--implicit conversion from with time zone types to TIME(L)TZ types, in insert 


drop table if exists tz_test;

create table tz_test (id int auto_increment, t time, tltz datetime with local time zone, ttz datetime with time zone);
set timezone '+10:00';

create table with_tz_types(
        c timestamp with local time zone,
        d timestamp with time zone,
        e datetime with local time zone,
        f datetime with time zone
);
set timezone '+3:00';
insert into with_tz_types values(timestamptz'2019-12-10 3:40:56', timestamptz'2019-12-10 3:40:56 Indian/Comoro',  datetimetz' 2019-12-10 3:40:56.299', datetimetz' 2019-12-10 3:40:56.299 Indian/Comoro');

set timezone 'Asia/Seoul';
--test: implicit conversion from with time zone constant values to t types
insert into tz_test(t, tltz, ttz) values (date'1999-09-09', date'1999-09-09', date'1999-09-09');
insert into tz_test(t, tltz, ttz) values (datetimetz'2015-9-17 22:22:22 +8:00', datetimetz'2015-9-17 22:22:22 +8:00', datetimetz'2015-9-17 22:22:22 +8:00');
insert into tz_test(t, tltz, ttz) values (timestamptz'1989-11-17 20:23:23 Australia/Eucla', timestamptz'1989-11-17 20:23:23 Australia/Eucla', timestamptz'1989-11-17 20:23:23 Australia/Eucla');
insert into tz_test(t, tltz, ttz) values (datetimetz' 2010-10-23 05:59:59.999 America/Scoresbysund', datetimetz' 2010-10-23 05:59:59.999 America/Scoresbysund', datetimetz' 2010-10-23 05:59:59.999 America/Scoresbysund');
select * from tz_test order by 1;


--test: implicit conversion from with time zone types to t types
insert into tz_test(t, tltz, ttz) values (select c from with_tz_types, select c from with_tz_types, select c from with_tz_types);
insert into tz_test(t, tltz, ttz) values (select d from with_tz_types, select d from with_tz_types, select d from with_tz_types);
insert into tz_test(t, tltz, ttz) select e, e, e from with_tz_types;
insert into tz_test(t, tltz, ttz) select f, f, f from with_tz_types;
select * from tz_test order by 1;


drop table tz_test, with_tz_types;

set timezone 'Asia/Seoul';
