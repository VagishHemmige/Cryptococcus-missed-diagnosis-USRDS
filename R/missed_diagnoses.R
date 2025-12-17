library(tibble)
library(tidyverse)

icd9_map <- tribble(
  ~category, ~code_type,   ~icd_code,
  
  # Lumbar puncture
  "Lumbar Puncture", "procedure", "0331",
  
  # Increased intracranial pressure
  "Increased Intracranial Pressure", "diagnosis", "3313",
  "Increased Intracranial Pressure", "diagnosis", "3314",
  "Increased Intracranial Pressure", "diagnosis", "3315",
  "Increased Intracranial Pressure", "procedure", "8891",
  
  # Brain infection
  "Brain Infection", "diagnosis", "0479",
  "Brain Infection", "diagnosis", "3207",
  "Brain Infection", "diagnosis", "3209",
  "Brain Infection", "diagnosis", "3214",
  "Brain Infection", "diagnosis", "3222",
  "Brain Infection", "diagnosis", "3229",
  "Brain Infection", "diagnosis", "32382",
  "Brain Infection", "diagnosis", "326",
  "Brain Infection", "diagnosis", "V1242",
  "Brain Infection", "procedure", "8893",
  
  # Encephalopathy
  "Encephalopathy", "diagnosis", "07020",
  "Encephalopathy", "diagnosis", "07021",
  "Encephalopathy", "diagnosis", "07022",
  "Encephalopathy", "diagnosis", "07044",
  "Encephalopathy", "diagnosis", "07071",
  "Encephalopathy", "diagnosis", "2903",
  "Encephalopathy", "diagnosis", "2931",
  "Encephalopathy", "diagnosis", "2989",
  "Encephalopathy", "diagnosis", "3238",
  "Encephalopathy", "diagnosis", "32381",
  "Encephalopathy", "diagnosis", "334830",
  "Encephalopathy", "diagnosis", "34831",
  "Encephalopathy", "diagnosis", "34839",
  "Encephalopathy", "diagnosis", "34982",
  "Encephalopathy", "diagnosis", "5722",
  "Encephalopathy", "diagnosis", "78001",
  "Encephalopathy", "diagnosis", "78009",
  "Encephalopathy", "diagnosis", "7801",
  "Encephalopathy", "diagnosis", "78097",
  "Encephalopathy", "procedure", "0222",
  "Encephalopathy", "procedure", "0232",
  "Encephalopathy", "procedure", "0234",
  "Encephalopathy", "procedure", "0242",
  "Encephalopathy", "procedure", "0243",
  
  # Headache
  "Headache", "diagnosis", "30781",
  "Headache", "diagnosis", "3393",
  "Headache", "diagnosis", "34610",
  "Headache", "diagnosis", "34670",
  "Headache", "diagnosis", "34690",
  "Headache", "diagnosis", "34691",
  "Headache", "diagnosis", "7840",
  "Headache", "procedure", "0112",
  "Headache", "procedure", "0390",
  
  # Focal neurological deficit
  "Focal Neurological Deficit", "diagnosis", "3688",
  "Focal Neurological Deficit", "diagnosis", "38912",
  "Focal Neurological Deficit", "diagnosis", "3899",
  "Focal Neurological Deficit", "diagnosis", "43884",
  "Focal Neurological Deficit", "diagnosis", "7802",
  "Focal Neurological Deficit", "diagnosis", "78039",
  "Focal Neurological Deficit", "diagnosis", "7804",
  "Focal Neurological Deficit", "diagnosis", "7810",
  "Focal Neurological Deficit", "diagnosis", "7812",
  "Focal Neurological Deficit", "diagnosis", "7813",
  "Focal Neurological Deficit", "diagnosis", "7843",
  "Focal Neurological Deficit", "diagnosis", "7845",
  "Focal Neurological Deficit", "procedure", "0110",
  "Focal Neurological Deficit", "procedure", "0113",
  "Focal Neurological Deficit", "procedure", "0114",
  "Focal Neurological Deficit", "procedure", "0128",
  "Focal Neurological Deficit", "procedure", "0131",
  "Focal Neurological Deficit", "procedure", "0139",
  "Focal Neurological Deficit", "procedure", "0159",
  "Focal Neurological Deficit", "procedure", "022",
  "Focal Neurological Deficit", "procedure", "0309",
  "Focal Neurological Deficit", "procedure", "0392",
  
  # Stroke
  "Stroke", "diagnosis", "4358",
  "Stroke", "diagnosis", "4359",
  "Stroke", "diagnosis", "V1254",
  "Stroke", "procedure", "0151",
  
  # Other neurological
  "Other", "diagnosis", "3485",
  "Other", "diagnosis", "34889",
  "Other", "diagnosis", "3489",
  "Other", "diagnosis", "3481",
  
  # Pneumonia NOS
  "Pneumonia NOS", "diagnosis", "4838",
  "Pneumonia NOS", "diagnosis", "4847",
  "Pneumonia NOS", "diagnosis", "485",
  "Pneumonia NOS", "diagnosis", "486",
  "Pneumonia NOS", "diagnosis", "490",
  "Pneumonia NOS", "diagnosis", "49322",
  "Pneumonia NOS", "diagnosis", "4940",
  "Pneumonia NOS", "diagnosis", "496",
  "Pneumonia NOS", "diagnosis", "51636",
  "Pneumonia NOS", "diagnosis", "5168",
  "Pneumonia NOS", "diagnosis", "51681",
  "Pneumonia NOS", "diagnosis", "51682",
  "Pneumonia NOS", "diagnosis", "51689",
  "Pneumonia NOS", "diagnosis", "5169",
  "Pneumonia NOS", "diagnosis", "517",
  "Pneumonia NOS", "diagnosis", "518",
  "Pneumonia NOS", "diagnosis", "5180",
  "Pneumonia NOS", "diagnosis", "5181",
  "Pneumonia NOS", "diagnosis", "5182",
  "Pneumonia NOS", "diagnosis", "5183",
  "Pneumonia NOS", "diagnosis", "5184",
  "Pneumonia NOS", "diagnosis", "5185",
  "Pneumonia NOS", "diagnosis", "5186",
  "Pneumonia NOS", "diagnosis", "5187",
  "Pneumonia NOS", "diagnosis", "5188",
  
  "Pneumonia NOS", "diagnosis", "51881",
  "Pneumonia NOS", "diagnosis", "51882",
  "Pneumonia NOS", "diagnosis", "51883",
  "Pneumonia NOS", "diagnosis", "51884",
  
  "Pneumonia NOS", "diagnosis", "71481",
  "Pneumonia NOS", "diagnosis", "78605",
  "Pneumonia NOS", "diagnosis", "78609",
  "Pneumonia NOS", "diagnosis", "7862",
  "Pneumonia NOS", "diagnosis", "7931",
  "Pneumonia NOS", "diagnosis", "79311",
  "Pneumonia NOS", "diagnosis", "V1261",
  "Pneumonia NOS", "procedure", "3220",
  "Pneumonia NOS", "procedure", "3229",
  "Pneumonia NOS", "procedure", "3230",
  "Pneumonia NOS", "procedure", "3249",
  "Pneumonia NOS", "procedure", "3321",
  "Pneumonia NOS", "procedure", "3322",
  "Pneumonia NOS", "procedure", "3323",
  "Pneumonia NOS", "procedure", "3324",
  "Pneumonia NOS", "procedure", "3326",
  "Pneumonia NOS", "procedure", "3327",
  "Pneumonia NOS", "procedure", "3328",
  
  # Pleural disease
  "Pleural Disease", "diagnosis", "5119",
  "Pleural Disease", "procedure", "3404",
  "Pleural Disease", "procedure", "3406",
  "Pleural Disease", "procedure", "3491",
  "Pleural Disease", "procedure", "8873",
  
  # Mediastinal
  "Mediastinal Diagnosis", "procedure", "3422",
  
  # Other pulmonary
  "Other", "diagnosis", "51889",
  "Other", "diagnosis", "78652",
  
  # Signs and symptoms of infection
  "Signs and Symptoms of Infection", "diagnosis", "7806",
  "Signs and Symptoms of Infection", "diagnosis", "78060",
  "Signs and Symptoms of Infection", "diagnosis", "78061",
  "Signs and Symptoms of Infection", "diagnosis", "78079",
  "Signs and Symptoms of Infection", "diagnosis", "7850",
  "Signs and Symptoms of Infection", "diagnosis", "7856",
  
  # Infection NOS
  "Infection NOS", "diagnosis", "07999",
  "Infection NOS", "diagnosis", "1179",
  "Infection NOS", "diagnosis", "56723",
  "Infection NOS", "diagnosis", "78552",
  "Infection NOS", "diagnosis", "725",
  "Infection NOS", "diagnosis", "99590",
  "Infection NOS", "diagnosis", "99591",
  "Infection NOS", "diagnosis", "99592"
  
)


