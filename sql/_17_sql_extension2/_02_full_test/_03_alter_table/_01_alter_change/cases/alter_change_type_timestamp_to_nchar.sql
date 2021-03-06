--+ holdcas on;
--alter_table_change_type_strict
--change the type of a timestamp column to nchar

create class coo(
        col1 timestamp,
        col2 timestamp,
        col3 timestamp
);

insert into coo
 values('2011-3-21 09:45:56 am', '13:24:58 PM 1999-12-12', '8:56:34 09/12/2023');


show columns in coo;


--timestamp -> nchar, new prec = 22
alter table coo change col1 col1 nchar(22);
select * from coo order by 1;

--timestamp -> nchar, new prec > 22
alter table coo change col2 col2 nchar(24);
select * from coo order by 1;

--timestamp -> nchar, new prec < 22
set system parameters 'alter_table_change_type_strict=yes';
alter table coo change col3 col3 nchar(20);
set system parameters 'alter_table_change_type_strict=no';
alter table coo change col3 col3 nchar(20);
select * from coo order by 1;


show columns in coo;

drop table coo;


commit;
--+ holdcas off;
