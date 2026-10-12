TERMUX_PKG_HOMEPAGE=https://github.com/tmuxpack/tpack
TERMUX_PKG_DESCRIPTION="A drop-in replacement for tmux-plugin-manager (tpm) with a TUI. Written in Go"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@everywhereless"
TERMUX_PKG_VERSION="2.0.6"
TERMUX_PKG_SRCURL="https://github.com/tmuxpack/tpack/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=d730b97b7f7c9dd70310bba6fa7ce9016e62624b16099612a468e13ba7853976
TERMUX_PKG_DEPENDS="git, tmux"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true

termux_step_pre_configure() {
	termux_setup_golang
}

termux_step_make() {
	go build -o tpack ./cmd/tpack
}

termux_step_make_install() {
	install -Dm755 tpack \
		"${TERMUX_PREFIX}/bin/tpack"
}
