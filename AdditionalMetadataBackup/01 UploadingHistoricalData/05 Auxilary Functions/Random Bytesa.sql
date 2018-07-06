create or replace function public.random_bytea(p_length in integer) returns bytea language plpgsql as $$
declare
  o bytea := '';
begin 
  for i in 1..p_length loop
    o := o||decode(lpad(to_hex(width_bucket(random(), 0, 1, 256)-1),2,'0'), 'hex');
  end loop;
  return o;
end;$$;