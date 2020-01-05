
# This script runs the key multilevel models for each of the nominated primary
# outcomes. It also has code for producing plots as needed.
# 05_secondary_outcomes.R does the same for the other outcomes.

  library(tidyverse)
  library(lme4)
  library(sjPlot)

# Primary outcomes were noted as:
# Paper:    Office and central BPs
# Protocol: Not specified, but notes impact on SBP as primary objective (protocol)
# Registry: "Blood Pressure [ Time Frame: 42 days ] A change between baseline
# blood pressure and endpoint blood pressure within the intervention group versus
# # the control group." (https://clinicaltrials.gov/ct2/show/NCT02355444)

# SBP --------------------------------------------------------------------------

# Reshape the data on 4 SBP values in order to plot the within period changes
# by tx group, get missing values. See 02_functions.R

  sbp <- outcomes(data, "sbp__")

# Missing values
# length(data$subj_id); table(is.na(data$subj_id)) # 83
# length(data$sequence); table(is.na(data$sequence)) # 83
#
# group_by(sbp, period, timing, tx) %>%
#   summarise(sbp_missings = sum(is.na(value))) %>%
#   filter(sbp_missings > 0) # 4 total values

# Distribution plot ####

# dist(sbp, "SBP (mmHg)") # See 02_functions.R
#
# ggsave("plots/primary/sbp_dist2.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(sbp, "SBP (mmHg)") # See 02_functions.R
#
# ggsave("plots/primary/sbp.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

# Because we want to option for period specific baseline adjustment for the
# given outcome, we first bl and ep specific values and delete the missings then
# rejoin them; then mean center the bl value. Using the resulting dataframe, we
# estimate 4 models: sex adjusted; +period effect; + tx by period interaction;
# + and then a "final" model with sex, period, and baseline (no interactions).
# A table for these models can be nicely done with sjPlot::tab_models as needed.

  me_sbp_df <- full_join(
    select(sbp, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(sbp, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")
  ) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_sbp     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                     data = me_sbp_df)
  me_sbp_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                     data = me_sbp_df)
  me_sbp_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                     data = me_sbp_df)
  me_sbp_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                     data = me_sbp_df)

# labs <- c("Intercept", "Treatment", "Sex", "Period")
#
# tab_model(
#   me_sbp, me_sbp_p, me_sbp_bl,
#   p.val = "kr",
#   file = "tables/primary/table_me_sbp.html",
#   pred.labels = c(labs, "SBP Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )

# DBP --------------------------------------------------------------------------

  dbp <- outcomes(data, "dbp__")

# group_by(dbp, period, timing, tx) %>%
#   summarise(dbp_missings = sum(is.na(value))) %>%
#   filter(dbp_missings > 0) # 4 total values

# Distribution plot ####

# dist(dbp, "DBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/dbp_dist2.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(dbp, "DBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/dbp.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_dbp_df <- full_join(
    select(dbp, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(dbp, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")
  ) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_dbp     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                     data = me_dbp_df)
  me_dbp_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                     data = me_dbp_df)
  me_dbp_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                     data = me_dbp_df)
  me_dbp_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                     data = me_dbp_df)

# tab_model(
#   me_dbp, me_dbp_p, me_dbp_bl,
#   p.val = "kr",
#   file = "tables/primary/table_me_dbp.html",
#   pred.labels = c(labs, "DBP Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )


# C SBP ------------------------------------------------------------------------

  c_sbp <- outcomes(data, "c_sbp__")

# group_by(c_sbp, period, timing, tx) %>%
#   summarise(c_sbp_missings = sum(is.na(value))) %>%
#   filter(c_sbp_missings > 0) # 4 total values

# Distribution plot ####

# dist(c_sbp, "C SBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/c_sbp_dist2.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(c_sbp, "C SBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/c_sbp.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_c_sbp_df <- full_join(
    select(c_sbp, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(c_sbp, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")
  ) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_c_sbp     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                         data = me_c_sbp_df)
  me_c_sbp_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                         data = me_c_sbp_df)
  me_c_sbp_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                         data = me_c_sbp_df)
  me_c_sbp_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                         data = me_c_sbp_df)

# tab_model(
#   me_c_sbp, me_c_sbp_p, me_c_sbp_bl,
#   p.val = "kr",
#   file = "tables/primary/table_me_c_sbp.html",
#   pred.labels = c(labs, "C SBP Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )


# C DBP ------------------------------------------------------------------------

  c_dbp <- outcomes(data, "c_dbp__")

# group_by(c_dbp, period, timing, tx) %>%
#   summarise(c_dbp_missings = sum(is.na(value))) %>%
#   filter(c_dbp_missings > 0) # 4 total values

# Distribution plot ####

# dist(c_dbp, "C DBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/c_dbp_dist2.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(c_dbp, "C DBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/c_dbp.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_c_dbp_df <- full_join(
    select(c_dbp, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(c_dbp, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")
  ) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_c_dbp     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                         data = me_c_dbp_df)
  me_c_dbp_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                         data = me_c_dbp_df)
  me_c_dbp_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                         data = me_c_dbp_df)
  me_c_dbp_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                         data = me_c_dbp_df)

# tab_model(
#   me_c_dbp, me_c_dbp_p, me_c_dbp_bl,
#   p.val = "kr",
#   file = "tables/primary/table_me_c_dbp.html",
#   pred.labels = c(labs, "C DBP Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )