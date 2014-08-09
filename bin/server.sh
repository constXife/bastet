#!/bin/sh

BASEDIR=$(dirname $0)
echo "Run Elf System"

cd $BASEDIR/..
BUNDLE_GEMFILE=$BASEDIR/../Gemfile bundle exec pumactl -F config/puma.rb $1