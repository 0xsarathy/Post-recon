#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./postrecon.sh subdomains.txt"
  exit 1
fi

INPUT=$1
OUT="output/$(date +%s)"
mkdir -p $OUT

echo "[+] Checking live hosts"
cat $INPUT | httpx -silent > $OUT/live.txt

echo "[+] Collecting URLs"
cat $OUT/live.txt | gau > $OUT/urls.txt
cat $OUT/live.txt | waybackurls >> $OUT/urls.txt
katana -list $OUT/live.txt -silent >> $OUT/urls.txt

sort -u $OUT/urls.txt -o $OUT/urls.txt

echo "[+] Discovering parameters"
arjun -i $OUT/live.txt -oT $OUT/params.txt

echo "[+] Running nuclei (critical, high, medium)"
nuclei -l $OUT/live.txt -severity critical,high,medium -o $OUT/nuclei.txt

echo "[+] PostRecon completed!"
echo "[+] Results saved in $OUT"
