#!/bin/sh
CWD=`pwd`
WIKI2TEX="tclkit wiki2tex.kit"
echo " ------------ Kopiowanie plików --------------"
cd wikiszj
for i in *txt; do
    cp ${i} ../
done

cd ..
rm wiki.txt
rm start.txt

echo " ------------ Konwersja ------------"
for i in *txt; do
    ${WIKI2TEX} ${i}
    rm $i
done

echo " ----- Gotowe --------"

# EOF
