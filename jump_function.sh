#!/bin/bash
#
# this script should not be run directly,
# instead you need to source it from your .bashrc,
# by adding this line:
#   . ~/scripts/jump_function.sh
#
# 



function jump() {
   case "$1" in
           "--save")
                echo "saving.. $2"
                pwd >"$HOME/.jumps/$2.bm"
                ;;
           "--help")
                echo "jump v0.2 copyright R. de Vos"
		echo ""
		echo "jump --save bookmarkname   :   current directory as bookmarkname"
		echo "jump --list                :   list all bookmarks"
		echo "jump --complete            :   list all bookmarks"
		echo "jump bookmarkname          :   cd to bookmarkname"
                ;;
           "--list")
                pushd $HOME/.jumps >/dev/null
		for i_jumps in *.bm
		do
			temp_jumps="`echo $i_jumps | sed "s/\.bm$//"`"
                        echo "$temp_jumps: `cat ${temp_jumps}.bm`"
			eval j_${temp_jumps}="`cat ${temp_jumps}.bm`"
			ln -s "`cat ${temp_jumps}.bm`" "/tmp/j_${temp_jumps}"
                done
                popd >/dev/null
                ;;
           "--complete")
                pushd $HOME/.jumps >/dev/null
		echo -e "--save \n--help\n--list" | grep "^$3"
		ls *.bm 2>/dev/null | sed "s/\.bm$//" | grep "^$3"
                popd >/dev/null
                ;;
           *)
                if test -f "$HOME/.jumps/$1.bm"; then
                        echo "changing directory to `cat "$HOME/.jumps/$1.bm"`"
                        cd `cat "$HOME/.jumps/$1.bm"`
		else
			echo "unknown jump point"
		fi
                ;;
   esac
}

complete -C "jump --complete" jump

if ! test -d "$HOME/.jumps"; then
	mkdir "$HOME/.jumps"
fi
