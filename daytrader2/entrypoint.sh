#!/bin/bash
set -m

function clean_up {
	echo 
	/wlp/bin/server stop Daytrader3Sample
	echo WEBSPHERE LIBERTY DAYTRADER APP STOPPED
	exit
}
trap clean_up SIGHUP SIGINT SIGTERM

echo WEBSPHERE LIBERTY DAYTRADER APP STARTING
/wlp/bin/server start Daytrader3Sample 
echo POPULATING DATABASE
curl -I  http://localhost:9137/daytrader/config?action=buildDBTables
curl -I  http://localhost:9137/daytrader/config?action=buildDB
echo WEBSPHERE LIBERTY DAYTRADER APP STARTED

# it seems Docker sends stuff to STDIN during the application lifecycle
# so to create a blocking read, we need this fifo hack

trap 'echo "we get signal"; rm -f ~/fifo' EXIT
mkfifo ~/fifo || exit
chmod 400 ~/fifo
echo "sleeping"
read < ~/fifo

echo WEBSPHERE LIBERTY DAYTRADER APP STOPPING
clean_up
