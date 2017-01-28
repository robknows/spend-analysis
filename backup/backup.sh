#!/bin/bash
./feeddbtoJ.q
./genshoptripbackupQ.ijs prepped.txt
chmod +x makeshoptripbackup.q

# Uncomment to make shoptrip binary
# ./makeshoptripbackup.q

# Clean up
rm -f prepped.txt
