# Maintainer: Iván Zaera Avellón <ivan.zaera@protonmail.com>
pkgname=ministore
pkgdesc="Mini keyring store based on PBKDF2 and ssh-askpass"
pkgver=1.0.0
pkgrel=1
arch=('any')
url="https://github.com/izaera/ministore"
license=('GPL3')
depends=(
	'bash'
	'grep'
	'openssl'
	'sed'
	'xaskpass'
	'wl-clipboard'
)
# makedepends=()
# backup=()
# install=ministore.install

# FILES=$(find src -type f)
# echo $FILES >> $LOG

# source=($FILES)
# noextract=("${source[@]%%::*}")
# md5sums=()
# validpgpkeys=()


pkgver() {
	git describe --tags	| sed -e 's/-/\./g'
}

package() {
	cd $srcdir/..
	PREFIX="$pkgdir/usr" make install
}
