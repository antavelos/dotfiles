#!/bin/bash

IGNORE=("." ".." ".git")
PWD=`pwd`
FILES=`ls -a`

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


for file in $FILES; do
	if is_dotfile $file && can_be_used $file; then
		# echo $PWD/$file
		ln -s $PWD/$file ~/$file
	fi
done
