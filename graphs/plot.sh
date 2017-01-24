#!/bin/bash
./saveplotdata.q
singleplotdata=`ls singleplotdata/*.txt`
./makesingleplots.ijs $singleplotdata
