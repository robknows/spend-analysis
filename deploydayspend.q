#!/home/rob/q/l32/q

/
format:
shoptrip (amount, date, class, tag)
dayspend (date, total, numberofspends)
\

/
class:
alcohol
bike
book
donation
clothes
devices
eatingout
food
gift
gym
holiday
laundry
medicine
milk
none
snacks
stationary
toiletries
travel
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
