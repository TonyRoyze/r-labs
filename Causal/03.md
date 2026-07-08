# Overall and Subgroup Risk Ratios

Use this when the question asks for an overall risk ratio and then the same calculation within subgroups such as age bands.

## R Template

```r
df$vaccine_status <- factor(df$vaccine_status,
                            levels = c("unvaccinated", "vaccinated"))
df$outcome <- factor(df$outcome,
                     levels = c("survived", "death"))

overall_tab <- with(df, table(vaccine_status, outcome))
overall_risk <- overall_tab[, "death"] / rowSums(overall_tab)
overall_rr <- overall_risk["vaccinated"] / overall_risk["unvaccinated"]

overall_tab
overall_risk
overall_rr

age_specific_rr <- lapply(split(df, df$age_group), function(d) {
  tab <- with(d, table(vaccine_status, outcome))
  risk <- tab[, "death"] / rowSums(tab)
  data.frame(
    risk_unvaccinated = risk["unvaccinated"],
    risk_vaccinated = risk["vaccinated"],
    risk_ratio = risk["vaccinated"] / risk["unvaccinated"]
  )
})

age_specific_rr
```

## Answer Pattern

Report the pooled risk ratio first.

Then report each subgroup risk ratio separately.

If the pooled conclusion differs from the subgroup conclusions, say this is consistent with Simpson's paradox and explain that subgroup composition is driving the reversal.
