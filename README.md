# Codex Skills

Shared Codex skills for multiple machines.

This repository is the source of truth for personal and third-party skills.
Codex still loads skills from the local machine, so each computer should sync
this repository into its local Codex skills directory.

## Layout

```text
skills/
  <skill-name>/
    SKILL.md
scripts/
  install-to-codex.ps1
  export-from-codex.ps1
  update-from-remote.ps1
```

The repository intentionally excludes Codex-managed directories such as
`.system` and `codex-primary-runtime`.

## Install Or Update On A Computer

Clone this repository, then run:

```powershell
.\scripts\update-from-remote.ps1
```

By default it installs into:

```text
$HOME\.codex\skills
```

Restart Codex after installing or updating skills.

## Export Local Changes Back To This Repo

After editing or installing skills locally:

```powershell
.\scripts\export-from-codex.ps1
git status
git add .
git commit -m "Update skills"
git push
```

## Notes

- Keep secrets out of skills.
- Prefer editing skills in this repository, then installing them locally.
- Use `git pull` before installing on another computer.
