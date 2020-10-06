--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--





--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;






--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: authclient_grant_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.authclient_grant_type AS ENUM (
    'authorization_code',
    'client_credentials',
    'jwt_bearer',
    'password'
);


ALTER TYPE public.authclient_grant_type OWNER TO postgres;

--
-- Name: authclient_response_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.authclient_response_type AS ENUM (
    'code',
    'token'
);


ALTER TYPE public.authclient_response_type OWNER TO postgres;

--
-- Name: group_joinable_by; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.group_joinable_by AS ENUM (
    'authority'
);


ALTER TYPE public.group_joinable_by OWNER TO postgres;

--
-- Name: group_readable_by; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.group_readable_by AS ENUM (
    'members',
    'world'
);


ALTER TYPE public.group_readable_by OWNER TO postgres;

--
-- Name: group_writeable_by; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.group_writeable_by AS ENUM (
    'authority',
    'members'
);


ALTER TYPE public.group_writeable_by OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activation (
    id integer NOT NULL,
    code text NOT NULL
);


ALTER TABLE public.activation OWNER TO postgres;

--
-- Name: activation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activation_id_seq OWNER TO postgres;

--
-- Name: activation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activation_id_seq OWNED BY public.activation.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: annotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annotation (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    userid text NOT NULL,
    groupid text DEFAULT '__world__'::text NOT NULL,
    text text,
    text_rendered text,
    tags text[],
    shared boolean DEFAULT false NOT NULL,
    target_uri text,
    target_uri_normalized text,
    target_selectors jsonb DEFAULT '[]'::jsonb,
    "references" uuid[] DEFAULT ARRAY[]::uuid[],
    extra jsonb DEFAULT '{}'::jsonb NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    document_id integer NOT NULL
);


ALTER TABLE public.annotation OWNER TO postgres;

--
-- Name: annotation_moderation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annotation_moderation (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    annotation_id uuid NOT NULL
);


ALTER TABLE public.annotation_moderation OWNER TO postgres;

--
-- Name: annotation_moderation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.annotation_moderation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_moderation_id_seq OWNER TO postgres;

--
-- Name: annotation_moderation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.annotation_moderation_id_seq OWNED BY public.annotation_moderation.id;


--
-- Name: authclient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authclient (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    name text,
    secret text,
    authority text NOT NULL,
    grant_type public.authclient_grant_type,
    response_type public.authclient_response_type,
    redirect_uri text,
    trusted boolean DEFAULT false NOT NULL,
    CONSTRAINT ck__authclient__authz_grant_redirect_uri CHECK (((grant_type <> 'authorization_code'::public.authclient_grant_type) OR (redirect_uri IS NOT NULL)))
);


ALTER TABLE public.authclient OWNER TO postgres;

--
-- Name: authticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authticket (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id text NOT NULL,
    expires timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    user_userid text NOT NULL
);


ALTER TABLE public.authticket OWNER TO postgres;

--
-- Name: authzcode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authzcode (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    user_id integer NOT NULL,
    authclient_id uuid NOT NULL,
    code text NOT NULL,
    expires timestamp without time zone NOT NULL
);


ALTER TABLE public.authzcode OWNER TO postgres;

--
-- Name: authzcode_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authzcode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authzcode_id_seq OWNER TO postgres;

--
-- Name: authzcode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authzcode_id_seq OWNED BY public.authzcode.id;


--
-- Name: blocklist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blocklist (
    id integer NOT NULL,
    uri text NOT NULL
);


ALTER TABLE public.blocklist OWNER TO postgres;

--
-- Name: blocklist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blocklist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blocklist_id_seq OWNER TO postgres;

--
-- Name: blocklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blocklist_id_seq OWNED BY public.blocklist.id;


--
-- Name: document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    title text,
    web_uri text
);


ALTER TABLE public.document OWNER TO postgres;

--
-- Name: document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_id_seq OWNER TO postgres;

--
-- Name: document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_id_seq OWNED BY public.document.id;


--
-- Name: document_meta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_meta (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    claimant text NOT NULL,
    claimant_normalized text NOT NULL,
    type text NOT NULL,
    value text[] NOT NULL,
    document_id integer NOT NULL
);


ALTER TABLE public.document_meta OWNER TO postgres;

--
-- Name: document_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_meta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_meta_id_seq OWNER TO postgres;

--
-- Name: document_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_meta_id_seq OWNED BY public.document_meta.id;


--
-- Name: document_uri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_uri (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    claimant text NOT NULL,
    claimant_normalized text NOT NULL,
    uri text NOT NULL,
    uri_normalized text NOT NULL,
    type text DEFAULT ''::text NOT NULL,
    content_type text DEFAULT ''::text NOT NULL,
    document_id integer NOT NULL
);


ALTER TABLE public.document_uri OWNER TO postgres;

--
-- Name: document_uri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_uri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_uri_id_seq OWNER TO postgres;

--
-- Name: document_uri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_uri_id_seq OWNED BY public.document_uri.id;


--
-- Name: feature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feature (
    id integer NOT NULL,
    name text NOT NULL,
    everyone boolean DEFAULT false NOT NULL,
    admins boolean DEFAULT false NOT NULL,
    staff boolean DEFAULT false NOT NULL
);


ALTER TABLE public.feature OWNER TO postgres;

--
-- Name: feature_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feature_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feature_id_seq OWNER TO postgres;

--
-- Name: feature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feature_id_seq OWNED BY public.feature.id;


