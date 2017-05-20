shoptrip: value`:tables/shoptrip
dayspend: value`:tables/dayspend

day_one: 2016.10.01
n_weeks: -1 + "i" $ .143 * .z.D - day_one
/ cs = A list of classes
weeklyclassspend: {{[cs;d] exec sum amount from shoptrip where date>=d,date<d+7,class in cs}[x] each (+[7]\)[n_weeks;day_one]}

classindices: {where x each shoptrip[`class]}
shoptripindices:til count shoptrip
dailyclassspend: {
  classspends:?[shoptripindices in classindices x;exec amount from shoptrip;0f];
  shopdates: -[exec date from shoptrip;day_one];
  value exec sum amount by date from ([] date:shopdates;amount:classspends)}

tagindices: {where x each shoptrip[`tag]}
dailytagspend: {
  tagspends:?[shoptripindices in tagindices x;exec amount from shoptrip;0f];
  shopdates: -[exec date from shoptrip;day_one];
  value exec sum amount by date from ([] date:shopdates;amount:tagspends)}

/ x is integer version of a date
dayofweeknum: {6 7 1 2 3 4 5 x mod 7}

/ x is a date
monthnum: {1 + ("i"$`month$x) mod 12}

daycount: exec date from dayspend - 2016.10.01
totals: exec total from dayspend

/ round[.5] x rounds all values of x to the nearest .5
round: {x*"j"$y%x}
