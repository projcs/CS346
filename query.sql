-- Query 1 --
DROP VIEW IF EXISTS view_1_1;
CREATE VIEW view_1_1 AS
SELECT ProductKey, Month, Nation, Quantity FROM Sales
LEFT JOIN Customer ON Customer.CustKey=Sales.CustKey
LEFT JOIN Time ON Sales.TimeKey=Time.TimeKey
WHERE Month>=5 AND Month<=12 AND Year=1994 AND Nation='RUSSIA';

SELECT Month, Mfgr, sum(Quantity) AS 'The units'
FROM Product
RIGHT JOIN view_1_1 v1 ON v1.ProductKey=Product.ProductKey
GROUP BY Month, Mfgr
UNION
SELECT 'total months' AS Month, Mfgr, sum(Quantity)
FROM Product
RIGHT JOIN view_1_1 v1 ON v1.ProductKey=Product.ProductKey
GROUP BY Mfgr
UNION
SELECT 'total months' AS Month, 'Total Mfgr' AS Mfgr, sum(Quantity)
FROM Product
RIGHT JOIN view_1_1 v1 ON v1.ProductKey=Product.ProductKey;

-- output
-- +--------------+----------------+-----------+
-- | Month        | Mfgr           | The units |
-- +--------------+----------------+-----------+
-- | 5            | Manufacturer#1 |     16294 |
-- | 5            | Manufacturer#2 |     15580 |
-- | 5            | Manufacturer#3 |     16639 |
-- | 5            | Manufacturer#4 |     18081 |
-- | 5            | Manufacturer#5 |     17275 |
-- | 6            | Manufacturer#1 |     18102 |
-- | 6            | Manufacturer#2 |     16601 |
-- | 6            | Manufacturer#3 |     16241 |
-- | 6            | Manufacturer#4 |     17284 |
-- | 6            | Manufacturer#5 |     17016 |
-- | 7            | Manufacturer#1 |     16848 |
-- | 7            | Manufacturer#2 |     15225 |
-- | 7            | Manufacturer#3 |     16858 |
-- | 7            | Manufacturer#4 |     16931 |
-- | 7            | Manufacturer#5 |     14575 |
-- | 8            | Manufacturer#1 |     17331 |
-- | 8            | Manufacturer#2 |     17244 |
-- | 8            | Manufacturer#3 |     17325 |
-- | 8            | Manufacturer#4 |     16614 |
-- | 8            | Manufacturer#5 |     17212 |
-- | 9            | Manufacturer#1 |     14837 |
-- | 9            | Manufacturer#2 |     16012 |
-- | 9            | Manufacturer#3 |     16066 |
-- | 9            | Manufacturer#4 |     15314 |
-- | 9            | Manufacturer#5 |     17079 |
-- | 10           | Manufacturer#1 |     16083 |
-- | 10           | Manufacturer#2 |     15440 |
-- | 10           | Manufacturer#3 |     14988 |
-- | 10           | Manufacturer#4 |     14777 |
-- | 10           | Manufacturer#5 |     14730 |
-- | 11           | Manufacturer#1 |     15731 |
-- | 11           | Manufacturer#2 |     16583 |
-- | 11           | Manufacturer#3 |     14552 |
-- | 11           | Manufacturer#4 |     14532 |
-- | 11           | Manufacturer#5 |     15782 |
-- | 12           | Manufacturer#1 |     16390 |
-- | 12           | Manufacturer#2 |     15897 |
-- | 12           | Manufacturer#3 |     15158 |
-- | 12           | Manufacturer#4 |     15554 |
-- | 12           | Manufacturer#5 |     15703 |
-- | total months | Manufacturer#1 |    131616 |
-- | total months | Manufacturer#2 |    128582 |
-- | total months | Manufacturer#3 |    127827 |
-- | total months | Manufacturer#4 |    129087 |
-- | total months | Manufacturer#5 |    129372 |
-- | total months | Total Mfgr     |    646484 |
-- +--------------+----------------+-----------+
-- 46 rows in set (10.62 sec)

-- query 2
DROP VIEW IF EXISTS view_1;
CREATE VIEW view_1 AS
SELECT count(DISTINCT(P.ProductKey)) AS product_num, T.Year,C.Nation
FROM Sales S
LEFT JOIN Product P ON P.ProductKey=S.ProductKey
LEFT JOIN Time T ON T.TimeKey=S.TimeKey
LEFT JOIN Customer C ON C.CustKey=S.CustKey
GROUP BY T.Year,C.Nation ASC;

