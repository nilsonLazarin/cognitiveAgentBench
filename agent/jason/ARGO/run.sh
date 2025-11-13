#!/bin/bash
LOG=monitoramento.log
NUM_REPETICOES=10

# O atop INICIA antes de tudo
atop -M 5 1000 > $LOG &
pid=$!

for i in $(seq 1 $NUM_REPETICOES); do
        echo "Iniciando repetição $i..."
        jason cognitiveAgentBenchWithJasonARGO.mas2j
        sleep 7
done

# O atop ENCERRA só depois que tudo acabou
kill $pid

echo 'Gerando os relatórios em CSV'
egrep '^MEM' $LOG > memoria.csv
egrep '^CPU' $LOG > cpu.csv
egrep '^SWP' $LOG > swap.csv
egrep '^DSK' $LOG > disco.csv

