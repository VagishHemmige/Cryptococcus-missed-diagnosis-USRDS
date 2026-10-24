# Analysis plan: Potential missed opportunities for diagnosis of cryptococcosis among kidney transplant recipients using USRDS

- **Version:** 0.3 (draft for review)
- **Date:** 2026-10-24
- **Reporting frameworks:** STROBE and RECORD. Bracketed references point to the reporting items each section addresses. They do not mean the methods have been validated.
- **Scope:** This plan covers study design, definitions, and statistical methods. Implementation details (files, variables, functions, and code organization) are kept separately in AGENTS.md.
- **Status:** Items marked **[VERIFY]** depend on data documentation or literature. Items marked **[TO FINALIZE]** are design decisions not yet made. Both must be resolved before the results that depend on them are examined. Later changes go in the change log.

## 1. Title, data source, and overview [S1, R1]

This retrospective claims-based study will identify potential missed diagnostic opportunities before the first observed cryptococcosis diagnosis among kidney transplant recipients in the United States Renal Data System (USRDS). The study links USRDS data on:

- demographics
- transplants
- payer history
- residence
- facilities
- Medicare fee-for-service institutional and physician/supplier (PS) claims

The primary analysis describes encounters in the 90 days before the first observed diagnosis. Secondary analyses examine all-cause mortality and geographic associations.

**Claim types.** Institutional claims include inpatient, outpatient (including emergency department and hospital outpatient services), skilled nursing facility, home health, and hospice claims. Throughout this plan:

- **inpatient claims** means inpatient institutional claims only
- **outpatient institutional claims** means hospital outpatient and emergency department claims
- **PS claims** means physician/supplier claims

Skilled nursing facility, home health, and hospice claims are not used to identify cases or opportunities. **[TO FINALIZE]** Confirm that exclusion.

## 2. Background and rationale [S2]

Cryptococcosis is a potentially severe infection in kidney transplant recipients. Encounters before diagnosis for neurologic, respiratory, or nonspecific infectious problems, or for related diagnostic procedures, may be identifiable in administrative claims. Published studies of missed opportunities in cryptococcosis are the starting point for the diagnostic phenotype and the 90-day window before diagnosis. This study applies that approach to USRDS institutional and PS claims, and it separates symptom and condition categories newly recorded before diagnosis from those documented earlier.

An encounter that meets the algorithm is a **claims-based potential missed opportunity**, not an adjudicated diagnostic error. Claims cannot establish when symptoms began, cannot show that cryptococcosis was clinically recognizable at that encounter, and cannot measure the true duration of diagnostic delay.

**[TO FINALIZE]** Full clinical background citations and bibliographic details of the source studies, including how those studies estimated a baseline or expected rate. **[VERIFY]**

## 3. Objectives and estimands [S3, S7]

**Primary objective:** Estimate the proportion of eligible recipients with at least one potential missed diagnostic opportunity in days −90 through −1 before the first observed cryptococcosis diagnosis. Report diagnosis-based, procedure-based, and combined opportunities separately. Also describe:

- the number of distinct qualifying encounters
- the clinical categories involved
- the time from the earliest qualifying encounter to index

**Secondary objectives:**

1. Estimate the association between having at least one potential missed opportunity and 90-day all-cause mortality.
2. Estimate the associations of rural versus urban residence, and of continuous distance to the transplant center, with having at least one potential missed opportunity.

**Additional mortality endpoints:** 30-day and 365-day all-cause mortality.

**Exploratory:** Graft outcomes, if they can be defined defensibly and follow-up is long enough.

The mortality analysis estimates an association. It is not a causal estimate of the effect of diagnostic delay.

## 4. Design and setting [S4, S5]

**Design.** This is a retrospective cohort of kidney transplant recipients with a first observed, confirmed cryptococcosis episode after transplant. Claims before index are used to find potential missed opportunities, and USRDS mortality data after index are used for outcomes. No matched group without cryptococcosis is required for the primary analysis. All eligible cases form its denominator. Section 9 describes the descriptive reference for interpreting the primary proportion.

