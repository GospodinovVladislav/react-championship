--PostgreSQL Maestro 16.6.0.14
------------------------------------------
--Host     : localhost
--Database : championship


\connect - postgres
CREATE DATABASE championship WITH TEMPLATE = template0 ENCODING = 6 TABLESPACE = pg_default;
\connect championship postgres
-- Definition for sequence championship_id_seq (OID = 16394):
SET search_path = public, pg_catalog;
CREATE SEQUENCE championship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
-- Structure for table championship (OID = 16396):
CREATE TABLE championship (
    id bigint DEFAULT nextval('championship_id_seq'::regclass) NOT NULL,
    name varchar(30) NOT NULL,
    start_date date NOT NULL,
    end_date date
) WITHOUT OIDS;
-- Definition for sequence participant_id_seq (OID = 16402):
CREATE SEQUENCE participant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
-- Structure for table participant (OID = 16404):
CREATE TABLE participant (
    id bigint DEFAULT nextval('participant_id_seq'::regclass) NOT NULL,
    first_name varchar(30) NOT NULL,
    last_name varchar(30) NOT NULL,
    picture varchar(30) NOT NULL,
    email varchar(30) NOT NULL,
    in_group boolean NOT NULL,
    "position" varchar(30),
    championship_id bigint NOT NULL
) WITHOUT OIDS;
-- Definition for sequence score_id_seq (OID = 16428):
CREATE SEQUENCE score_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
-- Structure for table score (OID = 16430):
CREATE TABLE score (
    id bigint DEFAULT nextval('score_id_seq'::regclass) NOT NULL,
    matches_won integer DEFAULT 0 NOT NULL,
    matches_lost integer DEFAULT 0 NOT NULL,
    points_made integer DEFAULT 0 NOT NULL,
    points_taken integer DEFAULT 0 NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    participant_id bigint NOT NULL
) WITHOUT OIDS;
-- Definition for sequence group_id_seq (OID = 16446):
CREATE SEQUENCE group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
-- Structure for table group (OID = 16448):
CREATE TABLE "group" (
    id bigint DEFAULT nextval('group_id_seq'::regclass) NOT NULL,
    group_name varchar(30) NOT NULL,
    match_id bigint,
    number_participants integer DEFAULT 0 NOT NULL,
    participants_id bigint NOT NULL,
    stage varchar(30) NOT NULL,
    chamionship_id bigint NOT NULL
) WITHOUT OIDS;
-- Definition for sequence match_id_seq (OID = 16470):
CREATE SEQUENCE match_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
-- Structure for table match (OID = 16472):
CREATE TABLE "match" (
    id bigint DEFAULT nextval('match_id_seq'::regclass) NOT NULL,
    winner_id bigint,
    guest_id bigint NOT NULL,
    host_id bigint NOT NULL,
    group_id bigint NOT NULL
) WITHOUT OIDS;
-- Definition for sequence set_id_seq (OID = 16503):
CREATE SEQUENCE set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
-- Structure for table set (OID = 16505):
CREATE TABLE "set" (
    id bigint DEFAULT nextval('set_id_seq'::regclass) NOT NULL,
    guest_points integer DEFAULT 0 NOT NULL,
    host_points integer DEFAULT 0 NOT NULL,
    match_id bigint NOT NULL
) WITHOUT OIDS;
-- Definition for sequence user_id_seq (OID = 16518):
CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
-- Structure for table user (OID = 16520):
CREATE TABLE "user" (
    id bigint DEFAULT nextval('user_id_seq'::regclass) NOT NULL,
    first_name varchar(30) NOT NULL,
    last_name varchar(30) NOT NULL,
    email varchar(30) NOT NULL,
    is_participant boolean NOT NULL,
    "password" varchar(30) NOT NULL,
    picture varchar(30) NOT NULL
) WITHOUT OIDS;
-- Definition for sequence role_id_seq (OID = 16526):
CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
-- Structure for table role (OID = 16528):
CREATE TABLE role (
    id bigint DEFAULT nextval('role_id_seq'::regclass) NOT NULL,
    role_name varchar(30) NOT NULL
) WITHOUT OIDS;
-- Structure for table user_role (OID = 16534):
CREATE TABLE user_role (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
) WITHOUT OIDS;
-- Definition for index championship_pkey (OID = 16400):
ALTER TABLE ONLY championship
    ADD CONSTRAINT championship_pkey PRIMARY KEY (id);
