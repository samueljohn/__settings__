# http://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile

source ${HOME}/.common

#----- Typo fixxer and shortcuts
alias cd..='cd ..'
alias ..='cd ..'
alias ll='ls -lah'
alias l='ls'
alias g='git'
alias gws='git status --short'
alias gco='git checkout'


#------ Test for an interactive shell.
# There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive. Be done now!
    return
fi


#----- Color settings in terminal
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
alias tree='tree -C'


#----- Qicklook alias (OS X specific):
alias quicklook='qlmanage -p "$@" >& /dev/null'
alias ql='qlmanage -p "$@" >& /dev/null'


#----- Colors:
# regular colors
c_black="\[\033[0;30m\]"    # black
c_red="\[\033[0;31m\]"    # red
c_green="\[\033[0;32m\]"    # green
c_yellow="\[\033[0;33m\]"    # yellow
c_blue="\[\033[0;34m\]"    # blue
c_magenta="\[\033[0;35m\]"    # magenta
c_cyan="\[\033[0;36m\]"    # cyan
c_white="\[\033[0;37m\]"    # white
c_gray="\[\033[1;30m\]"
# emphasized (bolded) colors
c_em_black="\[\033[1;30m\]"
c_em_red="\[\033[1;31m\]"
c_em_green="\[\033[1;32m\]"
c_em_yellow="\[\033[1;33m\]"
c_em_blue="\[\033[1;34m\]"
c_em_magenta="\[\033[1;35m\]"
c_em_cyan="\[\033[1;36m\]"
c_em_white="\[\033[1;37m\]"
# to reset to default:
c_reset="\[\033[0m\]"


#------ Fancy PWD display function:
# Taken from http://wiki.archlinux.org/index.php/c_Bash_Prompt and modified.
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=23
function bash_prompt_command {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=23
    # Indicate that there has been dir truncation
    local trunc_symbol="..." # unicode not working here
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    SHORT_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#SHORT_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        SHORT_PWD=${SHORT_PWD:$pwdoffset:$pwdmaxlen}
        SHORT_PWD=${trunc_symbol}/${SHORT_PWD#*/}
    fi

    if git rev-parse --git-dir >/dev/null 2>&1
    then
        local git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
        if git diff --quiet 2>/dev/null >&2
        then
            export GIT_BRANCH_OK=${git_branch}✓
            export GIT_BRANCH_DIRTY=""
        else
            export GIT_BRANCH_OK=""
            export GIT_BRANCH_DIRTY=${git_branch}✗
        fi
        export GIT_BRACKET_OPEN="["
        export GIT_BRACKET_CLOSE="]"
    else
        export GIT_BRANCH_OK=""
        export GIT_BRANCH_DIRTY=""
        export GIT_BRANCH=""
        export GIT_BRACKET_OPEN=""
        export GIT_BRACKET_CLOSE=""

    fi
}


#----- redefine prompt
# This will be executed and update the SHORT_PWD, GIT_BRANCH on each
# prompt display
PROMPT_COMMAND="bash_prompt_command"


#------ A function to manually rename a console window to the given string.
# If called without arguments, the prompt $PS1_default is used for the title.
# Note: KDE actually appeds " Shell No. X" to the title set and when you rename
# a tab manually in the Konsole (KDE app), the name given by konsolename is prepended
# to the value set via Konsoles "rename" function.
# Note, in order to have vertain vars evauated each time anew, we escape the
# $-sign:
function konsolename {
if [ $# -eq 0 ] ; then
    # If there are no arguments, we reset the PS1, and so the title to the default.
    if [ $DISPLAY ] ; then
        export PS1="$c_gray\t $c_green\u$c_reset@$c_cyan\h:$c_em_blue\${SHORT_PWD}\
${c_reset}\${GIT_BRACKET_OPEN}${c_green}\${GIT_BRANCH_OK}${c_red}\${GIT_BRANCH_DIRTY}${c_reset}\${GIT_BRACKET_CLOSE}\
${c_green} ❯ ${c_reset}\[\033]0;@\h:\${SHORT_PWD}\007\]"
    else
        export PS1="$c_gray\t $c_green\u$c_reset@$c_cyan\h:$c_em_blue\${SHORT_PWD}\
${c_reset}\${GIT_BRACKET_OPEN}${c_green}\${GIT_BRANCH_OK}${c_red}\${GIT_BRANCH_DIRTY}${c_reset}\${GIT_BRACKET_CLOSE}\
${c_green} ❯ ${c_reset}"
    fi
else
    # Note, here the double quotes (") are needed to have $1 expanded immediately
    # and we also need to escape the dollar-sign in front of "(bash_prompt_command)"
    # in order to have it evaluated later on.
    if [ $DISPLAY ] ; then
        export PS1="$c_gray\t $c_green\u$c_reset@$c_cyan\h:$c_em_blue\${SHORT_PWD}\
${c_reset}\${GIT_BRACKET_OPEN}${c_green}\${GIT_BRANCH_OK}${c_red}\${GIT_BRANCH_DIRTY}${c_reset}\${GIT_BRACKET_CLOSE}\
${c_green} ❯ ${c_reset}\[\033]0;@\h: $* \007\]"
    else
        export PS1="$c_gray\t $c_green\u$c_reset@$c_cyan\h:$c_em_blue\${SHORT_PWD}\
${c_reset}\${GIT_BRACKET_OPEN}${c_green}\${GIT_BRANCH_OK}${c_red}\${GIT_BRANCH_DIRTY}${c_reset}\${GIT_BRACKET_CLOSE}\
($*) ${c_green} ❯ ${c_reset}"
    fi
fi
}

#------ Set the inital prompt.
konsolename


#----- pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
} &&
complete -o default -F _pip_completion pip
# pip bash completion end

