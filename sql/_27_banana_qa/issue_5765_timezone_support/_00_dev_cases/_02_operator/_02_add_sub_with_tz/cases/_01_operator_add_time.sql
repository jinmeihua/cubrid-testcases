autocommit off;
set system parameters 'return_null_on_function_errors=no';

select cast(1 as SHORT) + DATE '09/01/2009' from db_root;
select DATE '09/01/2009' + cast(1 as SHORT) from db_root;
select cast(1 as SHORT) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select datetimetz '09/01/2009 03:30:30 pm' + cast(1 as SHORT) from db_root;
select cast(1 as SHORT) + timestamptz '09/01/2009 03:30:30 pm' from db_root;
select timestamptz '09/01/2009 03:30:30 pm' + cast(1 as SHORT) from db_root;

select cast(1 as INTEGER) + DATE '09/01/2009' from db_root;
select DATE '09/01/2009' + cast(1 as INTEGER) from db_root;
select cast(1 as INTEGER) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select datetimetz '09/01/2009 03:30:30 pm' + cast(1 as INTEGER) from db_root;
select cast(1 as INTEGER) + timestamptz '09/01/2009 03:30:30 pm' from db_root;
select timestamptz '09/01/2009 03:30:30 pm' + cast(1 as INTEGER) from db_root;

select cast(1 as BIGINT) + DATE '09/01/2009' from db_root;
select DATE '09/01/2009' + cast(1 as BIGINT) from db_root;
select cast(1 as BIGINT) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select datetimetz '09/01/2009 03:30:30 pm' + cast(1 as BIGINT) from db_root;
select cast(1 as BIGINT) + timestamptz '09/01/2009 03:30:30 pm' from db_root;
select timestamptz '09/01/2009 03:30:30 pm' + cast(1 as BIGINT) from db_root;



select cast(-1 as SHORT) + DATE '09/01/2009' from db_root;
select cast(-1 as SHORT) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select cast(-1 as SHORT) + timestamptz '09/01/2009 03:30:30 pm' from db_root;

select cast(-1 as INTEGER) + DATE '09/01/2009' from db_root;
select cast(-1 as INTEGER) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select cast(-1 as INTEGER) + timestamptz '09/01/2009 03:30:30 pm' from db_root;

select cast(-1 as BIGINT) + DATE '09/01/2009' from db_root;
select cast(-1 as BIGINT) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select cast(-1 as BIGINT) + timestamptz '09/01/2009 03:30:30 pm' from db_root;

