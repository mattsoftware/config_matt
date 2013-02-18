#!/usr/bin/env bash



function log() {
	echo "$1"
}
function logErr() {
	log " *** ERROR: $1 ***"
}

function createLink() {
	SOURCE="$1";shift
	TARGET="$1";shift
	if [[ ! -e "$TARGET" ]]; then
		ln -s "$SOURCE" "$TARGET"
	elif [[ ! -L "$TARGET" ]]; then
		logErr "$TARGET already exists"
	else
		if [[ "$(readlink "$TARGET")" != $SOURCE ]]; then
			logErr "$TARGET exists, but is a symlink already"
		fi
	fi
}

# .vim and .vimrc
createLink `pwd`/vim ~/.vim
createLink `pwd`/vim/vimrc ~/.vimrc

log "Dont forget to..."
log "    git submodule init"
log "    git submodule update"


