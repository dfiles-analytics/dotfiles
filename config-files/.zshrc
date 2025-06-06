# Enable basic features
autoload -Uz compinit promptinit
compinit
promptinit

git_prompt_info() {
	if command git rev-parse --is-inside-work-tree &>/dev/null; then
		local branch
		branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)
		[[ -n "$branch" ]] && printf ' (%s%s%s)' "%F{yellow}" "$branch" "%f"
	fi
}

venv_prompt_info() {
	if [[ -n "$VIRTUAL_ENV" ]]; then
		local venv_name="${VIRTUAL_ENV##*/}"
		printf '%s(%s)%s ' "%F{magenta}" "$venv_name" "%f"
	fi
}

precmd() {
	local git_branch venv_name
	git_branch=$(git_prompt_info)
	venv_name=$(venv_prompt_info)

	if [[ $EUID -eq 0 ]]; then
		PROMPT="${venv_name}%F{red}%n%f@%m %~${git_branch} # "
	else
		PROMPT="${venv_name}%F{blue}%n%f@%m %~${git_branch} ❯ "
	fi
}

# History settings
# unset HISTFILE
HISTSIZE=10
SAVEHIST=0

# Useful options
setopt autocd
setopt hist_ignore_dups
setopt share_history
setopt correct

# Keybindings
bindkey -v

# Path
export PATH="$PATH:/usr/local/texlive/2025/bin/x86_64-linux"

# Aliases

# Tmux
tmux-main() {
	# Check if the "main" session exists
	if tmux has-session -t main 2>/dev/null; then
		tmux attach-session -t main
	else
		# Start the "main" session detached with window "sys"
		tmux new-session -d -s main -n sys

		# Window "sys":
		# Pane 0: left
		# Pane 1: upper-right
		# Pane 2: lower-right
		tmux split-window -h -t main:sys
		tmux split-window -v -t main:sys.1

		# Create window "dev":
		# Pane 0: top
		# Pane 1: bottom (25% height)
		tmux new-window -t main:1 -n dev
		tmux split-window -v -p 25 -t main:dev

		# Return to sys window, focus on left pane
		tmux select-window -t main:sys
		tmux select-pane -t main:0

		# Attach to the session
		tmux attach-session -t main
	fi
}

# Misc
alias ll='ls -lh --color=auto'
alias ls='ls --color=auto'
