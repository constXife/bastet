#!/bin/sh

echo "Installing Elf System"

SCRIPTPATH=$( cd $(dirname $0) ; cd .. ; pwd -P )

if [ -d "$SCRIPTPATH/vendor" ]; then
    bundle install --deployment \
                   --binstubs \
                   --path=$SCRIPTPATH \
                   --gemfile=$SCRIPTPATH/Gemfile \
                   --without=development test \
                   --local
else
    bundle install --deployment \
                   --binstubs \
                   --path=$SCRIPTPATH \
                   --gemfile=$SCRIPTPATH/Gemfile \
                   --without=development test
fi
