
# These scripts includes a number of functions used in the analysis. Namely,
# there are functions to quickly reshape the main data set for each of the
# study outcomes as needed; and to plot said data in a manner that makes sense
# for a cross over trial. There are also functions for creating the main
# table 1 for the paper.

# Outcome data prep ------------------------------------------------------------

# Pull the key study variables (time, period, tx, id) and an outcome, reshape to
# long, and tidy up labels.

  outcomes <- function(df, variable, ...){

    df <- select(df, -contains("fwo"), -(contains("_mc_"))) %>%
      gather(time, value, starts_with(variable)) %>%
      select(sequence, treatment_p1, treatment_p2, time, value, subj_id,
             sex) %>%
      mutate(sequence = factor(sequence),
             treatment_p1 = factor(treatment_p1),
             treatment_p2 = factor(treatment_p2))

    df$time <- gsub(variable, "", df$time)

    times <- c("b_p1", "ep_p1", "b_p2", "ep_p2")

    df <- mutate(df, time = factor(time, levels = times))

    df$period[grepl("_p1", df$time)] <- "First"
    df$period[grepl("_p2", df$time)] <- "Second"

    bp <- grepl("b_p",  df$time)
    ep <- grepl("ep_p", df$time)

    df$timing[bp] <- "Baseline"
    df$timing[ep] <- "EoP"

    df$bl[bp] <- df$value[bp]
    df$ep[ep] <- df$value[ep]

    p1 <- df$period == "First"
    p2 <- df$period == "Second"
    df$tx[p1] <- df$treatment_p1[p1]
    df$tx[p2] <- df$treatment_p2[p2]

    df <- filter(df, !is.na(time)) %>%
      arrange(subj_id, period, timing) %>%
      select(subj_id, sequence, period, timing, tx, value, everything()) %>%
      mutate(period = factor(period),
             timing = factor(timing),
             tx  = factor(tx, labels = c("Control", "Active")))

    df$time2 <- factor(df$time, labels = c("p1_b", "p1_ep",
                                           "p2_b", "p2_ep"))

    df <- full_join(
      filter(df, timing == "Baseline" & tx == "Active" & !is.na(bl)) %>%
        select(subj_id, bl_act = bl),
      filter(df, timing == "Baseline" & tx == "Control" & !is.na(bl)) %>%
        select(subj_id, bl_con = bl),
      by = "subj_id"
    ) %>% full_join(
      filter(df, timing == "EoP" & tx == "Control" & !is.na(ep)) %>%
        select(subj_id, ep_con = ep),
      by = "subj_id"
    ) %>% mutate(regular = rowMeans(.[c("bl_act", "bl_con", "ep_con")])) %>%
      select(subj_id, regular) %>%
      full_join(df)

    return(df)
  }

# Outcome cross-over plot ------------------------------------------------------

  cross_plot <- function(df, ylabel,logged = c("yes", "no"), ...){

    if(logged == "no"){
      plt <- ggplot(df, aes(x = time2, y = value, group = subj_id))
    }

    if(logged == "yes"){
      plt <- ggplot(df, aes(x = time2, y = log(value), group = subj_id))
    }

    plt <- plt +
      geom_line(data = filter(df, as.numeric(time) < 3), alpha = 0.2,
                aes(color = treatment_p1)) +
      geom_smooth(data = filter(df, as.numeric(time) < 3), method = "lm",
                  aes(color = treatment_p1, linetype = treatment_p1,
                      group = treatment_p1),
                  se = FALSE, size = 2) +
      geom_line(data = filter(df, as.numeric(time) > 2), alpha = 0.2,
                aes(color = treatment_p2)) +
      geom_smooth(data = filter(df, as.numeric(time) > 2), method = "lm",
                  aes(color = treatment_p2, linetype = treatment_p2,
                      group = treatment_p2),
                  se = FALSE, size = 2) +
      scale_linetype(guide = FALSE) +
      scale_color_brewer("Tx", palette = "Set1") +
      theme(panel.grid.major = element_blank()) +
      scale_x_discrete(labels = c("Start P1", "End P1", "Start P2", "End P2")) +
      xlab("") +
      theme_minimal() +
      ylab(ylabel)

    return(plt)
  }


# Outcome distribution plot ----------------------------------------------------

  dist <- function(data, ylabel, logged = c("yes", "no"), ...){

    if(logged == "no"){
      plt <- ggplot(data, aes(x = value, fill = tx, color = tx))
    }

    if(logged == "yes"){
      plt <- ggplot(data, aes(x = log(value), fill = tx, color = tx))
    }

      plt <- plt +
        geom_density(alpha = 0.7) +
        geom_rug() +
        scale_fill_brewer("Tx", palette = "Set1") +
        scale_color_brewer("Tx", palette = "Set1") +
        facet_wrap(~period + timing) +
        theme(panel.grid.major = element_blank()) +
        ylab("") +
        theme_minimal() +
        xlab(ylabel)

      return(plt)
    }


# Others -----------------------------------------------------------------------

  is_labelled <- function(x) {
    if (length(class(x)) > 1) return(any(class(x) == "haven_labelled"))
    return(class(x) == "haven_labelled")
  }

  unlabel <- function(x) {
    if (is.data.frame(x) || is.matrix(x)) {
      for (i in 1:ncol(x)) {
        if (is_labelled(x[[i]])) x[[i]] <- unclass(x[[i]])
      }
    }
    else {
      # remove labelled class
      if (is_labelled(x)) x <- unclass(x)
    }
    return(x)
  }


