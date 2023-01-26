#!/bin/bash

main_branch_name() {
	if git rev-parse --quiet --verify main >/dev/null 2>&1 
	then 
		echo main
	else
		echo master
	fi
}

upstream_remote_exists() {
	git ls-remote --exit-code upstream >/dev/null 2>&1
}

if [ ! -z "$(git status --porcelain)" ]
then
	echo "Working copy is not clean. Refusing to continue"
	exit 1
fi

if [ "$(git br --show-current)" != "$(main_branch_name)" ]
then
	echo "Not in $(main_branch_name) branch. Refusing to continue"
	exit 1
fi

echo Latest 4 tags are:
echo
git tag --sort=-committerdate | head -4
echo 
echo -n "Enter desired new version: "
read VERSION

echo New version will be: $VERSION
echo -n "Confirm (y/N)? "
read CONFIRM

if [ "$CONFIRM" != "y" ]
then 
	exit 1
fi

echo ==== Patching PKGBUILD before makepkg...
sed -i "s/^pkgver=.*/pkgver=$VERSION/" arch/PKGBUILD
git add arch/PKGBUILD
git commit -m "chore: prepare version $VERSION"

echo ==== Tagging...
git tag "$VERSION"

echo ==== Pushing...
git push origin --follow-tags
upstream_remote_exists && git push upstream --follow-tags
