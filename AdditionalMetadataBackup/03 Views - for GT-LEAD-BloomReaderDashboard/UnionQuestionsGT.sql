REVOKE SELECT ON bloomreader.UnionQuestionsGT FROM bloomreaderuser;
DROP VIEW bloomreader.UnionQuestionsGT CASCADE;

CREATE VIEW bloomreader.UnionQuestionsGT AS
	SELECT * FROM bloomreader.questions_correct 
	UNION ALL
	SELECT * FROM bloomreaderbeta.questions_correct; 

GRANT SELECT ON bloomreader.UnionQuestionsGT TO bloomreaderuser;
select * FROM bloomreader.UnionQuestionsGT ;