--+ holdcas on;
autocommit off;
create class boo(b_int int);
create class foo(f_obj boo, f_int int);
insert into boo values(1);
insert into foo (f_obj, f_int) values(insert into boo values(2), 2);
select boo into :p1 from boo where b_int = 2;
create index i_foo_f_obj on foo(f_obj);
--set optimization: cost 'iscan' 0;
--set optimization: level 257;
select f_obj, f_obj.b_int, f_int from foo where f_obj = :p1;
rollback;

--+ holdcas off;
