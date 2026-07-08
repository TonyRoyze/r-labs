# Fisher Randomization Test

Use this when the question asks for Fisher's sharp null, missing potential outcomes under the null, an exact randomization distribution, or an exact p-value in a small experiment.

## R Template

```r
tv_data <- data.frame(
  unit = 1:6,
  Z = c(0, 1, 0, 1, 0, 1),
  Y_obs = c(55.0, 70.0, 72.0, 66.0, 72.7, 78.9)
)

tv_data$Y0 <- ifelse(tv_data$Z == 0, tv_data$Y_obs, NA_real_)
tv_data$Y1 <- ifelse(tv_data$Z == 1, tv_data$Y_obs, NA_real_)

tv_null <- transform(tv_data, Y0_null = Y_obs, Y1_null = Y_obs)

diff_in_means <- function(y, z) {
  mean(y[z == 1]) - mean(y[z == 0])
}

t_obs <- diff_in_means(tv_data$Y_obs, tv_data$Z)
choose(6, 3)

assignments <- combn(6, 3, simplify = FALSE)
rand_dist <- sapply(assignments, function(treated_units) {
  z <- integer(6)
  z[treated_units] <- 1
  diff_in_means(tv_null$Y_obs, z)
})

p_value_exact <- mean(abs(rand_dist) >= abs(t_obs))

t_obs
sort(rand_dist)
p_value_exact
```

## Answer Pattern

State Fisher's sharp null as `Y_i(1) = Y_i(0)` for every unit.

Under the sharp null, the missing potential outcomes equal the observed outcomes.

Say the exact p-value is computed by comparing the observed test statistic with all values in the randomization distribution.
