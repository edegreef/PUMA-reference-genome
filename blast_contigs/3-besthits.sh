#combining all the best_hit outputs into one
cat *_bestHits > allbesthits.txt

#searching for anything that is not Eukaryota for contamination
grep -v Eukaryota allbesthits.txt > contaminants.txt