-- overflow: max + max
select cast(32767 as SHORT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
select cast(2147483647 as INTEGER) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
select cast(9223372036854775807 as BIGINT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;

select cast(32767 as SHORT) + DATE '12/31/9999' from db_root;
select cast(2147483647 as INTEGER) + DATE '12/31/9999' from db_root;
select cast(9223372036854775807 as BIGINT) + DATE '12/31/9999' from db_root;

select cast(32767 as SHORT) + datetimetz '12/31/9999 11:59:59 pm' from db_root;
select cast(2147483647 as INTEGER) + datetimetz '12/31/9999 11:59:59 pm' from db_root;
select cast(9223372036854775807 as BIGINT) + datetimetz '12/31/9999 11:59:59 pm' from db_root;

-- max + 1
select cast(1 as SHORT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
select cast(1 as INTEGER) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
select cast(1 as BIGINT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;

select cast(1 as SHORT) + DATE '12/31/9999' from db_root;
select cast(1 as INTEGER) + DATE '12/31/9999' from db_root;
select cast(1 as BIGINT) + DATE '12/31/9999' from db_root;

select cast(1 as SHORT) + datetimetz '12/31/9999 11:59:59 pm' from db_root;
select cast(1 as INTEGER) + datetimetz '12/31/9999 11:59:59 pm' from db_root;
select cast(1 as BIGINT) + datetimetz '12/31/9999 11:59:59 pm' from db_root;


-- asymmetry
-- normal
select cast(-32768 as SHORT) + timestamptz '01/01/2009 09:00:01 am' from db_root;
-- underflow
select cast(-32768 as SHORT) + timestamptz '01/01/1970 09:00:01 am' from db_root;
-- overflow
select cast(-32768 as SHORT) + timestamptz '01/01/1970 09:00:00 am' from db_root;


-- underflow
select cast(-2147483648 as INTEGER) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
-- underflow
select cast(-2147483648 as INTEGER) + timestamptz '01/01/1970 09:00:01 am' from db_root;
-- overflow
select cast(-2147483648 as INTEGER) + timestamptz '01/01/1970 09:00:00 am' from db_root;


-- underflow
select cast(-9223372036854775808 as BIGINT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
-- underflow
select cast(-9223372036854775808 as BIGINT) + timestamptz '01/01/1970 09:00:01 am' from db_root;
-- overflow
select cast(-9223372036854775808 as BIGINT) + timestamptz '01/01/1970 09:00:00 am' from db_root;


-- add max
-- ok
select timestamptz '01/01/1970 09:00:00 am' + cast(32767 as SHORT) from db_root;
select timestamptz '01/01/1970 09:00:00 am' + cast(2147483647 as INTEGER) from db_root;
-- overflow
select timestamptz '01/01/1970 09:00:00 am' + cast(9223372036854775807 as BIGINT) from db_root;

-- ok(?)
select DATE '01/01/0001' + cast(32767 as SHORT) from db_root;
-- nok(year is negative value)
select DATE '01/01/0001' + cast(2147483647 as INTEGER) from db_root;
-- overflow
select DATE '01/01/0001' + cast(9223372036854775807 as BIGINT) from db_root;


-- ok(?)
select datetimetz '01/01/0001 00:00:00 am' + cast(32767 as SHORT) from db_root;
select datetimetz '01/01/0001 00:00:00 am' + cast(2147483647 as INTEGER) from db_root;
-- nok(wrong result)
select datetimetz '01/01/0001 00:00:00 am' + cast(9223372036854775807 as BIGINT) from db_root;
select datetimetz '12/31/9999 11:59:59 pm' + cast(9223372036854775807 as BIGINT) from db_root;


set system parameters 'compat_mode=mysql';

select cast(1 as SHORT) + DATE '09/01/2009' from db_root;
select DATE '09/01/2009' + cast(1 as SHORT) from db_root;
select cast(1 as SHORT) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select datetimetz '09/01/2009 03:30:30 pm' + cast(1 as SHORT) from db_root;
select cast(1 as SHORT) + timestamptz '09/01/2009 03:30:30 pm' from db_root;
select timestamptz '09/01/2009 03:30:30 pm' + cast(1 as SHORT) from db_root;

select cast(1 as INTEGER) + DATE '09/01/2009' from db_root;
select DATE '09/01/2009' + cast(1 as INTEGER) from db_root;
select cast(1 as INTEGER) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select datetimetz '09/01/2009 03:30:30 pm' + cast(1 as INTEGER) from db_root;
select cast(1 as INTEGER) + timestamptz '09/01/2009 03:30:30 pm' from db_root;
select timestamptz '09/01/2009 03:30:30 pm' + cast(1 as INTEGER) from db_root;

select cast(1 as BIGINT) + DATE '09/01/2009' from db_root;
select DATE '09/01/2009' + cast(1 as BIGINT) from db_root;
select cast(1 as BIGINT) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select datetimetz '09/01/2009 03:30:30 pm' + cast(1 as BIGINT) from db_root;
select cast(1 as BIGINT) + timestamptz '09/01/2009 03:30:30 pm' from db_root;
select timestamptz '09/01/2009 03:30:30 pm' + cast(1 as BIGINT) from db_root;



select cast(-1 as SHORT) + DATE '09/01/2009' from db_root;
select cast(-1 as SHORT) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select cast(-1 as SHORT) + timestamptz '09/01/2009 03:30:30 pm' from db_root;

select cast(-1 as INTEGER) + DATE '09/01/2009' from db_root;
select cast(-1 as INTEGER) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select cast(-1 as INTEGER) + timestamptz '09/01/2009 03:30:30 pm' from db_root;

select cast(-1 as BIGINT) + DATE '09/01/2009' from db_root;
select cast(-1 as BIGINT) + datetimetz '09/01/2009 03:30:30 pm' from db_root;
select cast(-1 as BIGINT) + timestamptz '09/01/2009 03:30:30 pm' from db_root;

-- overflow: max + max
select cast(32767 as SHORT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
select cast(2147483647 as INTEGER) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
select cast(9223372036854775807 as BIGINT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;

select cast(32767 as SHORT) + DATE '12/31/9999' from db_root;
select cast(2147483647 as INTEGER) + DATE '12/31/9999' from db_root;
select cast(9223372036854775807 as BIGINT) + DATE '12/31/9999' from db_root;

select cast(32767 as SHORT) + datetimetz '12/31/9999 11:59:59 pm' from db_root;
select cast(2147483647 as INTEGER) + datetimetz '12/31/9999 11:59:59 pm' from db_root;
select cast(9223372036854775807 as BIGINT) + datetimetz '12/31/9999 11:59:59 pm' from db_root;

-- max + 1
select cast(1 as SHORT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
select cast(1 as INTEGER) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
select cast(1 as BIGINT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;

select cast(1 as SHORT) + DATE '12/31/9999' from db_root;
select cast(1 as INTEGER) + DATE '12/31/9999' from db_root;
select cast(1 as BIGINT) + DATE '12/31/9999' from db_root;

select cast(1 as SHORT) + datetimetz '12/31/9999 11:59:59 pm' from db_root;
select cast(1 as INTEGER) + datetimetz '12/31/9999 11:59:59 pm' from db_root;
select cast(1 as BIGINT) + datetimetz '12/31/9999 11:59:59 pm' from db_root;


-- asymmetry
-- normal
select cast(-32768 as SHORT) + timestamptz '01/01/2009 09:00:01 am' from db_root;
-- underflow
select cast(-32768 as SHORT) + timestamptz '01/01/1970 09:00:01 am' from db_root;
-- overflow
select cast(-32768 as SHORT) + timestamptz '01/01/1970 09:00:00 am' from db_root;


-- underflow
select cast(-2147483648 as INTEGER) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
-- underflow
select cast(-2147483648 as INTEGER) + timestamptz '01/01/1970 09:00:01 am' from db_root;
-- overflow
select cast(-2147483648 as INTEGER) + timestamptz '01/01/1970 09:00:00 am' from db_root;


-- underflow
select cast(-9223372036854775808 as BIGINT) + timestamptz '01/19/2038 12:14:07 pm' from db_root;
-- underflow
select cast(-9223372036854775808 as BIGINT) + timestamptz '01/01/1970 09:00:01 am' from db_root;
-- overflow
select cast(-9223372036854775808 as BIGINT) + timestamptz '01/01/1970 09:00:00 am' from db_root;


-- add max
-- ok
select timestamptz '01/01/1970 09:00:00 am' + cast(32767 as SHORT) from db_root;
select timestamptz '01/01/1970 09:00:00 am' + cast(2147483647 as INTEGER) from db_root;
-- overflow
select timestamptz '01/01/1970 09:00:00 am' + cast(9223372036854775807 as BIGINT) from db_root;

-- ok(?)
select DATE '01/01/0001' + cast(32767 as SHORT) from db_root;
-- nok(year is negative value)
select DATE '01/01/0001' + cast(2147483647 as INTEGER) from db_root;
-- overflow
select DATE '01/01/0001' + cast(9223372036854775807 as BIGINT) from db_root;


-- ok(?)
select datetimetz '01/01/0001 00:00:00 am' + cast(32767 as SHORT) from db_root;
select datetimetz '01/01/0001 00:00:00 am' + cast(2147483647 as INTEGER) from db_root;
-- nok(wrong result)
select datetimetz '01/01/0001 00:00:00 am' + cast(9223372036854775807 as BIGINT) from db_root;
select datetimetz '12/31/9999 11:59:59 pm' + cast(9223372036854775807 as BIGINT) from db_root;


set system parameters 'compat_mode=cubrid';



commit;
autocommit on;
