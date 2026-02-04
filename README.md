# Commit AI

Generate a concise AI summary of your current changes and produce a commit
message in this format:

```
fix(COOL-43433): message
```

The Jira key is extracted from the current branch name (e.g. `COOL-1234/...`).
If no key is found, the script prompts you.

## Install

From this directory:

```
./install.sh
```

The installer asks for server URL, model, and API key, then writes `~/.commitrc`.
It also installs a symlink to `~/.local/bin/commit-ai`.
It also installs a short alias `cai` to the same location.

One-line install from git:

```
git clone https://github.com/vvruspat/commit-ai.git && cd commit-ai && ./install.sh
```

## Usage

Run from a git repository:

```
./commit-ai
```

Optional type flag:

```
./commit-ai -t fix
```

Stage and commit in one go:

```
./commit-ai -a
```

Commit and push to current branch:

```
./commit-ai -p
```

Stage, commit, and push:

```
./commit-ai -a -p
```

If you prefer, you can add this folder to your PATH and run `commit-ai`
anywhere.

## Config

`~/.commitrc` contains:

```
COMMIT_SERVER="https://api.openai.com"
COMMIT_MODEL="gpt-4o-mini"
COMMIT_API_KEY="..."
COMMIT_REQUIRE_JIRA="true"
```

You can also set `COMMIT_AUTH_HEADER` if your server uses a custom header.