-- SELECT * FROM view_1;
-- +-------------+------+----------------+
-- | product_num | Year | Nation         |
-- +-------------+------+----------------+
-- |       33265 | 1992 | ALGERIA        |
-- |       32710 | 1992 | ARGENTINA      |
-- |       33241 | 1992 | BRAZIL         |
-- |       33497 | 1992 | CANADA         |
-- |       33738 | 1992 | CHINA          |
-- |       32299 | 1992 | EGYPT          |
-- |       33313 | 1992 | ETHIOPIA       |
-- |       34346 | 1992 | FRANCE         |
-- |       33117 | 1992 | GERMANY        |
-- |       33280 | 1992 | INDIA          |
-- |       34423 | 1992 | INDONESIA      |
-- |       32295 | 1992 | IRAN           |
-- |       32892 | 1992 | IRAQ           |
-- |       32670 | 1992 | JAPAN          |
-- |       33830 | 1992 | JORDAN         |
-- |       32524 | 1992 | KENYA          |
-- |       33039 | 1992 | MOROCCO        |
-- |       34063 | 1992 | MOZAMBIQUE     |
-- |       32794 | 1992 | PERU           |
-- |       33359 | 1992 | ROMANIA        |
-- |       33995 | 1992 | RUSSIA         |
-- |       32243 | 1992 | SAUDI ARABIA   |
-- |       32853 | 1992 | UNITED KINGDOM |
-- |       33180 | 1992 | UNITED STATES  |
-- |       33536 | 1992 | VIETNAM        |
-- |       32933 | 1993 | ALGERIA        |
-- |       32981 | 1993 | ARGENTINA      |
-- |       33548 | 1993 | BRAZIL         |
-- |       34361 | 1993 | CANADA         |
-- |       33473 | 1993 | CHINA          |
-- |       32938 | 1993 | EGYPT          |
-- |       33009 | 1993 | ETHIOPIA       |
-- |       33069 | 1993 | FRANCE         |
-- |       33136 | 1993 | GERMANY        |
-- |       33199 | 1993 | INDIA          |
-- |       33029 | 1993 | INDONESIA      |
-- |       33525 | 1993 | IRAN           |
-- |       32280 | 1993 | IRAQ           |
-- |       32823 | 1993 | JAPAN          |
-- |       33859 | 1993 | JORDAN         |
-- |       33159 | 1993 | KENYA          |
-- |       32844 | 1993 | MOROCCO        |
-- |       34040 | 1993 | MOZAMBIQUE     |
-- |       32776 | 1993 | PERU           |
-- |       34054 | 1993 | ROMANIA        |
-- |       33983 | 1993 | RUSSIA         |
-- |       31866 | 1993 | SAUDI ARABIA   |
-- |       33020 | 1993 | UNITED KINGDOM |
-- |       33040 | 1993 | UNITED STATES  |
-- |       33484 | 1993 | VIETNAM        |
-- |       33471 | 1994 | ALGERIA        |
-- |       33181 | 1994 | ARGENTINA      |
-- |       33293 | 1994 | BRAZIL         |
-- |       33528 | 1994 | CANADA         |
-- |       34033 | 1994 | CHINA          |
-- |       32785 | 1994 | EGYPT          |
-- |       33279 | 1994 | ETHIOPIA       |
-- |       34358 | 1994 | FRANCE         |
-- |       33070 | 1994 | GERMANY        |
-- |       33330 | 1994 | INDIA          |
-- |       34364 | 1994 | INDONESIA      |
-- |       33021 | 1994 | IRAN           |
-- |       32901 | 1994 | IRAQ           |
-- |       32807 | 1994 | JAPAN          |
-- |       33450 | 1994 | JORDAN         |
-- |       32545 | 1994 | KENYA          |
-- |       32644 | 1994 | MOROCCO        |
-- |       33303 | 1994 | MOZAMBIQUE     |
-- |       32633 | 1994 | PERU           |
-- |       33649 | 1994 | ROMANIA        |
-- |       34403 | 1994 | RUSSIA         |
-- |       32808 | 1994 | SAUDI ARABIA   |
-- |       33134 | 1994 | UNITED KINGDOM |
-- |       33290 | 1994 | UNITED STATES  |
-- |       33546 | 1994 | VIETNAM        |
-- |       33587 | 1995 | ALGERIA        |
-- |       33560 | 1995 | ARGENTINA      |
-- |       33498 | 1995 | BRAZIL         |
-- |       33884 | 1995 | CANADA         |
-- |       33335 | 1995 | CHINA          |
-- |       33072 | 1995 | EGYPT          |
-- |       33528 | 1995 | ETHIOPIA       |
-- |       34047 | 1995 | FRANCE         |
-- |       33243 | 1995 | GERMANY        |
-- |       33576 | 1995 | INDIA          |
-- |       34360 | 1995 | INDONESIA      |
-- |       33228 | 1995 | IRAN           |
-- |       32136 | 1995 | IRAQ           |
-- |       32956 | 1995 | JAPAN          |
-- |       33664 | 1995 | JORDAN         |
-- |       32753 | 1995 | KENYA          |
-- |       33300 | 1995 | MOROCCO        |
-- |       33735 | 1995 | MOZAMBIQUE     |
-- |       32836 | 1995 | PERU           |
-- |       33765 | 1995 | ROMANIA        |
-- |       34009 | 1995 | RUSSIA         |
-- |       32907 | 1995 | SAUDI ARABIA   |
-- |       33427 | 1995 | UNITED KINGDOM |
-- |       33364 | 1995 | UNITED STATES  |
-- |       33301 | 1995 | VIETNAM        |
-- |       33186 | 1996 | ALGERIA        |
-- |       33223 | 1996 | ARGENTINA      |
-- |       33687 | 1996 | BRAZIL         |
-- |       33327 | 1996 | CANADA         |
-- |       33784 | 1996 | CHINA          |
-- |       33309 | 1996 | EGYPT          |
-- |       33441 | 1996 | ETHIOPIA       |
-- |       34915 | 1996 | FRANCE         |
-- |       33701 | 1996 | GERMANY        |
-- |       32573 | 1996 | INDIA          |
-- |       34119 | 1996 | INDONESIA      |
-- |       32969 | 1996 | IRAN           |
-- |       33379 | 1996 | IRAQ           |
-- |       33163 | 1996 | JAPAN          |
-- |       34399 | 1996 | JORDAN         |
-- |       32415 | 1996 | KENYA          |
-- |       33529 | 1996 | MOROCCO        |
-- |       33865 | 1996 | MOZAMBIQUE     |
-- |       33104 | 1996 | PERU           |
-- |       34100 | 1996 | ROMANIA        |
-- |       34040 | 1996 | RUSSIA         |
-- |       32464 | 1996 | SAUDI ARABIA   |
-- |       32710 | 1996 | UNITED KINGDOM |
-- |       33286 | 1996 | UNITED STATES  |
-- |       33997 | 1996 | VIETNAM        |
-- |       33468 | 1997 | ALGERIA        |
-- |       33415 | 1997 | ARGENTINA      |
-- |       33616 | 1997 | BRAZIL         |
-- |       32996 | 1997 | CANADA         |
-- |       33418 | 1997 | CHINA          |
-- |       32529 | 1997 | EGYPT          |
-- |       32573 | 1997 | ETHIOPIA       |
-- |       34146 | 1997 | FRANCE         |
-- |       32461 | 1997 | GERMANY        |
-- |       32691 | 1997 | INDIA          |
-- |       34193 | 1997 | INDONESIA      |
-- |       33298 | 1997 | IRAN           |
-- |       33028 | 1997 | IRAQ           |
-- |       33717 | 1997 | JAPAN          |
-- |       33854 | 1997 | JORDAN         |
-- |       32978 | 1997 | KENYA          |
-- |       32967 | 1997 | MOROCCO        |
-- |       33769 | 1997 | MOZAMBIQUE     |
-- |       32952 | 1997 | PERU           |
-- |       34060 | 1997 | ROMANIA        |
-- |       33694 | 1997 | RUSSIA         |
-- |       32657 | 1997 | SAUDI ARABIA   |
-- |       32340 | 1997 | UNITED KINGDOM |
-- |       34187 | 1997 | UNITED STATES  |
-- |       33133 | 1997 | VIETNAM        |
-- |       20178 | 1998 | ALGERIA        |
-- |       19785 | 1998 | ARGENTINA      |
-- |       20278 | 1998 | BRAZIL         |
-- |       20293 | 1998 | CANADA         |
-- |       20522 | 1998 | CHINA          |
-- |       19782 | 1998 | EGYPT          |
-- |       20100 | 1998 | ETHIOPIA       |
-- |       20826 | 1998 | FRANCE         |
-- |       20759 | 1998 | GERMANY        |
-- |       20646 | 1998 | INDIA          |
-- |       20716 | 1998 | INDONESIA      |
-- |       20481 | 1998 | IRAN           |
-- |       20124 | 1998 | IRAQ           |
-- |       20097 | 1998 | JAPAN          |
-- |       20788 | 1998 | JORDAN         |
-- |       19682 | 1998 | KENYA          |
-- |       19925 | 1998 | MOROCCO        |
-- |       21053 | 1998 | MOZAMBIQUE     |
-- |       20152 | 1998 | PERU           |
-- |       20553 | 1998 | ROMANIA        |
-- |       20547 | 1998 | RUSSIA         |
-- |       19693 | 1998 | SAUDI ARABIA   |
-- |       20446 | 1998 | UNITED KINGDOM |
-- |       20031 | 1998 | UNITED STATES  |
-- |       19969 | 1998 | VIETNAM        |
-- +-------------+------+----------------+
-- 175 rows in set (22.62 sec)

