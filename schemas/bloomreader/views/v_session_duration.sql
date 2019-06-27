-- TODO: For review by Andrew
 with allpairs as
    (with open as
         (select time_utc as time_opened,
                 anonymous_id,
                 book_title,
                 'open'
          from bloomreader.v_book_or_shelf_opened
          ORDER BY time_utc
          limit 100), close as
         (select time_utc as time_closed,
                 anonymous_id,
                 book_title,
                 'close'
          from bloomreader.v_pages_read
          ORDER BY time_utc
          limit 100) select ROW_NUMBER() OVER (PARTITION BY time_opened
                                               ORDER BY time_closed ASC) AS rownumber,
                                              (time_closed - time_opened) as diff,
                                              time_opened,
                                              time_closed,
                                              open.book_title,
                                              open.anonymous_id -- review should that partition be a combination of time_opened and anonymous_id?

     from open
     inner join close on open.anonymous_id = close.anonymous_id
     AND open.book_title = close.book_title
     where time_closed > time_opened
     order by time_opened,
              time_closed)
select *
from allpairs
WHERE allpairs.rownumber = 1
GROUP BY allpairs.anonymous_id,
         allpairs.book_title,
         allpairs.time_opened,
         rownumber,
         allpairs.diff,
         allpairs.time_closed ;