library(tibble)

icd10_map <- tribble(
  ~category, ~code_type,   ~icd_code,
  
  # ------------------------------------------------------------------
  # Lumbar puncture (ICD-10-PCS)
  # ------------------------------------------------------------------
  "Lumbar Puncture", "procedure", "009U3ZX",  # Drainage of lumbar spinal canal, diagnostic
  
  # ------------------------------------------------------------------
  # Increased intracranial pressure
  # ------------------------------------------------------------------
  "Increased Intracranial Pressure", "diagnosis", "G933",
  "Increased Intracranial Pressure", "diagnosis", "G934",
  "Increased Intracranial Pressure", "diagnosis", "G935",
  
  # ------------------------------------------------------------------
  # Brain infection / meningitis / encephalitis
  # ------------------------------------------------------------------
  "Brain Infection", "diagnosis", "G00",
  "Brain Infection", "diagnosis", "G01",
  "Brain Infection", "diagnosis", "G02",
  "Brain Infection", "diagnosis", "G03",
  "Brain Infection", "diagnosis", "G04",
  "Brain Infection", "diagnosis", "A870",     # Viral meningitis
  "Brain Infection", "diagnosis", "B451",     # Cryptococcal meningitis
  "Brain Infection", "diagnosis", "Z8619",    # Personal history of CNS infection
  
  # ------------------------------------------------------------------
  # Encephalopathy
  # ------------------------------------------------------------------
  "Encephalopathy", "diagnosis", "G931",
  "Encephalopathy", "diagnosis", "G932",
  "Encephalopathy", "diagnosis", "G9340",
  "Encephalopathy", "diagnosis", "G9341",
  "Encephalopathy", "diagnosis", "G9349",
  "Encephalopathy", "diagnosis", "G9389",
  "Encephalopathy", "diagnosis", "K7200",
  "Encephalopathy", "diagnosis", "R410",
  "Encephalopathy", "diagnosis", "R411",
  "Encephalopathy", "diagnosis", "R412",
  
  # ------------------------------------------------------------------
  # Headache
  # ------------------------------------------------------------------
  "Headache", "diagnosis", "R51",
  "Headache", "diagnosis", "G439",
  "Headache", "diagnosis", "G43809",
  "Headache", "diagnosis", "G43819",
  
  # ------------------------------------------------------------------
  # Focal neurological deficit
  # ------------------------------------------------------------------
  "Focal Neurological Deficit", "diagnosis", "R29810",
  "Focal Neurological Deficit", "diagnosis", "R29818",
  "Focal Neurological Deficit", "diagnosis", "R202",
  "Focal Neurological Deficit", "diagnosis", "R252",
  "Focal Neurological Deficit", "diagnosis", "R4701",
  
  # ------------------------------------------------------------------
  # Stroke / TIA
  # ------------------------------------------------------------------
  "Stroke", "diagnosis", "I63",
  "Stroke", "diagnosis", "I64",
  "Stroke", "diagnosis", "G459",
  
  # ------------------------------------------------------------------
  # Pneumonia NOS
  # ------------------------------------------------------------------
  "Pneumonia NOS", "diagnosis", "J12",
  "Pneumonia NOS", "diagnosis", "J13",
  "Pneumonia NOS", "diagnosis", "J14",
  "Pneumonia NOS", "diagnosis", "J15",
  "Pneumonia NOS", "diagnosis", "J16",
  "Pneumonia NOS", "diagnosis", "J17",
  "Pneumonia NOS", "diagnosis", "J18",
  
  # Pneumonia-related respiratory failure / complications
  "Pneumonia NOS", "diagnosis", "J960",
  "Pneumonia NOS", "diagnosis", "J961",
  "Pneumonia NOS", "diagnosis", "J969",
  "Pneumonia NOS", "diagnosis", "J80",     # ARDS
  "Pneumonia NOS", "diagnosis", "J81",
  "Pneumonia NOS", "diagnosis", "J982",
  
  # Pneumonia procedures (ICD-10-PCS)
  "Pneumonia NOS", "procedure", "0W993ZX",  # Thoracentesis, diagnostic
  "Pneumonia NOS", "procedure", "0W9B3ZX",  # Bronchoscopy, diagnostic
  
  # ------------------------------------------------------------------
  # Pleural disease
  # ------------------------------------------------------------------
  "Pleural Disease", "diagnosis", "J90",
  "Pleural Disease", "diagnosis", "J91",
  "Pleural Disease", "diagnosis", "J92",
  
  # ------------------------------------------------------------------
  # Mediastinal
  # ------------------------------------------------------------------
  "Mediastinal Diagnosis", "diagnosis", "J98",
  
  # ------------------------------------------------------------------
  # Signs and symptoms of infection
  # ------------------------------------------------------------------
  "Signs and Symptoms of Infection", "diagnosis", "R509",
  "Signs and Symptoms of Infection", "diagnosis", "R5081",
  "Signs and Symptoms of Infection", "diagnosis", "R6510",
  "Signs and Symptoms of Infection", "diagnosis", "R6520",
  
  # ------------------------------------------------------------------
  # Infection NOS / sepsis spectrum
  # ------------------------------------------------------------------
  "Infection NOS", "diagnosis", "A419",
  "Infection NOS", "diagnosis", "B999",
  "Infection NOS", "diagnosis", "R6521",
  "Infection NOS", "diagnosis", "Z8619"
)

icdcommbined_map<-bind_rows(icd9_map, icd10_map)