SELECT v2.Year,v2.Nation,v2.product_num,
  concat(round(COALESCE(( (v2.product_num-v1.product_num)/v2.product_num * 100 ),0),2),'%') AS inc_or_dec_percentage
FROM view_1 v1,view_1 v2
WHERE v1.Year=v2.Year-1 AND v1.Nation=v2.Nation AND v2.Year>=1992 AND v2.Year<=1995;

-- output
-- +------+----------------+-------------+-----------------------+
-- | Year | Nation         | product_num | inc_or_dec_percentage |
-- +------+----------------+-------------+-----------------------+
-- | 1993 | ALGERIA        |       32933 | -1.01%                |
-- | 1993 | ARGENTINA      |       32981 | 0.82%                 |
-- | 1993 | BRAZIL         |       33548 | 0.92%                 |
-- | 1993 | CANADA         |       34361 | 2.51%                 |
-- | 1993 | CHINA          |       33473 | -0.79%                |
-- | 1993 | EGYPT          |       32938 | 1.94%                 |
-- | 1993 | ETHIOPIA       |       33009 | -0.92%                |
-- | 1993 | FRANCE         |       33069 | -3.86%                |
-- | 1993 | GERMANY        |       33136 | 0.06%                 |
-- | 1993 | INDIA          |       33199 | -0.24%                |
-- | 1993 | INDONESIA      |       33029 | -4.22%                |
-- | 1993 | IRAN           |       33525 | 3.67%                 |
-- | 1993 | IRAQ           |       32280 | -1.90%                |
-- | 1993 | JAPAN          |       32823 | 0.47%                 |
-- | 1993 | JORDAN         |       33859 | 0.09%                 |
-- | 1993 | KENYA          |       33159 | 1.92%                 |
-- | 1993 | MOROCCO        |       32844 | -0.59%                |
-- | 1993 | MOZAMBIQUE     |       34040 | -0.07%                |
-- | 1993 | PERU           |       32776 | -0.05%                |
-- | 1993 | ROMANIA        |       34054 | 2.04%                 |
-- | 1993 | RUSSIA         |       33983 | -0.04%                |
-- | 1993 | SAUDI ARABIA   |       31866 | -1.18%                |
-- | 1993 | UNITED KINGDOM |       33020 | 0.51%                 |
-- | 1993 | UNITED STATES  |       33040 | -0.42%                |
-- | 1993 | VIETNAM        |       33484 | -0.16%                |
-- | 1994 | ALGERIA        |       33471 | 1.61%                 |
-- | 1994 | ARGENTINA      |       33181 | 0.60%                 |
-- | 1994 | BRAZIL         |       33293 | -0.77%                |
-- | 1994 | CANADA         |       33528 | -2.48%                |
-- | 1994 | CHINA          |       34033 | 1.65%                 |
-- | 1994 | EGYPT          |       32785 | -0.47%                |
-- | 1994 | ETHIOPIA       |       33279 | 0.81%                 |
-- | 1994 | FRANCE         |       34358 | 3.75%                 |
-- | 1994 | GERMANY        |       33070 | -0.20%                |
-- | 1994 | INDIA          |       33330 | 0.39%                 |
-- | 1994 | INDONESIA      |       34364 | 3.88%                 |
-- | 1994 | IRAN           |       33021 | -1.53%                |
-- | 1994 | IRAQ           |       32901 | 1.89%                 |
-- | 1994 | JAPAN          |       32807 | -0.05%                |
-- | 1994 | JORDAN         |       33450 | -1.22%                |
-- | 1994 | KENYA          |       32545 | -1.89%                |
-- | 1994 | MOROCCO        |       32644 | -0.61%                |
-- | 1994 | MOZAMBIQUE     |       33303 | -2.21%                |
-- | 1994 | PERU           |       32633 | -0.44%                |
-- | 1994 | ROMANIA        |       33649 | -1.20%                |
-- | 1994 | RUSSIA         |       34403 | 1.22%                 |
-- | 1994 | SAUDI ARABIA   |       32808 | 2.87%                 |
-- | 1994 | UNITED KINGDOM |       33134 | 0.34%                 |
-- | 1994 | UNITED STATES  |       33290 | 0.75%                 |
-- | 1994 | VIETNAM        |       33546 | 0.18%                 |
-- | 1995 | ALGERIA        |       33587 | 0.35%                 |
-- | 1995 | ARGENTINA      |       33560 | 1.13%                 |
-- | 1995 | BRAZIL         |       33498 | 0.61%                 |
-- | 1995 | CANADA         |       33884 | 1.05%                 |
-- | 1995 | CHINA          |       33335 | -2.09%                |
-- | 1995 | EGYPT          |       33072 | 0.87%                 |
-- | 1995 | ETHIOPIA       |       33528 | 0.74%                 |
-- | 1995 | FRANCE         |       34047 | -0.91%                |
-- | 1995 | GERMANY        |       33243 | 0.52%                 |
-- | 1995 | INDIA          |       33576 | 0.73%                 |
-- | 1995 | INDONESIA      |       34360 | -0.01%                |
-- | 1995 | IRAN           |       33228 | 0.62%                 |
-- | 1995 | IRAQ           |       32136 | -2.38%                |
-- | 1995 | JAPAN          |       32956 | 0.45%                 |
-- | 1995 | JORDAN         |       33664 | 0.64%                 |
-- | 1995 | KENYA          |       32753 | 0.64%                 |
-- | 1995 | MOROCCO        |       33300 | 1.97%                 |
-- | 1995 | MOZAMBIQUE     |       33735 | 1.28%                 |
-- | 1995 | PERU           |       32836 | 0.62%                 |
-- | 1995 | ROMANIA        |       33765 | 0.34%                 |
-- | 1995 | RUSSIA         |       34009 | -1.16%                |
-- | 1995 | SAUDI ARABIA   |       32907 | 0.30%                 |
-- | 1995 | UNITED KINGDOM |       33427 | 0.88%                 |
-- | 1995 | UNITED STATES  |       33364 | 0.22%                 |
-- | 1995 | VIETNAM        |       33301 | -0.74%                |
-- +------+----------------+-------------+-----------------------+
-- 75 rows in set (47.43 sec)

