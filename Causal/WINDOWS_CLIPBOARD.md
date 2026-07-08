# Windows Clipboard Workflow

Use PowerShell on Windows.

The simplest pattern is:

```powershell
curl.exe -L "https://raw.githubusercontent.com/<user>/<repo>/<branch>/curl_snippets/<file>.md" | Set-Clipboard
```

Then paste directly into your exam notebook with `Ctrl+V`.

## Direct One-Liner Pattern

Replace `<user>`, `<repo>`, `<branch>`, and `<file>.md`.

```powershell
curl.exe -L "https://raw.githubusercontent.com/<user>/<repo>/<branch>/curl_snippets/10_iv_2sls.md" | Set-Clipboard
```

## Recommended PowerShell Version

This version is more reliable than alias-based `curl` because it forces the real Windows curl binary:

```powershell
curl.exe -L "https://raw.githubusercontent.com/<user>/<repo>/<branch>/curl_snippets/05_ate_balance_adjusted_regression.md" | Set-Clipboard
```

## If You Want a Short Command

Use the helper script in this folder:

```powershell
powershell -ExecutionPolicy Bypass -File .\curl_snippets\copy-snippet.ps1 `
  -BaseRawUrl "https://raw.githubusercontent.com/<user>/<repo>/<branch>/curl_snippets" `
  -Key iv
```

That command copies the IV snippet directly to your clipboard.

## Short Keys

`slr`
Simple linear regression

`table`
2 x 2 table, RR, OR, chi-squared

`simpson`
Overall and subgroup risk ratios

`cre`
Treatment assignment enumeration

`ate`
Balance, unadjusted ATE, adjusted ATE

`fisher`
Exact Fisher randomization test

`perm`
Permutation inference

`ps`
Propensity score stratification

`ipw`
HT and Hajek IPW

`iv`
2SLS and IV

`med`
Causal mediation

## Practical Exam Usage

If the question is about regression diagnostics, copy `slr`.

If the question is about a binary exposure and binary outcome, copy `table`.

If the question is about randomized treatment effects with balance checks, copy `ate`.

If the question is about exact randomization-based inference, copy `fisher`.

If the question is about propensity scores, copy `ps` or `ipw`.

If the question is about instruments and 2SLS, copy `iv`.

If the question is about direct and indirect effects, copy `med`.
