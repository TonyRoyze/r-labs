print_model_equation <- function(model, dep) {
  coefs <- coef(model)
  eq <- cat(dep, "= ", round(coefs[1], 4))
  if (length(coefs) > 1) {
    for (i in 2:length(coefs)) {
      sign <- if (coefs[i] >= 0) " + " else " - "
      eq <- cat(eq, sign, abs(round(coefs[i], 4)), " * ", names(coefs)[i])
    }
  }
  cat(eq, "\n")
}
