#!/home/ubuntu/q/l32/q

shoptrip: value`:../tables/shoptrip

ams: shoptrip[`amount]
ds: shoptrip[`date]
cs: shoptrip[`class]
ts: `empty^shoptrip[`tag]

prepped: ([] amount:ams; date:ds; class:cs; tag:ts)

save `:prepped.txt;

\\
