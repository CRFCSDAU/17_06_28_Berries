# Other tests

# Paired-t-test

# Different contrasts

  c1 <- c(0.5, -0.5)

  model <- lmer(out ~ 1 + sequence + (1|subj:sequence) + period + tx,
                contrasts = list(sequence = c1, Period = c1, tx = c1),
                data  == data)