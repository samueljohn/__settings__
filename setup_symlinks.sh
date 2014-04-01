#!/bin/sh

settings_dir=$(pwd)

ln -s "${settings_dir}/zshrc.zsh" "${HOME}/.zshrc"
ln -s "${settings_dir}/bashrc.sh" "${HOME}/.bashrc"
ln -s "${settings_dir}/profile.sh" "${HOME}/.profile"
ln -s "${settings_dir}/common.sh" "${HOME}/.common"
ln -s "${settings_dir}/vimrc" "${HOME}/.vimrc"

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
cd "${HOME}/.zprezto"
git pull && git submodule update --init --recursive
cd $settings_dir

