# Analysis plan: Potential missed opportunities for diagnosis of cryptococcosis among kidney transplant recipients using USRDS

**Status:** Reconciled proposal, 25 October 2026; not yet adopted. Citations support relevant methodological precedents but do not validate this study’s claims algorithms.

## Scope and reporting framework

This document is the authoritative specification of the study's scientific objectives, population, definitions, estimands, and statistical methods. It describes what the analysis must accomplish, independently of how the code is organized or implemented. `ARCHITECTURE.md` documents the implementation structure and data flow, while `AGENTS.md` provides instructions and conventions for working with the repository. Neither document supersedes scientific decisions in this analysis plan.

Reporting will follow STROBE and RECORD [@vonelm2007strobe; @benchimol2015record].

## 1. Overview and aims

Building on the 90-day inpatient missed-opportunity approach of Salazar et al. [@salazar2020], this retrospective study uses USRDS data linked to Medicare fee-for-service (FFS) institutional and physician/supplier (PS) claims to identify **claims-based potential missed opportunities**, not confirmed diagnostic errors, before the first observed qualifying post-transplant cryptococcosis diagnosis.

**Primary estimand:** Proportion of eligible recipients with at least one qualifying encounter during days −90 through −1, reported for diagnosis-based, procedure-based, and combined opportunities, with Wilson 95% confidence intervals [@wilson1927].

**Secondary objectives:** Associations of any opportunity with 90-day all-cause mortality, and of (separately) ZIP-code RUCA rurality and continuous distance to the transplant center with any opportunity. Additional mortality horizons: 30 and 365 days. Graft outcomes are exploratory only if defensibly ascertained.

These are observational associations; they do not estimate the causal effect of delay.

## 2. Sources and observation

Use USRDS transplant, treatment, payer, patient, residence, facility and mortality records as applicable; use inpatient and outpatient institutional and PS claims for ascertainment. Institutional files can include inpatient, hospital outpatient, skilled nursing, home health and hospice services [@usrds2025guide]. Skilled nursing facility, home health, and hospice claims are excluded from case and opportunity ascertainment under the prespecified study scope.

Determine index-date eligibility from the date range in which claims are complete and the full preceding 365-day eligibility window can be observed. Mortality ascertainment has its own end date and must not be equated to claims availability. Use documentation applicable to the actual SAF release [@usrds2025guide].

ICD-9-CM and ICD-10-CM coding eras are combined in the primary analysis, with separate era-specific sensitivity estimates. For the October 1, 2015 transition, outpatient/professional coding follows service date and hospital inpatient coding follows discharge date [@cms2015transition].

## 3. Case ascertainment and index

Cryptococcosis is identified using clinically reviewed diagnosis codes in any qualifying diagnosis position. A confirmed case satisfies either:
- one inpatient stay with a cryptococcosis code; or
- two distinct noninpatient encounters (outpatient institutional or PS not belonging to the same inpatient stay), each with a cryptococcosis code, no more than 30 calendar days apart. The one-inpatient/two-noninpatient ascertainment structure follows established Medicare claims methods [@cmsccwalgorithms; @cmshboevaluation]; the 30-day interval is prespecified for this study.

The **confirmation date** is when the criterion is met. The **index date** is the earliest cryptococcosis diagnosis claim belonging to the qualifying episode, bounded to 30 days before confirmation. Do not mistake confirmation date for first observed diagnosis. Earlier isolated codes are characterized separately and subject to the *uniform prior-history exclusion* below; they do not automatically reset index to an arbitrarily earlier date.

Exclude an otherwise qualifying candidate index if an earlier cryptococcosis diagnosis is observed in the uniformly observable days −365 through −1 **outside the 30-day qualifying episode**. This exclusion also applies to pretransplant codes within that same uniformly observed period. Do not use extra years of uneven historical observation to exclude some patients but not others. The resulting case is a first **observed qualifying diagnosis after a uniform lookback**, not proven incident infection. The fixed 365-day period is a prespecified study choice: independent claims-methods literature demonstrates that washout length changes cohort classification [@washout2015], but does not validate 365 days for cryptococcosis.

Keep the single-claim and other alternate case definitions for sensitivity analyses. Final clinical code lists will be available with the study materials.

## 4. Eligibility and transplant chronology

Include USRDS patients with a kidney transplant preceding the cryptococcosis index date (strictly earlier than day 0). Allow early post-transplant cases, retransplant recipients, and recipients with failed grafts or return to dialysis.

Require uninterrupted **Medicare FFS primary Parts A and B (`MPAB`)** coverage for each day −365 through day 0. Exclude Medicare Advantage, secondary, other-payer and uncovered intervals. Broader primary FFS (`MPAB` or `MPO`) eligibility is a sensitivity analysis. USRDS recommends Medicare primary for claims analyses and distinguishes `MPAB` from `MPO`; this study deliberately selects stricter `MPAB` for the primary cohort [@usrds2025guide]. The uniform observation period establishes *recorded history*, not clinical absence.

Use the **most recent** kidney transplant preceding index to define time since transplant, transplant characteristics and center. For qualifying missed opportunities, encounters after **any first kidney transplant** can contribute, including before retransplantation. Do not count encounters before the first kidney transplant. For recent transplants, report the truncated post-transplant opportunity window; do not infer a full 90-day post-transplant observation window.

Graft status at index is based on reported transplant follow-up/graft-failure dates, not dialysis claims alone. Include graft failure in the primary cohort and restrict to functioning grafts in sensitivity analysis.

Residence ZIP and center linkage refer to the index date and relevant transplant episode. Missing geography does not exclude patients from primary proportions or mortality analyses.

## 5. Prior-history and opportunity windows

