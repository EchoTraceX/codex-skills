# Codex Skills 同步仓库

这是多个电脑共用的 Codex skills 仓库。

Codex 仍然从本机目录加载 skills，本仓库负责作为云端唯一来源。每台电脑只需要从这里拉取，然后同步到本机的 Codex skills 目录。

## 使用方法

### 第一次在新电脑安装

```powershell
git clone https://github.com/EchoTraceX/codex-skills.git
cd codex-skills
.\scripts\update-from-remote.ps1
```

脚本默认会安装到：

```text
$HOME\.codex\skills
```

安装完成后，重启 Codex 才会加载新的 skills。

### 以后更新 skills

在已经 clone 过本仓库的电脑上执行：

```powershell
cd codex-skills
.\scripts\update-from-remote.ps1
```

这个脚本会先执行 `git pull --ff-only`，然后把仓库里的 `skills/` 同步到本机 Codex。

更新后同样需要重启 Codex。

### 把本机新增或修改的 skills 同步回 GitHub

如果你在本机安装了新 skill，或者直接改了本机的 skill 文件，先导出到本仓库：

```powershell
.\scripts\export-from-codex.ps1
```

然后提交并推送：

```powershell
git status
git add .
git commit -m "Update skills"
git push
```

推送后，其他电脑执行 `.\scripts\update-from-remote.ps1` 就能同步到同一套 skills。

## 仓库结构

```text
skills/
  <skill-name>/
    SKILL.md
scripts/
  install-to-codex.ps1
  export-from-codex.ps1
  update-from-remote.ps1
```

## 当前包含的 skills

当前仓库同步的是个人和第三方 skills，不包含 Codex 自带运行目录。

```text
algorithmic-art
canvas-design
cli-anything
doc-coauthoring
docx
drawio-skill
frontend-design
internal-comms
mcp-builder
pdf
pptx
slack-gif-creator
theme-factory
webapp-testing
xlsx
```

## 注意事项

- 不要把密钥、token、账号信息写进 skill 文件。
- 本仓库不会同步 Codex 自带目录：`.system`、`codex-primary-runtime`。
- 推荐优先在本仓库里编辑 skills，再执行 `.\scripts\install-to-codex.ps1` 安装到本机。
- 如果其他电脑上有本地未提交改动，先处理本地改动，再执行更新脚本。