-- Query 3 --
DROP VIEW IF EXISTS v3;
CREATE VIEW v3 AS
SELECT Year, Month, Nation, COUNT(DISTINCT(Sales.CustKey)) AS Num_of_Customer FROM Sales
LEFT JOIN Time ON Sales.TimeKey=Time.TimeKey
LEFT JOIN Customer ON Customer.CustKey=Sales.CustKey
WHERE Year=1995
GROUP BY Month, Nation;

--report the number of distinct customers by nation per month in 1995
SELECT Year, Month, Nation, Num_of_Customer FROM v3;
-- report the year average of dictinct customers
SELECT Year, Nation, AVG(Num_of_Customer) AS Year_AVG FROM v3
GROUP BY Nation;
-- report the number of customers by region per month and year average
DROP VIEW IF EXISTS v3_1;
CREATE VIEW v3_1 AS
SELECT Year, Month, Region, COUNT(DISTINCT(Sales.CustKey)) AS Num_of_Customer FROM Sales
LEFT JOIN Time ON Sales.TimeKey=Time.TimeKey
LEFT JOIN Customer ON Customer.CustKey=Sales.CustKey
WHERE Year=1995
GROUP BY Month, Region;
SELECT Year, Month, Region, Num_of_Customer FROM v3_1;
SELECT Year, Region, AVG(Num_of_Customer) AS Year_AVG, SUM(Num_of_Customer) AS "# of total customers" FROM v3_1
GROUP BY Region;

