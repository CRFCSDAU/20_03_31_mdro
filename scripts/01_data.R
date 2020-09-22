
  library(tidyverse)
  library(readxl)
  library(testthat)
  library(janitor)
  library(lubridate)

# Data -------------------------------------------------------------------------

  data <- read_excel("data/IHFD 2013-2018 Tristan Cassidy_raw.xlsx") %>%
    clean_names()
  
# Add unique ID ----
  
  data$id <- 1:nrow(data)
  data <- select(data, id, everything())
  
# Add in MDRO and Anticoag flags ----  

  # In the original excel database, there are multiple sheets reflecting
  # different patient groups based on whether they have an ICD10 code indicating
  # an MDRO, anything requiring anticoagulants, and location. These were done by
  # eyeballing the data. Here were search the raw data for the relevant codes
  # and create the variables to reflects these things in the main dataset.
  
  tar_diag <- names(select(data, diag2:diag30)) # Codes are in these columns
  # Convert to upper just in case of typos
  data[tar_diag] <- map(data[tar_diag], toupper) 
  
  # Find all the values in the diag columns that match Z06. Tag those rows as
  # MDRO +
  data$mdro <- NA 
  for(i in 1:nrow(data)){
    if(any(grepl("Z06", data[i, tar_diag]))){data$mdro[i] <- "Yes"}
    else{data$mdro[i] <- "No"}
  }
  data$mdro <- factor(data$mdro) 
 
  
  
  # Repeat for anticoagulants (ICD-10: Z92)
  data$anticoag <- NA # Ditto for anticoag
  for(i in 1:nrow(data)){
    if(any(grepl("Z92", data[i, tar_diag]))){data$anticoag[i] <- "Yes"}
    else{data$anticoag[i] <- "No"}
  }
  data$anticoag <- factor(data$anticoag) 
  

# Timing ----
  

  data$time_to_surg[data$time_to_surg == -1] <- NA                       # QUERY
  data$adm_to_surg <- difftime(
    data$adm_primary_surgery_date_time, data$adm_date, units = "hours"
    )
  
  data$time_to_ortho[data$time_to_ortho == -1] <- NA                     # QUERY  
  data$adm_to_orth <- difftime(
    data$adm_orth_ward_date_time, data$adm_date, units = "hours"
  )
  
  
  data$adm_ae_diff <-  difftime(
    data$adm_ae_date_time, data$adm_date, units = "days"
  ) 
  
# qplot(as.numeric(data$adm_ae_diff))
# summary(as.numeric(data$adm_ae_diff))
# table(data$adm_ae_diff[data$adm_ae_diff < -2]) 
# So you get a lot of these that are almost 1 year off exactly, or 10 years off
  
# select(data, adm_date, adm_ae_date_time, adm_ae_diff, dis_date) %>%
#   filter(data$adm_ae_diff < -360 | data$adm_ae_diff > 360)
  
# Find the dates that are off and fix them  
  tar <- data$adm_ae_diff > 360 & !is.na(data$adm_ae_diff)
  
  data$adm_ae_date_time[tar] <-  data$adm_ae_date_time[tar] - years(1)
  
  tar <- data$adm_ae_diff < -360 & !is.na(data$adm_ae_diff) & 
    data$adm_ae_diff > -370
  
  data$adm_ae_date_time[tar] <-  data$adm_ae_date_time[tar] + years(1)

  tar <- data$adm_ae_diff < -3600 & !is.na(data$adm_ae_diff) 
  
  data$adm_ae_date_time[tar] <-  data$adm_ae_date_time[tar] + years(10)
  
# Make a difference using the earliest start date
  data$adm_leave_ae_diff <- ifelse(
    data$adm_ae_date_time < data$adm_date, 
    difftime(data$adm_ae_dis_date_time, data$adm_ae_date_time, units = "days"),
    difftime(data$adm_ae_dis_date_time, data$adm_date, units = "days")
  ) 
  
# length(
#   data$adm_leave_ae_diff[
#     data$adm_leave_ae_diff < 0 & !is.na(data$adm_leave_ae_diff)
#   ]
# ) 
# 124 with negative values, just set to missing
  data$adm_leave_ae_diff[data$adm_leave_ae_diff < 0] <- NA
  
  
# select(data, adm_date, adm_ae_date_time, adm_leave_ae_diff,
#        adm_ae_dis_date_time, dis_date) %>%
#   filter(data$adm_leave_ae_diff > 10) %>%
#   View
  
  data <- remove_constant(data)
  
# Remove if missing almost everything
  
  tar <- map_lgl(data, function(x) table(!is.na(x))["TRUE"] > 10)
  data <- data[tar]
  
  hosplabs <- c(
    "Connolly Hospital",
    "Midland regional Hospital Tullamore",
    "University Hospital Limerick",
    "Letterkenny University Hospital",
    "Sligo University Hospital",
    "University Hospital Waterford",
    "Cork University Hospital",
    "University Hospital Kerry",
    "Galway University Hospital",
    "Mayo University Hospital",
    "St. James’s Hospital, Dublin",
    "Mater Hospital",
    "St. Vincents University Hospital",
    "OLOL Drogheda",
    "Beaumont",
    "Tallaght"
  )
  
  data$hosp <- factor(data$hosp, labels = hosplabs)
  data$hosp <- relevel(data$hosp, ref = "University Hospital Waterford")
  
  data$sex <- factor(data$sex, labels = c("Male", "Female"))
  
  labs <- c(
    "No/No", 
    "Yes/No", 
    "No/Yes", 
    "Yes/Yes"
  )
  
  data <- mutate(
    data,
    mdro_anticoag = interaction(mdro, anticoag), 
    mdro_anticoag = factor(mdro_anticoag, labels = labs)
  )
  
  data$has_med_card[data$has_med_card == 2] <- NA
  data$adm_asa_grade[data$adm_asa_grade == 9] <- NA
  
  data$has_med_card <- factor(data$has_med_card, labels = c("No", "Yes"))
  data$marr_status <- factor(data$marr_status)
  data$adm_asa_grade <- ordered(data$adm_asa_grade)
  
  data$year <- data$adm_primary_surgery_date_time
  
  tar <- map_lgl(data, function(x)table(is.na(x))["FALSE"]/sum(table(is.na(x))) > 0.5)
  data <- data[tar]
  
# Save data --------------------------------------------------------------------
  
  save(data, file = "data/data.RData")
  

