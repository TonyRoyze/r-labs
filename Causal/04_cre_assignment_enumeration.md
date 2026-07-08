# Completely Randomized Experiment Assignment Enumeration

Use this when the question asks how many assignments are possible under a CRE or asks you to generate all assignments in R.

## R Template

```r
choose(5, 3)

all_assignments <- function(n, n1) {
  stopifnot(n1 >= 0, n1 <= n)

  treated_sets <- combn(n, n1)
  assignments <- matrix(0L, nrow = ncol(treated_sets), ncol = n)

  for (j in seq_len(ncol(treated_sets))) {
    assignments[j, treated_sets[, j]] <- 1L
  }

  colnames(assignments) <- paste0("unit_", seq_len(n))
  as.data.frame(assignments)
}

all_assignments(5, 3)
```

## Answer Pattern

Say the number of possible assignments is `choose(n, n1)`.

If the question asks for the mechanism list, report that each row is one valid treatment vector with exactly `n1` treated units.
