# Maintainer: Bruno Oliveira crazyshare01@gmail.com
pkgname=fonts
pkgver=1.0
pkgrel=1
pkgdesc="A personal collection of fonts for use in any projects"
arch=('any')
url="https://github.com/hk3wxy/fonts"
license=('MIT')
source=("fonts/")
sha256sums=('SKIP')
depends=()

package() {
    install -d "$pkgdir/usr/share/fonts/${pkgname}"
    cp -a "$srcdir/fonts/"* "$pkgdir/usr/share/fonts/${pkgname}/"
    # Ensure readable permissions for font files
    find "$pkgdir/usr/share/fonts/${pkgname}" -type f -exec chmod 644 {} + || true
}
