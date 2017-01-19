#!/home/rob/q/l32/q

\ Load tables
shoptrip: value `:../tables/shoptrip
dayspend: value `:../tables/dayspend

\ Applies a filter function, x, and gets the relevant indices
categoryindices: {where x each shoptrip[`keywords]}

\ Constants
daycount: exec date from dayspend - 2016.10.01
totals: exec total from dayspend

\ TEST
indexedshoptrips:til count shoptrip
foodindices: categoryindices {`food in x}
foodspends:?[indexedshoptrips in foodindices;exec amount from shoptrip;0f]
shopdates: -[exec date from shoptrip;2016.10.01]
daily_food_spend:value exec sum amount by date from ([] date:shopdates;amount:foodspends)

\ Data entries
p05_exp_weighted_moving_avg_daily_spending: ([]
  days_since_oct_1_2016:daycount;
  ewma:ema[.05;totals])
save `:graphdata/p05_exp_weighted_moving_avg_daily_spending.txt

p1_exp_weighted_moving_avg_daily_spending: ([]
  days_since_oct_1_2016:daycount;
  ewma:ema[.1;totals])
save `:graphdata/p1_exp_weighted_moving_avg_daily_spending.txt

p33_exp_weighted_moving_avg_daily_spending: ([]
  days_since_oct_1_2016:daycount;
  ewma:ema[.33;totals])
save `:graphdata/p33_exp_weighted_moving_avg_daily_spending.txt

moving_avg_daily_spending: ([]
  days_since_oct_1_2016:daycount;
  moving_avg:mavg[count totals;totals])
save `:graphdata/moving_avg_daily_spending.txt

daily_spending: ([]
  days_since_oct_1_2016: daycount;
  day_spending:totals)
save `:graphdata/daily_spending.txt

food_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_food: daily_food_spend)
save `:graphdata/food_spend_per_day.txt

\\
