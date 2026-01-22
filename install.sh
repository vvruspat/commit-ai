#!/usr/bin/env bash
set -euo pipefail

default_server="https://api.openai.com"
default_model="gpt-4o-mini"

rc_path="$HOME/.commitrc"

if [[ -f "$rc_path" ]]; then
  echo "Config already exists at $rc_path; leaving it unchanged."
else
  echo "Commit AI install"
  read -r -p "Server URL [$default_server]: " server
  echo "Select model:"
  PS3="Model number: "
  select choice in gpt-4o-mini gpt-4o custom; do
    case "${choice:-}" in
      gpt-4o-mini|gpt-4o)
        model="$choice"
        break
        ;;
      custom)
        read -r -p "Custom model [$default_model]: " model
        model="${model:-$default_model}"
        break
        ;;
      *)
        echo "Invalid selection."
        ;;
    esac
  done
  read -r -p "API key: " api_key

  server="${server:-$default_server}"
  model="${model:-$default_model}"

  cat > "$rc_path" <<EOF
COMMIT_SERVER="$server"
COMMIT_MODEL="$model"
COMMIT_API_KEY="$api_key"
EOF
  chmod 600 "$rc_path"
  echo "Wrote config to $rc_path"
fi

bin_dir="$HOME/.local/bin"
mkdir -p "$bin_dir"
ln -sf "$(pwd)/commit-ai" "$bin_dir/commit-ai"

shell_name="$(basename "${SHELL:-}")"
rc_file=""
case "$shell_name" in
  zsh) rc_file="$HOME/.zshrc" ;;
  bash) rc_file="$HOME/.bashrc" ;;
esac

if [[ -n "$rc_file" ]]; then
  if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$rc_file" 2>/dev/null; then
    printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$rc_file"
  fi
fi

echo "Installed symlink to $bin_dir/commit-ai"
if [[ -n "$rc_file" ]]; then
  echo "Added $bin_dir to PATH in $rc_file (restart your shell)."
else
  echo "Ensure $bin_dir is on your PATH."
fi
