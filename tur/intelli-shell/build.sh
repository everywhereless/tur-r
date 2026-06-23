TERMUX_PKG_HOMEPAGE=https://github.com/lasantosr/intelli-shell
TERMUX_PKG_DESCRIPTION="Like IntelliSense, but for shells"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@everywhereless"
TERMUX_PKG_VERSION="3.4.3"
TERMUX_PKG_SRCURL="https://github.com/lasantosr/intelli-shell/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=de3846628332a19740f372f9e6cd3ce84d1d079de75dbbdfa1e92715a08d0f9a
TERMUX_PKG_DEPENDS="openssl, sqlite"
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
		"target/${CARGO_TARGET_NAME}/release/intelli-shell" \
		"${TERMUX_PREFIX}/bin/intelli-shell"
}