**Case accrual period.** The window for case accrual is set by when claims are available, not by fixed calendar years:

- **Earliest index date:** the first date of available claims plus 365 days. This ensures that the prior-history window (days −365 to −91) and the "first observed" diagnosis are both fully observable.
- **Latest index date:** the last date with complete claims.

**[VERIFY]** The USRDS release, and the first and last dates of complete institutional and PS claims in that release.

**ICD coding eras.** ICD-9-CM applies to services before October 1, 2015. ICD-10-CM and ICD-10-PCS apply to services on or after that date.

## 5. Case definition and index date [S6, S7, R6.1, R6.2]

**Case-finding codes.** These are ICD-9-CM and ICD-10-CM diagnosis codes for cryptococcosis, in any diagnosis position on the claims used. Section 7 lists the code-list principles.

**Case confirmation.** A recipient is a confirmed case if they have either:

- one inpatient stay with a cryptococcosis diagnosis, or
- two distinct outpatient encounters with a cryptococcosis diagnosis, no more than 30 calendar days apart. An outpatient encounter here means a PS encounter or an outpatient institutional encounter.

Several claim lines or claims from the same encounter count as one encounter. Outpatient institutional encounters count toward the two-encounter rule in the same way as PS encounters.

**Confirmation date.** The date the confirmation criterion is first met.

**Index date (day 0).** **[TO FINALIZE]** Choose between:

- **(a) Bounded (recommended):** the earliest cryptococcosis claim no more than N days before the confirmation date. N is [TO FINALIZE; options include 30 days, matching the confirmation window, or 90 days].
- **(b) Unbounded:** the earliest cryptococcosis claim at any time before confirmation.

Whichever rule is not chosen becomes a sensitivity analysis. Under (a), a cryptococcosis code more than N days before the confirmation date is handled as follows: **[TO FINALIZE]** treat it as evidence of prior disease and exclude the person; or ignore it; or describe it separately as a possible earlier missed opportunity. This is a clinical judgment.

**Validation.** **[VERIFY]** Whether any published study has validated a claims-based case definition of cryptococcosis. If none has, report this as a limitation and rely on the sensitivity analyses in section 12.

## 6. Participants, selection, and covariates [S6, S8, S13, R6.3, R12.3, R13]

### 6.1 Selection

Selection is reported as a participant flowchart, with the number remaining at each step:

1. All USRDS patients with at least one kidney transplant.
2. Confirmed cryptococcosis (section 5), with an index date inside the case accrual period (section 4).
3. **Timing relative to transplant:** Exclude recipients whose first observed cryptococcosis diagnosis came before their first kidney transplant. **[TO FINALIZE]** Whether an isolated, unconfirmed code before transplant is enough to exclude, or whether pretransplant disease must meet the confirmation criterion. Only the first eligible episode per recipient enters the cohort.
4. **Medicare coverage:** Continuous Medicare fee-for-service primary coverage from day −365 through day 0. Adjacent or overlapping coverage periods are merged. No uncovered days are allowed.
5. **Chronology:** Exclude recipients with a missing first transplant date, or a recorded death before the index date. **[TO FINALIZE]** Any further chronology rules, such as transplant and index on the same day.

Recipients remain eligible whatever their graft function at diagnosis, including those who have returned to dialysis. Graft status is described, and restricting to functioning grafts is a sensitivity analysis. Missing residence or transplant-center location does **not** exclude a recipient from the main cohort or the mortality analysis.

**Definition of Medicare primary coverage.** Medicare fee-for-service primary payer, either "for both Part A and Part B" or "for other." The USRDS Researcher's Guide uses this definition for Medicare primary status, and it states that Medicare claims are complete only for Medicare primary enrollees. Medicare Advantage, Medicare-secondary, and non-Medicare periods are not eligible. Because the "for other" category does not guarantee both Part A and Part B, a sensitivity analysis restricts coverage to Part A and Part B together.

