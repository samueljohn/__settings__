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
    PATH="/usr/_local/bin:/usr/_local/sbin:/anaconda/bin:/opt/X11/bin:/usr/texbin:$HOME/bin:/sbin:$PATH"
    MANPATH="/usr/_local/share/man:/usr/local/share/man:$MANPATH"
fi


#----- Manpath (Some things deep in Xcode)
MANPATH="/Applications/Xcode.app/Contents/Developer/usr/share/man:$MANPATH"
MANPATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man:$MANPATH"

#----- Make find useful
function findall {
    find . -name "$*"
}

#----- I can't remember how to update locate
alias update-locate='sudo /usr/libexec/locate.updatedb'

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
export LANG="en_US.UTF-8"
export LC_TYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


#----- Sublime editor
export VISUAL="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
export EDITOR="/usr/_local/bin/vim"
alias edit="$VISUAL -w -n"
alias subl=$VISUAL


#----- Mono stuff
if command -v brew >/dev/null 2>&1; then
    export MONO_GAC_PREFIX="$(brew --prefix)"
fi

export MANPATH
export PATH
