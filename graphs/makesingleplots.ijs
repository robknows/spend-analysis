#!/usr/bin/ijconsole
require 'plot'

files =: 2}.ARGV
readfile =: 1!:1

xcol =: i.&TAB {. ]
ycol =: (>:@:i.&TAB) }. (i.&' ' {. ])
parsenum =: 0&".@:(i.&' ' {. ])
fn =: ((>:@:i.&'/') }. (i.&'.' {. ]))@:>
ls =: ] ;. _2
onhead =: @:(0&{)
ontail =: @:(1&}.)
parsetail =: parsenum ontail

createpdf =: 3 : 0
  txtfile =: y
  filename =: fn txtfile

  rawtxt =: readfile txtfile
  lines =: ls rawtxt

  xlabel =: xcol onhead lines
  ylabel =: ycol onhead lines
  
  xs =: parsetail xcol"1 lines
  ys =: parsetail ycol"1 lines

  pd 'reset'
  pd 'visible 0'
  pd 'title ',filename
  pd 'xcaption ',xlabel
  pd 'ycaption ',ylabel
  pd xs;ys
  pd 'pdf pdfs/',filename,'.pdf'
)

createpdf"0 files

exit''
