select organization, first_name, last_name, email,

how_using
,received_at
,context_language

,uilanguage,
(select count(*) uploads
from bloomapp.upload_book_success up
where up.user_id = users.id)
from bloomapp.users 
order BY uploads DESC, organization
