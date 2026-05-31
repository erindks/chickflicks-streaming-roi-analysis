-- create summary table
CREATE TABLE summary AS
SELECT
	'Netflix' AS platform,
	count(*) AS 'number of titles',
	count(*)/(SELECT monthly_price FROM prices WHERE platform = 'Netflix') AS 'number of titles per $'
FROM chick_flicks_titles cft
INNER JOIN netflix_titles nt
	ON cft.name = nt.title
UNION ALL

SELECT
	'Amazon Prime' AS platform,
	count(*) as 'number of titles',
	count(*)/(SELECT monthly_price FROM prices WHERE platform = 'Amazon Prime') AS 'number of titles per $'
FROM chick_flicks_titles cft
INNER JOIN amazon_prime_titles apt
	ON cft.name = apt.title
UNION ALL

SELECT
	'Disney Plus' AS platform,
	count(*) as 'number of titles',
	count(*)/(SELECT monthly_price FROM prices WHERE platform = 'Disney Plus') AS 'number of titles per $'
FROM chick_flicks_titles cft
INNER JOIN disney_plus_titles dpt
	ON cft.name = dpt.title
UNION ALL

SELECT
	'Hulu' AS platform,
	count(*) as 'number of titles',
	count(*)/(SELECT monthly_price FROM prices WHERE platform = 'Hulu') AS 'number of titles per $'
FROM chick_flicks_titles cft
INNER JOIN hulu_titles ht
	ON cft.name = ht.title;

INSERT INTO summary (platform, "number of titles", "number of titles per $")
SELECT 
    'Disney Hulu Bundle',
    (SELECT "number of titles" FROM summary WHERE platform = 'Disney Plus')+
    (SELECT "number of titles" FROM summary WHERE platform = 'Hulu'),
    ((SELECT "number of titles" FROM summary WHERE platform = 'Disney Plus')+
    (SELECT "number of titles" FROM summary WHERE platform = 'Hulu')) / 12.99;