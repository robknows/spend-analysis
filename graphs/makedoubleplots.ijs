#!/usr/bin/ijconsole
require 'plot'

files =: 2}.ARGV

readfile =: 1!:1
astwos =: ,&2@:(-:@:#) $ ]

xcol =: i.&TAB {. ]
ycol =: (>:@:i.&TAB) }. (i.&' ' {. ])
parsenum =: 0&".@:(i.&' ' {. ])
fn =: ((>:@:i.&'/') }. (i.&'.' {. ]))@:>
lns =: ] ;. _2
onhead =: @:(0&{)
ontail =: @:(1&}.)
parsetail =: parsenum ontail

makewindow =: 3 : 0
  pd 'reset'
  pd 'visible 0'
)

makelabels =: 3 : 0
  NB. Generalised axis labels
  pd 'xcaption days_since_oct_1_2016'
  pd 'ycaption associated_expenditure(£)'
)

makeplot =: 3 : 0
  lines =: y
  xs =: parsetail xcol"1 lines
  ys =: parsetail ycol"1 lines  
  pd 'type line'
  pd xs;ys  
)

exportaspdf =: 3 : 0
  filename =: y
  pd 'title ',filename
  pd 'pdf pdfs/',filename,'.pdf'
)

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
  makelabels''

  pd 'keycolor blue,red'
  makekey filenameA,',',filenameB
  pd 'color blue'
  makeplot filedataA
  pd 'color red'  
  makeplot filedataB
  exportaspdf filenameA,'_vs_',filenameB
)

createpdf"1 (astwos files)

exit''
