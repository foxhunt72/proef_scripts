#!/bin/bash


# get the freebsd releases and patchlevel.

wget http://www.freebsd.org/security/security.html -o /dev/null -O - | awk '/<table class="tblbasic">/,/<\/table>/{print}' | sed "s%<tr>%|rowsp%" | grep "rowsp" | sed "s/|rowsp/|/" | cut -d '>' -f 2- | cut -d '<' -f 1 | tr "\n" "," | tr "|" "\n" | sed "s/^,//" | cut -d ',' -f 2 | grep RELEASE | cut -d '-' -f 1 | while read zin
do
	export BRANCH="$(wget https://svnweb.freebsd.org/base/releng/${zin}/sys/conf/newvers.sh?view=co -o /dev/null -O - | grep "^BRANCH=")"
	if test -n "$BRANCH"; then
		echo -n "${zin}-"
		echo $BRANCH | cut -d '"' -f 2
	fi
done

