--https://database.guide/json_search-find-the-path-to-a-string-in-a-json-document-in-mysql/

--http://jira.cubrid.org/browse/CBRD-22452
SELECT JSON_SEARCH('{"Name": "Bart", "Age": 10}', 'one', 'Bart') ; 
  
SET @doc = '{"Name": "Bart", "Hobbies": ["Skateboarding", "Mischief"]}';
--http://jira.cubrid.org/browse/CBRD-22473
SELECT JSON_SEARCH(@doc, 'one', 'Mischief') ; 
SELECT JSON_SEARCH(@doc, 'one', 'Homer') ; 

SET @doc = '{"Name": "Bart", "Friends": ["Bart", "Milhouse"]}';
SELECT JSON_SEARCH(@doc, 'one', 'Bart') ; 
SELECT JSON_SEARCH(@doc, 'all', 'Bart') ; 

SET @doc = '{"Name": "Bart", "Hobbies": ["Skateboarding", "Mischief"]}';
SELECT JSON_SEARCH(@doc, 'one', 'Skate%') ; 

SET @doc = '{"Name": "Bart", "Hobbies": ["Skateboarding", "Mischief"]}';
SELECT JSON_SEARCH(@doc, 'one', 'Bar_') ; 


SET @doc = '{"Name": "Bart", "Hobbies": ["Skateboarding", "Mischief"]}';
SELECT JSON_SEARCH(@doc, 'one', 'Skate_') ; 

SET @doc = '{"userid": "bart_simpson", "pwd": "pass%word"}';
SELECT JSON_SEARCH(@doc, 'one', 'pass\%word') ; 

SET @doc = '{"userid": "bart_simpson", "pwd": "pass%word"}';
SELECT JSON_SEARCH(@doc, 'one', 'pass%word') ; 

SET @doc = '{"userid": "bart_simpson", "pwd": "pass%BLAH-BLAH-BLAH-word"}';
SELECT JSON_SEARCH(@doc, 'one', 'pass%word') ; 

SET @doc = '{"userid": "bart_simpson", "pwd": "pass%word"}';
SELECT 
  JSON_SEARCH(@doc, 'one', 'bart\_simpson') ,
  JSON_SEARCH(@doc, 'one', 'bart_simpson')  ;
 
SET @doc = '{"userid": "bartJsimpson", "pwd": "pass%word"}';
SELECT 
  JSON_SEARCH(@doc, 'one', 'bart\_simpson') ,
  JSON_SEARCH(@doc, 'one', 'bart_simpson')  ;

SET @doc = '{"userid": "bart_simpson", "pwd": "pass%word"}';
SELECT 
  JSON_SEARCH(@doc, 'one', 'bart$_simpson', '$') ,
  JSON_SEARCH(@doc, 'one', 'bart_simpson')  ;

SET @doc = '{"userid": "bartJsimpson", "pwd": "pass%word"}';
SELECT 
  JSON_SEARCH(@doc, 'one', 'bart$_simpson', '$') ,
  JSON_SEARCH(@doc, 'one', 'bart_simpson')  ;
  
SET @jv = '{  
    "Person": {    
       "Name": "Bart", 
       "Age": 10,
       "Friends": ["Bart", "Milhouse"]  
    }
 }';
SELECT JSON_SEARCH(@jv, 'all', 'Bart', NULL, '$.Person.Friends') ; 


SET @jv = '{  
    "Person": {    
       "Name": "Bart", 
       "Age": 10,
       "Friends": ["Bart", "Milhouse"]  
    }
 }';
SELECT JSON_SEARCH(@jv, 'all', 'Bart') ; 

SET @jv = '{  
    "Person": {    
       "Name": "Bart", 
       "Age": 10,
       "Friends": ["Bart", "Milhouse"]  
    }
 }';
SELECT JSON_SEARCH(@jv, 'one', 'Bart') ; 

SELECT 
  JSON_SEARCH('{}', 'all', 'Bart') ; 
  
  
drop variable @jv,@doc;

