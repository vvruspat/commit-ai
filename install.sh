#!/usr/bin/env bash
set -euo pipefail

default_server="https://api.openai.com"
default_model="gpt-4o-mini"

echo "Commit AI install"
read -r -p "Server URL [$default_server]: " server
read -r -p "Model [$default_model]: " model
read -r -p "API key: " api_key

server="${server:-$default_server}"
model="${model:-$default_model}"

rc_path="$HOME/.commitrc"

cat > "$rc_path" <<EOF
COMMIT_SERVER="$server"
COMMIT_MODEL="$model"
COMMIT_API_KEY="$api_key"
EOF

chmod 600 "$rc_path"

bin_dir="$HOME/.local/bin"
mkdir -p "$bin_dir"
ln -sf "$(pwd)/commit-ai" "$bin_dir/commit-ai"

echo "Wrote config to $rc_path"
echo "Installed symlink to $bin_dir/commit-ai"
echo "Ensure $bin_dir is on your PATH."
