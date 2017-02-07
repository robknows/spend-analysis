#!/bin/bash
# Update data
./saveplotdata.q

# Single plot all data by default.
# Plots meant for bar charts are overwritten by it later on.
graphdata=`ls graphdata/*.txt`
./makesingleplots.ijs $graphdata

# Selected double plots
./makedoubleplots.ijs graphdata/travel_spend_per_day.txt graphdata/gym_spend_per_day.txt graphdata/eatingout_spend_per_day.txt graphdata/imogen_spend_per_day.txt

# Selected bar charts
./makebarcharts.ijs graphdata/spending_by_day_of_week.txt
