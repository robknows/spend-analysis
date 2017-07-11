#!/usr/bin/python3

fields = ["amount(s)", "date(s)", "class(es)", "tag(s)"]
data = ["-", "-", "-", "-"]

print("b = step back, f = step forward, s = submit now\n")

nFields = len(fields)
i = 0

while (i < nFields):
  prompt = ("Enter " +  fields[i] + ", whose current value is " + data[i] + "\n")
  s = input(prompt)
  if (s == "b"):
    i -= 1
  elif (s == "f"):
    i += 1
  elif (s == "s"):
    i = nFields
  else:
    data[i] = s
    i += 1

shoptrip = "`shoptrip insert (amount:"+ data[0] +"f;date:"+ data[1] +";class:"+ data[2] +";tag:"+ data[3] +")"

f = open("insertShoptrips.q", "w")
print("#!/home/rob/q/l32/q", file=f)
print("shoptrip: value`:tables/shoptrip", file=f)
print(shoptrip, file=f)
print("save `:tables/shoptrip", file=f)
print("exit 0", file=f)
f.close()
exit(0)
