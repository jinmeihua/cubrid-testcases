--+ holdcas on;
--test udt using monetary type
create class t1(
	id int auto_increment primary key,
	col1 monetary 
);

create class t2(
	a set of t1,
	b set(varchar(10)),
	c sequence varchar(10)
);

insert INTO t1 (col1) values (1.111);
insert INTO t1 (col1) values (2.222);

SELECT t1 into xx from t1 where id=1;
insert into t2 values ({xx},{'aaa'},{'vvv'});

select * FROM t1;
SELECT * FROM t2;

drop t1;
drop t2;
--+ holdcas off;
