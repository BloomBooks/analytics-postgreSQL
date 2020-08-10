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
        shellDownloads BIGINT,
        pdfDownloads BIGINT,
        epubDownloads BIGINT,
        bloompubDownloads BIGINT,
        numQuestionsInBook BIGINT,
        numQuizzesTaken BIGINT,
        meanPctQuestionsCorrect NUMERIC,
        medianPctQuestionsCorrect NUMERIC)
AS $$

DECLARE

BEGIN
    RETURN QUERY    

    SELECT
            COALESCE(reads.bookInstanceId, comp.bookInstanceId, downloads.bookInstanceId) AS bookInstanceId,
            COALESCE(reads.bookTitle, comp.bookTitle, downloads.bookTitle) AS bookTitle,
            COALESCE(reads.bookBranding, comp.bookBranding, downloads.bookBranding) AS bookBranding,
            reads.language, 
            reads.started , 
            reads.finished,
            downloads.shellDownloads,
            downloads.pdfDownloads,
            downloads.epubDownloads,
            downloads.bloompubDownloads,
            comp.numQuestionsInBook,
            comp.numQuizzesTaken,
            comp.meanPctCorrect,
            comp.medianPctCorrect
    FROM common.get_reading_perbook_base_events(p_useBookIds, p_from, p_to, p_branding, p_country) reads

    FULL OUTER JOIN common.get_reading_perbook_comprehension_events(p_useBookIds, p_from, p_to, p_branding, p_country) comp
            ON reads.bookInstanceId = comp.bookInstanceId

    -- Full outer join, because it should be possible for a book to be downloaded but not read.
    FULL OUTER JOIN common.get_reading_perbook_download_events(p_useBookIds, p_from, p_to, p_branding, p_country) downloads
        ON reads.bookInstanceId = downloads.bookInstanceId

    ;
END; $$

LANGUAGE 'plpgsql';

