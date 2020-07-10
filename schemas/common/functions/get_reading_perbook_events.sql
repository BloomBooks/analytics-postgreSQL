-- DROP FUNCTION common.get_reading_perbook_events(boolean, date, date, text, text);

CREATE OR REPLACE FUNCTION common.get_reading_perbook_events(
    p_useBookIds BOOLEAN,
	p_from DATE DEFAULT DATE(20000101::TEXT), 
    p_to DATE DEFAULT DATE(30000101::TEXT),
    p_branding TEXT DEFAULT NULL, 
    p_country TEXT DEFAULT NULL)
RETURNS TABLE (
        bookInstanceId TEXT,
        bookTitle TEXT, 
        bookBranding TEXT, 
        language TEXT, 
        started BIGINT, 
        finished BIGINT,
        numQuestionsInBook BIGINT,
        numQuizzesTaken BIGINT,
        meanPctQuestionsCorrect NUMERIC,
        medianPctQuestionsCorrect NUMERIC)
AS $$

DECLARE

BEGIN
    RETURN QUERY    

    SELECT
            reads.*,
            comp.numQuestionsInBook,
            comp.numQuizzesTaken,
            comp.meanPctCorrect,
            comp.medianPctCorrect
    FROM common.get_reading_perbook_base_events(p_useBookIds, p_from, p_to, p_branding, p_country) reads

    -- Assumption: All comprehension events are also supposed to have a pages_read event,
    --             so we assume that it's not possible to have a comprehension event w/o it.
    --             This allows us to do a LEFT outer join instead of FULL (and not need to handle the left side's title/branding being possibly null)
    LEFT OUTER JOIN common.get_reading_perbook_comprehension_events(p_useBookIds, p_from, p_to, p_branding, p_country) comp
            ON reads.bookInstanceId = comp.bookInstanceId
    ;
END; $$

LANGUAGE 'plpgsql';