# Table functions --------------------------------------------------------------
# These are used to extract data to make the descriptive table in
# paper_stats.rmd. Each creates one column for the table (e.g. variable names).
# They are all then put into a data frame for printing.

  tests.1 <- function(data, ...) {

    tests.list <- list()

    require(dplyr)
    require(broom)

    for (j in seq_along(data)) {

      if(is.numeric(data[[j]])){

        t <- aov(data[[j]] ~ arm, data) %>%
          tidy()

        tests.list[[j]] <- round(t$p.value[1], 2)
      }

      if(is.factor(data[[j]])){

        c <- table(data[[j]], data$arm) %>%
          chisq.test() %>%
          tidy()

        tests.list[[j]] <- c(round(c$p.value[1], 2),
                             rep("", length(levels(data[[j]]))))
      }

    }
    unlist(tests.list)
  }


  tests.2 <- function(data, ...) {

    tests.list <- list()

    require(dplyr)
    require(broom)

    for (j in seq_along(data)) {

      if(is.numeric(data[[j]])){

        k <- kruskal.test(data[[j]] ~ arm, data) %>%
          tidy()

        tests.list[[j]] <- round(k$p.value[1], 2)
      }

      if(is.factor(data[[j]])){

        c <- table(data[[j]], data$arm) %>%
          chisq.test() %>%
          tidy()

        tests.list[[j]] <- c(round(c$p.value[1], 2),
                             rep("", length(levels(data[[j]]))))
      }

    }
    unlist(tests.list)
  }


# Generate the list of names for the table

  name.1 <- function(x, ...) {

    var.names <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        var.names[[i]] <- names(x[i])
      }

      if(is.factor(x[[i]])){
        var.names[[i]] <- c(names(x[i]), levels(x[[i]]))
      }
    }

    unlist(var.names)
  }


# Means(sds) or counts(%)

  summary.1 <- function(x, ...) {

    summary.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        summary.list[[i]] <- paste0(round(mean(x[[i]], na.rm = TRUE), 1),
                                    " \u00B1 ",
                                    round(sd(x[[i]],   na.rm = TRUE), 1))
      }

      if(is.factor(x[[i]])){
        summary.list[[i]] <- c("", paste0(table(x[[i]]),
                                          " (",
                                          round(table(x[[i]]) /
                                                  sum(table(x[[i]])), 3) * 100,
                                          "%)"))
      }

    }
    unlist(summary.list)
  }


  summary.2 <- function(x, ...) {

    summary.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        summary.list[[i]] <- paste0(round(quantile(x[[i]], probs = c(0.50),
                                                   na.rm = TRUE), 1),
                                    " [",
                                    round(quantile(x[[i]], probs = c(0.25),
                                                   na.rm = TRUE), 1),
                                    ", ",
                                    round(quantile(x[[i]], probs = c(0.75),
                                                   na.rm = TRUE), 1),
                                    "]")
      }

      if(is.factor(x[[i]])){
        summary.list[[i]] <- c("", paste0(table(x[[i]]),
                                          " (",
                                          round(table(x[[i]]) /
                                                  sum(table(x[[i]])), 3) * 100,
                                          "%)"))
      }

    }
    unlist(summary.list)
  }


# Missing observations

  n.miss <- function(x, ...) {

    miss.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        miss.list[[i]] <- length(x[[i]][!is.na(x[[i]])])
      }

      if(is.factor(x[[i]])){
        miss.list[[i]] <- c(length(x[[i]][!is.na(x[[i]])]),
                            rep("", length(levels(x[[i]]))))
      }

    }
    unlist(miss.list)
  }


# Min and max

  min.max <- function(x, ...) {

    min.max.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        min.max.list[[i]] <- paste0("(",
                                    round(min(x[[i]], na.rm = TRUE), 1),
                                    ", ",
                                    round(max(x[[i]], na.rm = TRUE), 1),
                                    ")")
      }

      if(is.factor(x[[i]])){
        min.max.list[[i]] <- c("", rep("", length(levels(x[[i]]))))
      }

    }
    unlist(min.max.list)
  }


# Quartiles

  tiles <- function(x, ...) {

    quantiles.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        quantiles.list[[i]] <- paste0(round(quantile(x[[i]], probs = c(0.25),
                                                     na.rm = TRUE), 1),
                                      ", ",
                                      round(quantile(x[[i]], probs = c(0.50),
                                                     na.rm = TRUE), 1),
                                      ", ",
                                      round(quantile(x[[i]], probs = c(0.75),
                                                     na.rm = TRUE), 1))
      }

      if(is.factor(x[[i]])){
        quantiles.list[[i]] <- c("", rep("", length(levels(x[[i]]))))
      }

    }
    unlist(quantiles.list)
  }


# Median, IQR

  med.iqr <- function(x, ...) {

    quantiles.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        quantiles.list[[i]] <- paste0(round(quantile(x[[i]], probs = c(0.5),
                                                     na.rm = TRUE), 1),
                                      " (",
                                      round(quantile(x[[i]], probs = c(0.25),
                                                     na.rm = TRUE), 1),
                                      ", ",
                                      round(quantile(x[[i]], probs = c(0.75),
                                                     na.rm = TRUE), 1),
                                      ")")
      }

      if(is.factor(x[[i]])){
        quantiles.list[[i]] <- c("", rep("", length(levels(x[[i]]))))
      }

    }
    unlist(quantiles.list)
  }

