#Create a cohort of kidney transplant patients with cryptococcus
#Requires objects from R/setup.R (sourced by R/main.R)

## ---- load-usrds-files
#Import core demographics from "patients" file
patients_raw<-usRds::load_usrds_file("patients")%>%
  select(-ZIPCODE) #This is ZIP code at time of USRDS initiation, but we want at time of crypto dx


## ---- initialize-flowchart
#Initialize a flowchart cohort and remove patients who have never had a transplant
patients_fc<-patients_raw%>%
  as_fc(label="Initial USRDS cohort")%>%

  fc_filter(TOTTX>0,
            label="Prior transplant",
            label_exc="Excluded: No prior transplant",
            show_exc=TRUE)


## ---- cryptococcus-claims
#Create list of USRDS ids for patients who have undergone transplant
transplant_id_list<-patients_fc$data%>%
  pull(USRDS_ID)

#Obtain cryptococcus claims from the IN and PS files
cryptococcus_claims_df<-bind_rows(get_IN_ICD(icd_codes = cryptococcus_ICD_list,
                                             years = claim_years,
                                             usrds_ids = transplant_id_list),
                                  get_PS_ICD(icd_codes = cryptococcus_ICD_list,
                                             years = claim_years,
                                             usrds_ids = transplant_id_list)%>%
                                    rename(CODE=DIAG))

#Keep the first cryptococcus claim of any type for each patient
cryptococcus_df<-cryptococcus_claims_df%>%
  slice_min(CLM_FROM, n = 1, with_ties = FALSE, by = USRDS_ID)%>%
  select(USRDS_ID, first_cryptococcus_date=CLM_FROM)


## ---- develop-flowchart
#Join cryptococcus date to fc cohort (one row per patient on both sides)
patients_fc$data<-patients_fc$data%>%
  left_join(cryptococcus_df,
            by = "USRDS_ID",
            relationship = "one-to-one")

patients_fc<-patients_fc%>%

  #Filter by whether or not the patient had a claim in the study period
  fc_filter(!is.na(first_cryptococcus_date),
            label="At least one cryptococcus claim 2006-2021",
            label_exc="No cryptococcus claim 2006-2021",
            show_exc=TRUE)%>%

  #Filter by whether or not the first claim was subsequent to the first kidney transplant date
  fc_filter(first_cryptococcus_date>TX1DATE,
            label="Cryptococcus subsequent to first transplant",
            label_exc="Excluded: Cryptococcus prior to first transplant",
            show_exc=TRUE)


## ---- medicare-coverage
#Mark Medicare FFS primary coverage on the date of the first cryptococcus claim, and whether
#that coverage spell began at least lookback_days earlier (adds medicare_primary_TF)
patients_fc$data<-patients_fc$data%>%
  verify_medicare_primary(index_date = "first_cryptococcus_date",
                          lookback_days = lookback_days,
                          coverage_start_variable = "coverage_start_date",
                          coverage_end_variable = "coverage_end_date")

#Confirm the coverage join did not duplicate patients
if (anyDuplicated(patients_fc$data$USRDS_ID) > 0) {
  stop("Medicare coverage join produced more than one row for some patients.")
}

patients_fc<-patients_fc%>%

  #Filter by Medicare primary coverage on day of claim
  fc_filter(!is.na(coverage_start_date),
            label="Medicare is primary coverage on date of claim",
            label_exc="Other coverage on date of claim",
            show_exc=TRUE)%>%

  #Filter by coverage for lookback_days before the claim
  fc_filter(medicare_primary_TF,
            label="365+ days of coverage prior to first cryptococcus claim",
            label_exc="Fewer than 365 days of coverage",
            show_exc=TRUE)


## ---- residence-transplant-facility
#Load ZIP codes
ZIP_code_df<-load_usrds_file("residenc",
                             usrds_ids = patients_fc$data$USRDS_ID)%>%
  select(USRDS_ID, ZIPCODE, BEGRES, ENDRES)

#Join patient cohort to ZIP code at the date of the first cryptococcus claim
patients_fc$data<-left_join(patients_fc$data,
                            ZIP_code_df,
                            join_by(USRDS_ID, between(first_cryptococcus_date, BEGRES, ENDRES)))

#Confirm the residence join did not duplicate patients
if (anyDuplicated(patients_fc$data$USRDS_ID) > 0) {
  stop("Residence join produced more than one row for some patients.")
}

#Load transplant data, and add a date for the next transplant (missing set to 1-1-2100)
transplant_df<-load_usrds_file("tx", usrds_ids = patients_fc$data$USRDS_ID)%>%
  select(USRDS_ID, TDATE, FAILDATE, PROVUSRD, YEAR)%>%
  arrange(USRDS_ID, TDATE)%>%
  group_by(USRDS_ID)%>%
  mutate(TDATE_lead=lead(TDATE))%>%
  ungroup()%>%
  mutate(TDATE_lead=coalesce(TDATE_lead, as.Date("2100-01-01")))

#Load facility data
facility <- load_usrds_file("facility")%>%
  select(ZIPCODE, PROVUSRD, FS_YEAR)%>%
  rename(YEAR=FS_YEAR)%>%
  mutate(YEAR=as.double(YEAR))

#Interval merge
transplant_joined<-left_join(transplant_df, facility, join_by(PROVUSRD, closest(x$YEAR<=y$YEAR )))