**Transplant reference.** Transplant characteristics and time since transplant come from the most recent kidney transplant before index.

The first *observed* diagnosis is not necessarily incident disease. Cryptococcosis outside the observable period or payer system cannot be detected.

### 6.2 Linkage

Data sources are linked deterministically by the USRDS patient identifier. Linkage rules:

- **Residence:** the residence period that contains the index date.
- **Transplant center:** the center of the most recent transplant before index, with facility information for the matching year.

Each person-date or person-transplant link should produce exactly one match. Overlapping or duplicate records are investigated rather than silently dropped. Report how complete each linkage is and how many links did not produce exactly one match.

### 6.3 Covariates

The principal mortality model uses these covariates:

- age at index
- sex
- time since most recent transplant
- calendar year
- four comorbidities: **diabetes mellitus, HIV infection, chronic liver disease, and malignancy**

**Comorbidity ascertainment.** Each comorbidity is assessed during **days −365 through −91**. It is classified as *documented* if, in that period, either:

- one inpatient stay has a relevant diagnosis in any position, or
- two distinct outpatient encounters (PS or outpatient institutional) do.

The two encounters can fall anywhere in the period, and they need not carry identical codes if both codes belong to the same comorbidity definition. Otherwise, under continuous coverage, the comorbidity is classified as *not documented*. This does not show clinical absence. *Missing* is reserved for status that is truly unknown or cannot be interpreted.

**Baseline utilization.** The number of distinct inpatient stays and outpatient encounters during days −365 through −91 is described by opportunity status. Utilization is **not** a covariate in the mortality models.

## 7. Diagnosis and procedure phenotype [S8, R7.1, R22.1]

The phenotype uses:

- ICD-9-CM and ICD-10-CM diagnosis codes
- ICD-9-CM Volume 3 and ICD-10-PCS procedure codes on inpatient claims
- CPT/HCPCS procedure codes on PS and outpatient institutional claims, where clinically relevant

Code-list principles:

- **The outcome is never a predictor.** Cryptococcosis codes cannot count as symptoms, conditions, or procedures for a missed opportunity.
- **No personal-history codes.** History codes (for example, history of CNS infection or stroke) show past events, not current symptoms. They are excluded from the opportunity categories. **[TO FINALIZE]** Confirm.
- **One category per code.** Each code belongs to exactly one clinical category.
- **Comparable eras.** Each category has ICD-9 and ICD-10 definitions that capture the same clinical concept. Mappings between ICD-9 and ICD-10 need clinical judgment, not only automated crosswalks. A category with no comparable definition in one era is reported by era or dropped.
- **Stated matching rules.** For each code, the plan states whether it is a category or a billable code and whether it is matched exactly or as a prefix.
- **Official code sets.** Every code is checked against the official code sets for the years in which it is applied.
- **Hospital stays across the ICD transition.** For a stay that spans October 1, 2015, the code system is set by the effective date of the claim, not by the admission date alone.

The final code lists for the case definition, comorbidities, and opportunity categories are published as supplementary material, with the matching rules. The lists are finalized without reviewing any results that depend on them.

## 8. Prediagnosis periods [S6, S7]

All times are relative to index day 0.

| Period | Days (inclusive) | Role |
|---|---|---|
| Fixed prior history | −365 to −91 | Find which clinical diagnosis categories were already documented; assess baseline comorbidities and utilization |
| Primary opportunity window | −90 to −1 | Identify potential missed opportunities |
| Nested sensitivity window | −60 to −1 | Repeat the opportunity analyses in the same cohort |
| Nested sensitivity window | −30 to −1 | Repeat the opportunity analyses in the same cohort |
| Index | 0 | First observed cryptococcosis diagnosis (section 5) |

**Rules shared by all windows:**

