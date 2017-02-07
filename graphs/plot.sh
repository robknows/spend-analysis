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
./makebarcharts.ijs graphdata/avg_spending_by_day_of_week.txt graphdata/avg_number_of_spends_by_day_of_week.txt graphdata/avg_spent_per_spend_by_day_of_week.txt graphdata/avg_daily_spend_by_month.txt
