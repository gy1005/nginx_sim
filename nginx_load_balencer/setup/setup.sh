#!/bin/bash

CPU_LIST=(11,13,15,17 1 3 5 7)

for i in {0..4}; do
  docker stop nginx_$i;
  docker rm nginx_$i;
done

for i in {0..4}; do
  docker run -d --net=host --cpuset-cpus=${CPU_LIST[$i]} -v $PWD/../conf/nginx_$i.conf:/etc/nginx/nginx.conf --name=nginx_$i nginx;
done