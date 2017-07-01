.barclays.parseDate:{"D"$string[x](6 7 8 9 5 3 4 2 0 1)}
.barclays.parseMemo:{rtrim 18#string x}

.barclays.readData:{
  raw:("SSSFSS" ; enlist ",") 0: x;
  amendColumnNames:{`amount`date`memo xcol `Amount`Date`Memo xcols x};
  amendColumnNames select .barclays.parseDate each Date,neg Amount,.barclays.parseMemo each Memo from raw where Subcategory=`PAYMENT}
  
.barclays.onDays:{[t;d]`date xasc select from t where date in d}