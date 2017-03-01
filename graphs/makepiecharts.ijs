#!/usr/bin/ijconsole
require 'plot'
require 'trig'

load 'jplotlib.ijs'

NB. STR remove CHAR
remove =: I.~ # [

NB. STR replace CHAR;REPLACEMENTCHAR
replace =: ((>@:(1&{)@:])`(I.@:([ e. >@:(0&{)@:]))`[)}

NB. y = filedata
slicesizes =: 3 : 0
  parsetail ycol"1 y
)

NB. y = filedata
slicelabels =: 3 : 0
  xcolelems =: xcol"1 1}.y
  cslabels =: remove&' ' ; ,&','"1 xcolelems
  cslabels replace ',';' '
)

createpdf =: 3 : 0
  boxedfn =: y
  filedata =: lns readfile boxedfn
  
  amounts =: slicesizes filedata
  labels =: slicelabels filedata
  
  makewindow''
  
  pd 'type pie'
  pd 'key ' , labels
  pd amounts
  exportaspdf fn boxedfn
)

createpdf"0 files

exit''
