--+ holdcas on;
SET @j = '["abc", [{"k": "10"}, "def"], {"x":"abc"}, {"y":"bcd"}]';
SELECT JSON_SEARCH(@j, 'all', '%b%', NULL, '$[3].');
DROP VARIABLE @j;

--+ holdcas off;
