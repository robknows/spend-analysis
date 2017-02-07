#!/home/rob/q/l32/q

\ Load tables
shoptrip: value `:../tables/shoptrip
dayspend: value `:../tables/dayspend

\ Functions
classindices: {where x each shoptrip[`class]}
shoptripindices:til count shoptrip
dailyclassspend: {
  classspends:?[shoptripindices in classindices x;exec amount from shoptrip;0f];
  shopdates: -[exec date from shoptrip;2016.10.01];
  value exec sum amount by date from ([] date:shopdates;amount:classspends)}

tagindices: {where x each shoptrip[`tag]}
dailytagspend: {
  tagspends:?[shoptripindices in tagindices x;exec amount from shoptrip;0f];
  shopdates: -[exec date from shoptrip;2016.10.01];
  value exec sum amount by date from ([] date:shopdates;amount:tagspends)}

dayofweeknum: {6 7 1 2 3 4 5 x mod 7}

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
  amount_spent_on_food: dailyclassspend {`food in x})
save `:graphdata/food_spend_per_day.txt

p05_exp_weighted_moving_avg_daily_food_spending: ([]
  days_since_oct_1_2016:daycount;
  ewma:ema[.05;dailyclassspend {`food in x}])
save `:graphdata/p05_exp_weighted_moving_avg_daily_food_spending.txt

moving_avg_food_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  mavg_amount_spent_on_food: mavg[count dcs; dcs:dailyclassspend {`food in x}])
save `:graphdata/moving_avg_food_spend_per_day.txt

travel_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_travel: dailyclassspend {`travel in x})
save `:graphdata/travel_spend_per_day.txt

p1_exp_weighted_moving_avg_daily_travel_spending: ([]
  days_since_oct_1_2016:daycount;
  ewma:ema[.1;dailyclassspend {`travel in x}])
save `:graphdata/p1_exp_weighted_moving_avg_daily_travel_spending.txt

gym_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_gym: dailyclassspend {`gym in x})
save `:graphdata/gym_spend_per_day.txt

milk_spend_per_milk_shop: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_shops_including_milk: dailyclassspend {`milk in x})
save `:graphdata/milk_spend_per_milk_shop.txt

eatingout_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_eatingout: dailyclassspend {`eatingout in x})
save `:graphdata/eatingout_spend_per_day.txt

gift_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_gift: dailyclassspend {`gift in x})
save `:graphdata/gift_spend_per_day.txt

imogen_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_tiny_girl: dailytagspend {`imogen in x})
save `:graphdata/imogen_spend_per_day.txt

spending_by_day_of_week:
  select expenditure: sum total by day from
    select day: dayofweeknum date,total from dayspend
save `:graphdata/spending_by_day_of_week.txt

avg_number_of_spends_by_day_of_week:
  select avg_number_of_spends: avg numberofspends by day from
    select day: dayofweeknum date,numberofspends from dayspend
save `:graphdata/avg_number_of_spends_by_day_of_week.txt

total_spending: ([]
  days_since_oct_1_2016: daycount;
  moving_total: exec (+\) total from dayspend)
save `:graphdata/total_spending.txt

\\
