#!/bin/bash

echo "-----------------------------------------------------------"
echo -e "\033[31mCPU Usage\033[0m"
echo "-----------------------------------------------------------"
echo -e "\033[32mus - user    : time running un-niced user processes
sy - system  : time running kernel processes
ni - nice    : time running niced user processes
id - idle    : time spent in the kernel idle handler
wa - IO-wait : time waiting for I/O completion
          hi : time spent servicing hardware interrupts
          si : time spent servicing software interrupts
          st : time stolen from this vm by the hypervisor\033[0m"

echo -e "\033[33m$(top -b -n 1 | grep 'Cpu')\033[0m"
echo "-----------------------------------------------------------"


echo -e "\033[31mMemory Usage\033[0m"
echo "-----------------------------------------------------------"
echo -e "\033[32mToal Memory: $(top -b -n 1 | grep "MiB Mem" | awk '{print $4}')\033[0m"
echo -e "\033[32mUsed Memory: $(top -b -n 1 | grep "MiB Mem" | awk '{print $8}')\033[0m"
echo -e "\033[32mAvailable Memory: $(top -b -n 1 | grep "avail Mem" | awk '{print $9}')\033[0m"
total_memory=$(top -b -n 1 | grep "MiB Mem" | awk '{print $4 + 0}')
used_memory=$(top -b -n 1 | grep "MiB Mem" | awk '{print $8 + 0}')
free_memory=$(top -b -n 1 | grep "avail Mem" | awk '{print $9 + 0}')

used_memory_percentage=$(echo "scale=4; ($used_memory/$total_memory)*100" | bc)
free_memory_percentage=$(echo "scale=4; ($free_memory/$total_memory)*100" | bc)

printf "\033[33mUsed Memory Percentage: %.2f %%\033[0m\n" "$used_memory_percentage"
printf "\033[33mAvailable Memory Percentage: %.2f %%\033[0m\n" "$free_memory_percentage"
echo "-----------------------------------------------------------"

echo -e "\033[31mDisk Usage\033[0m"
echo "-----------------------------------------------------------"
echo -e "\033[32mFile System\033[0m \033[34m Available %\033[0m  \033[31mUse %\033[0m"
df -h | while IFS= read -r line; do
  awk '{print "\033[32m" $1, "\033[34m" ($4/$2)*100"%", "\033[31m" $5}'
done
echo -e "\033[0m-----------------------------------------------------------"

echo -e "\033[31mTop 5 Processes by CPU usage\033[0m"

echo "-----------------------------------------------------------"
top -b -n 1 -o %CPU | grep "%CPU" -A 5
echo "-----------------------------------------------------------"
echo -e "\033[31mTop 5 Processes by Memory usage\033[0m"
echo "-----------------------------------------------------------"
top -b -n 1 -o %MEM | grep "%MEM" -A 5
echo "-----------------------------------------------------------"
echo -e "\033[31mOS Version\033[0m"
echo "-----------------------------------------------------------"
cat /etc/os-release | grep "VERSION="
echo "-----------------------------------------------------------"
echo -e "\033[31mLogged in Users\033[m"
echo "-----------------------------------------------------------"
who
echo "-----------------------------------------------------------"
