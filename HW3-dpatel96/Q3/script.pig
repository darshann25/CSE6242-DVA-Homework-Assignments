trigrams = LOAD 's3://cse6242-2019spring-trigrams-small/*' USING PigStorage(‘\t’) AS (trigram:chararray, year:int, occurrences:float, books:float);

t1 = FILTER trigrams BY occurrences >= 400 AND books >= 15;

t2 = GROUP t1 BY trigram;
t3 = FOREACH t2 GENERATE group AS trigram, (SUM(t1.occurrences) / SUM(t1.books)) AS occ_per_book;
t4 = ORDER t3 BY occ_per_book DESC, trigram ASC;