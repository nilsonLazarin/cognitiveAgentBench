#! /bin/bash
TEST=$1

echo "JACAMO"
cd jacamo
./run.sh $TEST

echo "JASON"
cd ../jason
./run.sh $TEST

echo "JasonEmbedded"
cd ../jasonEmbedded
./run.sh $TEST
cd ..

echo FIM!