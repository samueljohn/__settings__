#!/bin/sh

settings_dir=$(pwd)

ln -s "${settings_dir}/zshrc.zsh" "${HOME}/.zshrc"
ln -s "${settings_dir}/bashrc.sh" "${HOME}/.bashrc"
ln -s "${settings_dir}/profile.sh" "${HOME}/.profile"
ln -s "${settings_dir}/common.sh" "${HOME}/.common"
ln -s "${settings_dir}/vimrc" "${HOME}/.vimrc"


# Todo:
# git clone zprezto
# git pull zprezto (g stash before!)
# git submodule update
# link zprezto runcoms
#
...