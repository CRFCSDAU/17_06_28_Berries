
  library(tidyverse)
  library(lme4)
  library(sjPlot)

# OCS SBP ----------------------------------------------------------------------

  osc_sbp <- outcomes(data, "osc_sbp__")

# group_by(osc_sbp, period, timing, tx) %>%
#   summarise(osc_sbp_missings = sum(is.na(value))) %>%
#   filter(osc_sbp_missings > 0) # 4 total values

# Distribution plot ####

# dist(osc_sbp, "OSC SBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/osc_sbp_dist2.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(osc_sbp, "OSC SBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/osc_sbp.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_osc_sbp_df <- full_join(
    select(osc_sbp, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(osc_sbp, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")
  ) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_osc_sbp     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                         data = me_osc_sbp_df)
  me_osc_sbp_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                         data = me_osc_sbp_df)
  me_osc_sbp_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                         data = me_osc_sbp_df)
  me_osc_sbp_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                         data = me_osc_sbp_df)

# tab_model(
#   me_osc_sbp, me_osc_sbp_p, me_osc_sbp_bl,
#   p.val = "kr",
#   file = "tables/primary/table_me_osc_sbp.html",
#   pred.labels = c(labs, "OSC SBP Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )

# OCS DBP ----------------------------------------------------------------------

  osc_dbp <- outcomes(data, "osc_dbp__")

# group_by(osc_dbp, period, timing, tx) %>%
#   summarise(osc_dbp_missings = sum(is.na(value))) %>%
#   filter(osc_dbp_missings > 0) # 4 total values

# Distribution plot ####

# dist(osc_dbp, "OSC DBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/osc_dbp_dist2.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(osc_dbp, "OSC DBP (mmHg)", logged = "no")
#
# ggsave("plots/primary/osc_dbp.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_osc_dbp_df <- full_join(
    select(osc_dbp, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(osc_dbp, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")
  ) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_osc_dbp     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                         data = me_osc_dbp_df)
  me_osc_dbp_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                         data = me_osc_dbp_df)
  me_osc_dbp_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                         data = me_osc_dbp_df)
  me_osc_dbp_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                         data = me_osc_dbp_df)

# tab_model(
#   me_osc_dbp, me_osc_dbp_p, me_osc_dbp_bl,
#   p.val = "kr",
#   file = "tables/primary/table_me_osc_dbp.html",
#   pred.labels = c(labs, "OSC DBP Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )

# OXLDL ------------------------------------------------------------------------

  oxldl <- outcomes(data, "oxldl_")

# group_by(oxldl, period, timing, tx) %>%
#   summarise(oxldl_missings = sum(is.na(value))) %>%
#   filter(oxldl_missings > 0) # 4 total values

# Distribution plot ####

# dist(oxldl, "Log(OXLDL)", logged = "yes")
#
# ggsave("plots/secondary/oxldl_dist_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# dist(oxldl, "OXLDL", logged = "no")
#
# ggsave("plots/secondary/oxldl_dist.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(oxldl, "Log(OXLDL)", logged = "yes")
#
# ggsave("plots/secondary/oxldl_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# cross_plot(oxldl, "OXLDL", logged = "no")
#
# ggsave("plots/secondary/oxldl.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_oxldl_df <- full_join(
    select(oxldl, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(oxldl, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")
  ) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_oxldl     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                     data = me_oxldl_df)
  me_oxldl_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                     data = me_oxldl_df)
  me_oxldl_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                     data = me_oxldl_df)
  me_oxldl_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                     data = me_oxldl_df)

# tab_model(
#   me_oxldl, me_oxldl_p, me_oxldl_bl,
#   p.val = "kr",
#   file = "tables/secondary/table_me_oxldl.html",
#   pred.labels = c(labs, "OXLDL Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )


# Arterial Stiffness -----------------------------------------------------------

  art_stif <- outcomes(data, "pwv_art_stif_")

# group_by(art_stif, period, timing, tx) %>%
#   summarise(oxldl_missings = sum(is.na(value))) %>%
#   filter(oxldl_missings > 0)

# Distribution plot ####

# dist(art_stif, "Log(Arterial Stiffness)", logged = "yes")
#
# ggsave("plots/secondary/art_stif_dist_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# dist(art_stif, "Arterial Stiffness", logged = "no")
#
# ggsave("plots/secondary/art_stif_dist.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(art_stif, "Log(Arterial Stiffness)", logged = "yes")
#
# ggsave("plots/secondary/art_stif_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# cross_plot(art_stif, "Arterial Stiffness", logged = "no")
#
# ggsave("plots/secondary/art_stif.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_art_stif_df <- full_join(
    select(art_stif, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(art_stif, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")
  ) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_art_stif     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                          data = me_art_stif_df)
  me_art_stif_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                          data = me_art_stif_df)
  me_art_stif_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                          data = me_art_stif_df)
  me_art_stif_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                          data = me_art_stif_df)

