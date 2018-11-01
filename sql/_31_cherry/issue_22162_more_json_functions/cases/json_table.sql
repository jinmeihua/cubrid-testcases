
set @jdoc='{ 
 "id" : 901,
 "name" : { "first":"John", "last":"Doe" },
 "phones": [
 { "type":"home", "number":"555-3762"},
 { "type":"work", "number":"555-8792"}]
}';

SELECT jt."id", jt."first name",jt."last name",jt."phone type",jt."phone number"
 FROM JSON_TABLE(@jdoc, 
 '$'
 COLUMNS( "id" INTEGER PATH '$.id',
 "first name" VARCHAR(20) PATH '$.name.first',
 "last name" VARCHAR(20) PATH '$.name.last',
 "phone type" VARCHAR(20) PATH '$.phones[0].type',
 "phone number" VARCHAR(20) PATH '$.phones[0].number')
 ) AS jt;
					 
SELECT jt."id", jt."first name",jt."last name",jt."phone type",jt."number" AS "phone number"
 FROM JSON_TABLE(@jdoc, 
 '$'
 COLUMNS( "id" INTEGER PATH '$.id',
 "first name" VARCHAR(20) PATH '$.name.first',
 "last name" VARCHAR(20) PATH '$.name.last',
 NESTED PATH '$.phones[*]'
 COLUMNS (
 "phone type" VARCHAR(20) PATH '$.type',
 "number" VARCHAR(20) PATH '$.number' )
 )
 ) AS jt;


drop table if exists t;

create table t (a int, b varchar(128), c float, u_a int, u_b varchar(128), u_c float);
insert into t values (1, 'a', 0.1, NULL, NULL, NULL);
insert into t values (2, 'b', 0.2, NULL, NULL, NULL);
insert into t values (3, 'c', 0.3, NULL, NULL, NULL);
insert into t values (4, 'd', 0.4, NULL, NULL, NULL);

set @jdoc='[
{"a":1, "b":"a", "c":0.1},
{"a":2, "b":"b", "c":0.2},
{"a":3, "b":"c", "c":0.3},
{"a":4, "b":"d", "c":0.4}
]';

select * from json_table (
@jdoc, '$[*]'
columns (
a int path '$.a' ,
b varchar(12) path '$.b' ,
c float path '$.c' ,
u_a int path '$.e' ,
u_b varchar(12) path '$.e' ,
u_c float path '$.e' 
)) as t;

set @a = 0;
select /*+ recompile */ t1.a, x.a, @a := @a + 1 from t t1 
inner join json_table (
@jdoc, '$[*]'
columns (
a int path '$.a' ,
b varchar(12) path '$.b' ,
c float path '$.c' ,
u_a int path '$.e' ,
u_b varchar(12) path '$.e' ,
u_c float path '$.e' 
)) as t2 on t1.a = t2.a 
left join (select a + 1 as a, @a := @a + 1 from t) x on t2.a = x.a order by 1,2,3;

select /*+ recompile */ t1.a, x.a, @a := @a + 1 from t t1 
inner join json_table (
@jdoc, '$[*]'
columns (
a int path '$.a' ,
b varchar(12) path '$.b' ,
c float path '$.c' ,
u_a int path '$.e' ,
u_b varchar(12) path '$.e' ,
u_c float path '$.e' 
)) as t2 on t1.a = t2.a 
left join (select a + 1 as a, @a := @a + 1 from json_table (
@jdoc, '$[*]'
columns (
a int path '$.a' ,
b varchar(12) path '$.b' ,
c float path '$.c' ,
u_a int path '$.e' ,
u_b varchar(12) path '$.e' ,
u_c float path '$.e' 
)) as jt) as x on t2.a = x.a order by 1,2,3;

set @a = 0;
select /*+ recompile */ a, @a := @a + 1 from t 
union 
select a + 2, @a := @a + 1 from json_table (
@jdoc, '$[*]'
columns (
a int path '$.a' ,
b varchar(12) path '$.b' ,
c float path '$.c' ,
u_a int path '$.e' ,
u_b varchar(12) path '$.e' ,
u_c float path '$.e' 
)) as jt 
order by a desc,2;

 
drop variable @jdoc, @a;
drop table if exists t;

 
 
 
 
 
 