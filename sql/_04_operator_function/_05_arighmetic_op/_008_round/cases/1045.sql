--test round function using time and other types as its operand
select round(time'8:8:8 am', 10) from db_root;
select round(time'8:8:8 am', 10.12) from db_root;
select round(time'8:8:8 am', time'8:8:8 am') from db_root;
select round(time'8:8:8 am', date'6/6/2006') from db_root;
select round(time'8:8:8 am', timestamp'5/5/2005 8:8:8 am') from db_root;
select round(time'8:8:8 am', 'char') from db_root;
select round(time'8:8:8 am', b'0001000') from db_root order by 1;