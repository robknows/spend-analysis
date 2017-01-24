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

To insert new data, in the q REPL, run (replacing the fake data with your actual data of course):
```
`shoptrip insert (amount: 1 2 3 ... ;date: 2017.01.18 2017.01.19 ... ;keywords:(enlist `keyword),(`x;`y) ... )
save `:tables/shoptrip \ Depending on which dir you opened q from
```
Then you need to update the dayspend table by running ./deploydayspend.q

### Graphs
At the moment the only graphs you can create are plots for a set of x values against a set of y values.

You control the graph from inside saveplotdata.q

First you create a table. The name you give the saved table = the title of the graph.
You can also name the x and y axes by changing the names of the column names in
your table definition. The 1st column is the x axis and the 2nd is the y axis.

After configuring the graphs you want drawn, run plot.sh and the pdfs will be created.

At the moment there are graphs for a few exponential weighted moving averages
with different smoothing factors, a normal moving average and a graph simply
showing the expenditure for each day.
