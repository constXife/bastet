#!/bin/bash

cd /home/elf/elf-updater/dist/current/
app_root=$(pwd)

reel_pidfile="$app_root/tmp/pids/reel.pid"

function get_reel_pid
{
  local pid=$(cat $reel_pidfile)
  if [ -z $pid ] ; then
    echo "Could not find a PID in $reel_pidfile"
    exit 1
  fi
  reel_pid=$pid
}

function start
{
	mkdir -p $(dirname "$reel_pidfile")
	./bin/reel-rack > /dev/null 2>&1 & echo $! > $reel_pidfile
}

function stop
{
	get_reel_pid
	echo "kill $reel_pid"
	kill -HUP $reel_pid
}

function restart
{
	stop
	start
}

case "$1" in
	start)
	start
	;;
	stop)
	stop
	;;
	restart)
	restart
	;;
	*)
	echo "Usage: $0 {start|stop|restart}"
	;;
esac
