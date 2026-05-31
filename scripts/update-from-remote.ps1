param(
    [string]$CodexSkillsDir = "$HOME\.codex\skills"
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

git -C $repoRoot pull --ff-only

& (Join-Path $PSScriptRoot "install-to-codex.ps1") -CodexSkillsDir $CodexSkillsDir
