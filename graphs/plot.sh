#!/bin/bash
./saveplotdata.q
graphdata=`ls graphdata/*.txt`
./creategraphpdf.ijs $graphdata
