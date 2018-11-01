--https://database.guide/json_array_insert-insert-values-into-a-json-array-in-mysql/

--http://jira.cubrid.org/browse/CBRD-22469
SELECT JSON_ARRAY_INSERT('[1, 2, 3]', '$[1]', '4');
SELECT JSON_ARRAY_INSERT('[1, 2, 3]', '$[1]', 4);

SELECT JSON_ARRAY_INSERT('[1, 2, [3, 4]]', '$[2][1]', '5');
SELECT JSON_ARRAY_INSERT('[1, 2, [3, 4]]', '$[2][1]', 5);

SET @jv = '{  
    "Person": {    
       "Name": "Homer", 
       "Hobbies": ["Eating", "Sleeping"]  
    }
}';

--http://jira.cubrid.org/browse/CBRD-22469
SELECT JSON_ARRAY_INSERT(@jv, '$.Person.Hobbies[1]', 'Base Jumping') ;
SELECT JSON_ARRAY_INSERT(@jv, '$.Person.Hobbies[1]', "Base Jumping") ;
SELECT JSON_ARRAY_INSERT(@jv, '$.Person.Hobbies[1]', '"Base Jumping"') ;
SELECT JSON_ARRAY_INSERT(@jv, '$.Person.Hobbies[1]', '""Base Jumping""') ;

SELECT JSON_ARRAY_INSERT('{  
    "Person": {    
       "Name": "Homer", 
       "Hobbies": ["Eating", "Sleeping"]  
    }
}', '$.Person.Hobbies[1]', 'Base Jumping') ;

SELECT JSON_ARRAY_INSERT('{  
    "Person": {    
       "Name": "Homer", 
       "Hobbies": ["Eating", "Sleeping"]  
    }
}', '$.Person.Hobbies[1]', '"Base Jumping"') ;

drop variable @jv;

