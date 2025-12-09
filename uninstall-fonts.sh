#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $(basename "$0") [--user] [--help]

Removes fonts that match files in the local `fonts/` directory from the
installation destination used by `install-fonts.sh`.

Options:
  --user    Uninstall from the current user's font directory.
  --help    Show this help message.
EOF
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FONTS_DIR="$SCRIPT_DIR/fonts"

if [ ! -d "$FONTS_DIR" ]; then
  echo "Error: fonts directory not found at '$FONTS_DIR'" >&2
  exit 2
fi

USER_UNINSTALL=false
while [ "$#" -gt 0 ]; do
  case "$1" in
    --user) USER_UNINSTALL=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 2 ;;
  esac
done

if $USER_UNINSTALL; then
  DEST="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
else
  if [ "${EUID:-0}" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
      echo "Need root privileges for system uninstall — re-running with sudo..."
      exec sudo bash "$0" --userless
    else
      echo "Run this script as root or use --user for a per-user uninstall." >&2
      exit 3
    fi
  fi
  DEST="/usr/local/share/fonts"
fi

echo "Uninstalling fonts matching names from: $FONTS_DIR"
echo "From destination: $DEST"

to_remove=()
while IFS= read -r -d '' file; do
  to_remove+=("$(basename "$file")")
done < <(find "$FONTS_DIR" -type f \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.woff' -o -iname '*.woff2' \) -print0)

if [ ${#to_remove[@]} -eq 0 ]; then
  echo "No font files found in $FONTS_DIR to match." >&2
  exit 4
fi

echo "The following files will be removed from $DEST:"
for n in "${to_remove[@]}"; do echo "  $n"; done
read -r -p "Proceed? [y/N] " ans
case "$ans" in
  [yY]|[yY][eE][sS]) ;;
  *) echo "Aborted."; exit 0 ;;
esac

removed=0
for n in "${to_remove[@]}"; do
  target="$DEST/$n"
  if [ -e "$target" ]; then
    echo "Removing: $target"
    rm -f -- "$target"
    removed=$((removed+1))
  else
    echo "Not found: $target"
  fi
done

if command -v fc-cache >/dev/null 2>&1; then
  echo "Updating font cache..."
  fc-cache -f -v "$DEST" || true
fi

echo "Removed $removed file(s)."
