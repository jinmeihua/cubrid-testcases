-- [er] create vclass using Constraints not null,Unique and SHARED

create vclass t1 (
c1 int  SHARED 9 not null Unique
);

drop t1;