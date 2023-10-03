set check_function_bodies = off;

CREATE OR REPLACE FUNCTION copyfuse.on_auth_users_insert()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
declare
  member_id bigint;
  slack_channel text;
  slack_token text;
  slack_headers jsonb;
begin
  insert into copyfuse.members(email, user_id)
  values (new.email, new.id)
  returning id into member_id;
  
  insert into copyfuse.activities(members, activity_category, activity_json)
  values (member_id, 'auth.create', JSONB_BUILD_OBJECT('user_id', new.id));

  select decrypted_secret into slack_token
  from vault.decrypted_secrets
  where name = 'slack_notification_token';

  select decrypted_secret into slack_channel
  from vault.decrypted_secrets
  where name = 'slack_notification_channel';

  if slack_token is not null and slack_channel is not null then
    slack_headers := JSONB_BUILD_OBJECT(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer ' || slack_token
    );
    
    perform
      net.http_post(
          url:='https://slack.com/api/chat.postMessage',
          headers:=slack_headers,
          body:=JSONB_BUILD_OBJECT('channel', slack_channel, 'text', 'New member registration received from ' || new.email)
      ) as request_id;
  end if;

  return new;
end;
$function$
;


