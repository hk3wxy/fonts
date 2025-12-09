#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $(basename "$0") [--user] [--help]

Installs all fonts found under the `fonts/` directory adjacent to this script.

Options:
  --user    Install to the current user's font directory (no root required).
  --help    Show this help message.
EOF
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FONTS_DIR="$SCRIPT_DIR/fonts"

if [ ! -d "$FONTS_DIR" ]; then
  echo "Error: fonts directory not found at '$FONTS_DIR'" >&2
  exit 2
fi

USER_INSTALL=false
while [ "$#" -gt 0 ]; do
  case "$1" in
    --user) USER_INSTALL=true; shift ;;
    -h|--help) usage; exit 0 ;;
    --become-root) shift ;;
    *) echo "Unknown option: $1" >&2; usage; exit 2 ;;
  esac
done

if $USER_INSTALL; then
  DEST="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
  mkdir -p "$DEST"
else
  if [ "${EUID:-0}" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
      echo "Need root privileges for system install — re-running with sudo..."
      exec sudo bash "$0" --become-root
    else
      echo "Run this script as root or use --user for a per-user install." >&2
      exit 3
    fi
  fi
  DEST="/usr/local/share/fonts"
  mkdir -p "$DEST"
fi

echo "Installing fonts from: $FONTS_DIR"
echo "Destination: $DEST"

count=0
while IFS= read -r -d '' file; do
  name="$(basename "$file")"
  echo "Copying: $name"
  cp -f -- "$file" "$DEST/"
  chmod 644 "$DEST/$name" || true
  count=$((count+1))
done < <(find "$FONTS_DIR" -type f \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.woff' -o -iname '*.woff2' \) -print0)

if [ "$count" -eq 0 ]; then
  echo "No font files found in $FONTS_DIR. Supported extensions: ttf, otf, woff, woff2" >&2
  exit 4
fi

echo "Installed $count font(s). Updating font cache..."
if command -v fc-cache >/dev/null 2>&1; then
  fc-cache -f -v "$DEST" || true
  echo "Font cache updated."
else
  echo "Warning: 'fc-cache' not found. Run 'fc-cache -f -v' as root or as the user to update the cache." >&2
fi

echo "Done."
