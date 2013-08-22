# Common things for all my shells

#----- Homebrew
if [[ ${PATH} =~ "/homebrew/bin" ]]; then
    #echo "Homebrew at /homebrew, so not adding /usr/_local/bin to PATH"
    PATH="/homebrew/bin:/homebrew/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/X11/bin:/usr/texbin:$PATH"
else
    # I have my production Homebrew at /usr/_local so that my testing Homebrew
    # that lives at /homebrew does not accidently find stuff in /usr/local.
    PATH="/usr/_local/bin:/usr/_local/sbin:/opt/X11/bin:/usr/texbin:$PATH"
    MANPATH="/usr/_local/share/man:/usr/local/share/man:$MANPATH"
fi

#----- Manpath (Some things deep in Xcode)
MANPATH="/Applications/Xcode.app/Contents/Developer/usr/share/man:$MANPATH"
MANPATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man:$MANPATH"

#----- Fix grep (make it recursive)
function grepall {
    grep -r "$*" .
}

#----- Make find useful
function findall {
    find . -name "$*"
}

#----- Nice path plotter. Call pp $PATH or pp $PYTHONPATH
function pp {
    # This is magic. sed cannot insert newlines, but tr can. So we insert a
    # ☺ and then replace it by \n
    echo $* | tr ":" "\n" |  sed "s/ -/☺-/g" | tr "☺" "\n"
}

#----- l - I am so used to it.
alias l='ls'
alias la='ls -la'

#----- IPython
alias ipythonw="ipython -wthread"
alias pycon='ipython qtconsole --pylab=inline --pprint --editor=subl'
alias pycon3='ipython3 qtconsole --pylab=inline --pprint --editor=subl'

#----- Sublime editor
export VISUAL="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
export EDITOR="/usr/_local/bin/vim"
alias edit="$VISUAL -w -n"
alias subl=$VISUAL

#----- Virtualenv (separate python environments)
export VIRTUALENVWRAPPER_PYTHON=/usr/_local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/_local/bin/virtualenv3
export WORKON_HOME=$HOME/Dropbox/__settings__/virtualenvs
export VIRTUALENV_USE_DISTRIBUTE=true
if [ -f /usr/_local/bin/virtualenvwrapper.sh ]; then
    source /usr/_local/bin/virtualenvwrapper.sh
fi

export LANG='en_US.UTF-8'
export MANPATH
export PATH
