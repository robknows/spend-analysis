#!/bin/bash

cd dataEntry/
./enterData.py
mv insertShoptrips.q ../insertShoptrips.q
cd ..
cat insertShoptrips.q
while true; do
  read -p "Do you want to continue? (s = show generated q file again, y = yes, n = no)." yn
    case $yn in
      [Yy]* ) chmod +x insertShoptrips.q; ./insertShoptrips.q; ./deploydayspend.q; break;;
      [Nn]* ) break;;
      [Ss]* ) cat insertShoptrips.q;;
      * ) echo "Answer y, n or s";;
  esac
done
rm -f insertShoptrips.q
exit 0
