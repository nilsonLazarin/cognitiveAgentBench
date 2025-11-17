#!/bin/bash
LOG=monitor.log
NUM=10

for i in $(seq 1 $NUM); do
        echo "Starting round  $i..."
        atop -M 5 1000 > $i$LOG &
        pid=$!
        jasonEmbedded cognitiveAgentBenchWithJasonARGO.mas2j
        kill $pid
        # O atop ENCERRA só depois que tudo acabou
        echo 'Report in CSV'
        egrep '^MEM' $i$LOG > $i_mem.csv
        egrep '^CPU' $i$LOG > $i_cpu.csv
        egrep '^SWP' $i$LOG > $i_swap.csv
        egrep '^DSK' $i$LOG > $i_disc.csv
        sleep 10
done


