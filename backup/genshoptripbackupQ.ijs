#!/usr/bin/ijconsole

boxedfn =: 2{ARGV
readfile =: 1!:1
writefile =: 1!:2

rawtxt =: readfile boxedfn
lines =: (] ;. _2) rawtxt

droplastsemicolon =: ' '&(([`( >./@:I.@:e.&';'@:])`])})
replace =: ((>@:(1&{)@:])`(I.@:([ e. >@:(0&{)@:]))`[)}
taketofirst =: i. {. [
headcol =: i.&(9{a.) {. ]
tailcols =: >:@:i.&(9{a.) }. ]
NB. x=A string with columns seperated by tabs
NB. y=number of the column you want
col =: 4 : '(taketofirst&'' '') headcol tailcols^:y x'

NB. x=A stringified table whose columns are seperated by tabs on each row
NB. y=number of the column you want
tablecol =: 4 : '(col&y)"1 x'

annotatefloat =: 'f'&([`(i.&' '@:])`]})
amountheader =: (0{lines) col 0
amountdata =: droplastsemicolon@:, (,&';'@:annotatefloat@:((>:@:i.&' ') {. ]))"1 ((1}.lines) tablecol 0)

dateheader =: (0{lines) col 1
datedata =: , ((,&' ')@:replace&('-';'.'))"1 ((1}.lines) tablecol 1)

keywordsheader =: (0{lines) col 2
enlists =: (('(enlist `')&,@:replace&(',';'`')@:,&' ')"1 ((1}.lines) tablecol 2)
addclosingparen =: 3 : ''')'' ((8 + i.&'' ''@:(8&}.)) y)} y'
allenlists =: (addclosingparen @: {&enlists)"0 i.(# enlists)
multiplekws =: >&1@:(+/@:e.)&'`'
multiplekwenlists =: (I. multiplekws"1 allenlists) { allenlists
amendedmultkwenlists =: ('('&,@:(8&}.))"1 multiplekwenlists

NB. UGLY HACK
counter =: 0
NB. x=allenlists
singleamend =: 3 : 0
  index =: counter { (I. multiplekws"1 y)
  amendment =: (counter { amendedmultkwenlists) , '       '
  counter =: counter + 1
  amendment (index}) y
)
NB. Clarify state
counter =: 0

finalenlists =: singleamend^:(# amendedmultkwenlists) allenlists
NB. Fuck that was tough
keywordsdata =: droplastsemicolon@:, ((,&';')"1 finalenlists)

NB. x = column name
NB. y = semi-colon seperated column items
itemsdeclaration =: 4 : 'x,''_items: ('', y ,'')'''

hashbang =: '#!/home/rob/q/l32/q'

NB. Issue with trailing ; after last entry
amountdec =: amountheader itemsdeclaration amountdata

datedec =: dateheader itemsdeclaration datedata

NB. Issue with trailing ; after last entry
keywordsdec =: keywordsheader itemsdeclaration keywordsdata

makedump =: 'backupshoptrip: ([] amount:amount_items ; date:date_items ; keywords:keywords_items)'
savedump =: 'save `:backupshoptrip'
exitcommand =: '\\'

dumpfilecontent =: hashbang,LF,amountdec,LF,datedec,LF,keywordsdec,LF,makedump,LF,savedump,LF,exitcommand
dumpfilecontent writefile (<'/home/rob/Documents/spend_analysis/backup/makeshoptripbackup.q')

exit''
