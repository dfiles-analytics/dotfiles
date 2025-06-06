#!/bin/sh

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$REPO_DIR/config-files"
LINK_FILE="$REPO_DIR/links.list"

DRY_RUN=false

# Args
for arg in "$@"; do
	case "$arg" in
		--dry-run) DRY_RUN=true ;;
		*)
			printf "\033[31m[ERROR]\033[0m Unknown argument: %s\n" "$arg" >&2
			printf "Usage: %s [--dry-run]\n" "$(basename "$0")" >&2
			exit 1 ;;
	esac
done

# Log functions
log()   { printf "\033[33m[INFO]\033[0m  %s\n" "$1"; }
error() { printf "\033[31m[ERROR]\033[0m %s\n" "$1" >&2; }
dry_run() { printf "\033[36m[DRY-RUN]\033[0m %s\n" "$1"; }

# Main
while IFS='=' read -r src dst || [ -n "$src" ]; do
	# Trim and skip comments/empty
	src=$(echo "$src" | xargs)
	dst=$(echo "$dst" | xargs)
	[ -z "$src" ] && continue
	case "$src" in \#*) continue ;; esac

	src_path="$CONFIG_DIR/$src"
	dst_path=$(printf "%s" "$dst" | sed "s|^~|$HOME|")
	parent_dir="$(dirname "$dst_path")"

	# Check source
	if [ ! -e "$src_path" ]; then
		error "Missing source: $src_path"
		continue
	fi

	# Check for symlinked parent directory
	if [ -L "$parent_dir" ]; then
		link_target=$(readlink -f "$parent_dir")
		if [ "$DRY_RUN" = true ]; then
			dry_run "Parent is a symlink: $parent_dir → $link_target"
			dry_run "Skipping $dst_path to avoid nested links."
			continue
		else
			error "Target parent is a symlink: $parent_dir → $link_target"
			error "Skipping $dst_path to avoid nested links."
			continue
		fi
	fi

	# Remove existing symlink
	if [ -L "$dst_path" ]; then
		if [ "$DRY_RUN" = true ]; then
			dry_run "Would remove existing link: $dst_path"
		else
			rm -f "$dst_path"
			log "Removed existing link: $dst_path"
		fi
	fi

	# Create parent directory if needed
	[ "$DRY_RUN" = false ] && mkdir -p "$parent_dir"

	# Link
	if [ "$DRY_RUN" = true ]; then
		dry_run "Would link: $dst_path → $src_path"
	else
		ln -sf "$src_path" "$dst_path"
		log "Linked: $dst_path → $src_path"
	fi
done < "$LINK_FILE"

if [ "$DRY_RUN" = true ]; then
	dry_run "───[ DRY-RUN COMPLETE ]───"
else
	printf "\033[32m[SUCCESS] ───[ SYMLINK COMPLETE ]───\033[0m\n"
fi
