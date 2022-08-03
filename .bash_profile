# The following overrides ATT venv behavior from trying to helpfully modify PS1
export VIRTUAL_ENV_DISABLE_PROMPT=True

HISTSIZE=
HISTFILESIZE=
export VISUAL=vim
export EDITOR="$VISUAL"

# Pyenv init
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Load PS1 from bashrc
PROMPT_COMMAND=__prompt_command

# Load all the other fun aliases!
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi