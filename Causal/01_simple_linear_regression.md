# Simple Linear Regression Snippet

Use this when the question asks for visualization, correlation, a simple linear regression, model adequacy, the fitted equation, or the link between correlation and `R^2`.

## R Template

```r
data(cars)

plot(cars$speed, cars$dist,
     pch = 19, col = "steelblue",
     xlab = "Speed", ylab = "Stopping distance")
abline(lm(dist ~ speed, data = cars), col = "firebrick", lwd = 2)

cor(cars$speed, cars$dist)

fit <- lm(dist ~ speed, data = cars)
summary(fit)
coef(fit)

par(mfrow = c(2, 2))
plot(fit)
par(mfrow = c(1, 1))

sprintf("y_hat = %.4f + %.4f x",
        coef(fit)[1], coef(fit)[2])

c(correlation_squared = cor(cars$speed, cars$dist)^2,
  r_squared = summary(fit)$r.squared)
```

## Answer Pattern

State that the association is positive or negative from the scatter plot and the sign of the correlation.

Report the fitted model in the form `y_hat = b0 + b1 x`.

Comment on residual plots for curvature, unequal spread, and influential points.

If it is a simple linear regression with an intercept, say `R^2 = cor(X, Y)^2`. Also say this identity does not hold for all regression models.
