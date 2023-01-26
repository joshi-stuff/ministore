#!/bin/bash

if [[ "${PROJECT}" == "" ]] 
then 
	echo
	echo ERROR: PROJECT variable must be provided
	echo
	exit 1
fi

#
# Initialize for the first time
#
PROJECT_NAME=$(basename "$PROJECT")

if [[ -z $(ls "${PROJECT}") ]]
then
	cp arch/PKGBUILD "${PROJECT}"

	cat <<EOF > "${PROJECT}/.gitignore"
/*.tar*
/pkg
/src
EOF
fi

if [[ (-n $(ls "${PROJECT}")) && (! -r "${PROJECT}/PKGBUILD") ]] 
then 
	echo
	echo ERROR: ${PROJECT}/PKGBUILD does not exist
	echo
	exit 1
fi

cd "${PROJECT}"
if [ ! -z "$(git status --porcelain)" ] 
then 
	echo
	echo ERROR: ${PROJECT} working copy is not clean
	echo
	exit 1
fi
cd - >/dev/null 2>&1

#
# Copy things
#
cp arch/PKGBUILD "${PROJECT}"
#cp arch/install.sh "${PROJECT}" # install.sh is extracted by AUR's release.sh
cp arch/release.sh "${PROJECT}"
chmod 755 "${PROJECT}/release.sh"

#
# Tweak PKGBUILD
#
cd "${PROJECT}"

CUT_LINE=$(grep -n "# 8< ---- cut from here ----" PKGBUILD | cut -d ":" -f 1)
head -$(($CUT_LINE - 1)) PKGBUILD > PKGBUILD.pre

CUT_LINE=$(grep -n "# 8< ---- cut to here ----" PKGBUILD | cut -d ":" -f 1)
tail +$(($CUT_LINE + 1)) PKGBUILD > PKGBUILD.post

mv PKGBUILD.pre PKGBUILD
cat <<EOF >>PKGBUILD
source=(
	"\$pkgname-\$pkgver.tar.gz::https://codeberg.org/ivan.zaera/\$pkgname/archive/\$pkgver.tar.gz"
)
sha256sums=("")
EOF
cat PKGBUILD.post >> PKGBUILD
rm PKGBUILD.post
