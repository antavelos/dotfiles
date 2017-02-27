#!/bin/bash

IGNORE=("." ".." ".git")
PWD=`pwd`
FILES=`ls -a`

# Helper functions
is_dotfile() {
	[[ $1 = .* ]]
}

can_be_used() {
	for f in ${IGNORE[*]}; do
		if [ "$1" = $f ]; then
			return 1 # false
		fi
	done

	return 0 # true
}

exists() {
	[ -f $1 ] || [ -d $1 ]
}

create_link() {
	src=$PWD/$1
	dest=~/$1
	if exists $dest; then
		mv $dest $dest.bck
	fi
	ln -s $src $dest
	echo "Created link: $dest"
}

# Main
for file in $FILES; do
	if is_dotfile $file && can_be_used $file; then
		create_link $file
	fi
done