# tab_model(
#   me_art_stif, me_art_stif_p, me_art_stif_bl,
#   p.val = "kr",
#   file = "tables/secondary/table_me_art_stif.html",
#   pred.labels = c(labs, "Stiffness Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )

# Fasting glucose --------------------------------------------------------------

  glu <- outcomes(data, "glu_")

# group_by(glu, period, timing, tx) %>%
#   summarise(oxldl_missings = sum(is.na(value))) %>%
#   filter(oxldl_missings > 0)

# Distribution plot ####

# dist(glu, "Log(Glucose)", logged = "yes")
#
# ggsave("plots/secondary/glu_dist_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# dist(glu, "Glucose", logged = "no")
#
# ggsave("plots/secondary/glu_dist.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(glu, "Log(Glucose)", logged = "yes")
#
# ggsave("plots/secondary/glu_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# cross_plot(glu, "Glucose", logged = "no")
#
# ggsave("plots/secondary/glu.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_glu_df <- full_join(
    select(glu, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(glu, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_glu     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                          data = me_glu_df)
  me_glu_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                          data = me_glu_df)
  me_glu_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                          data = me_glu_df)
  me_glu_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                          data = me_glu_df)


# tab_model(
#   me_glu, me_glu_p, me_glu_bl,
#   p.val = "kr",
#   file = "tables/secondary/table_me_glu.html",
#   pred.labels = c(labs, "Glucose Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )


# LDL --------------------------------------------------------------------------

  ldl <- outcomes(data, "ldl_")

# group_by(ldl, period, timing, tx) %>%
#   summarise(ldl_missings = sum(is.na(value))) %>%
#   filter(ldl_missings > 0)

# Distribution plot ####

# dist(ldl, "Log(LDL)", logged = "yes")
#
# ggsave("plots/secondary/ldl_dist_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# dist(ldl, "LDL", logged = "no")
#
# ggsave("plots/secondary/ldl_dist.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(ldl, "Log(LDL)", logged = "yes")
#
# ggsave("plots/secondary/ldl_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# cross_plot(ldl, "LDL", logged = "no")
#
# ggsave("plots/secondary/ldl.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_ldl_df <- full_join(
    select(ldl, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(ldl, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_ldl     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                     data = me_ldl_df)
  me_ldl_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                     data = me_ldl_df)
  me_ldl_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                     data = me_ldl_df)
  me_ldl_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                     data = me_ldl_df)

# tab_model(
#   me_ldl, me_ldl_p, me_ldl_bl,
#   p.val = "kr",
#   file = "tables/secondary/table_me_ldl.html",
#   pred.labels = c(labs, "LDL Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )


# HDL --------------------------------------------------------------------------

  hdl <- outcomes(data, "hdl_")

# group_by(hdl, period, timing, tx) %>%
#   summarise(hdl_missings = sum(is.na(value))) %>%
#   filter(hdl_missings > 0)

# Distribution plot ####

# dist(hdl, "Log(HDL)", logged = "yes")
#
# ggsave("plots/secondary/hdl_dist_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# dist(hdl, "HDL", logged = "no")
#
# ggsave("plots/secondary/hdl_dist.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(hdl, "Log(HDL)", logged = "yes")
#
# ggsave("plots/secondary/hdl_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# cross_plot(hdl, "HDL", logged = "no")
#
# ggsave("plots/secondary/hdl.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_hdl_df <- full_join(
    select(hdl, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(hdl, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_hdl     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                     data = me_hdl_df)
  me_hdl_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                     data = me_hdl_df)
  me_hdl_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                     data = me_hdl_df)
  me_hdl_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                     data = me_hdl_df)

# tab_model(
#   me_hdl, me_hdl_p, me_hdl_bl,
#   p.val = "kr",
#   file = "tables/secondary/table_me_hdl.html",
#   pred.labels = c(labs, "HDL Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )


# TCHOL ------------------------------------------------------------------------

  tchol <- outcomes(data, "tchol_")

# group_by(tchol, period, timing, tx) %>%
#   summarise(tchol_missings = sum(is.na(value))) %>%
#   filter(tchol_missings > 0)

# Distribution plot ####

