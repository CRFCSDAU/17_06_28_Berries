
  library(tidyverse)
  source("scripts/functions.R")

# Data -------------------------------------------------------------------------

  data <- haven::read_spss("data/data.sav")

# Notes from reading the protocol

# SBP is the primary. We will also look at other CVD factors.
# Power was based on SPB 135 sd 3. Is that SD of 3 right!? QUERY
# Based on this, they expected to detect a 2mmHg drop with 85% power and n = 82

# inclusion: Systolic blood pressure: 130 – 149 mmHg

# 2 week pre-trial run-in (advised to not eat berries)

# Block randomized....do I have block info? QUERY

  names(data) <- tolower(names(data))

# Save labels from Haven

  label.list <- list()

  for (i in seq_along(data)){
    label.list[[i]] <- attributes(data[[i]])$label
  }

# Remove labelled class

  data <- unlabel(data)

# Remove NaNs

  data[sapply(data, is.numeric)] <- apply(data[sapply(data, is.numeric)], 2,
                                          function(x) ifelse(is.nan(x), NA, x))

# Fix inconsistent naming

  stub_change <- function(stub, ...){
    x <- gsub(paste0("_", stub), "", names(data)[grepl(stub, names(data))]) %>%
      paste0(paste0(stub, "_"), .)
    return(x)
  }

  names(data)[grepl("tag", names(data))]   <- stub_change("tag")
  names(data)[grepl("hdl", names(data))]   <- stub_change("hdl")
  names(data)[grepl("tchol", names(data))] <- stub_change("tchol")

  names(data)[grepl("_ldl", names(data))] <-
    gsub("_ldl", "", names(data)[grepl("_ldl", names(data))]) %>%
    paste0("ldl_", .)

  names(data) <- gsub("p_1", "p1", names(data)) %>%
    gsub("p_2", "p2", .) %>%
    gsub("_bl_", "_b_", .)

  save(data, file = "trial_data_july_2019.RData")






