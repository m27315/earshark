# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-multilib git-2

DESCRIPTION="Simple wrapper around libcurl inspired by the Python Requests project"
HOMEPAGE="https://github.com/whoshuu/cpr"
#SRC_URI="https://github.com/whoshuu/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="git://github.com/whoshuu/cpr.git https://github.com/whoshuu/cpr.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-insecure"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"

src_prepare() {
	multilib_copy_sources
}

multilib_src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use insecure INSECURE_CURL)
		-DUSE_SYSTEM_CURL=ON
		-DBUILD_CPR_TESTS=OFF
	)
	cmake-utils_src_configure
}

multilib_src_install() {
	dolib.a ./lib/libcpr.a
	dodoc ./README.md ./AUTHORS

	insinto /usr/include/cpr
	doins ./include/cpr/*.h
}