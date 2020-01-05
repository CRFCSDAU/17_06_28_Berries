
# This runs all the scripts neccessary to create the data and models that are
# then reported in the paper_stats.rmd file.


  source("scripts/02_functions.R")

  source("scripts/03_data.R")

  source("scripts/04_primary_outcomes.R")

  source("scripts/05_secondary_outcomes.R")

# save.image(file = gsub(" ", "_", paste0("data_models_", date(), ".RData")))



