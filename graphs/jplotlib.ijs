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

makelabels =: 4 : 0
  pd 'xcaption ' , x
  pd 'ycaption ' , y
)

NB. y = data lines - rank 2.
makeplot =: 3 : 0
  xs =: parsetail xcol"1 y
  ys =: parsetail ycol"1 y
  pd xs;ys
)

NB. y = filename
exportaspdf =: 3 : 0
  pd 'title ' , y
  pd 'pdf pdfs/', y ,'.pdf'
)
