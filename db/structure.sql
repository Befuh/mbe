--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE addresses (
    id integer NOT NULL,
    street text,
    house_number text,
    city text,
    zip_code text,
    state text,
    country text,
    phone text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- Name: admins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admins (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: clinical_observations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE clinical_observations (
    id integer NOT NULL,
    consultation_id integer,
    exam text,
    result text,
    interpretation text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clinical_observations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clinical_observations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clinical_observations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clinical_observations_id_seq OWNED BY clinical_observations.id;


--
-- Name: consultations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE consultations (
    id integer NOT NULL,
    "timestamp" timestamp without time zone,
    patient_id integer,
    doctor_id integer,
    health_facility_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: consultations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE consultations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: consultations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE consultations_id_seq OWNED BY consultations.id;


--
-- Name: doctors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE doctors (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: doctors_health_facilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE doctors_health_facilities (
    id integer NOT NULL,
    doctor_id integer,
    health_facility_id integer,
    deleted_at timestamp without time zone
);


--
-- Name: doctors_health_facilities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE doctors_health_facilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: doctors_health_facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE doctors_health_facilities_id_seq OWNED BY doctors_health_facilities.id;


--
-- Name: doctors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE doctors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: doctors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE doctors_id_seq OWNED BY doctors.id;


--
-- Name: health_facilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE health_facilities (
    id integer NOT NULL,
    name text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: health_facilities_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE health_facilities_addresses (
    id integer NOT NULL,
    health_facility_id integer,
    address_id integer
);


--
-- Name: health_facilities_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE health_facilities_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: health_facilities_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE health_facilities_addresses_id_seq OWNED BY health_facilities_addresses.id;


--
-- Name: health_facilities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE health_facilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: health_facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE health_facilities_id_seq OWNED BY health_facilities.id;


--
-- Name: lab_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lab_results (
    id integer NOT NULL,
    consultation_id integer,
    category text,
    value text,
    unit text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: lab_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lab_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lab_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lab_results_id_seq OWNED BY lab_results.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE patients (
    id integer NOT NULL,
    identifier text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: patients_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE patients_addresses (
    id integer NOT NULL,
    patient_id integer,
    address_id integer
);


--
-- Name: patients_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE patients_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patients_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE patients_addresses_id_seq OWNED BY patients_addresses.id;


--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE patients_id_seq OWNED BY patients.id;


--
-- Name: patients_pre_existing_conditions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE patients_pre_existing_conditions (
    id integer NOT NULL,
    patient_id integer,
    pre_existing_condition_id integer,
    treated boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: patients_pre_existing_conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE patients_pre_existing_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patients_pre_existing_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE patients_pre_existing_conditions_id_seq OWNED BY patients_pre_existing_conditions.id;


--
-- Name: pre_existing_conditions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pre_existing_conditions (
    id integer NOT NULL,
    name text
);


--
-- Name: pre_existing_conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pre_existing_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pre_existing_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pre_existing_conditions_id_seq OWNED BY pre_existing_conditions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    filename text NOT NULL
);


--
-- Name: treatments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE treatments (
    id integer NOT NULL,
    consultation_id integer,
    type text,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: treatments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE treatments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: treatments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE treatments_id_seq OWNED BY treatments.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    auth_id text NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    sex text,
    date_of_birth date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: clinical_observations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clinical_observations ALTER COLUMN id SET DEFAULT nextval('clinical_observations_id_seq'::regclass);


--
-- Name: consultations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY consultations ALTER COLUMN id SET DEFAULT nextval('consultations_id_seq'::regclass);


--
-- Name: doctors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY doctors ALTER COLUMN id SET DEFAULT nextval('doctors_id_seq'::regclass);


--
-- Name: doctors_health_facilities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY doctors_health_facilities ALTER COLUMN id SET DEFAULT nextval('doctors_health_facilities_id_seq'::regclass);


--
-- Name: health_facilities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY health_facilities ALTER COLUMN id SET DEFAULT nextval('health_facilities_id_seq'::regclass);


--
-- Name: health_facilities_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY health_facilities_addresses ALTER COLUMN id SET DEFAULT nextval('health_facilities_addresses_id_seq'::regclass);


--
-- Name: lab_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lab_results ALTER COLUMN id SET DEFAULT nextval('lab_results_id_seq'::regclass);


--
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);


--
-- Name: patients_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients_addresses ALTER COLUMN id SET DEFAULT nextval('patients_addresses_id_seq'::regclass);


--
-- Name: patients_pre_existing_conditions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients_pre_existing_conditions ALTER COLUMN id SET DEFAULT nextval('patients_pre_existing_conditions_id_seq'::regclass);


--
-- Name: pre_existing_conditions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pre_existing_conditions ALTER COLUMN id SET DEFAULT nextval('pre_existing_conditions_id_seq'::regclass);


--
-- Name: treatments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY treatments ALTER COLUMN id SET DEFAULT nextval('treatments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: admins admins_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_user_id_key UNIQUE (user_id);


--
-- Name: clinical_observations clinical_observations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clinical_observations
    ADD CONSTRAINT clinical_observations_pkey PRIMARY KEY (id);


--
-- Name: consultations consultations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY consultations
    ADD CONSTRAINT consultations_pkey PRIMARY KEY (id);


--
-- Name: doctors_health_facilities doctors_health_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY doctors_health_facilities
    ADD CONSTRAINT doctors_health_facilities_pkey PRIMARY KEY (id);


--
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (id);


--
-- Name: doctors doctors_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY doctors
    ADD CONSTRAINT doctors_user_id_key UNIQUE (user_id);


--
-- Name: health_facilities_addresses health_facilities_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY health_facilities_addresses
    ADD CONSTRAINT health_facilities_addresses_pkey PRIMARY KEY (id);


--
-- Name: health_facilities health_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY health_facilities
    ADD CONSTRAINT health_facilities_pkey PRIMARY KEY (id);


--
-- Name: lab_results lab_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lab_results
    ADD CONSTRAINT lab_results_pkey PRIMARY KEY (id);


--
-- Name: patients_addresses patients_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients_addresses
    ADD CONSTRAINT patients_addresses_pkey PRIMARY KEY (id);


--
-- Name: patients patients_identifier_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_identifier_key UNIQUE (identifier);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: patients_pre_existing_conditions patients_pre_existing_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients_pre_existing_conditions
    ADD CONSTRAINT patients_pre_existing_conditions_pkey PRIMARY KEY (id);


--
-- Name: patients patients_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_user_id_key UNIQUE (user_id);


--
-- Name: pre_existing_conditions pre_existing_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pre_existing_conditions
    ADD CONSTRAINT pre_existing_conditions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: treatments treatments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY treatments
    ADD CONSTRAINT treatments_pkey PRIMARY KEY (id);


--
-- Name: users users_auth_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_auth_id_key UNIQUE (auth_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: doctors_health_facilities doctors_health_facilities_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY doctors_health_facilities
    ADD CONSTRAINT doctors_health_facilities_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES doctors(id);


--
-- Name: doctors_health_facilities doctors_health_facilities_health_facility_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY doctors_health_facilities
    ADD CONSTRAINT doctors_health_facilities_health_facility_id_fkey FOREIGN KEY (health_facility_id) REFERENCES health_facilities(id);


--
-- Name: health_facilities_addresses health_facilities_addresses_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY health_facilities_addresses
    ADD CONSTRAINT health_facilities_addresses_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: health_facilities_addresses health_facilities_addresses_health_facility_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY health_facilities_addresses
    ADD CONSTRAINT health_facilities_addresses_health_facility_id_fkey FOREIGN KEY (health_facility_id) REFERENCES health_facilities(id);


--
-- Name: patients_addresses patients_addresses_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients_addresses
    ADD CONSTRAINT patients_addresses_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: patients_addresses patients_addresses_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients_addresses
    ADD CONSTRAINT patients_addresses_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- Name: patients_pre_existing_conditions patients_pre_existing_conditions_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients_pre_existing_conditions
    ADD CONSTRAINT patients_pre_existing_conditions_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- Name: patients_pre_existing_conditions patients_pre_existing_conditions_pre_existing_condition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients_pre_existing_conditions
    ADD CONSTRAINT patients_pre_existing_conditions_pre_existing_condition_id_fkey FOREIGN KEY (pre_existing_condition_id) REFERENCES pre_existing_conditions(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;
INSERT INTO "schema_migrations" ("filename") VALUES ('20180206133509_create_users.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180206153200_create_patients.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180206164548_create_doctors.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180206164602_create_admins.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180206203712_create_health_facilities.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180206204009_create_doctors_health_facilities.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180301211920_create_addresses.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180306143942_create_patients_addresses.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180306150440_create_health_facilities_addresses.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180829204022_create_pre_existing_condition.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180829204333_create_patients_pre_existing_condition.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180829205636_create_consultations.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180829205932_create_clinical_observations.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180829210230_create_lab_results.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180829210356_create_treatments.rb');