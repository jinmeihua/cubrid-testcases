--1 table with 2 auto_increment serial - drop auto_increment throu alter change


create table foo(a int primary key auto_increment, b string, c short);

insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
insert into foo values (null, 'aaa', 100);
select * from foo order by 1;
select last_insert_id();

--add another auto_increment serial
alter table foo change c c short auto_increment;

insert into foo(b) values ('a'), ('b'), ('c'), ('d');
select * from foo order by 1;
select last_insert_id();

insert into foo values (100, 'hhh', 4);
select * from foo order by 1;
select last_insert_id();

insert into foo(b) values ('a'), ('b'), ('c'), ('d');
select * from foo order by 1,2;
select last_insert_id();


drop table foo;
