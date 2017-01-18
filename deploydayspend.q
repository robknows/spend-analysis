\ format:
\ shoptrip (amount, date, keywords)

\ keywords:
\ imogen, gym, food, eatingout, snacks, milk, travel, holiday, bike, devices, gift, toiletries, laundry, stationary, idiocy, medicine, book, alcohol, clothes

shoptrip: value`:tables/shoptrip

dayspend: ([] 
  date:exec distinct date from shoptrip; 
  total:value exec sum amount by date from shoptrip; 
  numberofspends:value exec count amount by date from shoptrip)

save `:tables/dayspend
