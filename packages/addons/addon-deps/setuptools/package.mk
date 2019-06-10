# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="setuptools"
PKG_VERSION="42.0.2"
PKG_SITE="https://pypi.org/project/setuptools"
#PKG_WATCH="https://github.com/pypa/setuptools/releases .*/v(.*)\.tar\.gz"
PKG_URL="https://github.com/pypa/setuptools/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python:host"

make_host() {
  python3 bootstrap.py
}

makeinstall_host() {
  python3 setup.py install --prefix=$TOOLCHAIN
}
