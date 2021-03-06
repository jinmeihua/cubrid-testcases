--cast date/time columns to TIME(L)TZ types, in alter statement, alter_table_change_type_strict=yes

autocommit off;

drop table if exists tz_test;

create table tz_test(a date, b time, c timestamp, d datetime);
insert into tz_test values(date'2000-10-10', time'12:13:14', timestamp'2019-12-10 3:40:56', datetime'2019-12-10 3:40:56.299');
commit;

set system parameters 'alter_table_change_type_strict=yes';

set timezone '+3:00';
--test: cast date/time columns to TIME types
alter table tz_test modify a time;
alter table tz_test modify b time;
alter table tz_test modify c time;
alter table tz_test modify d time;
desc tz_test;
select * from tz_test order by 1;
rollback;

set timezone '-3:00';
--test: cast date/time columns to TIMELTZ types
alter table tz_test modify a datetime with local time zone;
alter table tz_test modify b datetime with local time zone;
alter table tz_test modify c datetime with local time zone;
alter table tz_test modify d datetime with local time zone;
desc tz_test;
select * from tz_test order by 1;
rollback;

set timezone 'America/Argentina/San_Juan';
--test: cast date/time columns to TIMETZ types
alter table tz_test modify a datetime with time zone;
alter table tz_test modify b datetime with time zone;
--BUG: CUBRIDSUS-16974, resolved
alter table tz_test modify c datetime with time zone;
alter table tz_test modify d datetime with time zone;
desc tz_test;
select * from tz_test order by 1;
rollback;


drop table tz_test;
commit;

set timezone 'Asia/Seoul';
autocommit on;
