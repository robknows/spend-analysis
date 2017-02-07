#!/usr/bin/ijconsole
require 'plot'

load 'jplotlib.ijs'

createpdf =: 3 : 0
  boxedfn =: y
  filedata =: lns readfile boxedfn
  
  makewindow''
  
  xlabel =: xcol onhead filedata
  ylabel =: ycol onhead filedata
  xlabel makelabels ylabel
  
  pd 'type bar'
  makeplot filedata
  exportaspdf fn boxedfn
)

createpdf"0 files

exit''
