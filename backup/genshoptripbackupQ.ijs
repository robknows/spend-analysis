#!/usr/bin/ijconsole

boxedfn =: 2{ARGV
readfile =: 1!:1
writefile =: 1!:2

rawtxt =: readfile boxedfn
lines =: (] ;. _2) rawtxt
headers =: 0{lines
data =: 1}.lines

remove =: I.@:-.@:e. { [
taketofirst =: i. {. [
headcol =: i.&(9{a.) {. ]
tailcols =: >:@:i.&(9{a.) }. ]

NB. x=A string with columns seperated by tabs
NB. y=number of the column you want
col =: 4 : '(taketofirst&'' '') headcol tailcols^:y x'

NB. x=A stringified table whose columns are seperated by tabs on each row
NB. y=number of the column you want
tablecol =: 4 : '(col&y)"1 x'

annotatefloat =: ('f'&([`(i.&' '@:])`]}))@:(,&' ')
droplastsemicolon =: ' '&(([`( >./@:I.@:e.&';'@:])`])})
amountheader =: headers col 0
amountdata =: (droplastsemicolon@:, (,&';'@:annotatefloat)"1 (data tablecol 0)) remove ' '

replace =: ((>@:(1&{)@:])`(I.@:([ e. >@:(0&{)@:]))`[)}
dateheader =: headers col 1
datedata =: , ((,&' ')@:replace&('-';'.'))"1 (data tablecol 1)

classheader =: headers col 2
classdata =: (, ('`'&,)"1 data tablecol 2) remove ' '

parseemptysymbols =: ('`'&,)`('`'"1)@.(*./@:('empty '&=@:(6&{.)))
tagheader =: headers col 3
tagdata =: (, parseemptysymbols"1 data tablecol 3) remove ' '

NB. x = column name
NB. y = semi-colon seperated column items
itemsdeclaration =: 4 : 'x,''_items: ('', y ,'')'''

hashbang =: '#!/home/ubuntu/q/l32/q'
amountdec =: amountheader itemsdeclaration amountdata
datedec =: dateheader itemsdeclaration datedata
classdec =: classheader itemsdeclaration classdata
tagdec =: tagheader itemsdeclaration tagdata

columndefs =: amountdec,LF,datedec,LF,classdec,LF,tagdec

tabledef =: 'shoptripbackup: ([] amount:amount_items ; date:date_items ; class:class_items ; tag:tag_items)'
savetable =: 'save `:shoptripbackup'
exitcommand =: '\\'

content =: hashbang,LF,columndefs,LF,tabledef,LF,savetable,LF,exitcommand
content writefile (<'/home/rob/spend-analysis/backup/makeshoptripbackup.q')

exit''
