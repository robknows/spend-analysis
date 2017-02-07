#!/usr/bin/ijconsole
require 'plot'

load 'jplotlib.ijs'

as_twos =: ,&2@:(-:@:#) $ ]

makekey =: 3 : 0
  pd 'key ',y
  pd 'keystyle marker'
  pd 'keymarkers line,line'
)

createpdf =: 3 : 0
  NB. This will improve
  boxedfnA =: 0{y
  filedataA =: lns readfile boxedfnA
  filenameA =: fn boxedfnA
  
  boxedfnB =: 1{y
  filedataB =: lns readfile boxedfnB
  filenameB =: fn boxedfnB
  
  makewindow''
  
  xlabel =: 'days_since_oct_1_2016'
  ylabel =: 'associated_expenditure(£)'
  xlabel makelabels ylabel

  pd 'keycolor blue,red'
  makekey filenameA,',',filenameB
  pd 'color blue'
  makeplot filedataA
  pd 'color red'
  makeplot filedataB
  exportaspdf filenameA,'_vs_',filenameB
)

createpdf"1 (as_twos files)

exit''
