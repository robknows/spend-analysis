#!/home/rob/q/l32/q

/
format:
shoptrip (amount, date, class, tag)
dayspend (date, total, numberofspends)
\

/
class:
==NOURISHMENT==
eatingout
food
snack
milk
==CONVENIENCE==
bike
devices
gym
laundry
medicine
stationary
toiletries
travel
tool
admin
==LUXURY==
alcohol
book
donation
clothes
gift
holiday
social
furnishing
==NONE==
none
\

/ 
tag:
charity
idiocy
imogen
\ 

shoptrip: value`:tables/shoptrip

dayspend: ([] 
  date:exec distinct date from shoptrip; 
  total:value exec sum amount by date from shoptrip; 
  numberofspends:value exec count amount by date from shoptrip)

save `:tables/dayspend

\\
