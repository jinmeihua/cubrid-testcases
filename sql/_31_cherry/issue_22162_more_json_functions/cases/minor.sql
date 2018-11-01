SET @jv = '{  
    "Person": {    
       "Name": "Homer", 
       "Age": 39,
       "Hobbies": ["Eating", "Sleeping"]  
    }
 }';
 
--CBRD- Function JSON_LENGTH is undefined or given wrong number of parameter.
SELECT JSON_LENGTH(@jv, '$.Person') ;
SELECT JSON_LENGTH(@jv) ;
SELECT JSON_LENGTH(json_extract(@jv, '$.Person')) ;


--CBRD- diff with MySQL
--json_object: MySQL returns ordered result, CUBRID will follow input order. Is it an issue?
select json_object('B', 1, 'A',1);
select json_pretty(json_object('B', 1, 'A',1));
--CUBRID {"B":1,"A":1}
--MySQL  {"A": 1, "B": 1}           


select json_array('B', 1, 'A',1);
select json_pretty(json_object('B', 1, 'A',1));

