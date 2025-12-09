# Installing the bundled fonts on Linux

This repository includes a `fonts/` directory with font files. The scripts
in this repo let you install or remove those fonts on most Linux distributions.

Files included

- `install-fonts.sh` — Installs fonts to the system (`/usr/local/share/fonts`) or the current user (`~/.local/share/fonts`).
- `uninstall-fonts.sh` — Removes installed fonts that match files found in `fonts/`.
- `PKGBUILD` and `.SRCINFO` — Arch Linux package build files (local build / AUR-ready hints).

Quick usage (scripts)

- System-wide install (requires root):

```bash
sudo bash ./install-fonts.sh
```

- Per-user install (no sudo required):

```bash
./install-fonts.sh --user
```

- Uninstall from user directory:

```bash
./uninstall-fonts.sh --user
```

- Uninstall system-wide (requires root):

```bash
sudo bash ./uninstall-fonts.sh
```

Notes and compatibility

- The scripts look for font files in the `fonts/` directory next to the scripts.
- Supported extensions: `.ttf`, `.otf`, `.woff`, `.woff2`.
- After installing or removing fonts the scripts call `fc-cache -f -v` when available.

Arch Linux / AUR

This repo includes a `PKGBUILD` that builds a local package from the `fonts/` directory and a corresponding `.SRCINFO`.

- Build and install locally (on an Arch-based system):

```bash
cd /path/to/repo
makepkg -si
```

- Install via AUR with `yay` (other users):
  - To make the package installable via `yay -S <pkgname>` you must upload the package tree (PKGBUILD + .SRCINFO) to the AUR under a unique package name (for example `fonts-hk3wxy`).
  - Once published, users can install with:

```bash
yay -S fonts-hk3wxy
```

- Note: for local builds the `PKGBUILD` uses `source=("fonts/")` and `sha256sums=('SKIP')`. If you prepare this package for the AUR prefer a reproducible source (for example a release tarball) and compute the correct checksum, replacing `SKIP`.

Help with packaging

If you'd like, I can:
- Update the `PKGBUILD` to fetch a tagged release tarball and compute the real checksum.
- Generate a `.SRCINFO` matching those values for direct AUR upload.
- Create an Arch `PKGBUILD` branch with a unique package name and instructions for publishing.

Tell me which option you prefer and I will update the files accordingly.
# Installing the bundled fonts on Linux

This repository includes a `fonts/` directory with font files. The scripts
below let you install or remove those fonts on most Linux distributions.

Files added:

- `install-fonts.sh` : Installs fonts to the system (`/usr/local/share/fonts`) or the current user (`~/.local/share/fonts`).
- `uninstall-fonts.sh` : Removes installed fonts that match files found in `fonts/`.

Quick usage

- System-wide install (requires root):

```bash
sudo bash ./install-fonts.sh
```

- Per-user install (no sudo required):

```bash
./install-fonts.sh --user
```

- Uninstall from user directory:

```bash
./uninstall-fonts.sh --user
```

- Uninstall system-wide (requires root):

```bash
sudo bash ./uninstall-fonts.sh
```

Notes and compatibility

- The scripts look for font files in the `fonts/` directory next to the scripts.
- Supported extensions: `.ttf`, `.otf`, `.woff`, `.woff2`.
- After installing or removing fonts the scripts call `fc-cache -f -v` when available.
- These scripts are simple, portable, and should work on most Linux distributions.

If you want packages (deb/rpm/Arch PKGBUILD) or integration with a font-management GUI,
I can help generate packaging templates next.
