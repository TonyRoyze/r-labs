#fs
pvals <- data.frame(
  Variable = c("Time", "Poten", "AdvExp", "Share", "Change", "Accounts", "Work"),
  P_Value = c(
    get_pval(timemodel),
    get_pval(potenmodel),
    get_pval(advexpmodel),
    get_pval(sharemodel),
    get_pval(changemodel),
    get_pval(accountsmodel),
    get_pval(ratingmodel)
  )
)

print(pvals)
