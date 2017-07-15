# Q spend analysis with graphing in J

## Making it work
### Tables
New spending data is always inserted into the shoptrip table. The
dayspend table creates it's data from the shoptrip table.

To make a new shoptrip table, just delete the current one and create your own
in it's place. The dayspend table is built entirely from the data of the
shoptrip table. Following from this, all new data is entered in the shoptrip
table. Days with no spending are entered as having amount 0f and the keyword
tag in none.

To insert new data, run `./enterData`. Example of me using it:

```
rob@rob-Lenovo-Z50-75:~/Documents/spend-analysis$ ./enterData.sh 
b = step back, f = step forward, s = submit now

Enter amount(s), whose current value is -
14.63 2.8
Enter date(s), whose current value is -
2017.07.15
Enter class(es), whose current value is -
`eatingout`alcohol
Enter tag(s), whose current value is -
`imogen`
#!/home/rob/q/l32/q
shoptrip: value`:tables/shoptrip
`shoptrip insert (amount:14.63 2.8f;date:2017.07.15;class:`eatingout`alcohol;tag:`imogen`)
save `:tables/shoptrip
exit 0
Do you want to continue? (s = show generated q file again, y = yes, n = no).y
KDB+ 3.4 2016.12.08 Copyright (C) 1993-2016 Kx Systems
l32/ 4()core 6906MB rob rob-lenovo-z50-75 127.0.1.1 NONEXPIRE  

Welcome to kdb+ 32bit edition
For support please see http://groups.google.com/d/forum/personal-kdbplus
Tutorials can be found at http://code.kx.com/wiki/Tutorials
To exit, type \\
To remove this startup msg, edit q.q
777 778
`:tables/shoptrip
KDB+ 3.4 2016.12.08 Copyright (C) 1993-2016 Kx Systems
l32/ 4()core 6906MB rob rob-lenovo-z50-75 127.0.1.1 NONEXPIRE  

Welcome to kdb+ 32bit edition
For support please see http://groups.google.com/d/forum/personal-kdbplus
Tutorials can be found at http://code.kx.com/wiki/Tutorials
To exit, type \\
To remove this startup msg, edit q.q
`:tables/dayspend
rob@rob-Lenovo-Z50-75:~/Documents/spend-analysis$
```


### Graphs
You can draw single line plots, single bar charts, single pie charts or double line plots.

You control the graph data from inside saveplotdata.q, while the selection of
graph is handled within plot.sh

First you create a table. The name you give the saved table = the title of the graph.
You can also name the x and y axes by changing the names of the column names in
your table definition. The 1st column is the x axis and the 2nd is the y axis.

After configuring the graphs you want drawn, run plot.sh and the pdfs will be created.
