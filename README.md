# Q DATA ANALYSIS WITH INTERPRETATION IN J

## SPENDING
Go into the /spending directory
Open the q repl
Check that there is a binary file called "shoptrip"
Enter "\l deploydayspend.q"
Check that a binary file called "dayspend" was created in tables/
Check that the two databases are ok in tables/

New spending data is always inserted into the `shoptrip table. The
dayspend table creates it's data from the shoptrip table.

To insert new data, in the q REPL, run:

`shoptrip insert (amount: 1 2 3 ... ;date: 2017.01.18 2017.01.19 ... ;keywords:(enlist `keyword1`keyword2),(enlist `x`y) ... )
`:tables/shoptrip set shoptrip \ Depending on which dir you opened q from
\l deploydayspend.q

### Graphs

At the moment the only graphs you can create are plots for a set of x values against a set of y values.

You control the graph from inside saveplotdata.q

First you create a table. The name you give the saved table = the title of the graph.
You can also name the x and y axes by changing the names of the column names in
your table definition. The 1st column is the x axis and the 2nd is the y axis.

After configuring the graphs you want drawn, run plot.sh and the pdfs will be created.
