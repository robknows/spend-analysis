#!/home/rob/q/l32/q

dayspend: value `:../tables/dayspend

daycount: exec date from dayspend - 2016.10.01
totals: exec total from dayspend

p05_exp_weighted_moving_avg_daily_spending: ([] days_since_oct_1_2016:daycount;ewma:ema[.05;totals])
save `:graphdata/p05_exp_weighted_moving_avg_daily_spending.txt

p1_exp_weighted_moving_avg_daily_spending: ([] days_since_oct_1_2016:daycount;ewma:ema[.1;totals])
save `:graphdata/p1_exp_weighted_moving_avg_daily_spending.txt

p33_exp_weighted_moving_avg_daily_spending: ([] days_since_oct_1_2016:daycount;ewma:ema[.33;totals])
save `:graphdata/p33_exp_weighted_moving_avg_daily_spending.txt

moving_avg_daily_spending: ([] days_since_oct_1_2016:daycount;moving_avg:mavg[count totals;totals])
save `:graphdata/moving_avg_daily_spending.txt

daily_spending: ([] days_since_oct_1_2016: daycount;day_spending:totals)
save `:graphdata/daily_spending.txt

\\
