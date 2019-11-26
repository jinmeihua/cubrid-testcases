--+ holdcas on;
--test path expression using some select queries and int,varchar,set type fields.
create class DML_0001
( 	int_col int not null,
var_col varchar(20),
set_col set (int,varchar(20)));

create class DML_0002 	
(	int_col int not null,
var_col varchar(20),
set_col set (int, varchar(20)),
ref_col DML_0001,
set_ref_col set of DML_0001);

create class DML_0003 under DML_0001
( 	int_col1 int not null);
insert into DML_0001 values (1,'test1', {1,'test1'});
insert into DML_0001 values (2,'test1', {1,'test1'});
insert into DML_0001 values (3,'test2', {1,'test2'});
insert into DML_0001 values (4,'test1', {2,'test1'});
insert into DML_0001 values (5,'test2', {2,'test2'});
select DML_0001 into a from DML_0001 where int_col = 1;
select DML_0001 into b from DML_0001 where int_col = 2;
select DML_0001 into c from DML_0001 where int_col = 3;
select DML_0001 into d from DML_0001 where int_col = 4;
select DML_0001 into e from DML_0001 where int_col = 5;
insert into DML_0002 values (1, 'test1', {1,'test1'}, a, {a, b, c});
insert into DML_0002 values (2, 'test1', {1,'test1'}, b, {a, b, d});
insert into DML_0002 values (3, 'test2', {1,'test2'}, c, {a, b, e});
insert into DML_0002 values (4, 'test1', {2,'test1'}, d, {b, c, d});
insert into DML_0002 values (5, 'test2', {2,'test2'}, e, {b, c, e});
insert into DML_0003 values (1,'test1', {1,'test1'},1);
insert into DML_0003 values (2,'test1', {1,'test1'},2);
insert into DML_0003 values (3,'test2', {1,'test2'},3);
insert into DML_0003 values (4,'test1', {2,'test1'},4);
insert into DML_0003 values (5,'test2', {2,'test2'},5);
select int_col, var_col, ref_col.int_col from DML_0002 order by 1,2,3;

select DML_0001.int_col,DML_0002.ref_col.int_col from DML_0001,DML_0002  order by 1,2;
select DML_0001.int_col,DML_0002.ref_col.int_col from all DML_0001,DML_0002  order by 1,2;
select int_col, var_col, ref_col.int_col, a.int_col from DML_0002, table(set_ref_col) as t(a)  order by 1,2,3,4;
select ref_col{a}.int_col from dml_0002, dml_0001 a  order by 1;


drop class DML_0001;
drop class DML_0002;
drop class DML_0003;
drop variable a,b,c,d,e ;

--+ holdcas off;