| Period (inclusive) | Purpose |
|---|---|
| −365 to −91 | Fixed prior history for diagnostic-category documentation, baseline comorbidity ascertainment and healthcare utilization |
| −90 to −1 | Primary opportunity window |
| −60 to −1; −30 to −1 | Nested sensitivity windows, with the same fixed baseline period |
| 0 | Index cryptococcosis diagnosis |

A diagnosis category is **newly recorded** if no diagnosis in that category was documented during days −365 to −91. Distinct codes within the same category are not new. This does **not** establish symptom onset. Relevant diagnostic procedures need not be new.

Exclude personal-history diagnosis codes from opportunity categories. Use clinically reviewed, era-appropriate exact/prefix coding rules; ICD conversion crosswalks alone do not establish equivalence. Source literature guides phenotype development [@salazar2020]; historical code-system and mapping guidance requires review of the corresponding code sets [@cmsicdarchive].

## 6. Encounter-based opportunity ascertainment

The counting unit is a **distinct clinical encounter** (inpatient stay, outpatient institutional visit, or PS encounter independent of a stay), not claim lines. PS services during a hospitalization belong to the corresponding stay; multiple claims cannot manufacture distinct confirmation encounters or opportunities.

A qualifying encounter after first transplant and during the selected window contributes when it carries (a) a relevant diagnosis category newly recorded relative to the fixed prior-history period, or (b) a qualifying diagnostic procedure. Encounters meeting both pathways count once in the combined count but can contribute to multiple categories.

Exclude the entire index-spanning inpatient stay, including associated PS services, from the primary opportunity count. For documented direct transfers, recognize the continuous hospitalization while preserving constituent stays; an earlier transferring hospitalization of **at least seven prediagnosis days** may qualify under the transfer rule [@salazar2020]. Describe prolonged prediagnosis index stays separately. Do not automatically merge a hospitalization after an outpatient index solely because it occurred within a fixed number of days.

Report patient-level proportions with explicit patient denominators, distinct qualifying encounters per patient (including zero), clinical categories, and time from the earliest qualifying encounter to index. Do not label elapsed time a measured diagnostic delay.

As descriptive context, plot weekly rates of encounters containing relevant diagnosis-category codes across days −365 to −1, *irrespective of newness*, overall and by neurologic, respiratory and infectious group. Do not fit a formal expected-rate comparison or infer a diagnostic threshold from the plot. This descriptive plot is a study-specific addition.

## 7. Covariates and baseline utilization

Prespecified mortality covariates: age at index, sex, time since most recent transplant, calendar year, diabetes, HIV, chronic liver disease, and malignancy.

Document a comorbidity during days −365 through −91 using one inpatient diagnosis or two distinct noninpatient encounters with relevant diagnoses, consistent with the general claims-ascertainment approach [@cmsccwalgorithms]. Otherwise classify it as **not documented**, not clinically absent. Report unknown status separately where ascertainment is impossible.

Describe distinct baseline inpatient stays and noninpatient encounters by missed-opportunity status, rurality and distance. Do not adjust mortality or primary geographic models for baseline utilization.

## 8. Mortality analyses

Follow from index to death, the administrative mortality ascertainment cutoff or the chosen horizon, whichever occurs first. Retain late-index cases and administratively censor them; do not require potential completion of each horizon. Report numbers at risk and follow-up completeness.

Report Kaplan–Meier absolute mortality estimates (30, 90 and 365 days) by opportunity status, with 95% confidence intervals. Use a conventional Cox model at 90 days as the preferred adjusted model when estimable. Prespecify penalized Cox regression for unstable sparse-event estimation [@heinze2001] and a simpler reduced model if needed. Do not select model terms based on statistical significance or the observed exposure effect. Weighting remains a separate exploratory approach, not an automatic solution to sparse events or disclosure risk.

**Unresolved protocol dependency:** objective feasibility thresholds and the precise hierarchy/covariate specification for sparse-comorbidity aggregation, penalization and reduced models must be settled in a tracked issue *before exposure–mortality associations are examined*. This draft does not claim that those criteria have been finalized.

Assess proportional hazards, influential observations and functional form. Interpret estimates as associations, subject to selection, surveillance and residual confounding.

## 9. Geographic secondary analyses

Residence is measured by ZIP code at index. Use period-appropriate ZIP-based RUCA primary codes 1–3 (urban/metropolitan) and 4–10 (rural/nonmetropolitan), using the USDA classification [@usdaruca], and straight-line miles from residential ZIP centroid to the **most recent** transplant center. Model distance continuously and report prevalence ratios per 50 miles, checking nonlinearity. Distance is not measured travel time.

Fit separate modified Poisson models with robust standard errors [@zou2004] for rurality and distance, respectively, adjusting for the prespecified clinical covariates. Use separate complete-case cohorts for each geographic model; report denominators, exclusions and missingness. Do not adjust for baseline utilization; describe utilization by geography.

## 10. Sensitivity, limitations, reproducibility and disclosure

Prespecified sensitivities include nested 30-/60-day opportunity windows; single cryptococcosis claim; inpatient-only case ascertainment; first/principal listed cryptococcosis diagnosis; functioning graft only; broader `MPAB` plus `MPO` coverage; ICD-9-CM and ICD-10-CM eras separately. Report the effect of each sensitivity definition on the denominator and observation period.

Primary study size is determined by eligible claims and deaths; do not assert formally powered contrasts. Report complete-case exclusions for models, without imputing unobserved diagnoses as negative clinical findings.

Public code and code lists may be shared, but restricted patient-level data may not. Reports must suppress counts 1–10 and values derivable from complementary tables, figures or text, subject to the governing DUA. Weighted/adjusted estimates do not automatically eliminate disclosure risks. Report software and relevant package versions.

## References

References are stored in root-level `references.bib`. Rendering is deferred.
