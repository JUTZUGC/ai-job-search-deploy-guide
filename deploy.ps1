# AI Job Search 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/MadsLorentzen/ai-job-search#quick-start
# 更新日期：2026-10-26
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw '需要先安装 Python 3' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

if (-not (Get-Command bun -ErrorAction SilentlyContinue)) { throw '需要先安装 Bun（bun.sh）' }
git clone https://github.com/MadsLorentzen/ai-job-search
Set-Location ai-job-search
python tools\install_portal_clis.py ; if ($LASTEXITCODE -ne 0) { throw '门户 CLI 安装失败，请查看上面的输出' }

Write-Host ''

Write-Host '安装完成：在 ai-job-search 目录里打开 Claude Code，先执行 /setup 填档案，再 /scrape 搜岗位'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/MadsLorentzen/ai-job-search#quick-start'
