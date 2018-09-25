#!/bin/bash

# QPS_LISTY = {10000}

WRK=../../wrk2_openloop/wrk2/wrk

mkdir -p ../logs/  

for RUN in {1..5}; do 
  mkdir -p ../logs/run_$RUN  
  for QPS in {1000..10000..500}; do
    $WRK -d 60 -c 200 -t 10 -L http://localhost:8100 -R $QPS > ../logs/run_$RUN/QPS$QPS.txt;
  done
done