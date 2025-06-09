#!/bin/bash

echo "------------------------"
echo "Server Stats"
echo "------------------------"

top -bn1 | grep "Cpu(s)" | awk '{usage=100-$8; printf "Cpu usage: %.2f%%\n",usage}'

echo "--------------------------"

free -m | awk 'NR==2 {
	total=$2; used=$3; free=$4;
	printf "Total: %d MB\nUsed: %d MB\nFree: %d MB\n", total,used,free;
	printf "Memory Usage: %.2f%%\n", (used/total)*100
}' 
echo "---------------------------"

df -h | awk 'NR==2 {
printf "Total: %s\nUsed: %s\nAvailable: %s\nUsage: %s\n0", $2, $3, $4, $5
}'

echo "-----------------------------"
echo "Top 5 processes wrt CPU"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

echo "------------------------------"
echo "Top 6 processes wrt memory"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
