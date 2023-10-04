set check_function_bodies = off;

CREATE OR REPLACE FUNCTION swiss.ttl_data_removal()
 RETURNS integer
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
begin
  delete from swiss.entities
  where expires_at < now();

  delete from swiss.attachments
  where entities is null;

  return 1;
end;
$function$
;


