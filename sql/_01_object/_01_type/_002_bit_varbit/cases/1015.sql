-- create table with bit data type and insert bit data


CREATE CLASS t1(
   col1       bit(20)
);

INSERT INTO t1 VALUES (B'0001');

drop t1;