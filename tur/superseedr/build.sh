TERMUX_PKG_HOMEPAGE=https://github.com/Jagalite/superseedr
TERMUX_PKG_DESCRIPTION="A BitTorrent Client in your Terminal"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@everywhereless"
TERMUX_PKG_VERSION="1.0.10"
TERMUX_PKG_SRCURL="https://github.com/Jagalite/superseedr/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=23b846bce0cd92f0f94dd893b8b4c6ebc227680d532bea6a33d4d9d72c153911
TERMUX_PKG_DEPENDS="openssl"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true

termux_step_pre_configure() {
	termux_setup_rust
}

termux_step_make() {
	cargo build \
		--jobs "$TERMUX_PKG_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--release
}

termux_step_make_install() {
	install -Dm755 \
		"target/${CARGO_TARGET_NAME}/release/superseedr" \
		"${TERMUX_PREFIX}/bin/superseedr"
}
