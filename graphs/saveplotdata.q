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

\ x is integer version of a date
dayofweeknum: {6 7 1 2 3 4 5 x mod 7}

\ x is a date
monthnum: {1 + ("i"$`month$x) mod 12}

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

avg_spending_by_day_of_week:
  select avg_expenditure: avg total by day from
    select day: dayofweeknum date,total from dayspend
save `:graphdata/avg_spending_by_day_of_week.txt

avg_number_of_spends_by_day_of_week:
  select avg_number_of_spends: avg numberofspends by day from
    select day: dayofweeknum date,numberofspends from dayspend
save `:graphdata/avg_number_of_spends_by_day_of_week.txt

avg_spent_per_spend_by_day_of_week:
  select avg_spent_per_spend: avg[total % numberofspends] by day from
    select day: dayofweeknum date,total,numberofspends from dayspend
save `:graphdata/avg_spent_per_spend_by_day_of_week.txt

moving_total_spending: ([]
  days_since_oct_1_2016: daycount;
  moving_total: exec (+\) total from dayspend)
save `:graphdata/moving_total_spending.txt

avg_daily_spend_by_month: select avg total by month_number from select month_number:monthnum date,total from dayspend;
empty_months: (1 + til 12) except exec month_number from avg_daily_spend_by_month;
avg_daily_spend_by_month: 0!avg_daily_spend_by_month;
`avg_daily_spend_by_month insert (month_number: empty_months; total: 0f);
avg_daily_spend_by_month: asc avg_daily_spend_by_month;
save `:graphdata/avg_daily_spend_by_month.txt

spending_by_class: desc (cs#s) upsert ([] class: `other;amount: value sum (cs:9)_s:desc select sum amount by class from shoptrip);
total: exec sum amount from spending_by_class;
spending_by_class: select class:class,amount:amount,proportion:100*amount%total from spending_by_class;
save `:graphdata/spending_by_class.txt

moving_avg_travel_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  mavg_amount_spent_on_travel: mavg[count dcs; dcs:dailyclassspend {`travel in x}])
save `:graphdata/moving_avg_travel_spend_per_day.txt

moving_avg_gym_spend_per_day: ([]
  days_since_oct_1_2016: daycount;
  mavg_amount_spent_on_gym: mavg[count dcs; dcs:dailyclassspend {`gym in x}])
save `:graphdata/moving_avg_gym_spend_per_day.txt

\\
