#!/usr/bin/ijconsole
require 'plot'

files =: 2}.ARGV

readfile =: 1!:1

xcol =: i.&TAB {. ]
ycol =: (>:@:i.&TAB) }. (i.&' ' {. ])

parsenum =: 0&".@:(i.&' ' {. ])
  
createpdf =: 3 : 0
  txtfile =: y
  filename =: ((>:@:i.&'/') }. (i.&'.' {. ])) (>txtfile)

  rawtxt =: readfile txtfile
  lines =: (] ;. _2) rawtxt

  xlabel =: xcol 0{lines
  ylabel =: ycol 0{lines

  xs =: parsenum 1}.xcol"1 lines
  ys =: parsenum 1}.ycol"1 lines

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
