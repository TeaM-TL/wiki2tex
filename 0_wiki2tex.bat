@echo off
SET W2T=wiki2tex
SET SOURCE=wikiszj
echo --- Kopiowanie
copy %SOURCE%\1_polityka.txt
copy %SOURCE%\2_prezentacja.txt
copy %SOURCE%\3_zakres_szj.txt
copy %SOURCE%\4_szj.txt
copy %SOURCE%\5_odpowiedzialnosc.txt
copy %SOURCE%\6_zarzadzania_zasobami.txt
copy %SOURCE%\7_realizacja_wyrobu.txt
copy %SOURCE%\8_pomiary.txt
copy %SOURCE%\9_wykazy.txt
copy %SOURCE%\instrukcja_formularzy.txt
copy %SOURCE%\p-4.2.3_01.txt
copy %SOURCE%\p-4.2.4_01.txt
copy %SOURCE%\p-8.2.2_01.txt
copy %SOURCE%\p-8.3_01.txt
copy %SOURCE%\p-8.5.2-2.txt
copy %SOURCE%\p_7.2_01.txt

echo --- konwersja
echo on
%W2T% 1_polityka.txt
%W2T% 2_prezentacja.txt
%W2T% 3_zakres_szj.txt
%W2T% 4_szj.txt
%W2T% 5_odpowiedzialnosc.txt
%W2T% 6_zarzadzania_zasobami.txt
%W2T% 7_realizacja_wyrobu.txt
%W2T% 8_pomiary.txt
%W2T% 9_wykazy.txt
%W2T% instrukcja_formularzy.txt
%W2T% p-4.2.3_01.txt
%W2T% p-4.2.4_01.txt
%W2T% p-8.2.2_01.txt
%W2T% p-8.3_01.txt
%W2T% p-8.5.2-2.txt
%W2T% p_7.2_01.txt

@echo off
echo --- usuwanie 
del 1_polityka.txt
del 2_prezentacja.txt
del 3_zakres_szj.txt
del 4_szj.txt
del 5_odpowiedzialnosc.txt
del 6_zarzadzania_zasobami.txt
del 7_realizacja_wyrobu.txt
del 8_pomiary.txt
del 9_wykazy.txt
del instrukcja_formularzy.txt
del p-4.2.3_01.txt
del p-4.2.4_01.txt
del p-8.2.2_01.txt
del p-8.3_01.txt
del p-8.5.2-2.txt
del p_7.2_01.txt
@pause
