#Create figures
#Requires objects from R/create_cohort.R (sourced by R/main.R)

## ---- final-flowchart
#Draw the cohort flowchart
#Before exporting, check that no box shows a count from 1 to 10 (CMS cell-size rule),
#including excluded counts recoverable by subtraction
patients_fc%>%
  fc_draw()
