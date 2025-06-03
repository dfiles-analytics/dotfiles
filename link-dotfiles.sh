#!/bin/bash

set -e

# Get repo directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Dry-run mode?
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
	DRY_RUN=true
fi

# Logging functions
log() {
	echo -e "\e[33m[INFO]\e[0m : $1"
}

error() {
	echo -e "\e[31m[ERROR]\e[0m : $1" >&2
}

while IFS='=' read -r tgt lnk; do
	# Trim
	tgt=$(echo "$tgt" | xargs)
	lnk=$(echo "$lnk" | xargs)

	src="$REPO_DIR/$tgt"
	dst="${lnk/#\~/$HOME}"

	if [ ! -e "$src" ]; then
		error "Missing source: $src"
		continue
	fi

	mkdir -p "$(dirname "$dst")"

	if $DRY_RUN; then
		log "[DRY-RUN] Would link: $dst → $src"
	else
		ln -sf "$src" "$dst"
		log "✓ Linked $dst → $src"
	fi
done < link.conf

log "--END--"
