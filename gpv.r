#gpv
get_pval <- function(model) {
    summary(model)$coefficients[nrow(summary(model)$coefficients), ncol(summary(model)$coefficients)]
}