-- output
-- +------+-------+----------------+-----------------+
-- | Year | Month | Nation         | num_OF_customer |
-- +------+-------+----------------+-----------------+
-- | 1995 |     1 | ALGERIA        |             694 |
-- | 1995 |     1 | ARGENTINA      |             702 |
-- | 1995 |     1 | BRAZIL         |             688 |
-- | 1995 |     1 | CANADA         |             721 |
-- | 1995 |     1 | CHINA          |             687 |
-- | 1995 |     1 | EGYPT          |             679 |
-- | 1995 |     1 | ETHIOPIA       |             749 |
-- | 1995 |     1 | FRANCE         |             689 |
-- | 1995 |     1 | GERMANY        |             714 |
-- | 1995 |     1 | INDIA          |             675 |
-- | 1995 |     1 | INDONESIA      |             708 |
-- | 1995 |     1 | IRAN           |             704 |
-- | 1995 |     1 | IRAQ           |             688 |
-- | 1995 |     1 | JAPAN          |             687 |
-- | 1995 |     1 | JORDAN         |             716 |
-- | 1995 |     1 | KENYA          |             705 |
-- | 1995 |     1 | MOROCCO        |             683 |
-- | 1995 |     1 | MOZAMBIQUE     |             702 |
-- | 1995 |     1 | PERU           |             715 |
-- | 1995 |     1 | ROMANIA        |             677 |
-- | 1995 |     1 | RUSSIA         |             687 |
-- | 1995 |     1 | SAUDI ARABIA   |             708 |
-- | 1995 |     1 | UNITED KINGDOM |             746 |
-- | 1995 |     1 | UNITED STATES  |             710 |
-- | 1995 |     1 | VIETNAM        |             691 |
-- | 1995 |     2 | ALGERIA        |             643 |
-- | 1995 |     2 | ARGENTINA      |             686 |
-- | 1995 |     2 | BRAZIL         |             635 |
-- | 1995 |     2 | CANADA         |             688 |
-- | 1995 |     2 | CHINA          |             629 |
-- | 1995 |     2 | EGYPT          |             641 |
-- | 1995 |     2 | ETHIOPIA       |             622 |
-- | 1995 |     2 | FRANCE         |             662 |
-- | 1995 |     2 | GERMANY        |             634 |
-- | 1995 |     2 | INDIA          |             632 |
-- | 1995 |     2 | INDONESIA      |             638 |
-- | 1995 |     2 | IRAN           |             636 |
-- | 1995 |     2 | IRAQ           |             640 |
-- | 1995 |     2 | JAPAN          |             673 |
-- | 1995 |     2 | JORDAN         |             674 |
-- | 1995 |     2 | KENYA          |             650 |
-- | 1995 |     2 | MOROCCO        |             661 |
-- | 1995 |     2 | MOZAMBIQUE     |             649 |
-- | 1995 |     2 | PERU           |             634 |
-- | 1995 |     2 | ROMANIA        |             643 |
-- | 1995 |     2 | RUSSIA         |             670 |
-- | 1995 |     2 | SAUDI ARABIA   |             615 |
-- | 1995 |     2 | UNITED KINGDOM |             633 |
-- | 1995 |     2 | UNITED STATES  |             623 |
-- | 1995 |     2 | VIETNAM        |             605 |
-- | 1995 |     3 | ALGERIA        |             691 |
-- | 1995 |     3 | ARGENTINA      |             708 |
-- | 1995 |     3 | BRAZIL         |             679 |
-- | 1995 |     3 | CANADA         |             733 |
-- | 1995 |     3 | CHINA          |             711 |
-- | 1995 |     3 | EGYPT          |             691 |
-- | 1995 |     3 | ETHIOPIA       |             718 |
-- | 1995 |     3 | FRANCE         |             727 |
-- | 1995 |     3 | GERMANY        |             677 |
-- | 1995 |     3 | INDIA          |             683 |
-- | 1995 |     3 | INDONESIA      |             707 |
-- | 1995 |     3 | IRAN           |             669 |
-- | 1995 |     3 | IRAQ           |             679 |
-- | 1995 |     3 | JAPAN          |             712 |
-- | 1995 |     3 | JORDAN         |             739 |
-- | 1995 |     3 | KENYA          |             656 |
-- | 1995 |     3 | MOROCCO        |             696 |
-- | 1995 |     3 | MOZAMBIQUE     |             723 |
-- | 1995 |     3 | PERU           |             678 |
-- | 1995 |     3 | ROMANIA        |             682 |
-- | 1995 |     3 | RUSSIA         |             706 |
-- | 1995 |     3 | SAUDI ARABIA   |             675 |
-- | 1995 |     3 | UNITED KINGDOM |             680 |
-- | 1995 |     3 | UNITED STATES  |             668 |
-- | 1995 |     3 | VIETNAM        |             645 |
-- | 1995 |     4 | ALGERIA        |             712 |
-- | 1995 |     4 | ARGENTINA      |             687 |
-- | 1995 |     4 | BRAZIL         |             682 |
-- | 1995 |     4 | CANADA         |             646 |
-- | 1995 |     4 | CHINA          |             651 |
-- | 1995 |     4 | EGYPT          |             691 |
-- | 1995 |     4 | ETHIOPIA       |             711 |
-- | 1995 |     4 | FRANCE         |             679 |
-- | 1995 |     4 | GERMANY        |             679 |
-- | 1995 |     4 | INDIA          |             668 |
-- | 1995 |     4 | INDONESIA      |             694 |
-- | 1995 |     4 | IRAN           |             660 |
-- | 1995 |     4 | IRAQ           |             669 |
-- | 1995 |     4 | JAPAN          |             666 |
-- | 1995 |     4 | JORDAN         |             654 |
-- | 1995 |     4 | KENYA          |             685 |
-- | 1995 |     4 | MOROCCO        |             713 |
-- | 1995 |     4 | MOZAMBIQUE     |             674 |
-- | 1995 |     4 | PERU           |             652 |
-- | 1995 |     4 | ROMANIA        |             717 |
-- | 1995 |     4 | RUSSIA         |             756 |
-- | 1995 |     4 | SAUDI ARABIA   |             638 |
-- | 1995 |     4 | UNITED KINGDOM |             673 |
-- | 1995 |     4 | UNITED STATES  |             711 |
-- | 1995 |     4 | VIETNAM        |             665 |
-- | 1995 |     5 | ALGERIA        |             677 |
-- | 1995 |     5 | ARGENTINA      |             651 |
-- | 1995 |     5 | BRAZIL         |             710 |
-- | 1995 |     5 | CANADA         |             726 |
-- | 1995 |     5 | CHINA          |             749 |
-- | 1995 |     5 | EGYPT          |             694 |
-- | 1995 |     5 | ETHIOPIA       |             680 |
-- | 1995 |     5 | FRANCE         |             707 |
-- | 1995 |     5 | GERMANY        |             687 |
-- | 1995 |     5 | INDIA          |             728 |
-- | 1995 |     5 | INDONESIA      |             709 |
-- | 1995 |     5 | IRAN           |             703 |
-- | 1995 |     5 | IRAQ           |             662 |
-- | 1995 |     5 | JAPAN          |             657 |
-- | 1995 |     5 | JORDAN         |             713 |
-- | 1995 |     5 | KENYA          |             645 |
-- | 1995 |     5 | MOROCCO        |             691 |
-- | 1995 |     5 | MOZAMBIQUE     |             727 |
-- | 1995 |     5 | PERU           |             691 |
-- | 1995 |     5 | ROMANIA        |             688 |
-- | 1995 |     5 | RUSSIA         |             688 |
-- | 1995 |     5 | SAUDI ARABIA   |             699 |
-- | 1995 |     5 | UNITED KINGDOM |             687 |
-- | 1995 |     5 | UNITED STATES  |             724 |
-- | 1995 |     5 | VIETNAM        |             706 |
-- | 1995 |     6 | ALGERIA        |             697 |
-- | 1995 |     6 | ARGENTINA      |             645 |
-- | 1995 |     6 | BRAZIL         |             703 |
-- | 1995 |     6 | CANADA         |             738 |
-- | 1995 |     6 | CHINA          |             671 |
-- | 1995 |     6 | EGYPT          |             708 |
-- | 1995 |     6 | ETHIOPIA       |             689 |
-- | 1995 |     6 | FRANCE         |             684 |
-- | 1995 |     6 | GERMANY        |             710 |
-- | 1995 |     6 | INDIA          |             646 |
-- | 1995 |     6 | INDONESIA      |             664 |
-- | 1995 |     6 | IRAN           |             670 |
-- | 1995 |     6 | IRAQ           |             621 |
-- | 1995 |     6 | JAPAN          |             663 |
-- | 1995 |     6 | JORDAN         |             684 |
-- | 1995 |     6 | KENYA          |             673 |
-- | 1995 |     6 | MOROCCO        |             691 |
-- | 1995 |     6 | MOZAMBIQUE     |             735 |
-- | 1995 |     6 | PERU           |             655 |
-- | 1995 |     6 | ROMANIA        |             712 |
-- | 1995 |     6 | RUSSIA         |             700 |
-- | 1995 |     6 | SAUDI ARABIA   |             643 |
-- | 1995 |     6 | UNITED KINGDOM |             690 |
-- | 1995 |     6 | UNITED STATES  |             669 |
-- | 1995 |     6 | VIETNAM        |             678 |
-- | 1995 |     7 | ALGERIA        |             677 |
-- | 1995 |     7 | ARGENTINA      |             703 |
-- | 1995 |     7 | BRAZIL         |             675 |
-- | 1995 |     7 | CANADA         |             745 |
-- | 1995 |     7 | CHINA          |             687 |
-- | 1995 |     7 | EGYPT          |             667 |
-- | 1995 |     7 | ETHIOPIA       |             710 |
-- | 1995 |     7 | FRANCE         |             732 |
-- | 1995 |     7 | GERMANY        |             721 |
-- | 1995 |     7 | INDIA          |             713 |
-- | 1995 |     7 | INDONESIA      |             742 |
-- | 1995 |     7 | IRAN           |             705 |
-- | 1995 |     7 | IRAQ           |             698 |
-- | 1995 |     7 | JAPAN          |             712 |
-- | 1995 |     7 | JORDAN         |             661 |
-- | 1995 |     7 | KENYA          |             712 |
-- | 1995 |     7 | MOROCCO        |             687 |
-- | 1995 |     7 | MOZAMBIQUE     |             671 |
-- | 1995 |     7 | PERU           |             667 |
-- | 1995 |     7 | ROMANIA        |             738 |
-- | 1995 |     7 | RUSSIA         |             731 |
-- | 1995 |     7 | SAUDI ARABIA   |             681 |
-- | 1995 |     7 | UNITED KINGDOM |             701 |
-- | 1995 |     7 | UNITED STATES  |             693 |
-- | 1995 |     7 | VIETNAM        |             697 |
-- | 1995 |     8 | ALGERIA        |             715 |
-- | 1995 |     8 | ARGENTINA      |             705 |
-- | 1995 |     8 | BRAZIL         |             731 |
-- | 1995 |     8 | CANADA         |             668 |
-- | 1995 |     8 | CHINA          |             664 |
-- | 1995 |     8 | EGYPT          |             731 |
-- | 1995 |     8 | ETHIOPIA       |             720 |
-- | 1995 |     8 | FRANCE         |             711 |
-- | 1995 |     8 | GERMANY        |             625 |
-- | 1995 |     8 | INDIA          |             723 |
-- | 1995 |     8 | INDONESIA      |             669 |
-- | 1995 |     8 | IRAN           |             699 |
-- | 1995 |     8 | IRAQ           |             717 |
-- | 1995 |     8 | JAPAN          |             698 |
-- | 1995 |     8 | JORDAN         |             691 |
-- | 1995 |     8 | KENYA          |             682 |
-- | 1995 |     8 | MOROCCO        |             714 |
-- | 1995 |     8 | MOZAMBIQUE     |             757 |
-- | 1995 |     8 | PERU           |             693 |
-- | 1995 |     8 | ROMANIA        |             707 |
-- | 1995 |     8 | RUSSIA         |             726 |
-- | 1995 |     8 | SAUDI ARABIA   |             699 |
-- | 1995 |     8 | UNITED KINGDOM |             710 |
-- | 1995 |     8 | UNITED STATES  |             683 |
-- | 1995 |     8 | VIETNAM        |             697 |
-- | 1995 |     9 | ALGERIA        |             664 |
-- | 1995 |     9 | ARGENTINA      |             717 |
-- | 1995 |     9 | BRAZIL         |             674 |
-- | 1995 |     9 | CANADA         |             670 |
-- | 1995 |     9 | CHINA          |             696 |
-- | 1995 |     9 | EGYPT          |             649 |
-- | 1995 |     9 | ETHIOPIA       |             682 |
-- | 1995 |     9 | FRANCE         |             665 |
-- | 1995 |     9 | GERMANY        |             693 |
-- | 1995 |     9 | INDIA          |             674 |
-- | 1995 |     9 | INDONESIA      |             702 |
-- | 1995 |     9 | IRAN           |             716 |
-- | 1995 |     9 | IRAQ           |             674 |
-- | 1995 |     9 | JAPAN          |             661 |
-- | 1995 |     9 | JORDAN         |             669 |
-- | 1995 |     9 | KENYA          |             643 |
-- | 1995 |     9 | MOROCCO        |             674 |
-- | 1995 |     9 | MOZAMBIQUE     |             683 |
-- | 1995 |     9 | PERU           |             649 |
-- | 1995 |     9 | ROMANIA        |             699 |
-- | 1995 |     9 | RUSSIA         |             666 |
-- | 1995 |     9 | SAUDI ARABIA   |             700 |
-- | 1995 |     9 | UNITED KINGDOM |             667 |
-- | 1995 |     9 | UNITED STATES  |             668 |
-- | 1995 |     9 | VIETNAM        |             667 |
-- | 1995 |    10 | ALGERIA        |             708 |
-- | 1995 |    10 | ARGENTINA      |             718 |
-- | 1995 |    10 | BRAZIL         |             741 |
-- | 1995 |    10 | CANADA         |             658 |
-- | 1995 |    10 | CHINA          |             708 |
-- | 1995 |    10 | EGYPT          |             727 |
-- | 1995 |    10 | ETHIOPIA       |             670 |
-- | 1995 |    10 | FRANCE         |             721 |
-- | 1995 |    10 | GERMANY        |             662 |
-- | 1995 |    10 | INDIA          |             709 |
-- | 1995 |    10 | INDONESIA      |             708 |
-- | 1995 |    10 | IRAN           |             697 |
-- | 1995 |    10 | IRAQ           |             655 |
-- | 1995 |    10 | JAPAN          |             689 |
-- | 1995 |    10 | JORDAN         |             706 |
-- | 1995 |    10 | KENYA          |             731 |
-- | 1995 |    10 | MOROCCO        |             700 |
-- | 1995 |    10 | MOZAMBIQUE     |             704 |
-- | 1995 |    10 | PERU           |             709 |
-- | 1995 |    10 | ROMANIA        |             709 |
-- | 1995 |    10 | RUSSIA         |             755 |
-- | 1995 |    10 | SAUDI ARABIA   |             680 |
-- | 1995 |    10 | UNITED KINGDOM |             728 |
-- | 1995 |    10 | UNITED STATES  |             709 |
-- | 1995 |    10 | VIETNAM        |             687 |
-- | 1995 |    11 | ALGERIA        |             689 |
-- | 1995 |    11 | ARGENTINA      |             655 |
-- | 1995 |    11 | BRAZIL         |             664 |
-- | 1995 |    11 | CANADA         |             633 |
-- | 1995 |    11 | CHINA          |             687 |
-- | 1995 |    11 | EGYPT          |             627 |
-- | 1995 |    11 | ETHIOPIA       |             668 |
-- | 1995 |    11 | FRANCE         |             704 |
-- | 1995 |    11 | GERMANY        |             676 |
-- | 1995 |    11 | INDIA          |             668 |
-- | 1995 |    11 | INDONESIA      |             695 |
-- | 1995 |    11 | IRAN           |             692 |
-- | 1995 |    11 | IRAQ           |             661 |
-- | 1995 |    11 | JAPAN          |             671 |
-- | 1995 |    11 | JORDAN         |             683 |
-- | 1995 |    11 | KENYA          |             683 |
-- | 1995 |    11 | MOROCCO        |             635 |
-- | 1995 |    11 | MOZAMBIQUE     |             697 |
-- | 1995 |    11 | PERU           |             657 |
-- | 1995 |    11 | ROMANIA        |             733 |
-- | 1995 |    11 | RUSSIA         |             685 |
-- | 1995 |    11 | SAUDI ARABIA   |             702 |
-- | 1995 |    11 | UNITED KINGDOM |             640 |
-- | 1995 |    11 | UNITED STATES  |             679 |
-- | 1995 |    11 | VIETNAM        |             710 |
-- | 1995 |    12 | ALGERIA        |             681 |
-- | 1995 |    12 | ARGENTINA      |             685 |
-- | 1995 |    12 | BRAZIL         |             656 |
-- | 1995 |    12 | CANADA         |             706 |
-- | 1995 |    12 | CHINA          |             719 |
-- | 1995 |    12 | EGYPT          |             679 |
-- | 1995 |    12 | ETHIOPIA       |             699 |
-- | 1995 |    12 | FRANCE         |             684 |
-- | 1995 |    12 | GERMANY        |             673 |
-- | 1995 |    12 | INDIA          |             706 |
-- | 1995 |    12 | INDONESIA      |             698 |
-- | 1995 |    12 | IRAN           |             704 |
-- | 1995 |    12 | IRAQ           |             642 |
-- | 1995 |    12 | JAPAN          |             664 |
-- | 1995 |    12 | JORDAN         |             692 |
-- | 1995 |    12 | KENYA          |             689 |
-- | 1995 |    12 | MOROCCO        |             692 |
-- | 1995 |    12 | MOZAMBIQUE     |             688 |
-- | 1995 |    12 | PERU           |             696 |
-- | 1995 |    12 | ROMANIA        |             690 |
-- | 1995 |    12 | RUSSIA         |             692 |
-- | 1995 |    12 | SAUDI ARABIA   |             705 |
-- | 1995 |    12 | UNITED KINGDOM |             709 |
-- | 1995 |    12 | UNITED STATES  |             651 |
-- | 1995 |    12 | VIETNAM        |             753 |
-- +------+-------+----------------+-----------------+
-- 300 rows in set (11.17 sec)
-- +------+----------------+----------+
-- | Year | Nation         | Year_AVG |
-- +------+----------------+----------+
-- | 1995 | ALGERIA        | 687.3333 |
-- | 1995 | ARGENTINA      | 688.5000 |
-- | 1995 | BRAZIL         | 686.5000 |
-- | 1995 | CANADA         | 694.3333 |
-- | 1995 | CHINA          | 688.2500 |
-- | 1995 | EGYPT          | 682.0000 |
-- | 1995 | ETHIOPIA       | 693.1667 |
-- | 1995 | FRANCE         | 697.0833 |
-- | 1995 | GERMANY        | 679.2500 |
-- | 1995 | INDIA          | 685.4167 |
-- | 1995 | INDONESIA      | 694.5000 |
-- | 1995 | IRAN           | 687.9167 |
-- | 1995 | IRAQ           | 667.1667 |
-- | 1995 | JAPAN          | 679.4167 |
-- | 1995 | JORDAN         | 690.1667 |
-- | 1995 | KENYA          | 679.5000 |
-- | 1995 | MOROCCO        | 686.4167 |
-- | 1995 | MOZAMBIQUE     | 700.8333 |
-- | 1995 | PERU           | 674.6667 |
-- | 1995 | ROMANIA        | 699.5833 |
-- | 1995 | RUSSIA         | 705.1667 |
-- | 1995 | SAUDI ARABIA   | 678.7500 |
-- | 1995 | UNITED KINGDOM | 688.6667 |
-- | 1995 | UNITED STATES  | 682.3333 |
-- | 1995 | VIETNAM        | 683.4167 |
-- +------+----------------+----------+
-- 25 rows in set (11.00 sec)
-- +------+-------+-------------+-----------------+
-- | Year | Month | Region      | Num_of_Customer |
-- +------+-------+-------------+-----------------+
-- | 1995 |     1 | AFRICA      |            3533 |
-- | 1995 |     1 | AMERICA     |            3536 |
-- | 1995 |     1 | ASIA        |            3448 |
-- | 1995 |     1 | EUROPE      |            3513 |
-- | 1995 |     1 | MIDDLE EAST |            3495 |
-- | 1995 |     2 | AFRICA      |            3225 |
-- | 1995 |     2 | AMERICA     |            3266 |
-- | 1995 |     2 | ASIA        |            3177 |
-- | 1995 |     2 | EUROPE      |            3242 |
-- | 1995 |     2 | MIDDLE EAST |            3206 |
-- | 1995 |     3 | AFRICA      |            3484 |
-- | 1995 |     3 | AMERICA     |            3466 |
-- | 1995 |     3 | ASIA        |            3458 |
-- | 1995 |     3 | EUROPE      |            3472 |
-- | 1995 |     3 | MIDDLE EAST |            3453 |
-- | 1995 |     4 | AFRICA      |            3495 |
-- | 1995 |     4 | AMERICA     |            3378 |
-- | 1995 |     4 | ASIA        |            3344 |
-- | 1995 |     4 | EUROPE      |            3504 |
-- | 1995 |     4 | MIDDLE EAST |            3312 |
-- | 1995 |     5 | AFRICA      |            3420 |
-- | 1995 |     5 | AMERICA     |            3502 |
-- | 1995 |     5 | ASIA        |            3549 |
-- | 1995 |     5 | EUROPE      |            3457 |
-- | 1995 |     5 | MIDDLE EAST |            3471 |
-- | 1995 |     6 | AFRICA      |            3485 |
-- | 1995 |     6 | AMERICA     |            3410 |
-- | 1995 |     6 | ASIA        |            3322 |
-- | 1995 |     6 | EUROPE      |            3496 |
-- | 1995 |     6 | MIDDLE EAST |            3326 |
-- | 1995 |     7 | AFRICA      |            3457 |
-- | 1995 |     7 | AMERICA     |            3483 |
-- | 1995 |     7 | ASIA        |            3551 |
-- | 1995 |     7 | EUROPE      |            3623 |
-- | 1995 |     7 | MIDDLE EAST |            3412 |
-- | 1995 |     8 | AFRICA      |            3588 |
-- | 1995 |     8 | AMERICA     |            3480 |
-- | 1995 |     8 | ASIA        |            3451 |
-- | 1995 |     8 | EUROPE      |            3479 |
-- | 1995 |     8 | MIDDLE EAST |            3537 |
-- | 1995 |     9 | AFRICA      |            3346 |
-- | 1995 |     9 | AMERICA     |            3378 |
-- | 1995 |     9 | ASIA        |            3400 |
-- | 1995 |     9 | EUROPE      |            3390 |
-- | 1995 |     9 | MIDDLE EAST |            3408 |
-- | 1995 |    10 | AFRICA      |            3513 |
-- | 1995 |    10 | AMERICA     |            3535 |
-- | 1995 |    10 | ASIA        |            3501 |
-- | 1995 |    10 | EUROPE      |            3575 |
-- | 1995 |    10 | MIDDLE EAST |            3465 |
-- | 1995 |    11 | AFRICA      |            3372 |
-- | 1995 |    11 | AMERICA     |            3288 |
-- | 1995 |    11 | ASIA        |            3431 |
-- | 1995 |    11 | EUROPE      |            3438 |
-- | 1995 |    11 | MIDDLE EAST |            3365 |
-- | 1995 |    12 | AFRICA      |            3449 |
-- | 1995 |    12 | AMERICA     |            3394 |
-- | 1995 |    12 | ASIA        |            3540 |
-- | 1995 |    12 | EUROPE      |            3448 |
-- | 1995 |    12 | MIDDLE EAST |            3422 |
-- +------+-------+-------------+-----------------+
-- 60 rows in set (11.05 sec)
-- +------+-------------+-----------+----------------------+
-- | Year | Region      | Year_AVG  | # of total customers |
-- +------+-------------+-----------+----------------------+
-- | 1995 | AFRICA      | 3447.2500 |                41367 |
-- | 1995 | AMERICA     | 3426.3333 |                41116 |
-- | 1995 | ASIA        | 3431.0000 |                41172 |
-- | 1995 | EUROPE      | 3469.7500 |                41637 |
-- | 1995 | MIDDLE EAST | 3406.0000 |                40872 |
-- +------+-------------+-----------+----------------------+
-- 5 rows in set (11.28 sec)

