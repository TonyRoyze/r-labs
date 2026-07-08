param(
    [Parameter(Mandatory = $true)]
    [string]$BaseRawUrl,

    [Parameter(Mandatory = $true)]
    [string]$Key
)

$map = @{
    "slr"     = "01_simple_linear_regression.md"
    "table"   = "02_contingency_rr_or_chisq.md"
    "simpson" = "03_subgroup_risk_ratio_simpsons_paradox.md"
    "cre"     = "04_cre_assignment_enumeration.md"
    "ate"     = "05_ate_balance_adjusted_regression.md"
    "fisher"  = "06_fisher_randomization_test.md"
    "perm"    = "07_permutation_inference.md"
    "ps"      = "08_propensity_score_stratification.md"
    "ipw"     = "09_ipw_ht_hajek.md"
    "iv"      = "10_iv_2sls.md"
    "med"     = "11_causal_mediation.md"
}

if (-not $map.ContainsKey($Key)) {
    Write-Host "Unknown key: $Key"
    Write-Host "Available keys: $($map.Keys -join ', ')"
    exit 1
}

$url = "$($BaseRawUrl.TrimEnd('/'))/$($map[$Key])"
$content = Invoke-WebRequest -Uri $url -UseBasicParsing | Select-Object -ExpandProperty Content
$content | Set-Clipboard

Write-Host "Copied to clipboard from:"
Write-Host $url
