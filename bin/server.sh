#!/bin/sh

echo "Run Elf System"

SCRIPTPATH=$( cd $(dirname $0) ; cd .. ; pwd -P )

cd $SCRIPTPATH

bin/reel-rack config.ru $1