# dist(tchol, "Log(TCHOL)", logged = "yes")
#
# ggsave("plots/secondary/tchol_dist_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# dist(tchol, "TCHOL", logged = "no")
#
# ggsave("plots/secondary/tchol_dist.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(tchol, "Log(TCHOL)", logged = "yes")
#
# ggsave("plots/secondary/tchol_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# cross_plot(tchol, "TCHOL", logged = "no")
#
# ggsave("plots/secondary/tchol.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_tchol_df <- full_join(
    select(tchol, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(tchol, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_tchol     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                     data = me_tchol_df)
  me_tchol_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                     data = me_tchol_df)
  me_tchol_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                     data = me_tchol_df)
  me_tchol_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                     data = me_tchol_df)

# tab_model(
#   me_tchol, me_tchol_p, me_tchol_bl,
#   p.val = "kr",
#   file = "tables/secondary/table_me_tchol.html",
#   pred.labels = c(labs, "TCHOL Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )

# TAG --------------------------------------------------------------------------

  tag <- outcomes(data, "tag_")

# group_by(tag, period, timing, tx) %>%
#   summarise(tag_missings = sum(is.na(value))) %>%
#   filter(tag_missings > 0)

# Distribution plot ####

# dist(tag, "Log(TAG)", logged = "yes")
#
# ggsave("plots/secondary/tag_dist_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# dist(tag, "TAG", logged = "no")
#
# ggsave("plots/secondary/tag_dist.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot

# cross_plot(tag, "Log(TAG)", logged = "yes")
#
# ggsave("plots/secondary/tag_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# cross_plot(tag, "TAG", logged = "no")
#
# ggsave("plots/secondary/tag.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_tag_df <- full_join(
    select(tag, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(tag, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_tag     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                       data = me_tag_df)
  me_tag_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                       data = me_tag_df)
  me_tag_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                       data = me_tag_df)
  me_tag_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                       data = me_tag_df)

# tab_model(
#   me_tag, me_tag_p, me_tag_bl,
#   p.val = "kr",
#   file = "tables/secondary/table_me_tag.html",
#   pred.labels = c(labs, "TAG Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )

# PWA Augment ------------------------------------------------------------------

  pwa_augment <- outcomes(data, "pwa_augment_")

# group_by(pwa_augment, period, timing, tx) %>%
#   summarise(pwa_augment_missings = sum(is.na(value))) %>%
#   filter(pwa_augment_missings > 0)

# Distribution plot ####

# dist(pwa_augment, "Log(PWA AUGMENT)", logged = "yes")
#
# ggsave("plots/secondary/pwa_augment_dist_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# dist(pwa_augment, "PWA AUGMENT", logged = "no")
#
# ggsave("plots/secondary/pwa_augment_dist.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Cross over plot ####

# cross_plot(pwa_augment, "Log(PWA AUGMENT)", logged = "yes")
#
# ggsave("plots/secondary/pwa_augment_log.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)
#
# cross_plot(pwa_augment, "PWA AUGMENT", logged = "no")
#
# ggsave("plots/secondary/pwa_augment.pdf", width = 33.867, height = 19.05, units = "cm",
#        scale = 0.6, dpi = 600)

# Models ####

  me_pwa_augment_df <- full_join(
    select(pwa_augment, subj_id, sex, period, bl, tx) %>% filter(!is.na(bl)),
    select(pwa_augment, subj_id, sex, period, ep, tx) %>% filter(!is.na(ep)),
    by = c("subj_id", "period", "tx", "sex")) %>%
    mutate(bl = scale(bl, scale = FALSE))

  me_pwa_augment     <- lmer(ep ~ tx + sex +               (1 | subj_id),
                     data = me_pwa_augment_df)
  me_pwa_augment_p   <- lmer(ep ~ tx + sex + period +      (1 | subj_id),
                     data = me_pwa_augment_df)
  me_pwa_augment_int <- lmer(ep ~ tx * period +  sex +     (1 | subj_id),
                     data = me_pwa_augment_df)
  me_pwa_augment_bl  <- lmer(ep ~ tx + sex + period + bl + (1 | subj_id),
                     data = me_pwa_augment_df)

# tab_model(
#   me_pwa_augment, me_pwa_augment_p, me_pwa_augment_bl,
#   p.val = "kr",
#   file = "tables/secondary/table_me_pwa_augment.html",
#   pred.labels = c(labs, "PWA AUGMENT Baseline"),
#   dv.labels = c("Unadjusted", "+ Period effect", "+ Baselines")
#   )


