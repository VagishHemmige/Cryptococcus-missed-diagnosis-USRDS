# AGENTS.md

Guidance for everyone working on this repository: the maintainer, collaborators, and any AI coding agents working for them. It covers how to work here: conventions, data handling, and checks.

Three files divide the documentation:

| File | Covers |
|---|---|
| `analysis-plan.md` | Study design and statistics: what the analysis does |
| `ARCHITECTURE.md` | Code structure: scripts, data flow, and the objects passed between them |
| `AGENTS.md` (this file) | How to work in the repository: rules, conventions, and checks |

Read all three before making changes. Each file covers its own topic and does not repeat the others.

## The project

This repository analyzes potential missed opportunities for diagnosing cryptococcosis among kidney transplant recipients. It uses United States Renal Data System (USRDS) data linked to Medicare claims.

- **`analysis-plan.md` is the source of truth for design.** It covers case definitions, windows, estimands, models, and sensitivity analyses. Code implements the plan; it does not redefine it.
  - If the code needs to depart from the plan, change the plan in the same pull request.
  - Plan changes are tracked in git, not in a change log inside the plan. Commit each design change on its own, with a message that gives the reason and says whether any results that depend on it had already been seen.
  - Do not settle an item the plan marks **[TO FINALIZE]** in code. Raise it with the maintainer.
- **This is an analysis project, not an R package**, even though the scripts live in `R/` and there is an `.Rbuildignore`. Do not add DESCRIPTION, NAMESPACE, roxygen, or pkgdown infrastructure. Do not apply CRAN conventions.

## R scripts

- **Running the analysis.** Open the `.Rproj` and run `R/main.R` from the project root. `main.R` sources the other scripts in dependency order. `ARCHITECTURE.md` describes what each script does and how data flows between them.
- **One job per script.** For example: setup, cohort construction, opportunity ascertainment, models, figures. When you add a script:
  - source it from `main.R` at the right point
  - update `ARCHITECTURE.md` in the same commit
- **Header comment.** Each script begins with a comment saying what it does and which objects it needs from earlier scripts.
- **Constants, libraries, and code lists** live in `R/setup.R`. Other scripts do not call `library()` or hard-code values. Any number that a reader might want to change, such as a window length, a year, or a threshold, is a named constant in `setup.R`.
- **No side effects outside the project.** Do not use `setwd()`, absolute paths, or writes outside the project. Locate data only through usRds's own directory setting.

## Chunk labels

Scripts are divided into labelled sections, so that Quarto documents can reuse the code without copying it:

```r
## ---- cryptococcus-claims
```

- Every logical step has a label. A label covers the code from its line to the next label.
- Labels are kebab-case, describe the step, and are **unique across all scripts**. Quarto pulls chunks by label, so a duplicate label silently picks up the wrong code.
- Renaming or deleting a label breaks any Quarto document that uses it. Search the `.qmd` files before you change one.
- Scripts must still run end to end through `main.R`. Labels are comments and must never change what the code does.

## Variable labels

- Label analysis variables with human-readable descriptions, for example with `labelled::set_variable_labels()`. Tables and output then show readable names without renaming code by hand.
- For USRDS variables, use usRds's `apply_usrds_varlabels()` and `apply_usrds_factors()` rather than writing labels by hand.
- Label each derived variable where it is created, in a form a reader would recognize. Include units, and windows where they apply (for example, "Any potential missed opportunity, days −90 to −1").

## Quarto

- **No analysis logic in Quarto documents.** They present results; they do not compute them.
  - Load script code with `knitr::read_chunk()` and call chunks by label.
  - Or work from objects that `main.R` creates.
- **Text from objects.** Write numbers in the text with inline R expressions drawn from objects. Never type a result by hand.
- **Disclosure applies to rendered output.** Rendered HTML, PDF, or Word files that contain results are outputs under the disclosure rules below. Do not commit rendered files that contain results. Add their output folders to `.gitignore`.
- **Figures** need alt text (`fig-alt`), and tables need captions. Quarto cross-references (`@fig-`, `@tbl-`) need matching labels.
- `README.Rmd` is still the usethis template. Replace it, or move to Quarto, before the repository is shared.

## Restricted data (applies to everyone)

USRDS and Medicare data are covered by a data use agreement (DUA). The rules below apply to people and agents alike.

- **Never commit data.** That includes USRDS files, extracts, and any saved R object or output derived from patient-level data (`.rds`, `.RData`, `.parquet`, `.csv`, and the like). Keep data outside the repository, and check `.gitignore` before adding a new output type.
- **AI agents must not read restricted data.** Anything an agent opens, prints, or summarizes is sent to the model provider. Agents therefore must not:
  - open data files or patient-level objects
  - print rows or `head()` of them
  - display USRDS IDs, person-level dates, or ZIP codes

  This applies unless your own DUA explicitly permits that use. Agents may write code, review it, and run it on **synthetic data** that mimics the column names and types. Results on real data are produced by an authorized person.
