SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") FROM stdin;
00000000-0000-0000-0000-000000000000	076a1540-1d23-4aac-92c7-973cf8efc644	{"action":"user_confirmation_requested","actor_id":"800058f5-8936-432a-9a49-dbecb66820cf","actor_username":"foo@foo.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 09:46:59.472919+00	
00000000-0000-0000-0000-000000000000	eb2a191e-2cef-4cbf-b9da-50970a61439f	{"action":"user_confirmation_requested","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 09:47:35.202579+00	
00000000-0000-0000-0000-000000000000	6ce4f120-2ea9-4894-a036-b4a21df6ca2e	{"action":"user_signedup","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"team"}	2025-06-22 09:49:12.221631+00	
00000000-0000-0000-0000-000000000000	b9014b6d-5c0b-4e88-bccb-87ea27dd079f	{"action":"token_refreshed","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 10:47:22.469494+00	
00000000-0000-0000-0000-000000000000	9fe3c9ae-c62f-4e47-bdb2-7e3686b79083	{"action":"token_revoked","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 10:47:22.470435+00	
00000000-0000-0000-0000-000000000000	8fe8ff8c-de8b-4edd-8400-8c5b5e0bcfc4	{"action":"user_confirmation_requested","actor_id":"a28d9797-4a51-4f09-895c-3f10178e8a38","actor_username":"foo4@foo.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 11:13:45.565489+00	
00000000-0000-0000-0000-000000000000	df86cc8c-1f48-44d4-b971-b33ede5de330	{"action":"login","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-22 11:14:05.907165+00	
00000000-0000-0000-0000-000000000000	90a15595-3e0a-4c97-b6e0-377ab901f534	{"action":"token_refreshed","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 12:12:11.451435+00	
00000000-0000-0000-0000-000000000000	352f5098-a458-4309-8581-5c4f2c655105	{"action":"token_revoked","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 12:12:11.452242+00	
00000000-0000-0000-0000-000000000000	038f659e-74a7-4b28-97af-3c37c46c4b42	{"action":"token_refreshed","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 12:38:11.293755+00	
00000000-0000-0000-0000-000000000000	caf902fc-d536-4ab9-8248-d714da056310	{"action":"token_revoked","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 12:38:11.294809+00	
00000000-0000-0000-0000-000000000000	d3285573-d661-4874-89e4-65fb50705d75	{"action":"login","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-22 17:49:28.44501+00	
00000000-0000-0000-0000-000000000000	f9fcf103-efe4-428c-8fa1-5118a4374d47	{"action":"login","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-22 17:56:11.196924+00	
00000000-0000-0000-0000-000000000000	33830874-aeae-4470-9d71-e257ba2c8ba8	{"action":"token_refreshed","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 18:47:44.978414+00	
00000000-0000-0000-0000-000000000000	e77eedad-a552-4660-8241-cc3e8d5a50b9	{"action":"token_revoked","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 18:47:44.979386+00	
00000000-0000-0000-0000-000000000000	8722a569-b7d9-4d41-b4a1-574c40223002	{"action":"user_confirmation_requested","actor_id":"800058f5-8936-432a-9a49-dbecb66820cf","actor_username":"foo@foo.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 18:56:17.91131+00	
00000000-0000-0000-0000-000000000000	c28b0b2e-9fce-4e70-851c-15a3f4c997d2	{"action":"user_repeated_signup","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 18:56:37.48697+00	
00000000-0000-0000-0000-000000000000	c2d84e2a-7a37-4f9a-b09a-392ced8b6d07	{"action":"user_repeated_signup","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 18:56:41.27255+00	
00000000-0000-0000-0000-000000000000	6c3d25b3-db5f-42c3-9eb1-25048f61e8c6	{"action":"user_confirmation_requested","actor_id":"6bd8c17c-8047-4d8d-9429-53d1b205fd45","actor_username":"foo2@foo.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 19:03:23.973121+00	
00000000-0000-0000-0000-000000000000	2978ff7b-36f3-4639-969b-e19d207010d2	{"action":"user_confirmation_requested","actor_id":"dfe26057-ab9f-4e51-861d-a252a8cebc81","actor_username":"foo3@foo.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 19:06:06.315239+00	
00000000-0000-0000-0000-000000000000	45cd0788-7fc7-47fb-bdcc-90db0cec7ef1	{"action":"token_refreshed","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 19:13:09.462948+00	
00000000-0000-0000-0000-000000000000	7ac08f11-9cae-4420-b4ed-704efad5e510	{"action":"token_revoked","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 19:13:09.463848+00	
00000000-0000-0000-0000-000000000000	58301fd5-8b79-4b2b-a887-370c953a4631	{"action":"user_confirmation_requested","actor_id":"1685e6ab-2a8d-430e-82f4-e53ee1d8c428","actor_username":"foo5@foo.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 19:18:08.67053+00	
00000000-0000-0000-0000-000000000000	6919b524-4564-407f-b246-d3e27b14f25d	{"action":"user_confirmation_requested","actor_id":"d8c4cf9a-55d8-4750-8a04-57a10fa281c6","actor_username":"demo@wordwise.ai","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 19:18:51.697259+00	
00000000-0000-0000-0000-000000000000	d9dbe620-8f1b-43a1-af9b-519f614d3ed0	{"action":"user_confirmation_requested","actor_id":"dfe26057-ab9f-4e51-861d-a252a8cebc81","actor_username":"foo3@foo.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-22 21:29:45.261093+00	
00000000-0000-0000-0000-000000000000	7dacc1a7-6bef-4c1a-82ce-d10f3c77796a	{"action":"login","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-22 22:02:24.868789+00	
00000000-0000-0000-0000-000000000000	4b2951ad-1ff7-4472-83b2-9b04d721ce82	{"action":"token_refreshed","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 23:49:59.691091+00	
00000000-0000-0000-0000-000000000000	1d41e703-f9f0-4b57-9104-71b37946fa61	{"action":"token_revoked","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-22 23:49:59.692047+00	
00000000-0000-0000-0000-000000000000	b72a6f60-3250-48ed-8e87-1af3d78d9e28	{"action":"token_refreshed","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-23 02:01:01.768784+00	
00000000-0000-0000-0000-000000000000	8b5a7abd-e377-4b70-b8e6-522bcffbb006	{"action":"token_revoked","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-23 02:01:01.769777+00	
00000000-0000-0000-0000-000000000000	d8bad138-a90e-4501-bff0-f931fa579a71	{"action":"token_refreshed","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-23 16:47:39.555278+00	
00000000-0000-0000-0000-000000000000	e8de7be1-a4b4-4836-a9ee-fd5444893a26	{"action":"token_revoked","actor_id":"2a633387-aae8-4e7a-bb7b-8c6604e98ca9","actor_username":"dingbatstevens@me.com","actor_via_sso":false,"log_type":"token"}	2025-06-23 16:47:39.556288+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") FROM stdin;
00000000-0000-0000-0000-000000000000	d8c4cf9a-55d8-4750-8a04-57a10fa281c6	authenticated	authenticated	demo@wordwise.ai	$2a$10$jfwNQrhzWoVi.E5xk1tNgezL8S41D4zmvlEh5227Uh7Y1Yr1pxBr.	\N	\N	600ea4c76d7f7e0e9028d3685ac66841b5c264e2c424dcd03359e0c7	2025-06-22 19:18:51.697815+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "d8c4cf9a-55d8-4750-8a04-57a10fa281c6", "email": "demo@wordwise.ai", "email_verified": false, "phone_verified": false}	\N	2025-06-22 19:18:51.692817+00	2025-06-22 19:18:52.88062+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	800058f5-8936-432a-9a49-dbecb66820cf	authenticated	authenticated	foo@foo.com	$2a$10$aBuX.2BDTJ.mxlCxiGRlfOZQehnnLoVWIq8AjvJagOY.8f0kT5L/a	\N	\N	19591201bd0ea70609175ccd5c08e443edd278a2e3def32fd1e2c484	2025-06-22 18:56:17.912257+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "800058f5-8936-432a-9a49-dbecb66820cf", "email": "foo@foo.com", "email_verified": false, "phone_verified": false}	\N	2025-06-22 09:46:59.460839+00	2025-06-22 18:56:19.162738+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	dfe26057-ab9f-4e51-861d-a252a8cebc81	authenticated	authenticated	foo3@foo.com	$2a$10$vvy0zkUGdsZL2ZkcI/EAwuBcXfM30wD40UQWIP1FaNYPC0T7T8Syi	\N	\N	af74b6a7118caae12bb6d328692b1b5946d508f8b52c0d66100e01d1	2025-06-22 21:29:45.262311+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "dfe26057-ab9f-4e51-861d-a252a8cebc81", "email": "foo3@foo.com", "email_verified": false, "phone_verified": false}	\N	2025-06-22 19:06:06.308603+00	2025-06-22 21:29:46.499868+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a28d9797-4a51-4f09-895c-3f10178e8a38	authenticated	authenticated	foo4@foo.com	$2a$10$V5nTI.2rDOk3gvziA5zUt.tQ1TC98URDvG8tP06vyP1yiXDgoj63W	\N	\N	252e7a90897795fe6e3033bbabbc0cd872de2a7e054082fc948a5ec9	2025-06-22 11:13:45.566246+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "a28d9797-4a51-4f09-895c-3f10178e8a38", "email": "foo4@foo.com", "email_verified": false, "phone_verified": false}	\N	2025-06-22 11:13:45.558819+00	2025-06-22 11:13:46.779949+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	authenticated	authenticated	dingbatstevens@me.com	$2a$10$bsFLYatk6Jz7s.FNnRH6G.NGcia5djCgN/IwqGzuUaH8vVjg9Jqle	2025-06-22 09:49:12.222491+00	\N		2025-06-22 09:47:35.203228+00		\N			\N	2025-06-22 22:02:24.86978+00	{"provider": "email", "providers": ["email"]}	{"sub": "2a633387-aae8-4e7a-bb7b-8c6604e98ca9", "email": "dingbatstevens@me.com", "email_verified": true, "phone_verified": false}	\N	2025-06-22 09:47:35.197276+00	2025-06-23 16:47:39.561022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6bd8c17c-8047-4d8d-9429-53d1b205fd45	authenticated	authenticated	foo2@foo.com	$2a$10$zhQ3W.Jd9GyIlmy3btkvKuHuzwWWrOamqD.DaBjiPxHCfFy3/zm/G	\N	\N	ef9e365cec2e1e353ff9d2ebae1ddc33b2bab5728178b71c2be45836	2025-06-22 19:03:23.973853+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "6bd8c17c-8047-4d8d-9429-53d1b205fd45", "email": "foo2@foo.com", "email_verified": false, "phone_verified": false}	\N	2025-06-22 19:03:23.966815+00	2025-06-22 19:03:25.180508+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	1685e6ab-2a8d-430e-82f4-e53ee1d8c428	authenticated	authenticated	foo5@foo.com	$2a$10$Qf8TixGpXSbdsYT2zWLK2u3SrIX0zTTYfxlZlfWs.mrie0rUZK0vG	\N	\N	35e593026d803d5e27c19cccbb1e6c5d05d27b95dd1cc6f1afc69e37	2025-06-22 19:18:08.671267+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "1685e6ab-2a8d-430e-82f4-e53ee1d8c428", "email": "foo5@foo.com", "email_verified": false, "phone_verified": false}	\N	2025-06-22 19:18:08.66431+00	2025-06-22 19:18:10.095456+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") FROM stdin;
800058f5-8936-432a-9a49-dbecb66820cf	800058f5-8936-432a-9a49-dbecb66820cf	{"sub": "800058f5-8936-432a-9a49-dbecb66820cf", "email": "foo@foo.com", "email_verified": false, "phone_verified": false}	email	2025-06-22 09:46:59.469712+00	2025-06-22 09:46:59.469762+00	2025-06-22 09:46:59.469762+00	8d07abd5-676a-4cc9-9612-5464db54836e
2a633387-aae8-4e7a-bb7b-8c6604e98ca9	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	{"sub": "2a633387-aae8-4e7a-bb7b-8c6604e98ca9", "email": "dingbatstevens@me.com", "email_verified": true, "phone_verified": false}	email	2025-06-22 09:47:35.199552+00	2025-06-22 09:47:35.1996+00	2025-06-22 09:47:35.1996+00	1ffdbd0e-3e00-4c9e-b673-7d6017a7e383
a28d9797-4a51-4f09-895c-3f10178e8a38	a28d9797-4a51-4f09-895c-3f10178e8a38	{"sub": "a28d9797-4a51-4f09-895c-3f10178e8a38", "email": "foo4@foo.com", "email_verified": false, "phone_verified": false}	email	2025-06-22 11:13:45.562626+00	2025-06-22 11:13:45.562678+00	2025-06-22 11:13:45.562678+00	413d0272-5a49-4cc9-a5f8-73b9f95c13a5
6bd8c17c-8047-4d8d-9429-53d1b205fd45	6bd8c17c-8047-4d8d-9429-53d1b205fd45	{"sub": "6bd8c17c-8047-4d8d-9429-53d1b205fd45", "email": "foo2@foo.com", "email_verified": false, "phone_verified": false}	email	2025-06-22 19:03:23.97028+00	2025-06-22 19:03:23.970329+00	2025-06-22 19:03:23.970329+00	27ede5b2-eb07-400b-a05e-68147b0ed77e
dfe26057-ab9f-4e51-861d-a252a8cebc81	dfe26057-ab9f-4e51-861d-a252a8cebc81	{"sub": "dfe26057-ab9f-4e51-861d-a252a8cebc81", "email": "foo3@foo.com", "email_verified": false, "phone_verified": false}	email	2025-06-22 19:06:06.31237+00	2025-06-22 19:06:06.31242+00	2025-06-22 19:06:06.31242+00	6c715fca-6085-4749-bb83-61db5cc8cbec
1685e6ab-2a8d-430e-82f4-e53ee1d8c428	1685e6ab-2a8d-430e-82f4-e53ee1d8c428	{"sub": "1685e6ab-2a8d-430e-82f4-e53ee1d8c428", "email": "foo5@foo.com", "email_verified": false, "phone_verified": false}	email	2025-06-22 19:18:08.667758+00	2025-06-22 19:18:08.667816+00	2025-06-22 19:18:08.667816+00	dbc75225-a3cb-481e-9532-07b59a2c5acc
d8c4cf9a-55d8-4750-8a04-57a10fa281c6	d8c4cf9a-55d8-4750-8a04-57a10fa281c6	{"sub": "d8c4cf9a-55d8-4750-8a04-57a10fa281c6", "email": "demo@wordwise.ai", "email_verified": false, "phone_verified": false}	email	2025-06-22 19:18:51.695196+00	2025-06-22 19:18:51.695243+00	2025-06-22 19:18:51.695243+00	3951270b-a3c8-4991-9ee8-55bc6e5e63ee
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."instances" ("id", "uuid", "raw_base_config", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag") FROM stdin;
2d374921-2cbd-4055-8c30-8e4214adce6d	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	2025-06-22 11:14:05.90801+00	2025-06-22 12:12:11.456051+00	\N	aal1	\N	2025-06-22 12:12:11.455976	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	23.93.140.255	\N
952ae25b-e274-4ae3-9234-976887d36c8f	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	2025-06-22 09:49:12.227346+00	2025-06-22 12:38:11.299012+00	\N	aal1	\N	2025-06-22 12:38:11.298934	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	23.93.140.255	\N
d4dc33bc-bb06-41d8-b581-335e8d905abc	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	2025-06-22 17:49:28.446212+00	2025-06-22 18:47:44.983271+00	\N	aal1	\N	2025-06-22 18:47:44.983198	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Safari/605.1.15	104.28.49.31	\N
cebc88ec-491f-42cc-b505-d696670f9f34	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	2025-06-22 17:56:11.198066+00	2025-06-22 19:13:09.467528+00	\N	aal1	\N	2025-06-22 19:13:09.467454	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	23.93.140.255	\N
89709c04-e9e4-4dfd-9347-ae9085cf69f4	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	2025-06-22 22:02:24.869856+00	2025-06-23 16:47:39.563636+00	\N	aal1	\N	2025-06-23 16:47:39.563559	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	23.93.140.255	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
952ae25b-e274-4ae3-9234-976887d36c8f	2025-06-22 09:49:12.231833+00	2025-06-22 09:49:12.231833+00	otp	80d41fe8-bd64-4906-94d0-a234c3f03873
2d374921-2cbd-4055-8c30-8e4214adce6d	2025-06-22 11:14:05.911105+00	2025-06-22 11:14:05.911105+00	password	28dcf2a4-372b-4a94-9361-91c8173dca62
d4dc33bc-bb06-41d8-b581-335e8d905abc	2025-06-22 17:49:28.449562+00	2025-06-22 17:49:28.449562+00	password	73f6e079-c188-4903-8b4c-8e5baabfd46d
cebc88ec-491f-42cc-b505-d696670f9f34	2025-06-22 17:56:11.201448+00	2025-06-22 17:56:11.201448+00	password	5b7d6338-dc35-40b2-93b5-4183e357ab50
89709c04-e9e4-4dfd-9347-ae9085cf69f4	2025-06-22 22:02:24.873042+00	2025-06-22 22:02:24.873042+00	password	47ba9d5c-985e-41e6-95a1-45cf91c1b1be
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_factors" ("id", "user_id", "friendly_name", "factor_type", "status", "created_at", "updated_at", "secret", "phone", "last_challenged_at", "web_authn_credential", "web_authn_aaguid") FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_challenges" ("id", "factor_id", "created_at", "verified_at", "ip_address", "otp_code", "web_authn_session_data") FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") FROM stdin;
3375a907-598f-47a2-8580-6c418023aeab	a28d9797-4a51-4f09-895c-3f10178e8a38	confirmation_token	252e7a90897795fe6e3033bbabbc0cd872de2a7e054082fc948a5ec9	foo4@foo.com	2025-06-22 11:13:46.78179	2025-06-22 11:13:46.78179
9d1b5c7b-d884-4c6f-8b41-68389aaf9eaf	800058f5-8936-432a-9a49-dbecb66820cf	confirmation_token	19591201bd0ea70609175ccd5c08e443edd278a2e3def32fd1e2c484	foo@foo.com	2025-06-22 18:56:19.165391	2025-06-22 18:56:19.165391
015cd328-fdda-4655-a228-73e5449a940c	6bd8c17c-8047-4d8d-9429-53d1b205fd45	confirmation_token	ef9e365cec2e1e353ff9d2ebae1ddc33b2bab5728178b71c2be45836	foo2@foo.com	2025-06-22 19:03:25.182274	2025-06-22 19:03:25.182274
5dc537b5-82a5-4531-be7c-62ddbf5e0945	1685e6ab-2a8d-430e-82f4-e53ee1d8c428	confirmation_token	35e593026d803d5e27c19cccbb1e6c5d05d27b95dd1cc6f1afc69e37	foo5@foo.com	2025-06-22 19:18:10.097526	2025-06-22 19:18:10.097526
a586df05-6ff5-4608-a25d-1ed737d54aec	d8c4cf9a-55d8-4750-8a04-57a10fa281c6	confirmation_token	600ea4c76d7f7e0e9028d3685ac66841b5c264e2c424dcd03359e0c7	demo@wordwise.ai	2025-06-22 19:18:52.881524	2025-06-22 19:18:52.881524
e44b6d1f-2f62-484c-9945-23bf152bbd13	dfe26057-ab9f-4e51-861d-a252a8cebc81	confirmation_token	af74b6a7118caae12bb6d328692b1b5946d508f8b52c0d66100e01d1	foo3@foo.com	2025-06-22 21:29:46.502286	2025-06-22 21:29:46.502286
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
00000000-0000-0000-0000-000000000000	1	wqkezd7wpkfe	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	t	2025-06-22 09:49:12.228879+00	2025-06-22 10:47:22.470972+00	\N	952ae25b-e274-4ae3-9234-976887d36c8f
00000000-0000-0000-0000-000000000000	3	dbzs3jic4ud5	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	t	2025-06-22 11:14:05.909157+00	2025-06-22 12:12:11.452809+00	\N	2d374921-2cbd-4055-8c30-8e4214adce6d
00000000-0000-0000-0000-000000000000	4	d2gyuqemrnup	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	f	2025-06-22 12:12:11.453478+00	2025-06-22 12:12:11.453478+00	dbzs3jic4ud5	2d374921-2cbd-4055-8c30-8e4214adce6d
00000000-0000-0000-0000-000000000000	2	qph3cmhcstxt	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	t	2025-06-22 10:47:22.471727+00	2025-06-22 12:38:11.295454+00	wqkezd7wpkfe	952ae25b-e274-4ae3-9234-976887d36c8f
00000000-0000-0000-0000-000000000000	5	ibscjjeaym6f	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	f	2025-06-22 12:38:11.296293+00	2025-06-22 12:38:11.296293+00	qph3cmhcstxt	952ae25b-e274-4ae3-9234-976887d36c8f
00000000-0000-0000-0000-000000000000	6	nsszbmhjpmys	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	t	2025-06-22 17:49:28.447483+00	2025-06-22 18:47:44.979939+00	\N	d4dc33bc-bb06-41d8-b581-335e8d905abc
00000000-0000-0000-0000-000000000000	8	a6zwu3anztcm	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	f	2025-06-22 18:47:44.980737+00	2025-06-22 18:47:44.980737+00	nsszbmhjpmys	d4dc33bc-bb06-41d8-b581-335e8d905abc
00000000-0000-0000-0000-000000000000	7	wcb3y6ujl6ca	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	t	2025-06-22 17:56:11.199291+00	2025-06-22 19:13:09.464393+00	\N	cebc88ec-491f-42cc-b505-d696670f9f34
00000000-0000-0000-0000-000000000000	9	sap4mv7w23i7	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	f	2025-06-22 19:13:09.465122+00	2025-06-22 19:13:09.465122+00	wcb3y6ujl6ca	cebc88ec-491f-42cc-b505-d696670f9f34
00000000-0000-0000-0000-000000000000	10	uvlg46eew674	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	t	2025-06-22 22:02:24.87097+00	2025-06-22 23:49:59.692605+00	\N	89709c04-e9e4-4dfd-9347-ae9085cf69f4
00000000-0000-0000-0000-000000000000	11	rwwsdvjkikuv	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	t	2025-06-22 23:49:59.693276+00	2025-06-23 02:01:01.770413+00	uvlg46eew674	89709c04-e9e4-4dfd-9347-ae9085cf69f4
00000000-0000-0000-0000-000000000000	12	a46urpiocum2	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	t	2025-06-23 02:01:01.771913+00	2025-06-23 16:47:39.557116+00	rwwsdvjkikuv	89709c04-e9e4-4dfd-9347-ae9085cf69f4
00000000-0000-0000-0000-000000000000	13	rrvo3crslqwa	2a633387-aae8-4e7a-bb7b-8c6604e98ca9	f	2025-06-23 16:47:39.559754+00	2025-06-23 16:47:39.559754+00	a46urpiocum2	89709c04-e9e4-4dfd-9347-ae9085cf69f4
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format") FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_relay_states" ("id", "sso_provider_id", "request_id", "for_email", "redirect_to", "created_at", "updated_at", "flow_state_id") FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_domains" ("id", "sso_provider_id", "domain", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: ai_prompts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."ai_prompts" ("id", "user_id", "type", "label", "prompt", "created_at") FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."documents" ("id", "user_id", "name", "is_builtin", "created_at", "updated_at") FROM stdin;
00000000-0000-0000-0000-000000000001	\N	Introduction.md	t	2025-06-22 20:51:29.74615+00	2025-06-22 20:51:29.74615+00
00000000-0000-0000-0000-000000000002	\N	Character Study.md	t	2025-06-22 20:51:29.74615+00	2025-06-22 20:51:29.74615+00
00000000-0000-0000-0000-000000000003	\N	Scene 1.md	t	2025-06-22 20:51:29.74615+00	2025-06-22 20:51:29.74615+00
00000000-0000-0000-0000-000000000004	\N	Plot Outline.md	t	2025-06-22 20:51:29.74615+00	2025-06-22 20:51:29.74615+00
00000000-0000-0000-0000-000000000005	\N	Untitled.md	t	2025-06-22 20:51:29.74615+00	2025-06-22 20:51:29.74615+00
\.


--
-- Data for Name: document_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."document_versions" ("id", "document_id", "version_no", "content", "created_at") FROM stdin;
\.


--
-- Data for Name: story_bible; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."story_bible" ("id", "user_id", "key", "value", "updated_at") FROM stdin;
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."user_preferences" ("user_id", "daily_word_goal", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id") FROM stdin;
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads" ("id", "in_progress_size", "upload_signature", "bucket_id", "key", "version", "owner_id", "created_at", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads_parts" ("id", "upload_id", "size", "part_number", "bucket_id", "key", "etag", "owner_id", "version", "created_at") FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 13, true);


--
-- PostgreSQL database dump complete
--

RESET ALL;
