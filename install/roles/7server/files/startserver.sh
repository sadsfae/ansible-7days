#!/bin/sh
cd "`dirname "$0"`"

PARAMS=$@

CONFIGFILE=
while test $# -gt 0
do
	if [ `echo $1 | cut -c 1-12` = "-configfile=" ]; then
		CONFIGFILE=`echo $1 | cut -c 13-`
	fi
	shift
done

if [ "$CONFIGFILE" = "" ]; then
	echo "No config file specified. Call this script like this:"
	echo "  ./startserver.sh -configfile=serverconfig.xml"
	exit
else
	if [ -f "$CONFIGFILE" ]; then
		echo Using config file: $CONFIGFILE
	else
		echo "Specified config file $CONFIGFILE does not exist."
		exit
	fi
fi

export LD_LIBRARY_PATH=.
#export MALLOC_CHECK_=0

if [ "$(uname -m)" = "x86_64" ]; then
	./7DaysToDieServer.x86_64 -logfile 7DaysToDieServer_Data/output_log__`date +%Y-%m-%d__%H-%M-%S`.txt -quit -batchmode -nographics -dedicated $PARAMS
else
	./7DaysToDieServer.x86 -logfile 7DaysToDieServer_Data/output_log__`date +%Y-%m-%d__%H-%M-%S`.txt -quit -batchmode -nographics -dedicated $PARAMS
fi

