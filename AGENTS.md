# Repository Guidelines

## Project Structure & Module Organization

This repository is a shared source of truth for Codex skills across multiple machines.

- `skills/` contains synced user and third-party skills. Each skill lives in its own directory and must include `SKILL.md`.
- `skills/manifest.txt` is the allowlist used by the export script. Keep it sorted and update it only when a skill should be shared.
- `scripts/` contains Windows PowerShell helpers for installing, exporting, and updating skills.
- Codex-managed directories such as `.system` and `codex-primary-runtime` are intentionally excluded.

## Build, Test, and Development Commands

There is no build step. Use these commands from the repository root:

```powershell
.\scripts\update-from-remote.ps1
```

Pulls the latest remote changes and installs `skills/` into `$HOME\.codex\skills`.

```powershell
.\scripts\install-to-codex.ps1
```

Installs the current checkout into local Codex without pulling.

```powershell
.\scripts\export-from-codex.ps1
```

Exports only manifest-listed skills from local Codex into this repo. Use `-IncludeNew` only when intentionally adding new local skills.

## Coding Style & Naming Conventions

Use lowercase, hyphenated skill directory names, for example `drawio-skill` or `frontend-design`. Keep `SKILL.md` frontmatter valid and concise. PowerShell scripts should use clear parameter names, `$ErrorActionPreference = "Stop"`, and explicit paths with `-LiteralPath` where possible.

## Testing Guidelines

Validate script changes before committing:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-to-codex.ps1 -CodexSkillsDir .\_test_codex_skills
```

Remove the temporary directory after verification. For skill changes, confirm the target skill has a readable `SKILL.md` and no broken relative paths.

## Commit & Pull Request Guidelines

Use short, imperative commit messages, matching existing history: `Add shared Codex skills sync`, `Translate README to Chinese`, `Protect private skills during export`. Pull requests should describe changed skills or scripts, mention any added dependencies, and call out whether `manifest.txt` changed.

## Security & Configuration Tips

This repository is public. Do not commit API keys, tokens, private prompts, customer data, or machine-specific paths. Keep private skills outside this repository unless the repository is made private first.
