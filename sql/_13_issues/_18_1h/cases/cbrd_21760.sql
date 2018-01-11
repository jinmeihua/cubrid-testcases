drop table if exists t1;

CREATE TABLE t1 (a SET (json));
INSERT INTO t1 VALUES ({'{"A":1}'});
select a + {'{"A": 2}'} from t1; 
select a + {json'{"A": 2}'} from t1;
select a - {json'{"A": 2}'} from t1;
select a - {json'{"A": 1}'} from t1;
select a * {json'{"A": 2}'} from t1;
select (a + {json'{"A": 2}'}) * {json'{"A": 2}'} from t1;

INSERT INTO t1 VALUES (a + {'{"A": 2}'});
select * from t1 order by 1;
drop table if exists t1;

CREATE TABLE t1 (a SET (json), b SET (json));
INSERT INTO t1 VALUES ({'{"A":1}'},{'{"A":1}'});
insert into t1 select a + {'{"A": 2}'}, b from t1;
select * from t1 order by 1;
select a+b from t1 order by 1;
select a-b from t1 order by 1;
select a*b from t1 order by 1;
select a+cast(b as multiset)+cast(a as multiset) from t1 order by 1;
drop table if exists t1;

CREATE TABLE t1 (c1 SET (String),c2 SET (String), c3 SET (int) );
INSERT INTO t1 VALUES ({'a','b'},{'d'},{5});
select c1 + c2 from t1;
select c1 + {'4'} from t1;
select c1 + c3 from t1;
select c1 + {1} from t1;
select c3 + {3} from t1;
drop table if exists t1;

CREATE TABLE t1 (a SET (int));		
INSERT INTO t1 VALUES ({});		
select * from t1;
INSERT INTO t1 VALUES ({1});
select * from t1;
drop table if exists t1;
