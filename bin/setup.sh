#!/bin/sh

BASEDIR=$(dirname $0)
echo "Installing Elf System"

cd $BASEDIR/..
BUNDLE_GEMFILE=$BASEDIR/../Gemfile bundle install --quiet --deployment
BUNDLE_GEMFILE=$BASEDIR/../Gemfile bundle exec rake assets:precompile
