param(
    [string]$CodexSkillsDir = "$HOME\.codex\skills"
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$sourceSkills = Join-Path $repoRoot "skills"

if (-not (Test-Path -LiteralPath $sourceSkills)) {
    throw "Missing skills directory: $sourceSkills"
}

New-Item -ItemType Directory -Force -Path $CodexSkillsDir | Out-Null

Get-ChildItem -LiteralPath $sourceSkills -Directory | ForEach-Object {
    $target = Join-Path $CodexSkillsDir $_.Name
    if (Test-Path -LiteralPath $target) {
        Remove-Item -LiteralPath $target -Recurse -Force
    }
    Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse -Force
    Write-Host "Installed $($_.Name) -> $target"
}

Write-Host ""
Write-Host "Restart Codex to pick up new or updated skills."
