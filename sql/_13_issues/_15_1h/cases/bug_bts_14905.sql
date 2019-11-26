--+ holdcas on;
SET OPTIMIZATION LEVEL 513;
set  system parameters 'dont_reuse_heap_file=no';
 
drop table if exists ntile_gl;
create table ntile_gl(
        col1 smallint auto_increment primary key,
        col2 bigint,
        col3 varchar default 'abc',
        col4 timestamp default CURRENT_TIMESTAMP,
        col5 bit(20)
);
select /*+ recompile */ ntile(10) over(partition by col1 order by col5, col4) from ntile_gl where ntile(3) over(order by col3) > 2 group by col4 order by 1;

--extended test 1
do (select * from ntile_gl where col2 = max(col2));

--extended test 2
set @v1 = (select col1 from ntile_gl where col2 = max(col2));

--extended test 3
drop table if exists t;
create table t (a int, b int);
insert into t values (5,5), (6,6);
 
merge into t using ntile_gl 
on (t.a = ntile_gl.col1 * 5) 
when matched then update set t.a = t.a + ntile_gl.col1 delete where t.a = max(t.b)
when not matched then insert values (ntile_gl.col1, ntile_gl.col2);

--extended test 4
insert into t select * from t where b=5 and b=min(b) on duplicate key update a = 8;

--extended test 5
delete from ntile_gl where col1 = max(col2);

SET OPTIMIZATION LEVEL 1;
drop variable @v1;
drop table if exists t;
drop table if exists ntile_gl;

--+ holdcas off;
