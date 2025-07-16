stepwise_selection <- function(dataframe, dep = names(dataframe)[1], alpha = 0.05) {
    predictors <- setdiff(names(dataframe), dep)
    remaining <- predictors
    selected <- c()
    best_model <- NULL
  
    repeat {
        pvals <- c()
        for (var in remaining) {
            model <- lm(as.formula(paste(dep, "~", paste(c(selected, var), collapse = "+"))), data = dataframe)
            pval <- summary(model)$coefficients[var, 4]
            pvals <- c(pvals, pval)
        }
        if (length(pvals) == 0) break
        if (min(pvals, na.rm = TRUE) < alpha) {
            best_var <- remaining[which.min(pvals)]
            cat("Adding ", best_var, "variable into the model", "\n")
            selected <- c(selected, best_var)
            remaining <- setdiff(remaining, best_var)
            best_model <- lm(as.formula(paste(dep, "~", paste(selected, collapse = "+"))), data = dataframe)
            for(var in selected){
                if(summary(best_model)$coefficients[var, 4] > alpha && var != best_var){
                    cat("Removing ", best_var, "variable from the model", "\n")
                    selected <- setdiff(selected, var)
                    remaining <- c(remaining, var)
                }
            }
        } else {
            break
        }
    }
    print(summary(best_model))
    print_model_equation(best_model, dep)
    
}

stepwise_selection(sales)
