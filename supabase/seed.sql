insert into copyfuse.networks (code, name, description)
select 'global', 'Global', 'Global Network';

INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '4f59d7c4-7ad1-4761-b10b-8f88d6d5c28c', '{"action":"user_confirmation_requested","actor_id":"b08a76be-73f8-4989-b633-e9ba8815dda5","actor_username":"ctrl@copyfuse.io","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2023-10-10 10:12:39.735745+00', '');

INSERT INTO auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method) VALUES ('bf13f700-c03f-4371-973b-2e08c13f7612', 'b08a76be-73f8-4989-b633-e9ba8815dda5', '5d4b9abe-e6cc-45b9-9ec2-090c23da1034', 's256', '2Vkyd8jfPNU6C1JKdeSU1Z-HbhS-na9Gu8o_9cfxv1s', 'email', '', '', '2023-10-10 10:12:39.737182+00', '2023-10-10 10:12:39.737182+00', 'email/signup');

INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at) VALUES ('00000000-0000-0000-0000-000000000000', 'b08a76be-73f8-4989-b633-e9ba8815dda5', 'authenticated', 'authenticated', 'ctrl@copyfuse.io', '$2a$10$cGMYKrUBtrtjV8/hOWhr2euJnUC7FnXgxeFqjEP5kM/gCKyNmihAy', NULL, NULL, 'pkce_6c5898203a0329bb519ff3a40cd2ddd58caf3423a35fce3cb377049c', '2023-10-10 10:12:39.738484+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2023-10-10 10:12:39.725038+00', '2023-10-10 10:12:39.748731+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL);

INSERT INTO auth.identities (id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at) VALUES ('b08a76be-73f8-4989-b633-e9ba8815dda5', 'b08a76be-73f8-4989-b633-e9ba8815dda5', '{"sub": "b08a76be-73f8-4989-b633-e9ba8815dda5", "email": "ctrl@copyfuse.io"}', 'email', '2023-10-10 10:12:39.734722+00', '2023-10-10 10:12:39.734753+00', '2023-10-10 10:12:39.734753+00');

INSERT INTO copyfuse.networks_members (id, created_at, networks, members) VALUES (1, '2023-10-10 08:48:15.658292+00', 1, 1);
SELECT pg_catalog.setval('copyfuse.networks_members_id_seq', 1, true);