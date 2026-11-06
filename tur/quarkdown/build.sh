TERMUX_PKG_HOMEPAGE=https://github.com/iamgio/quarkdown
TERMUX_PKG_DESCRIPTION="Markdown-based typesetting system"
TERMUX_PKG_LICENSE="GPL-3.0, AGPL-3.0"
TERMUX_PKG_MAINTAINER="@everywhereless"
TERMUX_PKG_VERSION="2.7.0"
TERMUX_PKG_SRCURL=https://github.com/iamgio/quarkdown/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=503aafdfeec99c9d05fca50a4c6a442cfabebaf6f674d17bd3758916f4ea4a49
TERMUX_PKG_DEPENDS="openjdk-21"
TERMUX_PKG_SUGGESTS="chromium"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_pre_configure() {
	termux_setup_nodejs
}

termux_step_make() {
	printf '%s\n' "$TERMUX_PKG_VERSION" >version.txt
	./gradlew installDist -x bundleRuntime --no-daemon
}

termux_step_make_install() {
	mkdir -p "$TERMUX_PREFIX/opt"
	cp -r build/install/quarkdown "$TERMUX_PREFIX/opt/quarkdown"
	rm -f "$TERMUX_PREFIX/opt/quarkdown/bin/"*.bat
	cat <<-EOF >"$TERMUX_PREFIX/bin/quarkdown"
		#!$TERMUX_PREFIX/bin/sh
		: "\${QD_CHROME_PATH:=$TERMUX_PREFIX/bin/chromium-browser}"
		export QD_CHROME_PATH
		exec "$TERMUX_PREFIX/opt/quarkdown/bin/quarkdown" "\$@"
	EOF
	chmod 0755 "$TERMUX_PREFIX/bin/quarkdown"

}
