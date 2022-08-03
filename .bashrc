export PATH=/usr/local/opt/openssl@1.0.2t/bin:$PATH
export PATH=/usr/local/opt/gnu-getopt/bin:$PATH
export PATH=/usr/local/opt/mysql@5.7/bin:$PATH

alias aliases='vim ~/.bash_profile'
alias cda='cd ~/work_space/all-the-things'
alias d='deactivate'
alias dockercompose='docker-compose -f deployable/meta/servers/docker-compose.yml up'
alias ga='git_amend'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias grm='gcm; git pull -q; git checkout -; git rebase master'
alias git_diff='git diff master --name-only'
alias git_log='git log --pretty=format:"%h%x09%an%x09%ad%x09%s" -10'
alias git_push='git push -f -u origin HEAD'
alias git_reflog='git reflog --date=iso'
alias gs='git status'
alias ls='ls -G'
alias make_mypy='d;cda;cd deployable/monolith; make mypy MYPY_MODE=daemon; cda'
alias mux="tmuxinator"
alias nt='nosetests'
alias onelogin='affirm.onelogin --aws-account sherlock-prod-canada; affirm.onelogin sherlock'
alias scc='~/work_space/cosmops/kubernetes/scripts/set-cluster-context.py'
av2() {
    cda;
    source deployable/$1/src/.venv/bin/activate
}

av() {
    cda;
    source deployable/$1/src/.venv3/bin/activate
}

function tlogin() {

  local cluster=$1
  if [ -z "$cluster" ]; then
    echo "Cluster not set"
    echo "Run: tlogin {{ CLUSTER }}, where {{ CLUSTER }} is prod, stage or dev"
    return 0
  fi

  if [[ $cluster == "prod" ]]; then
    cluster="keyhole"
  fi
  echo "Connecting to teleport.core.affirm-${cluster}.com"
  out=$(tsh login --proxy=teleport.core.affirm-${cluster}.com:443)
  echo "${out}"
}

# Get git branch
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Parse the venv name
parse_venv() {
    if [ "$VIRTUAL_ENV" != "" ]; then
        venv_prefix=${VIRTUAL_ENV%/src*}
        dt=${venv_prefix#*deployable/}
        # Everything should be py3 soon...
        venv_suffix=${VIRTUAL_ENV#*src/.venv}
        echo "[$dt$venv_suffix]"
    else
        echo ' '
    fi
}

# Only show a red X if the previous command had non-0 exit status
prev_cmd_err_flag() {
    exit_code="$?"
    if [ $exit_code = 0 ]; then
    echo ''
    else
    echo '[✘][✘][✘]'
    fi
}

# want to do some path munging relative to ATT
parse_path() {
    echo "${PWD#*all-the-things}"
}

# Todo: Need more colors (see 88/256 colors)
RED="\[\033[31m\]"
GRAY_BG="\[\033[102m\]"
RESET_BG="\[\033[49m\]"
BLACK="\[\033[30m\]"
YELLOW="\[\033[93m\]"
BLUE="\[\033[96m\]"
WHITE="\[\033[97m\]"
GREEN="\[\033[32m\]"
MAGENTA="\[\033[35m\]"
# I didn't want to create a helper fn for defining PS1, but need to because venv detection
# and previous command success parsing does not work on each successive command
__prompt_command() {
    PS1="${BLACK}${GRAY_BG}\t${reset}${RED}$(prev_cmd_err_flag)${MAGENTA}$(parse_venv)${YELLOW}$(parse_path)${BLUE}\$(parse_git_branch)${WHITE}> "
}
alias config='/usr/bin/git --git-dir=/Users/rohan.nagalkar/.cfg/.git/ --work-tree=/Users/rohan.nagalkar'
