#!/home/rob/q/l32/q

shoptrip: value`:../tables/shoptrip

stringifyKws: {sv[","] string shoptrip[`keywords] x}

kws:stringifyKws each til count shoptrip
ds: exec date from shoptrip
ams: exec amount from shoptrip

prepped: ([] amount:ams; date:ds; keywords:kws)

save `:prepped.txt

\\
