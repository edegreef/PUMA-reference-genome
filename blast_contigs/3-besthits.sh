#combining all the best_hit outputs into one with select columns
awk 'FNR == 1 { print FILENAME, $3, $11, $14, $15, $16, $17, $18, $19, $20, $21 }' *_bestHits > allbesthits.txt

#searching for anything that is not Eukaryota for contamination
grep -v Eukaryota allbesthits.txt > contaminants.txt