--
-- Name: featurecohort; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.featurecohort (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.featurecohort OWNER TO postgres;

--
-- Name: featurecohort_feature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.featurecohort_feature (
    id integer NOT NULL,
    cohort_id integer NOT NULL,
    feature_id integer NOT NULL
);


ALTER TABLE public.featurecohort_feature OWNER TO postgres;

--
-- Name: featurecohort_feature_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.featurecohort_feature_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.featurecohort_feature_id_seq OWNER TO postgres;

--
-- Name: featurecohort_feature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.featurecohort_feature_id_seq OWNED BY public.featurecohort_feature.id;


--
-- Name: featurecohort_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.featurecohort_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.featurecohort_id_seq OWNER TO postgres;

--
-- Name: featurecohort_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.featurecohort_id_seq OWNED BY public.featurecohort.id;


--
-- Name: featurecohort_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.featurecohort_user (
    id integer NOT NULL,
    cohort_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.featurecohort_user OWNER TO postgres;

--
-- Name: featurecohort_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.featurecohort_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.featurecohort_user_id_seq OWNER TO postgres;

--
-- Name: featurecohort_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.featurecohort_user_id_seq OWNED BY public.featurecohort_user.id;


--
-- Name: flag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flag (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    annotation_id uuid NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.flag OWNER TO postgres;

--
-- Name: flag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flag_id_seq OWNER TO postgres;

--
-- Name: flag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flag_id_seq OWNED BY public.flag.id;


--
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."group" (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    pubid text NOT NULL,
    authority text NOT NULL,
    name text NOT NULL,
    creator_id integer,
    description text,
    enforce_scope boolean DEFAULT true NOT NULL,
    authority_provided_id text,
    joinable_by public.group_joinable_by,
    readable_by public.group_readable_by,
    writeable_by public.group_writeable_by,
    organization_id integer
);


ALTER TABLE public."group" OWNER TO postgres;

--
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_id_seq OWNER TO postgres;

--
-- Name: group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.group_id_seq OWNED BY public."group".id;


--
-- Name: groupscope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupscope (
    id integer NOT NULL,
    group_id integer NOT NULL,
    origin text NOT NULL,
    path text
);


ALTER TABLE public.groupscope OWNER TO postgres;

--
-- Name: groupscope_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groupscope_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groupscope_id_seq OWNER TO postgres;

--
-- Name: groupscope_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groupscope_id_seq OWNED BY public.groupscope.id;


--
-- Name: organization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organization (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    pubid text NOT NULL,
    name text NOT NULL,
    logo text,
    authority text NOT NULL
);


ALTER TABLE public.organization OWNER TO postgres;

--
-- Name: organization_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organization_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_id_seq OWNER TO postgres;

--
-- Name: organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organization_id_seq OWNED BY public.organization.id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.setting (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    key text NOT NULL,
    value text
);


ALTER TABLE public.setting OWNER TO postgres;

--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscriptions (
    id integer NOT NULL,
    uri text NOT NULL,
    type character varying(64) NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.subscriptions OWNER TO postgres;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriptions_id_seq OWNER TO postgres;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;


--
-- Name: token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token (
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    userid text NOT NULL,
    value text NOT NULL,
    expires timestamp without time zone,
    refresh_token text,
    refresh_token_expires timestamp without time zone,
    authclient_id uuid
);


ALTER TABLE public.token OWNER TO postgres;

--
-- Name: token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.token_id_seq OWNER TO postgres;

--
-- Name: token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.token_id_seq OWNED BY public.token.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username text NOT NULL,
    authority text NOT NULL,
    display_name text,
    description text,
    location text,
    uri text,
    orcid text,
    admin boolean DEFAULT false NOT NULL,
    staff boolean DEFAULT false NOT NULL,
    nipsa boolean DEFAULT false NOT NULL,
    sidebar_tutorial_dismissed boolean DEFAULT false,
    privacy_accepted timestamp without time zone,
    email text,
    last_login_date timestamp without time zone,
    registered_date timestamp without time zone DEFAULT now() NOT NULL,
    activation_date timestamp without time zone,
    activation_id integer,
    password text,
    password_updated timestamp without time zone,
    salt text,
    "comms_opt_in column" boolean DEFAULT false,
    comms_opt_in boolean DEFAULT false
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.user_group OWNER TO postgres;

--
-- Name: user_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_group_id_seq OWNER TO postgres;

--
-- Name: user_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_group_id_seq OWNED BY public.user_group.id;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: user_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_identity (
    id integer NOT NULL,
    provider text NOT NULL,
    provider_unique_id text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.user_identity OWNER TO postgres;

--
-- Name: user_identity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_identity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_identity_id_seq OWNER TO postgres;

--
-- Name: user_identity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_identity_id_seq OWNED BY public.user_identity.id;


--
-- Name: activation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activation ALTER COLUMN id SET DEFAULT nextval('public.activation_id_seq'::regclass);


--
-- Name: annotation_moderation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation_moderation ALTER COLUMN id SET DEFAULT nextval('public.annotation_moderation_id_seq'::regclass);


--
-- Name: authzcode id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authzcode ALTER COLUMN id SET DEFAULT nextval('public.authzcode_id_seq'::regclass);


--
-- Name: blocklist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocklist ALTER COLUMN id SET DEFAULT nextval('public.blocklist_id_seq'::regclass);


--
-- Name: document id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document ALTER COLUMN id SET DEFAULT nextval('public.document_id_seq'::regclass);


--
-- Name: document_meta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_meta ALTER COLUMN id SET DEFAULT nextval('public.document_meta_id_seq'::regclass);


--
-- Name: document_uri id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_uri ALTER COLUMN id SET DEFAULT nextval('public.document_uri_id_seq'::regclass);


--
-- Name: feature id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature ALTER COLUMN id SET DEFAULT nextval('public.feature_id_seq'::regclass);


--
-- Name: featurecohort id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort ALTER COLUMN id SET DEFAULT nextval('public.featurecohort_id_seq'::regclass);


--
-- Name: featurecohort_feature id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_feature ALTER COLUMN id SET DEFAULT nextval('public.featurecohort_feature_id_seq'::regclass);


--
-- Name: featurecohort_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_user ALTER COLUMN id SET DEFAULT nextval('public.featurecohort_user_id_seq'::regclass);


--
-- Name: flag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flag ALTER COLUMN id SET DEFAULT nextval('public.flag_id_seq'::regclass);


--
-- Name: group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group" ALTER COLUMN id SET DEFAULT nextval('public.group_id_seq'::regclass);


--
-- Name: groupscope id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupscope ALTER COLUMN id SET DEFAULT nextval('public.groupscope_id_seq'::regclass);


--
-- Name: organization id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization ALTER COLUMN id SET DEFAULT nextval('public.organization_id_seq'::regclass);


--
-- Name: subscriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);


--
-- Name: token id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token ALTER COLUMN id SET DEFAULT nextval('public.token_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group ALTER COLUMN id SET DEFAULT nextval('public.user_group_id_seq'::regclass);


--
-- Name: user_identity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_identity ALTER COLUMN id SET DEFAULT nextval('public.user_identity_id_seq'::regclass);


--
-- Data for Name: activation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activation (id, code) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
3359d7d8ec29
\.


--
-- Data for Name: annotation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annotation (id, created, updated, userid, groupid, text, text_rendered, tags, shared, target_uri, target_uri_normalized, target_selectors, "references", extra, deleted, document_id) FROM stdin;
412f1c9e-fbe2-11ea-add0-8fefccc2ec41	2020-09-21 08:12:56.13772	2020-09-21 08:12:56.13772	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1760, "startOffset": 1747, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1976, "type": "TextPositionSelector", "start": 1963}, {"type": "TextQuoteSelector", "exact": "nsider subscr", "prefix": "te to the project, you should co", "suffix": "ibing to\\nthe [development mailin"}]	{}	{}	f	1
6cc43434-fbe2-11ea-add0-d757b9a6c8ca	2020-09-21 08:14:09.304692	2020-09-21 08:14:16.93187	acct:admin01@localhost	__world__	Test	<p>Test</p>\n	{#confusing}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1192, "startOffset": 1173, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1408, "type": "TextPositionSelector", "start": 1389}, {"type": "TextQuoteSelector", "exact": "test/publishers/emb", "prefix": "thedocs.io/projects/client/en/la", "suffix": "edding/\\n\\nDevelopment\\n-----------"}]	{}	{}	f	1
775f9d2a-fbe2-11ea-add0-ef4abc662157	2020-09-21 08:14:27.116426	2020-09-21 08:14:39.467453	acct:admin01@localhost	__world__	Test	<p>Test</p>\n	{#important,confusing}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1285, "startOffset": 1273, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1501, "type": "TextPositionSelector", "start": 1489}, {"type": "TextQuoteSelector", "exact": "for instruct", "prefix": "[Development Guide][developers] ", "suffix": "ions on building,\\ntesting and co"}]	{}	{}	f	1
9a01cb14-fbe2-11ea-add0-9b7aa6273301	2020-09-21 08:15:25.238517	2020-09-21 08:15:25.238517	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 698, "startOffset": 676, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 914, "type": "TextPositionSelector", "start": 892}, {"type": "TextQuoteSelector", "exact": "ol for making annotati", "prefix": "sis client is a browser-based to", "suffix": "ons on web\\npages. It’s a client "}]	{}	{}	f	1
d061ed7e-fbe2-11ea-add0-ffd68991d41b	2020-09-21 08:16:56.444519	2020-09-21 08:16:56.444519	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 853, "startOffset": 840, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1069, "type": "TextPositionSelector", "start": 1056}, {"type": "TextQuoteSelector", "exact": "d can also be", "prefix": "esis browser extension][ext], an", "suffix": "\\n[embedded directly into web pag"}]	{}	{}	f	1
124e7c70-fbe3-11ea-add0-1b8513f37518	2020-09-21 08:18:46.974132	2020-09-21 08:18:46.974132	acct:admin01@localhost	__world__			{#interesting}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 58, "startOffset": 40, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 274, "type": "TextPositionSelector", "start": 256}, {"type": "TextQuoteSelector", "exact": "Build status](http", "prefix": "is client\\n=================\\n\\n[![", "suffix": "s://img.shields.io/travis/hypoth"}]	{}	{}	f	1
0993df2a-fbe4-11ea-add0-d34d743f592c	2020-09-21 08:25:41.823446	2020-09-21 08:25:41.823446	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 120, "startOffset": 104, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 336, "type": "TextPositionSelector", "start": 320}, {"type": "TextQuoteSelector", "exact": "ster.svg)][travi", "prefix": "s.io/travis/hypothesis/client/ma", "suffix": "s]\\n[![npm version](https://img.s"}]	{}	{}	f	1
73ad88f2-f7d4-11ea-92b0-d7c630a84f39	2020-09-16 04:24:03.287647	2020-09-16 04:24:03.287647	acct:admin01@localhost	__world__	ss	<p>ss</p>\n	{"#important ⇤"}	f	http://localhost:3000/	httpx://localhost:3000	[]	{22f92dc6-f7d4-11ea-92b0-0b37a7d959d6}	{}	f	1
76dda782-f7d4-11ea-92b0-cf3d7466f9fc	2020-09-16 04:24:08.706592	2020-09-16 04:24:08.706592	acct:admin01@localhost	__world__	sds	<p>sds</p>\n	{"#comment ⇤"}	f	http://localhost:3000/	httpx://localhost:3000	[]	{34a54460-f7d4-11ea-92b0-2bfb61353aae}	{}	f	1
9c660daa-f7d4-11ea-92b0-7b08049828d0	2020-09-16 04:25:11.670938	2020-09-16 04:25:11.670938	acct:admin01@localhost	__world__	test	<p>test</p>\n	{}	f	http://localhost:3000/	httpx://localhost:3000	[]	{22f92dc6-f7d4-11ea-92b0-0b37a7d959d6,73ad88f2-f7d4-11ea-92b0-d7c630a84f39}	{}	f	1
11972d04-f7d8-11ea-92b0-b33f424861b8	2020-09-16 04:49:56.699576	2020-09-16 04:49:56.699576	acct:admin01@localhost	__world__	asas	<p>asas</p>\n	{"#important ⇤"}	f	http://localhost:3000/	httpx://localhost:3000	[]	{c3fed0ec-f7d7-11ea-92b0-136864de62d2}	{}	f	1
16b39df4-f7d8-11ea-92b0-077974422aa7	2020-09-16 04:50:05.359423	2020-09-16 04:50:05.359423	acct:admin01@localhost	__world__	asas	<p>asas</p>\n	{"#important ⇤",asaasa}	f	http://localhost:3000/	httpx://localhost:3000	[]	{c3fed0ec-f7d7-11ea-92b0-136864de62d2,11972d04-f7d8-11ea-92b0-b33f424861b8}	{}	f	1
f2edaa52-fbcb-11ea-add0-cb33e7c4c0ea	2020-09-21 05:33:15.735622	2020-09-21 05:33:15.735622	acct:admin01@localhost	__world__	yh	<p>yh</p>\n	{#comment}	t	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1159, "startOffset": 1155, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1375, "type": "TextPositionSelector", "start": 1371}, {"type": "TextQuoteSelector", "exact": "ject", "prefix": "d]: https://h.readthedocs.io/pro", "suffix": "s/client/en/latest/publishers/em"}]	{}	{}	f	1
021112c6-fbcc-11ea-add0-7b59dbe703ef	2020-09-21 05:33:41.401152	2020-09-21 05:33:41.401152	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 2044, "startOffset": 2041, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 2260, "type": "TextPositionSelector", "start": 2257}, {"type": "TextQuoteSelector", "exact": "st.", "prefix": ": https://groups.google.com/a/li", "suffix": "hypothes.is/forum/#!forum/dev\\n[c"}]	{}	{}	f	1
03f5d9fa-fbcc-11ea-add0-13e3030d0c27	2020-09-21 05:33:44.575523	2020-09-21 05:33:44.575523	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 2089, "startOffset": 2085, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 2305, "type": "TextPositionSelector", "start": 2301}, {"type": "TextQuoteSelector", "exact": "s://", "prefix": "is/forum/#!forum/dev\\n[coc]: http", "suffix": "github.com/hypothesis/client/blo"}]	{}	{}	f	1
078f8ebc-fbcc-11ea-add0-1fcb3a11fe0b	2020-09-21 05:33:50.607761	2020-09-21 05:33:50.607761	acct:admin01@localhost	__world__	j	<p>j</p>\n	{#comment}	t	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1242, "startOffset": 1237, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1458, "type": "TextPositionSelector", "start": 1453}, {"type": "TextQuoteSelector", "exact": "ent [", "prefix": "lopment\\n-----------\\n\\nSee the cli", "suffix": "Development Guide][developers] f"}]	{}	{}	f	1
530dcb24-fbcc-11ea-add0-f7f69e9d21c7	2020-09-21 05:35:57.273006	2020-09-21 05:35:57.273006	acct:admin01@localhost	__world__	y	<p>y</p>\n	{#comment}	t	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1484, "startOffset": 1481, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1700, "type": "TextPositionSelector", "start": 1697}, {"type": "TextQuoteSelector", "exact": "ack", "prefix": "r [Contact page to join us on Sl", "suffix": "](https://web.hypothes.is/contac"}]	{}	{}	f	1
54611116-fbcc-11ea-add0-3b986c2993a7	2020-09-21 05:35:59.521823	2020-09-21 05:35:59.521823	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1719, "startOffset": 1712, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1935, "type": "TextPositionSelector", "start": 1928}, {"type": "TextQuoteSelector", "exact": "ibute t", "prefix": "cussion.\\n\\nIf you'd like to contr", "suffix": "o the project, you should consid"}]	{}	{}	f	1
6d7c4d00-fbcc-11ea-add0-8318fa3876c8	2020-09-21 05:36:41.620946	2020-09-21 05:36:41.620946	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1295, "startOffset": 1286, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1511, "type": "TextPositionSelector", "start": 1502}, {"type": "TextQuoteSelector", "exact": "ons on bu", "prefix": "Guide][developers] for instructi", "suffix": "ilding,\\ntesting and contributing"}]	{}	{}	f	1
619f63c4-fbe4-11ea-add0-1b0b6ca25242	2020-09-21 08:28:09.589735	2020-09-21 08:28:09.589735	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 515, "startOffset": 493, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 731, "type": "TextPositionSelector", "start": 709}, {"type": "TextQuoteSelector", "exact": "nvite?channel=%23hypot", "prefix": "irc]: https://www.irccloud.com/i", "suffix": "hes.is&hostname=irc.freenode.net"}]	{}	{}	f	1
cf2aba48-fbe8-11ea-add0-c3ba866a1e6a	2020-09-21 08:59:51.388092	2020-09-21 08:59:51.388092	acct:admin01@localhost	__world__	we	<p>we</p>\n	{#note}	t	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 545, "startOffset": 536, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 761, "type": "TextPositionSelector", "start": 752}, {"type": "TextQuoteSelector", "exact": "reenode.n", "prefix": "el=%23hypothes.is&hostname=irc.f", "suffix": "et&port=6667&ssl=1\\n[license]: ht"}]	{}	{}	f	1
0f01c832-fbe9-11ea-add0-2386858e2a49	2020-09-21 09:01:38.501236	2020-09-21 09:01:38.501236	acct:admin01@localhost	__world__	adssd	<p>adssd</p>\n	{"#interesting ⇤"}	f	http://localhost:3000/	httpx://localhost:3000	[]	{124e7c70-fbe3-11ea-add0-1b8513f37518}	{}	f	1
10a4079a-fbe9-11ea-add0-eb67445b658c	2020-09-21 09:01:41.236075	2020-09-21 09:01:41.236075	acct:admin01@localhost	__world__	asds	<p>asds</p>\n	{"#interesting ⇤"}	f	http://localhost:3000/	httpx://localhost:3000	[]	{124e7c70-fbe3-11ea-add0-1b8513f37518,0f01c832-fbe9-11ea-add0-2386858e2a49}	{}	f	1
46bf8dee-fd8e-11ea-a214-cb03858e0e4d	2020-09-23 11:16:49.501557	2020-09-23 11:16:49.501557	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 108, "startOffset": 99, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 109, "type": "TextPositionSelector", "start": 100}, {"type": "TextQuoteSelector", "exact": "anyone an", "prefix": "s\\n\\nThis eBook is for the use of ", "suffix": "ywhere at no cost and with\\nalmos"}]	{}	{}	f	3
b1c97ba8-064f-11eb-ac3f-c71b845011e2	2020-10-04 14:41:31.89584	2020-10-04 14:41:31.89584	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#confusing}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 36, "startOffset": 27, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 703, "type": "TextPositionSelector", "start": 694}, {"type": "TextQuoteSelector", "exact": "earch foc", "prefix": "     \\n            My current res", "suffix": "uses on using machine learning a"}]	{}	{}	f	5
b44b257a-064f-11eb-ac3f-ebe72df627f0	2020-10-04 14:41:36.073381	2020-10-04 14:41:36.073381	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#interesting}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 50, "startOffset": 41, "endContainer": "/div[1]/div[1]/p[3]", "startContainer": "/div[1]/div[1]/p[3]"}, {"end": 1031, "type": "TextPositionSelector", "start": 1022}, {"type": "TextQuoteSelector", "exact": " Master's", "prefix": "    I received my Bachelor's and", "suffix": " degree in Computer Science from"}]	{}	{}	f	5
b72e4524-064f-11eb-ac3f-936335b029ae	2020-10-04 14:41:40.887478	2020-10-04 14:41:40.887478	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#irrelevant}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 84, "startOffset": 71, "endContainer": "/div[1]/div[1]/p[3]", "startContainer": "/div[1]/div[1]/p[3]"}, {"end": 1065, "type": "TextPositionSelector", "start": 1052}, {"type": "TextQuoteSelector", "exact": "cience from T", "prefix": "nd Master's degree in Computer S", "suffix": "he University of the South Pacif"}]	{}	{}	f	5
0a10c4a4-0652-11eb-ac3f-8b7022b4f383	2020-10-04 14:58:18.765333	2020-10-04 14:59:25.87969	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E	test	<p>test</p>\n	{#interesting}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 43, "startOffset": 37, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 710, "type": "TextPositionSelector", "start": 704}, {"type": "TextQuoteSelector", "exact": "ses on", "prefix": "        My current research focu", "suffix": " using machine learning and data"}]	{}	{}	f	5
a2916846-0652-11eb-ac3f-0f6e2711379d	2020-10-04 15:02:34.80609	2020-10-04 15:02:34.80609	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#important}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 69, "startOffset": 59, "endContainer": "/div[1]/div[1]/p[1]", "startContainer": "/div[1]/div[1]/p[1]"}, {"end": 437, "type": "TextPositionSelector", "start": 427}, {"type": "TextQuoteSelector", "exact": "aulfield C", "prefix": " student at Monash University, C", "suffix": "ampus. My advisors are  Prof. \\t\\n"}]	{}	{}	f	5
a91286e6-0652-11eb-ac3f-a71766891c25	2020-10-04 15:02:45.739269	2020-10-04 15:02:45.739269	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#irrelevant}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 42, "startOffset": 23, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 709, "type": "TextPositionSelector", "start": 690}, {"type": "TextQuoteSelector", "exact": " research focuses o", "prefix": "         \\n            My current", "suffix": "n using machine learning and dat"}]	{}	{}	f	5
b1cfa0f8-fbfc-11ea-993d-7b06addd1322	2020-09-21 11:22:11.950445	2020-09-21 11:22:11.950445	acct:admin01@localhost	__world__			{}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 238, "startOffset": 228, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 239, "type": "TextPositionSelector", "start": 229}, {"type": "TextQuoteSelector", "exact": "s of the P", "prefix": "away or\\nre-use it under the term", "suffix": "roject Gutenberg License include"}]	{}	{}	f	3
8dc9b2dc-fc03-11ea-993d-b7364470a07d	2020-09-21 12:11:18.093188	2020-09-21 12:11:18.093188	acct:admin01@localhost	__world__			{#interesting}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 264, "startOffset": 248, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 265, "type": "TextPositionSelector", "start": 249}, {"type": "TextQuoteSelector", "exact": "enberg License i", "prefix": "der the terms of the Project Gut", "suffix": "ncluded\\nwith this eBook or onlin"}]	{}	{}	f	3
91399c98-fc03-11ea-993d-97ab32ebe9cd	2020-09-21 12:11:23.883592	2020-09-21 12:11:23.883592	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 421, "startOffset": 410, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 422, "type": "TextPositionSelector", "start": 411}, {"type": "TextQuoteSelector", "exact": "005 [EBook ", "prefix": "rns\\n\\nRelease Date: January 25, 2", "suffix": "#1279]\\nLast Updated: March 15, 2"}]	{}	{}	f	3
14d1742c-fc04-11ea-993d-1f37a331f2bd	2020-09-21 12:15:04.618547	2020-09-21 12:15:04.618547	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 528, "startOffset": 523, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 529, "type": "TextPositionSelector", "start": 524}, {"type": "TextQuoteSelector", "exact": "IS PR", "prefix": "encoding: UTF-8\\n\\n*** START OF TH", "suffix": "OJECT GUTENBERG EBOOK POEMS AND "}]	{}	{}	f	3
8a54b3ea-fc03-11ea-993d-b7db8ea62e68	2020-09-21 12:11:12.215771	2020-09-21 12:12:17.775042	acct:admin01@localhost	__world__	s	<p>s</p>\n	{#important}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 90, "startOffset": 78, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 91, "type": "TextPositionSelector", "start": 79}, {"type": "TextQuoteSelector", "exact": "ok is for th", "prefix": "Burns, by Robert Burns\\n\\nThis eBo", "suffix": "e use of anyone anywhere at no c"}]	{}	{}	f	3
b44a31b6-fc03-11ea-993d-3f39ac8910dc	2020-09-21 12:12:22.671707	2020-09-21 12:12:28.028417	acct:admin01@localhost	__world__			{#important}	t	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 450, "startOffset": 443, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 451, "type": "TextPositionSelector", "start": 444}, {"type": "TextQuoteSelector", "exact": "arch 15", "prefix": "05 [EBook #1279]\\nLast Updated: M", "suffix": ", 2018\\n\\nLanguage: English\\n\\nChara"}]	{}	{}	f	3
0f9280d2-fc04-11ea-993d-43ad9e329c1a	2020-09-21 12:14:55.730182	2020-09-21 12:14:55.730182	acct:admin01@localhost	__world__			{#interesting}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 621, "startOffset": 613, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 622, "type": "TextPositionSelector", "start": 614}, {"type": "TextQuoteSelector", "exact": "r and an", "prefix": " ***\\n\\n\\n\\n\\nProduced by David Widge", "suffix": " Anonymous Project Gutenberg Vol"}]	{}	{}	f	3
20561d9c-fc05-11ea-993d-e3165b619adb	2020-09-21 12:22:33.31502	2020-09-21 12:22:33.31502	acct:admin01@localhost	__world__			{#interesting}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 130, "startOffset": 112, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 131, "type": "TextPositionSelector", "start": 113}, {"type": "TextQuoteSelector", "exact": "re at no cost and ", "prefix": " is for the use of anyone anywhe", "suffix": "with\\nalmost no restrictions what"}]	{}	{}	f	3
851b6b86-fc16-11ea-993d-9ffb897f0d3c	2020-09-21 14:27:04.002687	2020-09-21 14:27:17.752919	acct:admin01@localhost	__world__	434	<p>434</p>\n	{#note}	t	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 344, "startOffset": 338, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 345, "type": "TextPositionSelector", "start": 339}, {"type": "TextQuoteSelector", "exact": "Songs ", "prefix": "utenberg.net\\n\\n\\nTitle: Poems And ", "suffix": "Of Robert Burns\\n\\nAuthor: Robert "}]	{}	{}	f	3
b97d222c-fc19-11ea-993d-bf049940db84	2020-09-21 14:50:00.367201	2020-09-21 14:50:00.367201	acct:admin01@localhost	__world__	kk	<p>kk</p>\n	{#note}	t	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 226, "startOffset": 218, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 227, "type": "TextPositionSelector", "start": 219}, {"type": "TextQuoteSelector", "exact": "r the te", "prefix": ", give it away or\\nre-use it unde", "suffix": "rms of the Project Gutenberg Lic"}]	{}	{}	f	3
3141c5d8-fc47-11ea-993d-0362cd0bb6ef	2020-09-21 20:15:28.56685	2020-09-21 20:15:28.56685	acct:admin01@localhost	__world__			{#irrelevant}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 331, "startOffset": 323, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 332, "type": "TextPositionSelector", "start": 324}, {"type": "TextQuoteSelector", "exact": "tle: Poe", "prefix": "online at www.gutenberg.net\\n\\n\\nTi", "suffix": "ms And Songs Of Robert Burns\\n\\nAu"}]	{}	{}	f	3
557e6f6e-fc47-11ea-993d-170b7903cc0f	2020-09-21 20:16:29.425311	2020-09-21 20:16:29.425311	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 216, "startOffset": 209, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 217, "type": "TextPositionSelector", "start": 210}, {"type": "TextQuoteSelector", "exact": "e it un", "prefix": "y copy it, give it away or\\nre-us", "suffix": "der the terms of the Project Gut"}]	{}	{}	f	3
5b60247c-fc47-11ea-993d-27dfe25c3b39	2020-09-21 20:16:39.319368	2020-09-21 20:16:39.319368	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 74, "startOffset": 71, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 75, "type": "TextPositionSelector", "start": 72}, {"type": "TextQuoteSelector", "exact": "his", "prefix": "Robert Burns, by Robert Burns\\n\\nT", "suffix": " eBook is for the use of anyone "}]	{}	{}	f	3
5d7d6b16-fc47-11ea-993d-53606ced2613	2020-09-21 20:16:42.863338	2020-09-23 06:13:33.380329	acct:admin01@localhost	__world__			{#irrelevant}	t	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 38, "startOffset": 32, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 39, "type": "TextPositionSelector", "start": 33}, {"type": "TextQuoteSelector", "exact": "ngs Of", "prefix": "Project Gutenberg's Poems And So", "suffix": " Robert Burns, by Robert Burns\\n\\n"}]	{}	{}	f	3
387451d2-fd9a-11ea-a85f-c3d4af8861cd	2020-09-23 12:42:19.993995	2020-09-23 12:42:19.993995	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#confusing}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 127, "startOffset": 113, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 794, "type": "TextPositionSelector", "start": 780}, {"type": "TextQuoteSelector", "exact": "tion, especial", "prefix": "g methods in novel ways in educa", "suffix": "ly for behavioural \\n            "}]	{}	{}	f	5
770856b4-fd9a-11ea-a85f-4b40d0044aa9	2020-09-23 12:44:05.019469	2020-09-23 12:44:05.019469	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#confusing}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 26, "startOffset": 14, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 693, "type": "TextPositionSelector", "start": 681}, {"type": "TextQuoteSelector", "exact": "y current re", "prefix": "     \\n            \\n            M", "suffix": "search focuses on using machine "}]	{}	{}	f	5
90598b74-fd9a-11ea-a85f-7bd6d771921e	2020-09-23 12:44:47.554314	2020-09-23 12:44:47.554314	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#important}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 39, "startOffset": 32, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 706, "type": "TextPositionSelector", "start": 699}, {"type": "TextQuoteSelector", "exact": " focuse", "prefix": "\\n            My current research", "suffix": "s on using machine learning and "}]	{}	{}	f	5
9afec670-fd9a-11ea-a85f-a738de3669f9	2020-09-23 12:45:05.459557	2020-09-23 12:45:05.459557	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1, "startOffset": 34, "endContainer": "/div[1]/span[1]", "startContainer": "/div[1]"}, {"end": 66, "type": "TextPositionSelector", "start": 47}, {"type": "TextQuoteSelector", "exact": "ns:\\n              4", "prefix": "             Number of annotatio", "suffix": "\\n            \\n            \\n     "}]	{}	{}	f	1
ee0a3674-fd9a-11ea-a85f-7b8265f3b50a	2020-09-23 12:47:24.67087	2020-09-23 12:47:24.67087	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 366, "startOffset": 361, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 367, "type": "TextPositionSelector", "start": 362}, {"type": "TextQuoteSelector", "exact": "Autho", "prefix": "oems And Songs Of Robert Burns\\n\\n", "suffix": "r: Robert Burns\\n\\nRelease Date: J"}]	{}	{}	f	3
25ba62c4-0656-11eb-ac3f-77763f017816	2020-10-04 15:27:43.336557	2020-10-04 15:27:43.336557	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#important}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 119, "startOffset": 111, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 786, "type": "TextPositionSelector", "start": 778}, {"type": "TextQuoteSelector", "exact": "cation, ", "prefix": "ing methods in novel ways in edu", "suffix": "especially for behavioural \\n    "}]	{}	{}	f	5
c6d491da-fbce-11ea-add0-0785dc85ebf4	2020-09-21 05:53:30.481449	2020-09-21 05:53:30.481449	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1463, "startOffset": 1458, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1680, "type": "TextPositionSelector", "start": 1675}, {"type": "TextQuoteSelector", "exact": "t pag", "prefix": "unity\\n---------\\n\\nSee our [Contac", "suffix": "e to join us on Slack](https://w"}]	{}	{}	f	1
1a065fbe-fbcf-11ea-add0-83dc64564a60	2020-09-21 05:55:49.955079	2020-09-21 05:55:49.955079	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1365, "startOffset": 1361, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1582, "type": "TextPositionSelector", "start": 1578}, {"type": "TextQuoteSelector", "exact": "ps:/", "prefix": "o the client.\\n\\n[developers]: htt", "suffix": "/h.readthedocs.io/projects/clien"}]	{}	{}	f	1
63b6c5da-fbd0-11ea-add0-075f96cbc859	2020-09-21 06:05:03.113053	2020-09-21 06:05:03.113053	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 2406, "startOffset": 2401, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 2623, "type": "TextPositionSelector", "start": 2618}, {"type": "TextQuoteSelector", "exact": "ation", "prefix": "enses. All of the\\nlicense inform", "suffix": " can be found in the included [L"}]	{}	{}	f	1
2748b226-0656-11eb-ac3f-7f123f033577	2020-10-04 15:27:45.962846	2020-10-04 15:27:45.962846	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#confusing}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 135, "startOffset": 124, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 802, "type": "TextPositionSelector", "start": 791}, {"type": "TextQuoteSelector", "exact": "ially for b", "prefix": "n novel ways in education, espec", "suffix": "ehavioural \\n            analytic"}]	{}	{}	f	5
298042d4-0656-11eb-ac3f-3bb615b9faff	2020-10-04 15:27:49.699535	2020-10-04 15:27:49.699535	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#irrelevant}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 146, "startOffset": 138, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 813, "type": "TextPositionSelector", "start": 805}, {"type": "TextQuoteSelector", "exact": "vioural ", "prefix": "n education, especially for beha", "suffix": "\\n            analytics, analytic"}]	{}	{}	f	5
6c1bc672-0656-11eb-ac3f-93f02210c2a1	2020-10-04 15:29:41.461042	2020-10-04 15:29:41.461042	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#important}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 247, "startOffset": 237, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 914, "type": "TextPositionSelector", "start": 904}, {"type": "TextQuoteSelector", "exact": "earning an", "prefix": "mputer supported collaborative l", "suffix": "d personalisation of learning ex"}]	{}	{}	f	5
68a7b590-fbd0-11ea-add0-dfbefe677ced	2020-09-21 06:05:11.500132	2020-09-21 06:05:11.500132	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 2392, "startOffset": 2388, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 2609, "type": "TextPositionSelector", "start": 2605}, {"type": "TextQuoteSelector", "exact": "icen", "prefix": "their own licenses. All of the\\nl", "suffix": "se information can be found in t"}]	{}	{}	f	1
b2508776-fbd0-11ea-add0-a7bf2d1d3896	2020-09-21 06:07:14.280942	2020-09-21 06:07:14.280942	acct:admin01@localhost	__world__			{#irrelevant}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1229, "startOffset": 1226, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1446, "type": "TextPositionSelector", "start": 1443}, {"type": "TextQuoteSelector", "exact": "See", "prefix": "ding/\\n\\nDevelopment\\n-----------\\n\\n", "suffix": " the client [Development Guide]["}]	{}	{}	f	1
dfec93f0-fced-11ea-b058-fb00f5ef9e08	2020-09-22 16:08:37.626282	2020-09-22 16:08:37.626282	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 370, "startOffset": 363, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 371, "type": "TextPositionSelector", "start": 364}, {"type": "TextQuoteSelector", "exact": "thor: R", "prefix": "ms And Songs Of Robert Burns\\n\\nAu", "suffix": "obert Burns\\n\\nRelease Date: Janua"}]	{}	{}	f	3
ac0a6168-fcff-11ea-b058-7f647fb5e895	2020-09-22 18:16:02.047928	2020-09-22 18:16:02.047928	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/doyle	httpx://localhost:3000/document/doyle	[{"type": "RangeSelector", "endOffset": 197, "startOffset": 184, "endContainer": "/p[2]", "startContainer": "/p[2]"}, {"end": 320, "type": "TextPositionSelector", "start": 307}, {"type": "TextQuoteSelector", "exact": " Project Gute", "prefix": " it under\\n      the terms of the", "suffix": "nberg License included with this"}]	{}	{}	f	4
f5abb416-fcff-11ea-b058-935075205d99	2020-09-22 18:18:05.517489	2020-09-22 18:18:05.517489	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 262, "startOffset": 259, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 263, "type": "TextPositionSelector", "start": 260}, {"type": "TextQuoteSelector", "exact": "nse", "prefix": "ms of the Project Gutenberg Lice", "suffix": " included\\nwith this eBook or onl"}]	{}	{}	f	3
ddb492ce-fd63-11ea-a227-4bd283a16d77	2020-09-23 06:13:14.962414	2020-09-23 06:13:14.962414	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 555, "startOffset": 543, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 556, "type": "TextPositionSelector", "start": 544}, {"type": "TextQuoteSelector", "exact": " EBOOK POEMS", "prefix": " START OF THIS PROJECT GUTENBERG", "suffix": " AND SONGS OF ROBERT BURNS ***\\n\\n"}]	{}	{}	f	3
2a5d3da8-fd80-11ea-a227-17c0d016c682	2020-09-23 09:35:49.218575	2020-09-23 09:35:49.218575	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 203, "startOffset": 191, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 204, "type": "TextPositionSelector", "start": 192}, {"type": "TextQuoteSelector", "exact": "e it away or", "prefix": "hatsoever.  You may copy it, giv", "suffix": "\\nre-use it under the terms of th"}]	{}	{}	f	3
9e8ca65c-02ec-11eb-89d7-93d53433508b	2020-09-30 07:14:45.584027	2020-09-30 07:14:45.584027	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#confusing}	f	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	[{"type": "RangeSelector", "endOffset": 80, "startOffset": 73, "endContainer": "/div[1]/div[2]/div[1]/div[2]/div[1]/section[1]/div[1]/p[1]", "startContainer": "/div[1]/div[2]/div[1]/div[2]/div[1]/section[1]/div[1]/p[1]"}, {"end": 20526, "type": "TextPositionSelector", "start": 20519}, {"type": "TextQuoteSelector", "exact": "bout ho", "prefix": "tarted in R. I’ll briefly talk a", "suffix": "w to download and install R, but"}]	{}	{}	f	6
cb98f3b0-02f3-11eb-89d7-933368a241fb	2020-09-30 08:06:07.852045	2020-09-30 08:06:07.852045	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#confusing}	f	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	[{"type": "RangeSelector", "endOffset": 85, "startOffset": 80, "endContainer": "/div[2]/div[2]/div[1]/div[2]/div[1]/section[1]/div[1]/p[1]", "startContainer": "/div[2]/div[2]/div[1]/div[2]/div[1]/section[1]/div[1]/p[1]"}, {"end": 20477, "type": "TextPositionSelector", "start": 20472}, {"type": "TextQuoteSelector", "exact": "w to ", "prefix": "in R. I’ll briefly talk about ho", "suffix": "download and install R, but most"}]	{}	{}	f	6
a8bce194-064f-11eb-ac3f-6bfb6cbe0835	2020-10-04 14:41:16.575865	2020-10-04 14:41:16.575865	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#important}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 251, "startOffset": 240, "endContainer": "/div[1]/div[1]/p[1]", "startContainer": "/div[1]/div[1]/p[1]"}, {"end": 619, "type": "TextPositionSelector", "start": 608}, {"type": "TextQuoteSelector", "exact": "ts and reco", "prefix": "racting business relevant insigh", "suffix": "mmendations from data.\\n         "}]	{}	{}	f	5
ac06ed04-064f-11eb-ac3f-cb38d477768a	2020-10-04 14:41:22.192606	2020-10-04 14:41:22.192606	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#important}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 61, "startOffset": 52, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 728, "type": "TextPositionSelector", "start": 719}, {"type": "TextQuoteSelector", "exact": "chine lea", "prefix": "ent research focuses on using ma", "suffix": "rning and data mining methods in"}]	{}	{}	f	5
1b80a4ea-fbe2-11ea-add0-83ee683a36f7	2020-09-21 08:11:52.935779	2020-09-21 08:11:52.935779	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/	httpx://localhost:3000	[{"type": "RangeSelector", "endOffset": 1543, "startOffset": 1511, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 1759, "type": "TextPositionSelector", "start": 1727}, {"type": "TextQuoteSelector", "exact": "ontact/), or [log in once you've", "prefix": "Slack](https://web.hypothes.is/c", "suffix": " already created an account](htt"}]	{}	{}	f	1
7bf2918e-0656-11eb-ac3f-83a9d69c2b81	2020-10-04 15:30:08.008807	2020-10-04 15:30:08.008807	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#confusing}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 241, "startOffset": 229, "endContainer": "/div[1]/div[1]/p[1]", "startContainer": "/div[1]/div[1]/p[1]"}, {"end": 609, "type": "TextPositionSelector", "start": 597}, {"type": "TextQuoteSelector", "exact": "vant insight", "prefix": "       \\textracting business rele", "suffix": "s and recommendations from data."}]	{}	{}	f	5
a4b90256-0656-11eb-ac3f-cb9c3ca19c7a	2020-10-04 15:31:16.434271	2020-10-04 15:31:16.434271	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 184, "startOffset": 176, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 185, "type": "TextPositionSelector", "start": 177}, {"type": "TextQuoteSelector", "exact": "ay copy ", "prefix": " restrictions whatsoever.  You m", "suffix": "it, give it away or\\nre-use it un"}]	{}	{}	f	3
ce5ae90c-0657-11eb-ac3f-6f33f3f7a02c	2020-10-04 15:39:35.706218	2020-10-04 15:39:35.706218	acct:admin01@localhost	__world__			{#interesting}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 57, "startOffset": 47, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 58, "type": "TextPositionSelector", "start": 48}, {"type": "TextQuoteSelector", "exact": "urns, by R", "prefix": "rg's Poems And Songs Of Robert B", "suffix": "obert Burns\\n\\nThis eBook is for t"}]	{}	{}	f	3
e71527f0-0657-11eb-ac3f-3be89b188553	2020-10-04 15:40:17.234725	2020-10-04 15:40:17.234725	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#confusing}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 177, "startOffset": 164, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 844, "type": "TextPositionSelector", "start": 831}, {"type": "TextQuoteSelector", "exact": "tics, analyti", "prefix": "r behavioural \\n            analy", "suffix": "cs for content authoring, comput"}]	{}	{}	f	5
63b1cf56-0659-11eb-ac3f-f7068e62c1c4	2020-10-04 15:50:55.77704	2020-10-04 15:50:55.77704	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#confusing}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 50, "startOffset": 13, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 717, "type": "TextPositionSelector", "start": 680}, {"type": "TextQuoteSelector", "exact": "My current research focuses on using ", "prefix": "      \\n            \\n            ", "suffix": "machine learning and data mining"}]	{}	{}	f	5
42bd6a2a-065a-11eb-9fff-2314fe3e4876	2020-10-04 15:57:10.023317	2020-10-04 15:57:10.023317	acct:admin01@localhost	__world__	test	<p>test</p>\n	{#note}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 69, "startOffset": 55, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 70, "type": "TextPositionSelector", "start": 56}, {"type": "TextQuoteSelector", "exact": " Robert Burns\\n", "prefix": "ms And Songs Of Robert Burns, by", "suffix": "\\nThis eBook is for the use of an"}]	{}	{}	f	3
7a56c710-065a-11eb-9fff-dba1b7d911ca	2020-10-04 15:58:43.347537	2020-10-04 15:58:43.347537	acct:admin01@localhost	__world__			{#irrelevant}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 196, "startOffset": 185, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 197, "type": "TextPositionSelector", "start": 186}, {"type": "TextQuoteSelector", "exact": "t, give it ", "prefix": "ions whatsoever.  You may copy i", "suffix": "away or\\nre-use it under the term"}]	{}	{}	f	3
8b7f468e-065a-11eb-9fff-b3472fe720e8	2020-10-04 15:59:12.069156	2020-10-04 15:59:12.069156	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E			{#interesting}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 77, "startOffset": 68, "endContainer": "/div[1]/div[1]/p[2]", "startContainer": "/div[1]/div[1]/p[2]"}, {"end": 744, "type": "TextPositionSelector", "start": 735}, {"type": "TextQuoteSelector", "exact": "nd data m", "prefix": "uses on using machine learning a", "suffix": "ining methods in novel ways in e"}]	{}	{}	f	5
d66b760e-065a-11eb-9fff-b36e07711c35	2020-10-04 16:01:17.769044	2020-10-04 16:01:17.769044	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 24, "startOffset": 16, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 25, "type": "TextPositionSelector", "start": 17}, {"type": "TextQuoteSelector", "exact": "g's Poem", "prefix": "\\nProject Gutenber", "suffix": "s And Songs Of Robert Burns, by "}]	{}	{}	f	3
09829856-065b-11eb-9fff-e738b6415bc5	2020-10-04 16:02:43.523978	2020-10-04 16:02:43.523978	acct:admin01@localhost	__world__			{#important}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 109, "startOffset": 103, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 110, "type": "TextPositionSelector", "start": 104}, {"type": "TextQuoteSelector", "exact": "ne any", "prefix": "his eBook is for the use of anyo", "suffix": "where at no cost and with\\nalmost"}]	{}	{}	f	3
0ac5fd66-065b-11eb-9fff-f35bbd429367	2020-10-04 16:02:45.535216	2020-10-04 16:02:45.535216	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 117, "startOffset": 112, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 118, "type": "TextPositionSelector", "start": 113}, {"type": "TextQuoteSelector", "exact": "re at", "prefix": " is for the use of anyone anywhe", "suffix": " no cost and with\\nalmost no rest"}]	{}	{}	f	3
6ab9ce42-065a-11eb-9fff-6fd369907d46	2020-10-04 15:58:17.121843	2020-10-04 16:14:36.361063	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	GJw65n1E	j	<p>j</p>\n	{#confusing}	f	http://shaveensingh.com/?	httpx://shaveensingh.com	[{"type": "RangeSelector", "endOffset": 243, "startOffset": 226, "endContainer": "/div[1]/div[1]/p[1]", "startContainer": "/div[1]/div[1]/p[1]"}, {"end": 611, "type": "TextPositionSelector", "start": 594}, {"type": "TextQuoteSelector", "exact": "elevant insights ", "prefix": "          \\textracting business r", "suffix": "and recommendations from data.\\n "}]	{}	{}	f	5
9e96c7b8-067f-11eb-9fff-53f04479d25f	2020-10-04 20:24:35.407214	2020-10-04 20:24:35.407214	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 753, "startOffset": 742, "endContainer": "/pre[676]", "startContainer": "/pre[676]"}, {"end": 734013, "type": "TextPositionSelector", "start": 734002}, {"type": "TextQuoteSelector", "exact": "' silver ra", "prefix": "c.\\n\\n     When Cynthia lights, wi", "suffix": "y,\\n     The weary shearer's hame"}]	{}	{}	f	3
758c5404-0680-11eb-9fff-7730e6ed407b	2020-10-04 20:30:35.861744	2020-10-04 20:30:35.861744	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 37, "startOffset": 32, "endContainer": "/h2[504]", "startContainer": "/h2[504]"}, {"end": 734428, "type": "TextPositionSelector", "start": 734423}, {"type": "TextQuoteSelector", "exact": "Willy", "prefix": "\\n      Dialogue song—Philly And ", "suffix": "\\n    \\n     Tune—“The Sow's tail "}]	{}	{}	f	3
ec95c7ee-0688-11eb-89bc-4720dc4eaafa	2020-10-04 21:31:11.777977	2020-10-04 21:31:11.777977	acct:admin01@localhost	__world__			{#confusing}	f	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	[{"type": "RangeSelector", "endOffset": 153, "startOffset": 143, "endContainer": "/pre[1]", "startContainer": "/pre[1]"}, {"end": 414, "type": "TextPositionSelector", "start": 404}, {"type": "TextQuoteSelector", "exact": "o restrict", "prefix": "ere at no cost and with\\nalmost n", "suffix": "ions whatsoever.  You may copy i"}]	{}	{}	f	3
d0b68ef4-0738-11eb-91ac-274c527a7ff2	2020-10-05 18:30:16.138794	2020-10-05 18:30:16.138794	acct:admin01@localhost	__world__			{#confusing}	f	http://www.shaveensingh.com/	httpx://www.shaveensingh.com	[{"type": "RangeSelector", "endOffset": 269, "startOffset": 262, "endContainer": "/div[1]/div[1]/p[1]", "startContainer": "/div[1]/div[1]/p[1]"}, {"end": 637, "type": "TextPositionSelector", "start": 630}, {"type": "TextQuoteSelector", "exact": " from d", "prefix": "ant insights and recommendations", "suffix": "ata.\\n            \\n            \\n "}]	{}	{}	f	2
\.


--
-- Data for Name: annotation_moderation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annotation_moderation (created, updated, id, annotation_id) FROM stdin;
\.


--
-- Data for Name: authclient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authclient (created, updated, id, name, secret, authority, grant_type, response_type, redirect_uri, trusted) FROM stdin;
2020-09-16 04:13:47.018535	2020-09-16 04:13:47.018541	044a1698-f7d3-11ea-bb2d-5f1ed273c9c3	Client	\N	localhost	authorization_code	code	http://localhost:5000/app.html	f
2020-09-23 08:31:32.659086	2020-09-23 08:31:32.659112	2f6dfac0-fd77-11ea-a227-271b6b674f35	LMS	QgEa8e0heNKMYB9-_YtZWR8wRzL8VAY33N46nc2-SPo	lms.hypothes.is	client_credentials	\N	\N	f
2020-09-23 08:32:23.243244	2020-09-23 08:32:23.24325	4d91f218-fd77-11ea-a227-a7b26f9af281	LMS JWT	YdpE8CVZLsY1bvkGOivjNp85AcMOUKRutDkJWIvsbHs	lms.hypothes.is	jwt_bearer	\N	\N	f
\.


--
-- Data for Name: authticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authticket (created, updated, id, expires, user_id, user_userid) FROM stdin;
2020-10-05 18:42:12.606113	2020-10-05 20:16:36.998299	za2BDZxe51xAU916_hBaE24-_gRQvn9AKYmKQrPLJC4	2020-10-12 20:16:36.994056	1	acct:admin01@localhost
2020-10-05 20:36:18.280515	2020-10-05 20:36:18.280565	__rlyo69Th2_eiKEehpGMBsWFlJZbeM3a6-zgNcMUDs	2020-10-12 20:36:18.275542	1	acct:admin01@localhost
2020-10-04 14:33:00.612496	2020-10-05 05:02:05.564372	hOr76981Qvn4fHq7NRXWM03n_HrJoVLi44eUsYqek8c	2020-10-12 05:02:05.561294	1	acct:admin01@localhost
2020-09-23 08:39:01.318545	2020-09-30 07:15:37.081071	VjTQp3Kwkl2hfBJ8aE1NNZyxR4tkr52eNeeP0zpPGjc	2020-10-07 07:15:37.078464	1	acct:admin01@localhost
2020-10-05 05:25:48.039969	2020-10-05 17:06:49.510606	Ah73FpEH-4hTrjWr-sKv9eerNg7s8NbD3JZs1MmjRNU	2020-10-12 17:06:49.507922	1	acct:admin01@localhost
2020-10-05 17:08:47.975172	2020-10-05 17:08:47.975185	viODjwccoBfWeXqipMCqycmbbOuO-HzqBN0efQ1WxNU	2020-10-12 17:08:47.961636	1	acct:admin01@localhost
2020-10-05 17:10:37.80542	2020-10-05 17:10:37.805427	eNTWGl7JVwyDW831W8zVVCcGxie7GFOb1LauL5UBJL8	2020-10-12 17:10:37.802778	1	acct:admin01@localhost
2020-10-05 17:38:47.88537	2020-10-05 17:38:47.885393	qMyBVIcVh2GBbacDIQhDXCuhE1VVt6M4mXtrebOgHzU	2020-10-12 17:38:47.878877	1	acct:admin01@localhost
2020-10-05 17:54:44.516785	2020-10-05 17:54:44.516808	iu8oM3l4tlbpHrRAUXsOuTlhcXbupQKRylIdjV01b0M	2020-10-12 17:54:44.514019	1	acct:admin01@localhost
2020-10-05 18:08:56.494199	2020-10-05 18:08:56.494209	jerXgBU4-TxxbmLUMgPMEBgS25D0SoNuTjUH51xPQl4	2020-10-12 18:08:56.489593	1	acct:admin01@localhost
2020-10-06 09:37:57.732234	2020-10-06 12:02:11.266957	8QxNGWW7lV6rdEX5pVo7ojFmuX8iFjOaALN_swrvnJU	2020-10-13 12:02:11.265591	1	acct:admin01@localhost
\.


--
-- Data for Name: authzcode; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authzcode (created, updated, id, user_id, authclient_id, code, expires) FROM stdin;
\.


--
-- Data for Name: blocklist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blocklist (id, uri) FROM stdin;
\.


--
-- Data for Name: document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document (created, updated, id, title, web_uri) FROM stdin;
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	6	Chapter 3 Getting started with R | Learning statistics with R: A tutorial for psychology students and other beginners. (Version 0.6.1)	https://learningstatisticswithr.com/book/introR.html?
2020-09-23 12:42:19.993995	2020-10-04 16:14:36.361063	5	Shaveen Singh - PhD Student in Information Technology - Monash University	http://shaveensingh.com/?
2020-09-21 11:22:11.950445	2020-10-04 21:31:11.777977	3	Poems and Songs of Robert Burns, by Robert Burns	http://localhost:3000/document/burns
2020-09-21 06:25:41.974957	2020-10-05 18:30:16.138794	2	Shaveen Singh - PhD Student in Information Technology - Monash University	http://www.shaveensingh.com/
2020-09-22 18:16:02.047928	2020-09-22 18:16:02.127145	4	The Disappearance of Lady Carfax, by Arthur Conan Doyle	http://localhost:3000/document/doyle
2020-09-16 04:15:55.625578	2020-09-23 12:45:05.459557	1	Hypothesis Client Test	http://localhost:3000/
\.


--
-- Data for Name: document_meta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_meta (created, updated, id, claimant, claimant_normalized, type, value, document_id) FROM stdin;
2020-09-22 18:16:02.047928	2020-09-22 18:16:02.047928	5	http://localhost:3000/document/doyle	httpx://localhost:3000/document/doyle	title	{"The Disappearance of Lady Carfax, by Arthur Conan Doyle"}	4
2020-09-23 12:42:19.993995	2020-10-04 15:59:12.069156	7	http://shaveensingh.com/?	httpx://shaveensingh.com	favicon	{http://shaveensingh.com/img/favicon.ico}	5
2020-09-23 12:42:19.993995	2020-10-04 16:14:36.361063	6	http://shaveensingh.com/?	httpx://shaveensingh.com	title	{"Shaveen Singh - PhD Student in Information Technology - Monash University"}	5
2020-09-21 11:22:11.950445	2020-10-04 21:31:11.777977	4	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	title	{"Poems and Songs of Robert Burns, by Robert Burns"}	3
2020-09-16 04:15:55.625578	2020-09-23 12:45:05.459557	1	http://localhost:3000/	httpx://localhost:3000	title	{"Hypothesis Client Test"}	1
2020-09-21 06:25:41.974957	2020-10-05 18:30:16.138794	3	http://www.shaveensingh.com/	httpx://www.shaveensingh.com	title	{"Shaveen Singh - PhD Student in Information Technology - Monash University"}	2
2020-09-21 06:25:41.974957	2020-10-05 18:30:16.138794	2	http://www.shaveensingh.com/	httpx://www.shaveensingh.com	favicon	{http://www.shaveensingh.com/img/favicon.ico}	2
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	8	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	title	{"Chapter 3 Getting started with R | Learning statistics with R: A tutorial for psychology students and other beginners. (Version 0.6.1)"}	6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	9	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	facebook.title	{"Chapter 3 Getting started with R | Learning statistics with R: A tutorial for psychology students and other beginners. (Version 0.6.1)"}	6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	10	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	facebook.type	{book}	6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	11	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	facebook.description	{"Learning Statistics with R covers the contents of an introductory statistics class, as typically taught to undergraduate psychology students, focusing on the use of the R statistical software."}	6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	12	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	facebook.image	{http://learningstatisticswithr.com/images/jasmine-faint.jpg}	6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	13	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	twitter.card	{summary,summary}	6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	14	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	twitter.title	{"Chapter 3 Getting started with R | Learning statistics with R: A tutorial for psychology students and other beginners. (Version 0.6.1)"}	6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	15	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	twitter.description	{"Learning Statistics with R covers the contents of an introductory statistics class, as typically taught to undergraduate psychology students, focusing on the use of the R statistical software."}	6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	16	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	twitter.creator	{@djnavarro}	6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	17	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	twitter.image	{http://learningstatisticswithr.com/images/jasmine-faint.jpg}	6
\.


--
-- Data for Name: document_uri; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_uri (created, updated, id, claimant, claimant_normalized, uri, uri_normalized, type, content_type, document_id) FROM stdin;
2020-09-22 18:16:02.047928	2020-09-22 18:16:02.047928	6	http://localhost:3000/document/doyle	httpx://localhost:3000/document/doyle	http://localhost:3000/document/doyle	httpx://localhost:3000/document/doyle	self-claim		4
2020-09-23 12:42:19.993995	2020-10-04 15:59:12.069156	8	http://shaveensingh.com/?	httpx://shaveensingh.com	http://localhost:9080/http://shaveensingh.com?via.client.openSidebar=1&via.client.requestConfigFromFrame.origin=http%3A%2F%2Flocalhost%3A8001&via.client.requestConfigFromFrame.ancestorLevel=2&via.external_link_mode=new-tab	httpx://localhost:9080/http://shaveensingh.com?via.client.openSidebar=1&via.client.requestConfigFromFrame.ancestorLevel=2&via.client.requestConfigFromFrame.origin=http:%2F%2Flocalhost:8001&via.external_link_mode=new-tab			5
2020-09-23 12:42:19.993995	2020-10-04 15:59:12.069156	9	http://shaveensingh.com/?	httpx://shaveensingh.com	http://shaveensingh.com/?	httpx://shaveensingh.com	rel-canonical		5
2020-09-16 04:15:55.625578	2020-09-23 12:45:05.459557	1	http://localhost:3000/	httpx://localhost:3000	http://localhost:3000/	httpx://localhost:3000	self-claim		1
2020-09-23 12:42:19.993995	2020-10-04 16:14:36.361063	7	http://shaveensingh.com/?	httpx://shaveensingh.com	http://shaveensingh.com/?	httpx://shaveensingh.com	self-claim		5
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	11	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	http://localhost:9080/https://learningstatisticswithr.com/book/introR.html?via.client.openSidebar=1&via.client.requestConfigFromFrame.origin=http%3A%2F%2Flocalhost%3A8001&via.client.requestConfigFromFrame.ancestorLevel=2&via.external_link_mode=new-tab	httpx://localhost:9080/https://learningstatisticswithr.com/book/introR.html?via.client.openSidebar=1&via.client.requestConfigFromFrame.ancestorLevel=2&via.client.requestConfigFromFrame.origin=http:%2F%2Flocalhost:8001&via.external_link_mode=new-tab			6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	12	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	rel-canonical		6
2020-09-30 07:14:45.584027	2020-09-30 08:06:07.852045	10	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	https://learningstatisticswithr.com/book/introR.html?	httpx://learningstatisticswithr.com/book/introR.html	self-claim		6
2020-09-21 11:22:11.950445	2020-10-04 21:31:11.777977	5	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	http://localhost:3000/document/burns	httpx://localhost:3000/document/burns	self-claim		3
2020-09-21 06:25:41.974957	2020-10-05 18:30:16.138794	3	http://www.shaveensingh.com/	httpx://www.shaveensingh.com	http://localhost:9080/www.shaveensingh.com	httpx://localhost:9080/www.shaveensingh.com			2
2020-09-21 06:25:41.974957	2020-10-05 18:30:16.138794	4	http://www.shaveensingh.com/	httpx://www.shaveensingh.com	http://www.shaveensingh.com/	httpx://www.shaveensingh.com	rel-canonical		2
2020-09-21 06:25:41.974957	2020-10-05 18:30:16.138794	2	http://www.shaveensingh.com/	httpx://www.shaveensingh.com	http://www.shaveensingh.com/	httpx://www.shaveensingh.com	self-claim		2
\.


--
-- Data for Name: feature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feature (id, name, everyone, admins, staff) FROM stdin;
13	embed_cachebuster	f	f	f
14	client_display_names	f	f	f
15	client_do_not_separate_replies	f	f	f
16	client_search_input	f	f	f
17	synchronous_indexing	f	f	f
\.


--
-- Data for Name: featurecohort; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.featurecohort (created, updated, id, name) FROM stdin;
\.


--
-- Data for Name: featurecohort_feature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.featurecohort_feature (id, cohort_id, feature_id) FROM stdin;
\.


--
-- Data for Name: featurecohort_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.featurecohort_user (id, cohort_id, user_id) FROM stdin;
\.


--
-- Data for Name: flag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flag (created, updated, id, annotation_id, user_id) FROM stdin;
\.


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."group" (created, updated, id, pubid, authority, name, creator_id, description, enforce_scope, authority_provided_id, joinable_by, readable_by, writeable_by, organization_id) FROM stdin;
2020-09-16 04:01:37.443639	2020-09-16 04:01:37.443648	1	__world__	localhost	Public	\N	\N	t	\N	\N	world	authority	1
2020-09-23 09:53:18.752694	2020-09-23 09:53:18.752706	2	GJw65n1E	lms.hypothes.is	Test Course	18	\N	t	7d9155ffbd95e21af1ac50093746bd0318b7b98a	authority	members	members	\N
\.


--
-- Data for Name: groupscope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groupscope (id, group_id, origin, path) FROM stdin;
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organization (created, updated, id, pubid, name, logo, authority) FROM stdin;
2020-09-16 04:01:37.417019	2020-09-16 04:01:37.417037	1	__default__	Hypothesis	<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n<svg width="24px" height="28px" viewBox="0 0 24 28" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">\n    <rect fill="#ffffff" stroke="none" width="17.14407" height="16.046612" x="3.8855932" y="3.9449153" />\n    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">\n        <path d="M0,2.00494659 C0,0.897645164 0.897026226,0 2.00494659,0 L21.9950534,0 C23.1023548,0 24,0.897026226 24,2.00494659 L24,21.9950534 C24,23.1023548 23.1029738,24 21.9950534,24 L2.00494659,24 C0.897645164,24 0,23.1029738 0,21.9950534 L0,2.00494659 Z M9,24 L12,28 L15,24 L9,24 Z M7.00811294,4 L4,4 L4,20 L7.00811294,20 L7.00811294,15.0028975 C7.00811294,12.004636 8.16824717,12.0097227 9,12 C10,12.0072451 11.0189302,12.0606714 11.0189302,14.003477 L11.0189302,20 L14.0270431,20 L14.0270431,13.1087862 C14.0270433,10 12,9.00309038 10,9.00309064 C8.01081726,9.00309091 8,9.00309086 7.00811294,11.0019317 L7.00811294,4 Z M19,19.9869002 C20.1045695,19.9869002 21,19.0944022 21,17.9934501 C21,16.892498 20.1045695,16 19,16 C17.8954305,16 17,16.892498 17,17.9934501 C17,19.0944022 17.8954305,19.9869002 19,19.9869002 Z" id="Rectangle-2-Copy-17" fill="currentColor"></path>\n    </g>\n</svg>\n	localhost
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.setting (created, updated, key, value) FROM stdin;
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscriptions (id, uri, type, active) FROM stdin;
1	acct:admin01@localhost	reply	t
2	acct:lms@localhost	reply	t
\.


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token (created, updated, id, userid, value, expires, refresh_token, refresh_token_expires, authclient_id) FROM stdin;
2020-09-30 07:12:21.736785	2020-09-30 07:12:21.736793	41	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-USrCv0Ug-0nkk9-NoCVU0jMa192UMO2zaFLTbD5jxOg	2020-09-30 08:12:21.735264	4657-XXQqBE7Ex5ZyyTWJQWxVfwMRZD7naiebVMftzNXhfSk	2020-10-07 07:12:21.735277	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 07:13:50.061571	2020-09-30 07:13:50.06158	42	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-O7RuY4hC0X4KtvwGT5bmbo1oHFeo5l7VmEK46PXGgYY	2020-09-30 08:13:50.058485	4657-KvQ1q-hKX7EU9ObUaZPt-gaDCWFg3GkS74aR0CEW6qg	2020-10-07 07:13:50.058502	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 07:14:12.800073	2020-09-30 07:14:12.800079	43	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-ye391lGbln_Wmh3Dh_-SUuTTulzMuwXkJNNcPYQD0u4	2020-09-30 08:14:12.797901	4657--Y2GuvnNIpPcWziPV6OQrHXX7nFRdy9mE8DVh3c8vX4	2020-10-07 07:14:12.797912	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 07:14:33.693472	2020-09-30 07:14:33.693484	44	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-xo_cTqVpnmseEwgE46nBMvELy1Sua_JN3dUuD804kk8	2020-09-30 08:14:33.690096	4657-3DgZo47nZlx4LajyxgjmV9qi7L4oVL41CjUvmWzExqY	2020-10-07 07:14:33.69012	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 07:15:38.86081	2020-09-30 07:15:38.860816	45	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-515n__ZK4XAxLaj5jQbN8pLOBTkHFrxNcsx4h56SUdY	2020-09-30 08:15:38.857968	4657-94L4enfaGlefafckonZXFAMBN3w3rhjFOqNwkRw8c6I	2020-10-07 07:15:38.857983	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 07:16:26.78344	2020-09-30 07:16:26.783446	46	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-7zXK5dJI6XsHONQzLSquEHApOgSf6wfc-Zp3AAk1fKw	2020-09-30 08:16:26.782024	4657-Smq8LGt9j08kij261IRQo82rHGldS9SZk0_KmSucve0	2020-10-07 07:16:26.782039	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 07:16:44.354588	2020-09-30 07:16:44.354597	47	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-ZwssZIZpytDmQYbqbwpCwfNHGDuZEYR_KiT_HhJsrrI	2020-09-30 08:16:44.3528	4657-OCoMJTQeKamifVUomL8epPgw_GTU3AL-0Po946CPA6Q	2020-10-07 07:16:44.352814	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 14:41:07.440995	2020-10-04 14:41:07.44101	49	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-LDB6JSzJs-RN3H1PmaA8dzRPg570kSDFLOuUsrxxuPU	2020-10-04 15:41:07.438091	4657--r1qsxQIzqIQ20LXDIBoOJcPyP-P_7DYJxtNfmYQ0-Q	2020-10-11 14:41:07.438107	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:39:56.893171	2020-10-04 15:39:56.8932	60	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-dIUoEjdgHDAokHf2ksOF_UsTN7atCXp4-XUIzvCqNZ4	2020-10-04 16:39:56.889889	4657-ZuaRa5n0mB0KXh6ep_pOI4rJjJGvYcbzbebbQWeNCTM	2020-10-11 15:39:56.889904	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 06:58:59.0648	2020-09-30 06:58:59.06481	36	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-Go2pYuJ_qEW88KalK0aJis6xXdRtwnXw_GiKHy1sXQg	2020-09-30 07:58:59.062425	4657-EZk4SHYc03Yf249HGeaSD4Qs6qoJ3qz7s4-woPuM21M	2020-10-07 06:58:59.062441	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 06:59:35.444283	2020-09-30 06:59:35.44429	37	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-P8RjggqpgZvdoDXrmmcl_CM8aPjZp6ZdGzwZJOcdSpg	2020-09-30 07:59:35.440284	4657-siaYg85asI9r3eSMqwFbZT0K1TSq78QT9zGFXOd_Iww	2020-10-07 06:59:35.440304	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 06:59:43.267394	2020-09-30 06:59:43.267405	38	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-PkHx8HvhTD3kkxLaZZkgRdw4ZpIRiuPmEV1XHEa9CJI	2020-09-30 07:59:43.26503	4657-00jz0Om16ivxFGZ_aTdbydBrD9VKaDe9nEPbGAkUuFY	2020-10-07 06:59:43.265044	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 07:12:06.962533	2020-09-30 07:12:06.962552	39	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-mWpQWiBgeFvsPnY9XJrq9VfHHUGSoZtdE2j-MY1oKXE	2020-09-30 08:12:06.95956	4657-1WNcWaJRL3676h7c66vz5gXlg87xpD56uwgN1_cfzlk	2020-10-07 07:12:06.959579	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-09-30 07:12:19.0922	2020-09-30 07:12:19.09221	40	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-68j3fMYO5X_Fhf9casd5akoxV6140j0Rg1yOzHm4o-Q	2020-09-30 08:12:19.089542	4657-Wn-J74om9uONyVj4w8cScjVcvfVWmSRhql-KH99PR7o	2020-10-07 07:12:19.089559	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 14:42:48.061901	2020-10-04 14:42:48.061971	50	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-bLEZQiJ-35888aHCkEYVq0aDotaqcOYcVGT0ENDXB_g	2020-10-04 15:42:48.052523	4657-xznM7FpX1hPgNwxP3qSnRCKULKD4lAdKIAur2NW2mKQ	2020-10-11 14:42:48.052546	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 14:54:03.020892	2020-10-04 14:54:03.020982	51	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-Mon0mSzBFJdoiVzdi5dwxgYE9dZ-hgLckyknPGgXE1U	2020-10-04 15:54:03.017815	4657-svdCQjsce8-kyp4lYo_tMA97Ez6raMOTzSIQFQpu8gE	2020-10-11 14:54:03.017831	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 14:56:37.450004	2020-10-04 14:56:37.45001	52	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-UF-SCRpobXc3xti4E8GGygOzgh_mZ0oNWHUvlx6l3_Y	2020-10-04 15:56:37.448266	4657-ydmOfyk0mXUVctqgmzcfAi5ALDAlmcWsNAzLYCGJ60E	2020-10-11 14:56:37.44828	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 14:57:14.892905	2020-10-04 14:57:14.892916	53	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-J0P_8fixjGA0AD0RHHU4jHs7NQi2CJ1kEn7nMQT4x5U	2020-10-04 15:57:14.890329	4657-Y4OFLHdgueDBK1CbBs5sS-9gFLo2lypa0cKoASSozk4	2020-10-11 14:57:14.890347	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 14:57:33.644639	2020-10-04 14:57:33.644653	54	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768--q8rlAaDLG_9SgtdKKekaSISubUpt0ypO4n8HDg0zLY	2020-10-04 15:57:33.640437	4657-AGkkykf9gtWuhlsXE3q-jsB7pZvcFAXsw-NP3PtqGYE	2020-10-11 14:57:33.64045	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 14:58:07.006857	2020-10-04 14:58:07.006864	55	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-DvPKW5egPw6jDdVK4j3zqTRX6DxJNV0yls-8g-VFIFE	2020-10-04 15:58:07.005476	4657-39uNSBk4vBDrfxNopUcPYNClRFHVIK7f4tBEmlVpbcw	2020-10-11 14:58:07.005485	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:02:00.112431	2020-10-04 15:02:00.11253	56	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-N7jKZIW3WuYpIWgnvrv9x3LEy3e-Akm_-h7ebugsVJk	2020-10-04 16:02:00.103175	4657-URMkWfJmyDjHXIn07iLghDDBzraMA0miWwMwk9-bIkQ	2020-10-11 15:02:00.103221	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:29:59.516651	2020-10-04 15:29:59.516663	57	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-UxbsvOjPi-j3Q1DYoafeus7EWhqihcA8NP0fxTgwsy0	2020-10-04 16:29:59.513524	4657-wuASkdBwixKylMDTb0z-hjo4kjZhfC7gEpPL83aiJxU	2020-10-11 15:29:59.513533	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:30:20.5494	2020-10-04 15:30:20.549406	58	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-8-HHf5_7n3Pg9YzqeyCSm1JbCnHgi7L8likS2lhyzwg	2020-10-04 16:30:20.547954	4657-pU_w21TTbPf42Ndw83iY5q342IqBxiIk7ynoJtfxbGA	2020-10-11 15:30:20.547965	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 16:29:11.57988	2020-10-04 16:29:11.57989	69	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-0GR-gFHxvRd5ABgX1fXv5mBkt1eNWNPlVSJpJarhtNs	2020-10-04 17:29:11.57264	4657-KqAV2FfX1aVtVDJeHIst_ylJRDjXZQAJjGTtrY598Ps	2020-10-11 16:29:11.57266	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:40:11.18177	2020-10-04 15:40:11.181777	61	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-2lJbmS8sf4_cU412HdcYjKRwtKEfRIT2kpgJSO-zDQ4	2020-10-04 16:40:11.17999	4657-z6qGD0jHteDaIJyqQO_foBodyPn-7ztjmV3SOFrAAoE	2020-10-11 15:40:11.180016	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:41:29.479988	2020-10-04 15:41:29.480007	62	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-w8tyHg4oIdtTR4hKshoz6vBmsNEj54jJuoBcW-vbt0I	2020-10-04 16:41:29.476344	4657-8J7GNsJ8UvRsDoUiza6zLyCXEr9uD8NfeuURNSj658M	2020-10-11 15:41:29.476359	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:42:21.07333	2020-10-04 15:42:21.073339	63	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-hEXvskmXFHTfbiqP_f1_v1uT45CgQgVY8XmnePggPUg	2020-10-04 16:42:21.071543	4657-9FHZMZU6Mm8G5mQkyc9GJaqs_BHgS4FsaCJN-FueOz8	2020-10-11 15:42:21.071556	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:42:29.50772	2020-10-04 15:42:29.50773	64	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-jcrEHY-YkpvsmOLb4EA0ixsmTqysUk8tYVyQK5llXbA	2020-10-04 16:42:29.505072	4657-i7aDDvdcshpZzSOvVtrNNQBFvecapUI6Qw9OhRj92bE	2020-10-11 15:42:29.505087	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:58:04.460177	2020-10-04 15:58:04.460187	65	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-sLcZ1gi8rlEPHFkfkJ5Nx-OQKJldGUwTj9K4Nw3WrIs	2020-10-04 16:58:04.455433	4657-sF27PktVaP15_S75gaIXQk5TwuqpVPwvVcGTwzSk6N4	2020-10-11 15:58:04.455444	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 15:58:27.497147	2020-10-04 15:58:27.497154	66	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-304XILszMeQvQreqOu65JbM6f0Nglpvlbi31XYNFnaE	2020-10-04 16:58:27.494646	4657-x0zxVKCONfXjSk3Yq21Mna4O7TifMejtrJs75Z94c-8	2020-10-11 15:58:27.494664	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 16:14:31.463509	2020-10-04 16:14:31.463515	67	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-OWIfFl_jRkVohn2HFySuSRkIuSIJavjGH_8CCdNwDtg	2020-10-04 17:14:31.46143	4657-OXGdxrQ2zaT01Ha_r6RfZPURfOi-Wxzw50cjhSl7B9Q	2020-10-11 16:14:31.461448	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-04 16:14:42.673351	2020-10-04 16:14:42.673358	68	acct:e1f2aebb67e5d0e6c0d34f22d348ce@lms.hypothes.is	5768-catu0Kao8xgpSejGfjoB37VdSk9qlPunL3cEe0a0OsA	2020-10-04 17:14:42.671219	4657-gSwuUClAlaYc7xgxYPcCcT8LdszKLevPB54bd-pwL0s	2020-10-11 16:14:42.671234	4d91f218-fd77-11ea-a227-a7b26f9af281
2020-10-05 16:35:37.405137	2020-10-05 16:35:37.405554	80	acct:admin01@localhost	5768-MVVaXgGNVdDf8tw8dpOfDxk5ItipGPZ2wjlcVKruMS8	2020-10-05 17:35:37.387889	4657-eeFR5BAyHWaytZAcoqEXEYYvKxV9MjykjdqEu4-MKpc	2020-10-12 16:35:37.387899	044a1698-f7d3-11ea-bb2d-5f1ed273c9c3
2020-10-05 20:16:37.957566	2020-10-05 20:16:37.957584	115	acct:admin01@localhost	5768-7t0xEfj6wrLIkg0vjgGSFohtKCQG_mUt7QYo8eVqxyE	2020-10-05 21:16:37.937408	4657-9qnMA500U4nxJEWQUG3Dv702ncDajInqkDI7SVsR9t0	2020-10-12 20:16:37.937441	044a1698-f7d3-11ea-bb2d-5f1ed273c9c3
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, authority, display_name, description, location, uri, orcid, admin, staff, nipsa, sidebar_tutorial_dismissed, privacy_accepted, email, last_login_date, registered_date, activation_date, activation_id, password, password_updated, salt, "comms_opt_in column", comms_opt_in) FROM stdin;
17	e1f2aebb67e5d0e6c0d34f22d348ce	lms.hypothes.is	Administrator	\N	\N	\N	\N	f	f	f	t	\N	\N	\N	2020-09-23 11:56:41.08718	\N	\N	\N	\N	\N	f	f
1	admin01	localhost	\N	\N	\N	\N	\N	t	f	f	t	2020-09-16 04:02:43.603144	shaveen.singh@gmail.com	2020-10-06 09:37:57.721588	2020-09-16 04:02:43.95021	2020-09-16 04:03:48.11273	\N	$2b$12$lBhxa7oEjRkTo9fSasBvOePKe0QRmYn2BtMbJLIJa4Xps.fk7lTDC	2020-09-16 04:02:43.943994	\N	f	f
18	lms	lms.hypothes.is	\N	\N	\N	\N	\N	t	t	f	f	2020-09-16 04:02:43.603144	lms1@lms.hypothes.is	\N	2020-09-23 12:06:03.320609	2020-09-16 04:03:48.11273	\N	\N	\N	\N	f	f
\.


--
-- Data for Name: user_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group (id, user_id, group_id) FROM stdin;
16	17	2
\.


--
-- Data for Name: user_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_identity (id, provider, provider_unique_id, user_id) FROM stdin;
16	localhost	2	17
\.


--
-- Name: activation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activation_id_seq', 2, true);


--
-- Name: annotation_moderation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.annotation_moderation_id_seq', 1, false);


--
-- Name: authzcode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authzcode_id_seq', 6, true);


--
-- Name: blocklist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blocklist_id_seq', 1, false);


--
-- Name: document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_id_seq', 6, true);


--
-- Name: document_meta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_meta_id_seq', 17, true);


--
-- Name: document_uri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_uri_id_seq', 12, true);


--
-- Name: feature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feature_id_seq', 17, true);


--
-- Name: featurecohort_feature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.featurecohort_feature_id_seq', 1, false);


--
-- Name: featurecohort_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.featurecohort_id_seq', 1, false);


--
-- Name: featurecohort_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.featurecohort_user_id_seq', 1, false);


--
-- Name: flag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flag_id_seq', 1, false);


--
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_id_seq', 69, true);


--
-- Name: groupscope_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groupscope_id_seq', 1, false);


--
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organization_id_seq', 1, true);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscriptions_id_seq', 2, true);


--
-- Name: token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_id_seq', 115, true);


--
-- Name: user_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_group_id_seq', 68, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 71, true);


--
-- Name: user_identity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_identity_id_seq', 68, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: activation pk__activation; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activation
    ADD CONSTRAINT pk__activation PRIMARY KEY (id);


--
-- Name: annotation pk__annotation; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation
    ADD CONSTRAINT pk__annotation PRIMARY KEY (id);


--
-- Name: annotation_moderation pk__annotation_moderation; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation_moderation
    ADD CONSTRAINT pk__annotation_moderation PRIMARY KEY (id);


--
-- Name: authclient pk__authclient; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authclient
    ADD CONSTRAINT pk__authclient PRIMARY KEY (id);


--
-- Name: authticket pk__authticket; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authticket
    ADD CONSTRAINT pk__authticket PRIMARY KEY (id);


--
-- Name: authzcode pk__authzcode; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authzcode
    ADD CONSTRAINT pk__authzcode PRIMARY KEY (id);


--
-- Name: blocklist pk__blocklist; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocklist
    ADD CONSTRAINT pk__blocklist PRIMARY KEY (id);


--
-- Name: document pk__document; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT pk__document PRIMARY KEY (id);


--
-- Name: document_meta pk__document_meta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_meta
    ADD CONSTRAINT pk__document_meta PRIMARY KEY (id);


--
-- Name: document_uri pk__document_uri; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_uri
    ADD CONSTRAINT pk__document_uri PRIMARY KEY (id);


--
-- Name: feature pk__feature; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature
    ADD CONSTRAINT pk__feature PRIMARY KEY (id);


--
-- Name: featurecohort pk__featurecohort; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort
    ADD CONSTRAINT pk__featurecohort PRIMARY KEY (id);


--
-- Name: featurecohort_feature pk__featurecohort_feature; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_feature
    ADD CONSTRAINT pk__featurecohort_feature PRIMARY KEY (id);


--
-- Name: featurecohort_user pk__featurecohort_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_user
    ADD CONSTRAINT pk__featurecohort_user PRIMARY KEY (id);


--
-- Name: flag pk__flag; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flag
    ADD CONSTRAINT pk__flag PRIMARY KEY (id);


--
-- Name: group pk__group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT pk__group PRIMARY KEY (id);


--
-- Name: groupscope pk__groupscope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupscope
    ADD CONSTRAINT pk__groupscope PRIMARY KEY (id);


--
-- Name: organization pk__organization; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT pk__organization PRIMARY KEY (id);


--
-- Name: setting pk__setting; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT pk__setting PRIMARY KEY (key);


--
-- Name: subscriptions pk__subscriptions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT pk__subscriptions PRIMARY KEY (id);


--
-- Name: token pk__token; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT pk__token PRIMARY KEY (id);


--
-- Name: user pk__user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT pk__user PRIMARY KEY (id);


--
-- Name: user_group pk__user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group
    ADD CONSTRAINT pk__user_group PRIMARY KEY (id);


--
-- Name: user_identity pk__user_identity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_identity
    ADD CONSTRAINT pk__user_identity PRIMARY KEY (id);


--
-- Name: activation uq__activation__code; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activation
    ADD CONSTRAINT uq__activation__code UNIQUE (code);


--
-- Name: annotation_moderation uq__annotation_moderation__annotation_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation_moderation
    ADD CONSTRAINT uq__annotation_moderation__annotation_id UNIQUE (annotation_id);


--
-- Name: authzcode uq__authzcode__code; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authzcode
    ADD CONSTRAINT uq__authzcode__code UNIQUE (code);


--
-- Name: blocklist uq__blocklist__uri; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocklist
    ADD CONSTRAINT uq__blocklist__uri UNIQUE (uri);


--
-- Name: document_meta uq__document_meta__claimant_normalized; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_meta
    ADD CONSTRAINT uq__document_meta__claimant_normalized UNIQUE (claimant_normalized, type);


--
-- Name: document_uri uq__document_uri__claimant_normalized; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_uri
    ADD CONSTRAINT uq__document_uri__claimant_normalized UNIQUE (claimant_normalized, uri_normalized, type, content_type);


--
-- Name: feature uq__feature__name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature
    ADD CONSTRAINT uq__feature__name UNIQUE (name);


--
-- Name: featurecohort_feature uq__featurecohort_feature__cohort_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_feature
    ADD CONSTRAINT uq__featurecohort_feature__cohort_id UNIQUE (cohort_id, feature_id);


--
-- Name: featurecohort_user uq__featurecohort_user__cohort_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_user
    ADD CONSTRAINT uq__featurecohort_user__cohort_id UNIQUE (cohort_id, user_id);


--
-- Name: flag uq__flag__annotation_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flag
    ADD CONSTRAINT uq__flag__annotation_id UNIQUE (annotation_id, user_id);


--
-- Name: group uq__group__pubid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT uq__group__pubid UNIQUE (pubid);


--
-- Name: organization uq__organization__pubid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT uq__organization__pubid UNIQUE (pubid);


--
-- Name: token uq__token__refresh_token; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT uq__token__refresh_token UNIQUE (refresh_token);


--
-- Name: token uq__token__value; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT uq__token__value UNIQUE (value);


--
-- Name: user uq__user__email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT uq__user__email UNIQUE (email, authority);


--
-- Name: user_group uq__user_group__user_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group
    ADD CONSTRAINT uq__user_group__user_id UNIQUE (user_id, group_id);


--
-- Name: user_identity uq__user_identity__provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_identity
    ADD CONSTRAINT uq__user_identity__provider UNIQUE (provider, provider_unique_id);


--
-- Name: ix__annotation_groupid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__annotation_groupid ON public.annotation USING btree (groupid);


--
-- Name: ix__annotation_tags; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__annotation_tags ON public.annotation USING gin (tags);


--
-- Name: ix__annotation_thread_root; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__annotation_thread_root ON public.annotation USING btree (("references"[1]));


--
-- Name: ix__annotation_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__annotation_updated ON public.annotation USING btree (updated);


--
-- Name: ix__annotation_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__annotation_userid ON public.annotation USING btree (userid);


--
-- Name: ix__document_meta_document_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__document_meta_document_id ON public.document_meta USING btree (document_id);


--
-- Name: ix__document_meta_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__document_meta_updated ON public.document_meta USING btree (updated);


--
-- Name: ix__document_uri_document_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__document_uri_document_id ON public.document_uri USING btree (document_id);


--
-- Name: ix__document_uri_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__document_uri_updated ON public.document_uri USING btree (updated);


--
-- Name: ix__document_uri_uri_normalized; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__document_uri_uri_normalized ON public.document_uri USING btree (uri_normalized);


--
-- Name: ix__featurecohort_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__featurecohort_name ON public.featurecohort USING btree (name);


--
-- Name: ix__flag_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__flag_user_id ON public.flag USING btree (user_id);


--
-- Name: ix__group__groupid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix__group__groupid ON public."group" USING btree (authority, authority_provided_id);


--
-- Name: ix__group_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__group_name ON public."group" USING btree (name);


--
-- Name: ix__group_readable_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__group_readable_by ON public."group" USING btree (readable_by);


--
-- Name: ix__groupscope__scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__groupscope__scope ON public.groupscope USING btree (origin, path);


--
-- Name: ix__organization_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__organization_name ON public.organization USING btree (name);


--
-- Name: ix__user__nipsa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix__user__nipsa ON public."user" USING btree (nipsa) WHERE (nipsa IS TRUE);


--
-- Name: ix__user__userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix__user__userid ON public."user" USING btree (lower(replace(username, '.'::text, ''::text)), authority);


--
-- Name: subs_uri_idx_subscriptions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX subs_uri_idx_subscriptions ON public.subscriptions USING btree (uri);


--
-- Name: annotation fk__annotation__document_id__document; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation
    ADD CONSTRAINT fk__annotation__document_id__document FOREIGN KEY (document_id) REFERENCES public.document(id);


--
-- Name: annotation_moderation fk__annotation_moderation__annotation_id__annotation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation_moderation
    ADD CONSTRAINT fk__annotation_moderation__annotation_id__annotation FOREIGN KEY (annotation_id) REFERENCES public.annotation(id) ON DELETE CASCADE;


--
-- Name: authticket fk__authticket__user_id__user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authticket
    ADD CONSTRAINT fk__authticket__user_id__user FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: authzcode fk__authzcode__authclient_id__authclient; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authzcode
    ADD CONSTRAINT fk__authzcode__authclient_id__authclient FOREIGN KEY (authclient_id) REFERENCES public.authclient(id) ON DELETE CASCADE;


--
-- Name: authzcode fk__authzcode__user_id__user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authzcode
    ADD CONSTRAINT fk__authzcode__user_id__user FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: document_meta fk__document_meta__document_id__document; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_meta
    ADD CONSTRAINT fk__document_meta__document_id__document FOREIGN KEY (document_id) REFERENCES public.document(id);


--
-- Name: document_uri fk__document_uri__document_id__document; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_uri
    ADD CONSTRAINT fk__document_uri__document_id__document FOREIGN KEY (document_id) REFERENCES public.document(id);


--
-- Name: featurecohort_feature fk__featurecohort_feature__cohort_id__featurecohort; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_feature
    ADD CONSTRAINT fk__featurecohort_feature__cohort_id__featurecohort FOREIGN KEY (cohort_id) REFERENCES public.featurecohort(id);


--
-- Name: featurecohort_feature fk__featurecohort_feature__feature_id__feature; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_feature
    ADD CONSTRAINT fk__featurecohort_feature__feature_id__feature FOREIGN KEY (feature_id) REFERENCES public.feature(id) ON DELETE CASCADE;


--
-- Name: featurecohort_user fk__featurecohort_user__cohort_id__featurecohort; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_user
    ADD CONSTRAINT fk__featurecohort_user__cohort_id__featurecohort FOREIGN KEY (cohort_id) REFERENCES public.featurecohort(id);


--
-- Name: featurecohort_user fk__featurecohort_user__user_id__user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.featurecohort_user
    ADD CONSTRAINT fk__featurecohort_user__user_id__user FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: flag fk__flag__annotation_id__annotation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flag
    ADD CONSTRAINT fk__flag__annotation_id__annotation FOREIGN KEY (annotation_id) REFERENCES public.annotation(id) ON DELETE CASCADE;


--
-- Name: flag fk__flag__user_id__user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flag
    ADD CONSTRAINT fk__flag__user_id__user FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: group fk__group__creator_id__user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT fk__group__creator_id__user FOREIGN KEY (creator_id) REFERENCES public."user"(id);


--
-- Name: group fk__group__organization_id__organization; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT fk__group__organization_id__organization FOREIGN KEY (organization_id) REFERENCES public.organization(id);


--
-- Name: groupscope fk__groupscope__group_id__group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupscope
    ADD CONSTRAINT fk__groupscope__group_id__group FOREIGN KEY (group_id) REFERENCES public."group"(id) ON DELETE CASCADE;


--
-- Name: token fk__token__authclient_id__authclient; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT fk__token__authclient_id__authclient FOREIGN KEY (authclient_id) REFERENCES public.authclient(id) ON DELETE CASCADE;


--
-- Name: user fk__user__activation_id__activation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT fk__user__activation_id__activation FOREIGN KEY (activation_id) REFERENCES public.activation(id);


--
-- Name: user_group fk__user_group__group_id__group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group
    ADD CONSTRAINT fk__user_group__group_id__group FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: user_group fk__user_group__user_id__user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group
    ADD CONSTRAINT fk__user_group__user_id__user FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: user_identity fk__user_identity__user_id__user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_identity
    ADD CONSTRAINT fk__user_identity__user_id__user FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

