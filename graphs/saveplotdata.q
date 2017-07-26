#!/home/rob/q/l32/q

// Load tables

shoptrip: value `:../tables/shoptrip
dayspend: value `:../tables/dayspend

// Constants

day_one: 2016.10.01
n_weeks: -1 + "i" $ .143 * .z.D - day_one

// Functions

classindices: {where x each shoptrip[`class]}
shoptripindices:til count shoptrip
dailyclassspend: {
  classspends:?[shoptripindices in classindices x;exec amount from shoptrip;0f];
  shopdates: -[exec date from shoptrip;day_one];
  value exec sum amount by date from ([] date:shopdates;amount:classspends)}
round: {x*"j"$y%x}

tagindices: {where x each shoptrip[`tag]}
dailytagspend: {
  tagspends:?[shoptripindices in tagindices x;exec amount from shoptrip;0f];
  shopdates: -[exec date from shoptrip;day_one];
  value exec sum amount by date from ([] date:shopdates;amount:tagspends)}

weeklyclassspend: {{[c;d] exec sum amount from shoptrip where date>=d,date<d+7,class=c}[x] each (+[7]\)[n_weeks;day_one]}

// x is integer version of a date
dayofweeknum: {6 7 1 2 3 4 5 x mod 7}

// x is a date
monthnum: {1 + ("i"$`month$x) mod 12}

// Values

daycount: exec date from dayspend - 2016.10.01
totals: exec total from dayspend

dailyalleatingspend:raze exec sum each amount from dayspend lj `date xgroup select from shoptrip where class in `food`snack`eatingout;
dailyfoodspend:dailyclassspend {`food in x}
dailytravelspend:dailyclassspend {`travel in x}
dailygymspend:dailyclassspend {`gym in x}
dailyeatingoutspend:dailyclassspend {`eatingout in x}
dailymilkspend:dailyclassspend {`milk in x}
dailyimogenspend:dailytagspend {`imogen in x}

// ===== DATA SAVED BELOW =====

// Raw per day amounts

raw_per_day_spending:{[values;graphname]
  graphname set ([]
      days_since_oct_1_2016:daycount;
      spent:values);
  graphname save filename:hsym `$"graphdata/",string[graphname],".txt";
  filename}

raw_per_day_spending[totals;`daily_spending]
raw_per_day_spending[dailyfoodspend;`daily_food_spending]
raw_per_day_spending[dailytravelspend;`daily_travel_spending]
raw_per_day_spending[dailygymspend;`daily_gym_spending]
raw_per_day_spending[dailymilkspend;`daily_milk_spending]
raw_per_day_spending[dailyeatingoutspend;`daily_eatingout_spending]
raw_per_day_spending[dailyclassspend {`gift in x};`daily_gift_spending]
raw_per_day_spending[dailyimogenspend;`daily_imogen_spending]

// Whole period daily moving averages

daily_moving_avg:{[values;graphname]
  graphname set ([]
      days_since_oct_1_2016:daycount;
      moving_avg:mavg[count values;values]);
  graphname save filename:hsym `$"graphdata/",string[graphname],".txt";
  filename}

daily_moving_avg[totals;`moving_avg_daily_spending]
daily_moving_avg[dailyfoodspend;`moving_avg_food_spend_per_day]
daily_moving_avg[dailytravelspend;`moving_avg_travel_spend_per_day]
daily_moving_avg[dailygymspend;`moving_avg_gym_spend_per_day]
daily_moving_avg[dailyalleatingspend;`moving_avg_all_eating_spending]

// Whole period weekly moving averages

weekly_moving_avg:{[values;graphname]
  graphname set ([]
      week_number: til count values;
      moving_avg:mavg[count values;values]);
  graphname save filename:hsym `$"graphdata/",string[graphname],".txt";
  filename}

weeklyalleatingspend:exec sum each amount from `weekNum xgroup update weekNum:(date - 2016.10.01) div 7 from select from shoptrip where class in `snack`eatingout`food
weekly_moving_avg[weeklyclassspend `food;`moving_avg_weekly_food_spending]
weekly_moving_avg[weeklyclassspend `eatingout;`moving_avg_weekly_eatingout_spending]
weekly_moving_avg[weeklyalleatingspend;`moving_avg_weekly_all_eating_spending]

// Exponentially weighted moving averages

exp_moving_avg:{[weight;values;graphname]
  graphname set ([]
      days_since_oct_1_2016:daycount;
      ewma:ema[weight;values]);
  graphname save filename:hsym `$"graphdata/",string[graphname],".txt";
  filename}

exp_moving_avg[.05;totals;`p05_exp_weighted_moving_avg_daily_spending]
exp_moving_avg[.1;totals;`p1_exp_weighted_moving_avg_daily_spending]
exp_moving_avg[.33;totals;`p33_exp_weighted_moving_avg_daily_spending]
exp_moving_avg[.05;dailyfoodspend;`p05_exp_weighted_moving_avg_daily_food_spending]
exp_moving_avg[.05;dailytravelspend;`p1_exp_weighted_moving_avg_daily_travel_spending]

// 7-day moving averages

seven_day_moving_avg:{[values;graphname]
  graphname set ([]
      days_since_oct_1_2016:daycount;
      moving_avg:mavg[7;values]);
  graphname save filename:hsym `$"graphdata/",string[graphname],".txt";
  filename}

seven_day_moving_avg[totals;`seven_day_moving_avg_daily_spending]
seven_day_moving_avg[dailyalleatingspend;`seven_day_moving_avg_all_eating_spending]
seven_day_moving_avg[dailytravelspend;`seven_day_moving_avg_daily_travel_spending]

// Bespoke pie/bar charts

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

avg_daily_spend_by_month: select avg total by month_number from select month_number:monthnum date,total from dayspend;
empty_months: (1 + til 12) except exec month_number from avg_daily_spend_by_month;
avg_daily_spend_by_month: 0!avg_daily_spend_by_month;
`avg_daily_spend_by_month insert (month_number: empty_months; total: 0f);
avg_daily_spend_by_month: asc avg_daily_spend_by_month;
save `:graphdata/avg_daily_spend_by_month.txt

spending_by_class: desc (cs#s) upsert ([] class: `other;amount: value sum (cs:11)_s:desc select sum amount by class from shoptrip);
save `:graphdata/spending_by_class.txt

dayspend_distribution: select frequency:count amount by amount from select amount:ceiling total,date,numberofspends from dayspend
save `:graphdata/dayspend_distribution.txt

exit 0
