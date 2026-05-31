param(
    [string]$CodexSkillsDir = "$HOME\.codex\skills"
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$targetSkills = Join-Path $repoRoot "skills"
$excluded = @(".system", "codex-primary-runtime")

if (-not (Test-Path -LiteralPath $CodexSkillsDir)) {
    throw "Missing Codex skills directory: $CodexSkillsDir"
}

New-Item -ItemType Directory -Force -Path $targetSkills | Out-Null

Get-ChildItem -LiteralPath $CodexSkillsDir -Directory |
    Where-Object { $_.Name -notin $excluded } |
    ForEach-Object {
        $target = Join-Path $targetSkills $_.Name
        if (Test-Path -LiteralPath $target) {
            Remove-Item -LiteralPath $target -Recurse -Force
        }
        Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse -Force
        Write-Host "Exported $($_.Name) -> $target"
    }

Get-ChildItem -LiteralPath $targetSkills -Directory |
    Select-Object -ExpandProperty Name |
    Sort-Object |
    Set-Content -LiteralPath (Join-Path $targetSkills "manifest.txt") -Encoding utf8

Write-Host ""
Write-Host "Review changes with: git status"
