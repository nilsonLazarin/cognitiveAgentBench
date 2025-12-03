#!/bin/bash
FOLDER=$1
LOG=monitor.log
NUM=10

mkdir -p $FOLDER

for i in $(seq 1 $NUM); do
        echo "Starting round  $i..."
        atop -M 5 1000 > $FOLDER/$LOG$i &
        pid=$!
        jacamo cognitiveAgentBenchWithJaCaMoARGO.jcm  >> $FOLDER/run.log 2>>$FOLDER/run.log
        kill $pid
        # O atop ENCERRA só depois que tudo acabou
        echo 'Report in CSV'
        egrep '^MEM' $FOLDER/$LOG$i | grep -v "shmem" > $FOLDER/mem_$i.csv
        egrep '^CPU' $FOLDER/$LOG$i > $FOLDER/cpu_$i.csv
        egrep '^SWP' $FOLDER/$LOG$i > $FOLDER/swap_$i.csv
        sleep 10
done

echo "Done!"
