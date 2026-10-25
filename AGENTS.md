# AGENTS.md

Guidance for the maintainer, collaborators, and AI coding agents working in this repository: conventions, data handling, and checks.

| Document | Responsibility |
| --- | --- |
| `analysis-plan.md` | Scientific design, estimands, models, and sensitivity analyses |
| `REPOSITORY-BLUEPRINT.md` | Intended file and directory organization |
| `ARCHITECTURE.md` | Current code structure, data flow, and dependencies (maintained through Posit) |
| `AGENTS.md` | Implementation conventions, permissions, and review checks |
| GitHub Issues | Unresolved methodological choices, implementation tasks, and known defects |

Read the relevant documents before making changes. Follow `REPOSITORY-BLUEPRINT.md` for intended organization. Refer to [Cryptococcus-cost-analysis](https://github.com/VagishHemmige/Cryptococcus-cost-analysis) for examples of Quarto supporting files, chunk imports, callouts, and formatting—not for scientific methods. The analysis plan governs scientific decisions; `ARCHITECTURE.md` records the current implementation.

## The project

This is an **R analysis project, not an R package**. It examines potential missed opportunities to diagnose cryptococcosis among kidney transplant recipients using USRDS and Medicare claims. Do not introduce package infrastructure or impose CRAN conventions.

- The analysis plan is the scientific source of truth. If implementation requires a different design, obtain a methodological decision and update the plan before treating the change as definitive; track decisions in Git history rather than a change ledger within the plan.
- Do not make unresolved scientific decisions implicitly through code. Check relevant open GitHub issues and obtain an explicit methodological decision before implementing analyses that depend on them.
- Maintain implementation status and defects in GitHub Issues rather than in a standing list inside this file.

## R scripts

- Open the `.Rproj` and run `R/main.R` from the project root. `main.R` sources definitive scripts in dependency order.
- Keep scripts focused on one analytical responsibility. Study-specific scripts may be grouped in stage-specific subdirectories. Include a short header stating the script's role and its required upstream objects.
- When a definitive script is added or structurally reorganized, source it in `main.R` as appropriate and regenerate or update `ARCHITECTURE.md` through the Posit workflow **when the change materially affects structure or data flow**. `ARCHITECTURE.md` describes current implementation, not planned work.
- Define shared libraries, paths, configurable analytical constants, and their dependencies in `R/setup.R`. Avoid independent local definitions of study parameters in downstream scripts. Large, version-controlled code lists may live in separate files sourced by `setup.R`.
- Place reusable helpers in `R/functions.R`, or organized subdirectories when warranted. Prefer explicit function arguments over dependence on global objects.
- Avoid `setwd()`, machine-specific absolute paths, and writes outside designated project outputs. Locate restricted USRDS inputs through `usRds`'s directory configuration.

## Chunk labels

Scripts are divided into labelled sections so Quarto can reuse code without copying it:

```r
## ---- cryptococcus-claims
```

- Label logical steps with descriptive kebab-case identifiers **unique across scripts**. A label covers code up to the next label.
- Before renaming or removing a label, check the `.qmd` pages that reference it.
- Labels are comments; the underlying R scripts must remain executable through `main.R`.

## Variable labels

- Label analytical variables with human-readable descriptions (for example, `labelled::set_variable_labels()`).
- For USRDS fields, prefer `usRds::apply_usrds_varlabels()` and `usRds::apply_usrds_factors()` rather than duplicating source labels.
- Label derived variables where created, including units and time windows where relevant.

## Quarto documentation

Quarto pages **explain definitive analytical scripts** without executing analyses on restricted data. Exploratory scripts need no Quarto page.

- Refer to `REPOSITORY-BLUEPRINT.md` for intended file organization and to `Cryptococcus-cost-analysis` for working examples of `_quarto.yml`, code imports, and callout support.
- For script explanations, import existing chunk-labelled code using `knitr::read_chunk()` and display it with `#| eval: false`; explain the purpose and reasoning without duplicating source code.
- Rendering must not access restricted USRDS data. Review any proposed exceptions or publication of aggregate results separately for disclosure compliance.
- When definitive code or chunk labels change, update the affected explanations, navigation, and rendered pages as applicable. Do not assume a particular Quarto output directory is universal.

## Outputs

- `R/tables.R` and `R/figures.R` may create outputs directly or orchestrate specialized scripts. Store outputs in the designated tables and figures directories.
- Commit approved, nonrestricted results only when intentional; otherwise leave generated results local and ignored. Disclosure rules apply to all outputs.

## Restricted data (applies to everyone)

USRDS and Medicare data are governed by a data use agreement (DUA). Applicable DUA requirements take precedence over convenience or automation.

- Never commit restricted USRDS files, extracts, person-level data objects, or disclosive outputs. Keep restricted source data outside the repository and review output paths and `.gitignore` before adding new output types.
- AI agents must not read, print, summarize, or upload restricted patient-level data or identifiers, including USRDS IDs, person-level dates, or ZIP codes, unless such access is separately permitted under the applicable DUA and operating environment. A request to execute a pipeline does **not** itself provide such authorization.
- Use small, explicitly synthetic datasets for development and analytical validation; never derive synthetic records from actual patient records. Authorized people run restricted-data analyses in authorized environments.
- Prevent disclosure of counts 1–10 in tables, figures, flowcharts, or prose, including counts recoverable by subtraction or complementary cells. Follow the applicable DUA's exact dissemination rules and review outputs before release.

## Look in usRds first

The [usRds](https://github.com/VagishHemmige/usRds) package is the first place to look for USRDS file loading, claims extraction, claim types, diagnosis dates, Medicare coverage, cohort helpers, and costs.

- Check its documentation, known limitations, and open issues before reproducing functionality locally.
- Raise generally reusable defects or enhancements in `usRds`; prefer fixes there. Temporary project-specific wrappers must identify the upstream issue and be reconsidered when resolved.
- When this analysis depends on a pending `usRds` enhancement or correction, track the study-specific implementation task here and link it to the corresponding `usRds` issue.
- Record the `usRds` version or commit used for any result.

## USRDS data facts

Sources: the Researcher's Guide, Appendix B, and Appendix C for the **specific USRDS release being analyzed**. The summary below is a starting point, not a replacement for release-appropriate documentation. Obtain the applicable public documents from the [NIDDK Researcher's Guide page](https://www.niddk.nih.gov/about-niddk/strategic-plans-reports/usrds/for-researchers/researchers-guide). Consult `usRds` for machine-readable variable labels and formats.

**Institutional (IN) claims** include inpatient, outpatient, skilled nursing facility, home health, and hospice services.

- `HCFASAF` historically distinguishes `I` inpatient, `O` outpatient, `N` SNF, `H` home health, and `S` hospice; older data can include `M` for REBUS inpatient stays.
- Since 2002, corresponding file families include `ip_*`, `op_*`, `sn_*`, `hh_*`, and `hs_*`, generally with CLM, DXP, and DET records. Confirm structure for the release.
- Institutional claim identifiers include `USRDS_ID`, `CLM_FROM`, and `SEQ_KEYC`; verify the applicable key in source documentation.

**Physician/supplier (PS) claims** have CLM, LINE, and DX sources.

- Claim lines are not necessarily distinct encounters. Define and validate episode grouping before counting services; distinguish diagnoses, procedures, and claim-level versus line-level records.
- Physician/supplier services are not synonymous with outpatient care.

**Claims year:** claims can be assigned by service end date rather than start date; verify against release documentation and account for claims crossing year boundaries.

**2025-release data currency (illustrative only; re-verify for the release used):** claims complete through 2023-12-31 except the Q1 2024 inpatient file; core files including death dates extend through 2024-12-31. Do not infer contemporaneous coverage of claims and vital status.

**Payer history (`payhist`):** payer categories and Medicare FFS observability must be verified against the release-specific guide. The **primary versus sensitivity coverage definitions are prescribed in `analysis-plan.md`**, not here. Pay attention to Medicare Advantage, Medicare secondary payer categories, uncovered days, and Medicare entitlement transitions after transplantation.

**ICD transition:** ICD-9-CM applies before 2015-10-01; ICD-10-CM and ICD-10-PCS on or after that date. Codes may omit decimals. Establish the date controlling the code system for claims spanning the transition, and verify against official code-set definitions.

**Unclear variables:** consult the relevant Appendix B/C and source code documentation rather than inferring meaning from variable names.

## Coding conventions

- Build descriptive flowchart text from centrally defined parameters so labels cannot become stale when an analysis window changes.
- **Code lists:** maintain code type, coding system, category, and exact/prefix matching; verify against official coding sources. Distinguish outcome from opportunity codes and personal-history from symptom codes. Do not invent clinical definitions or variables. Check category overlaps and clinically justified exceptions rather than assuming all codes are mutually exclusive.
- **Cohort flow:** every patient-level inclusion or exclusion goes through `fc_filter()` in the `flowchart` workflow. Do not drop rows from `$data` outside the flowchart; the diagram must reproduce the cohort exactly.
- **Joins:** specify join keys and expected relationships. Check row multiplication, particularly after interval joins, and define handling of missing or unmatched records explicitly.
- **Dates and windows:** implement the boundaries prespecified in the analysis plan; test boundary cases on synthetic data.
- **Style:** use readable tidyverse conventions. Related readability improvements may accompany functional changes; keep unrelated large-scale formatting separate.

## Checks for any change

Before presenting changes for review or seeking commit approval, perform the applicable checks below. Report which checks were completed, which were not, and any limitations.

**Cohort construction**

- Do the order, denominator, and labels of flowchart steps reflect the actual conditions?
- Are the cohort counts reproducible from the operations shown?
- Is downstream analysis based on the final flowchart dataset?

**Claims and case definitions**

- Which claim files, claim types, diagnosis fields, and date fields are used?
- Are exact/prefix matching and ICD-9/ICD-10 date transitions handled appropriately?
- Can history codes, rule-out diagnoses, or outcome codes contaminate opportunities?

**Windows and coverage**

- Does index ascertainment agree with the analysis plan?
- Are date-window boundaries correct and inclusive where specified?
- Does eligible Medicare coverage span the **entire** required observation period, with adjacent spans joined without allowing gaps?

**Transplant timing**

- Are first and repeat transplants distinguished where the analysis requires them?
- Are transplant dates and characteristics drawn from the correct episode according to the analysis plan?
- Are graft failure and repeat transplants treated as prespecified?

**Residence and facility**

- Is residence information valid for the relevant date?
- Is facility information aligned to the appropriate year and transplant center?
- Are historical identifiers and changes in identifiers accounted for?

**Structure and documentation**

- Does `ARCHITECTURE.md` describe current scripts and data flow when structural changes warrant regeneration?
- Are chunk labels unique, and do Quarto pages continue to find the labels they reference?
- Do definitive analytical scripts have explanatory Quarto documentation, matching chunk labels? Were affected pages, navigation, and rendered outputs updated when appropriate?
- Are restricted-data analysis chunks non-evaluating in Quarto, and are derived variables labeled?

**Execution**

- Does `main.R` run from a clean session, using suitable relative paths?
- Are machine-specific absolute paths or hard-coded restricted-data directories absent?
- Are package versions and saved intermediates documented and checked for staleness?

**Validation on real data** (by an authorized person only; share only permitted, disclosure-reviewed aggregate findings)

- Row counts before and after interval joins.
- Counts of people with multiple matching coverage or residence spans.
- Case counts by ICD-9 versus ICD-10 era and by claim type.

## Working with agents

- **Autonomy:** the person directing an agent may impose stricter rules. By default, an agent may edit local project files, add scripts/tests, and run **synthetic-data** tests. **Explicit approval is required before committing changes or opening a pull request.**
- **Restricted data:** approval for full pipeline execution or expensive operations does not override DUA restrictions. Agents must separately obtain authorization for any operation that could access restricted records, under the applicable DUA and operating environment.
- **Full pipeline / expensive operations:** obtain explicit approval before running the full analysis or initiating expensive external/API operations.
- Keep proposed changes focused. Summarize the part of the plan being implemented and identify checks actually completed, their limitations, and whether testing used synthetic data or code inspection only. Never represent synthetic findings as clinical results.
- **Scientific citations:** maintain verified references in root-level `references.bib`; cite methodological sources in `analysis-plan.md` and technical references with the corresponding implementation documentation. Verify bibliographic metadata, source support for claims, and compatibility with the data release being analyzed.
