#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/ohmyposh"
THEME_FILE="$THEME_DIR/twoline.omp.json"
BASHRC="$HOME/.bashrc"

echo "==> Installing base packages"
sudo apt update
sudo apt install -y curl unzip git

echo "==> Installing Oh My Posh"
curl -s https://ohmyposh.dev/install.sh | bash -s

echo "==> Creating theme directory"
mkdir -p "$THEME_DIR"

echo "==> Writing theme"
cat > "$THEME_FILE" <<'EOF'
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "version": 3,
  "final_space": true,
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        {
          "type": "session",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#000000",
          "background": "#ffb347",
          "template": " {{ .UserName }}@{{ .HostName }} "
        },
        {
          "type": "path",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#ff8c42",
          "properties": {
            "style": "folder"
          },
          "template": " {{ .Path }} "
        },
        {
          "type": "git",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#5aa9ff",
          "template": " {{ .HEAD }}{{ if .Working.Changed }} *{{ end }} "
        }
      ]
    },
    {
      "type": "rprompt",
      "segments": [
        {
          "type": "text",
          "style": "plain",
          "foreground": "#888888",
          "template": "in "
        },
        {
          "type": "shell",
          "style": "plain",
          "foreground": "#5aa9ff",
          "template": "{{ .Name }}"
        },
        {
          "type": "text",
          "style": "plain",
          "foreground": "#888888",
          "template": " at "
        },
        {
          "type": "time",
          "style": "plain",
          "foreground": "#5aa9ff",
          "properties": {
            "time_format": "15:04:05"
          },
          "template": "{{ .CurrentDate | date .Format }}"
        }
      ]
    },
    {
      "type": "prompt",
      "alignment": "left",
      "newline": true,
      "segments": [
        {
          "type": "text",
          "style": "plain",
          "foreground": "#ffffff",
          "template": "> "
        }
      ]
    }
  ]
}
EOF

echo "==> Backing up bashrc"
cp "$BASHRC" "$BASHRC.bak.$(date +%Y%m%d%H%M%S)"

echo "==> Cleaning old Oh My Posh lines"
grep -v 'oh-my-posh init bash' "$BASHRC" | grep -v 'export PATH="$HOME/.local/bin:$PATH"' > "$BASHRC.tmp" || true
mv "$BASHRC.tmp" "$BASHRC"

echo "==> Adding PATH and init"
cat >> "$BASHRC" <<'EOF'

export PATH="$HOME/.local/bin:$PATH"
eval "$(oh-my-posh init bash --config "$HOME/.config/ohmyposh/twoline.omp.json")"
EOF

echo
echo "Done."
echo "Reconnect SSH to confirm."