---
name: dev-browser
description: Browser automation with persistent page state. Use when users ask to navigate websites, fill forms, take screenshots, extract web data, test web apps, or automate browser workflows. Trigger phrases include "go to [url]", "click on", "fill out the form", "take a screenshot", "scrape", "automate", "test the website", "log into", or any browser interaction request.
---

# Dev Browser

A CLI for controlling browsers with sandboxed JavaScript scripts.

## Installation

In a Claude Code cloud session, run this first (idempotent, ~30 s the first time):

```bash
CLAUDE_CODE_REMOTE=true bash "$CLAUDE_PROJECT_DIR/.claude/hooks/setup-dev-browser.sh"
```

It installs `dev-browser` and starts the preinstalled Chromium on port 9222. Then always use
`dev-browser --connect http://localhost:9222` (`--headless` tries to download a browser, which the network blocks).
`page.screenshot()` only accepts relative paths; files land in `~/.dev-browser/tmp/`.

Elsewhere (local machine):

```bash
npm install -g dev-browser
dev-browser install
```

## Usage

Run `dev-browser --help` to learn more.

Named daemon-launched browsers persist by default. For unattended work, `--idle-timeout 5m` closes each launched browser after inactivity while preserving its profile and login state. The setting never closes Chrome attached with `--connect`; use `--idle-timeout 0` to disable configured cleanup.
