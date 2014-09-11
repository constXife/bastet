#!/bin/sh

echo "Installing Elf System"

SCRIPTPATH=$( cd $(dirname $0) ; cd .. ; pwd -P )

cd $SCRIPTPATH

if [ "$RACK_ENV" = "production" ]
then
    bundle install --deployment --binstubs
else
    bundle install --binstubs
fi

bin/rake assets:precompile
