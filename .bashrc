# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Write comment to this command
shopt -s cdspell

# colorfull diff for subversion
sdiff() {
    svn diff --no-diff-deleted $@ | colordiff | less -SR
}

# default editor
export EDITOR=vim

# git stuff
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    complete -o default -o nospace -F _git g
fi

# usefull aliases for ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias g='git'
alias v='vim'
alias gp='git pkg'
alias gclean='git clean -d -x -n'

# aliases to tar extract and compress
alias tc='tar cvzf'
alias tx='tar xvzf'


platform=`uname`

# Status line
if [[ "$color_prompt" == yes || "$platform" == "Darwin" ]]; then
    NORMAL="\[\e[0m\]"
    RED="\[\e[1;31m\]"
    GREEN="\[\e[1;32m\]"
    YELLOW="\[\033[0;33m\]"
else
    NORMAL=""
    RED=""
    GREEN=""
    YELLOW=""
fi
export PS1="$RED\u@\h:$NORMAL\w$YELLOW\$(__git_ps1)$GREEN\$$NORMAL "


if [[ "$platform" == "Darwin" ]]; then
    # MacPorts Installer addition on 2011-06-26_at_12:43:19: adding an appropriate PATH variable for use with MacPorts.
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    # Finished adapting your PATH environment variable for use with MacPorts.

    # Add xld command line util to PATH
    export PATH=/Users/ignat/Packages/xld-20110802:$PATH

    # Setting PATH for EPD_free-7.1-2
    # The orginal version is saved in .bash_profile.pysave
    #PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
    #export PATH

    # Setting PATH for Python 2.7
    export PATH="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH"

    # Use the last version of g++
    export CXX=$(which g++-mp-4.6)
    export CC=$(which gcc-mp-4.6)
    #export CXX=$(which g++)
    #export CC=$(which gcc)

    # Colorize output of ls
    export LSCOLORS=Exfxcxdxbxegedabagacad
    alias ls="ls -FG"

    alias c++="g++-mp-4.6 -std=gnu++0x -O2 -I/opt/local/include"

    export GITHUB="/Users/ignat/Documents/github"

    export WORK="/Users/ignat/Documents/Work"

    export OLYMP_EXAMPLE="/Users/ignat/Olympiads/example"
    alias olymp_copy="cp '${OLYMP_EXAMPLE}/Makefile' '${OLYMP_EXAMPLE}/main.cpp' ."
    alias olymp_tc_copy="cp '${OLYMP_EXAMPLE}/Makefile' . && cp '${OLYMP_EXAMPLE}/tc.cpp' main.cpp"
    alias olymp="olymp_copy && vim main.cpp"
    alias olymp_tc="olymp_tc_copy && vim main.cpp"

    export YT="/Users/ignat/YT/yt/ytlib"

elif [[ "$platform" == "Linux" ]]; then
    # correct autocomplete of environment variables
    # shopt -s cdable_vars
    # complete -v -F _cd $nospace $filenames cd

    PATH="/home/ignat/clang/build/Release+Asserts/bin:$PATH"

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
        else
        color_prompt=
        fi
    fi


    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
        ;;
    *)
        ;;
    esac

    if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi



    # Variables for use debian
    export EMAIL="ignat@yandex-team.ru"
    export DEBFULLNAME="Ignat Kolesnichenko"
    export BOOST_TEST_LOG_LEVEL=messages

    # Aliases for apt-get
    alias agu="sudo apt-get update"
    alias agi="sudo apt-get install"
    alias acp="apt-cache policy"

    # alias for ack
    alias ack="ack-grep"

    # Some popular directories
    export PYMOD="/home/ignat/code/maps/pymod/"
    export API="/home/ignat/code/maps/pymod/yandex/maps/analyzer/api/"
    export MR="/home/ignat/code/maps/pymod/yandex/maps/mapreduce/"
    export QUALITY="/home/ignat/code/maps/fastcgi/analyzer/quality/"
    export PART="/home/ignat/code/maps/fastcgi/analyzer/graph_partition/"

    # Analyzer variables
    export ANALYZER="/home/ignat/code/maps/fastcgi/analyzer/"
    export ANALYZER_MODE=static

    # Analyzer variables
    export YT="/home/ignat/yt/yt/ytlib"

    # tmux completion and restore
    refresh_tmux() {
        if [[ -n $TMUX ]]; then
            NEW_SSH_AUTH_SOCK=`tmux showenv | grep ^SSH_AUTH_SOCK | cut -d = -f 2`
            if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then
                SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK
            fi
        fi
    }
    if [ -f ~/.tmux-completion.bash ]; then
        source ~/.tmux-completion.bash
    fi
    alias tm="tmux attach-session -t 0"
    alias rtm="refresh_tmux"
fi

