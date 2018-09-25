#!/bin/bash

# QPS_LISTY = {10000}

WRK=../../wrk2_openloop/wrk2/wrk

mkdir -p ../logs/nginx_load_balencer  

for RUN in {1..5}; do 
  mkdir -p ../logs/nginx_load_balencer/run_$RUN  
  for QPS in {10000..45000..5000}; do
    $WRK -d 60 -c 200 -t 10 -L http://localhost:8100 -R $QPS > ../logs/nginx_load_balencer/run_$RUN/QPS$QPS.txt;
  done
done