--+ holdcas on;
--[er]test the in keyword with invalid use of keyword 'set'
create class DML_0001 (
int_col integer,
var_col varchar(20),
set_col set (int, varchar(10)) );

insert into DML_0001 values (1,'test1', {1,'test1'});
insert into DML_0001 values (2,'test1', {1,'test1'});
insert into DML_0001 values (3,'test2', {1,'test2'});
insert into DML_0001 values (4,'test1', {2,'test1'});
insert into DML_0001 values (5,'test2', {2,'test2'});


select * from DML_0001 where int_col in (select int_col into set :a from DML_0001);



drop class DML_0001;

--+ holdcas off;
