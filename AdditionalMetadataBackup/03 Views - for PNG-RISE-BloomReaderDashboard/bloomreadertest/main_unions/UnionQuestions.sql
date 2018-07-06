REVOKE SELECT ON bloomreadertest.UnionQuestions FROM readbloomtester;
DROP VIEW bloomreadertest.UnionQuestions CASCADE;

CREATE VIEW bloomreadertest.UnionQuestions AS
	SELECT * FROM bloomreader.questions_correct 
	UNION ALL
	SELECT * FROM bloomreaderbeta.questions_correct; 
--	UNION ALL
--	SELECT * FROM bloomreadertest.questions_correct ;  

GRANT SELECT ON bloomreadertest.UnionQuestions TO readbloomtester;
select * FROM bloomreadertest.UnionQuestions ;