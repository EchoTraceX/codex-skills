param(
    [string]$CodexSkillsDir = "$HOME\.codex\skills",
    [switch]$IncludeNew
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$targetSkills = Join-Path $repoRoot "skills"
$manifestPath = Join-Path $targetSkills "manifest.txt"
$excluded = @(".system", "codex-primary-runtime")

if (-not (Test-Path -LiteralPath $CodexSkillsDir)) {
    throw "Missing Codex skills directory: $CodexSkillsDir"
}

New-Item -ItemType Directory -Force -Path $targetSkills | Out-Null

if ($IncludeNew -or -not (Test-Path -LiteralPath $manifestPath)) {
    $skillNames = Get-ChildItem -LiteralPath $CodexSkillsDir -Directory |
        Where-Object { $_.Name -notin $excluded } |
        Select-Object -ExpandProperty Name
} else {
    $skillNames = Get-Content -LiteralPath $manifestPath |
        Where-Object { $_ -and -not $_.StartsWith("#") } |
        ForEach-Object { $_.Trim() }
}

foreach ($name in $skillNames) {
    $source = Join-Path $CodexSkillsDir $name
    if (-not (Test-Path -LiteralPath $source)) {
        Write-Warning "Skipping missing local skill: $name"
        continue
    }

    $target = Join-Path $targetSkills $name
    if (Test-Path -LiteralPath $target) {
        Remove-Item -LiteralPath $target -Recurse -Force
    }
    Copy-Item -LiteralPath $source -Destination $target -Recurse -Force
    Write-Host "Exported $name -> $target"
}

$manifestNames = Get-ChildItem -LiteralPath $targetSkills -Directory |
    Select-Object -ExpandProperty Name |
    Sort-Object
[System.IO.File]::WriteAllLines($manifestPath, $manifestNames, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "Review changes with: git status"
if (-not $IncludeNew) {
    Write-Host "Private-safety mode: only skills listed in skills/manifest.txt were exported."
    Write-Host "Use -IncludeNew only when you intentionally want to add new local skills."
}
