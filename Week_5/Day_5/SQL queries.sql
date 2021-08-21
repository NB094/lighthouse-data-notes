SELECT * FROM flights
WHERE (fl_date BETWEEN '2019-01-01' AND '2019-12-31')
order by RANDOM() limit 300000;