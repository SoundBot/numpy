# Contributor: Francesco Colista <fcolista@alpinelinux.org>
# Contributor: Jakub Jirutka <jakub@jirutka.cz>
# Contributor: Martell Malone <martellmalone@gmail.com>
# Maintainer: Francesco Colista <fcolista@alpinelinux.org>
pkgname=py3-numpy
pkgver=1.22.3
pkgrel=0
pkgdesc="Scientific tools for Python"
url="https://www.numpy.org/"
arch="all"
license="BSD-3-Clause"
options="!check"
replaces="py-numpy"
makedepends="
	cython
	gfortran
	libbsd-dev
	openblas-dev
	py3-nose
	py3-setuptools
	python3-dev
	"
subpackages="$pkgname-dev
	$pkgname-doc
	$pkgname-f2py::noarch"
source="https://github.com/numpy/numpy/releases/download/v$pkgver/numpy-$pkgver.tar.gz
	numpy-1.17.0-musl.patch
	site.cfg"
builddir="$srcdir/numpy-$pkgver"

export Atlas=None
export LDFLAGS="$LDFLAGS -shared"
# scipy is a huge library (~26 MiB) optimized for performance, so compiling
# with -Os to sacrifice performance for ~1 MiB doesn't make sense.
export CFLAGS=${CFLAGS/-Os/-O2}
export CXXFLAGS=${CXXFLAGS/-Os/-O2}
export CPPFLAGS=${CPPFLAGS/-Os/-O2}

prepare() {
	default_prepare
	cp "$srcdir"/site.cfg "$builddir"/
}

build() {
	python3 setup.py build config_fc --fcompiler=gnu95
}

package() {
	python3 setup.py install --prefix=/usr --root="$pkgdir" \
			config_fc --fcompiler=gnu95

	install -D -m 644 LICENSE.txt \
		"$pkgdir"/usr/share/licenses/$pkgname/LICENSE
		
	python3 setup.py bdist_wheel
	
	cp -r ./dist/ "$pkgdir"
	
	ls
	
}

f2py() {
	pkgdesc="f2py for numpy (for python3)"
	depends="py3-numpy=$pkgver-r$pkgrel python3-dev"
	install_if="$pkgname-f2py=$pkgver-r$pkgrel python3"

	amove usr/bin/f2py*
}

dev() {
	depends_dev="$pkgname"
	default_dev
}

sha512sums="
59424fe1d0f8288adc21a19aef2c0d89aeddb737a27bc3ca02576978ff2d00ae71aef34846df28d84b7a546dd197cf52c865350b76b2432333cf46218d502a0d  numpy-1.22.3.tar.gz
2272f400594c1b2a3b69385fe0aa13d54cd12f4c4f1b109fa07789db7eec4bb681a68fd3d95ce9fb1342a5f76394e2381bb5fa8542631fc50b9a9335c512c690  numpy-1.17.0-musl.patch
21ca8db304cbbf5949f07702f2a42bb5e5a0d641921e36649555a41b0e48f04e96f53760417823177ac27f6de24b2191e6e1d5f0eb393beafa29f7484e23284f  site.cfg
"
