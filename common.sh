# Common things for all my shells (beware not to add this)

#----- Homebrew
if [[ "${PATH}" =~ "/homebrew/bin" ]]
then
    # Adding this in front because zprezto adds /usr/local/bin upfront and I
    # really want /homebrew/bin upfront when e.g. `brew sh`.
    PATH="/homebrew/bin:/homebrew/sbin:$PATH"
else
    # I have my production Homebrew at /usr/_local so that my testing Homebrew
    # whih lives at /homebrew does not accidently find stuff in /usr/local.
    PATH="/usr/_local/bin:/usr/_local/sbin:/opt/X11/bin:/usr/texbin:/$HOME/bin:$PATH"
    MANPATH="/usr/_local/share/man:/usr/local/share/man:$MANPATH"
fi


#----- Manpath (Some things deep in Xcode)
MANPATH="/Applications/Xcode.app/Contents/Developer/usr/share/man:$MANPATH"
MANPATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man:$MANPATH"

#----- Make find useful
function findall {
    find . -name "$*"
}

#----- Nice path plotter. Call pp $PATH or pp $PYTHONPATH
function pp {
    # Sed cannot insert newlines, but tr can. So we insert a
    # ☺ and then replace it by \n
    echo $* | tr ":" "\n" |  sed "s/ -/☺-/g" | tr "☺" "\n"
}


#----- Remove multiple Git remote branches at once. I stole this from Mike.
git_remove_remote_branches() {
    REMOTE="$1"
    for BRANCH in "$@"
    do
        [ "$BRANCH" = "$REMOTE" ] && continue
        git push "$REMOTE" ":$BRANCH"
    done
}
alias grrb="git_remove_remote_branches"


#----- l - I am so used to it.
alias l='ls'
alias la='ls -la'

#----- Set a language, so tools don't start to shout at me in German
export LANG=en_US.UTF-8
unset LC_CTYPE  # to avoid perl warnings

#----- IPython
alias ipythonw="ipython -wthread"
alias pycon2='ipython qtconsole --pylab=inline --pprint --editor=subl'
alias pycon='ipython3 qtconsole --pylab=inline --pprint --editor=subl'


#----- Sublime editor
export VISUAL="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
export EDITOR="/usr/_local/bin/vim"
alias edit="$VISUAL -w -n"
alias subl=$VISUAL


#----- Virtualenv (separate python environments)
export VIRTUALENVWRAPPER_PYTHON=/usr/_local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/_local/bin/virtualenv-3.3
export WORKON_HOME=$HOME/Dropbox/__settings__/virtualenvs
export VIRTUALENV_USE_DISTRIBUTE=true
if [ -f /usr/_local/bin/virtualenvwrapper.sh ]; then
    source /usr/_local/bin/virtualenvwrapper.sh
fi


export MANPATH
export PATH
