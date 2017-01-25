#!/bin/bash
./feeddbtoJ.q
./genshoptripbackupQ.ijs prepped.txt
chmod +x makeshoptripbackup.q
./makeshoptripbackup.q

# Clean up
rm -f prepped.txt
