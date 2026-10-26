#!/usr/bin/env bash
set -euo pipefail
# AI Job Search 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/MadsLorentzen/ai-job-search#quick-start
# 更新日期：2026-10-26
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1 || { echo "需要先安装 Python 3"; exit 1; }

mkdir -p .download
cd .download

command -v bun >/dev/null 2>&1 || { echo "需要先安装 Bun（bun.sh）"; exit 1; }
git clone https://github.com/MadsLorentzen/ai-job-search
cd ai-job-search
python3 tools/install_portal_clis.py

echo ""

echo "安装完成：在 ai-job-search 目录里打开 Claude Code，先执行 /setup 填档案，再 /scrape 搜岗位"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/MadsLorentzen/ai-job-search#quick-start"
