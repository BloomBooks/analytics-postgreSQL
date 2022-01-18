CREATE OR REPLACE FUNCTION public.generate_event_id () RETURNS TEXT AS $$
DECLARE
  output TEXT := '';
BEGIN
    output := CONCAT(generate_uid(8),'-',generate_uid(4),'-',generate_uid(4),'-',generate_uid(4),'-',generate_uid(12));
  RETURN output;
END;
$$ LANGUAGE plpgsql VOLATILE;

select generate_event_id ();