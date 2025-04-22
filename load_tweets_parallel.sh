#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time parallel ./load_denormalized.sh {} ::: $files

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time parallel python3 -u load_tweets.py --db=postgresql://postgres:pass@localhost:6002/ --input={} ::: $files

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time parallel python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:6003/ --input={} ::: $files
