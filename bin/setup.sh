#!/bin/sh

echo "Installing Elf System"

SCRIPTPATH=$( cd $(dirname $0) ; cd .. ; pwd -P )

bundle install --deployment \
               --binstubs \
               --path=$SCRIPTPATH \
               --gemfile=$SCRIPTPATH/Gemfile \
               --without=development test