- All windows use the same eligible cohort and the **same fixed prior-history period**.
- Prior symptoms are assessed at the *clinical-category* level. A different code in a category already documented does not count as newly recorded.
- "Newly recorded" is a claims observation, not proof of new clinical onset.
- Qualifying procedures need **not** be new. They can occur more than once and can count even when a similar procedure was recorded earlier.

**Encounter dates.** An encounter is dated by the date of service. An inpatient stay spans from admission to discharge. A stay that begins before day 0 and continues into it is part of the index episode (section 9), not an opportunity.

## 9. Potential missed-opportunity algorithm [S8, S12a]

**Unit of counting:** Distinct clinical encounters, not claim lines or diagnosis codes. The encounter types are:

- inpatient stays
- outpatient institutional visits
- PS encounters

PS services delivered during an inpatient stay belong to that stay. They are not counted as separate encounters.

**Diagnosis-based pathway:** An eligible encounter in the opportunity window has at least one qualifying diagnosis in a clinical category that was **not documented in the fixed −365 to −91 history**.

**Procedure-based pathway:** An eligible encounter has at least one qualifying diagnostic procedure. A procedure in the same category earlier does not disqualify the encounter.

**Combined pathway:** An encounter that meets either definition qualifies. An encounter with several categories or procedures counts **once** in the combined count but contributes to every category and pathway summary that applies. Later separate encounters can also qualify, including repeat procedures or the same category.

**Index diagnostic episode:** The whole index episode is excluded from the opportunity window. This includes:

- the index hospitalization
- PS services associated with it
- for a documented direct transfer into the index hospitalization, the transferring and receiving stays together, treated as one continuous episode

Earlier encounters that were separate and complete remain eligible. When the index date comes from an outpatient claim, a hospitalization that begins within **[TO FINALIZE]** days afterward is treated as part of the index episode. A later hospitalization is not automatically treated as the index episode.

**[TO FINALIZE BEFORE IMPLEMENTATION]** Rules for grouping claims into encounters when the claims cannot be linked exactly, and how direct transfers are identified and validated.

**Primary reporting:**

- the proportions of cases with any diagnosis-based, any procedure-based, and any (either type) opportunity
- the number of distinct opportunities per patient
- the distribution across categories
- days from the earliest qualifying opportunity to index

This elapsed time is **not** a clinically measured diagnostic delay. Summarize the nested 30-day and 60-day estimates using the same phenotype and counting rules.

**Descriptive reference for interpretation:** Plot the weekly rate of encounters with any opportunity-category code across days −365 to −1, whether or not the category is newly recorded. Show it overall and by diagnosis group (neurologic, respiratory, infectious). This shows whether and when encounter rates rise above the background level in this population, and gives context for the primary proportion. The plot is descriptive. No change-point threshold is used to redefine the primary estimand. **[TO FINALIZE]** Whether a formal expected-rate comparison is added, following the source studies.

## 10. Study size [S10]

There is no formal sample size calculation. Cohort size is fixed by the available data. Feasibility depends mainly on the number of 90-day deaths for the adjusted mortality model (section 11). Counts are reported subject to the disclosure rules in section 15.

## 11. Mortality outcomes and statistical plan [S7, S12]

**Outcomes.** The principal secondary outcome is **90-day all-cause mortality** after index. Additional outcomes are **30-day and 365-day all-cause mortality**.

**Follow-up.** Follow-up runs from index until the earliest of:

- death
- the administrative end of death ascertainment
- the horizon being analyzed

Survival through the outcome window is **not** required for eligibility. Losing Medicare fee-for-service coverage after index does not end follow-up, because USRDS death ascertainment does not depend on Medicare claims. **[VERIFY]** The end date of death ascertainment in the release used, and that it covers the 365-day horizon for the latest index dates.

**Unadjusted estimates.** Kaplan–Meier estimates of absolute mortality risk, with 95% confidence intervals, at each horizon, stratified by any potential missed opportunity.

**Principal adjusted model.**

