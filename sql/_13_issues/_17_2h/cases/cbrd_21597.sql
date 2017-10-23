drop table if exists scores;
CREATE TABLE scores(id INT PRIMARY KEY AUTO_INCREMENT, math INT, english INT, pe CHAR, grade INT);
INSERT INTO scores(math, english, pe, grade)
VALUES(60, 70, 'A', 1), (95, 90, 'A', 2), (60, 70, 'A', 1),  
(85, 95, 'B', 2),  (60, 70, 'B', 1),  (85, 95, 'B', 2);

-- Execute PERCENT_RANK() and PERCENTILE_DISC() in one query, it returns error.
SELECT
PERCENT_RANK() OVER(PARTITION BY grade ORDER BY math, english, pe) AS percent_rank2 ,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY math) OVER (PARTITION BY grade) AS pdisc 
FROM scores ;


SELECT id, math, english, pe, grade,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY math) OVER (PARTITION BY grade) AS pdisc,
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY math) OVER (PARTITION BY grade) AS pcont
FROM scores ORDER BY id;

SELECT id, math, english, pe, grade,
PERCENT_RANK() OVER(ORDER BY math, english, pe) AS percent_rank,
PERCENT_RANK() OVER(PARTITION BY grade ORDER BY math, english, pe) AS percent_rank2
FROM scores ORDER BY id;


SELECT id, math, english, pe, grade,
PERCENT_RANK() OVER(ORDER BY math, english, pe) AS percent_rank,
PERCENT_RANK() OVER(PARTITION BY grade ORDER BY math, english, pe) AS percent_rank2,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY math) OVER (PARTITION BY grade) AS pdisc,
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY math) OVER (PARTITION BY grade) AS pcont
FROM scores ORDER BY id;


SELECT id, math, english, pe, grade,
CUME_DIST() OVER(ORDER BY math, english, pe) AS cume_dist1,
CUME_DIST() OVER(PARTITION BY grade ORDER BY math, english, pe) AS cume_dist2,
PERCENT_RANK() OVER(ORDER BY math, english, pe) AS percent_rank,
PERCENT_RANK() OVER(PARTITION BY grade ORDER BY math, english, pe) AS percent_rank2,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY math) OVER (PARTITION BY grade) AS pdisc,
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY math) OVER (PARTITION BY grade) AS pcont
FROM scores ORDER BY id;

