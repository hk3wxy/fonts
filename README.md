# fonts
A personal collection of fonts for use in projects. This repository is a curated
selection of fonts maintained here for convenience and distribution.

Mostly used on Linux and in design tools like Photoshop.

Contents

- `fonts/` — bundled font files.
- `install-fonts.sh` — simple installer script (system or per-user).
- `uninstall-fonts.sh` — removes installed fonts that match the bundled files.
- `PKGBUILD` and `.SRCINFO` — Arch Linux packaging files for local builds or AUR upload.

Installation (scripts)

System-wide (requires root):

```bash
sudo bash ./install-fonts.sh
```

Per-user (no sudo):

```bash
./install-fonts.sh --user
```

Uninstall (user):

```bash
./uninstall-fonts.sh --user
```

Uninstall (system):

```bash
sudo bash ./uninstall-fonts.sh
```

Notes

- Supported font extensions: `.ttf`, `.otf`, `.woff`, `.woff2`.
- The scripts call `fc-cache -f -v` when available to refresh fontconfig's cache.
- `install-fonts.sh` installs to `/usr/local/share/fonts` (system) or `${XDG_DATA_HOME:-$HOME/.local/share}/fonts` (user).

Arch Linux / AUR

This repo includes a `PKGBUILD` that builds a local package directly from the
`fonts/` directory and a `.SRCINFO` file suitable for AUR uploads.

Build and install locally (on Arch/Manjaro):

```bash
cd /path/to/repo
makepkg -si
```

Install via AUR with `yay` (after publishing to the AUR):

```bash
yay -S fonts-hk3wxy
```

Notes for packaging

- The included `PKGBUILD` uses `source=("fonts/")` and `sha256sums=('SKIP')` for local builds. For AUR publishing, replace `source` with a stable tarball URL (for example a GitHub release) and compute the proper checksum instead of `SKIP`.
- Consider a unique package name such as `fonts-hk3wxy` to avoid conflicts in the AUR.

Want me to do more?

- I can update the `PKGBUILD` to fetch a release tarball and compute checksums (recommended for AUR).
- I can make the scripts executable in the repo (note: file permissions may not persist on Windows filesystems).
- I can prepare a short AUR publish workflow with commands to create the AUR repo, commit, and push.

If you'd like any of those, tell me which and I'll apply the change.
## Installation on Arch Linux

You can install these fonts from the AUR:

```bash
yay -S your-fonts