- A Cox proportional hazards model, with follow-up censored at 90 days.
- Exposure: any qualifying opportunity during days −90 to −1.
- Covariates: those listed in section 6.3.
- Report adjusted hazard ratios with 95% confidence intervals.
- Check proportional hazards (including Schoenfeld residuals), the functional form of continuous covariates, influential observations, and sparse cells.

**Prespecified fallback model.** If the number of 90-day deaths is below **[TO FINALIZE: e.g., 10]** per model parameter, the principal model is replaced with a reduced model. The reduced model includes the exposure, age at index, and time since transplant. **[TO FINALIZE]** Confirm the reduced covariate set. Covariates are not chosen by p value.

**Sparse covariates.** If a comorbidity is too rare to estimate or report (for example, HIV), it is **[TO FINALIZE: dropped from the model / combined with another immunocompromising condition]**. The decision is made before any model results are viewed. In descriptive tables, its count is suppressed under section 15.

**Interpretation.** Exposure is classified from the window before index and fixed at index, so the risk period begins only after exposure is ascertained. Even so, the associations may be biased by:

- selection on confirmed cryptococcosis
- survival to index
- how often patients have encounters
- earlier care pathways

The models do not adjust for clinical findings first documented in the opportunity window or the index hospitalization as if they were baseline confounders. Adjusted associations do not show that diagnostic delay caused preventable deaths.

**[TO FINALIZE]** Confidence interval methods for the primary proportions and encounter counts.

## 12. Geographic secondary objectives [S7, S12]

Both geographic exposures use the residential ZIP code **at index**. Patients without geographic data remain in the analyses that do not use it.

**Rurality.** Use ZIP-code-based Rural–Urban Commuting Area (RUCA) codes. The primary grouping is urban for primary RUCA codes **1–3** and rural for **4–10**. Assign the RUCA version that applies to the index year, and document:

- the release dates of each version used
- how versions map onto the study years
- how ZIP codes were linked
- how many ZIP codes did not match

**[VERIFY]** The historical RUCA versions and the matching ZIP crosswalks.

**Distance.** Straight-line distance, in miles, from the centroid of the residence ZIP code to the transplant center of the most recent kidney transplant before index. This is not driving distance or travel time. Model distance as continuous, report adjusted prevalence ratios per **50-mile increase**, and check whether the relationship is nonlinear. **[VERIFY]** The historical ZIP centroid data and the source of transplant-center location.

**Models.** For each geographic exposure separately, fit a modified Poisson model with robust standard errors. The outcome is any opportunity in the 90-day window. The models adjust for age, sex, time since most recent transplant, calendar year, diabetes, HIV, chronic liver disease, and malignancy, with the same sparse-covariate rule as section 11 and subject to model diagnostics. Report adjusted prevalence ratios with 95% confidence intervals. Use complete cases for the variables each model needs, and report the denominators and exclusions.

Baseline utilization is not adjusted for in these models, because it may lie on the pathway between geography and documented opportunities. Distance to the transplant center is only an imperfect proxy for where care was received before diagnosis.

## 13. Missing data, bias, and sensitivity analyses [S9, S12c–e, R19.1]

**Missing data.**

- All otherwise eligible patients stay in the descriptive and primary frequency analyses.
- Adjusted models use complete cases. Report how often each covariate is missing, the sample size of each model, and observed differences between included and excluded records.
- No imputation is prespecified.
- Under continuous eligible coverage, the absence of a code is defined as *not documented*. It is not a missing value, and it does not confirm the absence of disease.

**Prespecified sensitivity analyses:**

- the nested 60-day and 30-day windows compared with the primary 90-day window
- the index-date rule not chosen as primary (section 5)
- a single cryptococcosis claim instead of the confirmed case definition
- a case definition using inpatient claims only
- cryptococcosis as the principal or first-listed diagnosis, instead of any position
- restriction to recipients with a functioning graft at index
- Medicare coverage restricted to Part A and Part B together
- the ICD-9 and ICD-10 eras analyzed separately

