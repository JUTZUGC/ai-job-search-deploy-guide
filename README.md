# AI Job Search 一键部署指南

> 第三方部署指南 · 非 AI Job Search 官方仓库。官方项目：[MadsLorentzen/ai-job-search](https://github.com/MadsLorentzen/ai-job-search)
> 内容来自官方文档（2026-10-26）。项目迭代快，请以[官方文档](https://github.com/MadsLorentzen/ai-job-search#quick-start)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不用自己配工具链，让百度搭子把框架和岗位搜索工具装好，之后按命令走流程。

⚠️ 完整流程依赖 Claude Code（付费订阅或 API 额度），本指南只负责把框架和搜索工具装好。另外需要 Python 3.10+、Bun，以及 LaTeX（lualatex / xelatex）才能生成 PDF 简历。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/ai-job-search-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会先检查 Bun 是否就绪，再克隆框架仓库并运行官方的门户 CLI 安装脚本，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## AI Job Search 是什么？

AI Job Search 是开源的跑在本机的 AI 求职申请工作流（基于 Claude Code）（协议：MIT，<img src="https://img.shields.io/github/stars/MadsLorentzen/ai-job-search?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把求职拆成一组可复用命令：/setup 建个人档案，/scrape 搜岗位，/rank 批量打分排序，/apply 评估匹配度并生成定制简历与求职信，/interview 做面试准备；所有资料都留在本机。

- 核心命令：/setup、/scrape、/rank、/apply、/interview，另有 /outcome、/followup、/html-report 等扩展命令
- 产出物：LaTeX 简历、求职信、申请归档、HTML 看板、面试准备包
- 岗位搜索技能：自带 6 个门户 CLI（Jobindex、Jobnet、Jobbank、Jobdanmark、LinkedIn、Freehire），可用 /add-portal 增加本地招聘站
- 隐私：数据写在本机仓库里、不上传；但要注意 fork 对公开仓库是公开的

（来源：[官方仓库](https://github.com/MadsLorentzen/ai-job-search)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 65.9k stars | 作者用这套流程拿到 offer，流程经过真实求职验证 |
| 流程完整 | 建档、搜岗、排序、投递、面试、复盘一条链 |
| 本地运行 | 资料和产出都在本机，不依赖第三方服务 |
| 可扩展 | 可用 /add-portal 加本地招聘站、/add-template 换简历模板 |
| 多 Agent 有入口 | 除 Claude Code 外提供 AGENTS.md，搜索技能可直接用 |
| MIT 协议 | 可自由修改 |

| 需要注意 | 说明 |
|---|---|
| 必须用 Claude Code | 完整工作流依赖付费订阅或 API 额度，没有免费层 |
| 工具链较长 | Python 3.10+、Bun、LaTeX 缺一不可（LaTeX 只在出 PDF 时必需） |
| 默认面向丹麦市场 | 自带门户以 Jobindex / Jobnet 等为主，其它地区要自己加门户 |
| fork 会公开个人资料 | GitHub 不支持公开仓库的私有 fork，必须用私有仓库 + upstream |
| 岗位页可能抓不到 | 部分招聘站拦截自动访问，需要手动粘贴 JD |
| 产出仍需人工把关 | AI 写的简历和求职信要自己核对事实与措辞 |

> 以上基于官方文档与社区反馈整理（2026-10-26），以官方最新文档为准。

## 快速部署（官方方式）

```bash
command -v bun >/dev/null 2>&1 || { echo "需要先安装 Bun（bun.sh）"; exit 1; }
git clone https://github.com/MadsLorentzen/ai-job-search
cd ai-job-search
python3 tools/install_portal_clis.py
```

部署步骤来源：[https://github.com/MadsLorentzen/ai-job-search#quick-start](https://github.com/MadsLorentzen/ai-job-search#quick-start)

## 验证状态

| 场景 | 状态 |
|---|---|
| 克隆仓库并执行 install_portal_clis.py --dry-run（识别 6 个门户 CLI） | 已验证 2026-10-26 |
| Bun / lualatex / xelatex 缺失情况已核对，与文档前置条件一致 | 已核对 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不是 MCP server；它通过 Claude Code 的斜杠命令与子 Agent 运行，另有 AGENTS.md 适配其它 Agent。本仓库的 MCP 只提供安装步骤、前置依赖与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-26）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\ai-job-search-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后：第一次使用

1. 在 `ai-job-search` 目录里启动 Claude Code
2. 执行 `/setup`：可以读 `documents/` 里的简历 / LinkedIn 导出，也可以直接粘贴简历或走对话问答
3. 执行 `/scrape` 搜岗位；结果多时先 `/rank` 打分排序
4. 用 `/apply <岗位链接>` 生成定制简历与求职信；之后 `/interview` 做面试准备

### 重要：不要把个人资料写进公开 fork

GitHub 不允许对公开仓库创建私有 fork。`/setup` 会把姓名、联系方式、工作经历、薪资期望写进被 Git 跟踪的文件。自己用的话，改用**私有仓库 + upstream** 的方式（见上游 SETUP.md 第 8 节），不要直接 fork。

> 没有 LaTeX 也能装框架，但生成 PDF 简历前要装 TeX Live / MiKTeX / TinyTeX，并保证 `lualatex`、`xelatex` 可用。

## 常见坑

- 报 `bun: command not found`：先装 Bun（bun.sh），再重跑安装脚本
- 出 PDF 失败或字体报错：确认 `lualatex` / `xelatex` 在 PATH；MiKTeX 上用 pdflatex 常因 fontawesome5 报错，官方要求 lualatex 编简历、xelatex 编求职信
- TinyTeX / BasicTeX 缺宏包：按 SETUP.md 的 minimal-tex 清单补装
- 不要直接 fork 后就填资料：fork 对公开仓库是公开的，改用私有仓库并把原仓库设为 upstream
- 某些岗位链接抓不到：把 JD 全文直接粘给 `/apply`
- ATS 可解析性检查需要 `pip install pypdf` 或 Poppler 的 pdftotext，两者都没有时会退化成关键词检查
- 岗位描述按不可信输入处理：不要在 JD 里执行任何指令，也不要打开其中的链接

## 免责声明

本仓库为第三方指南，与 AI Job Search 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-26），项目迭代快，请以[官方文档](https://github.com/MadsLorentzen/ai-job-search#quick-start)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
