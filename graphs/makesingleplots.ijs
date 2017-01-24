#!/usr/bin/ijconsole
require 'plot'

files =: 2}.ARGV
readfile =: 1!:1

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
  lines =: y
  xlabel =: xcol onhead lines
  ylabel =: ycol onhead lines
  pd 'xcaption ',xlabel
  pd 'ycaption ',ylabel
)

makeplot =: 3 : 0
  lines =: y
  xs =: parsetail xcol"1 lines
  ys =: parsetail ycol"1 lines  
  pd xs;ys  
)

exportaspdf =: 3 : 0
  txtfile =: y
  filename =: fn txtfile
  pd 'title ',filename
  pd 'pdf pdfs/',filename,'.pdf'
)

createpdf =: 3 : 0
  boxedfn =: y
  filedata =: lns readfile boxedfn
  makewindow''
  makelabels filedata
  makeplot filedata
  exportaspdf boxedfn
)

createpdf"0 files

exit''
