#!/bin/bash
LOG=monitoramento.log
NUM_REPETICOES=10

# O atop INICIA antes de tudo
for i in $(seq 1 $NUM_REPETICOES); do
        echo "Iniciando repetição $i..."
        atop -M 5 1000 > $i$LOG &
        pid=$!
        jason cognitiveAgentBenchWithJasonARGO.mas2j
        kill $pid
        # O atop ENCERRA só depois que tudo acabou
        echo 'Gerando os relatórios em CSV'
        egrep '^MEM' $i$LOG > $i_memoria.csv
        egrep '^CPU' $i$LOG > $i_cpu.csv
        egrep '^SWP' $i$LOG > $i_swap.csv
        egrep '^DSK' $i$LOG > $i_disco.csv
done


