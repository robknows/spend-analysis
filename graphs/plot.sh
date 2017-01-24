#!/bin/bash
# Update data
./saveplotdata.q

# Single plot all of it
graphdata=`ls graphdata/*.txt`
./makesingleplots.ijs $graphdata

# Double plot selected ones
./makedoubleplots.ijs graphdata/travel_spend_per_day.txt graphdata/gym_spend_per_day.txt

