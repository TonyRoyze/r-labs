# When To Curl Which Snippet

Use this file as the selector guide.

GitHub raw pattern:

```bash
curl.exe -L "https://raw.githubusercontent.com/TonyRoyze/r-labs/main/Causal/10_iv_2sls.md" | Set-Clipboard
```

## Question Types

`01_simple_linear_regression.md`
Use when the question asks for a scatter plot, correlation, fitted line, regression diagnostics, fitted equation, or the relation between correlation and `R^2`.

`02_contingency_rr_or_chisq.md`
Use when the question asks for a 2 x 2 table, risk ratio, odds ratio, or a chi-squared test of independence for two binary variables.

`03_subgroup_risk_ratio_simpsons_paradox.md`
Use when the question asks for an overall risk ratio and then subgroup-specific risk ratios, especially with age groups or a request to comment on Simpson's paradox.

`04_cre_assignment_enumeration.md`
Use when the question asks how many treatment assignments are possible in a completely randomized experiment or asks for an R function to list them.

`05_ate_balance_adjusted_regression.md`
Use when the question asks for covariate balance, unadjusted ATE, adjusted ATE, imputation of missing outcomes, or regression adjustment in a randomized experiment.

`06_fisher_randomization_test.md`
Use when the question asks for Fisher's sharp null, missing potential outcomes under the null, an exact randomization distribution, or an exact p-value in a small experiment.

`07_permutation_inference.md`
Use when the question asks for Monte Carlo randomization inference, a permutation distribution, permutation p-values, or comparison with an asymptotic p-value.

`08_propensity_score_stratification.md`
Use when the question asks for propensity scores, stratification into `K` bins, a stratified ATE estimate, or a general R function for propensity-score stratification.

`09_ipw_ht_hajek.md`
Use when the question asks for Horvitz-Thompson estimation, Hajek estimation, propensity-score truncation, or bootstrap standard errors for IPW estimators.

`10_iv_2sls.md`
Use when the question asks for instrumental variables, 2SLS, corrected residuals, a manual standard error, or a confidence interval for the IV effect.

`11_causal_mediation.md`
Use when the question asks for a mediation DAG, Baron-Kenny direct and indirect effects, Sobel standard errors, or `mediation::mediate()` output.

## Practical Rule

Curl the smallest snippet that matches the method being asked for.

If a question mixes methods, curl the main estimation snippet first and then the inference snippet second.

Examples:

- ATE plus balance in an experiment: `05_ate_balance_adjusted_regression.md`
- 2 x 2 table plus risk ratio plus test of independence: `02_contingency_rr_or_chisq.md`
- Exact randomization test in a tiny experiment: `06_fisher_randomization_test.md`
- Propensity scores plus stratified effect estimate: `08_propensity_score_stratification.md`
- IV with manual matrix formulas: `10_iv_2sls.md`
