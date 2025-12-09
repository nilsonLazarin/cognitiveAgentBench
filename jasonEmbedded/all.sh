#!/bin/bash
cp src/agt/1D.asl src/agt/alice.asl
./run.sh 1D
cp src/agt/2D.asl src/agt/alice.asl
./run.sh 2D
cp src/agt/4D.asl src/agt/alice.asl
./run.sh 4D
cp src/agt/8D.asl src/agt/alice.asl
./run.sh 8D

