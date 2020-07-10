--DROP FUNCTION common.get_reading_perbook_comprehension_events(BOOLEAN, DATE, DATE, TEXT, TEXT);

CREATE OR REPLACE FUNCTION common.get_reading_perbook_comprehension_events(
    p_useBookIds BOOLEAN,
	p_from DATE DEFAULT DATE(20000101::TEXT), 
    p_to DATE DEFAULT DATE(30000101::TEXT),
    p_branding TEXT DEFAULT NULL, 
    p_country TEXT DEFAULT NULL)
RETURNS TABLE (
    bookInstanceId TEXT, 
    bookTitle TEXT, 
    bookBranding TEXT, 
    numQuestionsInBook BIGINT,
    numQuizzesTaken BIGINT,
    meanPctCorrect NUMERIC,
    medianPctCorrect NUMERIC)

AS $$

DECLARE

BEGIN

IF p_useBookIds
THEN
    RETURN QUERY

        SELECT  c.book_instance_id AS bookInstanceId,
                MODE() WITHIN GROUP (ORDER BY book_title) AS book_title,
                book_branding,
                MODE() WITHIN GROUP (ORDER BY question_count) AS numQuestionsInBook,
                count(*) AS numQuizzesTaken,
                round(avg(percent_right), 0) AS meanPctQuestionsCorrect,
                round(public.median(CAST(percent_right AS NUMERIC)), 0) AS medianPctQuestionsCorrect
        FROM    common.mv_comprehension c,
                temp_book_ids b
        WHERE   c.book_instance_id = b.book_instance_id AND
                date_local >= p_from AND 
                date_local <= p_to
        group by c.book_instance_id,
                c.book_branding;

ELSE
        RETURN QUERY    

        SELECT  book_instance_id AS bookInstanceId,
                MODE() WITHIN GROUP (ORDER BY book_title) AS book_title,
                book_branding,
                MODE() WITHIN GROUP (ORDER BY question_count) AS numQuestionsInBook,
                count(*) AS numQuizzesTaken,
                round(avg(percent_right), 0) AS meanPctQuestionsCorrect,
                round(public.median(CAST(percent_right AS NUMERIC)), 0) AS medianPctQuestionsCorrect
        FROM    common.mv_comprehension
        WHERE   book_instance_id is not null AND
                (p_branding IS NULL OR book_branding = p_branding) AND
                (p_country IS NULL OR country = p_country) AND        
                date_local >= p_from AND 
                date_local <= p_to
        group by book_instance_id,
                book_branding;
END IF;
END; $$


LANGUAGE 'plpgsql';