-- Definition for index participant_pkey (OID = 16408):
ALTER TABLE ONLY participant
    ADD CONSTRAINT participant_pkey PRIMARY KEY (id);
-- Definition for index score_pkey (OID = 16439):
ALTER TABLE ONLY score
    ADD CONSTRAINT score_pkey PRIMARY KEY (id);
-- Definition for index group_pkey (OID = 16453):
ALTER TABLE ONLY "group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);
-- Definition for index foreign_key01 (OID = 16455):
ALTER TABLE ONLY "group"
    ADD CONSTRAINT foreign_key01 FOREIGN KEY (chamionship_id) REFERENCES championship(id);
-- Definition for index foreign_key02 (OID = 16460):
ALTER TABLE ONLY "group"
    ADD CONSTRAINT foreign_key02 FOREIGN KEY (participants_id) REFERENCES participant(id);
-- Definition for index foreign_key02 (OID = 16465):
ALTER TABLE ONLY participant
    ADD CONSTRAINT foreign_key02 FOREIGN KEY (championship_id) REFERENCES championship(id);
-- Definition for index match_pkey (OID = 16476):
ALTER TABLE ONLY "match"
    ADD CONSTRAINT match_pkey PRIMARY KEY (id);
-- Definition for index foreign_key01 (OID = 16478):
ALTER TABLE ONLY score
    ADD CONSTRAINT foreign_key01 FOREIGN KEY (participant_id) REFERENCES participant(id);
-- Definition for index foreign_key01 (OID = 16483):
ALTER TABLE ONLY "match"
    ADD CONSTRAINT foreign_key01 FOREIGN KEY (host_id) REFERENCES participant(id) MATCH FULL ON DELETE SET DEFAULT;
-- Definition for index foreign_key02 (OID = 16488):
ALTER TABLE ONLY "match"
    ADD CONSTRAINT foreign_key02 FOREIGN KEY (guest_id) REFERENCES participant(id);
-- Definition for index foreign_key03 (OID = 16493):
ALTER TABLE ONLY "match"
    ADD CONSTRAINT foreign_key03 FOREIGN KEY (winner_id) REFERENCES participant(id);
-- Definition for index foreign_key04 (OID = 16498):
ALTER TABLE ONLY "match"
    ADD CONSTRAINT foreign_key04 FOREIGN KEY (group_id) REFERENCES "group"(id);
-- Definition for index set_pkey (OID = 16511):
ALTER TABLE ONLY "set"
    ADD CONSTRAINT set_pkey PRIMARY KEY (id);
-- Definition for index foreign_key01 (OID = 16513):
ALTER TABLE ONLY "set"
    ADD CONSTRAINT foreign_key01 FOREIGN KEY (match_id) REFERENCES match(id);
-- Definition for index user_pkey (OID = 16524):
ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
-- Definition for index role_pkey (OID = 16532):
ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);
-- Definition for index foreign_key01 (OID = 16537):
ALTER TABLE ONLY user_role
    ADD CONSTRAINT foreign_key01 FOREIGN KEY (user_id) REFERENCES "user"(id);
-- Definition for index foreign_key02 (OID = 16542):
ALTER TABLE ONLY user_role
    ADD CONSTRAINT foreign_key02 FOREIGN KEY (role_id) REFERENCES role(id);
SET search_path = pg_catalog, pg_catalog;
COMMENT ON SCHEMA public IS 'standard public schema';
