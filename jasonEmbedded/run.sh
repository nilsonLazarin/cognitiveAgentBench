#!/bin/bash
#./rung.sh folder round
FOLDER=$1
i=$2
LOG=monitor.log

mkdir -p $FOLDER

echo "Starting round  $i..."
atop -M 5 1000 > $FOLDER/$LOG$i &
pid=$!
jasonEmbedded cognitiveAgentBenchWithJasonARGO.mas2j >> $FOLDER/run_$i.log 2>>$FOLDER/run_$i.log
kill $pid
# O atop ENCERRA só depois que tudo acabou
echo 'Report in CSV'
egrep '^MEM' $FOLDER/$LOG$i | grep -v "shmem" > $FOLDER/mem_$i.csv
egrep '^CPU' $FOLDER/$LOG$i > $FOLDER/cpu_$i.csv
echo "Done!"
