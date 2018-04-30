#!/bin/bash

#Runs the test suites
echo "Building ..."
./build.sh

MODE="parse"
RES=0
FAIL=0
echo
echo
echo "------------Test for mode: "$MODE "--------------------"

for DIR_NAME in tests/*
do
    OUTPUT=$(./run.sh $MODE $DIR_NAME 2>&1)
    STATUS=${PIPESTATUS[0]}
    if [[ $OUTPUT != "OK" || $STATUS != 0 ]]
    then
        FAIL=$((FAIL+1))
        echo $DIR_NAME" -> "$OUTPUT
    else
        RES=$((RES+1))
        echo $DIR_NAME" -> "$OUTPUT
    fi

done
echo "----------------Test Ended---------------------------"
echo "Result "$MODE": "$RES" passes, "$FAIL" fail"
echo "----------------Test Ended---------------------------"