Nonspecific symptom categories, and possible long direct-transfer episodes, are examined separately if the code lists and data support those comparisons. Any sensitivity analysis added later is recorded before its results are viewed, or labeled post hoc.

**Selection related to Medicare after transplant.** Medicare entitlement based only on ESRD ends three years after a successful kidney transplant. Recipients who still have Medicare fee-for-service primary coverage later after transplant are therefore mostly older (65 or over) or entitled through disability. The coverage requirement may thus select an older or more disabled cohort among cases diagnosed more than three years after transplant. Report time since transplant and age for confirmed cases excluded for coverage and for those included, subject to disclosure rules.

**Other main threats:**

- left truncation of earlier diagnoses
- incomplete claims capture under fee-for-service
- selection by payer and by case confirmation
- misclassification from the code lists
- differences between the ICD-9 and ICD-10 eras
- detection and surveillance bias
- dates that cannot be distinguished within a hospital stay
- measurement error in the geographic exposures
- confounding by severity
- sparse death counts
- missing information

None of the algorithms confirms a diagnostic error.

## 14. Data access and reproducibility [R12.1, R12.2, R22.1]

- **Access.** The investigators use USRDS data under a data use agreement and have access to the USRDS files listed in section 1 for the release used.
- **Data cleaning to report:**
  - how coverage periods are merged
  - how claims are grouped into encounters
  - how duplicate and overlapping records are handled
  - how code systems are handled across the ICD transition
- **Reproducibility.** Report the software and package versions used. Analysis code and code lists can be shared publicly. Patient-level USRDS data cannot.

## 15. Disclosure

Follow the USRDS and CMS data use restrictions:

- Do not publish counts from 1 to 10.
- Do not allow such counts to be derived by subtraction or from complementary cells, in tables, flowcharts, figures, or text.

Check the exact disclosure wording in the governing data use agreement before dissemination.

## 16. Open items and change log

**Required before running the analyses that depend on them:**

- **[VERIFY]**
  - the data release and the claims date range
  - the claim types and diagnosis positions available
  - how index admissions and transfers are identified
  - historical RUCA data and the ZIP and transplant-center linkage
  - the end date of mortality follow-up
  - clinical validation of the code lists
- **[TO FINALIZE]**
  - the index-date rule and N (section 5)
  - handling of isolated codes before transplant (section 6.1)
  - history codes in the opportunity categories (section 7)
  - the window linking an outpatient index to a later hospitalization (section 9)
  - the fallback model threshold and covariates (section 11)
  - handling of sparse comorbidities (section 11)
  - confidence interval methods (section 11)
  - whether a formal expected-rate comparison is added (section 9)

| Date | Version | Decision/change | Rationale | Timing relative to dependent results |
|---|---|---|---|---|
| 2026-10-24 | 0.2 | Reconciled the plan with decisions from project discussion: case confirmation; earliest observed index; chronology of transplant and prior disease; fixed history and opportunity periods; encounter grouping; procedure pathway; mortality and geographic analyses; missing data | Moved from a generic STROBE/RECORD outline to a study-specific prespecification | Before any opportunity or mortality results |
| 2026-10-24 | 0.3 | Separated institutional claims into inpatient, outpatient, and other types; counted outpatient institutional encounters toward the two-encounter confirmation rule; changed the index-date choice to a bounded or unbounded rule still to be finalized; set case accrual by claims availability; defined Medicare primary following the USRDS Researcher's Guide; added a weekly-rate descriptive reference; prespecified the fallback mortality model and the handling of sparse covariates; added post-transplant Medicare selection to the bias section; added a study size section; defined the chronology exclusions; moved implementation details to AGENTS.md | Review of version 0.2 | Before any opportunity or mortality results. **[TO CONFIRM]** Cohort flowchart counts from the earlier single-claim definition may already have been viewed; none of these changes depend on them. |
