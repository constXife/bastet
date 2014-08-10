#!/bin/sh

echo "Run Elf System"

SCRIPTPATH=$( cd $(dirname $0) ; cd .. ; pwd -P )

cd $SCRIPTPATH

bin/pumactl -F config/puma.rb $1
