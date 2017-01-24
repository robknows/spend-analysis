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
save `:singleplotdata/p05_exp_weighted_moving_avg_daily_spending.txt

p1_exp_weighted_moving_avg_daily_spending: ([]
  days_since_oct_1_2016:daycount;
  ewma:ema[.1;totals])
save `:singleplotdata/p1_exp_weighted_moving_avg_daily_spending.txt

p33_exp_weighted_moving_avg_daily_spending: ([]
  days_since_oct_1_2016:daycount;
  ewma:ema[.33;totals])
save `:singleplotdata/p33_exp_weighted_moving_avg_daily_spending.txt

moving_avg_daily_spending: ([]
  days_since_oct_1_2016:daycount;
  moving_avg:mavg[count totals;totals])
save `:singleplotdata/moving_avg_daily_spending.txt

daily_spending: ([]
  days_since_oct_1_2016: daycount;
  day_spending:totals)
save `:singleplotdata/daily_spending.txt

food_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_food: dailycategoryspend {`food in x})
save `:singleplotdata/food_spend_per_day.txt

p05_exp_weighted_moving_avg_daily_food_spending: ([]
  days_since_oct_1_2016:daycount;
  ewma:ema[.05;dailycategoryspend {`food in x}])
save `:singleplotdata/p05_exp_weighted_moving_avg_daily_food_spending.txt

moving_avg_food_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  mavg_amount_spent_on_food: mavg[count dcs; dcs:dailycategoryspend {`food in x}])
save `:singleplotdata/moving_avg_food_spend_per_day.txt

imogen_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_tiny_girl: dailycategoryspend {`imogen in x})
save `:singleplotdata/imogen_spend_per_day.txt

travel_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_travel: dailycategoryspend {`travel in x})
save `:singleplotdata/travel_spend_per_day.txt

p1_exp_weighted_moving_avg_daily_travel_spending: ([]
  days_since_oct_1_2016:daycount;
  ewma:ema[.1;dailycategoryspend {`travel in x}])
save `:singleplotdata/p1_exp_weighted_moving_avg_daily_travel_spending.txt

gym_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_gym: dailycategoryspend {`gym in x})
save `:singleplotdata/gym_spend_per_day.txt

milk_spend_per_milk_shop: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_shops_including_milk: dailycategoryspend {`milk in x})
save `:singleplotdata/milk_spend_per_milk_shop.txt

eatingout_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_eatingout: dailycategoryspend {`eatingout in x})
save `:singleplotdata/eatingout_spend_per_day.txt

gift_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  amount_spent_on_gift: dailycategoryspend {`gift in x})
save `:singleplotdata/gift_spend_per_day.txt

\\
