#!/bin/bash
for i in $(seq 1 10); do
date +"%H:%M:%S"
ps -ef | wc -l
#sleep 5
done
cat /proc/cpuinfo > cpu_info.txt
cat /etc/os-release | grep "^NAME=" > os_info.txt
cat /etc/os-release | grep "^NAME=" | awk -F'=' '{print $2}' | tr -d '"' > os_name.txt
for i in $(seq 50 100); do
touch "${i}.txt"
done