-- query 4
DROP VIEW IF EXISTS view_4_0;
CREATE VIEW view_4_0 AS
SELECT P.ProductKey,C.Region,T.Quarter
FROM Sales S
LEFT JOIN Product P ON P.ProductKey=S.ProductKey
LEFT JOIN Time T ON T.TimeKey=S.TimeKey
LEFT JOIN Customer C ON C.CustKey=S.CustKey
WHERE T.Year=1993;

DROP VIEW IF EXISTS view_4_1;
CREATE VIEW view_4_1 AS
SELECT ProductKey,Region,Quarter
FROM view_4_0 WHERE Quarter=3 OR Quarter=4;

DROP VIEW IF EXISTS view_4_2;
CREATE VIEW view_4_2 AS
SELECT ProductKey,Region,Quarter
FROM view_4_0 WHERE Quarter=1 OR Quarter=2;

SELECT v1.Region,count(DISTINCT(v1.ProductKey)) AS product_num
FROM view_4_1 v1 LEFT JOIN view_4_2 v2
ON v1.ProductKey=v2.ProductKey
WHERE v2.ProductKey IS NULL
GROUP BY v1.Region;

-- output
-- +-------------+-------------+
-- | Region      | product_num |
-- +-------------+-------------+
-- | AFRICA      |        7832 |
-- | AMERICA     |        7713 |
-- | ASIA        |        7856 |
-- | EUROPE      |        7802 |
-- | MIDDLE EAST |        7694 |
-- +-------------+-------------+
-- 5 rows in set (8 min 28.27 sec)

