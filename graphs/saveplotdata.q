#!/home/rob/q/l32/q

\ Load tables
shoptrip: value `:../tables/shoptrip
dayspend: value `:../tables/dayspend

\ Functions

categoryindices: {where x each shoptrip[`keywords]}
shoptripindices:til count shoptrip
dailycategoryspend: {
  categoryspends:?[shoptripindices in categoryindices x;exec amount from shoptrip;0f];
  shopdates: -[exec date from shoptrip;2016.10.01];
  value exec sum amount by date from ([] date:shopdates;amount:categoryspends)}

\ Constants
daycount: exec date from dayspend - 2016.10.01
totals: exec total from dayspend

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
  amount_spent_on_food: dailycategoryspend {`food in x})
save `:graphdata/food_spend_per_day.txt

moving_avg_food_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  mavg_amount_spent_on_food: mavg[count dcs; dcs:dailycategoryspend {`food in x}])
save `:graphdata/moving_avg_food_spend_per_day.txt

imogen_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_food: dailycategoryspend {`imogen in x})
save `:graphdata/imogen_spend_per_day.txt

travel_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_food: dailycategoryspend {`travel in x})
save `:graphdata/travel_spend_per_day.txt

\\
