#!/usr/bin/env bash

echo "initializing submodules"
git submodule init
git submodule update

echo "Deleting the old files"
rm ~/.bashrc
rm ~/.bash_prompt
rm ~/.gitconfig
rm ~/.gitignore
rm ~/.githelpers
rm ~/bin
rm ~/.inputrc

echo "Symlinking files"
ln -s `pwd`/bashrc ~/.bashrc
ln -s `pwd`/bash_prompt ~/.bash_prompt
ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/gitignore ~/.gitignore
ln -s `pwd`/githelpers ~/.githelpers
ln -s `pwd`/bin ~/
ln -s `pwd`/inputrc ~/.inputrc

echo "Updating submodules"
git submodule foreach git pull origin master --recurse-submodules

echo "All done."