-- Query 5 --

-- GIVEN Query
SELECT c.Region, COUNT(*) AS '# of Sales by region for 1995'
FROM Sales s, Customer c, Time t
WHERE s.TimeKey = t.TimeKey
AND s.CustKey = c.CustKey
AND Year = 1995
GROUP BY c.Region;

-- +-------------+----------+
-- | Region      | COUNT(*) |
-- +-------------+----------+
-- | AFRICA      |   182687 |
-- | AMERICA     |   182865 |
-- | ASIA        |   183585 |
-- | EUROPE      |   184384 |
-- | MIDDLE EAST |   180406 |
-- +-------------+----------+
-- 5 rows in set (10.00 sec)

-- query 6
SELECT c.Nation,count(*)
FROM Sales s,Customer c
WHERE s.CustKey=c.CustKey AND
c.Region='EUROPE'
GROUP BY c.Nation;
-- +----------------+----------+
-- | Nation         | count(*) |
-- +----------------+----------+
-- | FRANCE         |   246415 |
-- | GERMANY        |   239064 |
-- | ROMANIA        |   243962 |
-- | RUSSIA         |   245236 |
-- | UNITED KINGDOM |   237400 |
-- +----------------+----------+
-- 5 rows in set (1.15 sec)

-- Query 7 --
SELECT COUNT(*)
FROM Sales s, Customer c, Time t
WHERE s.TimeKey = t.TimeKey
AND s.CustKey = c.CustKey
AND t.Year = 1994
AND (c.Region='AMERICA' OR c.Region='ASIA');
-- +----------+
-- | COUNT(*) |
-- +----------+
-- |   365333 |
-- +----------+
-- 1 row in set (26.50 sec)

-- Additional Method for Query 7

-- SELECT COUNT(*) AS 'Number of sales in America and Asia for 1994'
-- FROM Sales s
-- LEFT JOIN Customer c ON s.CustKey = c.CustKey
-- WHERE YEAR(FROM_DAYS(s.TimeKey))=1994 AND
-- (c.Region = 'AMERICA' OR c.Region = 'ASIA');
-- +----------+e
-- | COUNT(*) |
-- +----------+
-- |   365333 |
-- +----------+
-- 1 row in set (25.72 sec)

-- query 8
SELECT count(*)
FROM Sales s,Customer c
WHERE s.CustKey=c.CustKey AND
c.Nation IN
('FRANCE','GERMANY','BRAZIL','ALGERIA','JAPAN');
-- +----------+
-- | count(*) |
-- +----------+
-- |  1203959 |
-- +----------+
-- 1 row in set (0.86 sec)
