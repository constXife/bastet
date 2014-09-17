#!/bin/sh

echo "Installing Elf System"

SCRIPTPATH=$( cd $(dirname $0) ; cd .. ; pwd -P )

if [ -d "$SCRIPTPATH/vendor" ]; then
    CMD="bundle install --deployment \
                   --binstubs \
                   --path=$SCRIPTPATH \
                   --gemfile=$SCRIPTPATH/Gemfile \
                   --without=development test \
                   --local"
else
    CMD="bundle install --deployment \
                   --binstubs \
                   --path=$SCRIPTPATH \
                   --gemfile=$SCRIPTPATH/Gemfile \
                   --without=development test"
fi

echo $CMD
$CMD
