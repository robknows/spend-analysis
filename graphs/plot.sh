#!/bin/bash
# Update data
./saveplotdata.q

# Single plot all the data
graphdata=`ls graphdata/*.txt`
./makesingleplots.ijs $graphdata

# Double plot only selected ones
./makedoubleplots.ijs graphdata/travel_spend_per_day.txt graphdata/gym_spend_per_day.txt

