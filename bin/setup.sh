#!/bin/sh

echo "Installing Elf System"

SCRIPTPATH=$( cd $(dirname $0) ; cd .. ; pwd -P )

cd $SCRIPTPATH

bundle install --deployment --binstubs
bin/rake assets:precompile
