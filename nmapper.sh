#!/bin/bash

echo 'Starting first round of NMAP'
#gathering ports
nmap -T4 $1 > nmap_results.txt
cat nmap_results.txt | grep '/tcp' > nmap_results2.txt
sed -i 's/\/tcp.*//' nmap_results2.txt
echo 'Ports found:'
cat nmap_results2.txt

#formatting the output to use it in the next round
tr '\n' ',' < nmap_results2.txt > ports.txt
sed -i 's/.$//' ports.txt
nmap -T4 -p`cat ports.txt` -A $1
rm nmap_results.txt nmap_results2.txt ports.txt
