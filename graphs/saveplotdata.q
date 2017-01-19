#!/home/rob/q/l32/q

\ Load tables
shoptrip: value `:../tables/shoptrip
dayspend: value `:../tables/dayspend

\ Applies a filter function, x and gets the relevant shoptrips
categoryspends: {shoptrip[where x each shoptrip[`keywords]]}

\ Constants
daycount: exec date from dayspend - 2016.10.01
totals: exec total from dayspend
foodspends: categoryspends {`food in x}

\ Data entries
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

food_spend_per_tripday: ([] days_since_oct_1_2016:-[exec distinct date from foodspends;2016.10.01];spend_amount:value exec sum amount by date from foodspends)
save `:graphdata/food_spend_per_tripday.txt

moving_avg_food_spend_per_tripday: ([] days_since_oct_1_2016:-[exec distinct date from foodspends;2016.10.01];mavg_spend_amount:mavg[count spends;spends:value exec sum amount by date from foodspends])
save `:graphdata/moving_avg_food_spend_per_tripday.txt

\\