- **Use synthetic data for development and tests.** Build small synthetic data frames in code, label them clearly as synthetic, and never derive them from real records.
- **Disclosure.** No table, figure, flowchart box, or text may show a count from 1 to 10. That includes counts that can be recovered by subtraction or from complementary cells. Check every output before it leaves the secure environment, and check the exact wording of the governing DUA before dissemination.

## Look in usRds first

The [usRds](https://github.com/VagishHemmige/usRds) package is the **first place to look** for anything that touches USRDS files: loading files, extracting claims, claim types, diagnosis dates, Medicare coverage, cohort helpers, and costs.

- Check the package's function reference before writing project-specific code. Use an existing function, or extend it.
- **Package problems belong in the package.** If a usRds function is wrong, or does almost but not exactly what the plan needs, open an issue in the [usRds repository](https://github.com/VagishHemmige/usRds/issues) rather than documenting it here. Then do one of two things:
  - fix it in usRds, which is preferred when the behavior is generally useful
  - wrap it in this project, with a code comment that links the issue

  Remove the wrapper when the issue is fixed.
- Before relying on a function's behavior, read its documentation and its open issues.
- Record the usRds version (or commit) used for any result.

## USRDS data facts

Sources: USRDS 2025 Researcher's Guide, Appendix B (data file descriptions), and Appendix C (formats). Check these against the release you are using.

**Institutional ("IN") claims cover more than inpatient care.** They include inpatient, outpatient, skilled nursing facility (SNF), home health, and hospice claims.

- `HCFASAF` gives the claim type: `I` inpatient, `O` outpatient, `N` SNF, `H` home health, `S` hospice. In older files, `M` is a REBUS inpatient stay.
- From 2002 on, each type has its own files: `ip_*`, `op_*`, `sn_*`, `hh_*`, and `hs_*`, each with a CLM (claim), DXP (diagnosis/procedure), and DET (revenue center) file.
- Institutional claims are uniquely identified by `USRDS_ID`, `CLM_FROM`, and `SEQ_KEYC`.

**Physician/supplier (PS) claims** come as a CLM (claim), LINE (line item), and DX (diagnosis) file.

- Each line carries one diagnosis and one procedure code.
- One visit produces several lines, so lines must be grouped into encounters.
- Be explicit about whether you use line-level or claim-level diagnoses.

**Claims year.** Claims are assigned to a SAF year by the service **end** date, not the start date.

**Data currency (2025 release).**

- Claims are complete through 2023-12-31, except for the Q1 2024 inpatient file.
- The core files, including deaths, run through 2024-12-31.
- Vital status runs ahead of claims by about a year.

**Payer history (`payhist`)**

- Eligible Medicare fee-for-service primary coverage: `PAYER` is `MPAB` or `MPO`. This is the Researcher's Guide definition (Example 8), and claims are complete only for these periods.
- The plan's sensitivity analysis uses `MPAB` only.
- Not eligible: `HMO` (Medicare Advantage), `MSP-EGHP`, `MSP-nonEGHP`, `OTH`, `WAIT`.
- Medicare entitlement based only on ESRD ends three years after a successful transplant. Expect coverage loss after that point.

**ICD transition.** ICD-9-CM applies to services before 2015-10-01. ICD-10-CM and ICD-10-PCS apply on or after that date.

- Codes are stored without periods.
- Decide, and document, which date sets the code system for a hospital stay that crosses the transition.

**Unclear variables.** If a variable's meaning is unclear, check Appendix B and Appendix C. Do not guess from the name.

## Coding conventions

- **Flowchart labels and text** are built from the constants in `setup.R`, not hard-coded. For example, a label that says "2006-2021" or "365+ days" goes stale when the constants change.
- **Code lists**
  - Each code carries its category, its ICD version or code type (diagnosis or procedure), and its matching rule (exact or prefix).
  - Each code belongs to exactly one category.
  - Outcome codes (cryptococcosis) never appear in the opportunity categories.
  - Personal-history codes are not symptoms.
  - Check every code against the official CMS ICD-9-CM, ICD-10-CM, ICD-10-PCS, and HCPCS code sets.
  - Never invent codes, variables, files, or clinical definitions.
- **Cohort flow** uses the `flowchart` package (`as_fc()`, `fc_filter()`, `fc_draw()`). Every inclusion or exclusion goes through `fc_filter()`. Never drop rows from `$data` outside the flowchart; the diagram must reproduce the cohort exactly. The cohort used downstream is the data from the final flowchart step.
- **Joins**
  - Use `join_by()` with an explicit `relationship` where you can.
  - After every interval join (`between()`, `closest()`, `overlaps()`), assert that it did not multiply rows. `create_cohort.R` shows the pattern.
  - Decide deliberately what happens to people with no match (NA rows): keep them, exclude them through a flowchart step, or stop with an error.
- **Dates and windows**
  - Write windows as inclusive day offsets from the index date, matching the plan (for example, −90 to −1).
  - Test the window edges on synthetic data.
- **Style:** the tidyverse style guide. Style changes go in their own commits, separate from changes that alter analytical behavior.

## Checks for any change

Before opening a pull request, check the items below that apply to your change.

**Cohort construction**

- Do the order, the denominator, and the labels of each flowchart step match the condition it applies?
- Can each count be reproduced from the code?
- Is the downstream cohort the data from the final flowchart step?

**Claims and case definitions**

- Which claim files, claim types (`HCFASAF`), diagnosis positions, and date fields are used?
- Is matching exact or prefix?
- Are both ICD-9 and ICD-10 covered for the right dates?
- Could a code reflect a history, a rule-out, or the outcome itself?

**Windows and coverage**

- Is the index date defined as in the plan?
- Are the window edges inclusive as specified?
- Does Medicare coverage span the whole look-back window, not just its start?
- Are adjacent coverage spans merged without allowing uncovered days?

**Transplant timing**

- Is the right transplant episode used? The plan uses the first transplant only for the "before first transplant" exclusion, and the most recent transplant before index for everything else.
- How are graft failure and repeat transplants handled?

**Residence and facility**

- Is the ZIP code the one valid on the right date?
- Is the facility year aligned?
- Have identifiers changed over time?

**Structure and documentation**

- Does `ARCHITECTURE.md` still describe the scripts and the data flow?
- Are the chunk labels unique, and do the Quarto documents still find every label they use?
- Are new derived variables labelled?
- Is any number in the text produced by inline code rather than typed?

**Execution**

- Does `main.R` run from a clean session?
- Are paths relative?
- Are there no absolute paths or hard-coded data directories? Use usRds's own directory setting.
- Are package versions recorded?
- Are any saved intermediates stale?

**Validation on real data** (run by an authorized person; report only aggregate, suppressed results)

- row counts before and after each interval join
- the number of people with more than one matching coverage or residence span
- case counts by ICD-9 versus ICD-10 era
- case counts by claim type

## Current gaps between the code and the plan

This is a working list. Delete each item as it is resolved, or move these into GitHub issues.

- The case definition uses any single claim. The plan requires confirmation (plan §5).
- The case accrual period comes from the fixed `claim_years`. The plan bases it on claims availability: the first claims date plus 365 days, through the last complete claims date.
- The flowchart uses `TX1DATE` for timing. Transplant characteristics should come from the most recent transplant before index. `transplant_df` and `transplant_joined` are built but not yet joined to the cohort.
- Case confirmation and index date: `establish_dx_date()` does not match plan §5. See the usRds issues.
- Medicare coverage: `verify_medicare_primary()` has open problems that can make `medicare_primary_TF` silently `FALSE` (the cache and payer-label matching). See the usRds issues.
- The facility join uses `closest(x$YEAR <= y$YEAR)`. Check that it picks the facility year that matches the transplant.
- Corrections needed in the code maps in `setup.R`:
  - `B451` is in ICD-10 "Brain Infection" (the outcome used as a predictor)
  - `Z8619` appears in two categories
  - the history codes `V1242`, `V1254`, and `V1261`
  - ICD-9 `334830` is probably 348.30
  - ICD-9 `725` is polymyalgia rheumatica
  - `0W9B3ZX` is labeled bronchoscopy but is drainage of the left pleural cavity
  - the mediastinal entries are not comparable between ICD-9 (a procedure) and ICD-10 (`J98`)
  - three-character ICD-10 entries need expansion to full codes, because `get_*_ICD()` matches exactly
  - there are no CPT/HCPCS codes for PS and outpatient procedures
- Not yet implemented: comorbidities, encounter grouping, the opportunity algorithm, mortality analyses, RUCA and distance.

## Working with agents

- **Autonomy.** The person directing an agent decides how much it may do. That person may also give the agent stricter rules of their own, and those take precedence over this section. By default, an agent may:
  - edit code
  - add scripts and tests
  - run code on synthetic data
  - commit to a branch and open a pull request
- **Collaborators:** `main` is protected. Collaborators' changes reach it only through a pull request that the maintainer reviews.
- **Every agent, under any level of autonomy:**
  - follows the restricted-data rules above
  - asks before any step that would read real data, run the full pipeline, or make expensive calls
- Keep pull requests focused. In each one, state which section of the plan it implements and what was checked. Say whether it was checked on synthetic data or by reading only. Never describe synthetic results as results.
- For references, use the USRDS Researcher's Guide and its appendices, the CMS code sets, and PubMed. Cite what you used.
