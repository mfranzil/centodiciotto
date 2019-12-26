--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-1.pgdg16.04+1)
-- Dumped by pg_dump version 11.6 (Ubuntu 11.6-1.pgdg18.04+1)

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
-- Name: plv8; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plv8 WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plv8; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plv8 IS 'PL/JavaScript (v8) trusted procedural language';


--
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- Name: dict_int; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dict_int WITH SCHEMA public;


--
-- Name: EXTENSION dict_int; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_int IS 'text search dictionary template for integers';


--
-- Name: dict_xsyn; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dict_xsyn WITH SCHEMA public;


--
-- Name: EXTENSION dict_xsyn; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_xsyn IS 'text search dictionary template for extended synonym processing';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgrowlocks; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgrowlocks WITH SCHEMA public;


--
-- Name: EXTENSION pgrowlocks; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrowlocks IS 'show row-level locking information';


--
-- Name: pgstattuple; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgstattuple WITH SCHEMA public;


--
-- Name: EXTENSION pgstattuple; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgstattuple IS 'show tuple-level statistics';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: xml2; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS xml2 WITH SCHEMA public;


--
-- Name: EXTENSION xml2; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION xml2 IS 'XPath querying and XSLT';


--
-- Name: delrech(); Type: FUNCTION; Schema: public; Owner: eryfjzyp
--

CREATE FUNCTION public.delrech() RETURNS void
    LANGUAGE sql
    AS $$
DELETE FROM rechnung AS r WHERE r.rnr NOT IN (SELECT b.rnr FROM bestellung AS b WHERE rnr IS NOT NULL)
$$;


ALTER FUNCTION public.delrech() OWNER TO eryfjzyp;

--
-- Name: preiserhoehung(); Type: FUNCTION; Schema: public; Owner: eryfjzyp
--

CREATE FUNCTION public.preiserhoehung() RETURNS void
    LANGUAGE sql
    AS $$
UPDATE speise SET preis = FLOOR(preis)+ 0.99;
$$;


ALTER FUNCTION public.preiserhoehung() OWNER TO eryfjzyp;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: chemist; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.chemist (
    chemist_id character varying(254) NOT NULL,
    name character varying(255) NOT NULL,
    chemist_province character varying(5) NOT NULL,
    working_place text NOT NULL
);


ALTER TABLE public.chemist OWNER TO guhncjua;

--
-- Name: comune; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.comune (
    comune_id integer NOT NULL,
    name text,
    province text,
    belfiore text
);


ALTER TABLE public.comune OWNER TO guhncjua;

--
-- Name: doctor_exams; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.doctor_exams (
    doctor_id character varying(254) NOT NULL,
    exam_id integer NOT NULL
);


ALTER TABLE public.doctor_exams OWNER TO guhncjua;

--
-- Name: drug_type; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.drug_type (
    drug_id integer NOT NULL,
    drug_description text
);


ALTER TABLE public.drug_type OWNER TO guhncjua;

--
-- Name: drug_list_drug_id_seq; Type: SEQUENCE; Schema: public; Owner: guhncjua
--

CREATE SEQUENCE public.drug_list_drug_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drug_list_drug_id_seq OWNER TO guhncjua;

--
-- Name: drug_list_drug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guhncjua
--

ALTER SEQUENCE public.drug_list_drug_id_seq OWNED BY public.drug_type.drug_id;


--
-- Name: drug_prescription; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.drug_prescription (
    drug_prescription_id integer NOT NULL,
    practitioner_id character varying(254) NOT NULL,
    patient_id character varying(254) NOT NULL,
    drug_type integer NOT NULL,
    date_prescribed timestamp without time zone NOT NULL,
    date_sold timestamp without time zone,
    chemist_id character varying(254),
    ticket integer NOT NULL,
    ticket_paid boolean DEFAULT false NOT NULL,
    description text,
    CONSTRAINT drug_prescription_check CHECK ((NOT ((ticket_paid IS TRUE) AND (chemist_id IS NULL) AND (date_sold IS NULL))))
);


ALTER TABLE public.drug_prescription OWNER TO guhncjua;

--
-- Name: drug_prescription_drug_prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: guhncjua
--

CREATE SEQUENCE public.drug_prescription_drug_prescription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drug_prescription_drug_prescription_id_seq OWNER TO guhncjua;

--
-- Name: drug_prescription_drug_prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guhncjua
--

ALTER SEQUENCE public.drug_prescription_drug_prescription_id_seq OWNED BY public.drug_prescription.drug_prescription_id;


--
-- Name: exam; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.exam (
    exam_id integer NOT NULL,
    patient_id character varying(254) NOT NULL,
    doctor_id character varying(254),
    exam_type integer NOT NULL,
    done boolean DEFAULT false NOT NULL,
    date timestamp without time zone,
    result text,
    health_service_id character varying(254),
    ticket integer NOT NULL,
    ticket_paid boolean DEFAULT false NOT NULL,
    practitioner_id character varying(254),
    booked boolean DEFAULT false NOT NULL,
    recall integer,
    CONSTRAINT exam_check CHECK (((NOT booked) OR (date IS NOT NULL))),
    CONSTRAINT exam_check1 CHECK ((NOT ((NOT booked) AND ticket_paid))),
    CONSTRAINT exam_check2 CHECK (((NOT done) OR booked)),
    CONSTRAINT exam_check3 CHECK (((NOT (result IS NOT NULL)) OR done)),
    CONSTRAINT exam_check4 CHECK (((NOT (recall IS NOT NULL)) OR (doctor_id IS NOT NULL) OR ((NOT (recall IS NOT NULL)) OR (NOT booked)) OR ((NOT (recall IS NOT NULL)) OR (health_service_id IS NOT NULL)))),
    CONSTRAINT performed_not_both_chk CHECK (((booked IS FALSE) OR (NOT ((doctor_id IS NOT NULL) AND (health_service_id IS NOT NULL))))),
    CONSTRAINT performed_not_null_chk CHECK (((booked IS FALSE) OR ((doctor_id IS NOT NULL) OR (health_service_id IS NOT NULL)))),
    CONSTRAINT ticket_paid CHECK ((NOT ((ticket_paid IS TRUE) AND (done IS FALSE))))
);


ALTER TABLE public.exam OWNER TO guhncjua;

--
-- Name: exam_type; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.exam_type (
    exam_id integer NOT NULL,
    exam_description text
);


ALTER TABLE public.exam_type OWNER TO guhncjua;

--
-- Name: exams_exam_id_seq; Type: SEQUENCE; Schema: public; Owner: guhncjua
--

CREATE SEQUENCE public.exams_exam_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exams_exam_id_seq OWNER TO guhncjua;

--
-- Name: exams_exam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guhncjua
--

ALTER SEQUENCE public.exams_exam_id_seq OWNED BY public.exam.exam_id;


--
-- Name: exams_list_exam_id_seq; Type: SEQUENCE; Schema: public; Owner: guhncjua
--

CREATE SEQUENCE public.exams_list_exam_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exams_list_exam_id_seq OWNER TO guhncjua;

--
-- Name: exams_list_exam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guhncjua
--

ALTER SEQUENCE public.exams_list_exam_id_seq OWNED BY public.exam_type.exam_id;


--
-- Name: general_practitioner; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.general_practitioner (
    practitioner_id character varying(254) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    working_province character varying(5) NOT NULL,
    working_place text NOT NULL
);


ALTER TABLE public.general_practitioner OWNER TO guhncjua;

--
-- Name: health_service; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.health_service (
    health_service_id character varying(254) NOT NULL,
    operating_province character varying(5) NOT NULL
);


ALTER TABLE public.health_service OWNER TO guhncjua;

--
-- Name: password_reset; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.password_reset (
    user_id character varying(254) NOT NULL,
    token character varying(64) NOT NULL,
    expiring_date timestamp without time zone
);


ALTER TABLE public.password_reset OWNER TO guhncjua;

--
-- Name: patient; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.patient (
    patient_id character varying(254) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    birth_date timestamp without time zone NOT NULL,
    birth_place character varying(255) NOT NULL,
    ssn character varying(16) NOT NULL,
    gender character(1) NOT NULL,
    practitioner_id character varying(254) NOT NULL,
    living_province character varying(5) NOT NULL,
    living_place text NOT NULL
);


ALTER TABLE public.patient OWNER TO guhncjua;

--
-- Name: photo; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.photo (
    photo_id integer NOT NULL,
    patient_id character varying(254),
    upload_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.photo OWNER TO guhncjua;

--
-- Name: photo_new_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: guhncjua
--

CREATE SEQUENCE public.photo_new_photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_new_photo_id_seq OWNER TO guhncjua;

--
-- Name: photo_new_photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guhncjua
--

ALTER SEQUENCE public.photo_new_photo_id_seq OWNED BY public.photo.photo_id;


--
-- Name: province; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.province (
    province_id integer NOT NULL,
    province_name character varying(128) NOT NULL,
    province_abbreviation character varying(5) NOT NULL,
    province_region character varying(128) DEFAULT NULL::character varying
);


ALTER TABLE public.province OWNER TO guhncjua;

--
-- Name: recall; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.recall (
    recall_id integer NOT NULL,
    exam_type integer NOT NULL,
    min_age integer NOT NULL,
    max_age integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    health_service_id character varying(254) NOT NULL,
    CONSTRAINT recall_check CHECK ((min_age < max_age))
);


ALTER TABLE public.recall OWNER TO guhncjua;

--
-- Name: recall_recall_id_seq; Type: SEQUENCE; Schema: public; Owner: guhncjua
--

CREATE SEQUENCE public.recall_recall_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recall_recall_id_seq OWNER TO guhncjua;

--
-- Name: recall_recall_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guhncjua
--

ALTER SEQUENCE public.recall_recall_id_seq OWNED BY public.recall.recall_id;


--
-- Name: specialized_doctor; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.specialized_doctor (
    doctor_id character varying(254) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    working_place text
);


ALTER TABLE public.specialized_doctor OWNER TO guhncjua;

--
-- Name: temp_id_seq; Type: SEQUENCE; Schema: public; Owner: guhncjua
--

CREATE SEQUENCE public.temp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temp_id_seq OWNER TO guhncjua;

--
-- Name: temp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guhncjua
--

ALTER SEQUENCE public.temp_id_seq OWNED BY public.comune.comune_id;


--
-- Name: user_; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.user_ (
    user_id character varying(254) NOT NULL,
    hash character varying(256) NOT NULL,
    salt character varying(16) NOT NULL
);


ALTER TABLE public.user_ OWNER TO guhncjua;

--
-- Name: visit; Type: TABLE; Schema: public; Owner: guhncjua
--

CREATE TABLE public.visit (
    visit_id integer NOT NULL,
    practitioner_id character varying(254) NOT NULL,
    patient_id character varying(254) NOT NULL,
    visit_date timestamp without time zone,
    report_available boolean DEFAULT false NOT NULL,
    report text,
    booked boolean DEFAULT false NOT NULL,
    CONSTRAINT date_booked CHECK ((NOT ((visit_date IS NULL) AND report_available)))
);


ALTER TABLE public.visit OWNER TO guhncjua;

--
-- Name: visit_visit_id_seq; Type: SEQUENCE; Schema: public; Owner: guhncjua
--

CREATE SEQUENCE public.visit_visit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visit_visit_id_seq OWNER TO guhncjua;

--
-- Name: visit_visit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guhncjua
--

ALTER SEQUENCE public.visit_visit_id_seq OWNED BY public.visit.visit_id;


--
-- Name: comune comune_id; Type: DEFAULT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.comune ALTER COLUMN comune_id SET DEFAULT nextval('public.temp_id_seq'::regclass);


--
-- Name: drug_prescription drug_prescription_id; Type: DEFAULT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.drug_prescription ALTER COLUMN drug_prescription_id SET DEFAULT nextval('public.drug_prescription_drug_prescription_id_seq'::regclass);


--
-- Name: drug_type drug_id; Type: DEFAULT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.drug_type ALTER COLUMN drug_id SET DEFAULT nextval('public.drug_list_drug_id_seq'::regclass);


--
-- Name: exam exam_id; Type: DEFAULT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam ALTER COLUMN exam_id SET DEFAULT nextval('public.exams_exam_id_seq'::regclass);


--
-- Name: exam_type exam_id; Type: DEFAULT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam_type ALTER COLUMN exam_id SET DEFAULT nextval('public.exams_list_exam_id_seq'::regclass);


--
-- Name: photo photo_id; Type: DEFAULT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.photo ALTER COLUMN photo_id SET DEFAULT nextval('public.photo_new_photo_id_seq'::regclass);


--
-- Name: recall recall_id; Type: DEFAULT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.recall ALTER COLUMN recall_id SET DEFAULT nextval('public.recall_recall_id_seq'::regclass);


--
-- Name: visit visit_id; Type: DEFAULT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.visit ALTER COLUMN visit_id SET DEFAULT nextval('public.visit_visit_id_seq'::regclass);


--
-- Data for Name: chemist; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.chemist (chemist_id, name, chemist_province, working_place) FROM stdin;
natalia.antelami@virgilio.it	Farmacia Antelami	TA	Montemesola
filippa.salandra@yahoo.it	Farmacia Salandra	TA	Crispiano
fredo.bellini@hotmail.com	Farmacia Bellini	TA	San Marzano di San Giuseppe
alessandro.argurio@virgilio.it	Farmacia Argurio	TA	Laterza
toni.emanuelli@gmail.com	Farmacia Emanuelli	TA	Monteiasi
giovanni.porzio@virgilio.it	Farmacia Porzio	TA	Ginosa
laura.baglioni@hotmail.com	Farmacia Baglioni	TA	Martina Franca
sergius.gregori@gmail.com	Farmacia Gregori	TA	Monteparano
amedeo.druso@yahoo.it	Farmacia Druso	TA	Montemesola
beatrice.nordio@libero.it	Farmacia Nordio	TA	Martina Franca
arturo.vespucci@gmail.com	Farmacia Vespucci	TA	Faggiano
donatella.giradello@hotmail.com	Farmacia Giradello	TA	Carosino
vito.argenti@virgilio.it	Farmacia Argenti	TA	Crispiano
giustino.argurio@gmail.com	Farmacia Argurio	TA	Massafra
fredo.bonino@virgilio.it	Farmacia Bonino	TA	Lizzano
simonetta.castioni@virgilio.it	Farmacia Castioni	MT	San Mauro Forte
mariano.golgi@hotmail.com	Farmacia Golgi	MT	Grottole
sabatino.romagnoli@yahoo.it	Farmacia Romagnoli	MT	Policoro
toni.bettin@gmail.com	Farmacia Bettin	MT	Scanzano Jonico
sandro.pausini@gmail.com	Farmacia Pausini	MT	Irsina
vittoria.morgagni@virgilio.it	Farmacia Morgagni	MT	Matera
margherita.zampa@gmail.com	Farmacia Zampa	MT	Grassano
roman.rienzo@yahoo.it	Farmacia Rienzo	MT	Grassano
filippo.battisti@hotmail.com	Farmacia Battisti	MT	Grottole
natalia.trillini@virgilio.it	Farmacia Trillini	MT	Grassano
fausto.ricciardi@hotmail.com	Farmacia Ricciardi	MT	Scanzano Jonico
gionata.fantoni@yahoo.it	Farmacia Fantoni	MT	Cirigliano
ninetta.camanni@virgilio.it	Farmacia Camanni	MT	Scanzano Jonico
galasso.delle@libero.it	Farmacia Delle	MT	San Giorgio Lucano
rolando.raurica@libero.it	Farmacia Raurica	MT	Miglionico
gaetano.capone@yahoo.it	Farmacia Capone	TV	San Polo di Piave
eliana.rossellini@libero.it	Farmacia Rossellini	TV	San Biagio di Callalta
ilaria.pigafetta@libero.it	Farmacia Pigafetta	TV	Monfumo
giorgia.zoppetti@virgilio.it	Farmacia Zoppetti	TV	Vidor
fiorino.pirandello@yahoo.it	Farmacia Pirandello	TV	Loria
eleanora.pepe@libero.it	Farmacia Pepe	TV	Crocetta del Montello
fiorenzo.fabbri@hotmail.com	Farmacia Fabbri	TV	Oderzo
flavio.foletti@libero.it	Farmacia Foletti	TV	Salgareda
daniele.gremese@libero.it	Farmacia Gremese	TV	Chiarano
paoletta.cossiga@virgilio.it	Farmacia Cossiga	TV	Tarzo
giovanni.randazzo@libero.it	Farmacia Randazzo	TV	Roncade
goffredo.scarpetta@virgilio.it	Farmacia Scarpetta	TV	Fregona
giuseppe.savorgnan@hotmail.com	Farmacia Savorgnan	TV	Pederobba
lucrezia.calvo@gmail.com	Farmacia Calvo	TV	Miane
virginia.spallanzani@libero.it	Farmacia Spallanzani	TV	Fontanelle
lucia.satta@libero.it	Farmacia Satta	NU	Posada
diana.guinizzelli@yahoo.it	Farmacia Guinizzelli	NU	Tortolì
michelangelo.persico@virgilio.it	Farmacia Persico	NU	Ollolai
laura.jacuzzi@virgilio.it	Farmacia Jacuzzi	NU	Borore
salvi.stradivari@libero.it	Farmacia Stradivari	NU	Osidda
tiziano.bosurgi@yahoo.it	Farmacia Bosurgi	NU	Cardedu
ippazio.gabbana@libero.it	Farmacia Gabbana	NU	Villagrande Strisaili
agostino.cappelli@hotmail.com	Farmacia Cappelli	NU	Galtellì
antonello.ubaldi@hotmail.com	Farmacia Ubaldi	NU	Talana
maria.virgilio@hotmail.com	Farmacia Virgilio	NU	Onanì
morena.avogadro@yahoo.it	Farmacia Avogadro	NU	Noragugume
giulio.bettin@virgilio.it	Farmacia Bettin	NU	Siniscola
liberto.borzomì@yahoo.it	Farmacia Borzomì	NU	Onanì
marcella.fieramosca@gmail.com	Farmacia Fieramosca	NU	Ussassai
romana.celentano@yahoo.it	Farmacia Celentano	NU	Bolotana
fedele.morellato@libero.it	Farmacia Morellato	MT	Bernalda
matilda.monaco@gmail.com	Farmacia Monaco	MT	Stigliano
vittorio.dossetti@gmail.com	Farmacia Dossetti	MT	Oliveto Lucano
vanessa.panatta@gmail.com	Farmacia Panatta	MT	Tursi
laura.saraceno@gmail.com	Farmacia Saraceno	MT	Matera
romeo.zola@gmail.com	Farmacia Zola	MT	Calciano
armando.giacometti@virgilio.it	Farmacia Giacometti	MT	Salandra
annamaria.pedersoli@yahoo.it	Farmacia Pedersoli	MT	Garaguso
agnolo.soranzo@virgilio.it	Farmacia Soranzo	MT	Grottole
pina.gianinazzi@libero.it	Farmacia Gianinazzi	MT	Pisticci
laura.vecoli@hotmail.com	Farmacia Vecoli	MT	Montescaglioso
luigina.metella@yahoo.it	Farmacia Metella	MT	Valsinni
domenico.chinnici@hotmail.com	Farmacia Chinnici	MT	Nova Siri
fiorenzo.corcos@virgilio.it	Farmacia Corcos	MT	Scanzano Jonico
anita.lollobrigida@hotmail.com	Farmacia Lollobrigida	MT	Pomarico
galasso.grasso@hotmail.com	Farmacia Grasso	TV	Monastier di Treviso
carla.accardo@yahoo.it	Farmacia Accardo	TV	Maser
guglielmo.mannoia@libero.it	Farmacia Mannoia	TV	Resana
lauretta.platini@hotmail.com	Farmacia Platini	TV	Mogliano Veneto
rosina.cannizzaro@gmail.com	Farmacia Cannizzaro	TV	Altivole
amanda.giorgetti@yahoo.it	Farmacia Giorgetti	TV	Vidor
priscilla.mortati@gmail.com	Farmacia Mortati	TV	Altivole
giustino.mogherini@virgilio.it	Farmacia Mogherini	TV	Montebelluna
pierpaolo.valentino@virgilio.it	Farmacia Valentino	TV	Sernaglia della Battaglia
federica.zola@virgilio.it	Farmacia Zola	TV	Trevignano
fiamma.caracciolo@libero.it	Farmacia Caracciolo	TV	Casier
letizia.marzorati@libero.it	Farmacia Marzorati	TV	Treviso
nedda.sommaruga@libero.it	Farmacia Sommaruga	TV	Sarmede
jolanda.canil@hotmail.com	Farmacia Canil	TV	Spresiano
stefano.carriera@virgilio.it	Farmacia Carriera	TV	Resana
liliana.boldù@yahoo.it	Farmacia Boldù	MT	San Giorgio Lucano
calcedonio.norbiato@virgilio.it	Farmacia Norbiato	MT	Aliano
gilberto.prodi@libero.it	Farmacia Prodi	MT	Bernalda
francesca.oliboni@virgilio.it	Farmacia Oliboni	MT	Tursi
arturo.mezzetta@hotmail.com	Farmacia Mezzetta	MT	Grassano
lucrezia.garzoni@virgilio.it	Farmacia Garzoni	MT	Nova Siri
guglielmo.palladio@libero.it	Farmacia Palladio	MT	Tricarico
alberico.iannuzzi@gmail.com	Farmacia Iannuzzi	MT	Rotondella
domenico.ricciardi@yahoo.it	Farmacia Ricciardi	MT	Aliano
rossana.valguarnera@libero.it	Farmacia Valguarnera	MT	Oliveto Lucano
renata.pausini@yahoo.it	Farmacia Pausini	MT	Miglionico
serafina.ruffini@yahoo.it	Farmacia Ruffini	MT	Grottole
marcello.castiglione@gmail.com	Farmacia Castiglione	MT	San Mauro Forte
ricciotti.munari@hotmail.com	Farmacia Munari	MT	San Giorgio Lucano
giampaolo.salvemini@libero.it	Farmacia Salvemini	MT	Montalbano Jonico
\.


--
-- Data for Name: comune; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.comune (comune_id, name, province, belfiore) FROM stdin;
7967	Cantoira	TO	B637
7968	Caprie	TO	B705
7969	Caravino	TO	B733
7970	Carema	TO	B762
7971	Carignano	TO	B777
7972	Carmagnola	TO	B791
7973	Casalborgone	TO	B867
7974	Cascinette d'Ivrea	TO	B953
7975	Caselette	TO	B955
7976	Caselle Torinese	TO	B960
7977	Castagneto Po	TO	C045
7978	Castagnole Piemonte	TO	C048
7979	Castellamonte	TO	C133
7980	Castelnuovo Nigra	TO	C241
7981	Castiglione Torinese	TO	C307
7982	Cavagnolo	TO	C369
7983	Cavour	TO	C404
7984	Cercenasco	TO	C487
7985	Ceres	TO	C497
7986	Ceresole Reale	TO	C505
7987	Cesana Torinese	TO	C564
7988	Chialamberto	TO	C604
7989	Chianocco	TO	C610
7990	Chiaverano	TO	C624
7991	Chieri	TO	C627
7992	Chiesanuova	TO	C629
7993	Chiomonte	TO	C639
7994	Chiusa di San Michele	TO	C655
7995	Chivasso	TO	C665
7996	Ciconio	TO	C679
7997	Cintano	TO	C711
7998	Cinzano	TO	C715
7999	Ciriè	TO	C722
8000	Claviere	TO	C793
8001	Coassolo Torinese	TO	C801
8002	Coazze	TO	C803
8003	Collegno	TO	C860
8004	Colleretto Castelnuovo	TO	C867
8005	Colleretto Giacosa	TO	C868
8006	Condove	TO	C955
8007	Corio	TO	D008
8008	Cossano Canavese	TO	D092
8009	Cuceglio	TO	D197
8010	Cumiana	TO	D202
8011	Cuorgnè	TO	D208
8012	Druento	TO	D373
8013	Exilles	TO	D433
8014	Favria	TO	D520
8015	Feletto	TO	D524
8016	Fenestrelle	TO	D532
8017	Fiano	TO	D562
8018	Fiorano Canavese	TO	D608
8019	Foglizzo	TO	D646
8020	Forno Canavese	TO	D725
8021	Frassinetto	TO	D781
8022	Front	TO	D805
8023	Frossasco	TO	D812
8024	Garzigliana	TO	D931
8025	Gassino Torinese	TO	D933
8026	Germagnano	TO	D983
8027	Giaglione	TO	E009
8028	Giaveno	TO	E020
8029	Givoletto	TO	E067
8030	Gravere	TO	E154
8031	Groscavallo	TO	E199
8032	Grosso	TO	E203
8033	Grugliasco	TO	E216
8034	Ingria	TO	E301
8035	Inverso Pinasca	TO	E311
8036	Isolabella	TO	E345
8037	Issiglio	TO	E368
8038	Ivrea	TO	E379
8039	La Cassa	TO	E394
8040	La Loggia	TO	E423
8041	Lanzo Torinese	TO	E445
8042	Lauriano	TO	E484
8043	Leini	TO	E518
8044	Lemie	TO	E520
8045	Lessolo	TO	E551
8046	Levone	TO	E566
8047	Locana	TO	E635
8048	Lombardore	TO	E660
8049	Lombriasco	TO	E661
8050	Loranzè	TO	E683
8051	Luserna San Giovanni	TO	E758
8052	Lusernetta	TO	E759
8053	Lusigliè	TO	E763
8054	Macello	TO	E782
8055	Maglione	TO	E817
8056	Marentino	TO	E941
8057	Massello	TO	F041
8058	Mathi	TO	F053
8059	Mattie	TO	F058
8060	Mazzè	TO	F067
8061	Meana di Susa	TO	F074
8062	Mercenasco	TO	F140
8063	Mezzenile	TO	F182
8064	Mombello di Torino	TO	F315
8065	Mompantero	TO	F318
8066	Monastero di Lanzo	TO	F327
8067	Moncalieri	TO	F335
8068	Moncenisio	TO	D553
8069	Montaldo Torinese	TO	F407
8070	Montalenghe	TO	F411
8071	Montalto Dora	TO	F420
8072	Montanaro	TO	F422
8073	Monteu da Po	TO	F651
8074	Moriondo Torinese	TO	F733
8075	Nichelino	TO	F889
8076	Noasca	TO	F906
8077	Nole	TO	F925
8078	Nomaglio	TO	F927
8079	None	TO	F931
8080	Novalesa	TO	F948
8081	Oglianico	TO	G010
8082	Orbassano	TO	G087
8083	Orio Canavese	TO	G109
8084	Osasco	TO	G151
8085	Osasio	TO	G152
8086	Oulx	TO	G196
8087	Ozegna	TO	G202
8088	Palazzo Canavese	TO	G262
8089	Pancalieri	TO	G303
8090	Parella	TO	G330
8091	Pavarolo	TO	G387
8092	Pavone Canavese	TO	G392
8093	Pecetto Torinese	TO	G398
8094	Perosa Argentina	TO	G463
8095	Perosa Canavese	TO	G462
8096	Perrero	TO	G465
8097	Pertusio	TO	G477
8098	Pessinetto	TO	G505
8099	Pianezza	TO	G559
8100	Pinasca	TO	G672
8101	Pinerolo	TO	G674
8102	Pino Torinese	TO	G678
8103	Piobesi Torinese	TO	G684
8104	Piossasco	TO	G691
8105	Piscina	TO	G705
8106	Piverone	TO	G719
8107	Poirino	TO	G777
8108	Pomaretto	TO	G805
8109	Pont-Canavese	TO	G826
8110	Porte	TO	G900
8111	Pragelato	TO	G973
8112	Prali	TO	G978
8113	Pralormo	TO	G979
8114	Pramollo	TO	G982
8115	Prarostino	TO	G986
8116	Prascorsano	TO	G988
8117	Pratiglione	TO	G997
8118	Quagliuzzo	TO	H100
8119	Quassolo	TO	H120
8120	Quincinetto	TO	H127
8121	Reano	TO	H207
8122	Ribordone	TO	H270
8123	Rivalba	TO	H333
8124	Rivalta di Torino	TO	H335
8125	Riva presso Chieri	TO	H337
8126	Rivara	TO	H338
8127	Rivarolo Canavese	TO	H340
8128	Rivarossa	TO	H344
8129	Rivoli	TO	H355
8130	Robassomero	TO	H367
8131	Rocca Canavese	TO	H386
8132	Roletto	TO	H498
8133	Romano Canavese	TO	H511
8134	Ronco Canavese	TO	H539
8135	Rondissone	TO	H547
8136	Rorà	TO	H554
8137	Roure	TO	H555
8138	Rosta	TO	H583
8139	Rubiana	TO	H627
8140	Rueglio	TO	H631
8141	Salassa	TO	H691
8142	Salbertrand	TO	H684
8143	Salerano Canavese	TO	H702
8144	Salza di Pinerolo	TO	H734
8145	Samone	TO	H753
8146	San Benigno Canavese	TO	H775
8147	San Carlo Canavese	TO	H789
8148	San Colombano Belmonte	TO	H804
8149	San Didero	TO	H820
8150	San Francesco al Campo	TO	H847
8151	Sangano	TO	H855
8152	San Germano Chisone	TO	H862
8153	San Gillio	TO	H873
8154	San Giorgio Canavese	TO	H890
8155	San Giorio di Susa	TO	H900
8156	San Giusto Canavese	TO	H936
8157	San Martino Canavese	TO	H997
8158	San Maurizio Canavese	TO	I024
8159	San Mauro Torinese	TO	I030
8160	San Pietro Val Lemina	TO	I090
8161	San Ponso	TO	I126
8162	San Raffaele Cimena	TO	I137
8163	San Sebastiano da Po	TO	I152
8164	San Secondo di Pinerolo	TO	I154
8165	Sant'Ambrogio di Torino	TO	I258
8166	Sant'Antonino di Susa	TO	I296
8167	Santena	TO	I327
8168	Sauze di Cesana	TO	I465
8169	Sauze d'Oulx	TO	I466
8170	Scalenghe	TO	I490
8171	Scarmagno	TO	I511
8172	Sciolze	TO	I539
8173	Sestriere	TO	I692
8174	Settimo Rottaro	TO	I701
8175	Settimo Torinese	TO	I703
8176	Settimo Vittone	TO	I702
8177	Sparone	TO	I886
8178	Strambinello	TO	I969
8179	Strambino	TO	I970
8180	Susa	TO	L013
8181	Tavagnasco	TO	L066
8182	Torino	TO	L219
8183	Torrazza Piemonte	TO	L238
8184	Torre Canavese	TO	L247
8185	Torre Pellice	TO	L277
8186	Trana	TO	L327
8187	Traversella	TO	L345
8188	Traves	TO	L340
8189	Trofarello	TO	L445
8190	Usseaux	TO	L515
8191	Usseglio	TO	L516
8192	Vaie	TO	L538
8193	Val della Torre	TO	L555
8194	Valgioie	TO	L578
8195	Vallo Torinese	TO	L629
8196	Valperga	TO	L644
8197	Valprato Soana	TO	B510
8198	Varisella	TO	L685
8199	Vauda Canavese	TO	L698
8200	Venaus	TO	L726
8201	Venaria Reale	TO	L727
8202	Verolengo	TO	L779
8203	Verrua Savoia	TO	L787
8204	Vestignè	TO	L811
8205	Vialfrè	TO	L830
8206	Vidracco	TO	L857
8207	Vigone	TO	L898
8208	Villafranca Piemonte	TO	L948
8209	Villanova Canavese	TO	L982
8210	Villarbasse	TO	M002
8211	Villar Dora	TO	L999
8212	Villareggia	TO	M004
8213	Villar Focchiardo	TO	M007
8214	Villar Pellice	TO	M013
8215	Villar Perosa	TO	M014
8216	Villastellone	TO	M027
8217	Vinovo	TO	M060
8218	Virle Piemonte	TO	M069
8219	Vische	TO	M071
8220	Vistrorio	TO	M080
8221	Viù	TO	M094
8222	Volpiano	TO	M122
8223	Volvera	TO	M133
8224	Mappano	TO	M316
8225	Val di Chy	TO	M405
8226	Valchiusa	TO	M415
8227	Alagna Valsesia	VC	A119
8228	Albano Vercellese	VC	A130
8229	Alice Castello	VC	A198
8230	Arborio	VC	A358
8231	Asigliano Vercellese	VC	A466
8232	Balmuccia	VC	A600
8233	Balocco	VC	A601
8234	Bianzè	VC	A847
8235	Boccioleto	VC	A914
8236	Borgo d'Ale	VC	B009
8237	Borgosesia	VC	B041
8238	Borgo Vercelli	VC	B046
8239	Buronzo	VC	B280
8240	Campertogno	VC	B505
8241	Carcoforo	VC	B752
8242	Caresana	VC	B767
8243	Caresanablot	VC	B768
8244	Carisio	VC	B782
8245	Casanova Elvo	VC	B928
8246	San Giacomo Vercellese	VC	B952
8247	Cervatto	VC	C548
8248	Cigliano	VC	C680
8249	Civiasco	VC	C757
8250	Collobiano	VC	C884
8251	Costanzana	VC	D113
8252	Cravagliana	VC	D132
8253	Crescentino	VC	D154
8254	Crova	VC	D187
8255	Desana	VC	D281
8256	Fobello	VC	D641
8257	Fontanetto Po	VC	D676
8258	Formigliana	VC	D712
8259	Gattinara	VC	D938
8260	Ghislarengo	VC	E007
8261	Greggio	VC	E163
8262	Guardabosone	VC	E237
8263	Lamporo	VC	E433
8264	Lenta	VC	E528
8265	Lignana	VC	E583
8266	Livorno Ferraris	VC	E626
8267	Lozzolo	VC	E711
8268	Mollia	VC	F297
8269	Moncrivello	VC	F342
8270	Motta de' Conti	VC	F774
8271	Olcenengo	VC	G016
8272	Oldenico	VC	G018
8273	Palazzolo Vercellese	VC	G266
8274	Pertengo	VC	G471
8275	Pezzana	VC	G528
8276	Pila	VC	G666
8277	Piode	VC	G685
8278	Postua	VC	G940
8279	Prarolo	VC	G985
8280	Quarona	VC	H108
8281	Quinto Vercellese	VC	H132
8282	Rassa	VC	H188
8283	Rimella	VC	H293
8284	Rive	VC	H346
8285	Roasio	VC	H365
8286	Ronsecco	VC	H549
8287	Rossa	VC	H577
8288	Rovasenda	VC	H364
8289	Salasco	VC	H690
8290	Sali Vercellese	VC	H707
8291	Saluggia	VC	H725
8292	San Germano Vercellese	VC	H861
8293	Santhià	VC	I337
8294	Scopa	VC	I544
8295	Scopello	VC	I545
8296	Serravalle Sesia	VC	I663
8297	Stroppiana	VC	I984
8298	Tricerro	VC	L420
8299	Trino	VC	L429
8300	Tronzano Vercellese	VC	L451
8301	Valduggia	VC	L566
8302	Varallo	VC	L669
8303	Vercelli	VC	L750
8304	Villarboit	VC	M003
8305	Villata	VC	M028
8306	Vocca	VC	M106
8307	Alto Sermenza	VC	M389
8308	Cellio con Breia	VC	M398
8309	Agrate Conturbia	NO	A088
8310	Ameno	NO	A264
8311	Armeno	NO	A414
8312	Arona	NO	A429
8313	Barengo	NO	A653
8314	Bellinzago Novarese	NO	A752
8315	Biandrate	NO	A844
8316	Boca	NO	A911
8317	Bogogno	NO	A929
8318	Bolzano Novarese	NO	A953
8319	Borgolavezzaro	NO	B016
8320	Borgomanero	NO	B019
8321	Borgo Ticino	NO	B043
8322	Briga Novarese	NO	B176
8323	Briona	NO	B183
8324	Caltignaga	NO	B431
8325	Cameri	NO	B473
8326	Carpignano Sesia	NO	B823
8327	Casalbeltrame	NO	B864
8328	Casaleggio Novara	NO	B883
8329	Casalino	NO	B897
8330	Casalvolone	NO	B920
8331	Castellazzo Novarese	NO	C149
8332	Castelletto sopra Ticino	NO	C166
8333	Cavaglietto	NO	C364
8334	Cavaglio d'Agogna	NO	C365
8335	Cavallirio	NO	C378
8336	Cerano	NO	C483
8337	Colazza	NO	C829
8338	Comignago	NO	C926
8339	Cressa	NO	D162
8340	Cureggio	NO	D216
8341	Divignano	NO	D309
8342	Dormelletto	NO	D347
8343	Fara Novarese	NO	D492
8344	Fontaneto d'Agogna	NO	D675
8345	Galliate	NO	D872
8346	Garbagna Novarese	NO	D911
8347	Gargallo	NO	D921
8348	Ghemme	NO	E001
8349	Gozzano	NO	E120
8350	Granozzo con Monticello	NO	E143
8351	Grignasco	NO	E177
8352	Invorio	NO	E314
8353	Landiona	NO	E436
8354	Lesa	NO	E544
8355	Maggiora	NO	E803
8356	Mandello Vitta	NO	E880
8357	Marano Ticino	NO	E907
8358	Massino Visconti	NO	F047
8359	Meina	NO	F093
8360	Mezzomerico	NO	F188
8361	Miasino	NO	F191
8362	Momo	NO	F317
8363	Nebbiuno	NO	F859
8364	Nibbiola	NO	F886
8365	Novara	NO	F952
8366	Oleggio	NO	G019
8367	Oleggio Castello	NO	G020
8368	Orta San Giulio	NO	G134
8369	Paruzzaro	NO	G349
8370	Pella	NO	G421
8371	Pettenasco	NO	G520
8372	Pisano	NO	G703
8373	Pogno	NO	G775
8374	Pombia	NO	G809
8375	Prato Sesia	NO	H001
8376	Recetto	NO	H213
8377	Romagnano Sesia	NO	H502
8378	Romentino	NO	H518
8379	San Maurizio d'Opaglio	NO	I025
8380	San Nazzaro Sesia	NO	I052
8381	San Pietro Mosezzo	NO	I116
8382	Sillavengo	NO	I736
8383	Sizzano	NO	I767
8384	Soriso	NO	I857
8385	Sozzago	NO	I880
8386	Suno	NO	L007
8387	Terdobbiate	NO	L104
8388	Tornaco	NO	L223
8389	Trecate	NO	L356
8390	Vaprio d'Agogna	NO	L668
8391	Varallo Pombia	NO	L670
8392	Vespolate	NO	L808
8393	Vicolungo	NO	L847
8394	Vinzaglio	NO	M062
8395	Gattico-Veruno	NO	M416
8396	Acceglio	CN	A016
8397	Aisone	CN	A113
8398	Alba	CN	A124
8399	Albaretto della Torre	CN	A139
8400	Alto	CN	A238
8401	Argentera	CN	A394
8402	Arguello	CN	A396
8403	Bagnasco	CN	A555
8404	Bagnolo Piemonte	CN	A571
8405	Baldissero d'Alba	CN	A589
8406	Barbaresco	CN	A629
8407	Barge	CN	A660
8408	Barolo	CN	A671
8409	Bastia Mondovì	CN	A709
8410	Battifollo	CN	A716
8411	Beinette	CN	A735
8412	Bellino	CN	A750
8413	Belvedere Langhe	CN	A774
8414	Bene Vagienna	CN	A779
8415	Benevello	CN	A782
8416	Bergolo	CN	A798
8417	Bernezzo	CN	A805
8418	Bonvicino	CN	A979
8419	Borgomale	CN	B018
8420	Borgo San Dalmazzo	CN	B033
8421	Bosia	CN	B079
8422	Bossolasco	CN	B084
8423	Boves	CN	B101
8424	Bra	CN	B111
8425	Briaglia	CN	B167
8426	Briga Alta	CN	B175
8427	Brondello	CN	B200
8428	Brossasco	CN	B204
8429	Busca	CN	B285
8430	Camerana	CN	B467
8431	Canale	CN	B573
8432	Canosio	CN	B621
8433	Caprauna	CN	B692
8434	Caraglio	CN	B719
8435	Caramagna Piemonte	CN	B720
8436	Cardè	CN	B755
8437	Carrù	CN	B841
8438	Cartignano	CN	B845
8439	Casalgrasso	CN	B894
8440	Castagnito	CN	C046
8441	Casteldelfino	CN	C081
8442	Castelletto Stura	CN	C165
8443	Castelletto Uzzone	CN	C167
8444	Castellinaldo d'Alba	CN	C173
8445	Castellino Tanaro	CN	C176
8446	Castelmagno	CN	C205
8447	Castelnuovo di Ceva	CN	C214
8448	Castiglione Falletto	CN	C314
8449	Castiglione Tinella	CN	C317
8450	Castino	CN	C323
8451	Cavallerleone	CN	C375
8452	Cavallermaggiore	CN	C376
8453	Celle di Macra	CN	C441
8454	Centallo	CN	C466
8455	Ceresole Alba	CN	C504
8456	Cerretto Langhe	CN	C530
8457	Cervasca	CN	C547
8458	Cervere	CN	C550
8459	Ceva	CN	C589
8460	Cherasco	CN	C599
8461	Chiusa di Pesio	CN	C653
8462	Cigliè	CN	C681
8463	Cissone	CN	C738
8464	Clavesana	CN	C792
8465	Corneliano d'Alba	CN	D022
8466	Cortemilia	CN	D062
8467	Cossano Belbo	CN	D093
8468	Costigliole Saluzzo	CN	D120
8469	Cravanzana	CN	D133
8470	Crissolo	CN	D172
8471	Cuneo	CN	D205
8472	Demonte	CN	D271
8473	Diano d'Alba	CN	D291
8474	Dogliani	CN	D314
8475	Dronero	CN	D372
8476	Elva	CN	D401
8477	Entracque	CN	D410
8478	Envie	CN	D412
8479	Farigliano	CN	D499
8480	Faule	CN	D511
8481	Feisoglio	CN	D523
8482	Fossano	CN	D742
8483	Frabosa Soprana	CN	D751
8484	Frabosa Sottana	CN	D752
8485	Frassino	CN	D782
8486	Gaiola	CN	D856
8487	Gambasca	CN	D894
8488	Garessio	CN	D920
8489	Genola	CN	D967
8490	Gorzegno	CN	E111
8491	Gottasecca	CN	E115
8492	Govone	CN	E118
8493	Grinzane Cavour	CN	E182
8494	Guarene	CN	E251
8495	Igliano	CN	E282
8496	Isasca	CN	E327
8497	Lagnasco	CN	E406
8498	La Morra	CN	E430
8499	Lequio Berria	CN	E540
8500	Lequio Tanaro	CN	E539
8501	Lesegno	CN	E546
8502	Levice	CN	E564
8503	Limone Piemonte	CN	E597
8504	Lisio	CN	E615
8505	Macra	CN	E789
8506	Magliano Alfieri	CN	E809
8507	Magliano Alpi	CN	E808
8508	Mango	CN	E887
8509	Manta	CN	E894
8510	Marene	CN	E939
8511	Margarita	CN	E945
8512	Marmora	CN	E963
8513	Marsaglia	CN	E973
8514	Martiniana Po	CN	E988
8515	Melle	CN	F114
8516	Moiola	CN	F279
8517	Mombarcaro	CN	F309
8518	Mombasiglio	CN	F312
8519	Monastero di Vasco	CN	F326
8520	Monasterolo Casotto	CN	F329
8521	Monasterolo di Savigliano	CN	F330
8522	Monchiero	CN	F338
8523	Mondovì	CN	F351
8524	Monesiglio	CN	F355
8525	Monforte d'Alba	CN	F358
8526	Montà	CN	F385
8527	Montaldo di Mondovì	CN	F405
8528	Montaldo Roero	CN	F408
8529	Montanera	CN	F424
8530	Montelupo Albese	CN	F550
8531	Montemale di Cuneo	CN	F558
8532	Monterosso Grana	CN	F608
8533	Monteu Roero	CN	F654
8534	Montezemolo	CN	F666
8535	Monticello d'Alba	CN	F669
8536	Moretta	CN	F723
8537	Morozzo	CN	F743
8538	Murazzano	CN	F809
8539	Murello	CN	F811
8540	Narzole	CN	F846
8541	Neive	CN	F863
8542	Neviglie	CN	F883
8543	Niella Belbo	CN	F894
8544	Niella Tanaro	CN	F895
8545	Novello	CN	F961
8546	Nucetto	CN	F972
8547	Oncino	CN	G066
8548	Ormea	CN	G114
8549	Ostana	CN	G183
8550	Paesana	CN	G228
8551	Pagno	CN	G240
8552	Pamparato	CN	G302
8553	Paroldo	CN	G339
8554	Perletto	CN	G457
8555	Perlo	CN	G458
8556	Peveragno	CN	G526
8557	Pezzolo Valle Uzzone	CN	G532
8558	Pianfei	CN	G561
8559	Piasco	CN	G575
8560	Pietraporzio	CN	G625
8561	Piobesi d'Alba	CN	G683
8562	Piozzo	CN	G697
8563	Pocapaglia	CN	G742
8564	Polonghera	CN	G800
8565	Pontechianale	CN	G837
8566	Pradleves	CN	G970
8567	Prazzo	CN	H011
8568	Priero	CN	H059
8569	Priocca	CN	H068
8570	Priola	CN	H069
8571	Prunetto	CN	H085
8572	Racconigi	CN	H150
8573	Revello	CN	H247
8574	Rifreddo	CN	H285
8575	Rittana	CN	H326
8576	Roaschia	CN	H362
8577	Roascio	CN	H363
8578	Robilante	CN	H377
8579	Roburent	CN	H378
8580	Roccabruna	CN	H385
8581	Rocca Cigliè	CN	H391
8582	Rocca de' Baldi	CN	H395
8583	Roccaforte Mondovì	CN	H407
8584	Roccasparvera	CN	H447
8585	Roccavione	CN	H453
8586	Rocchetta Belbo	CN	H462
8587	Roddi	CN	H472
8588	Roddino	CN	H473
8589	Rodello	CN	H474
8590	Rossana	CN	H578
8591	Ruffia	CN	H633
8592	Sale delle Langhe	CN	H695
8593	Sale San Giovanni	CN	H704
8594	Saliceto	CN	H710
8595	Salmour	CN	H716
8596	Saluzzo	CN	H727
8597	Sambuco	CN	H746
8598	Sampeyre	CN	H755
8599	San Benedetto Belbo	CN	H770
8600	San Damiano Macra	CN	H812
8601	Sanfrè	CN	H851
8602	Sanfront	CN	H852
8603	San Michele Mondovì	CN	I037
8604	Sant'Albano Stura	CN	I210
8605	Santa Vittoria d'Alba	CN	I316
8606	Santo Stefano Belbo	CN	I367
8607	Santo Stefano Roero	CN	I372
8608	Savigliano	CN	I470
8609	Scagnello	CN	I484
8610	Scarnafigi	CN	I512
8611	Serralunga d'Alba	CN	I646
8612	Serravalle Langhe	CN	I659
8613	Sinio	CN	I750
8614	Somano	CN	I817
8615	Sommariva del Bosco	CN	I822
8616	Sommariva Perno	CN	I823
8617	Stroppo	CN	I985
8618	Tarantasca	CN	L048
8619	Torre Bormida	CN	L252
8620	Torre Mondovì	CN	L241
8621	Torre San Giorgio	CN	L278
8622	Torresina	CN	L281
8623	Treiso	CN	L367
8624	Trezzo Tinella	CN	L410
8625	Trinità	CN	L427
8626	Valdieri	CN	L558
8627	Valgrana	CN	L580
8628	Valloriate	CN	L631
8629	Venasca	CN	L729
8630	Verduno	CN	L758
8631	Vernante	CN	L771
8632	Verzuolo	CN	L804
8633	Vezza d'Alba	CN	L817
8634	Vicoforte	CN	L841
8635	Vignolo	CN	L888
8636	Villafalletto	CN	L942
8637	Villanova Mondovì	CN	L974
8638	Villanova Solaro	CN	L990
8639	Villar San Costanzo	CN	M015
8640	Vinadio	CN	M055
8641	Viola	CN	M063
8642	Vottignasco	CN	M136
8643	Agliano Terme	AT	A072
8644	Albugnano	AT	A173
8645	Antignano	AT	A312
8646	Aramengo	AT	A352
8647	Asti	AT	A479
8648	Azzano d'Asti	AT	A527
8649	Baldichieri d'Asti	AT	A588
8650	Belveglio	AT	A770
8651	Berzano di San Pietro	AT	A812
8652	Bruno	AT	B221
8653	Bubbio	AT	B236
8654	Buttigliera d'Asti	AT	B306
8655	Calamandrana	AT	B376
8656	Calliano	AT	B418
8657	Calosso	AT	B425
8658	Camerano Casasco	AT	B469
8659	Canelli	AT	B594
8660	Cantarana	AT	B633
8661	Capriglio	AT	B707
8662	Casorzo	AT	B991
8663	Cassinasco	AT	C022
8664	Castagnole delle Lanze	AT	C049
8665	Castagnole Monferrato	AT	C047
8666	Castel Boglione	AT	C064
8667	Castell'Alfero	AT	C127
8668	Castellero	AT	C154
8669	Castelletto Molina	AT	C161
8670	Castello di Annone	AT	A300
8671	Castelnuovo Belbo	AT	C226
8672	Castelnuovo Calcea	AT	C230
8673	Castelnuovo Don Bosco	AT	C232
8674	Castel Rocchero	AT	C253
8675	Cellarengo	AT	C438
8676	Celle Enomondo	AT	C440
8677	Cerreto d'Asti	AT	C528
8678	Cerro Tanaro	AT	C533
8679	Cessole	AT	C583
8680	Chiusano d'Asti	AT	C658
8681	Cinaglio	AT	C701
8682	Cisterna d'Asti	AT	C739
8683	Coazzolo	AT	C804
8684	Cocconato	AT	C807
8685	Corsione	AT	D046
8686	Cortandone	AT	D050
8687	Cortanze	AT	D051
8688	Cortazzone	AT	D052
8689	Cortiglione	AT	D072
8690	Cossombrato	AT	D101
8691	Costigliole d'Asti	AT	D119
8692	Cunico	AT	D207
8693	Dusino San Michele	AT	D388
8694	Ferrere	AT	D554
8695	Fontanile	AT	D678
8696	Frinco	AT	D802
8697	Grana	AT	E134
8698	Grazzano Badoglio	AT	E159
8699	Incisa Scapaccino	AT	E295
8700	Isola d'Asti	AT	E338
8701	Loazzolo	AT	E633
8702	Maranzana	AT	E917
8703	Maretto	AT	E944
8704	Moasca	AT	F254
8705	Mombaldone	AT	F308
8706	Mombaruzzo	AT	F311
8707	Mombercelli	AT	F316
8708	Monale	AT	F323
8709	Monastero Bormida	AT	F325
8710	Moncalvo	AT	F336
8711	Moncucco Torinese	AT	F343
8712	Mongardino	AT	F361
8713	Montabone	AT	F386
8714	Montafia	AT	F390
8715	Montaldo Scarampi	AT	F409
8716	Montechiaro d'Asti	AT	F468
8717	Montegrosso d'Asti	AT	F527
8718	Montemagno	AT	F556
8719	Moransengo	AT	F709
8720	Nizza Monferrato	AT	F902
8721	Olmo Gentile	AT	G048
8722	Passerano Marmorito	AT	G358
8723	Penango	AT	G430
8724	Piea	AT	G593
8725	Pino d'Asti	AT	G676
8726	Piovà Massaia	AT	G692
8727	Portacomaro	AT	G894
8728	Quaranti	AT	H102
8729	Refrancore	AT	H219
8730	Revigliasco d'Asti	AT	H250
8731	Roatto	AT	H366
8732	Robella	AT	H376
8733	Rocca d'Arazzo	AT	H392
8734	Roccaverano	AT	H451
8735	Rocchetta Palafea	AT	H466
8736	Rocchetta Tanaro	AT	H468
8737	San Damiano d'Asti	AT	H811
8738	San Giorgio Scarampi	AT	H899
8739	San Martino Alfieri	AT	H987
8740	San Marzano Oliveto	AT	I017
8741	San Paolo Solbrito	AT	I076
8742	Scurzolengo	AT	I555
8743	Serole	AT	I637
8744	Sessame	AT	I678
8745	Settime	AT	I698
8746	Soglio	AT	I781
8747	Tigliole	AT	L168
8748	Tonco	AT	L203
8749	Tonengo	AT	L204
8750	Vaglio Serra	AT	L531
8751	Valfenera	AT	L574
8752	Vesime	AT	L807
8753	Viale	AT	L829
8754	Viarigi	AT	L834
8755	Vigliano d'Asti	AT	L879
8756	Villafranca d'Asti	AT	L945
8757	Villanova d'Asti	AT	L984
8758	Villa San Secondo	AT	M019
8759	Vinchio	AT	M058
8760	Montiglio Monferrato	AT	M302
8761	Acqui Terme	AL	A052
8762	Albera Ligure	AL	A146
8763	Alessandria	AL	A182
8764	Alfiano Natta	AL	A189
8765	Alice Bel Colle	AL	A197
8766	Altavilla Monferrato	AL	A227
8767	Alzano Scrivia	AL	A245
8768	Arquata Scrivia	AL	A436
8769	Avolasca	AL	A523
8770	Balzola	AL	A605
8771	Basaluzzo	AL	A689
8772	Bassignana	AL	A708
8773	Belforte Monferrato	AL	A738
8774	Bergamasco	AL	A793
8775	Berzano di Tortona	AL	A813
8776	Bistagno	AL	A889
8777	Borghetto di Borbera	AL	A998
8778	Borgoratto Alessandrino	AL	B029
8779	Borgo San Martino	AL	B037
8780	Bosco Marengo	AL	B071
8781	Bosio	AL	B080
8782	Bozzole	AL	B109
8783	Brignano-Frascata	AL	B179
8784	Cabella Ligure	AL	B311
8785	Camagna Monferrato	AL	B453
8786	Camino	AL	B482
8787	Cantalupo Ligure	AL	B629
8788	Capriata d'Orba	AL	B701
8789	Carbonara Scrivia	AL	B736
8790	Carentino	AL	B765
8791	Carezzano	AL	B769
8792	Carpeneto	AL	B818
8793	Carrega Ligure	AL	B836
8794	Carrosio	AL	B840
8795	Cartosio	AL	B847
8796	Casal Cermelli	AL	B870
8797	Casaleggio Boiro	AL	B882
8798	Casale Monferrato	AL	B885
8799	Casalnoceto	AL	B902
8800	Casasco	AL	B941
8801	Cassine	AL	C027
8802	Cassinelle	AL	C030
8803	Castellania	AL	C137
8804	Castellar Guidobono	AL	C142
8805	Castellazzo Bormida	AL	C148
8806	Castelletto d'Erro	AL	C156
8807	Castelletto d'Orba	AL	C158
8808	Castelletto Merli	AL	C160
8809	Castelletto Monferrato	AL	C162
8810	Castelnuovo Bormida	AL	C229
8811	Castelnuovo Scrivia	AL	C243
8812	Castelspina	AL	C274
8813	Cavatore	AL	C387
8814	Cella Monte	AL	C432
8815	Cereseto	AL	C503
8816	Cerreto Grue	AL	C507
8817	Cerrina Monferrato	AL	C531
8818	Coniolo	AL	C962
8819	Conzano	AL	C977
8820	Costa Vescovato	AL	D102
8821	Cremolino	AL	D149
8822	Denice	AL	D272
8823	Dernice	AL	D277
8824	Fabbrica Curone	AL	D447
8825	Felizzano	AL	D528
8826	Fraconalto	AL	D559
8827	Francavilla Bisio	AL	D759
8828	Frascaro	AL	D770
8829	Frassinello Monferrato	AL	D777
8830	Frassineto Po	AL	D780
8831	Fresonara	AL	D797
8832	Frugarolo	AL	D813
8833	Fubine Monferrato	AL	D814
8834	Gabiano	AL	D835
8835	Gamalero	AL	D890
8836	Garbagna	AL	D910
8837	Gavi	AL	D944
8838	Giarole	AL	E015
8839	Gremiasco	AL	E164
8840	Grognardo	AL	E188
8841	Grondona	AL	E191
8842	Guazzora	AL	E255
8843	Isola Sant'Antonio	AL	E360
8844	Lerma	AL	E543
8845	Malvicino	AL	E870
8846	Masio	AL	F015
8847	Melazzo	AL	F096
8848	Merana	AL	F131
8849	Mirabello Monferrato	AL	F232
8850	Molare	AL	F281
8851	Molino dei Torti	AL	F293
8852	Mombello Monferrato	AL	F313
8853	Momperone	AL	F320
8854	Moncestino	AL	F337
8855	Mongiardino Ligure	AL	F365
8856	Monleale	AL	F374
8857	Montacuto	AL	F387
8858	Montaldeo	AL	F403
8859	Montaldo Bormida	AL	F404
8860	Montecastello	AL	F455
8861	Montechiaro d'Acqui	AL	F469
8862	Montegioco	AL	F518
8863	Montemarzino	AL	F562
8864	Morano sul Po	AL	F707
8865	Morbello	AL	F713
8866	Mornese	AL	F737
8867	Morsasco	AL	F751
8868	Murisengo	AL	F814
8869	Novi Ligure	AL	F965
8870	Occimiano	AL	F995
8871	Odalengo Grande	AL	F997
8872	Odalengo Piccolo	AL	F998
8873	Olivola	AL	G042
8874	Orsara Bormida	AL	G124
8875	Ottiglio	AL	G193
8876	Ovada	AL	G197
8877	Oviglio	AL	G199
8878	Ozzano Monferrato	AL	G204
8879	Paderna	AL	G215
8880	Pareto	AL	G334
8881	Parodi Ligure	AL	G338
8882	Pasturana	AL	G367
8883	Pecetto di Valenza	AL	G397
8884	Pietra Marazzi	AL	G619
8885	Pomaro Monferrato	AL	G807
8886	Pontecurone	AL	G839
8887	Pontestura	AL	G858
8888	Ponti	AL	G861
8889	Ponzano Monferrato	AL	G872
8890	Ponzone	AL	G877
8891	Pozzol Groppo	AL	G960
8892	Pozzolo Formigaro	AL	G961
8893	Prasco	AL	G987
8894	Predosa	AL	H021
8895	Quargnento	AL	H104
8896	Quattordio	AL	H121
8897	Ricaldone	AL	H272
8898	Rivalta Bormida	AL	H334
8899	Rivarone	AL	H343
8900	Roccaforte Ligure	AL	H406
8901	Rocca Grimalda	AL	H414
8902	Rocchetta Ligure	AL	H465
8903	Rosignano Monferrato	AL	H569
8904	Sala Monferrato	AL	H677
8905	Sale	AL	H694
8906	San Cristoforo	AL	H810
8907	San Giorgio Monferrato	AL	H878
8908	San Salvatore Monferrato	AL	I144
8909	San Sebastiano Curone	AL	I150
8910	Sant'Agata Fossili	AL	I190
8911	Sardigliano	AL	I429
8912	Sarezzano	AL	I432
8913	Serralunga di Crea	AL	I645
8914	Serravalle Scrivia	AL	I657
8915	Sezzadio	AL	I711
8916	Silvano d'Orba	AL	I738
8917	Solero	AL	I798
8918	Solonghello	AL	I808
8919	Spigno Monferrato	AL	I901
8920	Spineto Scrivia	AL	I911
8921	Stazzano	AL	I941
8922	Strevi	AL	I977
8923	Tagliolo Monferrato	AL	L027
8924	Tassarolo	AL	L059
8925	Terruggia	AL	L139
8926	Terzo	AL	L143
8927	Ticineto	AL	L165
8928	Tortona	AL	L304
8929	Treville	AL	L403
8930	Trisobbio	AL	L432
8931	Valenza	AL	L570
8932	Valmacca	AL	L633
8933	Vignale Monferrato	AL	L881
8934	Vignole Borbera	AL	L887
8935	Viguzzolo	AL	L904
8936	Villadeati	AL	L931
8937	Villalvernia	AL	L963
8938	Villamiroglio	AL	L970
8939	Villanova Monferrato	AL	L972
8940	Villaromagnano	AL	M009
8941	Visone	AL	M077
8942	Volpedo	AL	M120
8943	Volpeglino	AL	M121
8944	Voltaggio	AL	M123
8945	Cassano Spinola	AL	M388
8946	Alluvioni Piovera	AL	M397
8947	Lu e Cuccaro Monferrato	AL	M420
8948	Ailoche	BI	A107
8949	Andorno Micca	BI	A280
8950	Benna	BI	A784
8951	Biella	BI	A859
8952	Bioglio	BI	A876
8953	Borriana	BI	B058
8954	Brusnengo	BI	B229
8955	Callabiana	BI	B417
8956	Camandona	BI	B457
8957	Camburzano	BI	B465
8958	Candelo	BI	B586
8959	Caprile	BI	B708
8960	Casapinta	BI	B933
8961	Castelletto Cervo	BI	C155
8962	Cavaglià	BI	C363
8963	Cerrione	BI	C532
8964	Coggiola	BI	C819
8965	Cossato	BI	D094
8966	Crevacuore	BI	D165
8967	Curino	BI	D219
8968	Donato	BI	D339
8969	Dorzano	BI	D350
8970	Gaglianico	BI	D848
8971	Gifflenga	BI	E024
8972	Graglia	BI	E130
8973	Magnano	BI	E821
8974	Massazza	BI	F037
8975	Masserano	BI	F042
8976	Mezzana Mortigliengo	BI	F167
8977	Miagliano	BI	F189
8978	Mongrando	BI	F369
8979	Mottalciata	BI	F776
8980	Muzzano	BI	F833
8981	Netro	BI	F878
8982	Occhieppo Inferiore	BI	F992
8983	Occhieppo Superiore	BI	F993
8984	Pettinengo	BI	G521
8985	Piatto	BI	G577
8986	Piedicavallo	BI	G594
8987	Pollone	BI	G798
8988	Ponderano	BI	G820
8989	Portula	BI	G927
8990	Pralungo	BI	G980
8991	Pray	BI	G974
8992	Ronco Biellese	BI	H538
8993	Roppolo	BI	H553
8994	Rosazza	BI	H561
8995	Sagliano Micca	BI	H662
8996	Sala Biellese	BI	H681
8997	Salussola	BI	H726
8998	Sandigliano	BI	H821
8999	Sordevolo	BI	I847
9000	Sostegno	BI	I868
9001	Strona	BI	I980
9002	Tavigliano	BI	L075
9003	Ternengo	BI	L116
9004	Tollegno	BI	L193
9005	Torrazzo	BI	L239
9006	Valdengo	BI	L556
9007	Vallanzengo	BI	L586
9008	Valle San Nicolao	BI	L620
9009	Veglio	BI	L712
9010	Verrone	BI	L785
9011	Vigliano Biellese	BI	L880
9012	Villa del Bosco	BI	L933
9013	Villanova Biellese	BI	L978
9014	Viverone	BI	M098
9015	Zimone	BI	M179
9016	Zubiena	BI	M196
9017	Zumaglia	BI	M201
9018	Lessona	BI	M371
9019	Campiglia Cervo	BI	M373
9020	Quaregna Cerreto	BI	M414
9021	Valdilana	BI	M417
9022	Antrona Schieranco	VB	A317
9023	Anzola d'Ossola	VB	A325
9024	Arizzano	VB	A409
9025	Arola	VB	A427
9026	Aurano	VB	A497
9027	Baceno	VB	A534
9028	Bannio Anzino	VB	A610
9029	Baveno	VB	A725
9030	Bee	VB	A733
9031	Belgirate	VB	A742
9032	Beura-Cardezza	VB	A834
9033	Bognanco	VB	A925
9034	Brovello-Carpugnino	VB	B207
9035	Calasca-Castiglione	VB	B380
9036	Cambiasca	VB	B463
9037	Cannero Riviera	VB	B610
9038	Cannobio	VB	B615
9039	Caprezzo	VB	B694
9040	Casale Corte Cerro	VB	B876
9041	Ceppo Morelli	VB	C478
9042	Cesara	VB	C567
9043	Cossogno	VB	D099
9044	Craveggia	VB	D134
9045	Crevoladossola	VB	D168
9046	Crodo	VB	D177
9047	Domodossola	VB	D332
9048	Druogno	VB	D374
9049	Formazza	VB	D706
9050	Germagno	VB	D984
9051	Ghiffa	VB	E003
9052	Gignese	VB	E028
9053	Gravellona Toce	VB	E153
9054	Gurro	VB	E269
9055	Intragna	VB	E304
9056	Loreglia	VB	E685
9057	Macugnaga	VB	E790
9058	Madonna del Sasso	VB	E795
9059	Malesco	VB	E853
9060	Masera	VB	F010
9061	Massiola	VB	F048
9062	Mergozzo	VB	F146
9063	Miazzina	VB	F192
9064	Montecrestese	VB	F483
9065	Montescheno	VB	F639
9066	Nonio	VB	F932
9067	Oggebbio	VB	G007
9068	Omegna	VB	G062
9069	Ornavasso	VB	G117
9070	Pallanzeno	VB	G280
9071	Piedimulera	VB	G600
9072	Pieve Vergonte	VB	G658
9073	Premeno	VB	H030
9074	Premia	VB	H033
9075	Premosello-Chiovenda	VB	H037
9076	Quarna Sopra	VB	H106
9077	Quarna Sotto	VB	H107
9078	Re	VB	H203
9079	San Bernardino Verbano	VB	H777
9080	Santa Maria Maggiore	VB	I249
9081	Stresa	VB	I976
9082	Toceno	VB	L187
9083	Trarego Viggiona	VB	L333
9084	Trasquera	VB	L336
9085	Trontano	VB	L450
9086	Valstrona	VB	L651
9087	Vanzone con San Carlo	VB	L666
9088	Varzo	VB	L691
9089	Verbania	VB	L746
9090	Vignone	VB	L889
9091	Villadossola	VB	L906
9092	Villette	VB	M042
9093	Vogogna	VB	M111
9094	Borgomezzavalle	VB	M370
9095	Valle Cannobina	VB	M404
9096	Allein	AO	A205
9097	Antey-Saint-André	AO	A305
9098	Aosta	AO	A326
9099	Arnad	AO	A424
9100	Arvier	AO	A452
9101	Avise	AO	A521
9102	Ayas	AO	A094
9103	Aymavilles	AO	A108
9104	Bard	AO	A643
9105	Bionaz	AO	A877
9106	Brissogne	AO	B192
9107	Brusson	AO	B230
9108	Challand-Saint-Anselme	AO	C593
9109	Challand-Saint-Victor	AO	C594
9110	Chambave	AO	C595
9111	Chamois	AO	B491
9112	Champdepraz	AO	C596
9113	Champorcher	AO	B540
9114	Charvensod	AO	C598
9115	Châtillon	AO	C294
9116	Cogne	AO	C821
9117	Courmayeur	AO	D012
9118	Donnas	AO	D338
9119	Doues	AO	D356
9120	Emarèse	AO	D402
9121	Etroubles	AO	D444
9122	Fénis	AO	D537
9123	Fontainemore	AO	D666
9124	Gaby	AO	D839
9125	Gignod	AO	E029
9126	Gressan	AO	E165
9127	Gressoney-La-Trinité	AO	E167
9128	Gressoney-Saint-Jean	AO	E168
9129	Hône	AO	E273
9130	Introd	AO	E306
9131	Issime	AO	E369
9132	Issogne	AO	E371
9133	Jovençan	AO	E391
9134	La Magdeleine	AO	A308
9135	La Salle	AO	E458
9136	La Thuile	AO	E470
9137	Lillianes	AO	E587
9138	Montjovet	AO	F367
9139	Morgex	AO	F726
9140	Nus	AO	F987
9141	Ollomont	AO	G045
9142	Oyace	AO	G012
9143	Perloz	AO	G459
9144	Pollein	AO	G794
9145	Pontboset	AO	G545
9146	Pontey	AO	G860
9147	Pont-Saint-Martin	AO	G854
9148	Pré-Saint-Didier	AO	H042
9149	Quart	AO	H110
9150	Rhêmes-Notre-Dame	AO	H262
9151	Rhêmes-Saint-Georges	AO	H263
9152	Roisan	AO	H497
9153	Saint-Christophe	AO	H669
9154	Saint-Denis	AO	H670
9155	Saint-Marcel	AO	H671
9156	Saint-Nicolas	AO	H672
9157	Saint-Oyen	AO	H673
9158	Saint-Pierre	AO	H674
9159	Saint-Rhémy-en-Bosses	AO	H675
9160	Saint-Vincent	AO	H676
9161	Sarre	AO	I442
9162	Torgnon	AO	L217
9163	Valgrisenche	AO	L582
9164	Valpelline	AO	L643
9165	Valsavarenche	AO	L647
9166	Valtournenche	AO	L654
9167	Verrayes	AO	L783
9168	Verrès	AO	C282
9169	Villeneuve	AO	L981
9170	Agra	VA	A085
9171	Albizzate	VA	A167
9172	Angera	VA	A290
9173	Arcisate	VA	A371
9174	Arsago Seprio	VA	A441
9175	Azzate	VA	A531
9176	Azzio	VA	A532
9177	Barasso	VA	A619
9178	Bardello	VA	A645
9179	Bedero Valcuvia	VA	A728
9180	Besano	VA	A819
9181	Besnate	VA	A825
9182	Besozzo	VA	A826
9183	Biandronno	VA	A845
9184	Bisuschio	VA	A891
9185	Bodio Lomnago	VA	A918
9186	Brebbia	VA	B126
9187	Bregano	VA	B131
9188	Brenta	VA	B150
9189	Brezzo di Bedero	VA	B166
9190	Brinzio	VA	B182
9191	Brissago-Valtravaglia	VA	B191
9192	Brunello	VA	B219
9193	Brusimpiano	VA	B228
9194	Buguggiate	VA	B258
9195	Busto Arsizio	VA	B300
9196	Cadegliano-Viconago	VA	B326
9197	Cairate	VA	B368
9198	Cantello	VA	B634
9199	Caravate	VA	B732
9200	Cardano al Campo	VA	B754
9201	Carnago	VA	B796
9202	Caronno Pertusella	VA	B805
9203	Caronno Varesino	VA	B807
9204	Casale Litta	VA	B875
9205	Casalzuigno	VA	B921
9206	Casciago	VA	B949
9207	Casorate Sempione	VA	B987
9208	Cassano Magnago	VA	C004
9209	Cassano Valcuvia	VA	B999
9210	Castellanza	VA	C139
9211	Castello Cabiaglio	VA	B312
9212	Castelseprio	VA	C273
9213	Castelveccana	VA	C181
9214	Castiglione Olona	VA	C300
9215	Castronno	VA	C343
9216	Cavaria con Premezzo	VA	C382
9217	Cazzago Brabbia	VA	C409
9218	Cislago	VA	C732
9219	Cittiglio	VA	C751
9220	Clivio	VA	C796
9221	Cocquio-Trevisago	VA	C810
9222	Comabbio	VA	C911
9223	Comerio	VA	C922
9224	Cremenaga	VA	D144
9225	Crosio della Valle	VA	D185
9226	Cuasso al Monte	VA	D192
9227	Cugliate-Fabiasco	VA	D199
9228	Cunardo	VA	D204
9229	Curiglia con Monteviasco	VA	D217
9230	Cuveglio	VA	D238
9231	Cuvio	VA	D239
9232	Daverio	VA	D256
9233	Dumenza	VA	D384
9234	Duno	VA	D385
9235	Fagnano Olona	VA	D467
9236	Ferno	VA	D543
9237	Ferrera di Varese	VA	D551
9238	Gallarate	VA	D869
9239	Galliate Lombardo	VA	D871
9240	Gavirate	VA	D946
9241	Gazzada Schianno	VA	D951
9242	Gemonio	VA	D963
9243	Gerenzano	VA	D981
9244	Germignaga	VA	D987
9245	Golasecca	VA	E079
9246	Gorla Maggiore	VA	E101
9247	Gorla Minore	VA	E102
9248	Gornate Olona	VA	E104
9249	Grantola	VA	E144
9250	Inarzo	VA	E292
9251	Induno Olona	VA	E299
9252	Ispra	VA	E367
9253	Jerago con Orago	VA	E386
9254	Lavena Ponte Tresa	VA	E494
9255	Laveno-Mombello	VA	E496
9256	Leggiuno	VA	E510
9257	Lonate Ceppino	VA	E665
9258	Lonate Pozzolo	VA	E666
9259	Lozza	VA	E707
9260	Luino	VA	E734
9261	Luvinate	VA	E769
9262	Malgesso	VA	E856
9263	Malnate	VA	E863
9264	Marchirolo	VA	E929
9265	Marnate	VA	E965
9266	Marzio	VA	F002
9267	Masciago Primo	VA	F007
9268	Mercallo	VA	F134
9269	Mesenzana	VA	F154
9270	Montegrino Valtravaglia	VA	F526
9271	Monvalle	VA	F703
9272	Morazzone	VA	F711
9273	Mornago	VA	F736
9274	Oggiona con Santo Stefano	VA	G008
9275	Olgiate Olona	VA	G028
9276	Origgio	VA	G103
9277	Orino	VA	G105
9278	Porto Ceresio	VA	G906
9279	Porto Valtravaglia	VA	G907
9280	Rancio Valcuvia	VA	H173
9281	Ranco	VA	H174
9282	Saltrio	VA	H723
9283	Samarate	VA	H736
9284	Saronno	VA	I441
9285	Sesto Calende	VA	I688
9286	Solbiate Arno	VA	I793
9287	Solbiate Olona	VA	I794
9288	Somma Lombardo	VA	I819
9289	Sumirago	VA	L003
9290	Taino	VA	L032
9291	Ternate	VA	L115
9292	Tradate	VA	L319
9293	Travedona-Monate	VA	L342
9294	Tronzano Lago Maggiore	VA	A705
9295	Uboldo	VA	L480
9296	Valganna	VA	L577
9297	Varano Borghi	VA	L671
9298	Varese	VA	L682
9299	Vedano Olona	VA	L703
9300	Venegono Inferiore	VA	L733
9301	Venegono Superiore	VA	L734
9302	Vergiate	VA	L765
9303	Viggiù	VA	L876
9304	Vizzola Ticino	VA	M101
9305	Sangiano	VA	H872
9306	Maccagno con Pino e Veddasca	VA	M339
9307	Cadrezzate con Osmate	VA	M425
9308	Albavilla	CO	A143
9309	Albese con Cassano	CO	A153
9310	Albiolo	CO	A164
9311	Alserio	CO	A224
9312	Alzate Brianza	CO	A249
9313	Anzano del Parco	CO	A319
9314	Appiano Gentile	CO	A333
9315	Argegno	CO	A391
9316	Arosio	CO	A430
9317	Asso	CO	A476
9318	Barni	CO	A670
9319	Bene Lario	CO	A778
9320	Beregazzo con Figliaro	CO	A791
9321	Binago	CO	A870
9322	Bizzarone	CO	A898
9323	Blessagno	CO	A904
9324	Blevio	CO	A905
9325	Bregnano	CO	B134
9326	Brenna	CO	B144
9327	Brienno	CO	B172
9328	Brunate	CO	B218
9329	Bulgarograsso	CO	B262
9330	Cabiate	CO	B313
9331	Cadorago	CO	B346
9332	Caglio	CO	B355
9333	Campione d'Italia	CO	B513
9334	Cantù	CO	B639
9335	Canzo	CO	B641
9336	Capiago Intimiano	CO	B653
9337	Carate Urio	CO	B730
9338	Carbonate	CO	B742
9339	Carimate	CO	B778
9340	Carlazzo	CO	B785
9341	Carugo	CO	B851
9342	Caslino d'Erba	CO	B974
9343	Casnate con Bernate	CO	B977
9344	Cassina Rizzardi	CO	C020
9345	Castelmarte	CO	C206
9346	Castelnuovo Bozzente	CO	C220
9347	Cavargna	CO	C381
9348	Cerano d'Intelvi	CO	C482
9349	Cermenate	CO	C516
9350	Cernobbio	CO	C520
9351	Cirimido	CO	C724
9352	Claino con Osteno	CO	C787
9353	Colonno	CO	C902
9354	Como	CO	C933
9355	Corrido	CO	D041
9356	Cremia	CO	D147
9357	Cucciago	CO	D196
9358	Cusino	CO	D232
9359	Dizzasco	CO	D310
9360	Domaso	CO	D329
9361	Dongo	CO	D341
9362	Dosso del Liro	CO	D355
9363	Erba	CO	D416
9364	Eupilio	CO	D445
9365	Faggeto Lario	CO	D462
9366	Faloppio	CO	D482
9367	Fenegrò	CO	D531
9368	Figino Serenza	CO	D579
9369	Fino Mornasco	CO	D605
9370	Garzeno	CO	D930
9371	Gera Lario	CO	D974
9372	Grandate	CO	E139
9373	Grandola ed Uniti	CO	E141
9374	Griante	CO	E172
9375	Guanzate	CO	E235
9376	Inverigo	CO	E309
9377	Laglio	CO	E405
9378	Laino	CO	E416
9379	Lambrugo	CO	E428
9380	Lasnigo	CO	E462
9381	Lezzeno	CO	E569
9382	Limido Comasco	CO	E593
9383	Lipomo	CO	E607
9384	Livo	CO	E623
9385	Locate Varesino	CO	E638
9386	Lomazzo	CO	E659
9387	Longone al Segrino	CO	E679
9388	Luisago	CO	E735
9389	Lurago d'Erba	CO	E749
9390	Lurago Marinone	CO	E750
9391	Lurate Caccivio	CO	E753
9392	Magreglio	CO	E830
9393	Mariano Comense	CO	E951
9394	Maslianico	CO	F017
9395	Menaggio	CO	F120
9396	Merone	CO	F151
9397	Moltrasio	CO	F305
9398	Monguzzo	CO	F372
9399	Montano Lucino	CO	F427
9400	Montemezzo	CO	F564
9401	Montorfano	CO	F688
9402	Mozzate	CO	F788
9403	Musso	CO	F828
9404	Nesso	CO	F877
9405	Novedrate	CO	F958
9406	Olgiate Comasco	CO	G025
9407	Oltrona di San Mamette	CO	G056
9408	Orsenigo	CO	G126
9409	Peglio	CO	G415
9410	Pianello del Lario	CO	G556
9411	Pigra	CO	G665
9412	Plesio	CO	G737
9413	Pognana Lario	CO	G773
9414	Ponna	CO	G821
9415	Ponte Lambro	CO	G847
9416	Porlezza	CO	G889
9417	Proserpio	CO	H074
9418	Pusiano	CO	H094
9419	Rezzago	CO	H255
9420	Rodero	CO	H478
9421	Ronago	CO	H521
9422	Rovellasca	CO	H601
9423	Rovello Porro	CO	H602
9424	Sala Comacina	CO	H679
9425	San Bartolomeo Val Cavargna	CO	H760
9426	San Fermo della Battaglia	CO	H840
9427	San Nazzaro Val Cavargna	CO	I051
9428	Schignano	CO	I529
9429	Senna Comasco	CO	I611
9430	Sorico	CO	I856
9431	Sormano	CO	I860
9432	Stazzona	CO	I943
9433	Tavernerio	CO	L071
9434	Torno	CO	L228
9435	Trezzone	CO	L413
9436	Turate	CO	L470
9437	Uggiate-Trevano	CO	L487
9438	Valbrona	CO	L547
9439	Valmorea	CO	L640
9440	Val Rezzo	CO	H259
9441	Valsolda	CO	C936
9442	Veleso	CO	L715
9443	Veniano	CO	L737
9444	Vercana	CO	L748
9445	Vertemate con Minoprio	CO	L792
9446	Villa Guardia	CO	L956
9447	Zelbio	CO	M156
9448	San Siro	CO	I162
9449	Gravedona ed Uniti	CO	M315
9450	Bellagio	CO	M335
9451	Colverde	CO	M336
9452	Tremezzina	CO	M341
9453	Alta Valle Intelvi	CO	M383
9454	Centro Valle Intelvi	CO	M394
9455	Solbiate con Cagno	CO	M412
9456	Albaredo per San Marco	SO	A135
9457	Albosaggia	SO	A172
9458	Andalo Valtellino	SO	A273
9459	Aprica	SO	A337
9460	Ardenno	SO	A382
9461	Bema	SO	A777
9462	Berbenno di Valtellina	SO	A787
9463	Bianzone	SO	A848
9464	Bormio	SO	B049
9465	Buglio in Monte	SO	B255
9466	Caiolo	SO	B366
9467	Campodolcino	SO	B530
9468	Caspoggio	SO	B993
9469	Castello dell'Acqua	SO	C186
9470	Castione Andevenno	SO	C325
9471	Cedrasco	SO	C418
9472	Cercino	SO	C493
9473	Chiavenna	SO	C623
9474	Chiesa in Valmalenco	SO	C628
9475	Chiuro	SO	C651
9476	Cino	SO	C709
9477	Civo	SO	C785
9478	Colorina	SO	C903
9479	Cosio Valtellino	SO	D088
9480	Dazio	SO	D258
9481	Delebio	SO	D266
9482	Dubino	SO	D377
9483	Faedo Valtellino	SO	D456
9484	Forcola	SO	D694
9485	Fusine	SO	D830
9486	Gerola Alta	SO	D990
9487	Gordona	SO	E090
9488	Grosio	SO	E200
9489	Grosotto	SO	E201
9490	Madesimo	SO	E342
9491	Lanzada	SO	E443
9492	Livigno	SO	E621
9493	Lovero	SO	E705
9494	Mantello	SO	E896
9495	Mazzo di Valtellina	SO	F070
9496	Mello	SO	F115
9497	Mese	SO	F153
9498	Montagna in Valtellina	SO	F393
9499	Morbegno	SO	F712
9500	Novate Mezzola	SO	F956
9501	Pedesina	SO	G410
9502	Piantedo	SO	G572
9503	Piateda	SO	G576
9504	Piuro	SO	G718
9505	Poggiridenti	SO	G431
9506	Ponte in Valtellina	SO	G829
9507	Postalesio	SO	G937
9508	Prata Camportaccio	SO	G993
9509	Rasura	SO	H192
9510	Rogolo	SO	H493
9511	Samolaco	SO	H752
9512	San Giacomo Filippo	SO	H868
9513	Sernio	SO	I636
9514	Sondalo	SO	I828
9515	Sondrio	SO	I829
9516	Spriana	SO	I928
9517	Talamona	SO	L035
9518	Tartano	SO	L056
9519	Teglio	SO	L084
9520	Tirano	SO	L175
9521	Torre di Santa Maria	SO	L244
9522	Tovo di Sant'Agata	SO	L316
9523	Traona	SO	L330
9524	Tresivio	SO	L392
9525	Valdidentro	SO	L557
9526	Valdisotto	SO	L563
9527	Valfurva	SO	L576
9528	Val Masino	SO	L638
9529	Verceia	SO	L749
9530	Vervio	SO	L799
9531	Villa di Chiavenna	SO	L907
9532	Villa di Tirano	SO	L908
9533	Abbiategrasso	MI	A010
9534	Albairate	MI	A127
9535	Arconate	MI	A375
9536	Arese	MI	A389
9537	Arluno	MI	A413
9538	Assago	MI	A473
9539	Bareggio	MI	A652
9540	Basiano	MI	A697
9541	Basiglio	MI	A699
9542	Bellinzago Lombardo	MI	A751
9543	Bernate Ticino	MI	A804
9544	Besate	MI	A820
9545	Binasco	MI	A872
9546	Boffalora sopra Ticino	MI	A920
9547	Bollate	MI	A940
9548	Bresso	MI	B162
9549	Bubbiano	MI	B235
9550	Buccinasco	MI	B240
9551	Buscate	MI	B286
9552	Bussero	MI	B292
9553	Busto Garolfo	MI	B301
9554	Calvignasco	MI	B448
9555	Cambiago	MI	B461
9556	Canegrate	MI	B593
9557	Carpiano	MI	B820
9558	Carugate	MI	B850
9559	Casarile	MI	B938
9560	Casorezzo	MI	B989
9561	Cassano d'Adda	MI	C003
9562	Cassina de' Pecchi	MI	C014
9563	Cassinetta di Lugagnano	MI	C033
9564	Castano Primo	MI	C052
9565	Cernusco sul Naviglio	MI	C523
9566	Cerro al Lambro	MI	C536
9567	Cerro Maggiore	MI	C537
9568	Cesano Boscone	MI	C565
9569	Cesate	MI	C569
9570	Cinisello Balsamo	MI	C707
9571	Cisliano	MI	C733
9572	Cologno Monzese	MI	C895
9573	Colturano	MI	C908
9574	Corbetta	MI	C986
9575	Cormano	MI	D013
9576	Cornaredo	MI	D018
9577	Corsico	MI	D045
9578	Cuggiono	MI	D198
9579	Cusago	MI	D229
9580	Cusano Milanino	MI	D231
9581	Dairago	MI	D244
9582	Dresano	MI	D367
9583	Gaggiano	MI	D845
9584	Garbagnate Milanese	MI	D912
9585	Gessate	MI	D995
9586	Gorgonzola	MI	E094
9587	Grezzago	MI	E170
9588	Gudo Visconti	MI	E258
9589	Inveruno	MI	E313
9590	Inzago	MI	E317
9591	Lacchiarella	MI	E395
9592	Lainate	MI	E415
9593	Legnano	MI	E514
9594	Liscate	MI	E610
9595	Locate di Triulzi	MI	E639
9596	Magenta	MI	E801
9597	Magnago	MI	E819
9598	Marcallo con Casone	MI	E921
9599	Masate	MI	F003
9600	Mediglia	MI	F084
9601	Melegnano	MI	F100
9602	Melzo	MI	F119
9603	Mesero	MI	F155
9604	Milano	MI	F205
9605	Morimondo	MI	D033
9606	Motta Visconti	MI	F783
9607	Nerviano	MI	F874
9608	Nosate	MI	F939
9609	Novate Milanese	MI	F955
9610	Noviglio	MI	F968
9611	Opera	MI	G078
9612	Ossona	MI	G181
9613	Ozzero	MI	G206
9614	Paderno Dugnano	MI	G220
9615	Pantigliate	MI	G316
9616	Parabiago	MI	G324
9617	Paullo	MI	G385
9618	Pero	MI	C013
9619	Peschiera Borromeo	MI	G488
9620	Pessano con Bornago	MI	G502
9621	Pieve Emanuele	MI	G634
9622	Pioltello	MI	G686
9623	Pogliano Milanese	MI	G772
9624	Pozzo d'Adda	MI	G955
9625	Pozzuolo Martesana	MI	G965
9626	Pregnana Milanese	MI	H026
9627	Rescaldina	MI	H240
9629	Robecchetto con Induno	MI	H371
9630	Robecco sul Naviglio	MI	H373
9631	Rodano	MI	H470
9632	Rosate	MI	H560
9633	Rozzano	MI	H623
9634	San Colombano al Lambro	MI	H803
9635	San Donato Milanese	MI	H827
9636	San Giorgio su Legnano	MI	H884
9637	San Giuliano Milanese	MI	H930
9638	Santo Stefano Ticino	MI	I361
9639	San Vittore Olona	MI	I409
9640	San Zenone al Lambro	MI	I415
9641	Sedriano	MI	I566
9642	Segrate	MI	I577
9643	Senago	MI	I602
9644	Sesto San Giovanni	MI	I690
9645	Settala	MI	I696
9646	Settimo Milanese	MI	I700
9647	Solaro	MI	I786
9648	Trezzano Rosa	MI	L408
9649	Trezzano sul Naviglio	MI	L409
9650	Trezzo sull'Adda	MI	L411
9651	Tribiano	MI	L415
9652	Truccazzano	MI	L454
9653	Turbigo	MI	L471
9654	Vanzago	MI	L665
9655	Vaprio d'Adda	MI	L667
9656	Vernate	MI	L773
9657	Vignate	MI	L883
9658	Vimodrone	MI	M053
9659	Vittuone	MI	M091
9660	Vizzolo Predabissi	MI	M102
9661	Zibido San Giacomo	MI	M176
9662	Villa Cortese	MI	L928
9663	Vanzaghello	MI	L664
9664	Baranzate	MI	A618
9665	Vermezzo con Zelo	MI	M424
9666	Adrara San Martino	BG	A057
9667	Adrara San Rocco	BG	A058
9668	Albano Sant'Alessandro	BG	A129
9669	Albino	BG	A163
9670	Almè	BG	A214
9671	Almenno San Bartolomeo	BG	A216
9672	Almenno San Salvatore	BG	A217
9673	Alzano Lombardo	BG	A246
9674	Ambivere	BG	A259
9675	Antegnate	BG	A304
9676	Arcene	BG	A365
9677	Ardesio	BG	A383
9678	Arzago d'Adda	BG	A440
9679	Averara	BG	A511
9680	Aviatico	BG	A517
9681	Azzano San Paolo	BG	A528
9682	Azzone	BG	A533
9683	Bagnatica	BG	A557
9684	Barbata	BG	A631
9685	Bariano	BG	A664
9686	Barzana	BG	A684
9687	Bedulita	BG	A732
9688	Berbenno	BG	A786
9689	Bergamo	BG	A794
9690	Berzo San Fermo	BG	A815
9691	Bianzano	BG	A846
9692	Blello	BG	A903
9693	Bolgare	BG	A937
9694	Boltiere	BG	A950
9695	Bonate Sopra	BG	A963
9696	Bonate Sotto	BG	A962
9697	Borgo di Terzo	BG	B010
9698	Bossico	BG	B083
9699	Bottanuco	BG	B088
9700	Bracca	BG	B112
9701	Branzi	BG	B123
9702	Brembate	BG	B137
9703	Brembate di Sopra	BG	B138
9704	Brignano Gera d'Adda	BG	B178
9705	Brumano	BG	B217
9706	Brusaporto	BG	B223
9707	Calcinate	BG	B393
9708	Calcio	BG	B395
9709	Calusco d'Adda	BG	B434
9710	Calvenzano	BG	B442
9711	Camerata Cornello	BG	B471
9712	Canonica d'Adda	BG	B618
9713	Capizzone	BG	B661
9714	Capriate San Gervasio	BG	B703
9715	Caprino Bergamasco	BG	B710
9716	Caravaggio	BG	B731
9717	Carobbio degli Angeli	BG	B801
9718	Carona	BG	B803
9719	Carvico	BG	B854
9720	Casazza	BG	B947
9721	Casirate d'Adda	BG	B971
9722	Casnigo	BG	B978
9723	Cassiglio	BG	C007
9724	Castelli Calepio	BG	C079
9725	Castel Rozzone	BG	C255
9726	Castione della Presolana	BG	C324
9727	Castro	BG	C337
9728	Cavernago	BG	C396
9729	Cazzano Sant'Andrea	BG	C410
9730	Cenate Sopra	BG	C456
9731	Cenate Sotto	BG	C457
9732	Cene	BG	C459
9733	Cerete	BG	C506
9734	Chignolo d'Isola	BG	C635
9735	Chiuduno	BG	C649
9736	Cisano Bergamasco	BG	C728
9737	Ciserano	BG	C730
9738	Cividate al Piano	BG	C759
9739	Clusone	BG	C800
9740	Colere	BG	C835
9741	Cologno al Serio	BG	C894
9742	Colzate	BG	C910
9743	Comun Nuovo	BG	C937
9744	Corna Imagna	BG	D015
9745	Cortenuova	BG	D066
9746	Costa di Mezzate	BG	D110
9747	Costa Valle Imagna	BG	D103
9748	Costa Volpino	BG	D117
9749	Covo	BG	D126
9750	Credaro	BG	D139
9751	Curno	BG	D221
9752	Cusio	BG	D233
9753	Dalmine	BG	D245
9754	Dossena	BG	D352
9755	Endine Gaiano	BG	D406
9756	Entratico	BG	D411
9757	Fara Gera d'Adda	BG	D490
9758	Fara Olivana con Sola	BG	D491
9759	Filago	BG	D588
9760	Fino del Monte	BG	D604
9761	Fiorano al Serio	BG	D606
9762	Fontanella	BG	D672
9763	Fonteno	BG	D684
9764	Foppolo	BG	D688
9765	Foresto Sparso	BG	D697
9766	Fornovo San Giovanni	BG	D727
9767	Fuipiano Valle Imagna	BG	D817
9768	Gandellino	BG	D903
9769	Gandino	BG	D905
9770	Gandosso	BG	D906
9771	Gaverina Terme	BG	D943
9772	Gazzaniga	BG	D952
9773	Ghisalba	BG	E006
9774	Gorlago	BG	E100
9775	Gorle	BG	E103
9776	Gorno	BG	E106
9777	Grassobbio	BG	E148
9778	Gromo	BG	E189
9779	Grone	BG	E192
9780	Grumello del Monte	BG	E219
9781	Isola di Fondra	BG	E353
9782	Isso	BG	E370
9783	Lallio	BG	E422
9784	Leffe	BG	E509
9785	Lenna	BG	E524
9786	Levate	BG	E562
9787	Locatello	BG	E640
9788	Lovere	BG	E704
9789	Lurano	BG	E751
9790	Luzzana	BG	E770
9791	Madone	BG	E794
9792	Mapello	BG	E901
9793	Martinengo	BG	E987
9794	Mezzoldo	BG	F186
9795	Misano di Gera d'Adda	BG	F243
9796	Moio de' Calvi	BG	F276
9797	Monasterolo del Castello	BG	F328
9798	Montello	BG	F547
9799	Morengo	BG	F720
9800	Mornico al Serio	BG	F738
9801	Mozzanica	BG	F786
9802	Mozzo	BG	F791
9803	Nembro	BG	F864
9804	Olmo al Brembo	BG	G049
9805	Oltre il Colle	BG	G050
9806	Oltressenda Alta	BG	G054
9807	Oneta	BG	G068
9808	Onore	BG	G075
9809	Orio al Serio	BG	G108
9810	Ornica	BG	G118
9811	Osio Sopra	BG	G159
9812	Osio Sotto	BG	G160
9813	Pagazzano	BG	G233
9814	Paladina	BG	G249
9815	Palazzago	BG	G259
9816	Palosco	BG	G295
9817	Parre	BG	G346
9818	Parzanica	BG	G350
9819	Pedrengo	BG	G412
9820	Peia	BG	G418
9821	Pianico	BG	G564
9822	Piario	BG	G574
9823	Piazza Brembana	BG	G579
9824	Piazzatorre	BG	G583
9825	Piazzolo	BG	G588
9826	Pognano	BG	G774
9827	Ponte Nossa	BG	F941
9828	Ponteranica	BG	G853
9829	Ponte San Pietro	BG	G856
9830	Pontida	BG	G864
9831	Pontirolo Nuovo	BG	G867
9832	Pradalunga	BG	G968
9833	Predore	BG	H020
9834	Premolo	BG	H036
9835	Presezzo	BG	H046
9836	Pumenengo	BG	H091
9837	Ranica	BG	H176
9838	Ranzanico	BG	H177
9839	Riva di Solto	BG	H331
9840	Rogno	BG	H492
9841	Romano di Lombardia	BG	H509
9842	Roncobello	BG	H535
9843	Roncola	BG	H544
9844	Rota d'Imagna	BG	H584
9845	Rovetta	BG	H615
9846	San Giovanni Bianco	BG	H910
9847	San Paolo d'Argon	BG	B310
9848	San Pellegrino Terme	BG	I079
9849	Santa Brigida	BG	I168
9850	Sarnico	BG	I437
9851	Scanzorosciate	BG	I506
9852	Schilpario	BG	I530
9853	Sedrina	BG	I567
9854	Selvino	BG	I597
9855	Seriate	BG	I628
9856	Serina	BG	I629
9857	Solto Collina	BG	I812
9858	Songavazzo	BG	I830
9859	Sorisole	BG	I858
9860	Sotto il Monte Giovanni XXIII	BG	I869
9861	Sovere	BG	I873
9862	Spinone al Lago	BG	I916
9863	Spirano	BG	I919
9864	Stezzano	BG	I951
9865	Strozza	BG	I986
9866	Suisio	BG	I997
9867	Taleggio	BG	L037
9868	Tavernola Bergamasca	BG	L073
9869	Telgate	BG	L087
9870	Terno d'Isola	BG	L118
9871	Torre Boldone	BG	L251
9872	Torre de' Busi	BG	L257
9873	Torre de' Roveri	BG	L265
9874	Torre Pallavicina	BG	L276
9875	Trescore Balneario	BG	L388
9876	Treviglio	BG	L400
9877	Treviolo	BG	L404
9878	Ubiale Clanezzo	BG	C789
9879	Urgnano	BG	L502
9938	Brione	BS	B184
9939	Caino	BS	B365
9940	Calcinato	BS	B394
9941	Calvagese della Riviera	BS	B436
9942	Calvisano	BS	B450
9943	Capo di Ponte	BS	B664
9944	Capovalle	BS	B676
9945	Capriano del Colle	BS	B698
9946	Capriolo	BS	B711
9947	Carpenedolo	BS	B817
9948	Castegnato	BS	C055
9949	Castelcovati	BS	C072
9950	Castel Mella	BS	C208
9951	Castenedolo	BS	C293
9952	Casto	BS	C330
9953	Castrezzato	BS	C332
9954	Cazzago San Martino	BS	C408
9955	Cedegolo	BS	C417
9956	Cellatica	BS	C439
9957	Cerveno	BS	C549
9958	Ceto	BS	C585
9959	Cevo	BS	C591
9960	Chiari	BS	C618
9961	Cigole	BS	C685
9962	Cimbergo	BS	C691
9963	Cividate Camuno	BS	C760
9964	Coccaglio	BS	C806
9965	Collebeato	BS	C850
9966	Collio	BS	C883
9967	Cologne	BS	C893
9968	Comezzano-Cizzago	BS	C925
9969	Concesio	BS	C948
9970	Corte Franca	BS	D058
9971	Corteno Golgi	BS	D064
9972	Corzano	BS	D082
9973	Darfo Boario Terme	BS	D251
9974	Dello	BS	D270
9975	Desenzano del Garda	BS	D284
9976	Edolo	BS	D391
9977	Erbusco	BS	D421
9978	Esine	BS	D434
9979	Fiesse	BS	D576
9980	Flero	BS	D634
9981	Gambara	BS	D891
9982	Gardone Riviera	BS	D917
9983	Gardone Val Trompia	BS	D918
9984	Gargnano	BS	D924
9985	Gavardo	BS	D940
9986	Ghedi	BS	D999
9987	Gianico	BS	E010
9988	Gottolengo	BS	E116
9989	Gussago	BS	E271
9990	Idro	BS	E280
9991	Incudine	BS	E297
9992	Irma	BS	E325
9993	Iseo	BS	E333
9994	Isorella	BS	E364
9995	Lavenone	BS	E497
9996	Leno	BS	E526
9997	Limone sul Garda	BS	E596
9998	Lodrino	BS	E652
9999	Lograto	BS	E654
10000	Lonato del Garda	BS	M312
10001	Longhena	BS	E673
10002	Losine	BS	E698
10003	Lozio	BS	E706
10004	Lumezzane	BS	E738
10005	Maclodio	BS	E787
10006	Magasa	BS	E800
10007	Mairano	BS	E841
10008	Malegno	BS	E851
10009	Malonno	BS	E865
10010	Manerba del Garda	BS	E883
10011	Manerbio	BS	E884
10012	Marcheno	BS	E928
10013	Marmentino	BS	E961
10014	Marone	BS	E967
10015	Mazzano	BS	F063
10016	Milzano	BS	F216
10017	Moniga del Garda	BS	F373
10018	Monno	BS	F375
10019	Monte Isola	BS	F532
10020	Monticelli Brusati	BS	F672
10021	Montichiari	BS	F471
10022	Montirone	BS	F680
10023	Mura	BS	F806
10024	Muscoline	BS	F820
10025	Nave	BS	F851
10026	Niardo	BS	F884
10027	Nuvolento	BS	F989
10028	Nuvolera	BS	F990
10029	Odolo	BS	G001
10030	Offlaga	BS	G006
10032	Ono San Pietro	BS	G074
10033	Orzinuovi	BS	G149
10034	Orzivecchi	BS	G150
10035	Ospitaletto	BS	G170
10036	Ossimo	BS	G179
10037	Padenghe sul Garda	BS	G213
10038	Paderno Franciacorta	BS	G217
10039	Paisco Loveno	BS	G247
10040	Paitone	BS	G248
10041	Palazzolo sull'Oglio	BS	G264
10042	Paratico	BS	G327
10043	Paspardo	BS	G354
10044	Passirano	BS	G361
10045	Pavone del Mella	BS	G391
10046	San Paolo	BS	G407
10047	Pertica Alta	BS	G474
10048	Pertica Bassa	BS	G475
10049	Pezzaze	BS	G529
10050	Pian Camuno	BS	G546
10051	Pisogne	BS	G710
10052	Polaveno	BS	G779
10053	Polpenazze del Garda	BS	G801
10054	Pompiano	BS	G815
10055	Poncarale	BS	G818
10056	Ponte di Legno	BS	G844
10057	Pontevico	BS	G859
10058	Pontoglio	BS	G869
10059	Pozzolengo	BS	G959
10060	Pralboino	BS	G977
10061	Preseglie	BS	H043
10062	Prevalle	BS	H055
10063	Provaglio d'Iseo	BS	H078
10064	Provaglio Val Sabbia	BS	H077
10065	Puegnago sul Garda	BS	H086
10066	Quinzano d'Oglio	BS	H140
10067	Remedello	BS	H230
10068	Rezzato	BS	H256
10069	Roccafranca	BS	H410
10070	Rodengo Saiano	BS	H477
10071	Roè Volciano	BS	H484
10072	Roncadelle	BS	H525
10073	Rovato	BS	H598
10074	Rudiano	BS	H630
10075	Sabbio Chiese	BS	H650
10076	Sale Marasino	BS	H699
10077	Salò	BS	H717
10078	San Felice del Benaco	BS	H838
10079	San Gervasio Bresciano	BS	H865
10080	San Zeno Naviglio	BS	I412
10081	Sarezzo	BS	I433
10082	Saviore dell'Adamello	BS	I476
10083	Sellero	BS	I588
10084	Seniga	BS	I607
10085	Serle	BS	I631
10086	Sirmione	BS	I633
10087	Soiano del Lago	BS	I782
10088	Sonico	BS	I831
10089	Sulzano	BS	L002
10090	Tavernole sul Mella	BS	C698
10091	Temù	BS	L094
10092	Tignale	BS	L169
10093	Torbole Casaglia	BS	L210
10094	Toscolano-Maderno	BS	L312
10095	Travagliato	BS	L339
10096	Tremosine sul Garda	BS	L372
10097	Trenzano	BS	L380
10098	Treviso Bresciano	BS	L406
10099	Urago d'Oglio	BS	L494
10100	Vallio Terme	BS	L626
10101	Valvestino	BS	L468
10102	Verolanuova	BS	L777
10103	Verolavecchia	BS	L778
10104	Vestone	BS	L812
10105	Vezza d'Oglio	BS	L816
10106	Villa Carcina	BS	L919
10107	Villachiara	BS	L923
10108	Villanuova sul Clisi	BS	L995
10109	Vione	BS	M065
10110	Visano	BS	M070
10111	Vobarno	BS	M104
10112	Zone	BS	M188
10113	Piancogno	BS	G549
10114	Alagna	PV	A118
10115	Albaredo Arnaboldi	PV	A134
10116	Albonese	PV	A171
10117	Albuzzano	PV	A175
10118	Arena Po	PV	A387
10119	Badia Pavese	PV	A538
10120	Bagnaria	PV	A550
10121	Barbianello	PV	A634
10122	Bascapè	PV	A690
10123	Bastida Pancarana	PV	A712
10124	Battuda	PV	A718
10125	Belgioioso	PV	A741
10126	Bereguardo	PV	A792
10127	Borgarello	PV	A989
10128	Borgo Priolo	PV	B028
10129	Borgoratto Mormorolo	PV	B030
10130	Borgo San Siro	PV	B038
10131	Bornasco	PV	B051
10132	Bosnasco	PV	B082
10133	Brallo di Pregola	PV	B117
10134	Breme	PV	B142
10135	Bressana Bottarone	PV	B159
10136	Broni	PV	B201
10137	Calvignano	PV	B447
10138	Campospinoso	PV	B567
10139	Candia Lomellina	PV	B587
10140	Canneto Pavese	PV	B613
10141	Carbonara al Ticino	PV	B741
10142	Casanova Lonati	PV	B929
10143	Casatisma	PV	B945
10144	Casei Gerola	PV	B954
10145	Casorate Primo	PV	B988
10146	Cassolnovo	PV	C038
10147	Castana	PV	C050
10148	Casteggio	PV	C053
10149	Castelletto di Branduzzo	PV	C157
10150	Castello d'Agogna	PV	C184
10151	Castelnovetto	PV	C213
10152	Cava Manara	PV	C360
10153	Cecima	PV	C414
10154	Ceranova	PV	C484
10155	Ceretto Lomellina	PV	C508
10156	Cergnago	PV	C509
10157	Certosa di Pavia	PV	C541
10158	Cervesina	PV	C551
10159	Chignolo Po	PV	C637
10160	Cigognola	PV	C684
10161	Cilavegna	PV	C686
10162	Codevilla	PV	C813
10163	Confienza	PV	C958
10164	Copiano	PV	C979
10165	Corana	PV	C982
10166	Corvino San Quirico	PV	D081
10167	Costa de' Nobili	PV	D109
10168	Cozzo	PV	D127
10169	Cura Carpignano	PV	B824
10170	Dorno	PV	D348
10171	Ferrera Erbognone	PV	D552
10172	Filighera	PV	D594
10173	Fortunago	PV	D732
10174	Frascarolo	PV	D771
10175	Galliavola	PV	D873
10176	Gambarana	PV	D892
10177	Gambolò	PV	D901
10178	Garlasco	PV	D925
10179	Gerenzago	PV	D980
10180	Giussago	PV	E062
10181	Godiasco Salice Terme	PV	E072
10182	Golferenzo	PV	E081
10183	Gravellona Lomellina	PV	E152
10184	Gropello Cairoli	PV	E195
10185	Inverno e Monteleone	PV	E310
10186	Landriano	PV	E437
10187	Langosco	PV	E439
10188	Lardirago	PV	E454
10189	Linarolo	PV	E600
10190	Lirio	PV	E608
10191	Lomello	PV	E662
10192	Lungavilla	PV	B387
10193	Magherno	PV	E804
10194	Marcignago	PV	E934
10195	Marzano	PV	E999
10196	Mede	PV	F080
10197	Menconico	PV	F122
10198	Mezzana Bigli	PV	F170
10199	Mezzana Rabattone	PV	F171
10200	Mezzanino	PV	F175
10201	Miradolo Terme	PV	F238
10202	Montalto Pavese	PV	F417
10203	Montebello della Battaglia	PV	F440
10204	Montecalvo Versiggia	PV	F449
10205	Montescano	PV	F638
10206	Montesegale	PV	F644
10207	Monticelli Pavese	PV	F670
10208	Montù Beccaria	PV	F701
10209	Mornico Losana	PV	F739
10210	Mortara	PV	F754
10211	Nicorvo	PV	F891
10212	Olevano di Lomellina	PV	G021
10213	Oliva Gessi	PV	G032
10214	Ottobiano	PV	G194
10215	Palestro	PV	G275
10216	Pancarana	PV	G304
10217	Parona	PV	G342
10218	Pavia	PV	G388
10219	Pietra de' Giorgi	PV	G612
10220	Pieve Albignola	PV	G635
10221	Pieve del Cairo	PV	G639
10222	Pieve Porto Morone	PV	G650
10223	Pinarolo Po	PV	G671
10224	Pizzale	PV	G720
10225	Ponte Nizza	PV	G851
10226	Portalbera	PV	G895
10227	Rea	PV	H204
10228	Redavalle	PV	H216
10229	Retorbido	PV	H246
10230	Rivanazzano Terme	PV	H336
10231	Robbio	PV	H369
10232	Robecco Pavese	PV	H375
10233	Rocca de' Giorgi	PV	H396
10234	Rocca Susella	PV	H450
10235	Rognano	PV	H491
10236	Romagnese	PV	H505
10237	Roncaro	PV	H527
10238	Rosasco	PV	H559
10239	Rovescala	PV	H614
10240	San Cipriano Po	PV	H799
10241	San Damiano al Colle	PV	H814
10242	San Genesio ed Uniti	PV	H859
10243	San Giorgio di Lomellina	PV	H885
10244	San Martino Siccomario	PV	I014
10245	Sannazzaro de' Burgondi	PV	I048
10246	Santa Cristina e Bissone	PV	I175
10247	Santa Giuletta	PV	I203
10248	Sant'Alessio con Vialone	PV	I213
10249	Santa Margherita di Staffora	PV	I230
10250	Santa Maria della Versa	PV	I237
10251	Sant'Angelo Lomellina	PV	I276
10252	San Zenone al Po	PV	I416
10253	Sartirana Lomellina	PV	I447
10254	Scaldasole	PV	I487
10255	Semiana	PV	I599
10256	Silvano Pietra	PV	I739
10257	Siziano	PV	E265
10258	Sommo	PV	I825
10259	Spessa	PV	I894
10260	Stradella	PV	I968
10261	Suardi	PV	B014
10262	Torrazza Coste	PV	L237
10263	Torre Beretti e Castellaro	PV	L250
10264	Torre d'Arese	PV	L256
10265	Torre de' Negri	PV	L262
10266	Torre d'Isola	PV	L269
10267	Torrevecchia Pia	PV	L285
10268	Torricella Verzate	PV	L292
10269	Travacò Siccomario	PV	I236
10270	Trivolzio	PV	L440
10271	Tromello	PV	L449
10272	Trovo	PV	L453
10273	Val di Nizza	PV	L562
10274	Valeggio	PV	L568
10275	Valle Lomellina	PV	L593
10276	Valle Salimbene	PV	L617
10277	Varzi	PV	L690
10278	Velezzo Lomellina	PV	L716
10279	Vellezzo Bellini	PV	L720
10280	Verretto	PV	L784
10281	Verrua Po	PV	L788
10282	Vidigulfo	PV	L854
10283	Vigevano	PV	L872
10284	Villa Biscossi	PV	L917
10285	Villanova d'Ardenghi	PV	L983
10286	Villanterio	PV	L994
10287	Vistarino	PV	M079
10288	Voghera	PV	M109
10289	Volpara	PV	M119
10290	Zavattarello	PV	M150
10291	Zeccone	PV	M152
10292	Zeme	PV	M161
10293	Zenevredo	PV	M162
10294	Zerbo	PV	M166
10295	Zerbolò	PV	M167
10296	Zinasco	PV	M180
10297	Cornale e Bastida	PV	M338
10298	Corteolona e Genzone	PV	M372
10299	Colli Verdi	PV	M419
10300	Acquanegra Cremonese	CR	A039
10301	Agnadello	CR	A076
10302	Annicco	CR	A299
10303	Azzanello	CR	A526
10304	Bagnolo Cremasco	CR	A570
10305	Bonemerse	CR	A972
10306	Bordolano	CR	A986
10307	Calvatone	CR	B439
10308	Camisano	CR	B484
10309	Campagnola Cremasca	CR	B498
10310	Capergnanica	CR	B650
10311	Cappella Cantone	CR	B679
10312	Cappella de' Picenardi	CR	B680
10313	Capralba	CR	B686
10314	Casalbuttano ed Uniti	CR	B869
10315	Casale Cremasco-Vidolasco	CR	B881
10316	Casaletto Ceredano	CR	B889
10317	Casaletto di Sopra	CR	B890
10318	Casaletto Vaprio	CR	B891
10319	Casalmaggiore	CR	B898
10320	Casalmorano	CR	B900
10321	Casteldidone	CR	C089
10322	Castel Gabbiano	CR	C115
10323	Castelleone	CR	C153
10324	Castelverde	CR	B129
10325	Castelvisconti	CR	C290
10326	Cella Dati	CR	C435
10327	Chieve	CR	C634
10328	Cicognolo	CR	C678
10329	Cingia de' Botti	CR	C703
10330	Corte de' Cortesi con Cignone	CR	D056
10331	Corte de' Frati	CR	D057
10332	Credera Rubbiano	CR	D141
10333	Crema	CR	D142
10334	Cremona	CR	D150
10335	Cremosano	CR	D151
10336	Crotta d'Adda	CR	D186
10337	Cumignano sul Naviglio	CR	D203
10338	Derovere	CR	D278
10339	Dovera	CR	D358
10340	Fiesco	CR	D574
10341	Formigara	CR	D710
10342	Gabbioneta-Binanuova	CR	D834
10343	Gadesco-Pieve Delmona	CR	D841
10344	Genivolta	CR	D966
10345	Gerre de' Caprioli	CR	D993
10346	Gombito	CR	E082
10347	Grontardo	CR	E193
10348	Grumello Cremonese ed Uniti	CR	E217
10349	Gussola	CR	E272
10350	Isola Dovarese	CR	E356
10351	Izano	CR	E380
10352	Madignano	CR	E793
10353	Malagnino	CR	E843
10354	Martignana di Po	CR	E983
10355	Monte Cremasco	CR	F434
10356	Montodine	CR	F681
10357	Moscazzano	CR	F761
10358	Motta Baluffi	CR	F771
10359	Offanengo	CR	G004
10360	Olmeneta	CR	G047
10361	Ostiano	CR	G185
10362	Paderno Ponchielli	CR	G222
10363	Palazzo Pignano	CR	G260
10364	Pandino	CR	G306
10365	Persico Dosimo	CR	G469
10366	Pescarolo ed Uniti	CR	G483
10367	Pessina Cremonese	CR	G504
10368	Pianengo	CR	G558
10369	Pieranica	CR	G603
10370	Pieve d'Olmi	CR	G647
10371	Pieve San Giacomo	CR	G651
10372	Pizzighettone	CR	G721
10373	Pozzaglio ed Uniti	CR	B914
10374	Quintano	CR	H130
10375	Ricengo	CR	H276
10376	Ripalta Arpina	CR	H314
10377	Ripalta Cremasca	CR	H315
10378	Ripalta Guerina	CR	H316
10379	Rivarolo del Re ed Uniti	CR	H341
10380	Rivolta d'Adda	CR	H357
10381	Robecco d'Oglio	CR	H372
10382	Romanengo	CR	H508
10383	Salvirola	CR	H731
10384	San Bassano	CR	H767
10385	San Daniele Po	CR	H815
10386	San Giovanni in Croce	CR	H918
10387	San Martino del Lago	CR	I007
10388	Scandolara Ravara	CR	I497
10389	Scandolara Ripa d'Oglio	CR	I498
10390	Sergnano	CR	I627
10391	Sesto ed Uniti	CR	I683
10392	Solarolo Rainerio	CR	I790
10393	Soncino	CR	I827
10394	Soresina	CR	I849
10395	Sospiro	CR	I865
10396	Spinadesco	CR	I906
10397	Spineda	CR	I909
10398	Spino d'Adda	CR	I914
10399	Stagno Lombardo	CR	I935
10400	Ticengo	CR	L164
10401	Torlino Vimercati	CR	L221
10402	Tornata	CR	L225
10403	Torre de' Picenardi	CR	L258
10404	Torricella del Pizzo	CR	L296
10405	Trescore Cremasco	CR	L389
10406	Trigolo	CR	L426
10407	Vaiano Cremasco	CR	L535
10408	Vailate	CR	L539
10409	Vescovato	CR	L806
10410	Volongo	CR	M116
10411	Voltido	CR	M127
10412	Piadena Drizzona	CR	M418
10413	Acquanegra sul Chiese	MN	A038
10414	Asola	MN	A470
10415	Bagnolo San Vito	MN	A575
10416	Bozzolo	MN	B110
10417	Canneto sull'Oglio	MN	B612
10418	Casalmoro	MN	B901
10419	Casaloldo	MN	B907
10420	Casalromano	MN	B911
10421	Castelbelforte	MN	C059
10422	Castel d'Ario	MN	C076
10423	Castel Goffredo	MN	C118
10424	Castellucchio	MN	C195
10425	Castiglione delle Stiviere	MN	C312
10426	Cavriana	MN	C406
10427	Ceresara	MN	C502
10428	Commessaggio	MN	C930
10429	Curtatone	MN	D227
10430	Dosolo	MN	D351
10431	Gazoldo degli Ippoliti	MN	D949
10432	Gazzuolo	MN	D959
10433	Goito	MN	E078
10434	Gonzaga	MN	E089
10435	Guidizzolo	MN	E261
10436	Magnacavallo	MN	E818
10437	Mantova	MN	E897
10438	Marcaria	MN	E922
10439	Mariana Mantovana	MN	E949
10440	Marmirolo	MN	E962
10441	Medole	MN	F086
10442	Moglia	MN	F267
10443	Monzambano	MN	F705
10444	Motteggiana	MN	B012
10445	Ostiglia	MN	G186
10446	Pegognaga	MN	G417
10447	Piubega	MN	G717
10448	Poggio Rusco	MN	G753
10449	Pomponesco	MN	G816
10450	Ponti sul Mincio	MN	G862
10451	Porto Mantovano	MN	G917
10452	Quingentole	MN	H129
10453	Quistello	MN	H143
10454	Redondesco	MN	H218
10455	Rivarolo Mantovano	MN	H342
10456	Rodigo	MN	H481
10457	Roncoferraro	MN	H541
10458	Roverbella	MN	H604
10459	Sabbioneta	MN	H652
10460	San Benedetto Po	MN	H771
10461	San Giacomo delle Segnate	MN	H870
10462	San Giorgio Bigarello	MN	H883
10463	San Giovanni del Dosso	MN	H912
10464	San Martino dall'Argine	MN	I005
10465	Schivenoglia	MN	I532
10466	Sermide e Felonica	MN	I632
10467	Serravalle a Po	MN	I662
10468	Solferino	MN	I801
10469	Sustinente	MN	L015
10470	Suzzara	MN	L020
10471	Viadana	MN	L826
10472	Villimpenta	MN	M044
10473	Volta Mantovana	MN	M125
10474	Borgo Virgilio	MN	M340
10475	Borgo Mantovano	MN	M396
10476	Borgocarbonara  	MN	M406
10477	Abbadia Lariana	LC	A005
10478	Airuno	LC	A112
10479	Annone di Brianza	LC	A301
10480	Ballabio	LC	A594
10481	Barzago	LC	A683
10482	Barzanò	LC	A686
10483	Barzio	LC	A687
10484	Bellano	LC	A745
10485	Bosisio Parini	LC	B081
10486	Brivio	LC	B194
10487	Bulciago	LC	B261
10488	Calco	LC	B396
10489	Calolziocorte	LC	B423
10490	Carenno	LC	B763
10491	Casargo	LC	B937
10492	Casatenovo	LC	B943
10493	Cassago Brianza	LC	B996
10494	Cassina Valsassina	LC	C024
10495	Castello di Brianza	LC	C187
10496	Cernusco Lombardone	LC	C521
10497	Cesana Brianza	LC	C563
10498	Civate	LC	C752
10499	Colico	LC	C839
10500	Colle Brianza	LC	C851
10501	Cortenova	LC	D065
10502	Costa Masnaga	LC	D112
10503	Crandola Valsassina	LC	D131
10504	Cremella	LC	D143
10505	Cremeno	LC	D145
10506	Dervio	LC	D280
10507	Dolzago	LC	D327
10508	Dorio	LC	D346
10509	Ello	LC	D398
10510	Erve	LC	D428
10511	Esino Lario	LC	D436
10512	Galbiate	LC	D865
10513	Garbagnate Monastero	LC	D913
10514	Garlate	LC	D926
10515	Imbersago	LC	E287
10516	Introbio	LC	E305
10517	Lecco	LC	E507
10518	Lierna	LC	E581
10519	Lomagna	LC	E656
10520	Malgrate	LC	E858
10521	Mandello del Lario	LC	E879
10522	Margno	LC	E947
10523	Merate	LC	F133
10524	Missaglia	LC	F248
10525	Moggio	LC	F265
10526	Molteno	LC	F304
10527	Monte Marenzo	LC	F561
10528	Montevecchia	LC	F657
10529	Monticello Brianza	LC	F674
10530	Morterone	LC	F758
10531	Nibionno	LC	F887
10532	Oggiono	LC	G009
10533	Olgiate Molgora	LC	G026
10534	Olginate	LC	G030
10535	Oliveto Lario	LC	G040
10536	Osnago	LC	G161
10537	Paderno d'Adda	LC	G218
10538	Pagnona	LC	G241
10539	Parlasco	LC	G336
10540	Pasturo	LC	G368
10541	Perledo	LC	G456
10542	Pescate	LC	G485
10543	Premana	LC	H028
10544	Primaluna	LC	H063
10545	Robbiate	LC	G223
10546	Rogeno	LC	H486
10547	Santa Maria Hoè	LC	I243
10548	Sirone	LC	I759
10549	Sirtori	LC	I761
10550	Sueglio	LC	I994
10551	Suello	LC	I996
10552	Taceno	LC	L022
10553	Valgreghentino	LC	L581
10554	Valmadrera	LC	L634
10555	Varenna	LC	L680
10556	Vendrogno	LC	L731
10557	Vercurago	LC	L751
10558	Viganò	LC	L866
10559	Verderio	LC	M337
10560	La Valletta Brianza	LC	M348
10561	Valvarrone	LC	M395
10562	Abbadia Cerreto	LO	A004
10563	Bertonico	LO	A811
10564	Boffalora d'Adda	LO	A919
10565	Borghetto Lodigiano	LO	A995
10566	Borgo San Giovanni	LO	B017
10567	Brembio	LO	B141
10568	Casaletto Lodigiano	LO	B887
10569	Casalmaiocco	LO	B899
10570	Casalpusterlengo	LO	B910
10571	Caselle Landi	LO	B961
10572	Caselle Lurani	LO	B958
10573	Castelnuovo Bocca d'Adda	LO	C228
10574	Castiglione d'Adda	LO	C304
10575	Castiraga Vidardo	LO	C329
10576	Cavenago d'Adda	LO	C394
10577	Cervignano d'Adda	LO	C555
10578	Codogno	LO	C816
10579	Comazzo	LO	C917
10580	Cornegliano Laudense	LO	D021
10581	Corno Giovine	LO	D028
10582	Cornovecchio	LO	D029
10583	Corte Palasio	LO	D068
10584	Crespiatica	LO	D159
10585	Fombio	LO	D660
10586	Galgagnano	LO	D868
10587	Graffignana	LO	E127
10588	Guardamiglio	LO	E238
10589	Livraga	LO	E627
10590	Lodi	LO	E648
10591	Lodi Vecchio	LO	E651
10592	Maccastorna	LO	E777
10593	Mairago	LO	E840
10594	Maleo	LO	E852
10595	Marudo	LO	E994
10596	Massalengo	LO	F028
10597	Meleti	LO	F102
10598	Merlino	LO	F149
10599	Montanaso Lombardo	LO	F423
10600	Mulazzano	LO	F801
10601	Orio Litta	LO	G107
10602	Ospedaletto Lodigiano	LO	G166
10603	Ossago Lodigiano	LO	G171
10604	Pieve Fissiraga	LO	G096
10605	Salerano sul Lambro	LO	H701
10606	San Fiorano	LO	H844
10607	San Martino in Strada	LO	I012
10608	San Rocco al Porto	LO	I140
10609	Sant'Angelo Lodigiano	LO	I274
10610	Santo Stefano Lodigiano	LO	I362
10611	Secugnago	LO	I561
10612	Senna Lodigiana	LO	I612
10613	Somaglia	LO	I815
10614	Sordio	LO	I848
10615	Tavazzano con Villavesco	LO	F260
10616	Terranova dei Passerini	LO	L125
10617	Turano Lodigiano	LO	L469
10618	Valera Fratta	LO	L572
10619	Villanova del Sillaro	LO	L977
10620	Zelo Buon Persico	LO	M158
10621	Castelgerundo	LO	M393
10622	Agrate Brianza	MB	A087
10623	Aicurzio	MB	A096
10624	Albiate	MB	A159
10625	Arcore	MB	A376
10626	Barlassina	MB	A668
10627	Bellusco	MB	A759
10628	Bernareggio	MB	A802
10629	Besana in Brianza	MB	A818
10630	Biassono	MB	A849
10631	Bovisio-Masciago	MB	B105
10632	Briosco	MB	B187
10633	Brugherio	MB	B212
10634	Burago di Molgora	MB	B272
10635	Camparada	MB	B501
10636	Carate Brianza	MB	B729
10637	Carnate	MB	B798
10638	Cavenago di Brianza	MB	C395
10639	Ceriano Laghetto	MB	C512
10640	Cesano Maderno	MB	C566
10641	Cogliate	MB	C820
10642	Concorezzo	MB	C952
10643	Correzzana	MB	D038
10644	Desio	MB	D286
10645	Giussano	MB	E063
10646	Lazzate	MB	E504
10647	Lesmo	MB	E550
10648	Limbiate	MB	E591
10649	Lissone	MB	E617
10650	Macherio	MB	E786
10651	Meda	MB	F078
10652	Mezzago	MB	F165
10653	Misinto	MB	F247
10654	Monza	MB	F704
10655	Muggiò	MB	F797
10656	Nova Milanese	MB	F944
10657	Ornago	MB	G116
10658	Renate	MB	H233
10659	Ronco Briantino	MB	H537
10660	Seregno	MB	I625
10661	Seveso	MB	I709
10662	Sovico	MB	I878
10663	Sulbiate	MB	I998
10664	Triuggio	MB	L434
10665	Usmate Velate	MB	L511
10666	Varedo	MB	L677
10667	Vedano al Lambro	MB	L704
10668	Veduggio con Colzano	MB	L709
10669	Verano Brianza	MB	L744
10670	Villasanta	MB	M017
10671	Vimercate	MB	M052
10672	Busnago	MB	B289
10673	Caponago	MB	B671
10674	Cornate d'Adda	MB	D019
10675	Lentate sul Seveso	MB	E530
10676	Roncello	MB	H529
10677	Aldino	BZ	A179
10678	Andriano	BZ	A286
10679	Anterivo	BZ	A306
10680	Appiano sulla strada del vino	BZ	A332
10681	Avelengo	BZ	A507
10682	Badia	BZ	A537
10683	Barbiano	BZ	A635
10684	Bolzano	BZ	A952
10685	Braies	BZ	B116
10686	Brennero	BZ	B145
10687	Bressanone	BZ	B160
10688	Bronzolo	BZ	B203
10689	Brunico	BZ	B220
10690	Caines	BZ	B364
10691	Caldaro sulla strada del vino	BZ	B397
10692	Campo di Trens	BZ	B529
10693	Campo Tures	BZ	B570
10694	Castelbello-Ciardes	BZ	C062
10695	Castelrotto	BZ	C254
10696	Cermes	BZ	A022
10697	Chienes	BZ	C625
10698	Chiusa	BZ	C652
10699	Cornedo all'Isarco	BZ	B799
10700	Cortaccia sulla strada del vino	BZ	D048
10701	Cortina sulla strada del vino	BZ	D075
10702	Corvara in Badia	BZ	D079
10703	Curon Venosta	BZ	D222
10704	Dobbiaco	BZ	D311
10705	Egna	BZ	D392
10706	Falzes	BZ	D484
10707	Fiè allo Sciliar	BZ	D571
10708	Fortezza	BZ	D731
10709	Funes	BZ	D821
10710	Gais	BZ	D860
10711	Gargazzone	BZ	D923
10712	Glorenza	BZ	E069
10713	Laces	BZ	E398
10714	Lagundo	BZ	E412
10715	Laion	BZ	E420
10716	Laives	BZ	E421
10717	Lana	BZ	E434
10718	Lasa	BZ	E457
10719	Lauregno	BZ	E481
10720	Luson	BZ	E764
10721	Magrè sulla strada del vino	BZ	E829
10722	Malles Venosta	BZ	E862
10723	Marebbe	BZ	E938
10724	Marlengo	BZ	E959
10725	Martello	BZ	E981
10726	Meltina	BZ	F118
10727	Merano	BZ	F132
10728	Monguelfo-Tesido	BZ	F371
10729	Montagna	BZ	F392
10730	Moso in Passiria	BZ	F766
10731	Nalles	BZ	F836
10732	Naturno	BZ	F849
10733	Naz-Sciaves	BZ	F856
10734	Nova Levante	BZ	F949
10735	Nova Ponente	BZ	F950
10736	Ora	BZ	G083
10737	Ortisei	BZ	G140
10738	Parcines	BZ	G328
10739	Perca	BZ	G443
10740	Plaus	BZ	G299
10741	Ponte Gardena	BZ	G830
10742	Postal	BZ	G936
10743	Prato allo Stelvio	BZ	H004
10744	Predoi	BZ	H019
10745	Proves	BZ	H081
10746	Racines	BZ	H152
10747	Rasun-Anterselva	BZ	H189
10748	Renon	BZ	H236
10749	Rifiano	BZ	H284
10750	Rio di Pusteria	BZ	H299
10751	Rodengo	BZ	H475
10752	Salorno	BZ	H719
10753	San Candido	BZ	H786
10754	San Genesio Atesino	BZ	H858
10755	San Leonardo in Passiria	BZ	H952
10756	San Lorenzo di Sebato	BZ	H956
10757	San Martino in Badia	BZ	H988
10758	San Martino in Passiria	BZ	H989
10759	San Pancrazio	BZ	I065
10760	Santa Cristina Valgardena	BZ	I173
10761	Sarentino	BZ	I431
10762	Scena	BZ	I519
10763	Selva dei Molini	BZ	I593
10764	Selva di Val Gardena	BZ	I591
10765	Senales	BZ	I604
10766	Sesto	BZ	I687
10767	Silandro	BZ	I729
10768	Sluderno	BZ	I771
10769	Stelvio	BZ	I948
10770	Terento	BZ	L106
10771	Terlano	BZ	L108
10772	Termeno sulla strada del vino	BZ	L111
10773	Tesimo	BZ	L149
10774	Tires	BZ	L176
10775	Tirolo	BZ	L178
10776	Trodena nel parco naturale	BZ	L444
10777	Tubre	BZ	L455
10778	Ultimo	BZ	L490
10779	Vadena	BZ	L527
10780	Valdaora	BZ	L552
10781	Val di Vizze	BZ	L564
10782	Valle Aurina	BZ	L595
10783	Valle di Casies	BZ	L601
10784	Vandoies	BZ	L660
10785	Varna	BZ	L687
10786	Verano	BZ	L745
10787	Villabassa	BZ	L915
10788	Villandro	BZ	L971
10789	Vipiteno	BZ	M067
10790	Velturno	BZ	L724
10791	La Valle	BZ	E491
10792	Senale-San Felice	BZ	I603
10793	Ala	TN	A116
10794	Albiano	TN	A158
10795	Aldeno	TN	A178
10796	Andalo	TN	A274
10797	Arco	TN	A372
10798	Avio	TN	A520
10799	Baselga di Pinè	TN	A694
10800	Bedollo	TN	A730
10801	Besenello	TN	A821
10802	Bieno	TN	A863
10803	Bleggio Superiore	TN	A902
10804	Bocenago	TN	A916
10805	Bondone	TN	A968
10806	Borgo Valsugana	TN	B006
10807	Brentonico	TN	B153
10808	Bresimo	TN	B158
10809	Brez	TN	B165
10810	Caderzone Terme	TN	B335
10811	Cagnò	TN	B360
10812	Calceranica al Lago	TN	B389
10813	Caldes	TN	B400
10814	Caldonazzo	TN	B404
10815	Calliano	TN	B419
10816	Campitello di Fassa	TN	B514
10817	Campodenno	TN	B525
10818	Canal San Bovo	TN	B577
10819	Canazei	TN	B579
10820	Capriana	TN	B697
10821	Carano	TN	B723
10822	Carisolo	TN	B783
10823	Carzano	TN	B856
10824	Castel Condino	TN	C183
10825	Castelfondo	TN	C103
10826	Castello-Molina di Fiemme	TN	C189
10827	Castello Tesino	TN	C194
10828	Castelnuovo	TN	C216
10829	Cavalese	TN	C372
10830	Cavareno	TN	C380
10831	Cavedago	TN	C392
10832	Cavedine	TN	C393
10833	Cavizzana	TN	C400
10834	Cimone	TN	C700
10835	Cinte Tesino	TN	C712
10836	Cis	TN	C727
10837	Civezzano	TN	C756
10838	Cles	TN	C794
10839	Cloz	TN	C797
10840	Commezzadura	TN	C931
10841	Croviana	TN	D188
10842	Daiano	TN	D243
10843	Dambel	TN	D246
10844	Denno	TN	D273
10845	Drena	TN	D365
10846	Dro	TN	D371
10847	Faedo	TN	D457
10848	Fai della Paganella	TN	D468
10849	Fiavè	TN	D565
10850	Fierozzo	TN	D573
10851	Folgaria	TN	D651
10852	Fondo	TN	D663
10853	Fornace	TN	D714
10854	Frassilongo	TN	D775
10855	Garniga Terme	TN	D928
10856	Giovo	TN	E048
10857	Giustino	TN	E065
10858	Grigno	TN	E178
10859	Imer	TN	E288
10860	Isera	TN	E334
10861	Lavarone	TN	E492
10862	Lavis	TN	E500
10863	Levico Terme	TN	E565
10864	Livo	TN	E624
10865	Lona-Lases	TN	E664
10866	Luserna	TN	E757
10867	Malé	TN	E850
10868	Malosco	TN	E866
10869	Massimeno	TN	F045
10870	Mazzin	TN	F068
10871	Mezzana	TN	F168
10872	Mezzano	TN	F176
10873	Mezzocorona	TN	F183
10874	Mezzolombardo	TN	F187
10875	Moena	TN	F263
10876	Molveno	TN	F307
10877	Mori	TN	F728
10878	Nago-Torbole	TN	F835
10879	Nogaredo	TN	F920
10880	Nomi	TN	F929
10881	Novaledo	TN	F947
10882	Ospedaletto	TN	G168
10883	Ossana	TN	G173
10884	Palù del Fersina	TN	G296
10885	Panchià	TN	G305
10886	Ronzo-Chienis	TN	M303
10887	Peio	TN	G419
10888	Pellizzano	TN	G428
10889	Pelugo	TN	G429
10890	Pergine Valsugana	TN	G452
10891	Pieve Tesino	TN	G656
10892	Pinzolo	TN	G681
10893	Pomarolo	TN	G808
10894	Predazzo	TN	H018
10895	Rabbi	TN	H146
10896	Revò	TN	H254
10897	Riva del Garda	TN	H330
10898	Romallo	TN	H506
10899	Romeno	TN	H517
10900	Roncegno Terme	TN	H528
10901	Ronchi Valsugana	TN	H532
10902	Ronzone	TN	H552
10903	Roverè della Luna	TN	H607
10904	Rovereto	TN	H612
10905	Ruffrè-Mendola	TN	H634
10906	Rumo	TN	H639
10907	Sagron Mis	TN	H666
10908	Samone	TN	H754
10909	San Michele all'Adige	TN	I042
10910	Sant'Orsola Terme	TN	I354
10911	Sanzeno	TN	I411
10912	Sarnonico	TN	I439
10913	Scurelle	TN	I554
10914	Segonzano	TN	I576
10915	Sfruz	TN	I714
10916	Soraga di Fassa	TN	I839
10917	Sover	TN	I871
10918	Spiazzo	TN	I899
10919	Spormaggiore	TN	I924
10920	Sporminore	TN	I925
10921	Stenico	TN	I949
10922	Storo	TN	I964
10923	Strembo	TN	I975
10924	Telve	TN	L089
10925	Telve di Sopra	TN	L090
10926	Tenna	TN	L096
10927	Tenno	TN	L097
10928	Terragnolo	TN	L121
10929	Terzolas	TN	L145
10930	Tesero	TN	L147
10931	Tione di Trento	TN	L174
10932	Ton	TN	L200
10933	Torcegno	TN	L211
10934	Trambileno	TN	L322
10935	Trento	TN	L378
10936	Valfloriana	TN	L575
10937	Vallarsa	TN	L588
10938	Varena	TN	L678
10939	Vermiglio	TN	L769
10940	Vignola-Falesina	TN	L886
10941	Villa Lagarina	TN	L957
10942	Volano	TN	M113
10943	Ziano di Fiemme	TN	M173
10944	Comano Terme	TN	M314
10945	Ledro	TN	M313
10946	Predaia	TN	M344
10947	San Lorenzo Dorsino	TN	M345
10948	Valdaone	TN	M343
10949	Dimaro Folgarida	TN	M366
10950	Pieve di Bono-Prezzo	TN	M365
10951	Altavalle	TN	M349
10952	Altopiano della Vigolana	TN	M350
10953	Amblar-Don	TN	M351
10954	Borgo Chiese	TN	M352
10955	Borgo Lares	TN	M353
10956	Castel Ivano	TN	M354
10957	Cembra Lisignago	TN	M355
10958	Contà	TN	M356
10959	Madruzzo	TN	M357
10960	Porte di Rendena	TN	M358
10961	Primiero San Martino di Castrozza	TN	M359
10962	Sella Giudicarie	TN	M360
10963	Tre Ville	TN	M361
10964	Vallelaghi	TN	M362
10965	Ville d'Anaunia	TN	M363
10966	San Giovanni di Fassa	TN	M390
10967	Terre d'Adige	TN	M407
10968	Affi	VR	A061
10969	Albaredo d'Adige	VR	A137
10970	Angiari	VR	A292
10971	Arcole	VR	A374
10972	Badia Calavena	VR	A540
10973	Bardolino	VR	A650
10974	Belfiore	VR	A737
10975	Bevilacqua	VR	A837
10976	Bonavigo	VR	A964
10977	Boschi Sant'Anna	VR	B070
10978	Bosco Chiesanuova	VR	B073
10979	Bovolone	VR	B107
10980	Brentino Belluno	VR	B152
10981	Brenzone sul Garda	VR	B154
10982	Bussolengo	VR	B296
10983	Buttapietra	VR	B304
10984	Caldiero	VR	B402
10985	Caprino Veronese	VR	B709
10986	Casaleone	VR	B886
10987	Castagnaro	VR	C041
10988	Castel d'Azzano	VR	C078
10989	Castelnuovo del Garda	VR	C225
10990	Cavaion Veronese	VR	C370
10991	Cazzano di Tramigna	VR	C412
10992	Cerea	VR	C498
10993	Cerro Veronese	VR	C538
10994	Cologna Veneta	VR	C890
10995	Colognola ai Colli	VR	C897
10996	Concamarise	VR	C943
10997	Costermano sul Garda	VR	D118
10998	Dolcè	VR	D317
10999	Erbè	VR	D419
11000	Erbezzo	VR	D420
11001	Ferrara di Monte Baldo	VR	D549
11002	Fumane	VR	D818
11003	Garda	VR	D915
11004	Gazzo Veronese	VR	D957
11005	Grezzana	VR	E171
11006	Illasi	VR	E284
11007	Isola della Scala	VR	E349
11008	Isola Rizza	VR	E358
11009	Lavagno	VR	E489
11010	Lazise	VR	E502
11011	Legnago	VR	E512
11012	Malcesine	VR	E848
11013	Marano di Valpolicella	VR	E911
11014	Mezzane di Sotto	VR	F172
11015	Minerbe	VR	F218
11016	Montecchia di Crosara	VR	F461
11017	Monteforte d'Alpone	VR	F508
11018	Mozzecane	VR	F789
11019	Negrar di Valpolicella	VR	F861
11020	Nogara	VR	F918
11021	Nogarole Rocca	VR	F921
11022	Oppeano	VR	G080
11023	Palù	VR	G297
11024	Pastrengo	VR	G365
11025	Pescantina	VR	G481
11026	Peschiera del Garda	VR	G489
11027	Povegliano Veronese	VR	G945
11028	Pressana	VR	H048
11029	Rivoli Veronese	VR	H356
11030	Roncà	VR	H522
11031	Ronco all'Adige	VR	H540
11032	Roverchiara	VR	H606
11033	Roveredo di Guà	VR	H610
11034	Roverè Veronese	VR	H608
11035	Salizzole	VR	H714
11036	San Bonifacio	VR	H783
11037	San Giovanni Ilarione	VR	H916
11038	San Giovanni Lupatoto	VR	H924
11039	Sanguinetto	VR	H944
11040	San Martino Buon Albergo	VR	I003
11041	San Mauro di Saline	VR	H712
11042	San Pietro di Morubio	VR	I105
11043	San Pietro in Cariano	VR	I109
11044	Sant'Ambrogio di Valpolicella	VR	I259
11045	Sant'Anna d'Alfaedo	VR	I292
11046	San Zeno di Montagna	VR	I414
11047	Selva di Progno	VR	I594
11048	Soave	VR	I775
11049	Sommacampagna	VR	I821
11050	Sona	VR	I826
11051	Sorgà	VR	I850
11052	Terrazzo	VR	L136
11053	Torri del Benaco	VR	L287
11054	Tregnago	VR	L364
11055	Trevenzuolo	VR	L396
11056	Valeggio sul Mincio	VR	L567
11057	Velo Veronese	VR	L722
11058	Verona	VR	L781
11059	Veronella	VR	D193
11060	Vestenanova	VR	L810
11061	Vigasio	VR	L869
11062	Villa Bartolomea	VR	L912
11063	Villafranca di Verona	VR	L949
11064	Zevio	VR	M172
11065	Zimella	VR	M178
11066	Agugliaro	VI	A093
11067	Albettone	VI	A154
11068	Alonte	VI	A220
11069	Altavilla Vicentina	VI	A231
11070	Altissimo	VI	A236
11071	Arcugnano	VI	A377
11072	Arsiero	VI	A444
11073	Arzignano	VI	A459
11074	Asiago	VI	A465
11075	Asigliano Veneto	VI	A467
11076	Bassano del Grappa	VI	A703
11077	Bolzano Vicentino	VI	A954
11078	Breganze	VI	B132
11079	Brendola	VI	B143
11080	Bressanvido	VI	B161
11081	Brogliano	VI	B196
11082	Caldogno	VI	B403
11083	Caltrano	VI	B433
11084	Calvene	VI	B441
11085	Camisano Vicentino	VI	B485
11086	Campiglia dei Berici	VI	B511
11087	Carrè	VI	B835
11088	Cartigliano	VI	B844
11089	Cassola	VI	C037
11090	Castegnero	VI	C056
11091	Castelgomberto	VI	C119
11092	Chiampo	VI	C605
11093	Chiuppano	VI	C650
11094	Cogollo del Cengio	VI	C824
11095	Cornedo Vicentino	VI	D020
11096	Costabissara	VI	D107
11097	Creazzo	VI	D136
11098	Crespadoro	VI	D156
11099	Dueville	VI	D379
11100	Enego	VI	D407
11101	Fara Vicentino	VI	D496
11102	Foza	VI	D750
11103	Gallio	VI	D882
11104	Gambellara	VI	D897
11105	Gambugliano	VI	D902
11106	Grisignano di Zocco	VI	E184
11107	Grumolo delle Abbadesse	VI	E226
11108	Isola Vicentina	VI	E354
11109	Laghi	VI	E403
11110	Lastebasse	VI	E465
11111	Longare	VI	E671
11112	Lonigo	VI	E682
11113	Lugo di Vicenza	VI	E731
11114	Malo	VI	E864
11115	Marano Vicentino	VI	E912
11116	Marostica	VI	E970
11117	Montebello Vicentino	VI	F442
11118	Montecchio Maggiore	VI	F464
11119	Montecchio Precalcino	VI	F465
11120	Monte di Malo	VI	F486
11121	Montegalda	VI	F514
11122	Montegaldella	VI	F515
11123	Monteviale	VI	F662
11124	Monticello Conte Otto	VI	F675
11125	Montorso Vicentino	VI	F696
11126	Mussolente	VI	F829
11127	Nanto	VI	F838
11128	Nogarole Vicentino	VI	F922
11129	Nove	VI	F957
11130	Noventa Vicentina	VI	F964
11131	Orgiano	VI	G095
11132	Pedemonte	VI	G406
11133	Pianezze	VI	G560
11134	Piovene Rocchette	VI	G694
11135	Pojana Maggiore	VI	G776
11136	Posina	VI	G931
11137	Pove del Grappa	VI	G943
11138	Pozzoleone	VI	G957
11139	Quinto Vicentino	VI	H134
11140	Recoaro Terme	VI	H214
11141	Roana	VI	H361
11142	Romano d'Ezzelino	VI	H512
11143	Rosà	VI	H556
11144	Rossano Veneto	VI	H580
11145	Rotzo	VI	H594
11146	Salcedo	VI	F810
11147	Sandrigo	VI	H829
11148	San Pietro Mussolino	VI	I117
11149	Santorso	VI	I353
11150	San Vito di Leguzzano	VI	I401
11151	Sarcedo	VI	I425
11152	Sarego	VI	I430
11153	Schiavon	VI	I527
11154	Schio	VI	I531
11155	Solagna	VI	I783
11156	Sossano	VI	I867
11157	Sovizzo	VI	I879
11158	Tezze sul Brenta	VI	L156
11159	Thiene	VI	L157
11160	Tonezza del Cimone	VI	D717
11161	Torrebelvicino	VI	L248
11162	Torri di Quartesolo	VI	L297
11163	Trissino	VI	L433
11164	Valdagno	VI	L551
11165	Valdastico	VI	L554
11166	Valli del Pasubio	VI	L624
11167	Velo d'Astico	VI	L723
11168	Vicenza	VI	L840
11169	Villaga	VI	L952
11170	Villaverla	VI	M032
11171	Zanè	VI	M145
11172	Zermeghedo	VI	M170
11173	Zovencedo	VI	M194
11174	Zugliano	VI	M199
11175	Val Liona	VI	M384
11176	Barbarano Mossano	VI	M401
11177	Valbrenta	VI	M423
11178	Colceresa	VI	M426
11179	Lusiana Conco	VI	M427
11180	Agordo	BL	A083
11181	Alano di Piave	BL	A121
11182	Alleghe	BL	A206
11183	Arsiè	BL	A443
11184	Auronzo di Cadore	BL	A501
11185	Belluno	BL	A757
11186	Borca di Cadore	BL	A982
11187	Calalzo di Cadore	BL	B375
11188	Cencenighe Agordino	BL	C458
11189	Cesiomaggiore	BL	C577
11190	Chies d'Alpago	BL	C630
11191	Cibiana di Cadore	BL	C672
11192	Colle Santa Lucia	BL	C872
11193	Comelico Superiore	BL	C920
11194	Cortina d'Ampezzo	BL	A266
11195	Danta di Cadore	BL	D247
11196	Domegge di Cadore	BL	D330
11197	Falcade	BL	D470
11198	Feltre	BL	D530
11199	Fonzaso	BL	D686
11200	Canale d'Agordo	BL	B574
11201	Gosaldo	BL	E113
11202	Lamon	BL	E429
11203	La Valle Agordina	BL	E490
11204	Limana	BL	E588
11205	Livinallongo del Col di Lana	BL	E622
11206	Lorenzago di Cadore	BL	E687
11207	Lozzo di Cadore	BL	E708
11208	Ospitale di Cadore	BL	G169
11209	Pedavena	BL	G404
11210	Perarolo di Cadore	BL	G442
11211	Pieve di Cadore	BL	G642
11212	Ponte nelle Alpi	BL	B662
11213	Rivamonte Agordino	BL	H327
11214	Rocca Pietore	BL	H379
11215	San Gregorio nelle Alpi	BL	H938
11216	San Nicolò di Comelico	BL	I063
11217	San Pietro di Cadore	BL	I088
11218	Santa Giustina	BL	I206
11219	San Tomaso Agordino	BL	I347
11220	Santo Stefano di Cadore	BL	C919
11221	San Vito di Cadore	BL	I392
11222	Sedico	BL	I563
11223	Selva di Cadore	BL	I592
11224	Seren del Grappa	BL	I626
11225	Sospirolo	BL	I866
11226	Soverzene	BL	I876
11227	Sovramonte	BL	I673
11228	Taibon Agordino	BL	L030
11229	Tambre	BL	L040
11230	Vallada Agordina	BL	L584
11231	Valle di Cadore	BL	L590
11232	Vigo di Cadore	BL	L890
11233	Vodo Cadore	BL	M108
11234	Voltago Agordino	BL	M124
11235	Zoppè di Cadore	BL	M189
11236	Quero Vas	BL	M332
11237	Longarone	BL	M342
11238	Alpago	BL	M375
11239	Val di Zoldo	BL	M374
11240	Borgo Valbelluna	BL	M421
11241	Altivole	TV	A237
11242	Arcade	TV	A360
11243	Asolo	TV	A471
11244	Borso del Grappa	TV	B061
11245	Breda di Piave	TV	B128
11246	Caerano di San Marco	TV	B349
11247	Cappella Maggiore	TV	B678
11248	Carbonera	TV	B744
11249	Casale sul Sile	TV	B879
11250	Casier	TV	B965
11251	Castelcucco	TV	C073
11252	Castelfranco Veneto	TV	C111
11253	Castello di Godego	TV	C190
11254	Cavaso del Tomba	TV	C384
11255	Cessalto	TV	C580
11256	Chiarano	TV	C614
11257	Cimadolmo	TV	C689
11258	Cison di Valmarino	TV	C735
11259	Codognè	TV	C815
11260	Colle Umberto	TV	C848
11261	Conegliano	TV	C957
11262	Cordignano	TV	C992
11263	Cornuda	TV	D030
11264	Crocetta del Montello	TV	C670
11265	Farra di Soligo	TV	D505
11266	Follina	TV	D654
11267	Fontanelle	TV	D674
11268	Fonte	TV	D680
11269	Fregona	TV	D794
11270	Gaiarine	TV	D854
11271	Giavera del Montello	TV	E021
11272	Godega di Sant'Urbano	TV	E071
11273	Gorgo al Monticano	TV	E092
11274	Istrana	TV	E373
11275	Loria	TV	E692
11276	Mansuè	TV	E893
11277	Mareno di Piave	TV	E940
11278	Maser	TV	F009
11279	Maserada sul Piave	TV	F012
11280	Meduna di Livenza	TV	F088
11281	Miane	TV	F190
11282	Mogliano Veneto	TV	F269
11283	Monastier di Treviso	TV	F332
11284	Monfumo	TV	F360
11285	Montebelluna	TV	F443
11286	Morgano	TV	F725
11287	Moriago della Battaglia	TV	F729
11288	Motta di Livenza	TV	F770
11289	Nervesa della Battaglia	TV	F872
11290	Oderzo	TV	F999
11291	Ormelle	TV	G115
11292	Orsago	TV	G123
11293	Paese	TV	G229
11294	Pederobba	TV	G408
11295	Pieve di Soligo	TV	G645
11296	Ponte di Piave	TV	G846
11297	Ponzano Veneto	TV	G875
11298	Portobuffolè	TV	G909
11299	Possagno	TV	G933
11300	Povegliano	TV	G944
11301	Preganziol	TV	H022
11302	Quinto di Treviso	TV	H131
11303	Refrontolo	TV	H220
11304	Resana	TV	H238
11305	Revine Lago	TV	H253
11306	Riese Pio X	TV	H280
11307	Roncade	TV	H523
11308	Salgareda	TV	H706
11309	San Biagio di Callalta	TV	H781
11310	San Fior	TV	H843
11311	San Pietro di Feletto	TV	I103
11312	San Polo di Piave	TV	I124
11313	Santa Lucia di Piave	TV	I221
11314	San Vendemiano	TV	I382
11315	San Zenone degli Ezzelini	TV	I417
11316	Sarmede	TV	I435
11317	Segusino	TV	I578
11318	Sernaglia della Battaglia	TV	I635
11319	Silea	TV	F116
11320	Spresiano	TV	I927
11321	Susegana	TV	L014
11322	Tarzo	TV	L058
11323	Trevignano	TV	L402
11324	Treviso	TV	L407
11325	Valdobbiadene	TV	L565
11326	Vazzola	TV	L700
11327	Vedelago	TV	L706
11328	Vidor	TV	L856
11329	Villorba	TV	M048
11330	Vittorio Veneto	TV	M089
11331	Volpago del Montello	TV	M118
11332	Zenson di Piave	TV	M163
11333	Zero Branco	TV	M171
11334	Pieve del Grappa	TV	M422
11335	Annone Veneto	VE	A302
11336	Campagna Lupia	VE	B493
11337	Campolongo Maggiore	VE	B546
11338	Camponogara	VE	B554
11339	Caorle	VE	B642
11340	Cavarzere	VE	C383
11341	Ceggia	VE	C422
11342	Chioggia	VE	C638
11343	Cinto Caomaggiore	VE	C714
11344	Cona	VE	C938
11345	Concordia Sagittaria	VE	C950
11346	Dolo	VE	D325
11347	Eraclea	VE	D415
11348	Fiesso d'Artico	VE	D578
11349	Fossalta di Piave	VE	D740
11350	Fossalta di Portogruaro	VE	D741
11351	Fossò	VE	D748
11352	Gruaro	VE	E215
11353	Jesolo	VE	C388
11354	Marcon	VE	E936
11355	Martellago	VE	E980
11356	Meolo	VE	F130
11357	Mira	VE	F229
11358	Mirano	VE	F241
11359	Musile di Piave	VE	F826
11360	Noale	VE	F904
11361	Noventa di Piave	VE	F963
11362	Pianiga	VE	G565
11363	Portogruaro	VE	G914
11364	Pramaggiore	VE	G981
11365	Quarto d'Altino	VE	H117
11366	Salzano	VE	H735
11367	San Donà di Piave	VE	H823
11368	San Michele al Tagliamento	VE	I040
11369	Santa Maria di Sala	VE	I242
11370	San Stino di Livenza	VE	I373
11371	Scorzè	VE	I551
11372	Spinea	VE	I908
11373	Stra	VE	I965
11374	Teglio Veneto	VE	L085
11375	Torre di Mosto	VE	L267
11376	Venezia	VE	L736
11377	Vigonovo	VE	L899
11378	Cavallino-Treporti	VE	M308
11379	Abano Terme	PD	A001
11380	Agna	PD	A075
11381	Albignasego	PD	A161
11382	Anguillara Veneta	PD	A296
11383	Arquà Petrarca	PD	A434
11384	Arre	PD	A438
11385	Arzergrande	PD	A458
11386	Bagnoli di Sopra	PD	A568
11387	Baone	PD	A613
11388	Barbona	PD	A637
11389	Battaglia Terme	PD	A714
11390	Boara Pisani	PD	A906
11391	Borgoricco	PD	B031
11392	Bovolenta	PD	B106
11393	Brugine	PD	B213
11394	Cadoneghe	PD	B345
11395	Campodarsego	PD	B524
11396	Campodoro	PD	B531
11397	Camposampiero	PD	B563
11398	Campo San Martino	PD	B564
11399	Candiana	PD	B589
11400	Carceri	PD	B749
11401	Carmignano di Brenta	PD	B795
11402	Cartura	PD	B848
11403	Casale di Scodosia	PD	B877
11404	Casalserugo	PD	B912
11405	Castelbaldo	PD	C057
11406	Cervarese Santa Croce	PD	C544
11407	Cinto Euganeo	PD	C713
11408	Cittadella	PD	C743
11409	Codevigo	PD	C812
11410	Conselve	PD	C964
11411	Correzzola	PD	D040
11412	Curtarolo	PD	D226
11413	Este	PD	D442
11414	Fontaniva	PD	D679
11415	Galliera Veneta	PD	D879
11416	Galzignano Terme	PD	D889
11417	Gazzo	PD	D956
11418	Grantorto	PD	E145
11419	Granze	PD	E146
11420	Legnaro	PD	E515
11421	Limena	PD	E592
11422	Loreggia	PD	E684
11423	Lozzo Atestino	PD	E709
11424	Maserà di Padova	PD	F011
11425	Masi	PD	F013
11426	Massanzago	PD	F033
11427	Megliadino San Vitale	PD	F092
11428	Merlara	PD	F148
11429	Mestrino	PD	F161
11430	Monselice	PD	F382
11431	Montagnana	PD	F394
11432	Montegrotto Terme	PD	F529
11433	Noventa Padovana	PD	F962
11434	Ospedaletto Euganeo	PD	G167
11435	Padova	PD	G224
11436	Pernumia	PD	G461
11437	Piacenza d'Adige	PD	G534
11438	Piazzola sul Brenta	PD	G587
11439	Piombino Dese	PD	G688
11440	Piove di Sacco	PD	G693
11441	Polverara	PD	G802
11442	Ponso	PD	G823
11443	Pontelongo	PD	G850
11444	Ponte San Nicolò	PD	G855
11445	Pozzonovo	PD	G963
11446	Rovolon	PD	H622
11447	Rubano	PD	H625
11448	Saccolongo	PD	H655
11449	San Giorgio delle Pertiche	PD	H893
11450	San Giorgio in Bosco	PD	H897
11451	San Martino di Lupari	PD	I008
11452	San Pietro in Gu	PD	I107
11453	San Pietro Viminario	PD	I120
11454	Santa Giustina in Colle	PD	I207
11455	Sant'Angelo di Piove di Sacco	PD	I275
11456	Sant'Elena	PD	I319
11457	Sant'Urbano	PD	I375
11458	Saonara	PD	I418
11459	Selvazzano Dentro	PD	I595
11460	Solesino	PD	I799
11461	Stanghella	PD	I938
11462	Teolo	PD	L100
11463	Terrassa Padovana	PD	L132
11464	Tombolo	PD	L199
11465	Torreglia	PD	L270
11466	Trebaseleghe	PD	L349
11467	Tribano	PD	L414
11468	Urbana	PD	L497
11469	Veggiano	PD	L710
11470	Vescovana	PD	L805
11471	Vighizzolo d'Este	PD	L878
11472	Vigodarzere	PD	L892
11473	Vigonza	PD	L900
11474	Villa del Conte	PD	L934
11475	Villa Estense	PD	L937
11476	Villafranca Padovana	PD	L947
11477	Villanova di Camposampiero	PD	L979
11478	Vo'	PD	M103
11479	Due Carrare	PD	M300
11480	Borgo Veneto	PD	M402
11481	Adria	RO	A059
11482	Ariano nel Polesine	RO	A400
11483	Arquà Polesine	RO	A435
11484	Badia Polesine	RO	A539
11485	Bagnolo di Po	RO	A574
11486	Bergantino	RO	A795
11487	Bosaro	RO	B069
11488	Calto	RO	B432
11489	Canaro	RO	B578
11490	Canda	RO	B582
11491	Castelguglielmo	RO	C122
11492	Castelmassa	RO	C207
11493	Castelnovo Bariano	RO	C215
11494	Ceneselli	RO	C461
11495	Ceregnano	RO	C500
11496	Corbola	RO	C987
11497	Costa di Rovigo	RO	D105
11498	Crespino	RO	D161
11499	Ficarolo	RO	D568
11500	Fiesso Umbertiano	RO	D577
11501	Frassinelle Polesine	RO	D776
11502	Fratta Polesine	RO	D788
11503	Gaiba	RO	D855
11504	Gavello	RO	D942
11505	Giacciano con Baruchella	RO	E008
11506	Guarda Veneta	RO	E240
11507	Lendinara	RO	E522
11508	Loreo	RO	E689
11509	Lusia	RO	E761
11510	Melara	RO	F095
11511	Occhiobello	RO	F994
11512	Papozze	RO	G323
11513	Pettorazza Grimani	RO	G525
11514	Pincara	RO	G673
11515	Polesella	RO	G782
11516	Pontecchio Polesine	RO	G836
11517	Porto Tolle	RO	G923
11518	Rosolina	RO	H573
11519	Rovigo	RO	H620
11520	Salara	RO	H689
11521	San Bellino	RO	H768
11522	San Martino di Venezze	RO	H996
11523	Stienta	RO	I953
11524	Taglio di Po	RO	L026
11525	Trecenta	RO	L359
11526	Villadose	RO	L939
11527	Villamarzana	RO	L967
11528	Villanova del Ghebbo	RO	L985
11529	Villanova Marchesana	RO	L988
11530	Porto Viro	RO	G926
11531	Aiello del Friuli	UD	A103
11532	Amaro	UD	A254
11533	Ampezzo	UD	A267
11534	Aquileia	UD	A346
11535	Arta Terme	UD	A447
11536	Artegna	UD	A448
11537	Attimis	UD	A491
11538	Bagnaria Arsa	UD	A553
11539	Basiliano	UD	A700
11540	Bertiolo	UD	A810
11541	Bicinicco	UD	A855
11542	Bordano	UD	A983
11543	Buja	UD	B259
11544	Buttrio	UD	B309
11545	Camino al Tagliamento	UD	B483
11546	Campoformido	UD	B536
11547	Carlino	UD	B788
11548	Cassacco	UD	B994
11549	Castions di Strada	UD	C327
11550	Cavazzo Carnico	UD	C389
11551	Cercivento	UD	C494
11552	Cervignano del Friuli	UD	C556
11553	Chiopris-Viscone	UD	C641
11554	Chiusaforte	UD	C656
11555	Cividale del Friuli	UD	C758
11556	Codroipo	UD	C817
11557	Colloredo di Monte Albano	UD	C885
11558	Comeglians	UD	C918
11559	Corno di Rosazzo	UD	D027
11560	Coseano	UD	D085
11561	Dignano	UD	D300
11562	Dogna	UD	D316
11563	Drenchia	UD	D366
11564	Enemonzo	UD	D408
11565	Faedis	UD	D455
11566	Fagagna	UD	D461
11567	Flaibano	UD	D630
11568	Forni Avoltri	UD	D718
11569	Forni di Sopra	UD	D719
11570	Forni di Sotto	UD	D720
11571	Gemona del Friuli	UD	D962
11572	Gonars	UD	E083
11573	Grimacco	UD	E179
11574	Latisana	UD	E473
11575	Lauco	UD	E476
11576	Lestizza	UD	E553
11577	Lignano Sabbiadoro	UD	E584
11578	Lusevera	UD	E760
11579	Magnano in Riviera	UD	E820
11580	Majano	UD	E833
11581	Malborghetto Valbruna	UD	E847
11582	Manzano	UD	E899
11583	Marano Lagunare	UD	E910
11584	Martignacco	UD	E982
11585	Mereto di Tomba	UD	F144
11586	Moggio Udinese	UD	F266
11587	Moimacco	UD	F275
11588	Montenars	UD	F574
11589	Mortegliano	UD	F756
11590	Moruzzo	UD	F760
11591	Muzzana del Turgnano	UD	F832
11592	Nimis	UD	F898
11593	Osoppo	UD	G163
11594	Ovaro	UD	G198
11595	Pagnacco	UD	G238
11596	Palazzolo dello Stella	UD	G268
11597	Palmanova	UD	G284
11598	Paluzza	UD	G300
11599	Pasian di Prato	UD	G352
11600	Paularo	UD	G381
11601	Pavia di Udine	UD	G389
11602	Pocenia	UD	G743
11603	Pontebba	UD	G831
11604	Porpetto	UD	G891
11605	Povoletto	UD	G949
11606	Pozzuolo del Friuli	UD	G966
11607	Pradamano	UD	G969
11608	Prato Carnico	UD	H002
11609	Precenicco	UD	H014
11610	Premariacco	UD	H029
11611	Preone	UD	H038
11612	Prepotto	UD	H040
11613	Pulfero	UD	H089
11614	Ragogna	UD	H161
11615	Ravascletto	UD	H196
11616	Raveo	UD	H200
11617	Reana del Rojale	UD	H206
11618	Remanzacco	UD	H229
11619	Resia	UD	H242
11620	Resiutta	UD	H244
11621	Rigolato	UD	H289
11622	Rive d'Arcano	UD	H347
11623	Ronchis	UD	H533
11624	Ruda	UD	H629
11625	San Daniele del Friuli	UD	H816
11626	San Giorgio di Nogaro	UD	H895
11627	San Giovanni al Natisone	UD	H906
11628	San Leonardo	UD	H951
11629	San Pietro al Natisone	UD	I092
11630	Santa Maria la Longa	UD	I248
11631	San Vito al Torre	UD	I404
11632	San Vito di Fagagna	UD	I405
11633	Sauris	UD	I464
11634	Savogna	UD	I478
11635	Sedegliano	UD	I562
11636	Socchieve	UD	I777
11637	Stregna	UD	I974
11638	Sutrio	UD	L018
11639	Taipana	UD	G736
11640	Talmassons	UD	L039
11641	Tarcento	UD	L050
11642	Tarvisio	UD	L057
11643	Tavagnacco	UD	L065
11644	Terzo d'Aquileia	UD	L144
11645	Tolmezzo	UD	L195
11646	Torreano	UD	L246
11647	Torviscosa	UD	L309
11648	Trasaghis	UD	L335
11649	Treppo Grande	UD	L382
11650	Tricesimo	UD	L421
11651	Trivignano Udinese	UD	L438
11652	Udine	UD	L483
11653	Varmo	UD	L686
11654	Venzone	UD	L743
11655	Verzegnis	UD	L801
11656	Villa Santina	UD	L909
11657	Visco	UD	M073
11658	Zuglio	UD	M200
11659	Forgaria nel Friuli	UD	D700
11660	Campolongo Tapogliano	UD	M311
11661	Rivignano Teor	UD	M317
11662	Sappada	UD	I421
11663	Fiumicello Villa Vicentina	UD	M400
11664	Treppo Ligosullo	UD	M399
11665	Capriva del Friuli	GO	B712
11666	Cormons	GO	D014
11667	Doberdò del Lago	GO	D312
11668	Dolegna del Collio	GO	D321
11669	Farra d'Isonzo	GO	D504
11670	Fogliano Redipuglia	GO	D645
11671	Gorizia	GO	E098
11672	Gradisca d'Isonzo	GO	E124
11673	Grado	GO	E125
11674	Mariano del Friuli	GO	E952
11675	Medea	GO	F081
11676	Monfalcone	GO	F356
11677	Moraro	GO	F710
11678	Mossa	GO	F767
11679	Romans d'Isonzo	GO	H514
11680	Ronchi dei Legionari	GO	H531
11681	Sagrado	GO	H665
11682	San Canzian d'Isonzo	GO	H787
11683	San Floriano del Collio	GO	H845
11684	San Lorenzo Isontino	GO	H964
11685	San Pier d'Isonzo	GO	I082
11686	Savogna d'Isonzo	GO	I479
11687	Staranzano	GO	I939
11688	Turriaco	GO	L474
11689	Villesse	GO	M043
11690	Duino Aurisina	TS	D383
11691	Monrupino	TS	F378
11692	Muggia	TS	F795
11693	San Dorligo della Valle	TS	D324
11694	Sgonico	TS	I715
11695	Trieste	TS	L424
11696	Andreis	PN	A283
11697	Arba	PN	A354
11698	Aviano	PN	A516
11699	Azzano Decimo	PN	A530
11700	Barcis	PN	A640
11701	Brugnera	PN	B215
11702	Budoia	PN	B247
11703	Caneva	PN	B598
11704	Casarsa della Delizia	PN	B940
11705	Castelnovo del Friuli	PN	C217
11706	Cavasso Nuovo	PN	C385
11707	Chions	PN	C640
11708	Cimolais	PN	C699
11709	Claut	PN	C790
11710	Clauzetto	PN	C791
11711	Cordenons	PN	C991
11712	Cordovado	PN	C993
11713	Erto e Casso	PN	D426
11714	Fanna	PN	D487
11715	Fiume Veneto	PN	D621
11716	Fontanafredda	PN	D670
11717	Frisanco	PN	D804
11718	Maniago	PN	E889
11719	Meduno	PN	F089
11720	Montereale Valcellina	PN	F596
11721	Morsano al Tagliamento	PN	F750
11722	Pasiano di Pordenone	PN	G353
11723	Pinzano al Tagliamento	PN	G680
11724	Polcenigo	PN	G780
11725	Porcia	PN	G886
11726	Pordenone	PN	G888
11727	Prata di Pordenone	PN	G994
11728	Pravisdomini	PN	H010
11729	Roveredo in Piano	PN	H609
11730	Sacile	PN	H657
11731	San Giorgio della Richinvelda	PN	H891
11732	San Martino al Tagliamento	PN	H999
11733	San Quirino	PN	I136
11734	San Vito al Tagliamento	PN	I403
11735	Sequals	PN	I621
11736	Sesto al Reghena	PN	I686
11737	Spilimbergo	PN	I904
11738	Tramonti di Sopra	PN	L324
11739	Tramonti di Sotto	PN	L325
11740	Travesio	PN	L347
11741	Vito d'Asio	PN	M085
11742	Vivaro	PN	M096
11743	Zoppola	PN	M190
11744	Vajont	PN	M265
11745	Valvasone Arzene	PN	M346
11746	Airole	IM	A111
11747	Apricale	IM	A338
11748	Aquila d'Arroscia	IM	A344
11749	Armo	IM	A418
11750	Aurigo	IM	A499
11751	Badalucco	IM	A536
11752	Bajardo	IM	A581
11753	Bordighera	IM	A984
11754	Borghetto d'Arroscia	IM	A993
11755	Borgomaro	IM	B020
11756	Camporosso	IM	B559
11757	Caravonica	IM	B734
11758	Castellaro	IM	C143
11759	Castel Vittorio	IM	C110
11760	Ceriana	IM	C511
11761	Cervo	IM	C559
11762	Cesio	IM	C578
11763	Chiusanico	IM	C657
11764	Chiusavecchia	IM	C660
11765	Cipressa	IM	C718
11766	Civezza	IM	C755
11767	Cosio d'Arroscia	IM	D087
11768	Costarainera	IM	D114
11769	Diano Arentino	IM	D293
11770	Diano Castello	IM	D296
11771	Diano Marina	IM	D297
11772	Diano San Pietro	IM	D298
11773	Dolceacqua	IM	D318
11774	Dolcedo	IM	D319
11775	Imperia	IM	E290
11776	Isolabona	IM	E346
11777	Lucinasco	IM	E719
11778	Mendatica	IM	F123
11779	Molini di Triora	IM	F290
11780	Montegrosso Pian Latte	IM	F528
11781	Olivetta San Michele	IM	G041
11782	Ospedaletti	IM	G164
11783	Perinaldo	IM	G454
11784	Pietrabruna	IM	G607
11785	Pieve di Teco	IM	G632
11786	Pigna	IM	G660
11787	Pompeiana	IM	G814
11788	Pontedassio	IM	G840
11789	Pornassio	IM	G890
11790	Prelà	IM	H027
11791	Ranzo	IM	H180
11792	Rezzo	IM	H257
11793	Riva Ligure	IM	H328
11794	Rocchetta Nervina	IM	H460
11795	San Bartolomeo al Mare	IM	H763
11796	San Biagio della Cima	IM	H780
11797	San Lorenzo al Mare	IM	H957
11798	Sanremo	IM	I138
11799	Santo Stefano al Mare	IM	I365
11800	Seborga	IM	I556
11801	Soldano	IM	I796
11802	Taggia	IM	L024
11803	Terzorio	IM	L146
11804	Triora	IM	L430
11805	Vallebona	IM	L596
11806	Vallecrosia	IM	L599
11807	Vasia	IM	L693
11808	Ventimiglia	IM	L741
11809	Vessalico	IM	L809
11810	Villa Faraldi	IM	L943
11811	Montalto Carpasio	IM	M387
11812	Alassio	SV	A122
11813	Albenga	SV	A145
11814	Albissola Marina	SV	A165
11815	Albisola Superiore	SV	A166
11816	Altare	SV	A226
11817	Andora	SV	A278
11818	Arnasco	SV	A422
11819	Balestrino	SV	A593
11820	Bardineto	SV	A647
11821	Bergeggi	SV	A796
11822	Boissano	SV	A931
11823	Borghetto Santo Spirito	SV	A999
11824	Borgio Verezzi	SV	B005
11825	Bormida	SV	B048
11826	Cairo Montenotte	SV	B369
11827	Calice Ligure	SV	B409
11828	Calizzano	SV	B416
11829	Carcare	SV	B748
11830	Casanova Lerrone	SV	B927
11831	Castelbianco	SV	C063
11832	Castelvecchio di Rocca Barbena	SV	C276
11833	Celle Ligure	SV	C443
11834	Cengio	SV	C463
11835	Ceriale	SV	C510
11836	Cisano sul Neva	SV	C729
11837	Cosseria	SV	D095
11838	Dego	SV	D264
11839	Erli	SV	D424
11840	Finale Ligure	SV	D600
11841	Garlenda	SV	D927
11842	Giustenice	SV	E064
11843	Giusvalla	SV	E066
11844	Laigueglia	SV	E414
11845	Loano	SV	E632
11846	Magliolo	SV	E816
11847	Mallare	SV	E860
11848	Massimino	SV	F046
11849	Millesimo	SV	F213
11850	Mioglia	SV	F226
11851	Murialdo	SV	F813
11852	Nasino	SV	F847
11853	Noli	SV	F926
11854	Onzo	SV	G076
11855	Orco Feglino	SV	D522
11856	Ortovero	SV	G144
11857	Osiglia	SV	G155
11858	Pallare	SV	G281
11859	Piana Crixia	SV	G542
11860	Pietra Ligure	SV	G605
11861	Plodio	SV	G741
11862	Pontinvrea	SV	G866
11863	Quiliano	SV	H126
11864	Rialto	SV	H266
11865	Roccavignale	SV	H452
11866	Sassello	SV	I453
11867	Savona	SV	I480
11868	Spotorno	SV	I926
11869	Stella	SV	I946
11870	Stellanello	SV	I947
11871	Testico	SV	L152
11872	Toirano	SV	L190
11873	Tovo San Giacomo	SV	L315
11874	Urbe	SV	L499
11875	Vado Ligure	SV	L528
11876	Varazze	SV	L675
11877	Vendone	SV	L730
11878	Vezzi Portio	SV	L823
11879	Villanova d'Albenga	SV	L975
11880	Zuccarello	SV	M197
11881	Arenzano	GE	A388
11883	Bargagli	GE	A658
11884	Bogliasco	GE	A922
11885	Borzonasca	GE	B067
11886	Busalla	GE	B282
11887	Camogli	GE	B490
11888	Campo Ligure	GE	B538
11889	Campomorone	GE	B551
11890	Carasco	GE	B726
11891	Casarza Ligure	GE	B939
11892	Casella	GE	B956
11893	Castiglione Chiavarese	GE	C302
11894	Ceranesi	GE	C481
11895	Chiavari	GE	C621
11896	Cicagna	GE	C673
11897	Cogoleto	GE	C823
11898	Cogorno	GE	C826
11899	Coreglia Ligure	GE	C995
11900	Crocefieschi	GE	D175
11901	Davagna	GE	D255
11902	Fascia	GE	D509
11903	Favale di Malvaro	GE	D512
11904	Fontanigorda	GE	D677
11905	Genova	GE	D969
11906	Gorreto	GE	E109
11907	Isola del Cantone	GE	E341
11908	Lavagna	GE	E488
11909	Leivi	GE	E519
11910	Lorsica	GE	E695
11911	Lumarzo	GE	E737
11912	Masone	GE	F020
11913	Mele	GE	F098
11914	Mezzanego	GE	F173
11915	Mignanego	GE	F202
11916	Moconesi	GE	F256
11917	Moneglia	GE	F354
11918	Montebruno	GE	F445
11919	Montoggio	GE	F682
11920	Ne	GE	F858
11921	Neirone	GE	F862
11922	Orero	GE	G093
11923	Pieve Ligure	GE	G646
11924	Portofino	GE	G913
11925	Propata	GE	H073
11926	Rapallo	GE	H183
11927	Recco	GE	H212
11928	Rezzoaglio	GE	H258
11929	Ronco Scrivia	GE	H536
11930	Rondanina	GE	H546
11931	Rossiglione	GE	H581
11932	Rovegno	GE	H599
11933	San Colombano Certenoli	GE	H802
11934	Santa Margherita Ligure	GE	I225
11935	Sant'Olcese	GE	I346
11936	Santo Stefano d'Aveto	GE	I368
11937	Savignone	GE	I475
11938	Serra Riccò	GE	I640
11939	Sestri Levante	GE	I693
11940	Sori	GE	I852
11941	Tiglieto	GE	L167
11942	Torriglia	GE	L298
11943	Tribogna	GE	L416
11944	Uscio	GE	L507
11945	Valbrevenna	GE	L546
11946	Vobbia	GE	M105
11947	Zoagli	GE	M182
11948	Ameglia	SP	A261
11949	Arcola	SP	A373
11950	Beverino	SP	A836
11951	Bolano	SP	A932
11952	Bonassola	SP	A961
11953	Borghetto di Vara	SP	A992
11954	Brugnato	SP	B214
11955	Calice al Cornoviglio	SP	B410
11956	Carro	SP	B838
11957	Carrodano	SP	B839
11958	Castelnuovo Magra	SP	C240
11959	Deiva Marina	SP	D265
11960	Follo	SP	D655
11961	Framura	SP	D758
11962	La Spezia	SP	E463
11963	Lerici	SP	E542
11964	Levanto	SP	E560
11965	Maissana	SP	E842
11966	Monterosso al Mare	SP	F609
11967	Luni	SP	G143
11968	Pignone	SP	G664
11969	Portovenere	SP	G925
11970	Riccò del Golfo di Spezia	SP	H275
11971	Riomaggiore	SP	H304
11972	Rocchetta di Vara	SP	H461
11973	Santo Stefano di Magra	SP	I363
11974	Sarzana	SP	I449
11975	Sesta Godano	SP	E070
11976	Varese Ligure	SP	L681
11977	Vernazza	SP	L774
11978	Vezzano Ligure	SP	L819
11979	Zignago	SP	M177
11980	Agazzano	PC	A067
11981	Alseno	PC	A223
11982	Besenzone	PC	A823
11983	Bettola	PC	A831
11984	Bobbio	PC	A909
11985	Borgonovo Val Tidone	PC	B025
11986	Cadeo	PC	B332
11987	Calendasco	PC	B405
11988	Caorso	PC	B643
11989	Carpaneto Piacentino	PC	B812
11990	Castell'Arquato	PC	C145
11991	Castel San Giovanni	PC	C261
11992	Castelvetro Piacentino	PC	C288
11993	Cerignale	PC	C513
11994	Coli	PC	C838
11995	Corte Brugnatella	PC	D054
11996	Cortemaggiore	PC	D061
11997	Farini	PC	D502
11998	Ferriere	PC	D555
11999	Fiorenzuola d'Arda	PC	D611
12000	Gazzola	PC	D958
12001	Gossolengo	PC	E114
12002	Gragnano Trebbiense	PC	E132
12003	Gropparello	PC	E196
12004	Lugagnano Val d'Arda	PC	E726
12005	Monticelli d'Ongina	PC	F671
12006	Morfasso	PC	F724
12007	Ottone	PC	G195
12008	Piacenza	PC	G535
12009	Pianello Val Tidone	PC	G557
12010	Piozzano	PC	G696
12011	Podenzano	PC	G747
12012	Ponte dell'Olio	PC	G842
12013	Pontenure	PC	G852
12014	Rivergaro	PC	H350
12015	Rottofreno	PC	H593
12016	San Giorgio Piacentino	PC	H887
12017	San Pietro in Cerro	PC	G788
12018	Sarmato	PC	I434
12019	Travo	PC	L348
12020	Vernasca	PC	L772
12021	Vigolzone	PC	L897
12022	Villanova sull'Arda	PC	L980
12023	Zerba	PC	M165
12024	Ziano Piacentino	PC	L848
12025	Alta Val Tidone	PC	M386
12026	Albareto	PR	A138
12027	Bardi	PR	A646
12028	Bedonia	PR	A731
12029	Berceto	PR	A788
12030	Bore	PR	A987
12031	Borgo Val di Taro	PR	B042
12032	Busseto	PR	B293
12033	Calestano	PR	B408
12034	Collecchio	PR	C852
12035	Colorno	PR	C904
12036	Compiano	PR	C934
12037	Corniglio	PR	D026
12038	Felino	PR	D526
12039	Fidenza	PR	B034
12040	Fontanellato	PR	D673
12041	Fontevivo	PR	D685
12042	Fornovo di Taro	PR	D728
12043	Langhirano	PR	E438
12044	Lesignano de' Bagni	PR	E547
12045	Medesano	PR	F082
12046	Monchio delle Corti	PR	F340
12047	Montechiarugolo	PR	F473
12048	Neviano degli Arduini	PR	F882
12049	Noceto	PR	F914
12050	Palanzano	PR	G255
12051	Parma	PR	G337
12052	Pellegrino Parmense	PR	G424
12053	Roccabianca	PR	H384
12054	Sala Baganza	PR	H682
12055	Salsomaggiore Terme	PR	H720
12056	San Secondo Parmense	PR	I153
12057	Solignano	PR	I803
12058	Soragna	PR	I840
12059	Terenzo	PR	E548
12060	Tizzano Val Parma	PR	L183
12061	Tornolo	PR	L229
12062	Torrile	PR	L299
12063	Traversetolo	PR	L346
12064	Valmozzola	PR	L641
12065	Varano de' Melegari	PR	L672
12066	Varsi	PR	L689
12067	Sissa Trecasali	PR	M325
12068	Polesine Zibello	PR	M367
12069	Sorbolo Mezzani	PR	M411
12070	Albinea	RE	A162
12071	Bagnolo in Piano	RE	A573
12072	Baiso	RE	A586
12073	Bibbiano	RE	A850
12074	Boretto	RE	A988
12075	Brescello	RE	B156
12076	Cadelbosco di Sopra	RE	B328
12077	Campagnola Emilia	RE	B499
12078	Campegine	RE	B502
12079	Carpineti	RE	B825
12080	Casalgrande	RE	B893
12081	Casina	RE	B967
12082	Castellarano	RE	C141
12083	Castelnovo di Sotto	RE	C218
12084	Castelnovo ne' Monti	RE	C219
12085	Cavriago	RE	C405
12086	Canossa	RE	C669
12087	Correggio	RE	D037
12088	Fabbrico	RE	D450
12089	Gattatico	RE	D934
12090	Gualtieri	RE	E232
12091	Guastalla	RE	E253
12092	Luzzara	RE	E772
12093	Montecchio Emilia	RE	F463
12094	Novellara	RE	F960
12095	Poviglio	RE	G947
12096	Quattro Castella	RE	H122
12097	Reggiolo	RE	H225
12098	Reggio nell'Emilia	RE	H223
12099	Rio Saliceto	RE	H298
12100	Rolo	RE	H500
12101	Rubiera	RE	H628
12102	San Martino in Rio	RE	I011
12103	San Polo d'Enza	RE	I123
12104	Sant'Ilario d'Enza	RE	I342
12105	Scandiano	RE	I496
12106	Toano	RE	L184
12107	Vetto	RE	L815
12108	Vezzano sul Crostolo	RE	L820
12109	Viano	RE	L831
12110	Villa Minozzo	RE	L969
12111	Ventasso	RE	M364
12112	Bastiglia	MO	A713
12113	Bomporto	MO	A959
12114	Campogalliano	MO	B539
12115	Camposanto	MO	B566
12116	Carpi	MO	B819
12117	Castelfranco Emilia	MO	C107
12118	Castelnuovo Rangone	MO	C242
12119	Castelvetro di Modena	MO	C287
12120	Cavezzo	MO	C398
12121	Concordia sulla Secchia	MO	C951
12122	Fanano	MO	D486
12123	Finale Emilia	MO	D599
12124	Fiorano Modenese	MO	D607
12125	Fiumalbo	MO	D617
12126	Formigine	MO	D711
12127	Frassinoro	MO	D783
12128	Guiglia	MO	E264
12129	Lama Mocogno	MO	E426
12130	Maranello	MO	E904
12131	Marano sul Panaro	MO	E905
12132	Medolla	MO	F087
12133	Mirandola	MO	F240
12134	Modena	MO	F257
12135	Montecreto	MO	F484
12136	Montefiorino	MO	F503
12137	Montese	MO	F642
12138	Nonantola	MO	F930
12139	Novi di Modena	MO	F966
12140	Palagano	MO	G250
12141	Pavullo nel Frignano	MO	G393
12142	Pievepelago	MO	G649
12143	Polinago	MO	G789
12144	Prignano sulla Secchia	MO	H061
12145	Ravarino	MO	H195
12146	Riolunato	MO	H303
12147	San Cesario sul Panaro	MO	H794
12148	San Felice sul Panaro	MO	H835
12149	San Possidonio	MO	I128
12150	San Prospero	MO	I133
12151	Sassuolo	MO	I462
12152	Savignano sul Panaro	MO	I473
12153	Serramazzoni	MO	F357
12154	Sestola	MO	I689
12155	Soliera	MO	I802
12156	Spilamberto	MO	I903
12157	Vignola	MO	L885
12158	Zocca	MO	M183
12159	Anzola dell'Emilia	BO	A324
12160	Argelato	BO	A392
12161	Baricella	BO	A665
12162	Bentivoglio	BO	A785
12163	Bologna	BO	A944
12164	Borgo Tossignano	BO	B044
12165	Budrio	BO	B249
12166	Calderara di Reno	BO	B399
12167	Camugnano	BO	B572
12168	Casalecchio di Reno	BO	B880
12169	Casalfiumanese	BO	B892
12170	Castel d'Aiano	BO	C075
12171	Castel del Rio	BO	C086
12172	Castel di Casio	BO	B969
12173	Castel Guelfo di Bologna	BO	C121
12174	Castello d'Argile	BO	C185
12175	Castel Maggiore	BO	C204
12176	Castel San Pietro Terme	BO	C265
12177	Castenaso	BO	C292
12178	Castiglione dei Pepoli	BO	C296
12179	Crevalcore	BO	D166
12180	Dozza	BO	D360
12181	Fontanelice	BO	D668
12182	Gaggio Montano	BO	D847
12183	Galliera	BO	D878
12184	Granarolo dell'Emilia	BO	E136
12185	Grizzana Morandi	BO	E187
12186	Imola	BO	E289
12187	Lizzano in Belvedere	BO	A771
12188	Loiano	BO	E655
12189	Malalbergo	BO	E844
12190	Marzabotto	BO	B689
12191	Medicina	BO	F083
12192	Minerbio	BO	F219
12193	Molinella	BO	F288
12194	Monghidoro	BO	F363
12195	Monterenzio	BO	F597
12196	Monte San Pietro	BO	F627
12197	Monzuno	BO	F706
12198	Mordano	BO	F718
12199	Ozzano dell'Emilia	BO	G205
12200	Pianoro	BO	G570
12201	Pieve di Cento	BO	G643
12202	Sala Bolognese	BO	H678
12203	San Benedetto Val di Sambro	BO	G566
12204	San Giorgio di Piano	BO	H896
12205	San Giovanni in Persiceto	BO	G467
12206	San Lazzaro di Savena	BO	H945
12207	San Pietro in Casale	BO	I110
12208	Sant'Agata Bolognese	BO	I191
12209	Sasso Marconi	BO	G972
12210	Vergato	BO	L762
12211	Zola Predosa	BO	M185
12212	Valsamoggia	BO	M320
12213	Alto Reno Terme	BO	M369
12214	Argenta	FE	A393
12215	Bondeno	FE	A965
12216	Cento	FE	C469
12217	Codigoro	FE	C814
12218	Comacchio	FE	C912
12219	Copparo	FE	C980
12220	Ferrara	FE	D548
12221	Jolanda di Savoia	FE	E320
12222	Lagosanto	FE	E410
12223	Masi Torello	FE	F016
12224	Mesola	FE	F156
12225	Ostellato	FE	G184
12226	Poggio Renatico	FE	G768
12227	Portomaggiore	FE	G916
12228	Vigarano Mainarda	FE	L868
12229	Voghiera	FE	M110
12230	Goro	FE	E107
12231	Fiscaglia	FE	M323
12232	Terre del Reno	FE	M381
12233	Riva del Po	FE	M410
12234	Tresignana	FE	M409
12235	Alfonsine	RA	A191
12236	Bagnacavallo	RA	A547
12237	Bagnara di Romagna	RA	A551
12238	Brisighella	RA	B188
12239	Casola Valsenio	RA	B982
12240	Castel Bolognese	RA	C065
12241	Cervia	RA	C553
12242	Conselice	RA	C963
12243	Cotignola	RA	D121
12244	Faenza	RA	D458
12245	Fusignano	RA	D829
12246	Lugo	RA	E730
12247	Massa Lombarda	RA	F029
12248	Ravenna	RA	H199
12249	Riolo Terme	RA	H302
12250	Russi	RA	H642
12251	Sant'Agata sul Santerno	RA	I196
12252	Solarolo	RA	I787
12253	Bagno di Romagna	FC	A565
12254	Bertinoro	FC	A809
12255	Borghi	FC	B001
12256	Castrocaro Terme e Terra del Sole	FC	C339
12257	Cesena	FC	C573
12258	Cesenatico	FC	C574
12259	Civitella di Romagna	FC	C777
12260	Dovadola	FC	D357
12261	Forlì	FC	D704
12262	Forlimpopoli	FC	D705
12263	Galeata	FC	D867
12264	Gambettola	FC	D899
12265	Gatteo	FC	D935
12266	Longiano	FC	E675
12267	Meldola	FC	F097
12268	Mercato Saraceno	FC	F139
12269	Modigliana	FC	F259
12270	Montiano	FC	F668
12271	Portico e San Benedetto	FC	G904
12272	Predappio	FC	H017
12273	Premilcuore	FC	H034
12274	Rocca San Casciano	FC	H437
12275	Roncofreddo	FC	H542
12276	San Mauro Pascoli	FC	I027
12277	Santa Sofia	FC	I310
12278	Sarsina	FC	I444
12279	Savignano sul Rubicone	FC	I472
12280	Sogliano al Rubicone	FC	I779
12281	Tredozio	FC	L361
12282	Verghereto	FC	L764
12283	Bellaria-Igea Marina	RN	A747
12284	Cattolica	RN	C357
12285	Coriano	RN	D004
12286	Gemmano	RN	D961
12287	Misano Adriatico	RN	F244
12288	Mondaino	RN	F346
12289	Montefiore Conca	RN	F502
12290	Montegridolfo	RN	F523
12291	Morciano di Romagna	RN	F715
12292	Riccione	RN	H274
12293	Rimini	RN	H294
12294	Saludecio	RN	H724
12295	San Clemente	RN	H801
12296	San Giovanni in Marignano	RN	H921
12297	Santarcangelo di Romagna	RN	I304
12298	Verucchio	RN	L797
12299	Casteldelci	RN	C080
12300	Maiolo	RN	E838
12301	Novafeltria	RN	F137
12302	Pennabilli	RN	G433
12303	San Leo	RN	H949
12304	Sant'Agata Feltria	RN	I201
12305	Talamello	RN	L034
12306	Poggio Torriana	RN	M324
12307	Montescudo-Monte Colombo	RN	M368
12308	Aulla	MS	A496
12309	Bagnone	MS	A576
12310	Carrara	MS	B832
12311	Casola in Lunigiana	MS	B979
12312	Comano	MS	C914
12313	Filattiera	MS	D590
12314	Fivizzano	MS	D629
12315	Fosdinovo	MS	D735
12316	Licciana Nardi	MS	E574
12317	Massa	MS	F023
12318	Montignoso	MS	F679
12319	Mulazzo	MS	F802
12320	Podenzana	MS	G746
12321	Pontremoli	MS	G870
12322	Tresana	MS	L386
12323	Villafranca in Lunigiana	MS	L946
12324	Zeri	MS	M169
12325	Altopascio	LU	A241
12326	Bagni di Lucca	LU	A560
12327	Barga	LU	A657
12328	Borgo a Mozzano	LU	B007
12329	Camaiore	LU	B455
12330	Camporgiano	LU	B557
12331	Capannori	LU	B648
12332	Careggine	LU	B760
12333	Castelnuovo di Garfagnana	LU	C236
12334	Castiglione di Garfagnana	LU	C303
12335	Coreglia Antelminelli	LU	C996
12336	Forte dei Marmi	LU	D730
12337	Fosciandora	LU	D734
12338	Gallicano	LU	D874
12339	Lucca	LU	E715
12340	Massarosa	LU	F035
12341	Minucciano	LU	F225
12342	Molazzana	LU	F283
12343	Montecarlo	LU	F452
12344	Pescaglia	LU	G480
12345	Piazza al Serchio	LU	G582
12346	Pietrasanta	LU	G628
12347	Pieve Fosciana	LU	G648
12348	Porcari	LU	G882
12349	San Romano in Garfagnana	LU	I142
12350	Seravezza	LU	I622
12351	Stazzema	LU	I942
12352	Vagli Sotto	LU	L533
12353	Viareggio	LU	L833
12354	Villa Basilica	LU	L913
12355	Villa Collemandina	LU	L926
12356	Fabbriche di Vergemoli	LU	M319
12357	Sillano Giuncugnano	LU	M347
12358	Agliana	PT	A071
12359	Buggiano	PT	B251
12360	Lamporecchio	PT	E432
12361	Larciano	PT	E451
12362	Marliana	PT	E960
12363	Massa e Cozzile	PT	F025
12364	Monsummano Terme	PT	F384
12365	Montale	PT	F410
12366	Montecatini-Terme	PT	A561
12367	Pescia	PT	G491
12368	Pieve a Nievole	PT	G636
12369	Pistoia	PT	G713
12370	Ponte Buggianese	PT	G833
12371	Quarrata	PT	H109
12372	Sambuca Pistoiese	PT	H744
12373	Serravalle Pistoiese	PT	I660
12374	Uzzano	PT	L522
12375	Chiesina Uzzanese	PT	C631
12376	Abetone Cutigliano	PT	M376
12377	San Marcello Piteglio	PT	M377
12378	Bagno a Ripoli	FI	A564
12379	Barberino di Mugello	FI	A632
12380	Borgo San Lorenzo	FI	B036
12381	Calenzano	FI	B406
12382	Campi Bisenzio	FI	B507
12383	Capraia e Limite	FI	B684
12384	Castelfiorentino	FI	C101
12385	Cerreto Guidi	FI	C529
12386	Certaldo	FI	C540
12387	Dicomano	FI	D299
12388	Empoli	FI	D403
12389	Fiesole	FI	D575
12390	Firenze	FI	D612
12391	Firenzuola	FI	D613
12392	Fucecchio	FI	D815
12393	Gambassi Terme	FI	D895
12394	Greve in Chianti	FI	E169
12395	Impruneta	FI	E291
12396	Lastra a Signa	FI	E466
12397	Londa	FI	E668
12398	Marradi	FI	E971
12399	Montaione	FI	F398
12400	Montelupo Fiorentino	FI	F551
12401	Montespertoli	FI	F648
12402	Palazzuolo sul Senio	FI	G270
12403	Pelago	FI	G420
12404	Pontassieve	FI	G825
12405	Reggello	FI	H222
12406	Rignano sull'Arno	FI	H286
12407	Rufina	FI	H635
12408	San Casciano in Val di Pesa	FI	H791
12409	San Godenzo	FI	H937
12410	Scandicci	FI	B962
12411	Sesto Fiorentino	FI	I684
12412	Signa	FI	I728
12413	Vaglia	FI	L529
12414	Vicchio	FI	L838
12415	Vinci	FI	M059
12416	Figline e Incisa Valdarno	FI	M321
12417	Scarperia e San Piero	FI	M326
12418	Barberino Tavarnelle	FI	M408
12419	Bibbona	LI	A852
12420	Campiglia Marittima	LI	B509
12421	Campo nell'Elba	LI	B553
12422	Capoliveri	LI	B669
12423	Capraia Isola	LI	B685
12424	Castagneto Carducci	LI	C044
12425	Cecina	LI	C415
12426	Collesalvetti	LI	C869
12427	Livorno	LI	E625
12428	Marciana	LI	E930
12429	Marciana Marina	LI	E931
12430	Piombino	LI	G687
12431	Porto Azzurro	LI	E680
12432	Portoferraio	LI	G912
12433	Rosignano Marittimo	LI	H570
12434	San Vincenzo	LI	I390
12435	Sassetta	LI	I454
12436	Suvereto	LI	L019
12437	Rio	LI	M391
12438	Bientina	PI	A864
12439	Buti	PI	B303
12440	Calci	PI	B390
12441	Calcinaia	PI	B392
12442	Capannoli	PI	B647
12443	Casale Marittimo	PI	B878
12444	Cascina	PI	B950
12445	Castelfranco di Sotto	PI	C113
12446	Castellina Marittima	PI	C174
12447	Castelnuovo di Val di Cecina	PI	C244
12448	Chianni	PI	C609
12449	Fauglia	PI	D510
12450	Guardistallo	PI	E250
12451	Lajatico	PI	E413
12452	Montecatini Val di Cecina	PI	F458
12453	Montescudaio	PI	F640
12454	Monteverdi Marittimo	PI	F661
12455	Montopoli in Val d'Arno	PI	F686
12456	Orciano Pisano	PI	G090
12457	Palaia	PI	G254
12458	Peccioli	PI	G395
12459	Pisa	PI	G702
12460	Pomarance	PI	G804
12461	Ponsacco	PI	G822
12462	Pontedera	PI	G843
12463	Riparbella	PI	H319
12464	San Giuliano Terme	PI	A562
12465	San Miniato	PI	I046
12466	Santa Croce sull'Arno	PI	I177
12467	Santa Luce	PI	I217
12468	Santa Maria a Monte	PI	I232
12469	Terricciola	PI	L138
12470	Vecchiano	PI	L702
12471	Vicopisano	PI	L850
12472	Volterra	PI	M126
12473	Casciana Terme Lari	PI	M327
12474	Crespina Lorenzana	PI	M328
12475	Anghiari	AR	A291
12476	Arezzo	AR	A390
12477	Badia Tedalda	AR	A541
12478	Bibbiena	AR	A851
12479	Bucine	AR	B243
12480	Capolona	AR	B670
12481	Caprese Michelangelo	AR	B693
12482	Castel Focognano	AR	C102
12483	Castel San Niccolò	AR	C263
12484	Castiglion Fibocchi	AR	C318
12485	Castiglion Fiorentino	AR	C319
12486	Cavriglia	AR	C407
12487	Chitignano	AR	C648
12488	Chiusi della Verna	AR	C663
12489	Civitella in Val di Chiana	AR	C774
12490	Cortona	AR	D077
12491	Foiano della Chiana	AR	D649
12492	Loro Ciuffenna	AR	E693
12493	Lucignano	AR	E718
12494	Marciano della Chiana	AR	E933
12495	Montemignaio	AR	F565
12496	Monterchi	AR	F594
12497	Monte San Savino	AR	F628
12498	Montevarchi	AR	F656
12499	Ortignano Raggiolo	AR	G139
12500	Pieve Santo Stefano	AR	G653
12501	Poppi	AR	G879
12502	San Giovanni Valdarno	AR	H901
12503	Sansepolcro	AR	I155
12504	Sestino	AR	I681
12505	Subbiano	AR	I991
12506	Talla	AR	L038
12507	Terranuova Bracciolini	AR	L123
12508	Castelfranco Piandiscò	AR	M322
12509	Pratovecchio Stia	AR	M329
12510	Laterina Pergine Valdarno	AR	M392
12511	Abbadia San Salvatore	SI	A006
12512	Asciano	SI	A461
12513	Buonconvento	SI	B269
12514	Casole d'Elsa	SI	B984
12515	Castellina in Chianti	SI	C172
12516	Castelnuovo Berardenga	SI	C227
12517	Castiglione d'Orcia	SI	C313
12518	Cetona	SI	C587
12519	Chianciano Terme	SI	C608
12520	Chiusdino	SI	C661
12521	Chiusi	SI	C662
12522	Colle di Val d'Elsa	SI	C847
12523	Gaiole in Chianti	SI	D858
12524	Montepulciano	SI	F592
12525	Monteriggioni	SI	F598
12526	Monteroni d'Arbia	SI	F605
12527	Monticiano	SI	F676
12528	Murlo	SI	F815
12529	Piancastagnaio	SI	G547
12530	Pienza	SI	G602
12531	Poggibonsi	SI	G752
12532	Radda in Chianti	SI	H153
12533	Radicofani	SI	H156
12534	Radicondoli	SI	H157
12535	Rapolano Terme	SI	H185
12536	San Casciano dei Bagni	SI	H790
12537	San Gimignano	SI	H875
12538	San Quirico d'Orcia	SI	I135
12539	Sarteano	SI	I445
12540	Siena	SI	I726
12541	Sinalunga	SI	A468
12542	Sovicille	SI	I877
12543	Torrita di Siena	SI	L303
12544	Trequanda	SI	L384
12545	Montalcino	SI	M378
12546	Arcidosso	GR	A369
12547	Campagnatico	GR	B497
12548	Capalbio	GR	B646
12549	Castel del Piano	GR	C085
12550	Castell'Azzara	GR	C147
12551	Castiglione della Pescaia	GR	C310
12552	Cinigiano	GR	C705
12553	Civitella Paganico	GR	C782
12554	Follonica	GR	D656
12555	Gavorrano	GR	D948
12556	Grosseto	GR	E202
12557	Isola del Giglio	GR	E348
12558	Magliano in Toscana	GR	E810
12559	Manciano	GR	E875
12560	Massa Marittima	GR	F032
12561	Monte Argentario	GR	F437
12562	Montieri	GR	F677
12563	Orbetello	GR	G088
12564	Pitigliano	GR	G716
12565	Roccalbegna	GR	H417
12566	Roccastrada	GR	H449
12567	Santa Fiora	GR	I187
12568	Scansano	GR	I504
12569	Scarlino	GR	I510
12570	Seggiano	GR	I571
12571	Sorano	GR	I841
12572	Monterotondo Marittimo	GR	F612
12573	Semproniano	GR	I601
12574	Cantagallo	PO	B626
12575	Carmignano	PO	B794
12576	Montemurlo	PO	F572
12577	Poggio a Caiano	PO	G754
12578	Prato	PO	G999
12579	Vaiano	PO	L537
12580	Vernio	PO	L775
12581	Assisi	PG	A475
12582	Bastia Umbra	PG	A710
12583	Bettona	PG	A832
12584	Bevagna	PG	A835
12585	Campello sul Clitunno	PG	B504
12586	Cannara	PG	B609
12587	Cascia	PG	B948
12588	Castel Ritaldi	PG	C252
12589	Castiglione del Lago	PG	C309
12590	Cerreto di Spoleto	PG	C527
12591	Citerna	PG	C742
12592	Città della Pieve	PG	C744
12593	Città di Castello	PG	C745
12594	Collazzone	PG	C845
12595	Corciano	PG	C990
12596	Costacciaro	PG	D108
12597	Deruta	PG	D279
12598	Foligno	PG	D653
12599	Fossato di Vico	PG	D745
12600	Fratta Todina	PG	D787
12601	Giano dell'Umbria	PG	E012
12602	Gualdo Cattaneo	PG	E229
12603	Gualdo Tadino	PG	E230
12604	Gubbio	PG	E256
12605	Lisciano Niccone	PG	E613
12606	Magione	PG	E805
12607	Marsciano	PG	E975
12608	Massa Martana	PG	F024
12609	Monte Castello di Vibio	PG	F456
12610	Montefalco	PG	F492
12611	Monteleone di Spoleto	PG	F540
12612	Monte Santa Maria Tiberina	PG	F629
12613	Montone	PG	F685
12614	Nocera Umbra	PG	F911
12615	Norcia	PG	F935
12616	Paciano	PG	G212
12617	Panicale	PG	G308
12618	Passignano sul Trasimeno	PG	G359
12619	Perugia	PG	G478
12620	Piegaro	PG	G601
12621	Pietralunga	PG	G618
12622	Poggiodomo	PG	G758
12623	Preci	PG	H015
12624	San Giustino	PG	H935
12625	Sant'Anatolia di Narco	PG	I263
12626	Scheggia e Pascelupo	PG	I522
12627	Scheggino	PG	I523
12628	Sellano	PG	I585
12629	Sigillo	PG	I727
12630	Spello	PG	I888
12631	Spoleto	PG	I921
12632	Todi	PG	L188
12633	Torgiano	PG	L216
12634	Trevi	PG	L397
12635	Tuoro sul Trasimeno	PG	L466
12636	Umbertide	PG	D786
12637	Valfabbrica	PG	L573
12638	Vallo di Nera	PG	L627
12639	Valtopina	PG	L653
12640	Acquasparta	TR	A045
12641	Allerona	TR	A207
12642	Alviano	TR	A242
12643	Amelia	TR	A262
12644	Arrone	TR	A439
12645	Attigliano	TR	A490
12646	Baschi	TR	A691
12647	Calvi dell'Umbria	TR	B446
12648	Castel Giorgio	TR	C117
12649	Castel Viscardo	TR	C289
12650	Fabro	TR	D454
12651	Ferentillo	TR	D538
12652	Ficulle	TR	D570
12653	Giove	TR	E045
12654	Guardea	TR	E241
12655	Lugnano in Teverina	TR	E729
12656	Montecastrilli	TR	F457
12657	Montecchio	TR	F462
12658	Montefranco	TR	F510
12659	Montegabbione	TR	F513
12660	Monteleone d'Orvieto	TR	F543
12661	Narni	TR	F844
12662	Orvieto	TR	G148
12663	Otricoli	TR	G189
12664	Parrano	TR	G344
12665	Penna in Teverina	TR	G432
12666	Polino	TR	G790
12667	Porano	TR	G881
12668	San Gemini	TR	H857
12669	San Venanzo	TR	I381
12670	Stroncone	TR	I981
12671	Terni	TR	L117
12672	Avigliano Umbro	TR	M258
12673	Acqualagna	PU	A035
12674	Apecchio	PU	A327
12675	Belforte all'Isauro	PU	A740
12676	Borgo Pace	PU	B026
12677	Cagli	PU	B352
12678	Cantiano	PU	B636
12679	Carpegna	PU	B816
12680	Cartoceto	PU	B846
12681	Fano	PU	D488
12682	Fermignano	PU	D541
12683	Fossombrone	PU	D749
12684	Fratte Rosa	PU	D791
12685	Frontino	PU	D807
12686	Frontone	PU	D808
12687	Gabicce Mare	PU	D836
12688	Gradara	PU	E122
12689	Isola del Piano	PU	E351
12690	Lunano	PU	E743
12691	Macerata Feltria	PU	E785
12692	Mercatello sul Metauro	PU	F135
12693	Mercatino Conca	PU	F136
12694	Mombaroccio	PU	F310
12695	Mondavio	PU	F347
12696	Mondolfo	PU	F348
12697	Montecalvo in Foglia	PU	F450
12698	Monte Cerignone	PU	F467
12699	Monteciccardo	PU	F474
12700	Montecopiolo	PU	F478
12701	Montefelcino	PU	F497
12702	Monte Grimano Terme	PU	F524
12703	Montelabbate	PU	F533
12704	Monte Porzio	PU	F589
12705	Peglio	PU	G416
12706	Pergola	PU	G453
12707	Pesaro	PU	G479
12708	Petriano	PU	G514
12709	Piandimeleto	PU	G551
12710	Pietrarubbia	PU	G627
12711	Piobbico	PU	G682
12712	San Costanzo	PU	H809
12713	San Lorenzo in Campo	PU	H958
12714	Sant'Angelo in Vado	PU	I287
12715	Sant'Ippolito	PU	I344
12716	Sassofeltrio	PU	I460
12717	Serra Sant'Abbondio	PU	I654
12718	Tavoleto	PU	L078
12719	Tavullia	PU	L081
12720	Urbania	PU	L498
12721	Urbino	PU	L500
12722	Vallefoglia	PU	M331
12723	Colli al Metauro	PU	M380
12724	Terre Roveresche	PU	M379
12725	Sassocorvaro Auditore	PU	M413
12726	Agugliano	AN	A092
12727	Ancona	AN	A271
12728	Arcevia	AN	A366
12729	Barbara	AN	A626
12730	Belvedere Ostrense	AN	A769
12731	Camerano	AN	B468
12732	Camerata Picena	AN	B470
12733	Castelbellino	AN	C060
12734	Castelfidardo	AN	C100
12735	Castelleone di Suasa	AN	C152
12736	Castelplanio	AN	C248
12737	Cerreto d'Esi	AN	C524
12738	Chiaravalle	AN	C615
12739	Corinaldo	AN	D007
12740	Cupramontana	AN	D211
12741	Fabriano	AN	D451
12742	Falconara Marittima	AN	D472
12743	Filottrano	AN	D597
12744	Genga	AN	D965
12745	Jesi	AN	E388
12746	Loreto	AN	E690
12747	Maiolati Spontini	AN	E837
12748	Mergo	AN	F145
12749	Monsano	AN	F381
12750	Montecarotto	AN	F453
12751	Montemarciano	AN	F560
12752	Monte Roberto	AN	F600
12753	Monte San Vito	AN	F634
12754	Morro d'Alba	AN	F745
12755	Numana	AN	F978
12756	Offagna	AN	G003
12757	Osimo	AN	G157
12758	Ostra	AN	F401
12759	Ostra Vetere	AN	F581
12760	Poggio San Marcello	AN	G771
12761	Polverigi	AN	G803
12762	Rosora	AN	H575
12763	San Marcello	AN	H979
12764	San Paolo di Jesi	AN	I071
12765	Santa Maria Nuova	AN	I251
12766	Sassoferrato	AN	I461
12767	Senigallia	AN	I608
12768	Serra de' Conti	AN	I643
12769	Serra San Quirico	AN	I653
12770	Sirolo	AN	I758
12771	Staffolo	AN	I932
12772	Trecastelli	AN	M318
12773	Apiro	MC	A329
12774	Appignano	MC	A334
12775	Belforte del Chienti	MC	A739
12776	Bolognola	MC	A947
12777	Caldarola	MC	B398
12778	Camerino	MC	B474
12779	Camporotondo di Fiastrone	MC	B562
12780	Castelraimondo	MC	C251
12781	Castelsantangelo sul Nera	MC	C267
12782	Cessapalombo	MC	C582
12783	Cingoli	MC	C704
12784	Civitanova Marche	MC	C770
12785	Colmurano	MC	C886
12786	Corridonia	MC	D042
12787	Esanatoglia	MC	D429
12788	Fiastra	MC	D564
12789	Fiuminata	MC	D628
12790	Gagliole	MC	D853
12791	Gualdo	MC	E228
12792	Loro Piceno	MC	E694
12793	Macerata	MC	E783
12794	Matelica	MC	F051
12795	Mogliano	MC	F268
12796	Montecassiano	MC	F454
12797	Monte Cavallo	MC	F460
12798	Montecosaro	MC	F482
12799	Montefano	MC	F496
12800	Montelupone	MC	F552
12801	Monte San Giusto	MC	F621
12802	Monte San Martino	MC	F622
12803	Morrovalle	MC	F749
12804	Muccia	MC	F793
12805	Penna San Giovanni	MC	G436
12806	Petriolo	MC	G515
12807	Pieve Torina	MC	G657
12808	Pioraco	MC	G690
12809	Poggio San Vicino	MC	D566
12810	Pollenza	MC	F567
12811	Porto Recanati	MC	G919
12812	Potenza Picena	MC	F632
12813	Recanati	MC	H211
12814	Ripe San Ginesio	MC	H323
12815	San Ginesio	MC	H876
12816	San Severino Marche	MC	I156
12817	Sant'Angelo in Pontano	MC	I286
12818	Sarnano	MC	I436
12819	Sefro	MC	I569
12820	Serrapetrona	MC	I651
12821	Serravalle di Chienti	MC	I661
12822	Tolentino	MC	L191
12823	Treia	MC	L366
12824	Urbisaglia	MC	L501
12825	Ussita	MC	L517
12826	Visso	MC	M078
12827	Valfornace	MC	M382
12828	Acquasanta Terme	AP	A044
12829	Acquaviva Picena	AP	A047
12830	Appignano del Tronto	AP	A335
12831	Arquata del Tronto	AP	A437
12832	Ascoli Piceno	AP	A462
12833	Carassai	AP	B727
12834	Castel di Lama	AP	C093
12835	Castignano	AP	C321
12836	Castorano	AP	C331
12837	Colli del Tronto	AP	C877
12838	Comunanza	AP	C935
12839	Cossignano	AP	D096
12840	Cupra Marittima	AP	D210
12841	Folignano	AP	D652
12842	Force	AP	D691
12843	Grottammare	AP	E207
12844	Maltignano	AP	E868
12845	Massignano	AP	F044
12846	Monsampolo del Tronto	AP	F380
12847	Montalto delle Marche	AP	F415
12848	Montedinove	AP	F487
12849	Montefiore dell'Aso	AP	F501
12850	Montegallo	AP	F516
12851	Montemonaco	AP	F570
12852	Monteprandone	AP	F591
12853	Offida	AP	G005
12854	Palmiano	AP	G289
12855	Ripatransone	AP	H321
12856	Roccafluvione	AP	H390
12857	Rotella	AP	H588
12858	San Benedetto del Tronto	AP	H769
12859	Spinetoli	AP	I912
12860	Venarotta	AP	L728
12861	Altidona	FM	A233
12862	Amandola	FM	A252
12863	Belmonte Piceno	FM	A760
12864	Campofilone	FM	B534
12865	Falerone	FM	D477
12866	Fermo	FM	D542
12867	Francavilla d'Ete	FM	D760
12868	Grottazzolina	FM	E208
12869	Lapedona	FM	E447
12870	Magliano di Tenna	FM	E807
12871	Massa Fermana	FM	F021
12872	Monsampietro Morico	FM	F379
12873	Montappone	FM	F428
12874	Montefalcone Appennino	FM	F493
12875	Montefortino	FM	F509
12876	Monte Giberto	FM	F517
12877	Montegiorgio	FM	F520
12878	Montegranaro	FM	F522
12879	Monteleone di Fermo	FM	F536
12880	Montelparo	FM	F549
12881	Monte Rinaldo	FM	F599
12882	Monterubbiano	FM	F614
12883	Monte San Pietrangeli	FM	F626
12884	Monte Urano	FM	F653
12885	Monte Vidon Combatte	FM	F664
12886	Monte Vidon Corrado	FM	F665
12887	Montottone	FM	F697
12888	Moresco	FM	F722
12889	Ortezzano	FM	G137
12890	Pedaso	FM	G403
12891	Petritoli	FM	G516
12892	Ponzano di Fermo	FM	G873
12893	Porto San Giorgio	FM	G920
12894	Porto Sant'Elpidio	FM	G921
12895	Rapagnano	FM	H182
12896	Santa Vittoria in Matenano	FM	I315
12897	Sant'Elpidio a Mare	FM	I324
12898	Servigliano	FM	C070
12899	Smerillo	FM	I774
12900	Torre San Patrizio	FM	L279
12901	Acquapendente	VT	A040
12902	Arlena di Castro	VT	A412
12903	Bagnoregio	VT	A577
12904	Barbarano Romano	VT	A628
12905	Bassano Romano	VT	A704
12906	Bassano in Teverina	VT	A706
12907	Blera	VT	A857
12908	Bolsena	VT	A949
12909	Bomarzo	VT	A955
12910	Calcata	VT	B388
12911	Canepina	VT	B597
12912	Canino	VT	B604
12913	Capodimonte	VT	B663
12914	Capranica	VT	B688
12915	Caprarola	VT	B691
12916	Carbognano	VT	B735
12917	Castel Sant'Elia	VT	C269
12918	Castiglione in Teverina	VT	C315
12919	Celleno	VT	C446
12920	Cellere	VT	C447
12921	Civita Castellana	VT	C765
12922	Civitella d'Agliano	VT	C780
12923	Corchiano	VT	C988
12924	Fabrica di Roma	VT	D452
12925	Faleria	VT	D475
12926	Farnese	VT	D503
12927	Gallese	VT	D870
12928	Gradoli	VT	E126
12929	Graffignano	VT	E128
12930	Grotte di Castro	VT	E210
12931	Ischia di Castro	VT	E330
12932	Latera	VT	E467
12933	Lubriano	VT	E713
12934	Marta	VT	E978
12935	Montalto di Castro	VT	F419
12936	Montefiascone	VT	F499
12937	Monte Romano	VT	F603
12938	Monterosi	VT	F606
12939	Nepi	VT	F868
12940	Onano	VT	G065
12941	Oriolo Romano	VT	G111
12942	Orte	VT	G135
12943	Piansano	VT	G571
12944	Proceno	VT	H071
12945	Ronciglione	VT	H534
12946	Villa San Giovanni in Tuscia	VT	H913
12947	San Lorenzo Nuovo	VT	H969
12948	Soriano nel Cimino	VT	I855
12949	Sutri	VT	L017
12950	Tarquinia	VT	D024
12951	Tessennano	VT	L150
12952	Tuscania	VT	L310
12953	Valentano	VT	L569
12954	Vallerano	VT	L612
12955	Vasanello	VT	A701
12956	Vejano	VT	L713
12957	Vetralla	VT	L814
12958	Vignanello	VT	L882
12959	Viterbo	VT	M082
12960	Vitorchiano	VT	M086
12961	Accumoli	RI	A019
12962	Amatrice	RI	A258
12963	Antrodoco	RI	A315
12964	Ascrea	RI	A464
12965	Belmonte in Sabina	RI	A765
12966	Borbona	RI	A981
12967	Borgorose	RI	B008
12968	Borgo Velino	RI	A996
12969	Cantalice	RI	B627
12970	Cantalupo in Sabina	RI	B631
12971	Casaprota	RI	B934
12972	Casperia	RI	A472
12973	Castel di Tora	RI	C098
12974	Castelnuovo di Farfa	RI	C224
12975	Castel Sant'Angelo	RI	C268
12976	Cittaducale	RI	C746
12977	Cittareale	RI	C749
12978	Collalto Sabino	RI	C841
12979	Colle di Tora	RI	C857
12980	Collegiove	RI	C859
12981	Collevecchio	RI	C876
12982	Colli sul Velino	RI	C880
12983	Concerviano	RI	C946
12984	Configni	RI	C959
12985	Contigliano	RI	C969
12986	Cottanello	RI	D124
12987	Fara in Sabina	RI	D493
12988	Fiamignano	RI	D560
12989	Forano	RI	D689
12990	Frasso Sabino	RI	D785
12991	Greccio	RI	E160
12992	Labro	RI	E393
12993	Leonessa	RI	E535
12994	Longone Sabino	RI	E681
12995	Magliano Sabina	RI	E812
12996	Marcetelli	RI	E927
12997	Micigliano	RI	F193
12998	Mompeo	RI	F319
12999	Montasola	RI	F430
13000	Montebuono	RI	F446
13001	Monteleone Sabino	RI	F541
13002	Montenero Sabino	RI	F579
13003	Monte San Giovanni in Sabina	RI	F619
13004	Montopoli di Sabina	RI	F687
13005	Morro Reatino	RI	F746
13006	Nespolo	RI	F876
13007	Orvinio	RI	B595
13008	Paganico Sabino	RI	G232
13009	Pescorocchiano	RI	G498
13010	Petrella Salto	RI	G513
13011	Poggio Bustone	RI	G756
13012	Poggio Catino	RI	G757
13013	Poggio Mirteto	RI	G763
13014	Poggio Moiano	RI	G764
13015	Poggio Nativo	RI	G765
13016	Poggio San Lorenzo	RI	G770
13017	Posta	RI	G934
13018	Pozzaglia Sabina	RI	G951
13019	Rieti	RI	H282
13020	Rivodutri	RI	H354
13021	Roccantica	RI	H427
13022	Rocca Sinibalda	RI	H446
13023	Salisano	RI	H713
13024	Scandriglia	RI	I499
13025	Selci	RI	I581
13026	Stimigliano	RI	I959
13027	Tarano	RI	L046
13028	Toffia	RI	L189
13029	Torricella in Sabina	RI	L293
13030	Torri in Sabina	RI	L286
13031	Turania	RI	G507
13032	Vacone	RI	L525
13033	Varco Sabino	RI	L676
13034	Affile	RM	A062
13035	Agosta	RM	A084
13036	Albano Laziale	RM	A132
13037	Allumiere	RM	A210
13038	Anguillara Sabazia	RM	A297
13039	Anticoli Corrado	RM	A309
13040	Anzio	RM	A323
13041	Arcinazzo Romano	RM	A370
13042	Ariccia	RM	A401
13043	Arsoli	RM	A446
13044	Artena	RM	A449
13045	Bellegra	RM	A749
13046	Bracciano	RM	B114
13047	Camerata Nuova	RM	B472
13048	Campagnano di Roma	RM	B496
13049	Canale Monterano	RM	B576
13050	Canterano	RM	B635
13051	Capena	RM	B649
13052	Capranica Prenestina	RM	B687
13053	Carpineto Romano	RM	B828
13054	Casape	RM	B932
13055	Castel Gandolfo	RM	C116
13056	Castel Madama	RM	C203
13057	Castelnuovo di Porto	RM	C237
13058	Castel San Pietro Romano	RM	C266
13059	Cave	RM	C390
13060	Cerreto Laziale	RM	C518
13061	Cervara di Roma	RM	C543
13062	Cerveteri	RM	C552
13063	Ciciliano	RM	C677
13064	Cineto Romano	RM	C702
13065	Civitavecchia	RM	C773
13066	Civitella San Paolo	RM	C784
13067	Colleferro	RM	C858
13068	Colonna	RM	C900
13069	Fiano Romano	RM	D561
13070	Filacciano	RM	D586
13071	Formello	RM	D707
13072	Frascati	RM	D773
13073	Gallicano nel Lazio	RM	D875
13074	Gavignano	RM	D945
13075	Genazzano	RM	D964
13076	Genzano di Roma	RM	D972
13077	Gerano	RM	D978
13078	Gorga	RM	E091
13079	Grottaferrata	RM	E204
13080	Guidonia Montecelio	RM	E263
13081	Jenne	RM	E382
13082	Labico	RM	E392
13083	Lanuvio	RM	C767
13084	Licenza	RM	E576
13085	Magliano Romano	RM	E813
13086	Mandela	RM	B632
13087	Manziana	RM	E900
13088	Marano Equo	RM	E908
13089	Marcellina	RM	E924
13090	Marino	RM	E958
13091	Mazzano Romano	RM	F064
13092	Mentana	RM	F127
13093	Monte Compatri	RM	F477
13094	Monteflavio	RM	F504
13095	Montelanico	RM	F534
13096	Montelibretti	RM	F545
13097	Monte Porzio Catone	RM	F590
13098	Monterotondo	RM	F611
13099	Montorio Romano	RM	F692
13100	Moricone	RM	F730
13101	Morlupo	RM	F734
13102	Nazzano	RM	F857
13103	Nemi	RM	F865
13104	Nerola	RM	F871
13105	Nettuno	RM	F880
13106	Olevano Romano	RM	G022
13107	Palestrina	RM	G274
13108	Palombara Sabina	RM	G293
13109	Percile	RM	G444
13110	Pisoniano	RM	G704
13111	Poli	RM	G784
13112	Pomezia	RM	G811
13113	Ponzano Romano	RM	G874
13114	Riano	RM	H267
13115	Rignano Flaminio	RM	H288
13116	Riofreddo	RM	H300
13117	Rocca Canterano	RM	H387
13118	Rocca di Cave	RM	H401
13119	Rocca di Papa	RM	H404
13120	Roccagiovine	RM	H411
13121	Rocca Priora	RM	H432
13122	Rocca Santo Stefano	RM	H441
13123	Roiate	RM	H494
13124	Roma	RM	H501
13125	Roviano	RM	H618
13126	Sacrofano	RM	H658
13127	Sambuci	RM	H745
13128	San Gregorio da Sassola	RM	H942
13129	San Polo dei Cavalieri	RM	I125
13130	Santa Marinella	RM	I255
13131	Sant'Angelo Romano	RM	I284
13132	Sant'Oreste	RM	I352
13133	San Vito Romano	RM	I400
13134	Saracinesco	RM	I424
13135	Segni	RM	I573
13136	Subiaco	RM	I992
13137	Tivoli	RM	L182
13138	Tolfa	RM	L192
13139	Torrita Tiberina	RM	L302
13140	Trevignano Romano	RM	L401
13141	Vallepietra	RM	L611
13142	Vallinfreda	RM	L625
13143	Valmontone	RM	L639
13144	Velletri	RM	L719
13145	Vicovaro	RM	L851
13146	Vivaro Romano	RM	M095
13147	Zagarolo	RM	M141
13148	Lariano	RM	M207
13149	Ladispoli	RM	M212
13150	Ardea	RM	M213
13151	Ciampino	RM	M272
13152	San Cesareo	RM	M295
13153	Fiumicino	RM	M297
13154	Fonte Nuova	RM	M309
13155	Aprilia	LT	A341
13156	Bassiano	LT	A707
13157	Campodimele	LT	B527
13158	Castelforte	LT	C104
13159	Cisterna di Latina	LT	C740
13160	Cori	LT	D003
13161	Fondi	LT	D662
13162	Formia	LT	D708
13163	Gaeta	LT	D843
13164	Itri	LT	E375
13165	Latina	LT	E472
13166	Lenola	LT	E527
13167	Maenza	LT	E798
13168	Minturno	LT	F224
13169	Monte San Biagio	LT	F616
13170	Norma	LT	F937
13171	Pontinia	LT	G865
13172	Ponza	LT	G871
13173	Priverno	LT	G698
13174	Prossedi	LT	H076
13175	Roccagorga	LT	H413
13176	Rocca Massima	LT	H421
13177	Roccasecca dei Volsci	LT	H444
13178	Sabaudia	LT	H647
13179	San Felice Circeo	LT	H836
13180	Santi Cosma e Damiano	LT	I339
13181	Sermoneta	LT	I634
13182	Sezze	LT	I712
13183	Sonnino	LT	I832
13184	Sperlonga	LT	I892
13185	Spigno Saturnia	LT	I902
13186	Terracina	LT	L120
13187	Ventotene	LT	L742
13188	Acquafondata	FR	A032
13189	Acuto	FR	A054
13190	Alatri	FR	A123
13191	Alvito	FR	A244
13192	Amaseno	FR	A256
13193	Anagni	FR	A269
13194	Aquino	FR	A348
13195	Arce	FR	A363
13196	Arnara	FR	A421
13197	Arpino	FR	A433
13198	Atina	FR	A486
13199	Ausonia	FR	A502
13200	Belmonte Castello	FR	A763
13201	Boville Ernica	FR	A720
13202	Broccostella	FR	B195
13203	Campoli Appennino	FR	B543
13204	Casalattico	FR	B862
13205	Casalvieri	FR	B919
13206	Cassino	FR	C034
13207	Castelliri	FR	C177
13208	Castelnuovo Parano	FR	C223
13209	Castrocielo	FR	C340
13210	Castro dei Volsci	FR	C338
13211	Ceccano	FR	C413
13212	Ceprano	FR	C479
13213	Cervaro	FR	C545
13214	Colfelice	FR	C836
13215	Collepardo	FR	C864
13216	Colle San Magno	FR	C870
13217	Coreno Ausonio	FR	C998
13218	Esperia	FR	D440
13219	Falvaterra	FR	D483
13220	Ferentino	FR	D539
13221	Filettino	FR	D591
13222	Fiuggi	FR	A310
13223	Fontana Liri	FR	D667
13224	Fontechiari	FR	D682
13225	Frosinone	FR	D810
13226	Fumone	FR	D819
13227	Gallinaro	FR	D881
13228	Giuliano di Roma	FR	E057
13229	Guarcino	FR	E236
13230	Isola del Liri	FR	E340
13231	Monte San Giovanni Campano	FR	F620
13232	Morolo	FR	F740
13233	Paliano	FR	G276
13234	Pastena	FR	G362
13235	Patrica	FR	G374
13236	Pescosolido	FR	G500
13237	Picinisco	FR	G591
13238	Pico	FR	G592
13239	Piedimonte San Germano	FR	G598
13240	Piglio	FR	G659
13241	Pignataro Interamna	FR	G662
13242	Pofi	FR	G749
13243	Pontecorvo	FR	G838
13244	Posta Fibreno	FR	G935
13245	Ripi	FR	H324
13246	Rocca d'Arce	FR	H393
13247	Roccasecca	FR	H443
13248	San Biagio Saracinisco	FR	H779
13249	San Donato Val di Comino	FR	H824
13250	San Giorgio a Liri	FR	H880
13251	San Giovanni Incarico	FR	H917
13252	Sant'Ambrogio sul Garigliano	FR	I256
13253	Sant'Andrea del Garigliano	FR	I265
13254	Sant'Apollinare	FR	I302
13255	Sant'Elia Fiumerapido	FR	I321
13256	Santopadre	FR	I351
13257	San Vittore del Lazio	FR	I408
13258	Serrone	FR	I669
13259	Settefrati	FR	I697
13260	Sgurgola	FR	I716
13261	Sora	FR	I838
13262	Strangolagalli	FR	I973
13263	Supino	FR	L009
13264	Terelle	FR	L105
13265	Torre Cajetani	FR	L243
13266	Torrice	FR	L290
13267	Trevi nel Lazio	FR	L398
13268	Trivigliano	FR	L437
13269	Vallecorsa	FR	L598
13270	Vallemaio	FR	L605
13271	Vallerotonda	FR	L614
13272	Veroli	FR	L780
13273	Vicalvi	FR	L836
13274	Vico nel Lazio	FR	L843
13275	Villa Latina	FR	A081
13276	Villa Santa Lucia	FR	L905
13277	Villa Santo Stefano	FR	I364
13278	Viticuso	FR	M083
13279	Acciano	AQ	A018
13280	Aielli	AQ	A100
13281	Alfedena	AQ	A187
13282	Anversa degli Abruzzi	AQ	A318
13283	Ateleta	AQ	A481
13284	Avezzano	AQ	A515
13285	Balsorano	AQ	A603
13286	Barete	AQ	A656
13287	Barisciano	AQ	A667
13288	Barrea	AQ	A678
13289	Bisegna	AQ	A884
13290	Bugnara	AQ	B256
13291	Cagnano Amiterno	AQ	B358
13292	Calascio	AQ	B382
13293	Campo di Giove	AQ	B526
13294	Campotosto	AQ	B569
13295	Canistro	AQ	B606
13296	Cansano	AQ	B624
13297	Capestrano	AQ	B651
13298	Capistrello	AQ	B656
13299	Capitignano	AQ	B658
13300	Caporciano	AQ	B672
13301	Cappadocia	AQ	B677
13302	Carapelle Calvisio	AQ	B725
13303	Carsoli	AQ	B842
13304	Castel del Monte	AQ	C083
13305	Castel di Ieri	AQ	C090
13306	Castel di Sangro	AQ	C096
13307	Castellafiume	AQ	C126
13308	Castelvecchio Calvisio	AQ	C278
13309	Castelvecchio Subequo	AQ	C279
13310	Celano	AQ	C426
13311	Cerchio	AQ	C492
13312	Civita d'Antino	AQ	C766
13313	Civitella Alfedena	AQ	C778
13314	Civitella Roveto	AQ	C783
13315	Cocullo	AQ	C811
13316	Collarmele	AQ	C844
13317	Collelongo	AQ	C862
13318	Collepietro	AQ	C866
13319	Corfinio	AQ	C999
13320	Fagnano Alto	AQ	D465
13321	Fontecchio	AQ	D681
13322	Fossa	AQ	D736
13323	Gagliano Aterno	AQ	D850
13324	Gioia dei Marsi	AQ	E040
13325	Goriano Sicoli	AQ	E096
13326	Introdacqua	AQ	E307
13327	L'Aquila	AQ	A345
13328	Lecce nei Marsi	AQ	E505
13329	Luco dei Marsi	AQ	E723
13330	Lucoli	AQ	E724
13331	Magliano de' Marsi	AQ	E811
13332	Massa d'Albe	AQ	F022
13333	Molina Aterno	AQ	M255
13334	Montereale	AQ	F595
13335	Morino	AQ	F732
13336	Navelli	AQ	F852
13337	Ocre	AQ	F996
13338	Ofena	AQ	G002
13339	Opi	AQ	G079
13340	Oricola	AQ	G102
13341	Ortona dei Marsi	AQ	G142
13342	Ortucchio	AQ	G145
13343	Ovindoli	AQ	G200
13344	Pacentro	AQ	G210
13345	Pereto	AQ	G449
13346	Pescasseroli	AQ	G484
13347	Pescina	AQ	G492
13348	Pescocostanzo	AQ	G493
13349	Pettorano sul Gizio	AQ	G524
13350	Pizzoli	AQ	G726
13351	Poggio Picenze	AQ	G766
13352	Prata d'Ansidonia	AQ	G992
13353	Pratola Peligna	AQ	H007
13354	Prezza	AQ	H056
13355	Raiano	AQ	H166
13356	Rivisondoli	AQ	H353
13357	Roccacasale	AQ	H389
13358	Rocca di Botte	AQ	H399
13359	Rocca di Cambio	AQ	H400
13360	Rocca di Mezzo	AQ	H402
13361	Rocca Pia	AQ	H429
13362	Roccaraso	AQ	H434
13363	San Benedetto dei Marsi	AQ	H772
13364	San Benedetto in Perillis	AQ	H773
13365	San Demetrio ne' Vestini	AQ	H819
13366	San Pio delle Camere	AQ	I121
13367	Sante Marie	AQ	I326
13368	Sant'Eusanio Forconese	AQ	I336
13369	Santo Stefano di Sessanio	AQ	I360
13370	San Vincenzo Valle Roveto	AQ	I389
13371	Scanno	AQ	I501
13372	Scontrone	AQ	I543
13373	Scoppito	AQ	I546
13374	Scurcola Marsicana	AQ	I553
13375	Secinaro	AQ	I558
13376	Sulmona	AQ	I804
13377	Tagliacozzo	AQ	L025
13378	Tione degli Abruzzi	AQ	L173
13379	Tornimparte	AQ	L227
13380	Trasacco	AQ	L334
13381	Villalago	AQ	L958
13382	Villa Santa Lucia degli Abruzzi	AQ	M021
13383	Villa Sant'Angelo	AQ	M023
13384	Villavallelonga	AQ	M031
13385	Villetta Barrea	AQ	M041
13386	Vittorito	AQ	M090
13387	Alba Adriatica	TE	A125
13388	Ancarano	TE	A270
13389	Arsita	TE	A445
13390	Atri	TE	A488
13391	Basciano	TE	A692
13392	Bellante	TE	A746
13393	Bisenti	TE	A885
13394	Campli	TE	B515
13395	Canzano	TE	B640
13396	Castel Castagna	TE	C040
13397	Castellalto	TE	C128
13398	Castelli	TE	C169
13399	Castiglione Messer Raimondo	TE	C316
13400	Castilenti	TE	C322
13401	Cellino Attanasio	TE	C449
13402	Cermignano	TE	C517
13403	Civitella del Tronto	TE	C781
13404	Colledara	TE	C311
13405	Colonnella	TE	C901
13406	Controguerra	TE	C972
13407	Corropoli	TE	D043
13408	Cortino	TE	D076
13409	Crognaleto	TE	D179
13410	Fano Adriano	TE	D489
13411	Giulianova	TE	E058
13412	Isola del Gran Sasso d'Italia	TE	E343
13413	Montefino	TE	F500
13414	Montorio al Vomano	TE	F690
13415	Morro d'Oro	TE	F747
13416	Mosciano Sant'Angelo	TE	F764
13417	Nereto	TE	F870
13418	Notaresco	TE	F942
13419	Penna Sant'Andrea	TE	G437
13420	Pietracamela	TE	G608
13421	Pineto	TE	F831
13422	Rocca Santa Maria	TE	H440
13423	Roseto degli Abruzzi	TE	F585
13424	Sant'Egidio alla Vibrata	TE	I318
13425	Sant'Omero	TE	I348
13426	Silvi	TE	I741
13427	Teramo	TE	L103
13428	Torano Nuovo	TE	L207
13429	Torricella Sicura	TE	L295
13430	Tortoreto	TE	L307
13431	Tossicia	TE	L314
13432	Valle Castellana	TE	L597
13433	Martinsicuro	TE	E989
13434	Abbateggio	PE	A008
13435	Alanno	PE	A120
13436	Bolognano	PE	A945
13437	Brittoli	PE	B193
13438	Bussi sul Tirino	PE	B294
13439	Cappelle sul Tavo	PE	B681
13440	Caramanico Terme	PE	B722
13441	Carpineto della Nora	PE	B827
13442	Castiglione a Casauria	PE	C308
13443	Catignano	PE	C354
13444	Cepagatti	PE	C474
13445	Città Sant'Angelo	PE	C750
13446	Civitaquana	PE	C771
13447	Civitella Casanova	PE	C779
13448	Collecorvino	PE	C853
13449	Corvara	PE	D078
13450	Cugnoli	PE	D201
13451	Elice	PE	D394
13452	Farindola	PE	D501
13453	Lettomanoppello	PE	E558
13454	Loreto Aprutino	PE	E691
13455	Manoppello	PE	E892
13456	Montebello di Bertona	PE	F441
13457	Montesilvano	PE	F646
13458	Moscufo	PE	F765
13459	Nocciano	PE	F908
13460	Penne	PE	G438
13461	Pescara	PE	G482
13462	Pescosansonesco	PE	G499
13463	Pianella	PE	G555
13464	Picciano	PE	G589
13465	Pietranico	PE	G621
13466	Popoli	PE	G878
13467	Roccamorice	PE	H425
13468	Rosciano	PE	H562
13469	Salle	PE	H715
13470	Sant'Eufemia a Maiella	PE	I332
13471	San Valentino in Abruzzo Citeriore	PE	I376
13472	Scafa	PE	I482
13473	Serramonacesca	PE	I649
13474	Spoltore	PE	I922
13475	Tocco da Casauria	PE	L186
13476	Torre de' Passeri	PE	L263
13477	Turrivalignani	PE	L475
13478	Vicoli	PE	L846
13479	Villa Celiera	PE	L922
13480	Altino	CH	A235
13481	Archi	CH	A367
13482	Ari	CH	A398
13483	Arielli	CH	A402
13484	Atessa	CH	A485
13485	Bomba	CH	A956
13486	Borrello	CH	B057
13487	Bucchianico	CH	B238
13488	Montebello sul Sangro	CH	B268
13489	Canosa Sannita	CH	B620
13490	Carpineto Sinello	CH	B826
13491	Carunchio	CH	B853
13492	Casacanditella	CH	B859
13493	Casalanguida	CH	B861
13494	Casalbordino	CH	B865
13495	Casalincontrada	CH	B896
13496	Casoli	CH	B985
13497	Castel Frentano	CH	C114
13498	Castelguidone	CH	C123
13499	Castiglione Messer Marino	CH	C298
13500	Celenza sul Trigno	CH	C428
13501	Chieti	CH	C632
13502	Civitaluparella	CH	C768
13503	Civitella Messer Raimondo	CH	C776
13504	Colledimacine	CH	C855
13505	Colledimezzo	CH	C856
13506	Crecchio	CH	D137
13507	Cupello	CH	D209
13508	Dogliola	CH	D315
13509	Fara Filiorum Petri	CH	D494
13510	Fara San Martino	CH	D495
13511	Filetto	CH	D592
13512	Fossacesia	CH	D738
13513	Fraine	CH	D757
13514	Francavilla al Mare	CH	D763
13515	Fresagrandinaria	CH	D796
13516	Frisa	CH	D803
13517	Furci	CH	D823
13518	Gamberale	CH	D898
13519	Gessopalena	CH	D996
13520	Gissi	CH	E052
13521	Giuliano Teatino	CH	E056
13522	Guardiagrele	CH	E243
13523	Guilmi	CH	E266
13524	Lama dei Peligni	CH	E424
13525	Lanciano	CH	E435
13526	Lentella	CH	E531
13527	Lettopalena	CH	E559
13528	Liscia	CH	E611
13529	Miglianico	CH	F196
13530	Montazzoli	CH	F433
13531	Monteferrante	CH	F498
13532	Montelapiano	CH	F535
13533	Montenerodomo	CH	F578
13534	Monteodorisio	CH	F582
13535	Mozzagrogna	CH	F785
13536	Orsogna	CH	G128
13537	Ortona	CH	G141
13538	Paglieta	CH	G237
13539	Palena	CH	G271
13540	Palmoli	CH	G290
13541	Palombaro	CH	G294
13542	Pennadomo	CH	G434
13543	Pennapiedimonte	CH	G435
13544	Perano	CH	G441
13545	Pizzoferrato	CH	G724
13546	Poggiofiorito	CH	G760
13547	Pollutri	CH	G799
13548	Pretoro	CH	H052
13549	Quadri	CH	H098
13550	Rapino	CH	H184
13551	Ripa Teatina	CH	H320
13552	Roccamontepiano	CH	H424
13553	Rocca San Giovanni	CH	H439
13554	Roccascalegna	CH	H442
13555	Roccaspinalveti	CH	H448
13556	Roio del Sangro	CH	H495
13557	Rosello	CH	H566
13558	San Buono	CH	H784
13559	San Giovanni Lipioni	CH	H923
13560	San Giovanni Teatino	CH	D690
13561	San Martino sulla Marrucina	CH	H991
13562	San Salvo	CH	I148
13563	Santa Maria Imbaro	CH	I244
13564	Sant'Eusanio del Sangro	CH	I335
13565	San Vito Chietino	CH	I394
13566	Scerni	CH	I520
13567	Schiavi di Abruzzo	CH	I526
13568	Taranta Peligna	CH	L047
13569	Tollo	CH	L194
13570	Torino di Sangro	CH	L218
13571	Tornareccio	CH	L224
13572	Torrebruna	CH	L253
13573	Torrevecchia Teatina	CH	L284
13574	Torricella Peligna	CH	L291
13575	Treglio	CH	L363
13576	Tufillo	CH	L459
13577	Vacri	CH	L526
13578	Vasto	CH	E372
13579	Villalfonsina	CH	L961
13580	Villamagna	CH	L964
13581	Villa Santa Maria	CH	M022
13582	Pietraferrazzana	CH	G613
13583	Fallo	CH	D480
13584	Acquaviva Collecroce	CB	A050
13585	Baranello	CB	A616
13586	Bojano	CB	A930
13587	Bonefro	CB	A971
13588	Busso	CB	B295
13589	Campobasso	CB	B519
13590	Campochiaro	CB	B522
13591	Campodipietra	CB	B528
13592	Campolieto	CB	B544
13593	Campomarino	CB	B550
13594	Casacalenda	CB	B858
13595	Casalciprano	CB	B871
13596	Castelbottaccio	CB	C066
13597	Castellino del Biferno	CB	C175
13598	Castelmauro	CB	C197
13599	Castropignano	CB	C346
13600	Cercemaggiore	CB	C486
13601	Cercepiccola	CB	C488
13602	Civitacampomarano	CB	C764
13603	Colle d'Anchise	CB	C854
13604	Colletorto	CB	C875
13605	Duronia	CB	C772
13606	Ferrazzano	CB	D550
13607	Fossalto	CB	D737
13608	Gambatesa	CB	D896
13609	Gildone	CB	E030
13610	Guardialfiera	CB	E244
13611	Guardiaregia	CB	E248
13612	Guglionesi	CB	E259
13613	Jelsi	CB	E381
13614	Larino	CB	E456
13615	Limosano	CB	E599
13616	Lucito	CB	E722
13617	Lupara	CB	E748
13618	Macchia Valfortore	CB	E780
13619	Mafalda	CB	E799
13620	Matrice	CB	F055
13621	Mirabello Sannitico	CB	F233
13622	Molise	CB	F294
13623	Monacilioni	CB	F322
13624	Montagano	CB	F391
13625	Montecilfone	CB	F475
13626	Montefalcone nel Sannio	CB	F495
13627	Montelongo	CB	F548
13628	Montemitro	CB	F569
13629	Montenero di Bisaccia	CB	F576
13630	Montorio nei Frentani	CB	F689
13631	Morrone del Sannio	CB	F748
13632	Oratino	CB	G086
13633	Palata	CB	G257
13634	Petacciato	CB	G506
13635	Petrella Tifernina	CB	G512
13636	Pietracatella	CB	G609
13637	Pietracupa	CB	G610
13638	Portocannone	CB	G910
13639	Provvidenti	CB	H083
13640	Riccia	CB	H273
13641	Ripabottoni	CB	H311
13642	Ripalimosani	CB	H313
13643	Roccavivara	CB	H454
13644	Rotello	CB	H589
13645	Salcito	CB	H693
13646	San Biase	CB	H782
13647	San Felice del Molise	CB	H833
13648	San Giacomo degli Schiavoni	CB	H867
13649	San Giovanni in Galdo	CB	H920
13650	San Giuliano del Sannio	CB	H928
13651	San Giuliano di Puglia	CB	H929
13652	San Martino in Pensilis	CB	H990
13653	San Massimo	CB	I023
13654	San Polo Matese	CB	I122
13655	Santa Croce di Magliano	CB	I181
13656	Sant'Angelo Limosano	CB	I289
13657	Sant'Elia a Pianisi	CB	I320
13658	Sepino	CB	I618
13659	Spinete	CB	I910
13660	Tavenna	CB	L069
13661	Termoli	CB	L113
13662	Torella del Sannio	CB	L215
13663	Toro	CB	L230
13664	Trivento	CB	L435
13665	Tufara	CB	L458
13666	Ururi	CB	L505
13667	Vinchiaturo	CB	M057
13668	Acquaviva d'Isernia	IS	A051
13669	Agnone	IS	A080
13670	Bagnoli del Trigno	IS	A567
13671	Belmonte del Sannio	IS	A761
13672	Cantalupo nel Sannio	IS	B630
13673	Capracotta	IS	B682
13674	Carovilli	IS	B810
13675	Carpinone	IS	B830
13676	Castel del Giudice	IS	C082
13677	Castelpetroso	IS	C246
13678	Castelpizzuto	IS	C247
13679	Castel San Vincenzo	IS	C270
13680	Castelverrino	IS	C200
13681	Cerro al Volturno	IS	C534
13682	Chiauci	IS	C620
13683	Civitanova del Sannio	IS	C769
13684	Colli a Volturno	IS	C878
13685	Conca Casale	IS	C941
13686	Filignano	IS	D595
13687	Forlì del Sannio	IS	D703
13688	Fornelli	IS	D715
13689	Frosolone	IS	D811
13690	Isernia	IS	E335
13691	Longano	IS	E669
13692	Macchia d'Isernia	IS	E778
13693	Macchiagodena	IS	E779
13694	Miranda	IS	F239
13695	Montaquila	IS	F429
13696	Montenero Val Cocchiara	IS	F580
13697	Monteroduni	IS	F601
13698	Pesche	IS	G486
13699	Pescolanciano	IS	G495
13700	Pescopennataro	IS	G497
13701	Pettoranello del Molise	IS	G523
13702	Pietrabbondante	IS	G606
13703	Pizzone	IS	G727
13704	Poggio Sannita	IS	B317
13705	Pozzilli	IS	G954
13706	Rionero Sannitico	IS	H308
13707	Roccamandolfi	IS	H420
13708	Roccasicura	IS	H445
13709	Rocchetta a Volturno	IS	H458
13710	San Pietro Avellana	IS	I096
13711	Sant'Agapito	IS	I189
13712	Santa Maria del Molise	IS	I238
13713	Sant'Angelo del Pesco	IS	I282
13714	Sant'Elena Sannita	IS	B466
13715	Scapoli	IS	I507
13716	Sessano del Molise	IS	I679
13717	Sesto Campano	IS	I682
13718	Vastogirardi	IS	L696
13719	Venafro	IS	L725
13720	Ailano	CE	A106
13721	Alife	CE	A200
13722	Alvignano	CE	A243
13723	Arienzo	CE	A403
13724	Aversa	CE	A512
13725	Baia e Latina	CE	A579
13726	Bellona	CE	A755
13727	Caianello	CE	B361
13728	Caiazzo	CE	B362
13729	Calvi Risorta	CE	B445
13730	Camigliano	CE	B477
13731	Cancello ed Arnone	CE	B581
13732	Capodrise	CE	B667
13733	Capriati a Volturno	CE	B704
13734	Capua	CE	B715
13735	Carinaro	CE	B779
13736	Carinola	CE	B781
13737	Casagiove	CE	B860
13738	Casal di Principe	CE	B872
13739	Casaluce	CE	B916
13740	Casapulla	CE	B935
13741	Caserta	CE	B963
13742	Castel Campagnano	CE	B494
13743	Castel di Sasso	CE	C097
13744	Castello del Matese	CE	C178
13745	Castel Morrone	CE	C211
13746	Castel Volturno	CE	C291
13747	Cervino	CE	C558
13748	Cesa	CE	C561
13749	Ciorlano	CE	C716
13750	Conca della Campania	CE	C939
13751	Curti	CE	D228
13752	Dragoni	CE	D361
13753	Fontegreca	CE	D683
13754	Formicola	CE	D709
13755	Francolise	CE	D769
13756	Frignano	CE	D799
13757	Gallo Matese	CE	D884
13758	Galluccio	CE	D886
13759	Giano Vetusto	CE	E011
13760	Gioia Sannitica	CE	E039
13761	Grazzanise	CE	E158
13762	Gricignano di Aversa	CE	E173
13763	Letino	CE	E554
13764	Liberi	CE	E570
13765	Lusciano	CE	E754
13766	Macerata Campania	CE	E784
13767	Maddaloni	CE	E791
13768	Marcianise	CE	E932
13769	Marzano Appio	CE	E998
13770	Mignano Monte Lungo	CE	F203
13771	Mondragone	CE	F352
13772	Orta di Atella	CE	G130
13773	Parete	CE	G333
13774	Pastorano	CE	G364
13775	Piana di Monte Verna	CE	G541
13776	Piedimonte Matese	CE	G596
13777	Pietramelara	CE	G620
13778	Pietravairano	CE	G630
13779	Pignataro Maggiore	CE	G661
13780	Pontelatone	CE	G849
13781	Portico di Caserta	CE	G903
13782	Prata Sannita	CE	G991
13783	Pratella	CE	G995
13784	Presenzano	CE	H045
13785	Raviscanina	CE	H202
13786	Recale	CE	H210
13787	Riardo	CE	H268
13788	Rocca d'Evandro	CE	H398
13789	Roccamonfina	CE	H423
13790	Roccaromana	CE	H436
13791	Rocchetta e Croce	CE	H459
13792	Ruviano	CE	H165
13793	San Cipriano d'Aversa	CE	H798
13794	San Felice a Cancello	CE	H834
13795	San Gregorio Matese	CE	H939
13796	San Marcellino	CE	H978
13797	San Nicola la Strada	CE	I056
13798	San Pietro Infine	CE	I113
13799	San Potito Sannitico	CE	I130
13800	San Prisco	CE	I131
13801	Santa Maria a Vico	CE	I233
13802	Santa Maria Capua Vetere	CE	I234
13803	Santa Maria la Fossa	CE	I247
13804	San Tammaro	CE	I261
13805	Sant'Angelo d'Alife	CE	I273
13806	Sant'Arpino	CE	I306
13807	Sessa Aurunca	CE	I676
13808	Sparanise	CE	I885
13809	Succivo	CE	I993
13810	Teano	CE	L083
13811	Teverola	CE	L155
13812	Tora e Piccilli	CE	L205
13813	Trentola Ducenta	CE	L379
13814	Vairano Patenora	CE	L540
13815	Valle Agricola	CE	L594
13816	Valle di Maddaloni	CE	L591
13817	Villa di Briano	CE	D801
13818	Villa Literno	CE	L844
13819	Vitulazio	CE	M092
13820	Falciano del Massico	CE	D471
13821	Cellole	CE	M262
13822	Casapesenna	CE	M260
13823	San Marco Evangelista	CE	F043
13824	Airola	BN	A110
13825	Amorosi	BN	A265
13826	Apice	BN	A328
13827	Apollosa	BN	A330
13828	Arpaia	BN	A431
13829	Arpaise	BN	A432
13830	Baselice	BN	A696
13831	Benevento	BN	A783
13832	Bonea	BN	A970
13833	Bucciano	BN	B239
13834	Buonalbergo	BN	B267
13835	Calvi	BN	B444
13836	Campolattaro	BN	B541
13837	Campoli del Monte Taburno	BN	B542
13838	Casalduni	BN	B873
13839	Castelfranco in Miscano	BN	C106
13840	Castelpagano	BN	C245
13841	Castelpoto	BN	C250
13842	Castelvenere	BN	C280
13843	Castelvetere in Val Fortore	BN	C284
13844	Cautano	BN	C359
13845	Ceppaloni	BN	C476
13846	Cerreto Sannita	BN	C525
13847	Circello	BN	C719
13848	Colle Sannita	BN	C846
13849	Cusano Mutri	BN	D230
13850	Dugenta	BN	D380
13851	Durazzano	BN	D386
13852	Faicchio	BN	D469
13853	Foglianise	BN	D644
13854	Foiano di Val Fortore	BN	D650
13855	Forchia	BN	D693
13856	Fragneto l'Abate	BN	D755
13857	Fragneto Monforte	BN	D756
13858	Frasso Telesino	BN	D784
13859	Ginestra degli Schiavoni	BN	E034
13860	Guardia Sanframondi	BN	E249
13861	Limatola	BN	E589
13862	Melizzano	BN	F113
13863	Moiano	BN	F274
13864	Molinara	BN	F287
13865	Montefalcone di Val Fortore	BN	F494
13866	Montesarchio	BN	F636
13867	Morcone	BN	F717
13868	Paduli	BN	G227
13869	Pago Veiano	BN	G243
13870	Pannarano	BN	G311
13871	Paolisi	BN	G318
13872	Paupisi	BN	G386
13873	Pesco Sannita	BN	G494
13874	Pietraroja	BN	G626
13875	Pietrelcina	BN	G631
13876	Ponte	BN	G827
13877	Pontelandolfo	BN	G848
13878	Puglianello	BN	H087
13879	Reino	BN	H227
13880	San Bartolomeo in Galdo	BN	H764
13881	San Giorgio del Sannio	BN	H894
13882	San Giorgio La Molara	BN	H898
13883	San Leucio del Sannio	BN	H953
13884	San Lorenzello	BN	H955
13885	San Lorenzo Maggiore	BN	H967
13886	San Lupo	BN	H973
13887	San Marco dei Cavoti	BN	H984
13888	San Martino Sannita	BN	I002
13889	San Nazzaro	BN	I049
13890	San Nicola Manfredi	BN	I062
13891	San Salvatore Telesino	BN	I145
13892	Santa Croce del Sannio	BN	I179
13893	Sant'Agata de' Goti	BN	I197
13894	Sant'Angelo a Cupolo	BN	I277
13895	Sassinoro	BN	I455
13896	Solopaca	BN	I809
13897	Telese Terme	BN	L086
13898	Tocco Caudio	BN	L185
13899	Torrecuso	BN	L254
13900	Vitulano	BN	M093
13901	Sant'Arcangelo Trimonte	BN	F557
13902	Acerra	NA	A024
13903	Afragola	NA	A064
13904	Agerola	NA	A068
13905	Anacapri	NA	A268
13906	Arzano	NA	A455
13907	Bacoli	NA	A535
13908	Barano d'Ischia	NA	A617
13909	Boscoreale	NA	B076
13910	Boscotrecase	NA	B077
13911	Brusciano	NA	B227
13912	Caivano	NA	B371
13913	Calvizzano	NA	B452
13914	Camposano	NA	B565
13915	Capri	NA	B696
13916	Carbonara di Nola	NA	B740
13917	Cardito	NA	B759
13918	Casalnuovo di Napoli	NA	B905
13919	Casamarciano	NA	B922
13920	Casamicciola Terme	NA	B924
13921	Casandrino	NA	B925
13922	Casavatore	NA	B946
13923	Casola di Napoli	NA	B980
13924	Casoria	NA	B990
13925	Castellammare di Stabia	NA	C129
13926	Castello di Cisterna	NA	C188
13927	Cercola	NA	C495
13928	Cicciano	NA	C675
13929	Cimitile	NA	C697
13930	Comiziano	NA	C929
13931	Crispano	NA	D170
13932	Forio	NA	D702
13933	Frattamaggiore	NA	D789
13934	Frattaminore	NA	D790
13935	Giugliano in Campania	NA	E054
13936	Gragnano	NA	E131
13937	Grumo Nevano	NA	E224
13938	Ischia	NA	E329
13939	Lacco Ameno	NA	E396
13940	Lettere	NA	E557
13941	Liveri	NA	E620
13942	Marano di Napoli	NA	E906
13943	Mariglianella	NA	E954
13944	Marigliano	NA	E955
13945	Massa Lubrense	NA	F030
13946	Melito di Napoli	NA	F111
13947	Meta	NA	F162
13948	Monte di Procida	NA	F488
13949	Mugnano di Napoli	NA	F799
13950	Napoli	NA	F839
13951	Nola	NA	F924
13952	Ottaviano	NA	G190
13953	Palma Campania	NA	G283
13954	Piano di Sorrento	NA	G568
13955	Pimonte	NA	G670
13956	Poggiomarino	NA	G762
13957	Pollena Trocchia	NA	G795
13958	Pomigliano d'Arco	NA	G812
13959	Pompei	NA	G813
13960	Portici	NA	G902
13961	Pozzuoli	NA	G964
13962	Procida	NA	H072
13963	Qualiano	NA	H101
13964	Quarto	NA	H114
13965	Ercolano	NA	H243
13966	Roccarainola	NA	H433
13967	San Gennaro Vesuviano	NA	H860
13968	San Giorgio a Cremano	NA	H892
13969	San Giuseppe Vesuviano	NA	H931
13970	San Paolo Bel Sito	NA	I073
13971	San Sebastiano al Vesuvio	NA	I151
13972	Sant'Agnello	NA	I208
13973	Sant'Anastasia	NA	I262
13974	Sant'Antimo	NA	I293
13975	Sant'Antonio Abate	NA	I300
13976	San Vitaliano	NA	I391
13977	Saviano	NA	I469
13978	Scisciano	NA	I540
13979	Serrara Fontana	NA	I652
13980	Somma Vesuviana	NA	I820
13981	Sorrento	NA	I862
13982	Striano	NA	I978
13983	Terzigno	NA	L142
13984	Torre Annunziata	NA	L245
13985	Torre del Greco	NA	L259
13986	Tufino	NA	L460
13987	Vico Equense	NA	L845
13988	Villaricca	NA	G309
13989	Visciano	NA	M072
13990	Volla	NA	M115
13991	Santa Maria la Carità	NA	M273
13992	Trecase	NA	M280
13993	Massa di Somma	NA	M289
13994	Aiello del Sabato	AV	A101
13995	Altavilla Irpina	AV	A228
13996	Andretta	AV	A284
13997	Aquilonia	AV	A347
13998	Ariano Irpino	AV	A399
13999	Atripalda	AV	A489
14000	Avella	AV	A508
14001	Avellino	AV	A509
14002	Bagnoli Irpino	AV	A566
14003	Baiano	AV	A580
14004	Bisaccia	AV	A881
14005	Bonito	AV	A975
14006	Cairano	AV	B367
14007	Calabritto	AV	B374
14008	Calitri	AV	B415
14009	Candida	AV	B590
14010	Caposele	AV	B674
14011	Capriglia Irpina	AV	B706
14012	Carife	AV	B776
14013	Casalbore	AV	B866
14014	Cassano Irpino	AV	B997
14015	Castel Baronia	AV	C058
14016	Castelfranci	AV	C105
14017	Castelvetere sul Calore	AV	C283
14018	Cervinara	AV	C557
14019	Cesinali	AV	C576
14020	Chianche	AV	C606
14021	Chiusano di San Domenico	AV	C659
14022	Contrada	AV	C971
14023	Conza della Campania	AV	C976
14024	Domicella	AV	D331
14025	Flumeri	AV	D638
14026	Fontanarosa	AV	D671
14027	Forino	AV	D701
14028	Frigento	AV	D798
14029	Gesualdo	AV	D998
14030	Greci	AV	E161
14031	Grottaminarda	AV	E206
14032	Grottolella	AV	E214
14033	Guardia Lombardi	AV	E245
14034	Lacedonia	AV	E397
14035	Lapio	AV	E448
14036	Lauro	AV	E487
14037	Lioni	AV	E605
14038	Luogosano	AV	E746
14039	Manocalzati	AV	E891
14040	Marzano di Nola	AV	E997
14041	Melito Irpino	AV	F110
14042	Mercogliano	AV	F141
14043	Mirabella Eclano	AV	F230
14044	Montaguto	AV	F397
14045	Montecalvo Irpino	AV	F448
14046	Montefalcione	AV	F491
14047	Monteforte Irpino	AV	F506
14048	Montefredane	AV	F511
14049	Montefusco	AV	F512
14050	Montella	AV	F546
14051	Montemarano	AV	F559
14052	Montemiletto	AV	F566
14053	Monteverde	AV	F660
14054	Morra De Sanctis	AV	F744
14055	Moschiano	AV	F762
14056	Mugnano del Cardinale	AV	F798
14057	Nusco	AV	F988
14058	Ospedaletto d'Alpinolo	AV	G165
14059	Pago del Vallo di Lauro	AV	G242
14060	Parolise	AV	G340
14061	Paternopoli	AV	G370
14062	Petruro Irpino	AV	G519
14063	Pietradefusi	AV	G611
14064	Pietrastornina	AV	G629
14065	Prata di Principato Ultra	AV	G990
14066	Pratola Serra	AV	H006
14067	Quadrelle	AV	H097
14068	Quindici	AV	H128
14069	Roccabascerana	AV	H382
14070	Rocca San Felice	AV	H438
14071	Rotondi	AV	H592
14072	Salza Irpina	AV	H733
14073	San Mango sul Calore	AV	H975
14074	San Martino Valle Caudina	AV	I016
14075	San Michele di Serino	AV	I034
14076	San Nicola Baronia	AV	I061
14077	San Potito Ultra	AV	I129
14078	San Sossio Baronia	AV	I163
14079	Santa Lucia di Serino	AV	I219
14080	Sant'Andrea di Conza	AV	I264
14081	Sant'Angelo all'Esca	AV	I279
14082	Sant'Angelo a Scala	AV	I280
14083	Sant'Angelo dei Lombardi	AV	I281
14084	Santa Paolina	AV	I301
14085	Santo Stefano del Sole	AV	I357
14086	Savignano Irpino	AV	I471
14087	Scampitella	AV	I493
14088	Senerchia	AV	I606
14089	Serino	AV	I630
14090	Sirignano	AV	I756
14091	Solofra	AV	I805
14092	Sorbo Serpico	AV	I843
14093	Sperone	AV	I893
14094	Sturno	AV	I990
14095	Summonte	AV	L004
14096	Taurano	AV	L061
14097	Taurasi	AV	L062
14098	Teora	AV	L102
14099	Torella dei Lombardi	AV	L214
14100	Torre Le Nocelle	AV	L272
14101	Torrioni	AV	L301
14102	Trevico	AV	L399
14103	Tufo	AV	L461
14104	Vallata	AV	L589
14105	Vallesaccarda	AV	L616
14106	Venticano	AV	L739
14107	Villamaina	AV	L965
14108	Villanova del Battista	AV	L973
14109	Volturara Irpina	AV	M130
14110	Zungoli	AV	M203
14111	Montoro	AV	M330
14112	Acerno	SA	A023
14113	Agropoli	SA	A091
14114	Albanella	SA	A128
14115	Alfano	SA	A186
14116	Altavilla Silentina	SA	A230
14117	Amalfi	SA	A251
14118	Angri	SA	A294
14119	Aquara	SA	A343
14120	Ascea	SA	A460
14121	Atena Lucana	SA	A484
14122	Atrani	SA	A487
14123	Auletta	SA	A495
14124	Baronissi	SA	A674
14125	Battipaglia	SA	A717
14126	Bellosguardo	SA	A756
14127	Bracigliano	SA	B115
14128	Buccino	SA	B242
14129	Buonabitacolo	SA	B266
14130	Caggiano	SA	B351
14131	Calvanico	SA	B437
14132	Camerota	SA	B476
14133	Campagna	SA	B492
14134	Campora	SA	B555
14135	Cannalonga	SA	B608
14136	Capaccio Paestum	SA	B644
14137	Casalbuono	SA	B868
14138	Casaletto Spartano	SA	B888
14139	Casal Velino	SA	B895
14140	Caselle in Pittari	SA	B959
14141	Castelcivita	SA	C069
14142	Castellabate	SA	C125
14143	Castelnuovo Cilento	SA	C231
14144	Castelnuovo di Conza	SA	C235
14145	Castel San Giorgio	SA	C259
14146	Castel San Lorenzo	SA	C262
14147	Castiglione del Genovesi	SA	C306
14148	Cava de' Tirreni	SA	C361
14149	Celle di Bulgheria	SA	C444
14150	Centola	SA	C470
14151	Ceraso	SA	C485
14152	Cetara	SA	C584
14153	Cicerale	SA	C676
14154	Colliano	SA	C879
14155	Conca dei Marini	SA	C940
14156	Controne	SA	C973
14157	Contursi Terme	SA	C974
14158	Corbara	SA	C984
14159	Corleto Monforte	SA	D011
14160	Cuccaro Vetere	SA	D195
14161	Eboli	SA	D390
14162	Felitto	SA	D527
14163	Fisciano	SA	D615
14164	Furore	SA	D826
14165	Futani	SA	D832
14166	Giffoni Sei Casali	SA	E026
14167	Giffoni Valle Piana	SA	E027
14168	Gioi	SA	E037
14169	Giungano	SA	E060
14170	Ispani	SA	E365
14171	Laureana Cilento	SA	E480
14172	Laurino	SA	E485
14173	Laurito	SA	E486
14174	Laviano	SA	E498
14175	Lustra	SA	E767
14176	Magliano Vetere	SA	E814
14177	Maiori	SA	E839
14178	Mercato San Severino	SA	F138
14179	Minori	SA	F223
14180	Moio della Civitella	SA	F278
14181	Montano Antilia	SA	F426
14182	Montecorice	SA	F479
14183	Montecorvino Pugliano	SA	F480
14184	Montecorvino Rovella	SA	F481
14185	Monteforte Cilento	SA	F507
14186	Monte San Giacomo	SA	F618
14187	Montesano sulla Marcellana	SA	F625
14188	Morigerati	SA	F731
14189	Nocera Inferiore	SA	F912
14190	Nocera Superiore	SA	F913
14191	Novi Velia	SA	F967
14192	Ogliastro Cilento	SA	G011
14193	Olevano sul Tusciano	SA	G023
14194	Oliveto Citra	SA	G039
14195	Omignano	SA	G063
14196	Orria	SA	G121
14197	Ottati	SA	G192
14198	Padula	SA	G226
14199	Pagani	SA	G230
14200	Palomonte	SA	G292
14201	Pellezzano	SA	G426
14202	Perdifumo	SA	G447
14203	Perito	SA	G455
14204	Pertosa	SA	G476
14205	Petina	SA	G509
14206	Piaggine	SA	G538
14207	Pisciotta	SA	G707
14208	Polla	SA	G793
14209	Pollica	SA	G796
14210	Pontecagnano Faiano	SA	G834
14211	Positano	SA	G932
14212	Postiglione	SA	G939
14213	Praiano	SA	G976
14214	Prignano Cilento	SA	H062
14215	Ravello	SA	H198
14216	Ricigliano	SA	H277
14217	Roccadaspide	SA	H394
14218	Roccagloriosa	SA	H412
14219	Roccapiemonte	SA	H431
14220	Rofrano	SA	H485
14221	Romagnano al Monte	SA	H503
14222	Roscigno	SA	H564
14223	Rutino	SA	H644
14224	Sacco	SA	H654
14225	Sala Consilina	SA	H683
14226	Salento	SA	H686
14227	Salerno	SA	H703
14228	Salvitelle	SA	H732
14229	San Cipriano Picentino	SA	H800
14230	San Giovanni a Piro	SA	H907
14231	San Gregorio Magno	SA	H943
14232	San Mango Piemonte	SA	H977
14233	San Marzano sul Sarno	SA	I019
14234	San Mauro Cilento	SA	I031
14235	San Mauro la Bruca	SA	I032
14236	San Pietro al Tanagro	SA	I089
14237	San Rufo	SA	I143
14238	Santa Marina	SA	I253
14239	Sant'Angelo a Fasanella	SA	I278
14240	Sant'Arsenio	SA	I307
14241	Sant'Egidio del Monte Albino	SA	I317
14242	Santomenna	SA	I260
14243	San Valentino Torio	SA	I377
14244	Sanza	SA	I410
14245	Sapri	SA	I422
14246	Sarno	SA	I438
14247	Sassano	SA	I451
14248	Scafati	SA	I483
14249	Scala	SA	I486
14250	Serramezzana	SA	I648
14251	Serre	SA	I666
14252	Sessa Cilento	SA	I677
14253	Siano	SA	I720
14254	Sicignano degli Alburni	SA	M253
14255	Stella Cilento	SA	G887
14256	Stio	SA	I960
14257	Teggiano	SA	D292
14258	Torchiara	SA	L212
14259	Torraca	SA	L233
14260	Torre Orsaia	SA	L274
14261	Tortorella	SA	L306
14262	Tramonti	SA	L323
14263	Trentinara	SA	L377
14264	Valle dell'Angelo	SA	G540
14265	Vallo della Lucania	SA	L628
14266	Valva	SA	L656
14267	Vibonati	SA	L835
14268	Vietri sul Mare	SA	L860
14269	Bellizzi	SA	M294
14270	Accadia	FG	A015
14271	Alberona	FG	A150
14272	Anzano di Puglia	FG	A320
14273	Apricena	FG	A339
14274	Ascoli Satriano	FG	A463
14275	Biccari	FG	A854
14276	Bovino	FG	B104
14277	Cagnano Varano	FG	B357
14278	Candela	FG	B584
14279	Carapelle	FG	B724
14280	Carlantino	FG	B784
14281	Carpino	FG	B829
14282	Casalnuovo Monterotaro	FG	B904
14283	Casalvecchio di Puglia	FG	B917
14284	Castelluccio dei Sauri	FG	C198
14285	Castelluccio Valmaggiore	FG	C202
14286	Castelnuovo della Daunia	FG	C222
14287	Celenza Valfortore	FG	C429
14288	Celle di San Vito	FG	C442
14289	Cerignola	FG	C514
14290	Chieuti	FG	C633
14291	Deliceto	FG	D269
14292	Faeto	FG	D459
14293	Foggia	FG	D643
14294	Ischitella	FG	E332
14295	Isole Tremiti	FG	E363
14296	Lesina	FG	E549
14297	Lucera	FG	E716
14298	Manfredonia	FG	E885
14299	Mattinata	FG	F059
14300	Monteleone di Puglia	FG	F538
14301	Monte Sant'Angelo	FG	F631
14302	Motta Montecorvino	FG	F777
14303	Orsara di Puglia	FG	G125
14304	Orta Nova	FG	G131
14305	Panni	FG	G312
14306	Peschici	FG	G487
14307	Pietramontecorvino	FG	G604
14308	Poggio Imperiale	FG	G761
14309	Rignano Garganico	FG	H287
14310	Rocchetta Sant'Antonio	FG	H467
14311	Rodi Garganico	FG	H480
14312	Roseto Valfortore	FG	H568
14313	San Giovanni Rotondo	FG	H926
14314	San Marco in Lamis	FG	H985
14315	San Marco la Catola	FG	H986
14316	San Nicandro Garganico	FG	I054
14317	San Paolo di Civitate	FG	I072
14318	San Severo	FG	I158
14319	Sant'Agata di Puglia	FG	I193
14320	Serracapriola	FG	I641
14321	Stornara	FG	I962
14322	Stornarella	FG	I963
14323	Torremaggiore	FG	L273
14324	Troia	FG	L447
14325	Vico del Gargano	FG	L842
14326	Vieste	FG	L858
14327	Volturara Appula	FG	M131
14328	Volturino	FG	M132
14329	Ordona	FG	M266
14330	Zapponeta	FG	M267
14331	Acquaviva delle Fonti	BA	A048
14332	Adelfia	BA	A055
14333	Alberobello	BA	A149
14334	Altamura	BA	A225
14335	Bari	BA	A662
14336	Binetto	BA	A874
14337	Bitetto	BA	A892
14338	Bitonto	BA	A893
14339	Bitritto	BA	A894
14340	Capurso	BA	B716
14341	Casamassima	BA	B923
14342	Cassano delle Murge	BA	B998
14343	Castellana Grotte	BA	C134
14344	Cellamare	BA	C436
14345	Conversano	BA	C975
14346	Corato	BA	C983
14347	Gioia del Colle	BA	E038
14348	Giovinazzo	BA	E047
14349	Gravina in Puglia	BA	E155
14350	Grumo Appula	BA	E223
14351	Locorotondo	BA	E645
14352	Modugno	BA	F262
14353	Mola di Bari	BA	F280
14354	Molfetta	BA	F284
14355	Monopoli	BA	F376
14356	Noci	BA	F915
14357	Noicattaro	BA	F923
14358	Palo del Colle	BA	G291
14359	Poggiorsini	BA	G769
14360	Polignano a Mare	BA	G787
14361	Putignano	BA	H096
14362	Rutigliano	BA	H643
14363	Ruvo di Puglia	BA	H645
14364	Sammichele di Bari	BA	H749
14365	Sannicandro di Bari	BA	I053
14366	Santeramo in Colle	BA	I330
14367	Terlizzi	BA	L109
14368	Toritto	BA	L220
14369	Triggiano	BA	L425
14370	Turi	BA	L472
14371	Valenzano	BA	L571
14372	Avetrana	TA	A514
14373	Carosino	TA	B808
14374	Castellaneta	TA	C136
14375	Crispiano	TA	D171
14376	Faggiano	TA	D463
14377	Fragagnano	TA	D754
14378	Ginosa	TA	E036
14379	Grottaglie	TA	E205
14380	Laterza	TA	E469
14381	Leporano	TA	E537
14382	Lizzano	TA	E630
14383	Manduria	TA	E882
14384	Martina Franca	TA	E986
14385	Maruggio	TA	E995
14386	Massafra	TA	F027
14387	Monteiasi	TA	F531
14388	Montemesola	TA	F563
14389	Monteparano	TA	F587
14390	Mottola	TA	F784
14391	Palagianello	TA	G251
14392	Palagiano	TA	G252
14393	Pulsano	TA	H090
14394	Roccaforzata	TA	H409
14395	San Giorgio Ionico	TA	H882
14396	San Marzano di San Giuseppe	TA	I018
14397	Sava	TA	I467
14398	Taranto	TA	L049
14399	Torricella	TA	L294
14400	Statte	TA	M298
14401	Brindisi	BR	B180
14402	Carovigno	BR	B809
14403	Ceglie Messapica	BR	C424
14404	Cellino San Marco	BR	C448
14405	Cisternino	BR	C741
14406	Erchie	BR	D422
14407	Fasano	BR	D508
14408	Francavilla Fontana	BR	D761
14409	Latiano	BR	E471
14410	Mesagne	BR	F152
14411	Oria	BR	G098
14412	Ostuni	BR	G187
14413	San Donaci	BR	H822
14414	San Michele Salentino	BR	I045
14415	San Pancrazio Salentino	BR	I066
14416	San Pietro Vernotico	BR	I119
14417	San Vito dei Normanni	BR	I396
14418	Torchiarolo	BR	L213
14419	Torre Santa Susanna	BR	L280
14420	Villa Castelli	BR	L920
14421	Alessano	LE	A184
14422	Alezio	LE	A185
14423	Alliste	LE	A208
14424	Andrano	LE	A281
14425	Aradeo	LE	A350
14426	Arnesano	LE	A425
14427	Bagnolo del Salento	LE	A572
14428	Botrugno	LE	B086
14429	Calimera	LE	B413
14430	Campi Salentina	LE	B506
14431	Cannole	LE	B616
14432	Caprarica di Lecce	LE	B690
14433	Carmiano	LE	B792
14434	Carpignano Salentino	LE	B822
14435	Casarano	LE	B936
14436	Castri di Lecce	LE	C334
14437	Castrignano de' Greci	LE	C335
14438	Castrignano del Capo	LE	C336
14439	Cavallino	LE	C377
14440	Collepasso	LE	C865
14441	Copertino	LE	C978
14442	Corigliano d'Otranto	LE	D006
14443	Corsano	LE	D044
14444	Cursi	LE	D223
14445	Cutrofiano	LE	D237
14446	Diso	LE	D305
14447	Gagliano del Capo	LE	D851
14448	Galatina	LE	D862
14449	Galatone	LE	D863
14450	Gallipoli	LE	D883
14451	Giuggianello	LE	E053
14452	Giurdignano	LE	E061
14453	Guagnano	LE	E227
14454	Lecce	LE	E506
14455	Lequile	LE	E538
14456	Leverano	LE	E563
14457	Lizzanello	LE	E629
14458	Maglie	LE	E815
14459	Martano	LE	E979
14460	Martignano	LE	E984
14461	Matino	LE	F054
14462	Melendugno	LE	F101
14463	Melissano	LE	F109
14464	Melpignano	LE	F117
14465	Miggiano	LE	F194
14466	Minervino di Lecce	LE	F221
14467	Monteroni di Lecce	LE	F604
14468	Montesano Salentino	LE	F623
14469	Morciano di Leuca	LE	F716
14470	Muro Leccese	LE	F816
14471	Nardò	LE	F842
14472	Neviano	LE	F881
14473	Nociglia	LE	F916
14474	Novoli	LE	F970
14475	Ortelle	LE	G136
14476	Otranto	LE	G188
14477	Palmariggi	LE	G285
14478	Parabita	LE	G325
14479	Patù	LE	G378
14480	Poggiardo	LE	G751
14481	Racale	LE	H147
14482	Ruffano	LE	H632
14483	Salice Salentino	LE	H708
14484	Salve	LE	H729
14485	Sanarica	LE	H757
14486	San Cesario di Lecce	LE	H793
14487	San Donato di Lecce	LE	H826
14488	Sannicola	LE	I059
14489	San Pietro in Lama	LE	I115
14490	Santa Cesarea Terme	LE	I172
14491	Scorrano	LE	I549
14492	Seclì	LE	I559
14493	Sogliano Cavour	LE	I780
14494	Soleto	LE	I800
14495	Specchia	LE	I887
14496	Spongano	LE	I923
14497	Squinzano	LE	I930
14498	Sternatia	LE	I950
14499	Supersano	LE	L008
14500	Surano	LE	L010
14501	Surbo	LE	L011
14502	Taurisano	LE	L064
14503	Taviano	LE	L074
14504	Tiggiano	LE	L166
14505	Trepuzzi	LE	L383
14506	Tricase	LE	L419
14507	Tuglie	LE	L462
14508	Ugento	LE	L484
14509	Uggiano la Chiesa	LE	L485
14510	Veglie	LE	L711
14511	Vernole	LE	L776
14512	Zollino	LE	M187
14513	San Cassiano	LE	M264
14514	Castro	LE	M261
14515	Porto Cesareo	LE	M263
14516	Presicce-Acquarica	LE	M428
14517	Andria	BT	A285
14518	Barletta	BT	A669
14519	Bisceglie	BT	A883
14520	Canosa di Puglia	BT	B619
14521	Margherita di Savoia	BT	E946
14522	Minervino Murge	BT	F220
14523	San Ferdinando di Puglia	BT	H839
14524	Spinazzola	BT	I907
14525	Trani	BT	L328
14526	Trinitapoli	BT	B915
14527	Abriola	PZ	A013
14528	Acerenza	PZ	A020
14529	Albano di Lucania	PZ	A131
14530	Anzi	PZ	A321
14531	Armento	PZ	A415
14532	Atella	PZ	A482
14533	Avigliano	PZ	A519
14534	Balvano	PZ	A604
14535	Banzi	PZ	A612
14536	Baragiano	PZ	A615
14537	Barile	PZ	A666
14538	Bella	PZ	A743
14539	Brienza	PZ	B173
14540	Brindisi Montagna	PZ	B181
14541	Calvello	PZ	B440
14542	Calvera	PZ	B443
14543	Campomaggiore	PZ	B549
14544	Cancellara	PZ	B580
14545	Carbone	PZ	B743
14546	San Paolo Albanese	PZ	B906
14547	Castelgrande	PZ	C120
14548	Castelluccio Inferiore	PZ	C199
14549	Castelluccio Superiore	PZ	C201
14550	Castelmezzano	PZ	C209
14551	Castelsaraceno	PZ	C271
14552	Castronuovo di Sant'Andrea	PZ	C345
14553	Cersosimo	PZ	C539
14554	Chiaromonte	PZ	C619
14555	Corleto Perticara	PZ	D010
14556	Episcopia	PZ	D414
14557	Fardella	PZ	D497
14558	Filiano	PZ	D593
14559	Forenza	PZ	D696
14560	Francavilla in Sinni	PZ	D766
14561	Gallicchio	PZ	D876
14562	Genzano di Lucania	PZ	D971
14563	Grumento Nova	PZ	E221
14564	Guardia Perticara	PZ	E246
14565	Lagonegro	PZ	E409
14566	Latronico	PZ	E474
14567	Laurenzana	PZ	E482
14568	Lauria	PZ	E483
14569	Lavello	PZ	E493
14570	Maratea	PZ	E919
14571	Marsico Nuovo	PZ	E976
14572	Marsicovetere	PZ	E977
14573	Maschito	PZ	F006
14574	Melfi	PZ	F104
14575	Missanello	PZ	F249
14576	Moliterno	PZ	F295
14577	Montemilone	PZ	F568
14578	Montemurro	PZ	F573
14579	Muro Lucano	PZ	F817
14580	Nemoli	PZ	F866
14581	Noepoli	PZ	F917
14582	Oppido Lucano	PZ	G081
14583	Palazzo San Gervasio	PZ	G261
14584	Pescopagano	PZ	G496
14585	Picerno	PZ	G590
14586	Pietragalla	PZ	G616
14587	Pietrapertosa	PZ	G623
14588	Pignola	PZ	G663
14589	Potenza	PZ	G942
14590	Rapolla	PZ	H186
14591	Rapone	PZ	H187
14592	Rionero in Vulture	PZ	H307
14593	Ripacandida	PZ	H312
14594	Rivello	PZ	H348
14595	Roccanova	PZ	H426
14596	Rotonda	PZ	H590
14597	Ruoti	PZ	H641
14598	Ruvo del Monte	PZ	H646
14599	San Chirico Nuovo	PZ	H795
14600	San Chirico Raparo	PZ	H796
14601	San Costantino Albanese	PZ	H808
14602	San Fele	PZ	H831
14603	San Martino d'Agri	PZ	H994
14604	San Severino Lucano	PZ	I157
14605	Sant'Angelo Le Fratte	PZ	I288
14606	Sant'Arcangelo	PZ	I305
14607	Sarconi	PZ	I426
14608	Sasso di Castalda	PZ	I457
14609	Satriano di Lucania	PZ	G614
14610	Savoia di Lucania	PZ	H730
14611	Senise	PZ	I610
14612	Spinoso	PZ	I917
14613	Teana	PZ	L082
14614	Terranova di Pollino	PZ	L126
14615	Tito	PZ	L181
14616	Tolve	PZ	L197
14617	Tramutola	PZ	L326
14618	Trecchina	PZ	L357
14619	Trivigno	PZ	L439
14620	Vaglio Basilicata	PZ	L532
14621	Venosa	PZ	L738
14622	Vietri di Potenza	PZ	L859
14623	Viggianello	PZ	L873
14624	Viggiano	PZ	L874
14625	Ginestra	PZ	E033
14626	Paterno	PZ	M269
14627	Accettura	MT	A017
14628	Aliano	MT	A196
14629	Bernalda	MT	A801
14630	Calciano	MT	B391
14631	Cirigliano	MT	C723
14632	Colobraro	MT	C888
14633	Craco	MT	D128
14634	Ferrandina	MT	D547
14635	Garaguso	MT	D909
14636	Gorgoglione	MT	E093
14637	Grassano	MT	E147
14638	Grottole	MT	E213
14639	Irsina	MT	E326
14640	Matera	MT	F052
14641	Miglionico	MT	F201
14642	Montalbano Jonico	MT	F399
14643	Montescaglioso	MT	F637
14644	Nova Siri	MT	A942
14645	Oliveto Lucano	MT	G037
14646	Pisticci	MT	G712
14647	Policoro	MT	G786
14648	Pomarico	MT	G806
14649	Rotondella	MT	H591
14650	Salandra	MT	H687
14651	San Giorgio Lucano	MT	H888
14652	San Mauro Forte	MT	I029
14653	Stigliano	MT	I954
14654	Tricarico	MT	L418
14655	Tursi	MT	L477
14656	Valsinni	MT	D513
14657	Scanzano Jonico	MT	M256
14658	Acquaformosa	CS	A033
14659	Acquappesa	CS	A041
14660	Acri	CS	A053
14661	Aiello Calabro	CS	A102
14662	Aieta	CS	A105
14663	Albidona	CS	A160
14664	Alessandria del Carretto	CS	A183
14665	Altilia	CS	A234
14666	Altomonte	CS	A240
14667	Amantea	CS	A253
14668	Amendolara	CS	A263
14669	Aprigliano	CS	A340
14670	Belmonte Calabro	CS	A762
14671	Belsito	CS	A768
14672	Belvedere Marittimo	CS	A773
14673	Bianchi	CS	A842
14674	Bisignano	CS	A887
14675	Bocchigliero	CS	A912
14676	Bonifati	CS	A973
14677	Buonvicino	CS	B270
14678	Calopezzati	CS	B424
14679	Caloveto	CS	B426
14680	Campana	CS	B500
14681	Canna	CS	B607
14682	Cariati	CS	B774
14683	Carolei	CS	B802
14684	Carpanzano	CS	B813
14685	Cassano all'Ionio	CS	C002
14686	Castiglione Cosentino	CS	C301
14687	Castrolibero	CS	C108
14688	Castroregio	CS	C348
14689	Castrovillari	CS	C349
14690	Celico	CS	C430
14691	Cellara	CS	C437
14692	Cerchiara di Calabria	CS	C489
14693	Cerisano	CS	C515
14694	Cervicati	CS	C554
14695	Cerzeto	CS	C560
14696	Cetraro	CS	C588
14697	Civita	CS	C763
14698	Cleto	CS	C795
14699	Colosimi	CS	C905
14700	Cosenza	CS	D086
14701	Cropalati	CS	D180
14702	Crosia	CS	D184
14703	Diamante	CS	D289
14704	Dipignano	CS	D304
14705	Domanico	CS	D328
14706	Fagnano Castello	CS	D464
14707	Falconara Albanese	CS	D473
14708	Figline Vegliaturo	CS	D582
14709	Firmo	CS	D614
14710	Fiumefreddo Bruzio	CS	D624
14711	Francavilla Marittima	CS	D764
14712	Frascineto	CS	D774
14713	Fuscaldo	CS	D828
14714	Grimaldi	CS	E180
14715	Grisolia	CS	E185
14716	Guardia Piemontese	CS	E242
14717	Lago	CS	E407
14718	Laino Borgo	CS	E417
14719	Laino Castello	CS	E419
14720	Lappano	CS	E450
14721	Lattarico	CS	E475
14722	Longobardi	CS	E677
14723	Longobucco	CS	E678
14724	Lungro	CS	E745
14725	Luzzi	CS	E773
14726	Maierà	CS	E835
14727	Malito	CS	E859
14728	Malvito	CS	E872
14729	Mandatoriccio	CS	E878
14730	Mangone	CS	E888
14731	Marano Marchesato	CS	E914
14732	Marano Principato	CS	E915
14733	Marzi	CS	F001
14734	Mendicino	CS	F125
14735	Mongrassano	CS	F370
14736	Montalto Uffugo	CS	F416
14737	Montegiordano	CS	F519
14738	Morano Calabro	CS	F708
14739	Mormanno	CS	F735
14740	Mottafollone	CS	F775
14741	Nocara	CS	F907
14742	Oriolo	CS	G110
14743	Orsomarso	CS	G129
14744	Paludi	CS	G298
14745	Panettieri	CS	G307
14746	Paola	CS	G317
14747	Papasidero	CS	G320
14748	Parenti	CS	G331
14749	Paterno Calabro	CS	G372
14750	Pedivigliano	CS	G411
14751	Piane Crati	CS	G553
14752	Pietrafitta	CS	G615
14753	Pietrapaola	CS	G622
14754	Plataci	CS	G733
14755	Praia a Mare	CS	G975
14756	Rende	CS	H235
14757	Rocca Imperiale	CS	H416
14758	Roggiano Gravina	CS	H488
14759	Rogliano	CS	H490
14760	Rose	CS	H565
14761	Roseto Capo Spulico	CS	H572
14762	Rota Greca	CS	H585
14763	Rovito	CS	H621
14764	San Basile	CS	H765
14765	San Benedetto Ullano	CS	H774
14766	San Cosmo Albanese	CS	H806
14767	San Demetrio Corone	CS	H818
14768	San Donato di Ninea	CS	H825
14769	San Fili	CS	H841
14770	Sangineto	CS	H877
14771	San Giorgio Albanese	CS	H881
14772	San Giovanni in Fiore	CS	H919
14773	San Lorenzo Bellizzi	CS	H961
14774	San Lorenzo del Vallo	CS	H962
14775	San Lucido	CS	H971
14776	San Marco Argentano	CS	H981
14777	San Martino di Finita	CS	H992
14778	San Nicola Arcella	CS	I060
14779	San Pietro in Amantea	CS	I108
14780	San Pietro in Guarano	CS	I114
14781	San Sosti	CS	I165
14782	Santa Caterina Albanese	CS	I171
14783	Santa Domenica Talao	CS	I183
14784	Sant'Agata di Esaro	CS	I192
14785	Santa Maria del Cedro	CS	C717
14786	Santa Sofia d'Epiro	CS	I309
14787	Santo Stefano di Rogliano	CS	I359
14788	San Vincenzo La Costa	CS	I388
14789	Saracena	CS	I423
14790	Scala Coeli	CS	I485
14791	Scalea	CS	I489
14792	Scigliano	CS	D290
14793	Serra d'Aiello	CS	I642
14794	Spezzano Albanese	CS	I895
14795	Spezzano della Sila	CS	I896
14796	Tarsia	CS	L055
14797	Terranova da Sibari	CS	L124
14798	Terravecchia	CS	L134
14799	Torano Castello	CS	L206
14800	Tortora	CS	L305
14801	Trebisacce	CS	L353
14802	Vaccarizzo Albanese	CS	L524
14803	Verbicaro	CS	L747
14804	Villapiana	CS	B903
14805	Zumpano	CS	M202
14806	Casali del Manco	CS	M385
14807	Corigliano-Rossano	CS	M403
14808	Albi	CZ	A155
14809	Amaroni	CZ	A255
14810	Amato	CZ	A257
14811	Andali	CZ	A272
14812	Argusto	CZ	A397
14813	Badolato	CZ	A542
14814	Belcastro	CZ	A736
14815	Borgia	CZ	B002
14816	Botricello	CZ	B085
14817	Caraffa di Catanzaro	CZ	B717
14818	Cardinale	CZ	B758
14819	Carlopoli	CZ	B790
14820	Catanzaro	CZ	C352
14821	Cenadi	CZ	C453
14822	Centrache	CZ	C472
14823	Cerva	CZ	C542
14824	Chiaravalle Centrale	CZ	C616
14825	Cicala	CZ	C674
14826	Conflenti	CZ	C960
14827	Cortale	CZ	D049
14828	Cropani	CZ	D181
14829	Curinga	CZ	D218
14830	Davoli	CZ	D257
14831	Decollatura	CZ	D261
14832	Falerna	CZ	D476
14833	Feroleto Antico	CZ	D544
14834	Fossato Serralta	CZ	D744
14835	Gagliato	CZ	D852
14836	Gasperina	CZ	D932
14837	Gimigliano	CZ	E031
14838	Girifalco	CZ	E050
14839	Gizzeria	CZ	E068
14840	Guardavalle	CZ	E239
14841	Isca sullo Ionio	CZ	E328
14842	Jacurso	CZ	E274
14843	Magisano	CZ	E806
14844	Maida	CZ	E834
14845	Marcedusa	CZ	E923
14846	Marcellinara	CZ	E925
14847	Martirano	CZ	E990
14848	Martirano Lombardo	CZ	E991
14849	Miglierina	CZ	F200
14850	Montauro	CZ	F432
14851	Montepaone	CZ	F586
14852	Motta Santa Lucia	CZ	F780
14853	Nocera Terinese	CZ	F910
14854	Olivadi	CZ	G034
14855	Palermiti	CZ	G272
14856	Pentone	CZ	G439
14857	Petrizzi	CZ	G517
14858	Petronà	CZ	G518
14859	Pianopoli	CZ	D546
14860	Platania	CZ	G734
14861	San Floro	CZ	H846
14862	San Mango d'Aquino	CZ	H976
14863	San Pietro a Maida	CZ	I093
14864	San Pietro Apostolo	CZ	I095
14865	San Sostene	CZ	I164
14866	Santa Caterina dello Ionio	CZ	I170
14867	Sant'Andrea Apostolo dello Ionio	CZ	I266
14868	San Vito sullo Ionio	CZ	I393
14869	Satriano	CZ	I463
14870	Sellia	CZ	I589
14871	Sellia Marina	CZ	I590
14872	Serrastretta	CZ	I655
14873	Sersale	CZ	I671
14874	Settingiano	CZ	I704
14875	Simeri Crichi	CZ	I745
14876	Sorbo San Basile	CZ	I844
14877	Soverato	CZ	I872
14878	Soveria Mannelli	CZ	I874
14879	Soveria Simeri	CZ	I875
14880	Squillace	CZ	I929
14881	Stalettì	CZ	I937
14882	Taverna	CZ	L070
14883	Tiriolo	CZ	L177
14884	Torre di Ruggiero	CZ	L240
14885	Vallefiorita	CZ	I322
14886	Zagarise	CZ	M140
14887	Lamezia Terme	CZ	M208
14888	Africo	RC	A065
14889	Agnana Calabra	RC	A077
14890	Anoia	RC	A303
14891	Antonimina	RC	A314
14892	Ardore	RC	A385
14893	Bagaladi	RC	A544
14894	Bagnara Calabra	RC	A552
14895	Benestare	RC	A780
14896	Bianco	RC	A843
14897	Bivongi	RC	A897
14898	Bova	RC	B097
14899	Bovalino	RC	B098
14900	Bova Marina	RC	B099
14901	Brancaleone	RC	B118
14902	Bruzzano Zeffirio	RC	B234
14903	Calanna	RC	B379
14904	Camini	RC	B481
14905	Campo Calabro	RC	B516
14906	Candidoni	RC	B591
14907	Canolo	RC	B617
14908	Caraffa del Bianco	RC	B718
14909	Cardeto	RC	B756
14910	Careri	RC	B766
14911	Casignana	RC	B966
14912	Caulonia	RC	C285
14913	Ciminà	RC	C695
14914	Cinquefrondi	RC	C710
14915	Cittanova	RC	C747
14916	Condofuri	RC	C954
14917	Cosoleto	RC	D089
14918	Delianuova	RC	D268
14919	Feroleto della Chiesa	RC	D545
14920	Ferruzzano	RC	D557
14921	Fiumara	RC	D619
14922	Galatro	RC	D864
14923	Gerace	RC	D975
14924	Giffone	RC	E025
14925	Gioia Tauro	RC	E041
14926	Gioiosa Ionica	RC	E044
14927	Grotteria	RC	E212
14928	Laganadi	RC	E402
14929	Laureana di Borrello	RC	E479
14930	Locri	RC	D976
14931	Mammola	RC	E873
14932	Marina di Gioiosa Ionica	RC	E956
14933	Maropati	RC	E968
14934	Martone	RC	E993
14935	Melicuccà	RC	F105
14936	Melicucco	RC	F106
14937	Melito di Porto Salvo	RC	F112
14938	Molochio	RC	F301
14939	Monasterace	RC	F324
14940	Montebello Jonico	RC	D746
14941	Motta San Giovanni	RC	F779
14942	Oppido Mamertina	RC	G082
14943	Palizzi	RC	G277
14944	Palmi	RC	G288
14945	Pazzano	RC	G394
14946	Placanica	RC	G729
14947	Platì	RC	G735
14948	Polistena	RC	G791
14949	Portigliola	RC	G905
14950	Reggio di Calabria	RC	H224
14951	Riace	RC	H265
14952	Rizziconi	RC	H359
14953	Roccaforte del Greco	RC	H408
14954	Roccella Ionica	RC	H456
14955	Roghudi	RC	H489
14956	Rosarno	RC	H558
14957	Samo	RC	H013
14958	San Giorgio Morgeto	RC	H889
14959	San Giovanni di Gerace	RC	H903
14960	San Lorenzo	RC	H959
14961	San Luca	RC	H970
14962	San Pietro di Caridà	RC	I102
14963	San Procopio	RC	I132
14964	San Roberto	RC	I139
14965	Santa Cristina d'Aspromonte	RC	I176
14966	Sant'Agata del Bianco	RC	I198
14967	Sant'Alessio in Aspromonte	RC	I214
14968	Sant'Eufemia d'Aspromonte	RC	I333
14969	Sant'Ilario dello Ionio	RC	I341
14970	Santo Stefano in Aspromonte	RC	I371
14971	Scido	RC	I536
14972	Scilla	RC	I537
14973	Seminara	RC	I600
14974	Serrata	RC	I656
14975	Siderno	RC	I725
7915	Agliè	TO	A074
7916	Airasca	TO	A109
7917	Ala di Stura	TO	A117
7918	Albiano d'Ivrea	TO	A157
7919	Almese	TO	A218
7920	Alpette	TO	A221
7921	Alpignano	TO	A222
7922	Andezeno	TO	A275
7923	Andrate	TO	A282
7924	Angrogna	TO	A295
7925	Arignano	TO	A405
7926	Avigliana	TO	A518
7927	Azeglio	TO	A525
7928	Bairo	TO	A584
7929	Balangero	TO	A587
7930	Baldissero Canavese	TO	A590
7931	Baldissero Torinese	TO	A591
7932	Balme	TO	A599
7933	Banchette	TO	A607
7934	Barbania	TO	A625
7935	Bardonecchia	TO	A651
7936	Barone Canavese	TO	A673
7937	Beinasco	TO	A734
7938	Bibiana	TO	A853
7939	Bobbio Pellice	TO	A910
7940	Bollengo	TO	A941
7941	Borgaro Torinese	TO	A990
7942	Borgiallo	TO	B003
7943	Borgofranco d'Ivrea	TO	B015
7944	Borgomasino	TO	B021
7945	Borgone Susa	TO	B024
7946	Bosconero	TO	B075
7947	Brandizzo	TO	B121
7948	Bricherasio	TO	B171
7949	Brosso	TO	B205
7950	Brozolo	TO	B209
7951	Bruino	TO	B216
7952	Brusasco	TO	B225
7953	Bruzolo	TO	B232
7954	Buriasco	TO	B278
7955	Burolo	TO	B279
7956	Busano	TO	B284
7957	Bussoleno	TO	B297
7958	Buttigliera Alta	TO	B305
7959	Cafasse	TO	B350
7960	Caluso	TO	B435
7961	Cambiano	TO	B462
7962	Campiglione Fenile	TO	B512
7963	Candia Canavese	TO	B588
7964	Candiolo	TO	B592
7965	Canischio	TO	B605
7966	Cantalupa	TO	B628
14976	Sinopoli	RC	I753
14977	Staiti	RC	I936
14978	Stignano	RC	I955
14979	Stilo	RC	I956
14980	Taurianova	RC	L063
14981	Terranova Sappo Minulio	RC	L127
14982	Varapodio	RC	L673
14983	Villa San Giovanni	RC	M018
14984	San Ferdinando	RC	M277
14985	Belvedere di Spinello	KR	A772
14986	Caccuri	KR	B319
14987	Carfizzi	KR	B771
14988	Casabona	KR	B857
14989	Castelsilano	KR	B968
14990	Cerenzia	KR	C501
14991	Cirò	KR	C725
14992	Cirò Marina	KR	C726
14993	Cotronei	KR	D123
14994	Crotone	KR	D122
14995	Crucoli	KR	D189
14996	Cutro	KR	D236
14997	Isola di Capo Rizzuto	KR	E339
14998	Melissa	KR	F108
14999	Mesoraca	KR	F157
15000	Pallagorio	KR	G278
15001	Petilia Policastro	KR	G508
15002	Roccabernarda	KR	H383
15003	Rocca di Neto	KR	H403
15004	San Mauro Marchesato	KR	I026
15005	San Nicola dell'Alto	KR	I057
15006	Santa Severina	KR	I308
15007	Savelli	KR	I468
15008	Scandale	KR	I494
15009	Strongoli	KR	I982
15010	Umbriatico	KR	L492
15011	Verzino	KR	L802
15012	Acquaro	VV	A043
15013	Arena	VV	A386
15014	Briatico	VV	B169
15015	Brognaturo	VV	B197
15016	Capistrano	VV	B655
15017	Cessaniti	VV	C581
15018	Dasà	VV	D253
15019	Dinami	VV	D303
15020	Drapia	VV	D364
15021	Fabrizia	VV	D453
15022	Filadelfia	VV	D587
15023	Filandari	VV	D589
15024	Filogaso	VV	D596
15025	Francavilla Angitola	VV	D762
15026	Francica	VV	D767
15027	Gerocarne	VV	D988
15028	Ionadi	VV	E321
15029	Joppolo	VV	E389
15030	Limbadi	VV	E590
15031	Maierato	VV	E836
15032	Mileto	VV	F207
15033	Mongiana	VV	F364
15034	Monterosso Calabro	VV	F607
15035	Nardodipace	VV	F843
15036	Nicotera	VV	F893
15037	Parghelia	VV	G335
15038	Pizzo	VV	G722
15039	Pizzoni	VV	G728
15040	Polia	VV	G785
15041	Ricadi	VV	H271
15042	Rombiolo	VV	H516
15043	San Calogero	VV	H785
15044	San Costantino Calabro	VV	H807
15045	San Gregorio d'Ippona	VV	H941
15046	San Nicola da Crissa	VV	I058
15047	Sant'Onofrio	VV	I350
15048	Serra San Bruno	VV	I639
15049	Simbario	VV	I744
15050	Sorianello	VV	I853
15051	Soriano Calabro	VV	I854
15052	Spadola	VV	I884
15053	Spilinga	VV	I905
15054	Stefanaconi	VV	I945
15055	Tropea	VV	L452
15056	Vallelonga	VV	L607
15057	Vazzano	VV	L699
15058	Vibo Valentia	VV	F537
15059	Zaccanopoli	VV	M138
15060	Zambrone	VV	M143
15061	Zungri	VV	M204
15062	Alcamo	TP	A176
15063	Buseto Palizzolo	TP	B288
15064	Calatafimi-Segesta	TP	B385
15065	Campobello di Mazara	TP	B521
15066	Castellammare del Golfo	TP	C130
15067	Castelvetrano	TP	C286
15068	Custonaci	TP	D234
15069	Erice	TP	D423
15070	Favignana	TP	D518
15071	Gibellina	TP	E023
15072	Marsala	TP	E974
15073	Mazara del Vallo	TP	F061
15074	Paceco	TP	G208
15075	Pantelleria	TP	G315
15076	Partanna	TP	G347
15077	Poggioreale	TP	G767
15078	Salaparuta	TP	H688
15079	Salemi	TP	H700
15080	Santa Ninfa	TP	I291
15081	San Vito Lo Capo	TP	I407
15082	Trapani	TP	L331
15083	Valderice	TP	G319
15084	Vita	TP	M081
15085	Petrosino	TP	M281
15086	Alia	PA	A195
15087	Alimena	PA	A202
15088	Aliminusa	PA	A203
15089	Altavilla Milicia	PA	A229
15090	Altofonte	PA	A239
15091	Bagheria	PA	A546
15092	Balestrate	PA	A592
15093	Baucina	PA	A719
15094	Belmonte Mezzagno	PA	A764
15095	Bisacquino	PA	A882
15096	Bolognetta	PA	A946
15097	Bompietro	PA	A958
15098	Borgetto	PA	A991
15099	Caccamo	PA	B315
15100	Caltavuturo	PA	B430
15101	Campofelice di Fitalia	PA	B533
15102	Campofelice di Roccella	PA	B532
15103	Campofiorito	PA	B535
15104	Camporeale	PA	B556
15105	Capaci	PA	B645
15106	Carini	PA	B780
15107	Castelbuono	PA	C067
15108	Casteldaccia	PA	C074
15109	Castellana Sicula	PA	C135
15110	Castronovo di Sicilia	PA	C344
15111	Cefalà Diana	PA	C420
15112	Cefalù	PA	C421
15113	Cerda	PA	C496
15114	Chiusa Sclafani	PA	C654
15115	Ciminna	PA	C696
15116	Cinisi	PA	C708
15117	Collesano	PA	C871
15118	Contessa Entellina	PA	C968
15119	Corleone	PA	D009
15120	Ficarazzi	PA	D567
15121	Gangi	PA	D907
15122	Geraci Siculo	PA	D977
15123	Giardinello	PA	E013
15124	Giuliana	PA	E055
15125	Godrano	PA	E074
15126	Gratteri	PA	E149
15127	Isnello	PA	E337
15128	Isola delle Femmine	PA	E350
15129	Lascari	PA	E459
15130	Lercara Friddi	PA	E541
15131	Marineo	PA	E957
15132	Mezzojuso	PA	F184
15133	Misilmeri	PA	F246
15134	Monreale	PA	F377
15135	Montelepre	PA	F544
15136	Montemaggiore Belsito	PA	F553
15137	Palazzo Adriano	PA	G263
15138	Palermo	PA	G273
15139	Partinico	PA	G348
15140	Petralia Soprana	PA	G510
15141	Petralia Sottana	PA	G511
15142	Piana degli Albanesi	PA	G543
15143	Polizzi Generosa	PA	G792
15144	Pollina	PA	G797
15145	Prizzi	PA	H070
15146	Roccamena	PA	H422
15147	Roccapalumba	PA	H428
15148	San Cipirello	PA	H797
15149	San Giuseppe Jato	PA	H933
15150	San Mauro Castelverde	PA	I028
15151	Santa Cristina Gela	PA	I174
15152	Santa Flavia	PA	I188
15153	Sciara	PA	I534
15154	Sclafani Bagni	PA	I541
15155	Termini Imerese	PA	L112
15156	Terrasini	PA	L131
15157	Torretta	PA	L282
15158	Trabia	PA	L317
15159	Trappeto	PA	L332
15160	Ustica	PA	L519
15161	Valledolmo	PA	L603
15162	Ventimiglia di Sicilia	PA	L740
15163	Vicari	PA	L837
15164	Villabate	PA	L916
15165	Villafrati	PA	L951
15166	Scillato	PA	I538
15167	Blufi	PA	M268
15168	Alcara li Fusi	ME	A177
15169	Alì	ME	A194
15170	Alì Terme	ME	A201
15171	Antillo	ME	A313
15172	Barcellona Pozzo di Gotto	ME	A638
15173	Basicò	ME	A698
15174	Brolo	ME	B198
15175	Capizzi	ME	B660
15176	Capo d'Orlando	ME	B666
15177	Capri Leone	ME	B695
15178	Caronia	ME	B804
15179	Casalvecchio Siculo	ME	B918
15180	Castel di Lucio	ME	C094
15181	Castell'Umberto	ME	C051
15182	Castelmola	ME	C210
15183	Castroreale	ME	C347
15184	Cesarò	ME	C568
15185	Condrò	ME	C956
15186	Falcone	ME	D474
15187	Ficarra	ME	D569
15188	Fiumedinisi	ME	D622
15189	Floresta	ME	D635
15190	Fondachelli-Fantina	ME	D661
15191	Forza d'Agrò	ME	D733
15192	Francavilla di Sicilia	ME	D765
15193	Frazzanò	ME	D793
15194	Furci Siculo	ME	D824
15195	Furnari	ME	D825
15196	Gaggi	ME	D844
15197	Galati Mamertino	ME	D861
15198	Gallodoro	ME	D885
15199	Giardini-Naxos	ME	E014
15200	Gioiosa Marea	ME	E043
15201	Graniti	ME	E142
15202	Gualtieri Sicaminò	ME	E233
15203	Itala	ME	E374
15204	Leni	ME	E523
15205	Letojanni	ME	E555
15206	Librizzi	ME	E571
15207	Limina	ME	E594
15208	Lipari	ME	E606
15209	Longi	ME	E674
15210	Malfa	ME	E855
15211	Malvagna	ME	E869
15212	Mandanici	ME	E876
15213	Mazzarrà Sant'Andrea	ME	F066
15214	Merì	ME	F147
15215	Messina	ME	F158
15216	Milazzo	ME	F206
15217	Militello Rosmarino	ME	F210
15218	Mirto	ME	F242
15219	Mistretta	ME	F251
15220	Moio Alcantara	ME	F277
15221	Monforte San Giorgio	ME	F359
15222	Mongiuffi Melia	ME	F368
15223	Montagnareale	ME	F395
15224	Montalbano Elicona	ME	F400
15225	Motta Camastra	ME	F772
15226	Motta d'Affermo	ME	F773
15227	Naso	ME	F848
15228	Nizza di Sicilia	ME	F901
15229	Novara di Sicilia	ME	F951
15230	Oliveri	ME	G036
15231	Pace del Mela	ME	G209
15232	Pagliara	ME	G234
15233	Patti	ME	G377
15234	Pettineo	ME	G522
15235	Piraino	ME	G699
15236	Raccuja	ME	H151
15237	Reitano	ME	H228
15238	Roccafiorita	ME	H405
15239	Roccalumera	ME	H418
15240	Roccavaldina	ME	H380
15241	Roccella Valdemone	ME	H455
15242	Rodì Milici	ME	H479
15243	Rometta	ME	H519
15244	San Filippo del Mela	ME	H842
15245	San Fratello	ME	H850
15246	San Marco d'Alunzio	ME	H982
15247	San Pier Niceto	ME	I084
15248	San Piero Patti	ME	I086
15249	San Salvatore di Fitalia	ME	I147
15250	Santa Domenica Vittoria	ME	I184
15251	Sant'Agata di Militello	ME	I199
15252	Sant'Alessio Siculo	ME	I215
15253	Santa Lucia del Mela	ME	I220
15254	Santa Marina Salina	ME	I254
15255	Sant'Angelo di Brolo	ME	I283
15256	Santa Teresa di Riva	ME	I311
15257	San Teodoro	ME	I328
15258	Santo Stefano di Camastra	ME	I370
15259	Saponara	ME	I420
15260	Savoca	ME	I477
15261	Scaletta Zanclea	ME	I492
15262	Sinagra	ME	I747
15263	Spadafora	ME	I881
15264	Taormina	ME	L042
15265	Torregrotta	ME	L271
15266	Tortorici	ME	L308
15267	Tripi	ME	L431
15268	Tusa	ME	L478
15269	Ucria	ME	L482
15270	Valdina	ME	L561
15271	Venetico	ME	L735
15272	Villafranca Tirrena	ME	L950
15273	Terme Vigliatore	ME	M210
15274	Acquedolci	ME	M211
15275	Torrenova	ME	M286
15276	Agrigento	AG	A089
15277	Alessandria della Rocca	AG	A181
15278	Aragona	AG	A351
15279	Bivona	AG	A896
15280	Burgio	AG	B275
15281	Calamonaci	AG	B377
15282	Caltabellotta	AG	B427
15283	Camastra	AG	B460
15284	Cammarata	AG	B486
15285	Campobello di Licata	AG	B520
15286	Canicattì	AG	B602
15287	Casteltermini	AG	C275
15288	Castrofilippo	AG	C341
15289	Cattolica Eraclea	AG	C356
15290	Cianciana	AG	C668
15291	Comitini	AG	C928
15292	Favara	AG	D514
15293	Grotte	AG	E209
15294	Joppolo Giancaxio	AG	E390
15295	Lampedusa e Linosa	AG	E431
15296	Licata	AG	E573
15297	Lucca Sicula	AG	E714
15298	Menfi	AG	F126
15299	Montallegro	AG	F414
15300	Montevago	AG	F655
15301	Naro	AG	F845
15302	Palma di Montechiaro	AG	G282
15303	Porto Empedocle	AG	F299
15304	Racalmuto	AG	H148
15305	Raffadali	AG	H159
15306	Ravanusa	AG	H194
15307	Realmonte	AG	H205
15308	Ribera	AG	H269
15309	Sambuca di Sicilia	AG	H743
15310	San Biagio Platani	AG	H778
15311	San Giovanni Gemini	AG	H914
15312	Santa Elisabetta	AG	I185
15313	Santa Margherita di Belice	AG	I224
15314	Sant'Angelo Muxaro	AG	I290
15315	Santo Stefano Quisquina	AG	I356
15316	Sciacca	AG	I533
15317	Siculiana	AG	I723
15318	Villafranca Sicula	AG	L944
15319	Acquaviva Platani	CL	A049
15320	Bompensiere	CL	A957
15321	Butera	CL	B302
15322	Caltanissetta	CL	B429
15323	Campofranco	CL	B537
15324	Delia	CL	D267
15325	Gela	CL	D960
15326	Marianopoli	CL	E953
15327	Mazzarino	CL	F065
15328	Milena	CL	E618
15329	Montedoro	CL	F489
15330	Mussomeli	CL	F830
15331	Niscemi	CL	F899
15332	Resuttano	CL	H245
15333	Riesi	CL	H281
15334	San Cataldo	CL	H792
15335	Santa Caterina Villarmosa	CL	I169
15336	Serradifalco	CL	I644
15337	Sommatino	CL	I824
15338	Sutera	CL	L016
15339	Vallelunga Pratameno	CL	L609
15340	Villalba	CL	L959
15341	Agira	EN	A070
15342	Aidone	EN	A098
15343	Assoro	EN	A478
15344	Barrafranca	EN	A676
15345	Calascibetta	EN	B381
15346	Catenanuova	EN	C353
15347	Centuripe	EN	C471
15348	Cerami	EN	C480
15349	Enna	EN	C342
15350	Gagliano Castelferrato	EN	D849
15351	Leonforte	EN	E536
15352	Nicosia	EN	F892
15353	Nissoria	EN	F900
15354	Piazza Armerina	EN	G580
15355	Pietraperzia	EN	G624
15356	Regalbuto	EN	H221
15357	Sperlinga	EN	I891
15358	Troina	EN	L448
15359	Valguarnera Caropepe	EN	L583
15360	Villarosa	EN	M011
15361	Aci Bonaccorsi	CT	A025
15362	Aci Castello	CT	A026
15363	Aci Catena	CT	A027
15364	Acireale	CT	A028
15365	Aci Sant'Antonio	CT	A029
15366	Adrano	CT	A056
15367	Belpasso	CT	A766
15368	Biancavilla	CT	A841
15369	Bronte	CT	B202
15370	Calatabiano	CT	B384
15371	Caltagirone	CT	B428
15372	Camporotondo Etneo	CT	B561
15373	Castel di Iudica	CT	C091
15374	Castiglione di Sicilia	CT	C297
15375	Catania	CT	C351
15376	Fiumefreddo di Sicilia	CT	D623
15377	Giarre	CT	E017
15378	Grammichele	CT	E133
15379	Gravina di Catania	CT	E156
15380	Licodia Eubea	CT	E578
15381	Linguaglossa	CT	E602
15382	Maletto	CT	E854
15383	Mascali	CT	F004
15384	Mascalucia	CT	F005
15385	Militello in Val di Catania	CT	F209
15386	Milo	CT	F214
15387	Mineo	CT	F217
15388	Mirabella Imbaccari	CT	F231
15389	Misterbianco	CT	F250
15390	Motta Sant'Anastasia	CT	F781
15391	Nicolosi	CT	F890
15392	Palagonia	CT	G253
15393	Paternò	CT	G371
15394	Pedara	CT	G402
15395	Piedimonte Etneo	CT	G597
15396	Raddusa	CT	H154
15397	Ramacca	CT	H168
15398	Randazzo	CT	H175
15399	Riposto	CT	H325
15400	San Cono	CT	H805
15401	San Giovanni la Punta	CT	H922
15402	San Gregorio di Catania	CT	H940
15403	San Michele di Ganzaria	CT	I035
15404	San Pietro Clarenza	CT	I098
15405	Sant'Agata li Battiati	CT	I202
15406	Sant'Alfio	CT	I216
15407	Santa Maria di Licodia	CT	I240
15408	Santa Venerina	CT	I314
15409	Scordia	CT	I548
15410	Trecastagni	CT	L355
15411	Tremestieri Etneo	CT	L369
15412	Valverde	CT	L658
15413	Viagrande	CT	L828
15414	Vizzini	CT	M100
15415	Zafferana Etnea	CT	M139
15416	Mazzarrone	CT	M271
15417	Maniace	CT	M283
15418	Ragalna	CT	M287
15419	Acate	RG	A014
15420	Chiaramonte Gulfi	RG	C612
15421	Comiso	RG	C927
15422	Giarratana	RG	E016
15423	Ispica	RG	E366
15424	Modica	RG	F258
15425	Monterosso Almo	RG	F610
15426	Pozzallo	RG	G953
15427	Ragusa	RG	H163
15428	Santa Croce Camerina	RG	I178
15429	Scicli	RG	I535
15430	Vittoria	RG	M088
15431	Augusta	SR	A494
15432	Avola	SR	A522
15433	Buccheri	SR	B237
15434	Buscemi	SR	B287
15435	Canicattini Bagni	SR	B603
15436	Carlentini	SR	B787
15437	Cassaro	SR	C006
15438	Ferla	SR	D540
15439	Floridia	SR	D636
15440	Francofonte	SR	D768
15441	Lentini	SR	E532
15442	Melilli	SR	F107
15443	Noto	SR	F943
15444	Pachino	SR	G211
15445	Palazzolo Acreide	SR	G267
15446	Rosolini	SR	H574
15447	Siracusa	SR	I754
15448	Solarino	SR	I785
15449	Sortino	SR	I864
15450	Portopalo di Capo Passero	SR	M257
15451	Priolo Gargallo	SR	M279
15452	Aggius	SS	A069
15453	Alà dei Sardi	SS	A115
15454	Alghero	SS	A192
15455	Anela	SS	A287
15456	Ardara	SS	A379
15457	Arzachena	SS	A453
15458	Banari	SS	A606
15459	Benetutti	SS	A781
15460	Berchidda	SS	A789
15461	Bessude	SS	A827
15462	Bonnanaro	SS	A976
15463	Bono	SS	A977
15464	Bonorva	SS	A978
15465	Bortigiadas	SS	B063
15466	Borutta	SS	B064
15467	Bottidda	SS	B094
15468	Buddusò	SS	B246
15469	Bultei	SS	B264
15470	Bulzi	SS	B265
15471	Burgos	SS	B276
15472	Calangianus	SS	B378
15473	Cargeghe	SS	B772
15474	Castelsardo	SS	C272
15475	Cheremule	SS	C600
15476	Chiaramonti	SS	C613
15477	Codrongianos	SS	C818
15478	Cossoine	SS	D100
15479	Esporlatu	SS	D441
15480	Florinas	SS	D637
15481	Giave	SS	E019
15482	Illorai	SS	E285
15483	Ittireddu	SS	E376
15484	Ittiri	SS	E377
15485	Laerru	SS	E401
15486	La Maddalena	SS	E425
15487	Luogosanto	SS	E747
15488	Luras	SS	E752
15489	Mara	SS	E902
15490	Martis	SS	E992
15491	Monteleone Rocca Doria	SS	F542
15492	Monti	SS	F667
15493	Mores	SS	F721
15494	Muros	SS	F818
15495	Nughedu San Nicolò	SS	F975
15496	Nule	SS	F976
15497	Nulvi	SS	F977
15498	Olbia	SS	G015
15499	Olmedo	SS	G046
15500	Oschiri	SS	G153
15501	Osilo	SS	G156
15502	Ossi	SS	G178
15503	Ozieri	SS	G203
15504	Padria	SS	G225
15505	Palau	SS	G258
15506	Pattada	SS	G376
15507	Perfugas	SS	G450
15508	Ploaghe	SS	G740
15509	Porto Torres	SS	G924
15510	Pozzomaggiore	SS	G962
15511	Putifigari	SS	H095
15512	Romana	SS	H507
15513	Aglientu	SS	H848
15514	Santa Teresa Gallura	SS	I312
15515	Sassari	SS	I452
15516	Sedini	SS	I565
15517	Semestene	SS	I598
15518	Sennori	SS	I614
15519	Siligo	SS	I732
15520	Sorso	SS	I863
15521	Tempio Pausania	SS	L093
15522	Thiesi	SS	L158
15523	Tissi	SS	L180
15524	Torralba	SS	L235
15525	Trinità d'Agultu e Vignola	SS	L428
15526	Tula	SS	L464
15527	Uri	SS	L503
15528	Usini	SS	L509
15529	Villanova Monteleone	SS	L989
15530	Valledoria	SS	L604
15531	Telti	SS	L088
15532	Badesi	SS	M214
15533	Viddalba	SS	M259
15534	Golfo Aranci	SS	M274
15535	Loiri Porto San Paolo	SS	M275
15536	Sant'Antonio di Gallura	SS	M276
15537	Tergu	SS	M282
15538	Santa Maria Coghinas	SS	M284
15539	Erula	SS	M292
15540	Stintino	SS	M290
15541	Padru	SS	M301
15542	Budoni	SS	B248
15543	San Teodoro	SS	I329
15544	Aritzo	NU	A407
15545	Arzana	NU	A454
15546	Atzara	NU	A492
15547	Austis	NU	A503
15548	Bari Sardo	NU	A663
15549	Baunei	NU	A722
15550	Belvì	NU	A776
15551	Birori	NU	A880
15552	Bitti	NU	A895
15553	Bolotana	NU	A948
15554	Borore	NU	B056
15555	Bortigali	NU	B062
15556	Desulo	NU	D287
15557	Dorgali	NU	D345
15558	Dualchi	NU	D376
15559	Elini	NU	D395
15560	Fonni	NU	D665
15561	Gadoni	NU	D842
15562	Gairo	NU	D859
15563	Galtellì	NU	D888
15564	Gavoi	NU	D947
15565	Girasole	NU	E049
15566	Ilbono	NU	E283
15567	Irgoli	NU	E323
15568	Jerzu	NU	E387
15569	Lanusei	NU	E441
15570	Lei	NU	E517
15571	Loceri	NU	E644
15572	Loculi	NU	E646
15573	Lodè	NU	E647
15574	Lotzorai	NU	E700
15575	Lula	NU	E736
15576	Macomer	NU	E788
15577	Mamoiada	NU	E874
15578	Meana Sardo	NU	F073
15579	Noragugume	NU	F933
15580	Nuoro	NU	F979
15581	Oliena	NU	G031
15582	Ollolai	NU	G044
15583	Olzai	NU	G058
15584	Onanì	NU	G064
15585	Onifai	NU	G070
15586	Oniferi	NU	G071
15587	Orani	NU	G084
15588	Orgosolo	NU	G097
15589	Orosei	NU	G119
15590	Orotelli	NU	G120
15591	Ortueri	NU	G146
15592	Orune	NU	G147
15593	Osidda	NU	G154
15594	Osini	NU	G158
15595	Ottana	NU	G191
15596	Ovodda	NU	G201
15597	Perdasdefogu	NU	G445
15598	Posada	NU	G929
15599	Sarule	NU	I448
15600	Silanus	NU	I730
15601	Sindia	NU	I748
15602	Siniscola	NU	I751
15603	Sorgono	NU	I851
15604	Talana	NU	L036
15605	Tertenia	NU	L140
15606	Teti	NU	L153
15607	Tiana	NU	L160
15608	Tonara	NU	L202
15609	Torpè	NU	L231
15610	Tortolì	NU	A355
15611	Triei	NU	L423
15612	Ulassai	NU	L489
15613	Urzulei	NU	L506
15614	Ussassai	NU	L514
15615	Villagrande Strisaili	NU	L953
15616	Cardedu	NU	M285
15617	Lodine	NU	E649
15618	Assemini	CA	A474
15619	Cagliari	CA	B354
15620	Capoterra	CA	B675
15621	Decimomannu	CA	D259
15622	Maracalagonis	CA	E903
15623	Pula	CA	H088
15624	Quartu Sant'Elena	CA	H118
15625	Sarroch	CA	I443
15626	Selargius	CA	I580
15627	Sestu	CA	I695
15628	Settimo San Pietro	CA	I699
15629	Sinnai	CA	I752
15630	Uta	CA	L521
15631	Villa San Pietro	CA	I118
15632	Quartucciu	CA	H119
15633	Elmas	CA	D399
15634	Monserrato	CA	F383
15635	Abbasanta	OR	A007
15636	Aidomaggiore	OR	A097
15637	Albagiara	OR	A126
15638	Ales	OR	A180
15639	Allai	OR	A204
15640	Arborea	OR	A357
15641	Ardauli	OR	A380
15642	Assolo	OR	A477
15643	Asuni	OR	A480
15644	Baradili	OR	A614
15645	Baratili San Pietro	OR	A621
15646	Baressa	OR	A655
15647	Bauladu	OR	A721
15648	Bidonì	OR	A856
15649	Bonarcado	OR	A960
15650	Boroneddu	OR	B055
15651	Busachi	OR	B281
15652	Cabras	OR	B314
15653	Cuglieri	OR	D200
15654	Fordongianus	OR	D695
15655	Ghilarza	OR	E004
15656	Gonnoscodina	OR	E087
15657	Gonnosnò	OR	D585
15658	Gonnostramatza	OR	E088
15659	Marrubiu	OR	E972
15660	Masullas	OR	F050
15661	Milis	OR	F208
15662	Mogorella	OR	F270
15663	Mogoro	OR	F272
15664	Morgongiori	OR	F727
15665	Narbolia	OR	F840
15666	Neoneli	OR	F867
15667	Norbello	OR	F934
15668	Nughedu Santa Vittoria	OR	F974
15669	Nurachi	OR	F980
15670	Nureci	OR	F985
15671	Ollastra	OR	G043
15672	Oristano	OR	G113
15673	Palmas Arborea	OR	G286
15674	Pau	OR	G379
15675	Paulilatino	OR	G384
15676	Pompu	OR	G817
15677	Riola Sardo	OR	H301
15678	Ruinas	OR	F271
15679	Samugheo	OR	H756
15680	San Nicolò d'Arcidano	OR	A368
15681	Santa Giusta	OR	I205
15682	Villa Sant'Antonio	OR	I298
15683	Santu Lussurgiu	OR	I374
15684	San Vero Milis	OR	I384
15685	Scano di Montiferro	OR	I503
15686	Sedilo	OR	I564
15687	Seneghe	OR	I605
15688	Senis	OR	I609
15689	Sennariolo	OR	I613
15690	Siamaggiore	OR	I717
15691	Siamanna	OR	I718
15692	Simala	OR	I742
15693	Simaxis	OR	I743
15694	Sini	OR	I749
15695	Siris	OR	I757
15696	Solarussa	OR	I791
15697	Sorradile	OR	I861
15698	Tadasuni	OR	L023
15699	Terralba	OR	L122
15700	Tramatza	OR	L321
15701	Tresnuraghes	OR	L393
15702	Ulà Tirso	OR	L488
15703	Uras	OR	L496
15704	Usellus	OR	L508
15705	Villanova Truschedu	OR	L991
15706	Villaurbana	OR	M030
15707	Villa Verde	OR	A609
15708	Zeddiani	OR	M153
15709	Zerfaliu	OR	M168
15710	Siapiccia	OR	I721
15711	Curcuris	OR	D214
15712	Soddì	OR	I778
15713	Bosa	OR	B068
15714	Flussio	OR	D640
15715	Laconi	OR	E400
15716	Magomadas	OR	E825
15717	Modolo	OR	F261
15718	Montresta	OR	F698
15719	Sagama	OR	H661
15720	Suni	OR	L006
15721	Tinnura	OR	L172
15722	Arbus	SU	A359
15723	Armungia	SU	A419
15724	Ballao	SU	A597
15725	Barrali	SU	A677
15726	Barumini	SU	A681
15727	Buggerru	SU	B250
15728	Burcei	SU	B274
15729	Calasetta	SU	B383
15730	Carbonia	SU	B745
15731	Carloforte	SU	B789
15732	Castiadas	SU	M288
15733	Collinas	SU	C882
15734	Decimoputzu	SU	D260
15735	Dolianova	SU	D323
15736	Domus de Maria	SU	D333
15737	Domusnovas	SU	D334
15738	Donori	SU	D344
15739	Escalaplano	SU	D430
15740	Escolca	SU	D431
15741	Esterzili	SU	D443
15742	Fluminimaggiore	SU	D639
15743	Furtei	SU	D827
15744	Genoni	SU	D968
15745	Genuri	SU	D970
15746	Gergei	SU	D982
15747	Gesico	SU	D994
15748	Gesturi	SU	D997
15749	Giba	SU	E022
15750	Goni	SU	E084
15751	Gonnesa	SU	E086
15752	Gonnosfanadiga	SU	E085
15753	Guamaggiore	SU	E234
15754	Guasila	SU	E252
15755	Guspini	SU	E270
15756	Iglesias	SU	E281
15757	Isili	SU	E336
15758	Las Plassas	SU	E464
15759	Lunamatrona	SU	E742
15760	Mandas	SU	E877
15761	Masainas	SU	M270
15762	Monastir	SU	F333
9628	Rho	MI	H264
9880	Valbondione	BG	L544
9881	Valbrembo	BG	L545
9882	Valgoglio	BG	L579
9883	Valleve	BG	L623
9884	Valnegra	BG	L642
9885	Valtorta	BG	L655
9886	Vedeseta	BG	L707
9887	Verdellino	BG	L752
9888	Verdello	BG	L753
9889	Vertova	BG	L795
9890	Viadanica	BG	L827
9891	Vigano San Martino	BG	L865
9892	Vigolo	BG	L894
9893	Villa d'Adda	BG	L929
9894	Villa d'Almè	BG	A215
9895	Villa di Serio	BG	L936
9896	Villa d'Ogna	BG	L938
9897	Villongo	BG	M045
9898	Vilminore di Scalve	BG	M050
9899	Zandobbio	BG	M144
9900	Zanica	BG	M147
9901	Zogno	BG	M184
9902	Costa Serina	BG	D111
9903	Algua	BG	A193
9904	Cornalba	BG	D016
9905	Medolago	BG	F085
9906	Solza	BG	I813
9907	Sant'Omobono Terme	BG	M333
9908	Val Brembilla	BG	M334
9909	Acquafredda	BS	A034
9910	Adro	BS	A060
9911	Agnosine	BS	A082
9912	Alfianello	BS	A188
9913	Anfo	BS	A288
9914	Angolo Terme	BS	A293
9915	Artogne	BS	A451
9916	Azzano Mella	BS	A529
9917	Bagnolo Mella	BS	A569
9918	Bagolino	BS	A578
9919	Barbariga	BS	A630
9920	Barghe	BS	A661
9921	Bassano Bresciano	BS	A702
9922	Bedizzole	BS	A729
9923	Berlingo	BS	A799
9924	Berzo Demo	BS	A816
9925	Berzo Inferiore	BS	A817
9926	Bienno	BS	A861
9927	Bione	BS	A878
9928	Borgo San Giacomo	BS	B035
9929	Borgosatollo	BS	B040
9930	Borno	BS	B054
9931	Botticino	BS	B091
9932	Bovegno	BS	B100
9933	Bovezzo	BS	B102
9934	Brandico	BS	B120
9935	Braone	BS	B124
9936	Breno	BS	B149
9937	Brescia	BS	B157
10031	Ome	BS	G061
11882	Avegno	GE	A506
15763	Muravera	SU	F808
15764	Musei	SU	F822
15765	Narcao	SU	F841
15766	Nuragus	SU	F981
15767	Nurallao	SU	F982
15768	Nuraminis	SU	F983
15769	Nurri	SU	F986
15770	Nuxis	SU	F991
15771	Orroli	SU	G122
15772	Ortacesus	SU	G133
15773	Pabillonis	SU	G207
15774	Pauli Arbarei	SU	G382
15775	Perdaxius	SU	G446
15776	Pimentel	SU	G669
15777	Piscinas	SU	M291
15778	Portoscuso	SU	G922
15779	Sadali	SU	H659
15780	Samassi	SU	H738
15781	Samatzai	SU	H739
15782	San Basilio	SU	H766
15783	San Gavino Monreale	SU	H856
15784	San Giovanni Suergiu	SU	G287
15785	San Nicolò Gerrei	SU	G383
15786	San Sperate	SU	I166
15787	San Vito	SU	I402
15788	Sanluri	SU	H974
15789	Santadi	SU	I182
15790	Sant'Andrea Frius	SU	I271
15791	Sant'Anna Arresi	SU	M209
15792	Sant'Antioco	SU	I294
15793	Sardara	SU	I428
15794	Segariu	SU	I570
15795	Selegas	SU	I582
15796	Senorbì	SU	I615
15797	Serdiana	SU	I624
15798	Serramanna	SU	I647
15799	Serrenti	SU	I667
15800	Serri	SU	I668
15801	Setzu	SU	I705
15802	Seui	SU	I706
15803	Seulo	SU	I707
15804	Siddi	SU	I724
15805	Siliqua	SU	I734
15806	Silius	SU	I735
15807	Siurgus Donigala	SU	I765
15808	Soleminis	SU	I797
15809	Suelli	SU	I995
15810	Teulada	SU	L154
15811	Tratalias	SU	L337
15812	Tuili	SU	L463
15813	Turri	SU	L473
15814	Ussana	SU	L512
15815	Ussaramanna	SU	L513
15816	Vallermosa	SU	L613
15817	Villacidro	SU	L924
15818	Villamar	SU	L966
15819	Villamassargia	SU	L968
15820	Villanova Tulo	SU	L992
15821	Villanovaforru	SU	L986
15822	Villanovafranca	SU	L987
15823	Villaperuccio	SU	M278
15824	Villaputzu	SU	L998
15825	Villasalto	SU	M016
15826	Villasimius	SU	B738
15827	Villasor	SU	M025
15828	Villaspeciosa	SU	M026
\.


--
-- Data for Name: doctor_exams; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.doctor_exams (doctor_id, exam_id) FROM stdin;
matteo.pugliese@hotmail.com	1154
matteo.pugliese@hotmail.com	86
matteo.pugliese@hotmail.com	1003
matteo.pugliese@hotmail.com	330
matteo.pugliese@hotmail.com	2325
matteo.pugliese@hotmail.com	1043
matteo.pugliese@hotmail.com	256
matteo.pugliese@hotmail.com	2812
matteo.pugliese@hotmail.com	2473
matteo.pugliese@hotmail.com	1953
matteo.pugliese@hotmail.com	2156
matteo.pugliese@hotmail.com	829
matteo.pugliese@hotmail.com	840
matteo.pugliese@hotmail.com	2728
matteo.pugliese@hotmail.com	1443
matteo.pugliese@hotmail.com	1142
matteo.pugliese@hotmail.com	1693
matteo.pugliese@hotmail.com	422
matteo.pugliese@hotmail.com	2149
matteo.pugliese@hotmail.com	1491
matteo.pugliese@hotmail.com	1969
matteo.pugliese@hotmail.com	2533
matteo.pugliese@hotmail.com	1839
matteo.pugliese@hotmail.com	1472
matteo.pugliese@hotmail.com	2322
matteo.pugliese@hotmail.com	2217
matteo.pugliese@hotmail.com	22
matteo.pugliese@hotmail.com	2280
matteo.pugliese@hotmail.com	37
matteo.pugliese@hotmail.com	2494
matteo.pugliese@hotmail.com	498
matteo.pugliese@hotmail.com	2104
matteo.pugliese@hotmail.com	1408
matteo.pugliese@hotmail.com	926
matteo.pugliese@hotmail.com	309
matteo.pugliese@hotmail.com	456
matteo.pugliese@hotmail.com	1476
matteo.pugliese@hotmail.com	1874
matteo.pugliese@hotmail.com	410
matteo.pugliese@hotmail.com	1294
matteo.pugliese@hotmail.com	2740
matteo.pugliese@hotmail.com	88
matteo.pugliese@hotmail.com	1165
matteo.pugliese@hotmail.com	2610
matteo.pugliese@hotmail.com	341
matteo.pugliese@hotmail.com	2265
matteo.pugliese@hotmail.com	1806
matteo.pugliese@hotmail.com	616
matteo.pugliese@hotmail.com	436
matteo.pugliese@hotmail.com	251
matteo.pugliese@hotmail.com	2408
matteo.pugliese@hotmail.com	1313
matteo.pugliese@hotmail.com	1453
matteo.pugliese@hotmail.com	1548
matteo.pugliese@hotmail.com	2263
matteo.pugliese@hotmail.com	1056
matteo.pugliese@hotmail.com	2703
matteo.pugliese@hotmail.com	2082
matteo.pugliese@hotmail.com	2167
matteo.pugliese@hotmail.com	1556
matteo.pugliese@hotmail.com	1282
matteo.pugliese@hotmail.com	1588
matteo.pugliese@hotmail.com	1237
matteo.pugliese@hotmail.com	1278
matteo.pugliese@hotmail.com	2027
matteo.pugliese@hotmail.com	219
matteo.pugliese@hotmail.com	421
matteo.pugliese@hotmail.com	1964
matteo.pugliese@hotmail.com	948
matteo.pugliese@hotmail.com	589
matteo.pugliese@hotmail.com	1772
matteo.pugliese@hotmail.com	2306
matteo.pugliese@hotmail.com	423
matteo.pugliese@hotmail.com	316
matteo.pugliese@hotmail.com	2587
matteo.pugliese@hotmail.com	306
matteo.pugliese@hotmail.com	2644
matteo.pugliese@hotmail.com	805
matteo.pugliese@hotmail.com	1903
matteo.pugliese@hotmail.com	2063
matteo.pugliese@hotmail.com	1869
matteo.pugliese@hotmail.com	2093
matteo.pugliese@hotmail.com	478
matteo.pugliese@hotmail.com	1748
matteo.pugliese@hotmail.com	638
matteo.pugliese@hotmail.com	2595
matteo.pugliese@hotmail.com	1080
matteo.pugliese@hotmail.com	275
matteo.pugliese@hotmail.com	300
matteo.pugliese@hotmail.com	2584
matteo.pugliese@hotmail.com	1617
matteo.pugliese@hotmail.com	2371
matteo.pugliese@hotmail.com	502
matteo.pugliese@hotmail.com	973
matteo.pugliese@hotmail.com	2619
matteo.pugliese@hotmail.com	750
matteo.pugliese@hotmail.com	1695
matteo.pugliese@hotmail.com	1682
matteo.pugliese@hotmail.com	1099
matteo.pugliese@hotmail.com	1975
irma.cimini@hotmail.com	2203
irma.cimini@hotmail.com	356
irma.cimini@hotmail.com	1236
irma.cimini@hotmail.com	79
irma.cimini@hotmail.com	2614
irma.cimini@hotmail.com	2101
irma.cimini@hotmail.com	489
irma.cimini@hotmail.com	2724
irma.cimini@hotmail.com	1674
irma.cimini@hotmail.com	2698
irma.cimini@hotmail.com	460
irma.cimini@hotmail.com	649
irma.cimini@hotmail.com	2138
irma.cimini@hotmail.com	2228
irma.cimini@hotmail.com	1694
irma.cimini@hotmail.com	1695
irma.cimini@hotmail.com	1747
irma.cimini@hotmail.com	2561
irma.cimini@hotmail.com	2220
irma.cimini@hotmail.com	399
irma.cimini@hotmail.com	2599
irma.cimini@hotmail.com	2443
irma.cimini@hotmail.com	423
irma.cimini@hotmail.com	2489
irma.cimini@hotmail.com	1637
irma.cimini@hotmail.com	384
irma.cimini@hotmail.com	128
irma.cimini@hotmail.com	1297
irma.cimini@hotmail.com	959
irma.cimini@hotmail.com	844
irma.cimini@hotmail.com	1648
irma.cimini@hotmail.com	679
irma.cimini@hotmail.com	1258
irma.cimini@hotmail.com	1126
irma.cimini@hotmail.com	1274
irma.cimini@hotmail.com	734
irma.cimini@hotmail.com	2283
irma.cimini@hotmail.com	696
irma.cimini@hotmail.com	2776
irma.cimini@hotmail.com	2050
irma.cimini@hotmail.com	361
irma.cimini@hotmail.com	759
irma.cimini@hotmail.com	67
irma.cimini@hotmail.com	465
irma.cimini@hotmail.com	1924
irma.cimini@hotmail.com	2100
irma.cimini@hotmail.com	2271
irma.cimini@hotmail.com	965
irma.cimini@hotmail.com	2490
irma.cimini@hotmail.com	2697
irma.cimini@hotmail.com	2569
irma.cimini@hotmail.com	1108
irma.cimini@hotmail.com	2357
irma.cimini@hotmail.com	2681
irma.cimini@hotmail.com	1501
irma.cimini@hotmail.com	1710
irma.cimini@hotmail.com	1862
irma.cimini@hotmail.com	2148
irma.cimini@hotmail.com	1143
irma.cimini@hotmail.com	329
irma.cimini@hotmail.com	2717
irma.cimini@hotmail.com	1040
irma.cimini@hotmail.com	1734
irma.cimini@hotmail.com	33
irma.cimini@hotmail.com	180
irma.cimini@hotmail.com	1431
irma.cimini@hotmail.com	1804
irma.cimini@hotmail.com	1030
irma.cimini@hotmail.com	803
irma.cimini@hotmail.com	1277
irma.cimini@hotmail.com	1697
irma.cimini@hotmail.com	2093
irma.cimini@hotmail.com	2765
irma.cimini@hotmail.com	1219
irma.cimini@hotmail.com	2634
irma.cimini@hotmail.com	380
irma.cimini@hotmail.com	1
irma.cimini@hotmail.com	2328
irma.cimini@hotmail.com	1012
irma.cimini@hotmail.com	1503
irma.cimini@hotmail.com	1543
irma.cimini@hotmail.com	2843
irma.cimini@hotmail.com	89
irma.cimini@hotmail.com	2273
irma.cimini@hotmail.com	1667
irma.cimini@hotmail.com	159
irma.cimini@hotmail.com	2225
irma.cimini@hotmail.com	2274
irma.cimini@hotmail.com	1917
irma.cimini@hotmail.com	292
irma.cimini@hotmail.com	2428
irma.cimini@hotmail.com	2642
irma.cimini@hotmail.com	1463
irma.cimini@hotmail.com	1136
irma.cimini@hotmail.com	1493
irma.cimini@hotmail.com	2204
irma.cimini@hotmail.com	1704
irma.cimini@hotmail.com	1603
irma.cimini@hotmail.com	2494
irma.cimini@hotmail.com	176
nicolò.tedesco@gmail.com	1220
nicolò.tedesco@gmail.com	2662
nicolò.tedesco@gmail.com	2017
nicolò.tedesco@gmail.com	1747
nicolò.tedesco@gmail.com	42
nicolò.tedesco@gmail.com	2560
nicolò.tedesco@gmail.com	879
nicolò.tedesco@gmail.com	1139
nicolò.tedesco@gmail.com	2827
nicolò.tedesco@gmail.com	1626
nicolò.tedesco@gmail.com	672
nicolò.tedesco@gmail.com	761
nicolò.tedesco@gmail.com	186
nicolò.tedesco@gmail.com	863
nicolò.tedesco@gmail.com	774
nicolò.tedesco@gmail.com	2144
nicolò.tedesco@gmail.com	131
nicolò.tedesco@gmail.com	1682
nicolò.tedesco@gmail.com	2790
nicolò.tedesco@gmail.com	9
nicolò.tedesco@gmail.com	1208
nicolò.tedesco@gmail.com	732
nicolò.tedesco@gmail.com	1793
nicolò.tedesco@gmail.com	874
nicolò.tedesco@gmail.com	2009
nicolò.tedesco@gmail.com	335
nicolò.tedesco@gmail.com	2388
nicolò.tedesco@gmail.com	2509
nicolò.tedesco@gmail.com	259
nicolò.tedesco@gmail.com	2598
nicolò.tedesco@gmail.com	1653
nicolò.tedesco@gmail.com	374
nicolò.tedesco@gmail.com	600
nicolò.tedesco@gmail.com	194
nicolò.tedesco@gmail.com	1779
nicolò.tedesco@gmail.com	2056
nicolò.tedesco@gmail.com	2551
nicolò.tedesco@gmail.com	112
nicolò.tedesco@gmail.com	1518
nicolò.tedesco@gmail.com	2031
nicolò.tedesco@gmail.com	45
nicolò.tedesco@gmail.com	898
nicolò.tedesco@gmail.com	1994
nicolò.tedesco@gmail.com	247
nicolò.tedesco@gmail.com	1307
nicolò.tedesco@gmail.com	2675
nicolò.tedesco@gmail.com	2330
nicolò.tedesco@gmail.com	2674
nicolò.tedesco@gmail.com	2763
nicolò.tedesco@gmail.com	1030
nicolò.tedesco@gmail.com	2809
nicolò.tedesco@gmail.com	469
nicolò.tedesco@gmail.com	2149
nicolò.tedesco@gmail.com	2573
nicolò.tedesco@gmail.com	1855
nicolò.tedesco@gmail.com	1843
nicolò.tedesco@gmail.com	2803
nicolò.tedesco@gmail.com	2112
nicolò.tedesco@gmail.com	1897
nicolò.tedesco@gmail.com	850
nicolò.tedesco@gmail.com	1513
nicolò.tedesco@gmail.com	404
nicolò.tedesco@gmail.com	1680
nicolò.tedesco@gmail.com	167
nicolò.tedesco@gmail.com	930
nicolò.tedesco@gmail.com	1242
nicolò.tedesco@gmail.com	1469
nicolò.tedesco@gmail.com	140
nicolò.tedesco@gmail.com	1934
nicolò.tedesco@gmail.com	1269
nicolò.tedesco@gmail.com	1681
nicolò.tedesco@gmail.com	1451
nicolò.tedesco@gmail.com	1713
nicolò.tedesco@gmail.com	2415
nicolò.tedesco@gmail.com	1627
nicolò.tedesco@gmail.com	1733
nicolò.tedesco@gmail.com	24
nicolò.tedesco@gmail.com	1723
nicolò.tedesco@gmail.com	2609
nicolò.tedesco@gmail.com	852
nicolò.tedesco@gmail.com	2035
nicolò.tedesco@gmail.com	534
nicolò.tedesco@gmail.com	127
nicolò.tedesco@gmail.com	2236
nicolò.tedesco@gmail.com	2488
nicolò.tedesco@gmail.com	2846
nicolò.tedesco@gmail.com	2436
nicolò.tedesco@gmail.com	1678
nicolò.tedesco@gmail.com	2174
nicolò.tedesco@gmail.com	959
nicolò.tedesco@gmail.com	2491
nicolò.tedesco@gmail.com	2475
nicolò.tedesco@gmail.com	975
nicolò.tedesco@gmail.com	1123
nicolò.tedesco@gmail.com	1112
nicolò.tedesco@gmail.com	746
nicolò.tedesco@gmail.com	1726
nicolò.tedesco@gmail.com	735
nicolò.tedesco@gmail.com	423
nicolò.tedesco@gmail.com	252
sabatino.bettin@hotmail.com	1990
sabatino.bettin@hotmail.com	1610
sabatino.bettin@hotmail.com	1735
sabatino.bettin@hotmail.com	417
sabatino.bettin@hotmail.com	425
sabatino.bettin@hotmail.com	1625
sabatino.bettin@hotmail.com	2711
sabatino.bettin@hotmail.com	2002
sabatino.bettin@hotmail.com	1496
sabatino.bettin@hotmail.com	527
sabatino.bettin@hotmail.com	302
sabatino.bettin@hotmail.com	441
sabatino.bettin@hotmail.com	2017
sabatino.bettin@hotmail.com	414
sabatino.bettin@hotmail.com	868
sabatino.bettin@hotmail.com	2052
sabatino.bettin@hotmail.com	1078
sabatino.bettin@hotmail.com	565
sabatino.bettin@hotmail.com	2426
sabatino.bettin@hotmail.com	1213
sabatino.bettin@hotmail.com	98
sabatino.bettin@hotmail.com	716
sabatino.bettin@hotmail.com	1275
sabatino.bettin@hotmail.com	1829
sabatino.bettin@hotmail.com	397
sabatino.bettin@hotmail.com	1233
sabatino.bettin@hotmail.com	688
sabatino.bettin@hotmail.com	891
sabatino.bettin@hotmail.com	1252
sabatino.bettin@hotmail.com	507
sabatino.bettin@hotmail.com	2010
sabatino.bettin@hotmail.com	2341
sabatino.bettin@hotmail.com	1593
sabatino.bettin@hotmail.com	1503
sabatino.bettin@hotmail.com	1270
sabatino.bettin@hotmail.com	2758
sabatino.bettin@hotmail.com	736
sabatino.bettin@hotmail.com	2198
sabatino.bettin@hotmail.com	2188
sabatino.bettin@hotmail.com	1297
sabatino.bettin@hotmail.com	1632
sabatino.bettin@hotmail.com	1494
sabatino.bettin@hotmail.com	1743
sabatino.bettin@hotmail.com	223
sabatino.bettin@hotmail.com	1901
sabatino.bettin@hotmail.com	1640
sabatino.bettin@hotmail.com	636
sabatino.bettin@hotmail.com	1428
sabatino.bettin@hotmail.com	287
sabatino.bettin@hotmail.com	1533
sabatino.bettin@hotmail.com	1974
sabatino.bettin@hotmail.com	524
sabatino.bettin@hotmail.com	137
sabatino.bettin@hotmail.com	2367
sabatino.bettin@hotmail.com	2834
sabatino.bettin@hotmail.com	1056
sabatino.bettin@hotmail.com	842
sabatino.bettin@hotmail.com	2163
sabatino.bettin@hotmail.com	1930
sabatino.bettin@hotmail.com	1039
sabatino.bettin@hotmail.com	2411
sabatino.bettin@hotmail.com	117
sabatino.bettin@hotmail.com	2611
sabatino.bettin@hotmail.com	476
sabatino.bettin@hotmail.com	2361
sabatino.bettin@hotmail.com	1836
sabatino.bettin@hotmail.com	725
sabatino.bettin@hotmail.com	1540
sabatino.bettin@hotmail.com	663
sabatino.bettin@hotmail.com	2562
sabatino.bettin@hotmail.com	346
sabatino.bettin@hotmail.com	73
sabatino.bettin@hotmail.com	1823
sabatino.bettin@hotmail.com	2369
sabatino.bettin@hotmail.com	481
sabatino.bettin@hotmail.com	1810
sabatino.bettin@hotmail.com	218
sabatino.bettin@hotmail.com	977
sabatino.bettin@hotmail.com	2095
sabatino.bettin@hotmail.com	126
sabatino.bettin@hotmail.com	1017
sabatino.bettin@hotmail.com	74
sabatino.bettin@hotmail.com	2429
sabatino.bettin@hotmail.com	1892
sabatino.bettin@hotmail.com	1484
sabatino.bettin@hotmail.com	289
sabatino.bettin@hotmail.com	1198
sabatino.bettin@hotmail.com	2770
sabatino.bettin@hotmail.com	1545
sabatino.bettin@hotmail.com	249
sabatino.bettin@hotmail.com	35
sabatino.bettin@hotmail.com	555
sabatino.bettin@hotmail.com	2162
sabatino.bettin@hotmail.com	883
sabatino.bettin@hotmail.com	2119
sabatino.bettin@hotmail.com	329
sabatino.bettin@hotmail.com	596
sabatino.bettin@hotmail.com	818
sabatino.bettin@hotmail.com	516
sabatino.bettin@hotmail.com	1011
cipriano.vercelloni@virgilio.it	2114
cipriano.vercelloni@virgilio.it	1629
cipriano.vercelloni@virgilio.it	2075
cipriano.vercelloni@virgilio.it	1921
cipriano.vercelloni@virgilio.it	589
cipriano.vercelloni@virgilio.it	2148
cipriano.vercelloni@virgilio.it	2852
cipriano.vercelloni@virgilio.it	2481
cipriano.vercelloni@virgilio.it	1135
cipriano.vercelloni@virgilio.it	747
cipriano.vercelloni@virgilio.it	1264
cipriano.vercelloni@virgilio.it	2669
cipriano.vercelloni@virgilio.it	913
cipriano.vercelloni@virgilio.it	1786
cipriano.vercelloni@virgilio.it	93
cipriano.vercelloni@virgilio.it	2598
cipriano.vercelloni@virgilio.it	2175
cipriano.vercelloni@virgilio.it	512
cipriano.vercelloni@virgilio.it	2302
cipriano.vercelloni@virgilio.it	2737
cipriano.vercelloni@virgilio.it	2386
cipriano.vercelloni@virgilio.it	625
cipriano.vercelloni@virgilio.it	1701
cipriano.vercelloni@virgilio.it	395
cipriano.vercelloni@virgilio.it	1601
cipriano.vercelloni@virgilio.it	2582
cipriano.vercelloni@virgilio.it	1619
cipriano.vercelloni@virgilio.it	847
cipriano.vercelloni@virgilio.it	82
cipriano.vercelloni@virgilio.it	937
cipriano.vercelloni@virgilio.it	2385
cipriano.vercelloni@virgilio.it	1490
cipriano.vercelloni@virgilio.it	2049
cipriano.vercelloni@virgilio.it	965
cipriano.vercelloni@virgilio.it	1063
cipriano.vercelloni@virgilio.it	490
cipriano.vercelloni@virgilio.it	1426
cipriano.vercelloni@virgilio.it	2101
cipriano.vercelloni@virgilio.it	523
cipriano.vercelloni@virgilio.it	1471
cipriano.vercelloni@virgilio.it	448
cipriano.vercelloni@virgilio.it	2328
cipriano.vercelloni@virgilio.it	60
cipriano.vercelloni@virgilio.it	23
cipriano.vercelloni@virgilio.it	2535
cipriano.vercelloni@virgilio.it	2613
cipriano.vercelloni@virgilio.it	2384
cipriano.vercelloni@virgilio.it	1825
cipriano.vercelloni@virgilio.it	873
cipriano.vercelloni@virgilio.it	511
cipriano.vercelloni@virgilio.it	1416
cipriano.vercelloni@virgilio.it	601
cipriano.vercelloni@virgilio.it	800
cipriano.vercelloni@virgilio.it	2015
cipriano.vercelloni@virgilio.it	1720
cipriano.vercelloni@virgilio.it	17
cipriano.vercelloni@virgilio.it	1495
cipriano.vercelloni@virgilio.it	13
cipriano.vercelloni@virgilio.it	1943
cipriano.vercelloni@virgilio.it	213
cipriano.vercelloni@virgilio.it	1379
cipriano.vercelloni@virgilio.it	2686
cipriano.vercelloni@virgilio.it	2323
cipriano.vercelloni@virgilio.it	2278
cipriano.vercelloni@virgilio.it	2258
cipriano.vercelloni@virgilio.it	249
cipriano.vercelloni@virgilio.it	1950
cipriano.vercelloni@virgilio.it	1971
cipriano.vercelloni@virgilio.it	1308
cipriano.vercelloni@virgilio.it	1745
cipriano.vercelloni@virgilio.it	2493
cipriano.vercelloni@virgilio.it	2519
cipriano.vercelloni@virgilio.it	1105
cipriano.vercelloni@virgilio.it	1666
cipriano.vercelloni@virgilio.it	2414
cipriano.vercelloni@virgilio.it	1064
cipriano.vercelloni@virgilio.it	2156
cipriano.vercelloni@virgilio.it	1116
cipriano.vercelloni@virgilio.it	2439
cipriano.vercelloni@virgilio.it	1240
cipriano.vercelloni@virgilio.it	92
cipriano.vercelloni@virgilio.it	1945
cipriano.vercelloni@virgilio.it	2248
cipriano.vercelloni@virgilio.it	1443
cipriano.vercelloni@virgilio.it	2348
cipriano.vercelloni@virgilio.it	415
cipriano.vercelloni@virgilio.it	507
cipriano.vercelloni@virgilio.it	2804
cipriano.vercelloni@virgilio.it	1434
cipriano.vercelloni@virgilio.it	74
cipriano.vercelloni@virgilio.it	2018
cipriano.vercelloni@virgilio.it	1190
cipriano.vercelloni@virgilio.it	1213
cipriano.vercelloni@virgilio.it	2457
cipriano.vercelloni@virgilio.it	1217
cipriano.vercelloni@virgilio.it	185
cipriano.vercelloni@virgilio.it	975
cipriano.vercelloni@virgilio.it	774
cipriano.vercelloni@virgilio.it	2707
cipriano.vercelloni@virgilio.it	1592
fernanda.blasi@libero.it	1565
fernanda.blasi@libero.it	2134
fernanda.blasi@libero.it	1445
fernanda.blasi@libero.it	581
fernanda.blasi@libero.it	2640
fernanda.blasi@libero.it	1467
fernanda.blasi@libero.it	1885
fernanda.blasi@libero.it	1892
fernanda.blasi@libero.it	233
fernanda.blasi@libero.it	1810
fernanda.blasi@libero.it	66
fernanda.blasi@libero.it	804
fernanda.blasi@libero.it	2748
fernanda.blasi@libero.it	2624
fernanda.blasi@libero.it	1841
fernanda.blasi@libero.it	587
fernanda.blasi@libero.it	1921
fernanda.blasi@libero.it	2428
fernanda.blasi@libero.it	2797
fernanda.blasi@libero.it	1214
fernanda.blasi@libero.it	2390
fernanda.blasi@libero.it	2600
fernanda.blasi@libero.it	2037
fernanda.blasi@libero.it	1730
fernanda.blasi@libero.it	10
fernanda.blasi@libero.it	1570
fernanda.blasi@libero.it	1819
fernanda.blasi@libero.it	164
fernanda.blasi@libero.it	1116
fernanda.blasi@libero.it	846
fernanda.blasi@libero.it	424
fernanda.blasi@libero.it	372
fernanda.blasi@libero.it	460
fernanda.blasi@libero.it	2104
fernanda.blasi@libero.it	733
fernanda.blasi@libero.it	1159
fernanda.blasi@libero.it	812
fernanda.blasi@libero.it	65
fernanda.blasi@libero.it	2579
fernanda.blasi@libero.it	2011
fernanda.blasi@libero.it	1981
fernanda.blasi@libero.it	1036
fernanda.blasi@libero.it	669
fernanda.blasi@libero.it	2281
fernanda.blasi@libero.it	2146
fernanda.blasi@libero.it	1760
fernanda.blasi@libero.it	766
fernanda.blasi@libero.it	1979
fernanda.blasi@libero.it	1679
fernanda.blasi@libero.it	1238
fernanda.blasi@libero.it	1416
fernanda.blasi@libero.it	2739
fernanda.blasi@libero.it	1725
fernanda.blasi@libero.it	2470
fernanda.blasi@libero.it	2400
fernanda.blasi@libero.it	2641
fernanda.blasi@libero.it	255
fernanda.blasi@libero.it	1654
fernanda.blasi@libero.it	886
fernanda.blasi@libero.it	809
fernanda.blasi@libero.it	2742
fernanda.blasi@libero.it	2691
fernanda.blasi@libero.it	1686
fernanda.blasi@libero.it	2464
fernanda.blasi@libero.it	2339
fernanda.blasi@libero.it	803
fernanda.blasi@libero.it	1802
fernanda.blasi@libero.it	621
fernanda.blasi@libero.it	322
fernanda.blasi@libero.it	1039
fernanda.blasi@libero.it	201
fernanda.blasi@libero.it	661
fernanda.blasi@libero.it	554
fernanda.blasi@libero.it	1038
fernanda.blasi@libero.it	1459
fernanda.blasi@libero.it	2853
fernanda.blasi@libero.it	1249
fernanda.blasi@libero.it	887
fernanda.blasi@libero.it	2377
fernanda.blasi@libero.it	1971
fernanda.blasi@libero.it	1209
fernanda.blasi@libero.it	956
fernanda.blasi@libero.it	2161
fernanda.blasi@libero.it	899
fernanda.blasi@libero.it	1438
fernanda.blasi@libero.it	75
fernanda.blasi@libero.it	894
fernanda.blasi@libero.it	905
fernanda.blasi@libero.it	1168
fernanda.blasi@libero.it	2259
fernanda.blasi@libero.it	282
fernanda.blasi@libero.it	2859
fernanda.blasi@libero.it	1899
fernanda.blasi@libero.it	1978
fernanda.blasi@libero.it	2213
fernanda.blasi@libero.it	14
fernanda.blasi@libero.it	1242
fernanda.blasi@libero.it	2391
fernanda.blasi@libero.it	2836
fernanda.blasi@libero.it	2447
eva.carullo@gmail.com	1434
eva.carullo@gmail.com	24
eva.carullo@gmail.com	1706
eva.carullo@gmail.com	311
eva.carullo@gmail.com	832
eva.carullo@gmail.com	168
eva.carullo@gmail.com	2323
eva.carullo@gmail.com	2260
eva.carullo@gmail.com	1831
eva.carullo@gmail.com	1127
eva.carullo@gmail.com	2100
eva.carullo@gmail.com	548
eva.carullo@gmail.com	256
eva.carullo@gmail.com	1815
eva.carullo@gmail.com	291
eva.carullo@gmail.com	151
eva.carullo@gmail.com	2137
eva.carullo@gmail.com	1231
eva.carullo@gmail.com	2203
eva.carullo@gmail.com	317
eva.carullo@gmail.com	1420
eva.carullo@gmail.com	2793
eva.carullo@gmail.com	441
eva.carullo@gmail.com	2710
eva.carullo@gmail.com	33
eva.carullo@gmail.com	1748
eva.carullo@gmail.com	716
eva.carullo@gmail.com	2155
eva.carullo@gmail.com	338
eva.carullo@gmail.com	277
eva.carullo@gmail.com	2336
eva.carullo@gmail.com	942
eva.carullo@gmail.com	228
eva.carullo@gmail.com	2010
eva.carullo@gmail.com	1514
eva.carullo@gmail.com	669
eva.carullo@gmail.com	1616
eva.carullo@gmail.com	1864
eva.carullo@gmail.com	2016
eva.carullo@gmail.com	2307
eva.carullo@gmail.com	2805
eva.carullo@gmail.com	216
eva.carullo@gmail.com	2511
eva.carullo@gmail.com	1617
eva.carullo@gmail.com	2295
eva.carullo@gmail.com	574
eva.carullo@gmail.com	2404
eva.carullo@gmail.com	1539
eva.carullo@gmail.com	2451
eva.carullo@gmail.com	2795
eva.carullo@gmail.com	193
eva.carullo@gmail.com	2618
eva.carullo@gmail.com	105
eva.carullo@gmail.com	2609
eva.carullo@gmail.com	755
eva.carullo@gmail.com	2086
eva.carullo@gmail.com	519
eva.carullo@gmail.com	366
eva.carullo@gmail.com	1276
eva.carullo@gmail.com	1278
eva.carullo@gmail.com	887
eva.carullo@gmail.com	2557
eva.carullo@gmail.com	328
eva.carullo@gmail.com	1428
eva.carullo@gmail.com	850
eva.carullo@gmail.com	610
eva.carullo@gmail.com	34
eva.carullo@gmail.com	1832
eva.carullo@gmail.com	2263
eva.carullo@gmail.com	2565
eva.carullo@gmail.com	2473
eva.carullo@gmail.com	411
eva.carullo@gmail.com	1412
eva.carullo@gmail.com	2408
eva.carullo@gmail.com	525
eva.carullo@gmail.com	2341
eva.carullo@gmail.com	661
eva.carullo@gmail.com	2251
eva.carullo@gmail.com	581
eva.carullo@gmail.com	1771
eva.carullo@gmail.com	2758
eva.carullo@gmail.com	28
eva.carullo@gmail.com	2583
eva.carullo@gmail.com	1055
eva.carullo@gmail.com	2302
eva.carullo@gmail.com	2169
eva.carullo@gmail.com	2493
eva.carullo@gmail.com	2701
eva.carullo@gmail.com	1625
eva.carullo@gmail.com	1028
eva.carullo@gmail.com	2594
eva.carullo@gmail.com	1264
eva.carullo@gmail.com	2466
eva.carullo@gmail.com	1463
eva.carullo@gmail.com	2509
eva.carullo@gmail.com	2819
eva.carullo@gmail.com	494
eva.carullo@gmail.com	540
eva.carullo@gmail.com	1499
eva.carullo@gmail.com	476
luchino.mannoia@gmail.com	478
luchino.mannoia@gmail.com	1618
luchino.mannoia@gmail.com	2290
luchino.mannoia@gmail.com	93
luchino.mannoia@gmail.com	1915
luchino.mannoia@gmail.com	1972
luchino.mannoia@gmail.com	1985
luchino.mannoia@gmail.com	639
luchino.mannoia@gmail.com	1666
luchino.mannoia@gmail.com	2615
luchino.mannoia@gmail.com	2425
luchino.mannoia@gmail.com	2510
luchino.mannoia@gmail.com	2019
luchino.mannoia@gmail.com	1695
luchino.mannoia@gmail.com	915
luchino.mannoia@gmail.com	1706
luchino.mannoia@gmail.com	2836
luchino.mannoia@gmail.com	781
luchino.mannoia@gmail.com	1120
luchino.mannoia@gmail.com	1310
luchino.mannoia@gmail.com	689
luchino.mannoia@gmail.com	396
luchino.mannoia@gmail.com	640
luchino.mannoia@gmail.com	2486
luchino.mannoia@gmail.com	57
luchino.mannoia@gmail.com	1640
luchino.mannoia@gmail.com	1537
luchino.mannoia@gmail.com	1852
luchino.mannoia@gmail.com	353
luchino.mannoia@gmail.com	733
luchino.mannoia@gmail.com	2480
luchino.mannoia@gmail.com	871
luchino.mannoia@gmail.com	1792
luchino.mannoia@gmail.com	70
luchino.mannoia@gmail.com	90
luchino.mannoia@gmail.com	1919
luchino.mannoia@gmail.com	2404
luchino.mannoia@gmail.com	76
luchino.mannoia@gmail.com	2668
luchino.mannoia@gmail.com	1605
luchino.mannoia@gmail.com	2816
luchino.mannoia@gmail.com	1111
luchino.mannoia@gmail.com	584
luchino.mannoia@gmail.com	1017
luchino.mannoia@gmail.com	2128
luchino.mannoia@gmail.com	763
luchino.mannoia@gmail.com	1496
luchino.mannoia@gmail.com	2766
luchino.mannoia@gmail.com	2573
luchino.mannoia@gmail.com	261
luchino.mannoia@gmail.com	2582
luchino.mannoia@gmail.com	1686
luchino.mannoia@gmail.com	2665
luchino.mannoia@gmail.com	96
luchino.mannoia@gmail.com	1065
luchino.mannoia@gmail.com	873
luchino.mannoia@gmail.com	1794
luchino.mannoia@gmail.com	513
luchino.mannoia@gmail.com	1133
luchino.mannoia@gmail.com	2384
luchino.mannoia@gmail.com	1712
luchino.mannoia@gmail.com	1930
luchino.mannoia@gmail.com	865
luchino.mannoia@gmail.com	319
luchino.mannoia@gmail.com	274
luchino.mannoia@gmail.com	73
luchino.mannoia@gmail.com	989
luchino.mannoia@gmail.com	1519
luchino.mannoia@gmail.com	2376
luchino.mannoia@gmail.com	661
luchino.mannoia@gmail.com	2400
luchino.mannoia@gmail.com	496
luchino.mannoia@gmail.com	1880
luchino.mannoia@gmail.com	1781
luchino.mannoia@gmail.com	26
luchino.mannoia@gmail.com	378
luchino.mannoia@gmail.com	1372
luchino.mannoia@gmail.com	1014
luchino.mannoia@gmail.com	2754
luchino.mannoia@gmail.com	2090
luchino.mannoia@gmail.com	77
luchino.mannoia@gmail.com	2163
luchino.mannoia@gmail.com	1898
luchino.mannoia@gmail.com	2142
luchino.mannoia@gmail.com	1282
luchino.mannoia@gmail.com	657
luchino.mannoia@gmail.com	2031
luchino.mannoia@gmail.com	1822
luchino.mannoia@gmail.com	1963
luchino.mannoia@gmail.com	375
luchino.mannoia@gmail.com	882
luchino.mannoia@gmail.com	1939
luchino.mannoia@gmail.com	1148
luchino.mannoia@gmail.com	2333
luchino.mannoia@gmail.com	1165
luchino.mannoia@gmail.com	2447
luchino.mannoia@gmail.com	1064
luchino.mannoia@gmail.com	2626
luchino.mannoia@gmail.com	2531
luchino.mannoia@gmail.com	2280
melania.martucci@virgilio.it	1412
melania.martucci@virgilio.it	969
melania.martucci@virgilio.it	1283
melania.martucci@virgilio.it	242
melania.martucci@virgilio.it	1424
melania.martucci@virgilio.it	1649
melania.martucci@virgilio.it	1815
melania.martucci@virgilio.it	2672
melania.martucci@virgilio.it	1981
melania.martucci@virgilio.it	1113
melania.martucci@virgilio.it	1065
melania.martucci@virgilio.it	662
melania.martucci@virgilio.it	427
melania.martucci@virgilio.it	66
melania.martucci@virgilio.it	2414
melania.martucci@virgilio.it	71
melania.martucci@virgilio.it	177
melania.martucci@virgilio.it	2513
melania.martucci@virgilio.it	2630
melania.martucci@virgilio.it	2210
melania.martucci@virgilio.it	2685
melania.martucci@virgilio.it	96
melania.martucci@virgilio.it	798
melania.martucci@virgilio.it	2376
melania.martucci@virgilio.it	2796
melania.martucci@virgilio.it	1241
melania.martucci@virgilio.it	2128
melania.martucci@virgilio.it	152
melania.martucci@virgilio.it	1813
melania.martucci@virgilio.it	171
melania.martucci@virgilio.it	1748
melania.martucci@virgilio.it	39
melania.martucci@virgilio.it	2732
melania.martucci@virgilio.it	1549
melania.martucci@virgilio.it	2557
melania.martucci@virgilio.it	2802
melania.martucci@virgilio.it	1532
melania.martucci@virgilio.it	75
melania.martucci@virgilio.it	259
melania.martucci@virgilio.it	570
melania.martucci@virgilio.it	829
melania.martucci@virgilio.it	858
melania.martucci@virgilio.it	1617
melania.martucci@virgilio.it	2445
melania.martucci@virgilio.it	1555
melania.martucci@virgilio.it	710
melania.martucci@virgilio.it	1037
melania.martucci@virgilio.it	1878
melania.martucci@virgilio.it	85
melania.martucci@virgilio.it	849
melania.martucci@virgilio.it	868
melania.martucci@virgilio.it	335
melania.martucci@virgilio.it	1382
melania.martucci@virgilio.it	842
melania.martucci@virgilio.it	283
melania.martucci@virgilio.it	587
melania.martucci@virgilio.it	777
melania.martucci@virgilio.it	652
melania.martucci@virgilio.it	2819
melania.martucci@virgilio.it	46
melania.martucci@virgilio.it	250
melania.martucci@virgilio.it	2093
melania.martucci@virgilio.it	2458
melania.martucci@virgilio.it	2269
melania.martucci@virgilio.it	2639
melania.martucci@virgilio.it	2142
melania.martucci@virgilio.it	2842
melania.martucci@virgilio.it	687
melania.martucci@virgilio.it	1030
melania.martucci@virgilio.it	276
melania.martucci@virgilio.it	1770
melania.martucci@virgilio.it	778
melania.martucci@virgilio.it	734
melania.martucci@virgilio.it	239
melania.martucci@virgilio.it	654
melania.martucci@virgilio.it	1724
melania.martucci@virgilio.it	21
melania.martucci@virgilio.it	775
melania.martucci@virgilio.it	2346
melania.martucci@virgilio.it	430
melania.martucci@virgilio.it	946
melania.martucci@virgilio.it	115
melania.martucci@virgilio.it	2804
melania.martucci@virgilio.it	1493
melania.martucci@virgilio.it	90
melania.martucci@virgilio.it	271
melania.martucci@virgilio.it	1989
melania.martucci@virgilio.it	2715
melania.martucci@virgilio.it	2554
melania.martucci@virgilio.it	943
melania.martucci@virgilio.it	260
melania.martucci@virgilio.it	1615
melania.martucci@virgilio.it	2818
melania.martucci@virgilio.it	2701
melania.martucci@virgilio.it	989
melania.martucci@virgilio.it	1786
melania.martucci@virgilio.it	1681
melania.martucci@virgilio.it	333
melania.martucci@virgilio.it	167
melania.martucci@virgilio.it	2734
pierina.asprucci@virgilio.it	1144
pierina.asprucci@virgilio.it	447
pierina.asprucci@virgilio.it	2425
pierina.asprucci@virgilio.it	1472
pierina.asprucci@virgilio.it	1644
pierina.asprucci@virgilio.it	2734
pierina.asprucci@virgilio.it	2332
pierina.asprucci@virgilio.it	548
pierina.asprucci@virgilio.it	758
pierina.asprucci@virgilio.it	1550
pierina.asprucci@virgilio.it	1220
pierina.asprucci@virgilio.it	528
pierina.asprucci@virgilio.it	1416
pierina.asprucci@virgilio.it	2450
pierina.asprucci@virgilio.it	1452
pierina.asprucci@virgilio.it	1569
pierina.asprucci@virgilio.it	421
pierina.asprucci@virgilio.it	887
pierina.asprucci@virgilio.it	2291
pierina.asprucci@virgilio.it	1134
pierina.asprucci@virgilio.it	232
pierina.asprucci@virgilio.it	627
pierina.asprucci@virgilio.it	2058
pierina.asprucci@virgilio.it	2827
pierina.asprucci@virgilio.it	823
pierina.asprucci@virgilio.it	1630
pierina.asprucci@virgilio.it	1736
pierina.asprucci@virgilio.it	1383
pierina.asprucci@virgilio.it	2295
pierina.asprucci@virgilio.it	2076
pierina.asprucci@virgilio.it	2064
pierina.asprucci@virgilio.it	2300
pierina.asprucci@virgilio.it	785
pierina.asprucci@virgilio.it	1076
pierina.asprucci@virgilio.it	2159
pierina.asprucci@virgilio.it	371
pierina.asprucci@virgilio.it	342
pierina.asprucci@virgilio.it	615
pierina.asprucci@virgilio.it	1878
pierina.asprucci@virgilio.it	241
pierina.asprucci@virgilio.it	1481
pierina.asprucci@virgilio.it	1790
pierina.asprucci@virgilio.it	386
pierina.asprucci@virgilio.it	725
pierina.asprucci@virgilio.it	472
pierina.asprucci@virgilio.it	1737
pierina.asprucci@virgilio.it	1457
pierina.asprucci@virgilio.it	827
pierina.asprucci@virgilio.it	1882
pierina.asprucci@virgilio.it	1828
pierina.asprucci@virgilio.it	2002
pierina.asprucci@virgilio.it	905
pierina.asprucci@virgilio.it	1085
pierina.asprucci@virgilio.it	1895
pierina.asprucci@virgilio.it	767
pierina.asprucci@virgilio.it	2670
pierina.asprucci@virgilio.it	2340
pierina.asprucci@virgilio.it	1700
pierina.asprucci@virgilio.it	2283
pierina.asprucci@virgilio.it	1243
pierina.asprucci@virgilio.it	1840
pierina.asprucci@virgilio.it	270
pierina.asprucci@virgilio.it	2488
pierina.asprucci@virgilio.it	389
pierina.asprucci@virgilio.it	2721
pierina.asprucci@virgilio.it	1045
pierina.asprucci@virgilio.it	918
pierina.asprucci@virgilio.it	562
pierina.asprucci@virgilio.it	1729
pierina.asprucci@virgilio.it	840
pierina.asprucci@virgilio.it	1604
pierina.asprucci@virgilio.it	1315
pierina.asprucci@virgilio.it	57
pierina.asprucci@virgilio.it	1217
pierina.asprucci@virgilio.it	851
pierina.asprucci@virgilio.it	1640
pierina.asprucci@virgilio.it	2078
pierina.asprucci@virgilio.it	886
pierina.asprucci@virgilio.it	729
pierina.asprucci@virgilio.it	1303
pierina.asprucci@virgilio.it	309
pierina.asprucci@virgilio.it	1477
pierina.asprucci@virgilio.it	2124
pierina.asprucci@virgilio.it	1835
pierina.asprucci@virgilio.it	724
pierina.asprucci@virgilio.it	2812
pierina.asprucci@virgilio.it	710
pierina.asprucci@virgilio.it	923
pierina.asprucci@virgilio.it	297
pierina.asprucci@virgilio.it	1513
pierina.asprucci@virgilio.it	801
pierina.asprucci@virgilio.it	819
pierina.asprucci@virgilio.it	2145
pierina.asprucci@virgilio.it	518
pierina.asprucci@virgilio.it	1557
pierina.asprucci@virgilio.it	2313
pierina.asprucci@virgilio.it	1626
pierina.asprucci@virgilio.it	2693
pierina.asprucci@virgilio.it	2467
pierina.asprucci@virgilio.it	408
gianpietro.venturi@yahoo.it	1507
gianpietro.venturi@yahoo.it	2194
gianpietro.venturi@yahoo.it	1754
gianpietro.venturi@yahoo.it	2077
gianpietro.venturi@yahoo.it	1805
gianpietro.venturi@yahoo.it	1182
gianpietro.venturi@yahoo.it	909
gianpietro.venturi@yahoo.it	1626
gianpietro.venturi@yahoo.it	1066
gianpietro.venturi@yahoo.it	2633
gianpietro.venturi@yahoo.it	1046
gianpietro.venturi@yahoo.it	2000
gianpietro.venturi@yahoo.it	1840
gianpietro.venturi@yahoo.it	2223
gianpietro.venturi@yahoo.it	2812
gianpietro.venturi@yahoo.it	2182
gianpietro.venturi@yahoo.it	628
gianpietro.venturi@yahoo.it	1148
gianpietro.venturi@yahoo.it	2771
gianpietro.venturi@yahoo.it	2846
gianpietro.venturi@yahoo.it	2413
gianpietro.venturi@yahoo.it	2448
gianpietro.venturi@yahoo.it	503
gianpietro.venturi@yahoo.it	1933
gianpietro.venturi@yahoo.it	1860
gianpietro.venturi@yahoo.it	90
gianpietro.venturi@yahoo.it	627
gianpietro.venturi@yahoo.it	481
gianpietro.venturi@yahoo.it	427
gianpietro.venturi@yahoo.it	1821
gianpietro.venturi@yahoo.it	788
gianpietro.venturi@yahoo.it	2828
gianpietro.venturi@yahoo.it	544
gianpietro.venturi@yahoo.it	1434
gianpietro.venturi@yahoo.it	2372
gianpietro.venturi@yahoo.it	731
gianpietro.venturi@yahoo.it	513
gianpietro.venturi@yahoo.it	545
gianpietro.venturi@yahoo.it	2261
gianpietro.venturi@yahoo.it	2608
gianpietro.venturi@yahoo.it	2305
gianpietro.venturi@yahoo.it	1662
gianpietro.venturi@yahoo.it	673
gianpietro.venturi@yahoo.it	248
gianpietro.venturi@yahoo.it	700
gianpietro.venturi@yahoo.it	2767
gianpietro.venturi@yahoo.it	2023
gianpietro.venturi@yahoo.it	1866
gianpietro.venturi@yahoo.it	1631
gianpietro.venturi@yahoo.it	1031
gianpietro.venturi@yahoo.it	1738
gianpietro.venturi@yahoo.it	1305
gianpietro.venturi@yahoo.it	1642
gianpietro.venturi@yahoo.it	2640
gianpietro.venturi@yahoo.it	1711
gianpietro.venturi@yahoo.it	1231
gianpietro.venturi@yahoo.it	510
gianpietro.venturi@yahoo.it	2490
gianpietro.venturi@yahoo.it	2489
gianpietro.venturi@yahoo.it	2628
gianpietro.venturi@yahoo.it	991
gianpietro.venturi@yahoo.it	640
gianpietro.venturi@yahoo.it	124
gianpietro.venturi@yahoo.it	2417
gianpietro.venturi@yahoo.it	1735
gianpietro.venturi@yahoo.it	1472
gianpietro.venturi@yahoo.it	2291
gianpietro.venturi@yahoo.it	523
gianpietro.venturi@yahoo.it	2449
gianpietro.venturi@yahoo.it	354
gianpietro.venturi@yahoo.it	1
gianpietro.venturi@yahoo.it	1663
gianpietro.venturi@yahoo.it	2144
gianpietro.venturi@yahoo.it	76
gianpietro.venturi@yahoo.it	496
gianpietro.venturi@yahoo.it	243
gianpietro.venturi@yahoo.it	2243
gianpietro.venturi@yahoo.it	2200
gianpietro.venturi@yahoo.it	1484
gianpietro.venturi@yahoo.it	2280
gianpietro.venturi@yahoo.it	53
gianpietro.venturi@yahoo.it	2164
gianpietro.venturi@yahoo.it	2729
gianpietro.venturi@yahoo.it	734
gianpietro.venturi@yahoo.it	325
gianpietro.venturi@yahoo.it	620
gianpietro.venturi@yahoo.it	1656
gianpietro.venturi@yahoo.it	2060
gianpietro.venturi@yahoo.it	2691
gianpietro.venturi@yahoo.it	2271
gianpietro.venturi@yahoo.it	832
gianpietro.venturi@yahoo.it	2402
gianpietro.venturi@yahoo.it	952
gianpietro.venturi@yahoo.it	1838
gianpietro.venturi@yahoo.it	2855
gianpietro.venturi@yahoo.it	1070
gianpietro.venturi@yahoo.it	2795
gianpietro.venturi@yahoo.it	1778
gianpietro.venturi@yahoo.it	2673
gianpietro.venturi@yahoo.it	2364
liberto.cannizzaro@hotmail.com	202
liberto.cannizzaro@hotmail.com	1714
liberto.cannizzaro@hotmail.com	1232
liberto.cannizzaro@hotmail.com	1199
liberto.cannizzaro@hotmail.com	1215
liberto.cannizzaro@hotmail.com	393
liberto.cannizzaro@hotmail.com	1278
liberto.cannizzaro@hotmail.com	517
liberto.cannizzaro@hotmail.com	2613
liberto.cannizzaro@hotmail.com	331
liberto.cannizzaro@hotmail.com	1573
liberto.cannizzaro@hotmail.com	403
liberto.cannizzaro@hotmail.com	2098
liberto.cannizzaro@hotmail.com	2370
liberto.cannizzaro@hotmail.com	1247
liberto.cannizzaro@hotmail.com	80
liberto.cannizzaro@hotmail.com	830
liberto.cannizzaro@hotmail.com	354
liberto.cannizzaro@hotmail.com	687
liberto.cannizzaro@hotmail.com	1105
liberto.cannizzaro@hotmail.com	5
liberto.cannizzaro@hotmail.com	878
liberto.cannizzaro@hotmail.com	2834
liberto.cannizzaro@hotmail.com	1225
liberto.cannizzaro@hotmail.com	1799
liberto.cannizzaro@hotmail.com	120
liberto.cannizzaro@hotmail.com	2159
liberto.cannizzaro@hotmail.com	468
liberto.cannizzaro@hotmail.com	146
liberto.cannizzaro@hotmail.com	823
liberto.cannizzaro@hotmail.com	2508
liberto.cannizzaro@hotmail.com	1263
liberto.cannizzaro@hotmail.com	734
liberto.cannizzaro@hotmail.com	2813
liberto.cannizzaro@hotmail.com	2847
liberto.cannizzaro@hotmail.com	2411
liberto.cannizzaro@hotmail.com	770
liberto.cannizzaro@hotmail.com	2684
liberto.cannizzaro@hotmail.com	1618
liberto.cannizzaro@hotmail.com	1235
liberto.cannizzaro@hotmail.com	2016
liberto.cannizzaro@hotmail.com	2819
liberto.cannizzaro@hotmail.com	1695
liberto.cannizzaro@hotmail.com	1842
liberto.cannizzaro@hotmail.com	191
liberto.cannizzaro@hotmail.com	475
liberto.cannizzaro@hotmail.com	2134
liberto.cannizzaro@hotmail.com	2442
liberto.cannizzaro@hotmail.com	49
liberto.cannizzaro@hotmail.com	946
liberto.cannizzaro@hotmail.com	1699
liberto.cannizzaro@hotmail.com	2487
liberto.cannizzaro@hotmail.com	1511
liberto.cannizzaro@hotmail.com	748
liberto.cannizzaro@hotmail.com	1143
liberto.cannizzaro@hotmail.com	494
liberto.cannizzaro@hotmail.com	245
liberto.cannizzaro@hotmail.com	1676
liberto.cannizzaro@hotmail.com	1233
liberto.cannizzaro@hotmail.com	2466
liberto.cannizzaro@hotmail.com	587
liberto.cannizzaro@hotmail.com	364
liberto.cannizzaro@hotmail.com	1418
liberto.cannizzaro@hotmail.com	1722
liberto.cannizzaro@hotmail.com	1260
liberto.cannizzaro@hotmail.com	373
liberto.cannizzaro@hotmail.com	2097
liberto.cannizzaro@hotmail.com	1738
liberto.cannizzaro@hotmail.com	314
liberto.cannizzaro@hotmail.com	22
liberto.cannizzaro@hotmail.com	1586
liberto.cannizzaro@hotmail.com	591
liberto.cannizzaro@hotmail.com	2141
liberto.cannizzaro@hotmail.com	842
liberto.cannizzaro@hotmail.com	2506
liberto.cannizzaro@hotmail.com	2773
liberto.cannizzaro@hotmail.com	110
liberto.cannizzaro@hotmail.com	1034
liberto.cannizzaro@hotmail.com	2319
liberto.cannizzaro@hotmail.com	2195
liberto.cannizzaro@hotmail.com	1604
liberto.cannizzaro@hotmail.com	1681
liberto.cannizzaro@hotmail.com	2283
liberto.cannizzaro@hotmail.com	1950
liberto.cannizzaro@hotmail.com	2111
liberto.cannizzaro@hotmail.com	2485
liberto.cannizzaro@hotmail.com	1606
liberto.cannizzaro@hotmail.com	851
liberto.cannizzaro@hotmail.com	2529
liberto.cannizzaro@hotmail.com	791
liberto.cannizzaro@hotmail.com	1614
liberto.cannizzaro@hotmail.com	732
liberto.cannizzaro@hotmail.com	211
liberto.cannizzaro@hotmail.com	2393
liberto.cannizzaro@hotmail.com	472
liberto.cannizzaro@hotmail.com	1794
liberto.cannizzaro@hotmail.com	2068
liberto.cannizzaro@hotmail.com	532
liberto.cannizzaro@hotmail.com	1420
liberto.cannizzaro@hotmail.com	2317
giulietta.moretti@libero.it	1034
giulietta.moretti@libero.it	122
giulietta.moretti@libero.it	2019
giulietta.moretti@libero.it	2577
giulietta.moretti@libero.it	1991
giulietta.moretti@libero.it	2491
giulietta.moretti@libero.it	323
giulietta.moretti@libero.it	1078
giulietta.moretti@libero.it	2675
giulietta.moretti@libero.it	2321
giulietta.moretti@libero.it	867
giulietta.moretti@libero.it	207
giulietta.moretti@libero.it	922
giulietta.moretti@libero.it	2039
giulietta.moretti@libero.it	682
giulietta.moretti@libero.it	1290
giulietta.moretti@libero.it	781
giulietta.moretti@libero.it	2619
giulietta.moretti@libero.it	1221
giulietta.moretti@libero.it	2114
giulietta.moretti@libero.it	2256
giulietta.moretti@libero.it	490
giulietta.moretti@libero.it	1303
giulietta.moretti@libero.it	2004
giulietta.moretti@libero.it	617
giulietta.moretti@libero.it	2527
giulietta.moretti@libero.it	563
giulietta.moretti@libero.it	2541
giulietta.moretti@libero.it	1612
giulietta.moretti@libero.it	2487
giulietta.moretti@libero.it	1834
giulietta.moretti@libero.it	2176
giulietta.moretti@libero.it	1234
giulietta.moretti@libero.it	2501
giulietta.moretti@libero.it	2105
giulietta.moretti@libero.it	2843
giulietta.moretti@libero.it	799
giulietta.moretti@libero.it	858
giulietta.moretti@libero.it	2812
giulietta.moretti@libero.it	1804
giulietta.moretti@libero.it	1792
giulietta.moretti@libero.it	1780
giulietta.moretti@libero.it	2660
giulietta.moretti@libero.it	1949
giulietta.moretti@libero.it	1411
giulietta.moretti@libero.it	32
giulietta.moretti@libero.it	293
giulietta.moretti@libero.it	1697
giulietta.moretti@libero.it	2212
giulietta.moretti@libero.it	964
giulietta.moretti@libero.it	266
giulietta.moretti@libero.it	2017
giulietta.moretti@libero.it	772
giulietta.moretti@libero.it	598
giulietta.moretti@libero.it	1942
giulietta.moretti@libero.it	22
giulietta.moretti@libero.it	2092
giulietta.moretti@libero.it	1478
giulietta.moretti@libero.it	1240
giulietta.moretti@libero.it	196
giulietta.moretti@libero.it	675
giulietta.moretti@libero.it	2339
giulietta.moretti@libero.it	1698
giulietta.moretti@libero.it	1251
giulietta.moretti@libero.it	2762
giulietta.moretti@libero.it	801
giulietta.moretti@libero.it	203
giulietta.moretti@libero.it	1259
giulietta.moretti@libero.it	1263
giulietta.moretti@libero.it	436
giulietta.moretti@libero.it	296
giulietta.moretti@libero.it	226
giulietta.moretti@libero.it	2412
giulietta.moretti@libero.it	1136
giulietta.moretti@libero.it	1589
giulietta.moretti@libero.it	940
giulietta.moretti@libero.it	180
giulietta.moretti@libero.it	321
giulietta.moretti@libero.it	417
giulietta.moretti@libero.it	1605
giulietta.moretti@libero.it	1994
giulietta.moretti@libero.it	2057
giulietta.moretti@libero.it	1079
giulietta.moretti@libero.it	737
giulietta.moretti@libero.it	1410
giulietta.moretti@libero.it	1893
giulietta.moretti@libero.it	2387
giulietta.moretti@libero.it	579
giulietta.moretti@libero.it	2046
giulietta.moretti@libero.it	70
giulietta.moretti@libero.it	1272
giulietta.moretti@libero.it	1510
giulietta.moretti@libero.it	1378
giulietta.moretti@libero.it	2010
giulietta.moretti@libero.it	1530
giulietta.moretti@libero.it	1170
giulietta.moretti@libero.it	127
giulietta.moretti@libero.it	2190
giulietta.moretti@libero.it	1501
giulietta.moretti@libero.it	829
dante.mantegazza@yahoo.it	2738
dante.mantegazza@yahoo.it	1747
dante.mantegazza@yahoo.it	1634
dante.mantegazza@yahoo.it	784
dante.mantegazza@yahoo.it	1946
dante.mantegazza@yahoo.it	538
dante.mantegazza@yahoo.it	1844
dante.mantegazza@yahoo.it	94
dante.mantegazza@yahoo.it	746
dante.mantegazza@yahoo.it	1089
dante.mantegazza@yahoo.it	1315
dante.mantegazza@yahoo.it	1475
dante.mantegazza@yahoo.it	642
dante.mantegazza@yahoo.it	1124
dante.mantegazza@yahoo.it	1669
dante.mantegazza@yahoo.it	380
dante.mantegazza@yahoo.it	454
dante.mantegazza@yahoo.it	1372
dante.mantegazza@yahoo.it	1640
dante.mantegazza@yahoo.it	751
dante.mantegazza@yahoo.it	1600
dante.mantegazza@yahoo.it	455
dante.mantegazza@yahoo.it	963
dante.mantegazza@yahoo.it	1921
dante.mantegazza@yahoo.it	1118
dante.mantegazza@yahoo.it	777
dante.mantegazza@yahoo.it	147
dante.mantegazza@yahoo.it	586
dante.mantegazza@yahoo.it	1135
dante.mantegazza@yahoo.it	1183
dante.mantegazza@yahoo.it	1381
dante.mantegazza@yahoo.it	1064
dante.mantegazza@yahoo.it	2767
dante.mantegazza@yahoo.it	1759
dante.mantegazza@yahoo.it	2832
dante.mantegazza@yahoo.it	1888
dante.mantegazza@yahoo.it	1643
dante.mantegazza@yahoo.it	1189
dante.mantegazza@yahoo.it	1790
dante.mantegazza@yahoo.it	817
dante.mantegazza@yahoo.it	2289
dante.mantegazza@yahoo.it	58
dante.mantegazza@yahoo.it	1262
dante.mantegazza@yahoo.it	1461
dante.mantegazza@yahoo.it	2735
dante.mantegazza@yahoo.it	1965
dante.mantegazza@yahoo.it	607
dante.mantegazza@yahoo.it	2263
dante.mantegazza@yahoo.it	1513
dante.mantegazza@yahoo.it	1910
dante.mantegazza@yahoo.it	2358
dante.mantegazza@yahoo.it	419
dante.mantegazza@yahoo.it	381
dante.mantegazza@yahoo.it	1584
dante.mantegazza@yahoo.it	80
dante.mantegazza@yahoo.it	2093
dante.mantegazza@yahoo.it	406
dante.mantegazza@yahoo.it	1850
dante.mantegazza@yahoo.it	173
dante.mantegazza@yahoo.it	1964
dante.mantegazza@yahoo.it	437
dante.mantegazza@yahoo.it	1235
dante.mantegazza@yahoo.it	347
dante.mantegazza@yahoo.it	292
dante.mantegazza@yahoo.it	1576
dante.mantegazza@yahoo.it	654
dante.mantegazza@yahoo.it	1116
dante.mantegazza@yahoo.it	2540
dante.mantegazza@yahoo.it	1920
dante.mantegazza@yahoo.it	1897
dante.mantegazza@yahoo.it	1052
dante.mantegazza@yahoo.it	82
dante.mantegazza@yahoo.it	920
dante.mantegazza@yahoo.it	2048
dante.mantegazza@yahoo.it	1077
dante.mantegazza@yahoo.it	17
dante.mantegazza@yahoo.it	2283
dante.mantegazza@yahoo.it	1598
dante.mantegazza@yahoo.it	2261
dante.mantegazza@yahoo.it	183
dante.mantegazza@yahoo.it	533
dante.mantegazza@yahoo.it	2382
dante.mantegazza@yahoo.it	2339
dante.mantegazza@yahoo.it	1772
dante.mantegazza@yahoo.it	2777
dante.mantegazza@yahoo.it	1682
dante.mantegazza@yahoo.it	112
dante.mantegazza@yahoo.it	2640
dante.mantegazza@yahoo.it	2164
dante.mantegazza@yahoo.it	2773
dante.mantegazza@yahoo.it	435
dante.mantegazza@yahoo.it	742
dante.mantegazza@yahoo.it	985
dante.mantegazza@yahoo.it	1980
dante.mantegazza@yahoo.it	553
dante.mantegazza@yahoo.it	2104
dante.mantegazza@yahoo.it	687
dante.mantegazza@yahoo.it	1627
dante.mantegazza@yahoo.it	143
dante.mantegazza@yahoo.it	2696
dario.battisti@hotmail.com	1117
dario.battisti@hotmail.com	2625
dario.battisti@hotmail.com	293
dario.battisti@hotmail.com	477
dario.battisti@hotmail.com	1408
dario.battisti@hotmail.com	2488
dario.battisti@hotmail.com	450
dario.battisti@hotmail.com	2606
dario.battisti@hotmail.com	84
dario.battisti@hotmail.com	1138
dario.battisti@hotmail.com	899
dario.battisti@hotmail.com	2148
dario.battisti@hotmail.com	2672
dario.battisti@hotmail.com	1950
dario.battisti@hotmail.com	337
dario.battisti@hotmail.com	1064
dario.battisti@hotmail.com	1780
dario.battisti@hotmail.com	472
dario.battisti@hotmail.com	2655
dario.battisti@hotmail.com	48
dario.battisti@hotmail.com	2278
dario.battisti@hotmail.com	2170
dario.battisti@hotmail.com	402
dario.battisti@hotmail.com	2770
dario.battisti@hotmail.com	2439
dario.battisti@hotmail.com	1063
dario.battisti@hotmail.com	581
dario.battisti@hotmail.com	2099
dario.battisti@hotmail.com	2157
dario.battisti@hotmail.com	902
dario.battisti@hotmail.com	623
dario.battisti@hotmail.com	2572
dario.battisti@hotmail.com	1109
dario.battisti@hotmail.com	665
dario.battisti@hotmail.com	2748
dario.battisti@hotmail.com	353
dario.battisti@hotmail.com	2609
dario.battisti@hotmail.com	2475
dario.battisti@hotmail.com	1270
dario.battisti@hotmail.com	1974
dario.battisti@hotmail.com	2035
dario.battisti@hotmail.com	1709
dario.battisti@hotmail.com	1456
dario.battisti@hotmail.com	872
dario.battisti@hotmail.com	1234
dario.battisti@hotmail.com	1118
dario.battisti@hotmail.com	1482
dario.battisti@hotmail.com	1262
dario.battisti@hotmail.com	2670
dario.battisti@hotmail.com	1106
dario.battisti@hotmail.com	647
dario.battisti@hotmail.com	1469
dario.battisti@hotmail.com	2525
dario.battisti@hotmail.com	1872
dario.battisti@hotmail.com	2342
dario.battisti@hotmail.com	1968
dario.battisti@hotmail.com	2658
dario.battisti@hotmail.com	1715
dario.battisti@hotmail.com	588
dario.battisti@hotmail.com	1477
dario.battisti@hotmail.com	163
dario.battisti@hotmail.com	2701
dario.battisti@hotmail.com	2125
dario.battisti@hotmail.com	1420
dario.battisti@hotmail.com	2678
dario.battisti@hotmail.com	2668
dario.battisti@hotmail.com	447
dario.battisti@hotmail.com	919
dario.battisti@hotmail.com	1649
dario.battisti@hotmail.com	842
dario.battisti@hotmail.com	226
dario.battisti@hotmail.com	630
dario.battisti@hotmail.com	2400
dario.battisti@hotmail.com	1235
dario.battisti@hotmail.com	2661
dario.battisti@hotmail.com	879
dario.battisti@hotmail.com	3
dario.battisti@hotmail.com	1519
dario.battisti@hotmail.com	1942
dario.battisti@hotmail.com	42
dario.battisti@hotmail.com	1506
dario.battisti@hotmail.com	467
dario.battisti@hotmail.com	1993
dario.battisti@hotmail.com	385
dario.battisti@hotmail.com	9
dario.battisti@hotmail.com	1677
dario.battisti@hotmail.com	2418
dario.battisti@hotmail.com	1476
dario.battisti@hotmail.com	416
dario.battisti@hotmail.com	1830
dario.battisti@hotmail.com	1416
dario.battisti@hotmail.com	1967
dario.battisti@hotmail.com	2135
dario.battisti@hotmail.com	2758
dario.battisti@hotmail.com	1314
dario.battisti@hotmail.com	2065
dario.battisti@hotmail.com	1025
dario.battisti@hotmail.com	1472
dario.battisti@hotmail.com	674
dario.battisti@hotmail.com	404
bianca.traversa@virgilio.it	131
bianca.traversa@virgilio.it	655
bianca.traversa@virgilio.it	587
bianca.traversa@virgilio.it	2471
bianca.traversa@virgilio.it	2686
bianca.traversa@virgilio.it	2393
bianca.traversa@virgilio.it	1075
bianca.traversa@virgilio.it	2105
bianca.traversa@virgilio.it	2859
bianca.traversa@virgilio.it	2388
bianca.traversa@virgilio.it	787
bianca.traversa@virgilio.it	1380
bianca.traversa@virgilio.it	34
bianca.traversa@virgilio.it	1172
bianca.traversa@virgilio.it	115
bianca.traversa@virgilio.it	1275
bianca.traversa@virgilio.it	836
bianca.traversa@virgilio.it	2408
bianca.traversa@virgilio.it	2792
bianca.traversa@virgilio.it	825
bianca.traversa@virgilio.it	2704
bianca.traversa@virgilio.it	934
bianca.traversa@virgilio.it	1600
bianca.traversa@virgilio.it	2251
bianca.traversa@virgilio.it	1313
bianca.traversa@virgilio.it	734
bianca.traversa@virgilio.it	2114
bianca.traversa@virgilio.it	1491
bianca.traversa@virgilio.it	477
bianca.traversa@virgilio.it	623
bianca.traversa@virgilio.it	1201
bianca.traversa@virgilio.it	2701
bianca.traversa@virgilio.it	2436
bianca.traversa@virgilio.it	1646
bianca.traversa@virgilio.it	1303
bianca.traversa@virgilio.it	2237
bianca.traversa@virgilio.it	574
bianca.traversa@virgilio.it	1237
bianca.traversa@virgilio.it	278
bianca.traversa@virgilio.it	741
bianca.traversa@virgilio.it	2081
bianca.traversa@virgilio.it	244
bianca.traversa@virgilio.it	174
bianca.traversa@virgilio.it	1262
bianca.traversa@virgilio.it	2504
bianca.traversa@virgilio.it	221
bianca.traversa@virgilio.it	1016
bianca.traversa@virgilio.it	2515
bianca.traversa@virgilio.it	1108
bianca.traversa@virgilio.it	292
bianca.traversa@virgilio.it	233
bianca.traversa@virgilio.it	2663
bianca.traversa@virgilio.it	163
bianca.traversa@virgilio.it	769
bianca.traversa@virgilio.it	132
bianca.traversa@virgilio.it	2318
bianca.traversa@virgilio.it	2133
bianca.traversa@virgilio.it	1805
bianca.traversa@virgilio.it	2492
bianca.traversa@virgilio.it	313
bianca.traversa@virgilio.it	2407
bianca.traversa@virgilio.it	2362
bianca.traversa@virgilio.it	2688
bianca.traversa@virgilio.it	2671
bianca.traversa@virgilio.it	1288
bianca.traversa@virgilio.it	2710
bianca.traversa@virgilio.it	2546
bianca.traversa@virgilio.it	1415
bianca.traversa@virgilio.it	2509
bianca.traversa@virgilio.it	642
bianca.traversa@virgilio.it	2587
bianca.traversa@virgilio.it	2258
bianca.traversa@virgilio.it	2604
bianca.traversa@virgilio.it	1173
bianca.traversa@virgilio.it	1637
bianca.traversa@virgilio.it	2321
bianca.traversa@virgilio.it	1579
bianca.traversa@virgilio.it	155
bianca.traversa@virgilio.it	1571
bianca.traversa@virgilio.it	1280
bianca.traversa@virgilio.it	2062
bianca.traversa@virgilio.it	1839
bianca.traversa@virgilio.it	1029
bianca.traversa@virgilio.it	453
bianca.traversa@virgilio.it	606
bianca.traversa@virgilio.it	1507
bianca.traversa@virgilio.it	930
bianca.traversa@virgilio.it	1285
bianca.traversa@virgilio.it	960
bianca.traversa@virgilio.it	1770
bianca.traversa@virgilio.it	616
bianca.traversa@virgilio.it	2139
bianca.traversa@virgilio.it	1857
bianca.traversa@virgilio.it	1187
bianca.traversa@virgilio.it	842
bianca.traversa@virgilio.it	1015
bianca.traversa@virgilio.it	1917
bianca.traversa@virgilio.it	33
bianca.traversa@virgilio.it	2685
bianca.traversa@virgilio.it	1786
micheletto.saragat@hotmail.com	705
micheletto.saragat@hotmail.com	1148
micheletto.saragat@hotmail.com	1447
micheletto.saragat@hotmail.com	188
micheletto.saragat@hotmail.com	80
micheletto.saragat@hotmail.com	2046
micheletto.saragat@hotmail.com	1241
micheletto.saragat@hotmail.com	2619
micheletto.saragat@hotmail.com	2251
micheletto.saragat@hotmail.com	34
micheletto.saragat@hotmail.com	711
micheletto.saragat@hotmail.com	175
micheletto.saragat@hotmail.com	124
micheletto.saragat@hotmail.com	1077
micheletto.saragat@hotmail.com	2394
micheletto.saragat@hotmail.com	109
micheletto.saragat@hotmail.com	294
micheletto.saragat@hotmail.com	672
micheletto.saragat@hotmail.com	1686
micheletto.saragat@hotmail.com	2278
micheletto.saragat@hotmail.com	2704
micheletto.saragat@hotmail.com	42
micheletto.saragat@hotmail.com	2349
micheletto.saragat@hotmail.com	589
micheletto.saragat@hotmail.com	2330
micheletto.saragat@hotmail.com	147
micheletto.saragat@hotmail.com	574
micheletto.saragat@hotmail.com	1709
micheletto.saragat@hotmail.com	457
micheletto.saragat@hotmail.com	2477
micheletto.saragat@hotmail.com	2517
micheletto.saragat@hotmail.com	654
micheletto.saragat@hotmail.com	1
micheletto.saragat@hotmail.com	492
micheletto.saragat@hotmail.com	1600
micheletto.saragat@hotmail.com	1608
micheletto.saragat@hotmail.com	2100
micheletto.saragat@hotmail.com	2152
micheletto.saragat@hotmail.com	1549
micheletto.saragat@hotmail.com	2047
micheletto.saragat@hotmail.com	108
micheletto.saragat@hotmail.com	576
micheletto.saragat@hotmail.com	699
micheletto.saragat@hotmail.com	1821
micheletto.saragat@hotmail.com	1175
micheletto.saragat@hotmail.com	520
micheletto.saragat@hotmail.com	247
micheletto.saragat@hotmail.com	74
micheletto.saragat@hotmail.com	272
micheletto.saragat@hotmail.com	164
micheletto.saragat@hotmail.com	2351
micheletto.saragat@hotmail.com	2685
micheletto.saragat@hotmail.com	1090
micheletto.saragat@hotmail.com	1869
micheletto.saragat@hotmail.com	118
micheletto.saragat@hotmail.com	287
micheletto.saragat@hotmail.com	1285
micheletto.saragat@hotmail.com	1903
micheletto.saragat@hotmail.com	882
micheletto.saragat@hotmail.com	2119
micheletto.saragat@hotmail.com	2213
micheletto.saragat@hotmail.com	2143
micheletto.saragat@hotmail.com	384
micheletto.saragat@hotmail.com	2092
micheletto.saragat@hotmail.com	1485
micheletto.saragat@hotmail.com	263
micheletto.saragat@hotmail.com	1111
micheletto.saragat@hotmail.com	463
micheletto.saragat@hotmail.com	1882
micheletto.saragat@hotmail.com	902
micheletto.saragat@hotmail.com	867
micheletto.saragat@hotmail.com	309
micheletto.saragat@hotmail.com	945
micheletto.saragat@hotmail.com	1749
micheletto.saragat@hotmail.com	2650
micheletto.saragat@hotmail.com	97
micheletto.saragat@hotmail.com	1382
micheletto.saragat@hotmail.com	689
micheletto.saragat@hotmail.com	2669
micheletto.saragat@hotmail.com	727
micheletto.saragat@hotmail.com	1052
micheletto.saragat@hotmail.com	2853
micheletto.saragat@hotmail.com	1219
micheletto.saragat@hotmail.com	1579
micheletto.saragat@hotmail.com	1505
micheletto.saragat@hotmail.com	1047
micheletto.saragat@hotmail.com	1313
micheletto.saragat@hotmail.com	597
micheletto.saragat@hotmail.com	2465
micheletto.saragat@hotmail.com	1797
micheletto.saragat@hotmail.com	1023
micheletto.saragat@hotmail.com	1301
micheletto.saragat@hotmail.com	2648
micheletto.saragat@hotmail.com	232
micheletto.saragat@hotmail.com	1852
micheletto.saragat@hotmail.com	1417
micheletto.saragat@hotmail.com	72
micheletto.saragat@hotmail.com	1853
micheletto.saragat@hotmail.com	663
micheletto.saragat@hotmail.com	2108
pierpaolo.cerquiglini@virgilio.it	2610
pierpaolo.cerquiglini@virgilio.it	2345
pierpaolo.cerquiglini@virgilio.it	1001
pierpaolo.cerquiglini@virgilio.it	1555
pierpaolo.cerquiglini@virgilio.it	404
pierpaolo.cerquiglini@virgilio.it	666
pierpaolo.cerquiglini@virgilio.it	948
pierpaolo.cerquiglini@virgilio.it	1982
pierpaolo.cerquiglini@virgilio.it	916
pierpaolo.cerquiglini@virgilio.it	1622
pierpaolo.cerquiglini@virgilio.it	45
pierpaolo.cerquiglini@virgilio.it	2515
pierpaolo.cerquiglini@virgilio.it	888
pierpaolo.cerquiglini@virgilio.it	1818
pierpaolo.cerquiglini@virgilio.it	1235
pierpaolo.cerquiglini@virgilio.it	2716
pierpaolo.cerquiglini@virgilio.it	1206
pierpaolo.cerquiglini@virgilio.it	2269
pierpaolo.cerquiglini@virgilio.it	1160
pierpaolo.cerquiglini@virgilio.it	2135
pierpaolo.cerquiglini@virgilio.it	1708
pierpaolo.cerquiglini@virgilio.it	1468
pierpaolo.cerquiglini@virgilio.it	2377
pierpaolo.cerquiglini@virgilio.it	2237
pierpaolo.cerquiglini@virgilio.it	842
pierpaolo.cerquiglini@virgilio.it	576
pierpaolo.cerquiglini@virgilio.it	399
pierpaolo.cerquiglini@virgilio.it	303
pierpaolo.cerquiglini@virgilio.it	2480
pierpaolo.cerquiglini@virgilio.it	1224
pierpaolo.cerquiglini@virgilio.it	1038
pierpaolo.cerquiglini@virgilio.it	519
pierpaolo.cerquiglini@virgilio.it	148
pierpaolo.cerquiglini@virgilio.it	782
pierpaolo.cerquiglini@virgilio.it	1859
pierpaolo.cerquiglini@virgilio.it	2018
pierpaolo.cerquiglini@virgilio.it	1675
pierpaolo.cerquiglini@virgilio.it	2714
pierpaolo.cerquiglini@virgilio.it	1184
pierpaolo.cerquiglini@virgilio.it	1550
pierpaolo.cerquiglini@virgilio.it	899
pierpaolo.cerquiglini@virgilio.it	958
pierpaolo.cerquiglini@virgilio.it	2275
pierpaolo.cerquiglini@virgilio.it	89
pierpaolo.cerquiglini@virgilio.it	2657
pierpaolo.cerquiglini@virgilio.it	115
pierpaolo.cerquiglini@virgilio.it	1422
pierpaolo.cerquiglini@virgilio.it	591
pierpaolo.cerquiglini@virgilio.it	114
pierpaolo.cerquiglini@virgilio.it	396
pierpaolo.cerquiglini@virgilio.it	600
pierpaolo.cerquiglini@virgilio.it	641
pierpaolo.cerquiglini@virgilio.it	1075
pierpaolo.cerquiglini@virgilio.it	1691
pierpaolo.cerquiglini@virgilio.it	910
pierpaolo.cerquiglini@virgilio.it	760
pierpaolo.cerquiglini@virgilio.it	1653
pierpaolo.cerquiglini@virgilio.it	1511
pierpaolo.cerquiglini@virgilio.it	1280
pierpaolo.cerquiglini@virgilio.it	361
pierpaolo.cerquiglini@virgilio.it	877
pierpaolo.cerquiglini@virgilio.it	951
pierpaolo.cerquiglini@virgilio.it	950
pierpaolo.cerquiglini@virgilio.it	32
pierpaolo.cerquiglini@virgilio.it	104
pierpaolo.cerquiglini@virgilio.it	1532
pierpaolo.cerquiglini@virgilio.it	1307
pierpaolo.cerquiglini@virgilio.it	2352
pierpaolo.cerquiglini@virgilio.it	737
pierpaolo.cerquiglini@virgilio.it	2452
pierpaolo.cerquiglini@virgilio.it	2651
pierpaolo.cerquiglini@virgilio.it	2111
pierpaolo.cerquiglini@virgilio.it	198
pierpaolo.cerquiglini@virgilio.it	2470
pierpaolo.cerquiglini@virgilio.it	34
pierpaolo.cerquiglini@virgilio.it	1634
pierpaolo.cerquiglini@virgilio.it	20
pierpaolo.cerquiglini@virgilio.it	2469
pierpaolo.cerquiglini@virgilio.it	586
pierpaolo.cerquiglini@virgilio.it	1382
pierpaolo.cerquiglini@virgilio.it	1718
pierpaolo.cerquiglini@virgilio.it	2323
pierpaolo.cerquiglini@virgilio.it	1463
pierpaolo.cerquiglini@virgilio.it	91
pierpaolo.cerquiglini@virgilio.it	1617
pierpaolo.cerquiglini@virgilio.it	429
pierpaolo.cerquiglini@virgilio.it	1637
pierpaolo.cerquiglini@virgilio.it	2415
pierpaolo.cerquiglini@virgilio.it	2418
pierpaolo.cerquiglini@virgilio.it	25
pierpaolo.cerquiglini@virgilio.it	1019
pierpaolo.cerquiglini@virgilio.it	120
pierpaolo.cerquiglini@virgilio.it	2797
pierpaolo.cerquiglini@virgilio.it	1525
pierpaolo.cerquiglini@virgilio.it	2533
pierpaolo.cerquiglini@virgilio.it	484
pierpaolo.cerquiglini@virgilio.it	2368
pierpaolo.cerquiglini@virgilio.it	593
pierpaolo.cerquiglini@virgilio.it	502
pierpaolo.cerquiglini@virgilio.it	2174
elmo.barbarigo@yahoo.it	880
elmo.barbarigo@yahoo.it	1915
elmo.barbarigo@yahoo.it	145
elmo.barbarigo@yahoo.it	570
elmo.barbarigo@yahoo.it	1899
elmo.barbarigo@yahoo.it	2385
elmo.barbarigo@yahoo.it	1982
elmo.barbarigo@yahoo.it	2612
elmo.barbarigo@yahoo.it	2051
elmo.barbarigo@yahoo.it	2179
elmo.barbarigo@yahoo.it	1789
elmo.barbarigo@yahoo.it	439
elmo.barbarigo@yahoo.it	293
elmo.barbarigo@yahoo.it	1126
elmo.barbarigo@yahoo.it	2329
elmo.barbarigo@yahoo.it	1528
elmo.barbarigo@yahoo.it	371
elmo.barbarigo@yahoo.it	1037
elmo.barbarigo@yahoo.it	908
elmo.barbarigo@yahoo.it	2653
elmo.barbarigo@yahoo.it	1457
elmo.barbarigo@yahoo.it	112
elmo.barbarigo@yahoo.it	2563
elmo.barbarigo@yahoo.it	491
elmo.barbarigo@yahoo.it	971
elmo.barbarigo@yahoo.it	2458
elmo.barbarigo@yahoo.it	2776
elmo.barbarigo@yahoo.it	187
elmo.barbarigo@yahoo.it	1646
elmo.barbarigo@yahoo.it	2609
elmo.barbarigo@yahoo.it	1739
elmo.barbarigo@yahoo.it	719
elmo.barbarigo@yahoo.it	417
elmo.barbarigo@yahoo.it	471
elmo.barbarigo@yahoo.it	1965
elmo.barbarigo@yahoo.it	625
elmo.barbarigo@yahoo.it	321
elmo.barbarigo@yahoo.it	2745
elmo.barbarigo@yahoo.it	2520
elmo.barbarigo@yahoo.it	2672
elmo.barbarigo@yahoo.it	435
elmo.barbarigo@yahoo.it	1996
elmo.barbarigo@yahoo.it	2551
elmo.barbarigo@yahoo.it	2033
elmo.barbarigo@yahoo.it	2529
elmo.barbarigo@yahoo.it	510
elmo.barbarigo@yahoo.it	1781
elmo.barbarigo@yahoo.it	2285
elmo.barbarigo@yahoo.it	2733
elmo.barbarigo@yahoo.it	2202
elmo.barbarigo@yahoo.it	2016
elmo.barbarigo@yahoo.it	1044
elmo.barbarigo@yahoo.it	788
elmo.barbarigo@yahoo.it	1673
elmo.barbarigo@yahoo.it	791
elmo.barbarigo@yahoo.it	1897
elmo.barbarigo@yahoo.it	952
elmo.barbarigo@yahoo.it	1248
elmo.barbarigo@yahoo.it	1549
elmo.barbarigo@yahoo.it	2046
elmo.barbarigo@yahoo.it	1828
elmo.barbarigo@yahoo.it	2111
elmo.barbarigo@yahoo.it	2703
elmo.barbarigo@yahoo.it	2491
elmo.barbarigo@yahoo.it	486
elmo.barbarigo@yahoo.it	1106
elmo.barbarigo@yahoo.it	1233
elmo.barbarigo@yahoo.it	1665
elmo.barbarigo@yahoo.it	1854
elmo.barbarigo@yahoo.it	2560
elmo.barbarigo@yahoo.it	2070
elmo.barbarigo@yahoo.it	1924
elmo.barbarigo@yahoo.it	888
elmo.barbarigo@yahoo.it	1186
elmo.barbarigo@yahoo.it	458
elmo.barbarigo@yahoo.it	578
elmo.barbarigo@yahoo.it	521
elmo.barbarigo@yahoo.it	2048
elmo.barbarigo@yahoo.it	2845
elmo.barbarigo@yahoo.it	973
elmo.barbarigo@yahoo.it	2190
elmo.barbarigo@yahoo.it	287
elmo.barbarigo@yahoo.it	1085
elmo.barbarigo@yahoo.it	48
elmo.barbarigo@yahoo.it	1999
elmo.barbarigo@yahoo.it	2287
elmo.barbarigo@yahoo.it	1247
elmo.barbarigo@yahoo.it	2432
elmo.barbarigo@yahoo.it	1600
elmo.barbarigo@yahoo.it	1866
elmo.barbarigo@yahoo.it	1470
elmo.barbarigo@yahoo.it	2723
elmo.barbarigo@yahoo.it	620
elmo.barbarigo@yahoo.it	2346
elmo.barbarigo@yahoo.it	974
elmo.barbarigo@yahoo.it	2526
elmo.barbarigo@yahoo.it	165
elmo.barbarigo@yahoo.it	1172
elmo.barbarigo@yahoo.it	1014
elmo.barbarigo@yahoo.it	361
eliana.peano@libero.it	2090
eliana.peano@libero.it	2027
eliana.peano@libero.it	2460
eliana.peano@libero.it	51
eliana.peano@libero.it	521
eliana.peano@libero.it	648
eliana.peano@libero.it	2704
eliana.peano@libero.it	2330
eliana.peano@libero.it	2634
eliana.peano@libero.it	498
eliana.peano@libero.it	1591
eliana.peano@libero.it	1180
eliana.peano@libero.it	2067
eliana.peano@libero.it	2130
eliana.peano@libero.it	787
eliana.peano@libero.it	2466
eliana.peano@libero.it	136
eliana.peano@libero.it	34
eliana.peano@libero.it	1945
eliana.peano@libero.it	2729
eliana.peano@libero.it	2352
eliana.peano@libero.it	1600
eliana.peano@libero.it	1086
eliana.peano@libero.it	10
eliana.peano@libero.it	720
eliana.peano@libero.it	839
eliana.peano@libero.it	1224
eliana.peano@libero.it	2206
eliana.peano@libero.it	1792
eliana.peano@libero.it	891
eliana.peano@libero.it	2452
eliana.peano@libero.it	1976
eliana.peano@libero.it	478
eliana.peano@libero.it	2726
eliana.peano@libero.it	713
eliana.peano@libero.it	2571
eliana.peano@libero.it	2356
eliana.peano@libero.it	2092
eliana.peano@libero.it	1245
eliana.peano@libero.it	2174
eliana.peano@libero.it	2093
eliana.peano@libero.it	210
eliana.peano@libero.it	413
eliana.peano@libero.it	2512
eliana.peano@libero.it	1472
eliana.peano@libero.it	1699
eliana.peano@libero.it	575
eliana.peano@libero.it	1488
eliana.peano@libero.it	1316
eliana.peano@libero.it	1179
eliana.peano@libero.it	893
eliana.peano@libero.it	1119
eliana.peano@libero.it	282
eliana.peano@libero.it	2311
eliana.peano@libero.it	4
eliana.peano@libero.it	75
eliana.peano@libero.it	393
eliana.peano@libero.it	2623
eliana.peano@libero.it	2828
eliana.peano@libero.it	1769
eliana.peano@libero.it	2234
eliana.peano@libero.it	1555
eliana.peano@libero.it	1933
eliana.peano@libero.it	971
eliana.peano@libero.it	636
eliana.peano@libero.it	784
eliana.peano@libero.it	692
eliana.peano@libero.it	388
eliana.peano@libero.it	227
eliana.peano@libero.it	705
eliana.peano@libero.it	1277
eliana.peano@libero.it	1901
eliana.peano@libero.it	1552
eliana.peano@libero.it	2484
eliana.peano@libero.it	277
eliana.peano@libero.it	33
eliana.peano@libero.it	1603
eliana.peano@libero.it	2134
eliana.peano@libero.it	1812
eliana.peano@libero.it	1035
eliana.peano@libero.it	1661
eliana.peano@libero.it	2552
eliana.peano@libero.it	357
eliana.peano@libero.it	2080
eliana.peano@libero.it	2525
eliana.peano@libero.it	408
eliana.peano@libero.it	198
eliana.peano@libero.it	935
eliana.peano@libero.it	1727
eliana.peano@libero.it	1644
eliana.peano@libero.it	2302
eliana.peano@libero.it	2279
eliana.peano@libero.it	403
eliana.peano@libero.it	18
eliana.peano@libero.it	1659
eliana.peano@libero.it	2429
eliana.peano@libero.it	1529
eliana.peano@libero.it	586
eliana.peano@libero.it	1425
eliana.peano@libero.it	220
milo.casagrande@yahoo.it	1629
milo.casagrande@yahoo.it	467
milo.casagrande@yahoo.it	2490
milo.casagrande@yahoo.it	923
milo.casagrande@yahoo.it	1012
milo.casagrande@yahoo.it	2541
milo.casagrande@yahoo.it	846
milo.casagrande@yahoo.it	580
milo.casagrande@yahoo.it	2324
milo.casagrande@yahoo.it	992
milo.casagrande@yahoo.it	562
milo.casagrande@yahoo.it	1589
milo.casagrande@yahoo.it	1081
milo.casagrande@yahoo.it	2581
milo.casagrande@yahoo.it	874
milo.casagrande@yahoo.it	2796
milo.casagrande@yahoo.it	2107
milo.casagrande@yahoo.it	641
milo.casagrande@yahoo.it	2358
milo.casagrande@yahoo.it	2252
milo.casagrande@yahoo.it	2004
milo.casagrande@yahoo.it	1911
milo.casagrande@yahoo.it	388
milo.casagrande@yahoo.it	1568
milo.casagrande@yahoo.it	1434
milo.casagrande@yahoo.it	2359
milo.casagrande@yahoo.it	2791
milo.casagrande@yahoo.it	153
milo.casagrande@yahoo.it	2507
milo.casagrande@yahoo.it	787
milo.casagrande@yahoo.it	2171
milo.casagrande@yahoo.it	2722
milo.casagrande@yahoo.it	197
milo.casagrande@yahoo.it	567
milo.casagrande@yahoo.it	1476
milo.casagrande@yahoo.it	800
milo.casagrande@yahoo.it	70
milo.casagrande@yahoo.it	658
milo.casagrande@yahoo.it	430
milo.casagrande@yahoo.it	1469
milo.casagrande@yahoo.it	1949
milo.casagrande@yahoo.it	2641
milo.casagrande@yahoo.it	2818
milo.casagrande@yahoo.it	2496
milo.casagrande@yahoo.it	1726
milo.casagrande@yahoo.it	338
milo.casagrande@yahoo.it	1272
milo.casagrande@yahoo.it	164
milo.casagrande@yahoo.it	71
milo.casagrande@yahoo.it	829
milo.casagrande@yahoo.it	2265
milo.casagrande@yahoo.it	231
milo.casagrande@yahoo.it	1126
milo.casagrande@yahoo.it	852
milo.casagrande@yahoo.it	2338
milo.casagrande@yahoo.it	1633
milo.casagrande@yahoo.it	2509
milo.casagrande@yahoo.it	2253
milo.casagrande@yahoo.it	720
milo.casagrande@yahoo.it	2083
milo.casagrande@yahoo.it	2329
milo.casagrande@yahoo.it	1051
milo.casagrande@yahoo.it	384
milo.casagrande@yahoo.it	1543
milo.casagrande@yahoo.it	474
milo.casagrande@yahoo.it	1613
milo.casagrande@yahoo.it	1381
milo.casagrande@yahoo.it	2672
milo.casagrande@yahoo.it	2362
milo.casagrande@yahoo.it	1181
milo.casagrande@yahoo.it	272
milo.casagrande@yahoo.it	1878
milo.casagrande@yahoo.it	441
milo.casagrande@yahoo.it	1659
milo.casagrande@yahoo.it	1141
milo.casagrande@yahoo.it	2018
milo.casagrande@yahoo.it	109
milo.casagrande@yahoo.it	67
milo.casagrande@yahoo.it	1586
milo.casagrande@yahoo.it	2802
milo.casagrande@yahoo.it	849
milo.casagrande@yahoo.it	712
milo.casagrande@yahoo.it	522
milo.casagrande@yahoo.it	1823
milo.casagrande@yahoo.it	1871
milo.casagrande@yahoo.it	2500
milo.casagrande@yahoo.it	563
milo.casagrande@yahoo.it	266
milo.casagrande@yahoo.it	2238
milo.casagrande@yahoo.it	161
milo.casagrande@yahoo.it	1973
milo.casagrande@yahoo.it	1294
milo.casagrande@yahoo.it	1092
milo.casagrande@yahoo.it	1866
milo.casagrande@yahoo.it	1714
milo.casagrande@yahoo.it	2295
milo.casagrande@yahoo.it	1303
milo.casagrande@yahoo.it	2269
milo.casagrande@yahoo.it	2040
milo.casagrande@yahoo.it	31
paloma.barozzi@hotmail.com	1818
paloma.barozzi@hotmail.com	1676
paloma.barozzi@hotmail.com	862
paloma.barozzi@hotmail.com	456
paloma.barozzi@hotmail.com	875
paloma.barozzi@hotmail.com	485
paloma.barozzi@hotmail.com	137
paloma.barozzi@hotmail.com	387
paloma.barozzi@hotmail.com	683
paloma.barozzi@hotmail.com	1709
paloma.barozzi@hotmail.com	221
paloma.barozzi@hotmail.com	2098
paloma.barozzi@hotmail.com	7
paloma.barozzi@hotmail.com	720
paloma.barozzi@hotmail.com	1820
paloma.barozzi@hotmail.com	2073
paloma.barozzi@hotmail.com	1880
paloma.barozzi@hotmail.com	2479
paloma.barozzi@hotmail.com	31
paloma.barozzi@hotmail.com	2472
paloma.barozzi@hotmail.com	1113
paloma.barozzi@hotmail.com	628
paloma.barozzi@hotmail.com	2548
paloma.barozzi@hotmail.com	1313
paloma.barozzi@hotmail.com	2350
paloma.barozzi@hotmail.com	985
paloma.barozzi@hotmail.com	1544
paloma.barozzi@hotmail.com	1312
paloma.barozzi@hotmail.com	543
paloma.barozzi@hotmail.com	673
paloma.barozzi@hotmail.com	2792
paloma.barozzi@hotmail.com	2095
paloma.barozzi@hotmail.com	2133
paloma.barozzi@hotmail.com	2049
paloma.barozzi@hotmail.com	2727
paloma.barozzi@hotmail.com	1046
paloma.barozzi@hotmail.com	343
paloma.barozzi@hotmail.com	1550
paloma.barozzi@hotmail.com	924
paloma.barozzi@hotmail.com	958
paloma.barozzi@hotmail.com	1172
paloma.barozzi@hotmail.com	2514
paloma.barozzi@hotmail.com	398
paloma.barozzi@hotmail.com	750
paloma.barozzi@hotmail.com	828
paloma.barozzi@hotmail.com	86
paloma.barozzi@hotmail.com	1711
paloma.barozzi@hotmail.com	601
paloma.barozzi@hotmail.com	2398
paloma.barozzi@hotmail.com	204
paloma.barozzi@hotmail.com	1280
paloma.barozzi@hotmail.com	143
paloma.barozzi@hotmail.com	1559
paloma.barozzi@hotmail.com	1263
paloma.barozzi@hotmail.com	2773
paloma.barozzi@hotmail.com	2803
paloma.barozzi@hotmail.com	1489
paloma.barozzi@hotmail.com	14
paloma.barozzi@hotmail.com	1179
paloma.barozzi@hotmail.com	76
paloma.barozzi@hotmail.com	2846
paloma.barozzi@hotmail.com	2122
paloma.barozzi@hotmail.com	317
paloma.barozzi@hotmail.com	1218
paloma.barozzi@hotmail.com	1549
paloma.barozzi@hotmail.com	629
paloma.barozzi@hotmail.com	2002
paloma.barozzi@hotmail.com	2173
paloma.barozzi@hotmail.com	1686
paloma.barozzi@hotmail.com	890
paloma.barozzi@hotmail.com	1882
paloma.barozzi@hotmail.com	2174
paloma.barozzi@hotmail.com	2756
paloma.barozzi@hotmail.com	2508
paloma.barozzi@hotmail.com	1248
paloma.barozzi@hotmail.com	557
paloma.barozzi@hotmail.com	2253
paloma.barozzi@hotmail.com	2709
paloma.barozzi@hotmail.com	1498
paloma.barozzi@hotmail.com	2388
paloma.barozzi@hotmail.com	415
paloma.barozzi@hotmail.com	2586
paloma.barozzi@hotmail.com	2695
paloma.barozzi@hotmail.com	1232
paloma.barozzi@hotmail.com	1039
paloma.barozzi@hotmail.com	2672
paloma.barozzi@hotmail.com	2158
paloma.barozzi@hotmail.com	2372
paloma.barozzi@hotmail.com	2712
paloma.barozzi@hotmail.com	2530
paloma.barozzi@hotmail.com	1072
paloma.barozzi@hotmail.com	779
paloma.barozzi@hotmail.com	739
paloma.barozzi@hotmail.com	2341
paloma.barozzi@hotmail.com	1873
paloma.barozzi@hotmail.com	984
paloma.barozzi@hotmail.com	315
paloma.barozzi@hotmail.com	237
paloma.barozzi@hotmail.com	1116
paloma.barozzi@hotmail.com	584
dino.garibaldi@yahoo.it	2717
dino.garibaldi@yahoo.it	571
dino.garibaldi@yahoo.it	798
dino.garibaldi@yahoo.it	6
dino.garibaldi@yahoo.it	2401
dino.garibaldi@yahoo.it	1943
dino.garibaldi@yahoo.it	477
dino.garibaldi@yahoo.it	649
dino.garibaldi@yahoo.it	680
dino.garibaldi@yahoo.it	25
dino.garibaldi@yahoo.it	2854
dino.garibaldi@yahoo.it	1463
dino.garibaldi@yahoo.it	704
dino.garibaldi@yahoo.it	803
dino.garibaldi@yahoo.it	372
dino.garibaldi@yahoo.it	642
dino.garibaldi@yahoo.it	2448
dino.garibaldi@yahoo.it	2450
dino.garibaldi@yahoo.it	1205
dino.garibaldi@yahoo.it	1062
dino.garibaldi@yahoo.it	2215
dino.garibaldi@yahoo.it	83
dino.garibaldi@yahoo.it	2436
dino.garibaldi@yahoo.it	37
dino.garibaldi@yahoo.it	1009
dino.garibaldi@yahoo.it	676
dino.garibaldi@yahoo.it	179
dino.garibaldi@yahoo.it	469
dino.garibaldi@yahoo.it	815
dino.garibaldi@yahoo.it	560
dino.garibaldi@yahoo.it	1987
dino.garibaldi@yahoo.it	210
dino.garibaldi@yahoo.it	909
dino.garibaldi@yahoo.it	1790
dino.garibaldi@yahoo.it	60
dino.garibaldi@yahoo.it	1773
dino.garibaldi@yahoo.it	1713
dino.garibaldi@yahoo.it	759
dino.garibaldi@yahoo.it	1734
dino.garibaldi@yahoo.it	739
dino.garibaldi@yahoo.it	2202
dino.garibaldi@yahoo.it	496
dino.garibaldi@yahoo.it	2414
dino.garibaldi@yahoo.it	1648
dino.garibaldi@yahoo.it	1593
dino.garibaldi@yahoo.it	1067
dino.garibaldi@yahoo.it	543
dino.garibaldi@yahoo.it	2455
dino.garibaldi@yahoo.it	2001
dino.garibaldi@yahoo.it	2170
dino.garibaldi@yahoo.it	2582
dino.garibaldi@yahoo.it	1484
dino.garibaldi@yahoo.it	2432
dino.garibaldi@yahoo.it	1115
dino.garibaldi@yahoo.it	1381
dino.garibaldi@yahoo.it	85
dino.garibaldi@yahoo.it	2579
dino.garibaldi@yahoo.it	319
dino.garibaldi@yahoo.it	316
dino.garibaldi@yahoo.it	175
dino.garibaldi@yahoo.it	124
dino.garibaldi@yahoo.it	2552
dino.garibaldi@yahoo.it	757
dino.garibaldi@yahoo.it	1697
dino.garibaldi@yahoo.it	289
dino.garibaldi@yahoo.it	323
dino.garibaldi@yahoo.it	122
dino.garibaldi@yahoo.it	1609
dino.garibaldi@yahoo.it	335
dino.garibaldi@yahoo.it	370
dino.garibaldi@yahoo.it	1774
dino.garibaldi@yahoo.it	2294
dino.garibaldi@yahoo.it	1851
dino.garibaldi@yahoo.it	1236
dino.garibaldi@yahoo.it	2680
dino.dallara@hotmail.com	715
dino.garibaldi@yahoo.it	715
lara.grimani@virgilio.it	738
arsenio.fagiani@virgilio.it	738
cristina.tedesco@yahoo.it	738
lamberto.ferrata@libero.it	744
laura.lettiere@yahoo.it	744
flavia.sobrero@virgilio.it	744
lilla.ceci@virgilio.it	783
melania.martucci@virgilio.it	783
vincenza.turati@hotmail.com	783
michelotto.alfieri@hotmail.com	792
vito.petrocelli@hotmail.com	792
eliana.accardo@virgilio.it	792
paoletta.crespi@yahoo.it	808
paoletta.crespi@yahoo.it	2203
luchino.mannoia@gmail.com	808
silvia.camanni@virgilio.it	833
dario.battisti@hotmail.com	833
manuel.lucciano@virgilio.it	833
micheletto.saragat@hotmail.com	856
milo.casagrande@yahoo.it	856
dante.chiesa@libero.it	856
dante.mantegazza@yahoo.it	864
nicoletta.gabbana@gmail.com	864
irma.cimini@hotmail.com	864
nicolò.tedesco@gmail.com	904
vincenza.turati@hotmail.com	904
melania.martucci@virgilio.it	904
michelangelo.antonetti@gmail.com	927
vincenza.turati@hotmail.com	927
donatello.varano@yahoo.it	927
gianluca.carriera@hotmail.com	983
micheletto.saragat@hotmail.com	983
paloma.barozzi@hotmail.com	983
elmo.barbarigo@yahoo.it	986
flavia.sobrero@virgilio.it	986
salvatore.togliatti@virgilio.it	986
dino.garibaldi@yahoo.it	1551
dino.garibaldi@yahoo.it	1898
dino.garibaldi@yahoo.it	1077
dino.garibaldi@yahoo.it	32
dino.garibaldi@yahoo.it	1545
dino.garibaldi@yahoo.it	2186
dino.garibaldi@yahoo.it	2623
dino.garibaldi@yahoo.it	2654
dino.garibaldi@yahoo.it	1919
dino.garibaldi@yahoo.it	2770
dino.garibaldi@yahoo.it	140
dino.garibaldi@yahoo.it	1204
dino.garibaldi@yahoo.it	2311
dino.garibaldi@yahoo.it	2558
dino.garibaldi@yahoo.it	581
dino.garibaldi@yahoo.it	415
dino.garibaldi@yahoo.it	519
dino.garibaldi@yahoo.it	1293
dino.garibaldi@yahoo.it	586
dino.garibaldi@yahoo.it	1107
dino.garibaldi@yahoo.it	1755
dino.garibaldi@yahoo.it	2015
dino.garibaldi@yahoo.it	1281
dino.garibaldi@yahoo.it	412
dino.garibaldi@yahoo.it	1836
giacinto.scarfoglio@yahoo.it	746
giacinto.scarfoglio@yahoo.it	1116
giacinto.scarfoglio@yahoo.it	1476
giacinto.scarfoglio@yahoo.it	1676
giacinto.scarfoglio@yahoo.it	2766
giacinto.scarfoglio@yahoo.it	936
giacinto.scarfoglio@yahoo.it	2812
giacinto.scarfoglio@yahoo.it	1760
giacinto.scarfoglio@yahoo.it	1625
giacinto.scarfoglio@yahoo.it	1479
giacinto.scarfoglio@yahoo.it	1090
giacinto.scarfoglio@yahoo.it	1382
giacinto.scarfoglio@yahoo.it	136
giacinto.scarfoglio@yahoo.it	1583
giacinto.scarfoglio@yahoo.it	1411
giacinto.scarfoglio@yahoo.it	2307
giacinto.scarfoglio@yahoo.it	1054
giacinto.scarfoglio@yahoo.it	248
giacinto.scarfoglio@yahoo.it	1458
giacinto.scarfoglio@yahoo.it	1236
giacinto.scarfoglio@yahoo.it	619
giacinto.scarfoglio@yahoo.it	1245
giacinto.scarfoglio@yahoo.it	730
giacinto.scarfoglio@yahoo.it	2437
giacinto.scarfoglio@yahoo.it	1953
giacinto.scarfoglio@yahoo.it	1648
giacinto.scarfoglio@yahoo.it	2798
giacinto.scarfoglio@yahoo.it	2110
giacinto.scarfoglio@yahoo.it	888
giacinto.scarfoglio@yahoo.it	1883
giacinto.scarfoglio@yahoo.it	2624
giacinto.scarfoglio@yahoo.it	732
giacinto.scarfoglio@yahoo.it	1503
giacinto.scarfoglio@yahoo.it	294
giacinto.scarfoglio@yahoo.it	134
giacinto.scarfoglio@yahoo.it	2408
giacinto.scarfoglio@yahoo.it	2131
giacinto.scarfoglio@yahoo.it	366
giacinto.scarfoglio@yahoo.it	340
giacinto.scarfoglio@yahoo.it	1057
giacinto.scarfoglio@yahoo.it	992
giacinto.scarfoglio@yahoo.it	319
giacinto.scarfoglio@yahoo.it	2311
giacinto.scarfoglio@yahoo.it	21
giacinto.scarfoglio@yahoo.it	2214
giacinto.scarfoglio@yahoo.it	2655
giacinto.scarfoglio@yahoo.it	748
giacinto.scarfoglio@yahoo.it	527
giacinto.scarfoglio@yahoo.it	1210
giacinto.scarfoglio@yahoo.it	1585
giacinto.scarfoglio@yahoo.it	1505
giacinto.scarfoglio@yahoo.it	1905
giacinto.scarfoglio@yahoo.it	2652
giacinto.scarfoglio@yahoo.it	2640
giacinto.scarfoglio@yahoo.it	2463
giacinto.scarfoglio@yahoo.it	2145
giacinto.scarfoglio@yahoo.it	1552
giacinto.scarfoglio@yahoo.it	1470
giacinto.scarfoglio@yahoo.it	763
giacinto.scarfoglio@yahoo.it	72
giacinto.scarfoglio@yahoo.it	1127
giacinto.scarfoglio@yahoo.it	2399
giacinto.scarfoglio@yahoo.it	1241
giacinto.scarfoglio@yahoo.it	482
giacinto.scarfoglio@yahoo.it	2094
giacinto.scarfoglio@yahoo.it	360
giacinto.scarfoglio@yahoo.it	1029
giacinto.scarfoglio@yahoo.it	2266
giacinto.scarfoglio@yahoo.it	1233
giacinto.scarfoglio@yahoo.it	2470
giacinto.scarfoglio@yahoo.it	1720
giacinto.scarfoglio@yahoo.it	417
giacinto.scarfoglio@yahoo.it	594
giacinto.scarfoglio@yahoo.it	2477
giacinto.scarfoglio@yahoo.it	1179
giacinto.scarfoglio@yahoo.it	2161
giacinto.scarfoglio@yahoo.it	403
giacinto.scarfoglio@yahoo.it	2107
giacinto.scarfoglio@yahoo.it	1804
giacinto.scarfoglio@yahoo.it	2411
giacinto.scarfoglio@yahoo.it	2856
giacinto.scarfoglio@yahoo.it	1601
giacinto.scarfoglio@yahoo.it	1732
giacinto.scarfoglio@yahoo.it	1936
giacinto.scarfoglio@yahoo.it	1061
giacinto.scarfoglio@yahoo.it	2813
giacinto.scarfoglio@yahoo.it	404
giacinto.scarfoglio@yahoo.it	625
giacinto.scarfoglio@yahoo.it	646
giacinto.scarfoglio@yahoo.it	1650
giacinto.scarfoglio@yahoo.it	876
giacinto.scarfoglio@yahoo.it	2726
giacinto.scarfoglio@yahoo.it	1302
giacinto.scarfoglio@yahoo.it	1537
giacinto.scarfoglio@yahoo.it	2065
giacinto.scarfoglio@yahoo.it	1112
giacinto.scarfoglio@yahoo.it	1293
giacinto.scarfoglio@yahoo.it	394
giacinto.scarfoglio@yahoo.it	841
giacinto.scarfoglio@yahoo.it	252
patrizia.accardo@yahoo.it	1812
patrizia.accardo@yahoo.it	280
patrizia.accardo@yahoo.it	2171
patrizia.accardo@yahoo.it	1785
patrizia.accardo@yahoo.it	585
patrizia.accardo@yahoo.it	1041
patrizia.accardo@yahoo.it	1540
patrizia.accardo@yahoo.it	406
patrizia.accardo@yahoo.it	148
patrizia.accardo@yahoo.it	2489
patrizia.accardo@yahoo.it	1221
patrizia.accardo@yahoo.it	2649
patrizia.accardo@yahoo.it	607
patrizia.accardo@yahoo.it	129
patrizia.accardo@yahoo.it	2467
patrizia.accardo@yahoo.it	2564
patrizia.accardo@yahoo.it	1235
patrizia.accardo@yahoo.it	331
patrizia.accardo@yahoo.it	731
patrizia.accardo@yahoo.it	1698
patrizia.accardo@yahoo.it	1071
patrizia.accardo@yahoo.it	979
patrizia.accardo@yahoo.it	211
patrizia.accardo@yahoo.it	695
patrizia.accardo@yahoo.it	185
patrizia.accardo@yahoo.it	2529
patrizia.accardo@yahoo.it	1986
patrizia.accardo@yahoo.it	69
patrizia.accardo@yahoo.it	416
patrizia.accardo@yahoo.it	250
patrizia.accardo@yahoo.it	951
patrizia.accardo@yahoo.it	1916
patrizia.accardo@yahoo.it	312
patrizia.accardo@yahoo.it	991
patrizia.accardo@yahoo.it	1737
patrizia.accardo@yahoo.it	973
patrizia.accardo@yahoo.it	750
patrizia.accardo@yahoo.it	1891
patrizia.accardo@yahoo.it	1913
patrizia.accardo@yahoo.it	1279
patrizia.accardo@yahoo.it	24
patrizia.accardo@yahoo.it	385
patrizia.accardo@yahoo.it	376
patrizia.accardo@yahoo.it	94
patrizia.accardo@yahoo.it	1823
patrizia.accardo@yahoo.it	2603
patrizia.accardo@yahoo.it	705
patrizia.accardo@yahoo.it	1894
patrizia.accardo@yahoo.it	1417
patrizia.accardo@yahoo.it	2262
patrizia.accardo@yahoo.it	2115
patrizia.accardo@yahoo.it	469
patrizia.accardo@yahoo.it	296
patrizia.accardo@yahoo.it	1078
patrizia.accardo@yahoo.it	937
patrizia.accardo@yahoo.it	1914
patrizia.accardo@yahoo.it	1934
patrizia.accardo@yahoo.it	297
patrizia.accardo@yahoo.it	745
patrizia.accardo@yahoo.it	2192
patrizia.accardo@yahoo.it	686
patrizia.accardo@yahoo.it	928
patrizia.accardo@yahoo.it	2119
patrizia.accardo@yahoo.it	2515
patrizia.accardo@yahoo.it	2710
patrizia.accardo@yahoo.it	1597
patrizia.accardo@yahoo.it	1643
patrizia.accardo@yahoo.it	1862
patrizia.accardo@yahoo.it	2101
patrizia.accardo@yahoo.it	2540
patrizia.accardo@yahoo.it	1503
patrizia.accardo@yahoo.it	683
patrizia.accardo@yahoo.it	2367
patrizia.accardo@yahoo.it	1010
patrizia.accardo@yahoo.it	223
patrizia.accardo@yahoo.it	563
patrizia.accardo@yahoo.it	1080
patrizia.accardo@yahoo.it	869
patrizia.accardo@yahoo.it	2494
patrizia.accardo@yahoo.it	194
patrizia.accardo@yahoo.it	2186
patrizia.accardo@yahoo.it	1732
patrizia.accardo@yahoo.it	2041
patrizia.accardo@yahoo.it	2756
patrizia.accardo@yahoo.it	1446
patrizia.accardo@yahoo.it	915
patrizia.accardo@yahoo.it	2182
patrizia.accardo@yahoo.it	989
patrizia.accardo@yahoo.it	959
patrizia.accardo@yahoo.it	1001
patrizia.accardo@yahoo.it	457
patrizia.accardo@yahoo.it	2509
patrizia.accardo@yahoo.it	2066
patrizia.accardo@yahoo.it	2547
patrizia.accardo@yahoo.it	1171
patrizia.accardo@yahoo.it	603
patrizia.accardo@yahoo.it	261
patrizia.accardo@yahoo.it	1222
patrizia.accardo@yahoo.it	2389
patrizia.accardo@yahoo.it	1011
lamberto.ferrata@libero.it	1281
lamberto.ferrata@libero.it	572
lamberto.ferrata@libero.it	1239
lamberto.ferrata@libero.it	236
lamberto.ferrata@libero.it	1433
lamberto.ferrata@libero.it	2083
lamberto.ferrata@libero.it	2399
lamberto.ferrata@libero.it	1637
lamberto.ferrata@libero.it	1162
lamberto.ferrata@libero.it	1702
lamberto.ferrata@libero.it	2339
lamberto.ferrata@libero.it	1312
lamberto.ferrata@libero.it	437
lamberto.ferrata@libero.it	1812
lamberto.ferrata@libero.it	1752
lamberto.ferrata@libero.it	1024
lamberto.ferrata@libero.it	1262
lamberto.ferrata@libero.it	1453
lamberto.ferrata@libero.it	1108
lamberto.ferrata@libero.it	1505
lamberto.ferrata@libero.it	2771
lamberto.ferrata@libero.it	2389
lamberto.ferrata@libero.it	786
lamberto.ferrata@libero.it	622
lamberto.ferrata@libero.it	430
lamberto.ferrata@libero.it	1959
lamberto.ferrata@libero.it	2112
lamberto.ferrata@libero.it	1949
lamberto.ferrata@libero.it	2195
lamberto.ferrata@libero.it	1656
lamberto.ferrata@libero.it	2691
lamberto.ferrata@libero.it	196
lamberto.ferrata@libero.it	1421
lamberto.ferrata@libero.it	955
lamberto.ferrata@libero.it	26
lamberto.ferrata@libero.it	1712
lamberto.ferrata@libero.it	639
lamberto.ferrata@libero.it	232
lamberto.ferrata@libero.it	626
lamberto.ferrata@libero.it	822
lamberto.ferrata@libero.it	540
lamberto.ferrata@libero.it	2312
lamberto.ferrata@libero.it	1198
lamberto.ferrata@libero.it	1907
lamberto.ferrata@libero.it	2141
lamberto.ferrata@libero.it	891
lamberto.ferrata@libero.it	1293
lamberto.ferrata@libero.it	91
lamberto.ferrata@libero.it	1171
lamberto.ferrata@libero.it	1741
lamberto.ferrata@libero.it	650
lamberto.ferrata@libero.it	844
lamberto.ferrata@libero.it	2598
lamberto.ferrata@libero.it	458
lamberto.ferrata@libero.it	1539
lamberto.ferrata@libero.it	2084
lamberto.ferrata@libero.it	2111
lamberto.ferrata@libero.it	1254
lamberto.ferrata@libero.it	2567
lamberto.ferrata@libero.it	888
lamberto.ferrata@libero.it	1297
lamberto.ferrata@libero.it	85
lamberto.ferrata@libero.it	2593
lamberto.ferrata@libero.it	2585
lamberto.ferrata@libero.it	952
lamberto.ferrata@libero.it	2484
lamberto.ferrata@libero.it	1974
lamberto.ferrata@libero.it	19
lamberto.ferrata@libero.it	99
lamberto.ferrata@libero.it	2303
lamberto.ferrata@libero.it	1811
lamberto.ferrata@libero.it	405
lamberto.ferrata@libero.it	621
lamberto.ferrata@libero.it	719
lamberto.ferrata@libero.it	1872
lamberto.ferrata@libero.it	2135
lamberto.ferrata@libero.it	489
lamberto.ferrata@libero.it	1863
lamberto.ferrata@libero.it	451
lamberto.ferrata@libero.it	2437
lamberto.ferrata@libero.it	34
lamberto.ferrata@libero.it	742
lamberto.ferrata@libero.it	2081
lamberto.ferrata@libero.it	579
lamberto.ferrata@libero.it	770
lamberto.ferrata@libero.it	2307
lamberto.ferrata@libero.it	13
lamberto.ferrata@libero.it	2632
lamberto.ferrata@libero.it	778
lamberto.ferrata@libero.it	53
lamberto.ferrata@libero.it	2416
lamberto.ferrata@libero.it	2190
lamberto.ferrata@libero.it	673
lamberto.ferrata@libero.it	1592
lamberto.ferrata@libero.it	269
lamberto.ferrata@libero.it	793
lamberto.ferrata@libero.it	2554
lamberto.ferrata@libero.it	2599
lamberto.ferrata@libero.it	2794
lamberto.ferrata@libero.it	248
laura.lettiere@yahoo.it	2176
laura.lettiere@yahoo.it	2353
laura.lettiere@yahoo.it	1042
laura.lettiere@yahoo.it	15
laura.lettiere@yahoo.it	1253
laura.lettiere@yahoo.it	2436
laura.lettiere@yahoo.it	1271
laura.lettiere@yahoo.it	1202
laura.lettiere@yahoo.it	604
laura.lettiere@yahoo.it	1250
laura.lettiere@yahoo.it	532
laura.lettiere@yahoo.it	2287
laura.lettiere@yahoo.it	2735
laura.lettiere@yahoo.it	2571
laura.lettiere@yahoo.it	120
laura.lettiere@yahoo.it	2006
laura.lettiere@yahoo.it	1549
laura.lettiere@yahoo.it	198
laura.lettiere@yahoo.it	1246
laura.lettiere@yahoo.it	256
laura.lettiere@yahoo.it	1263
laura.lettiere@yahoo.it	1892
laura.lettiere@yahoo.it	1532
laura.lettiere@yahoo.it	43
laura.lettiere@yahoo.it	1832
laura.lettiere@yahoo.it	100
laura.lettiere@yahoo.it	1462
laura.lettiere@yahoo.it	883
laura.lettiere@yahoo.it	510
laura.lettiere@yahoo.it	2692
laura.lettiere@yahoo.it	594
laura.lettiere@yahoo.it	2714
laura.lettiere@yahoo.it	932
laura.lettiere@yahoo.it	980
laura.lettiere@yahoo.it	750
laura.lettiere@yahoo.it	902
laura.lettiere@yahoo.it	2574
laura.lettiere@yahoo.it	736
laura.lettiere@yahoo.it	2602
laura.lettiere@yahoo.it	220
laura.lettiere@yahoo.it	320
laura.lettiere@yahoo.it	309
laura.lettiere@yahoo.it	1506
laura.lettiere@yahoo.it	192
laura.lettiere@yahoo.it	1064
laura.lettiere@yahoo.it	2458
laura.lettiere@yahoo.it	1663
laura.lettiere@yahoo.it	593
laura.lettiere@yahoo.it	1868
laura.lettiere@yahoo.it	1242
laura.lettiere@yahoo.it	2421
laura.lettiere@yahoo.it	2084
laura.lettiere@yahoo.it	1181
laura.lettiere@yahoo.it	1528
laura.lettiere@yahoo.it	57
laura.lettiere@yahoo.it	1624
laura.lettiere@yahoo.it	475
laura.lettiere@yahoo.it	2237
laura.lettiere@yahoo.it	232
laura.lettiere@yahoo.it	1224
laura.lettiere@yahoo.it	855
laura.lettiere@yahoo.it	2119
laura.lettiere@yahoo.it	955
laura.lettiere@yahoo.it	1769
laura.lettiere@yahoo.it	521
laura.lettiere@yahoo.it	764
laura.lettiere@yahoo.it	2056
laura.lettiere@yahoo.it	950
laura.lettiere@yahoo.it	2266
laura.lettiere@yahoo.it	2381
laura.lettiere@yahoo.it	1633
laura.lettiere@yahoo.it	1264
laura.lettiere@yahoo.it	456
laura.lettiere@yahoo.it	2424
laura.lettiere@yahoo.it	1696
laura.lettiere@yahoo.it	1218
laura.lettiere@yahoo.it	278
laura.lettiere@yahoo.it	929
laura.lettiere@yahoo.it	1771
laura.lettiere@yahoo.it	157
laura.lettiere@yahoo.it	2652
laura.lettiere@yahoo.it	2367
laura.lettiere@yahoo.it	769
laura.lettiere@yahoo.it	1423
laura.lettiere@yahoo.it	2069
laura.lettiere@yahoo.it	2018
laura.lettiere@yahoo.it	546
laura.lettiere@yahoo.it	1372
laura.lettiere@yahoo.it	2173
laura.lettiere@yahoo.it	2315
laura.lettiere@yahoo.it	38
laura.lettiere@yahoo.it	460
laura.lettiere@yahoo.it	2280
laura.lettiere@yahoo.it	1061
laura.lettiere@yahoo.it	1474
laura.lettiere@yahoo.it	11
laura.lettiere@yahoo.it	2585
laura.lettiere@yahoo.it	2826
laura.lettiere@yahoo.it	2770
laura.lettiere@yahoo.it	203
sante.malaparte@libero.it	202
sante.malaparte@libero.it	1047
sante.malaparte@libero.it	1991
sante.malaparte@libero.it	1536
sante.malaparte@libero.it	1243
sante.malaparte@libero.it	1259
sante.malaparte@libero.it	817
sante.malaparte@libero.it	2317
sante.malaparte@libero.it	2425
sante.malaparte@libero.it	736
sante.malaparte@libero.it	220
sante.malaparte@libero.it	1187
sante.malaparte@libero.it	2297
sante.malaparte@libero.it	153
sante.malaparte@libero.it	2679
sante.malaparte@libero.it	317
sante.malaparte@libero.it	130
sante.malaparte@libero.it	2095
sante.malaparte@libero.it	2114
sante.malaparte@libero.it	1918
sante.malaparte@libero.it	2566
sante.malaparte@libero.it	2859
sante.malaparte@libero.it	331
sante.malaparte@libero.it	1990
sante.malaparte@libero.it	2497
sante.malaparte@libero.it	837
sante.malaparte@libero.it	2248
sante.malaparte@libero.it	1861
sante.malaparte@libero.it	2640
sante.malaparte@libero.it	2119
sante.malaparte@libero.it	2291
sante.malaparte@libero.it	764
sante.malaparte@libero.it	2283
sante.malaparte@libero.it	2260
sante.malaparte@libero.it	2137
sante.malaparte@libero.it	2237
sante.malaparte@libero.it	2841
sante.malaparte@libero.it	613
sante.malaparte@libero.it	474
sante.malaparte@libero.it	2225
sante.malaparte@libero.it	636
sante.malaparte@libero.it	1254
sante.malaparte@libero.it	2845
sante.malaparte@libero.it	460
sante.malaparte@libero.it	1684
sante.malaparte@libero.it	815
sante.malaparte@libero.it	643
sante.malaparte@libero.it	62
sante.malaparte@libero.it	852
sante.malaparte@libero.it	1791
sante.malaparte@libero.it	1836
sante.malaparte@libero.it	1462
sante.malaparte@libero.it	1050
sante.malaparte@libero.it	1275
sante.malaparte@libero.it	1272
sante.malaparte@libero.it	2802
sante.malaparte@libero.it	2717
sante.malaparte@libero.it	830
sante.malaparte@libero.it	1423
sante.malaparte@libero.it	1718
sante.malaparte@libero.it	2604
sante.malaparte@libero.it	1412
sante.malaparte@libero.it	1636
sante.malaparte@libero.it	1939
sante.malaparte@libero.it	64
sante.malaparte@libero.it	1909
sante.malaparte@libero.it	88
sante.malaparte@libero.it	140
sante.malaparte@libero.it	1998
sante.malaparte@libero.it	282
sante.malaparte@libero.it	1652
sante.malaparte@libero.it	1729
sante.malaparte@libero.it	237
sante.malaparte@libero.it	2753
sante.malaparte@libero.it	976
sante.malaparte@libero.it	630
sante.malaparte@libero.it	1704
sante.malaparte@libero.it	2188
sante.malaparte@libero.it	380
sante.malaparte@libero.it	350
sante.malaparte@libero.it	756
sante.malaparte@libero.it	187
sante.malaparte@libero.it	1199
sante.malaparte@libero.it	2553
sante.malaparte@libero.it	1284
sante.malaparte@libero.it	2303
sante.malaparte@libero.it	136
sante.malaparte@libero.it	2328
sante.malaparte@libero.it	1173
sante.malaparte@libero.it	1277
sante.malaparte@libero.it	1420
sante.malaparte@libero.it	1095
sante.malaparte@libero.it	345
sante.malaparte@libero.it	784
sante.malaparte@libero.it	1089
sante.malaparte@libero.it	5
sante.malaparte@libero.it	444
sante.malaparte@libero.it	17
sante.malaparte@libero.it	1139
sante.malaparte@libero.it	1000
vincenza.salandra@yahoo.it	58
vincenza.salandra@yahoo.it	575
vincenza.salandra@yahoo.it	2124
vincenza.salandra@yahoo.it	704
vincenza.salandra@yahoo.it	2780
vincenza.salandra@yahoo.it	2090
vincenza.salandra@yahoo.it	1174
vincenza.salandra@yahoo.it	117
vincenza.salandra@yahoo.it	1512
vincenza.salandra@yahoo.it	2812
vincenza.salandra@yahoo.it	37
vincenza.salandra@yahoo.it	2213
vincenza.salandra@yahoo.it	886
vincenza.salandra@yahoo.it	620
vincenza.salandra@yahoo.it	295
vincenza.salandra@yahoo.it	1230
vincenza.salandra@yahoo.it	661
vincenza.salandra@yahoo.it	675
vincenza.salandra@yahoo.it	2775
vincenza.salandra@yahoo.it	2813
vincenza.salandra@yahoo.it	1510
vincenza.salandra@yahoo.it	539
vincenza.salandra@yahoo.it	2016
vincenza.salandra@yahoo.it	1888
vincenza.salandra@yahoo.it	174
vincenza.salandra@yahoo.it	1930
vincenza.salandra@yahoo.it	1802
vincenza.salandra@yahoo.it	861
vincenza.salandra@yahoo.it	1414
vincenza.salandra@yahoo.it	2387
vincenza.salandra@yahoo.it	242
vincenza.salandra@yahoo.it	2613
vincenza.salandra@yahoo.it	1995
vincenza.salandra@yahoo.it	221
vincenza.salandra@yahoo.it	2228
vincenza.salandra@yahoo.it	244
vincenza.salandra@yahoo.it	2151
vincenza.salandra@yahoo.it	80
vincenza.salandra@yahoo.it	2755
vincenza.salandra@yahoo.it	1662
vincenza.salandra@yahoo.it	902
vincenza.salandra@yahoo.it	2398
vincenza.salandra@yahoo.it	1123
vincenza.salandra@yahoo.it	1202
vincenza.salandra@yahoo.it	413
vincenza.salandra@yahoo.it	2402
vincenza.salandra@yahoo.it	2005
vincenza.salandra@yahoo.it	887
vincenza.salandra@yahoo.it	366
vincenza.salandra@yahoo.it	975
vincenza.salandra@yahoo.it	1847
vincenza.salandra@yahoo.it	368
vincenza.salandra@yahoo.it	779
vincenza.salandra@yahoo.it	1608
vincenza.salandra@yahoo.it	1408
vincenza.salandra@yahoo.it	604
vincenza.salandra@yahoo.it	1633
vincenza.salandra@yahoo.it	1665
vincenza.salandra@yahoo.it	2683
vincenza.salandra@yahoo.it	679
vincenza.salandra@yahoo.it	194
vincenza.salandra@yahoo.it	253
vincenza.salandra@yahoo.it	950
vincenza.salandra@yahoo.it	2550
vincenza.salandra@yahoo.it	2438
vincenza.salandra@yahoo.it	2462
vincenza.salandra@yahoo.it	2776
vincenza.salandra@yahoo.it	393
vincenza.salandra@yahoo.it	1160
vincenza.salandra@yahoo.it	1683
vincenza.salandra@yahoo.it	347
vincenza.salandra@yahoo.it	913
vincenza.salandra@yahoo.it	2436
vincenza.salandra@yahoo.it	1290
vincenza.salandra@yahoo.it	1476
vincenza.salandra@yahoo.it	1067
vincenza.salandra@yahoo.it	108
vincenza.salandra@yahoo.it	2093
vincenza.salandra@yahoo.it	2541
vincenza.salandra@yahoo.it	909
vincenza.salandra@yahoo.it	2666
vincenza.salandra@yahoo.it	943
vincenza.salandra@yahoo.it	68
vincenza.salandra@yahoo.it	2286
vincenza.salandra@yahoo.it	304
vincenza.salandra@yahoo.it	650
vincenza.salandra@yahoo.it	1018
vincenza.salandra@yahoo.it	2449
vincenza.salandra@yahoo.it	1293
vincenza.salandra@yahoo.it	1748
vincenza.salandra@yahoo.it	1685
vincenza.salandra@yahoo.it	2646
vincenza.salandra@yahoo.it	614
vincenza.salandra@yahoo.it	193
vincenza.salandra@yahoo.it	1053
vincenza.salandra@yahoo.it	1764
vincenza.salandra@yahoo.it	2477
vincenza.salandra@yahoo.it	2486
vincenza.salandra@yahoo.it	1678
vincenza.salandra@yahoo.it	2770
silvia.camanni@virgilio.it	2265
silvia.camanni@virgilio.it	1152
silvia.camanni@virgilio.it	557
silvia.camanni@virgilio.it	2391
silvia.camanni@virgilio.it	707
silvia.camanni@virgilio.it	627
silvia.camanni@virgilio.it	1206
silvia.camanni@virgilio.it	377
silvia.camanni@virgilio.it	2364
silvia.camanni@virgilio.it	742
silvia.camanni@virgilio.it	2764
silvia.camanni@virgilio.it	1615
silvia.camanni@virgilio.it	110
silvia.camanni@virgilio.it	2078
silvia.camanni@virgilio.it	879
silvia.camanni@virgilio.it	2799
silvia.camanni@virgilio.it	1813
silvia.camanni@virgilio.it	1544
silvia.camanni@virgilio.it	2589
silvia.camanni@virgilio.it	64
silvia.camanni@virgilio.it	1279
silvia.camanni@virgilio.it	304
silvia.camanni@virgilio.it	782
silvia.camanni@virgilio.it	2375
silvia.camanni@virgilio.it	1320
silvia.camanni@virgilio.it	2536
silvia.camanni@virgilio.it	1433
silvia.camanni@virgilio.it	803
silvia.camanni@virgilio.it	450
silvia.camanni@virgilio.it	490
silvia.camanni@virgilio.it	336
silvia.camanni@virgilio.it	8
silvia.camanni@virgilio.it	2350
silvia.camanni@virgilio.it	2740
silvia.camanni@virgilio.it	289
silvia.camanni@virgilio.it	2135
silvia.camanni@virgilio.it	2081
silvia.camanni@virgilio.it	2507
silvia.camanni@virgilio.it	91
silvia.camanni@virgilio.it	576
silvia.camanni@virgilio.it	1070
silvia.camanni@virgilio.it	422
silvia.camanni@virgilio.it	2080
silvia.camanni@virgilio.it	1708
silvia.camanni@virgilio.it	242
silvia.camanni@virgilio.it	2229
silvia.camanni@virgilio.it	1831
silvia.camanni@virgilio.it	2703
silvia.camanni@virgilio.it	1156
silvia.camanni@virgilio.it	2306
silvia.camanni@virgilio.it	2293
silvia.camanni@virgilio.it	2090
silvia.camanni@virgilio.it	2107
silvia.camanni@virgilio.it	641
silvia.camanni@virgilio.it	1795
silvia.camanni@virgilio.it	2814
silvia.camanni@virgilio.it	2065
silvia.camanni@virgilio.it	2125
silvia.camanni@virgilio.it	1253
silvia.camanni@virgilio.it	1221
silvia.camanni@virgilio.it	68
silvia.camanni@virgilio.it	2360
silvia.camanni@virgilio.it	2225
silvia.camanni@virgilio.it	219
silvia.camanni@virgilio.it	2043
silvia.camanni@virgilio.it	198
silvia.camanni@virgilio.it	2239
silvia.camanni@virgilio.it	265
silvia.camanni@virgilio.it	2243
silvia.camanni@virgilio.it	2524
silvia.camanni@virgilio.it	1934
silvia.camanni@virgilio.it	1234
silvia.camanni@virgilio.it	1442
silvia.camanni@virgilio.it	1092
silvia.camanni@virgilio.it	683
silvia.camanni@virgilio.it	500
silvia.camanni@virgilio.it	1148
silvia.camanni@virgilio.it	1246
silvia.camanni@virgilio.it	743
silvia.camanni@virgilio.it	1959
silvia.camanni@virgilio.it	912
silvia.camanni@virgilio.it	2312
silvia.camanni@virgilio.it	658
silvia.camanni@virgilio.it	2274
silvia.camanni@virgilio.it	567
silvia.camanni@virgilio.it	1792
silvia.camanni@virgilio.it	2254
silvia.camanni@virgilio.it	1025
silvia.camanni@virgilio.it	2244
silvia.camanni@virgilio.it	1528
silvia.camanni@virgilio.it	88
silvia.camanni@virgilio.it	2371
silvia.camanni@virgilio.it	188
silvia.camanni@virgilio.it	2599
silvia.camanni@virgilio.it	1806
silvia.camanni@virgilio.it	2063
silvia.camanni@virgilio.it	2288
silvia.camanni@virgilio.it	2563
silvia.camanni@virgilio.it	2213
silvia.camanni@virgilio.it	239
calcedonio.scarponi@libero.it	2315
calcedonio.scarponi@libero.it	2194
calcedonio.scarponi@libero.it	238
calcedonio.scarponi@libero.it	750
calcedonio.scarponi@libero.it	23
calcedonio.scarponi@libero.it	1642
calcedonio.scarponi@libero.it	1162
calcedonio.scarponi@libero.it	2368
calcedonio.scarponi@libero.it	493
calcedonio.scarponi@libero.it	748
calcedonio.scarponi@libero.it	2467
calcedonio.scarponi@libero.it	1559
calcedonio.scarponi@libero.it	2482
calcedonio.scarponi@libero.it	2080
calcedonio.scarponi@libero.it	528
calcedonio.scarponi@libero.it	115
calcedonio.scarponi@libero.it	2435
calcedonio.scarponi@libero.it	2569
calcedonio.scarponi@libero.it	2205
calcedonio.scarponi@libero.it	1449
calcedonio.scarponi@libero.it	2396
calcedonio.scarponi@libero.it	2634
calcedonio.scarponi@libero.it	570
calcedonio.scarponi@libero.it	448
calcedonio.scarponi@libero.it	1104
calcedonio.scarponi@libero.it	1290
calcedonio.scarponi@libero.it	487
calcedonio.scarponi@libero.it	539
calcedonio.scarponi@libero.it	1564
calcedonio.scarponi@libero.it	116
calcedonio.scarponi@libero.it	1382
calcedonio.scarponi@libero.it	2335
calcedonio.scarponi@libero.it	2662
calcedonio.scarponi@libero.it	194
calcedonio.scarponi@libero.it	985
calcedonio.scarponi@libero.it	722
calcedonio.scarponi@libero.it	2522
calcedonio.scarponi@libero.it	122
calcedonio.scarponi@libero.it	2121
calcedonio.scarponi@libero.it	353
calcedonio.scarponi@libero.it	847
calcedonio.scarponi@libero.it	463
calcedonio.scarponi@libero.it	878
calcedonio.scarponi@libero.it	1770
calcedonio.scarponi@libero.it	1782
calcedonio.scarponi@libero.it	1910
calcedonio.scarponi@libero.it	753
calcedonio.scarponi@libero.it	335
calcedonio.scarponi@libero.it	745
calcedonio.scarponi@libero.it	867
calcedonio.scarponi@libero.it	291
calcedonio.scarponi@libero.it	671
calcedonio.scarponi@libero.it	416
calcedonio.scarponi@libero.it	2473
calcedonio.scarponi@libero.it	13
calcedonio.scarponi@libero.it	2793
calcedonio.scarponi@libero.it	2052
calcedonio.scarponi@libero.it	1799
calcedonio.scarponi@libero.it	1791
calcedonio.scarponi@libero.it	2290
calcedonio.scarponi@libero.it	549
calcedonio.scarponi@libero.it	511
calcedonio.scarponi@libero.it	941
calcedonio.scarponi@libero.it	2352
calcedonio.scarponi@libero.it	1190
calcedonio.scarponi@libero.it	2440
calcedonio.scarponi@libero.it	2803
calcedonio.scarponi@libero.it	468
calcedonio.scarponi@libero.it	403
calcedonio.scarponi@libero.it	2356
calcedonio.scarponi@libero.it	94
calcedonio.scarponi@libero.it	2124
calcedonio.scarponi@libero.it	2657
calcedonio.scarponi@libero.it	1637
calcedonio.scarponi@libero.it	420
calcedonio.scarponi@libero.it	1729
calcedonio.scarponi@libero.it	769
calcedonio.scarponi@libero.it	885
calcedonio.scarponi@libero.it	2263
calcedonio.scarponi@libero.it	1677
calcedonio.scarponi@libero.it	1140
calcedonio.scarponi@libero.it	2538
calcedonio.scarponi@libero.it	1860
calcedonio.scarponi@libero.it	2449
calcedonio.scarponi@libero.it	2059
calcedonio.scarponi@libero.it	1598
calcedonio.scarponi@libero.it	1537
calcedonio.scarponi@libero.it	2797
calcedonio.scarponi@libero.it	2806
calcedonio.scarponi@libero.it	1650
calcedonio.scarponi@libero.it	2497
calcedonio.scarponi@libero.it	1630
calcedonio.scarponi@libero.it	917
calcedonio.scarponi@libero.it	993
calcedonio.scarponi@libero.it	177
calcedonio.scarponi@libero.it	1944
calcedonio.scarponi@libero.it	2013
calcedonio.scarponi@libero.it	617
calcedonio.scarponi@libero.it	1881
calcedonio.scarponi@libero.it	45
cristina.tedesco@yahoo.it	2040
cristina.tedesco@yahoo.it	1146
cristina.tedesco@yahoo.it	262
cristina.tedesco@yahoo.it	1703
cristina.tedesco@yahoo.it	2275
cristina.tedesco@yahoo.it	10
cristina.tedesco@yahoo.it	1190
cristina.tedesco@yahoo.it	2364
cristina.tedesco@yahoo.it	1421
cristina.tedesco@yahoo.it	694
cristina.tedesco@yahoo.it	651
cristina.tedesco@yahoo.it	1847
cristina.tedesco@yahoo.it	940
cristina.tedesco@yahoo.it	1947
cristina.tedesco@yahoo.it	950
cristina.tedesco@yahoo.it	1241
cristina.tedesco@yahoo.it	2272
cristina.tedesco@yahoo.it	1044
cristina.tedesco@yahoo.it	2717
cristina.tedesco@yahoo.it	2060
cristina.tedesco@yahoo.it	2046
cristina.tedesco@yahoo.it	2773
cristina.tedesco@yahoo.it	1729
cristina.tedesco@yahoo.it	2634
cristina.tedesco@yahoo.it	174
cristina.tedesco@yahoo.it	461
cristina.tedesco@yahoo.it	2793
cristina.tedesco@yahoo.it	1867
cristina.tedesco@yahoo.it	1719
cristina.tedesco@yahoo.it	1752
cristina.tedesco@yahoo.it	1274
cristina.tedesco@yahoo.it	1283
cristina.tedesco@yahoo.it	1199
cristina.tedesco@yahoo.it	52
cristina.tedesco@yahoo.it	345
cristina.tedesco@yahoo.it	1091
cristina.tedesco@yahoo.it	2240
cristina.tedesco@yahoo.it	1188
cristina.tedesco@yahoo.it	2626
cristina.tedesco@yahoo.it	1925
cristina.tedesco@yahoo.it	949
cristina.tedesco@yahoo.it	309
cristina.tedesco@yahoo.it	2020
cristina.tedesco@yahoo.it	1692
cristina.tedesco@yahoo.it	533
cristina.tedesco@yahoo.it	1052
cristina.tedesco@yahoo.it	295
cristina.tedesco@yahoo.it	1619
cristina.tedesco@yahoo.it	335
cristina.tedesco@yahoo.it	1638
cristina.tedesco@yahoo.it	824
cristina.tedesco@yahoo.it	1145
cristina.tedesco@yahoo.it	12
cristina.tedesco@yahoo.it	1076
cristina.tedesco@yahoo.it	176
cristina.tedesco@yahoo.it	2431
cristina.tedesco@yahoo.it	1033
cristina.tedesco@yahoo.it	1177
cristina.tedesco@yahoo.it	919
cristina.tedesco@yahoo.it	2604
cristina.tedesco@yahoo.it	2276
cristina.tedesco@yahoo.it	423
cristina.tedesco@yahoo.it	713
cristina.tedesco@yahoo.it	2337
cristina.tedesco@yahoo.it	1878
cristina.tedesco@yahoo.it	2547
cristina.tedesco@yahoo.it	1466
cristina.tedesco@yahoo.it	1509
cristina.tedesco@yahoo.it	297
cristina.tedesco@yahoo.it	1871
cristina.tedesco@yahoo.it	1449
cristina.tedesco@yahoo.it	578
cristina.tedesco@yahoo.it	1700
cristina.tedesco@yahoo.it	1613
cristina.tedesco@yahoo.it	782
cristina.tedesco@yahoo.it	1278
cristina.tedesco@yahoo.it	1713
cristina.tedesco@yahoo.it	91
cristina.tedesco@yahoo.it	153
cristina.tedesco@yahoo.it	2511
cristina.tedesco@yahoo.it	2841
cristina.tedesco@yahoo.it	2289
cristina.tedesco@yahoo.it	815
cristina.tedesco@yahoo.it	848
cristina.tedesco@yahoo.it	1866
cristina.tedesco@yahoo.it	152
cristina.tedesco@yahoo.it	789
cristina.tedesco@yahoo.it	2513
cristina.tedesco@yahoo.it	1476
cristina.tedesco@yahoo.it	1030
cristina.tedesco@yahoo.it	933
cristina.tedesco@yahoo.it	1757
cristina.tedesco@yahoo.it	1931
cristina.tedesco@yahoo.it	1029
cristina.tedesco@yahoo.it	765
cristina.tedesco@yahoo.it	2710
cristina.tedesco@yahoo.it	445
cristina.tedesco@yahoo.it	2780
cristina.tedesco@yahoo.it	1312
cristina.tedesco@yahoo.it	2088
marina.bettoni@libero.it	164
marina.bettoni@libero.it	1740
marina.bettoni@libero.it	1038
marina.bettoni@libero.it	1546
marina.bettoni@libero.it	224
marina.bettoni@libero.it	2801
marina.bettoni@libero.it	2111
marina.bettoni@libero.it	2052
marina.bettoni@libero.it	702
marina.bettoni@libero.it	2061
marina.bettoni@libero.it	1425
marina.bettoni@libero.it	1639
marina.bettoni@libero.it	2670
marina.bettoni@libero.it	61
marina.bettoni@libero.it	908
marina.bettoni@libero.it	483
marina.bettoni@libero.it	347
marina.bettoni@libero.it	1451
marina.bettoni@libero.it	97
marina.bettoni@libero.it	1224
marina.bettoni@libero.it	1981
marina.bettoni@libero.it	1558
marina.bettoni@libero.it	887
marina.bettoni@libero.it	2417
marina.bettoni@libero.it	607
marina.bettoni@libero.it	2531
marina.bettoni@libero.it	2250
marina.bettoni@libero.it	575
marina.bettoni@libero.it	325
marina.bettoni@libero.it	1729
marina.bettoni@libero.it	2021
marina.bettoni@libero.it	1637
marina.bettoni@libero.it	961
marina.bettoni@libero.it	20
marina.bettoni@libero.it	596
marina.bettoni@libero.it	1752
marina.bettoni@libero.it	1884
marina.bettoni@libero.it	2477
marina.bettoni@libero.it	2554
marina.bettoni@libero.it	719
marina.bettoni@libero.it	1589
marina.bettoni@libero.it	613
marina.bettoni@libero.it	874
marina.bettoni@libero.it	1
marina.bettoni@libero.it	117
marina.bettoni@libero.it	2225
marina.bettoni@libero.it	2256
marina.bettoni@libero.it	2818
marina.bettoni@libero.it	2742
marina.bettoni@libero.it	501
marina.bettoni@libero.it	1593
marina.bettoni@libero.it	36
marina.bettoni@libero.it	2699
marina.bettoni@libero.it	1566
marina.bettoni@libero.it	1086
marina.bettoni@libero.it	606
marina.bettoni@libero.it	1894
marina.bettoni@libero.it	1499
marina.bettoni@libero.it	1573
marina.bettoni@libero.it	2745
marina.bettoni@libero.it	389
marina.bettoni@libero.it	157
marina.bettoni@libero.it	133
marina.bettoni@libero.it	650
marina.bettoni@libero.it	1994
marina.bettoni@libero.it	1265
marina.bettoni@libero.it	1003
marina.bettoni@libero.it	1287
marina.bettoni@libero.it	118
marina.bettoni@libero.it	2371
marina.bettoni@libero.it	100
marina.bettoni@libero.it	1379
marina.bettoni@libero.it	1016
marina.bettoni@libero.it	2780
marina.bettoni@libero.it	2201
marina.bettoni@libero.it	2529
marina.bettoni@libero.it	1484
marina.bettoni@libero.it	2291
marina.bettoni@libero.it	2501
marina.bettoni@libero.it	2353
marina.bettoni@libero.it	267
marina.bettoni@libero.it	629
marina.bettoni@libero.it	2843
marina.bettoni@libero.it	2354
marina.bettoni@libero.it	724
marina.bettoni@libero.it	1292
marina.bettoni@libero.it	2094
marina.bettoni@libero.it	2183
marina.bettoni@libero.it	1683
marina.bettoni@libero.it	283
marina.bettoni@libero.it	762
marina.bettoni@libero.it	1284
marina.bettoni@libero.it	2173
marina.bettoni@libero.it	1135
marina.bettoni@libero.it	441
marina.bettoni@libero.it	2521
marina.bettoni@libero.it	35
marina.bettoni@libero.it	1274
marina.bettoni@libero.it	542
marina.bettoni@libero.it	1902
diana.guicciardini@libero.it	379
diana.guicciardini@libero.it	1096
diana.guicciardini@libero.it	1605
diana.guicciardini@libero.it	1763
diana.guicciardini@libero.it	1166
diana.guicciardini@libero.it	498
diana.guicciardini@libero.it	1455
diana.guicciardini@libero.it	2680
diana.guicciardini@libero.it	402
diana.guicciardini@libero.it	400
diana.guicciardini@libero.it	2248
diana.guicciardini@libero.it	1133
diana.guicciardini@libero.it	2188
diana.guicciardini@libero.it	968
diana.guicciardini@libero.it	460
diana.guicciardini@libero.it	2423
diana.guicciardini@libero.it	2645
diana.guicciardini@libero.it	2600
diana.guicciardini@libero.it	105
diana.guicciardini@libero.it	1031
diana.guicciardini@libero.it	950
diana.guicciardini@libero.it	466
diana.guicciardini@libero.it	850
diana.guicciardini@libero.it	892
diana.guicciardini@libero.it	940
diana.guicciardini@libero.it	818
diana.guicciardini@libero.it	2133
diana.guicciardini@libero.it	2441
diana.guicciardini@libero.it	2656
diana.guicciardini@libero.it	543
diana.guicciardini@libero.it	638
diana.guicciardini@libero.it	2250
diana.guicciardini@libero.it	161
diana.guicciardini@libero.it	1258
diana.guicciardini@libero.it	226
diana.guicciardini@libero.it	79
diana.guicciardini@libero.it	1122
diana.guicciardini@libero.it	2135
diana.guicciardini@libero.it	623
diana.guicciardini@libero.it	791
diana.guicciardini@libero.it	723
diana.guicciardini@libero.it	2733
diana.guicciardini@libero.it	593
diana.guicciardini@libero.it	1558
diana.guicciardini@libero.it	330
diana.guicciardini@libero.it	1537
diana.guicciardini@libero.it	2650
diana.guicciardini@libero.it	820
diana.guicciardini@libero.it	2523
diana.guicciardini@libero.it	1254
diana.guicciardini@libero.it	604
diana.guicciardini@libero.it	1982
diana.guicciardini@libero.it	1317
diana.guicciardini@libero.it	2158
diana.guicciardini@libero.it	510
diana.guicciardini@libero.it	496
diana.guicciardini@libero.it	64
diana.guicciardini@libero.it	557
diana.guicciardini@libero.it	2665
diana.guicciardini@libero.it	259
diana.guicciardini@libero.it	2285
diana.guicciardini@libero.it	1911
diana.guicciardini@libero.it	29
diana.guicciardini@libero.it	484
diana.guicciardini@libero.it	2439
diana.guicciardini@libero.it	2726
diana.guicciardini@libero.it	1105
diana.guicciardini@libero.it	1641
diana.guicciardini@libero.it	2717
diana.guicciardini@libero.it	1981
diana.guicciardini@libero.it	2809
diana.guicciardini@libero.it	1823
diana.guicciardini@libero.it	2729
diana.guicciardini@libero.it	1659
diana.guicciardini@libero.it	2530
diana.guicciardini@libero.it	2195
diana.guicciardini@libero.it	2597
diana.guicciardini@libero.it	1603
diana.guicciardini@libero.it	1050
diana.guicciardini@libero.it	447
diana.guicciardini@libero.it	1580
diana.guicciardini@libero.it	1541
diana.guicciardini@libero.it	2743
diana.guicciardini@libero.it	2355
diana.guicciardini@libero.it	1091
diana.guicciardini@libero.it	2564
diana.guicciardini@libero.it	2735
diana.guicciardini@libero.it	1276
diana.guicciardini@libero.it	2821
diana.guicciardini@libero.it	1970
diana.guicciardini@libero.it	309
diana.guicciardini@libero.it	2070
diana.guicciardini@libero.it	173
diana.guicciardini@libero.it	2816
diana.guicciardini@libero.it	1437
diana.guicciardini@libero.it	876
diana.guicciardini@libero.it	2405
diana.guicciardini@libero.it	1700
diana.guicciardini@libero.it	2553
diana.guicciardini@libero.it	318
vincenza.turati@hotmail.com	2211
vincenza.turati@hotmail.com	799
vincenza.turati@hotmail.com	512
vincenza.turati@hotmail.com	2102
vincenza.turati@hotmail.com	265
vincenza.turati@hotmail.com	547
vincenza.turati@hotmail.com	1745
vincenza.turati@hotmail.com	2394
vincenza.turati@hotmail.com	1810
vincenza.turati@hotmail.com	462
vincenza.turati@hotmail.com	2584
vincenza.turati@hotmail.com	2106
vincenza.turati@hotmail.com	54
vincenza.turati@hotmail.com	680
vincenza.turati@hotmail.com	1894
vincenza.turati@hotmail.com	2319
vincenza.turati@hotmail.com	735
vincenza.turati@hotmail.com	1706
vincenza.turati@hotmail.com	963
vincenza.turati@hotmail.com	1826
vincenza.turati@hotmail.com	2445
vincenza.turati@hotmail.com	848
vincenza.turati@hotmail.com	703
vincenza.turati@hotmail.com	1210
vincenza.turati@hotmail.com	1827
vincenza.turati@hotmail.com	2471
vincenza.turati@hotmail.com	1117
vincenza.turati@hotmail.com	1303
vincenza.turati@hotmail.com	2764
vincenza.turati@hotmail.com	1888
vincenza.turati@hotmail.com	143
vincenza.turati@hotmail.com	1408
vincenza.turati@hotmail.com	58
vincenza.turati@hotmail.com	1290
vincenza.turati@hotmail.com	2353
vincenza.turati@hotmail.com	244
vincenza.turati@hotmail.com	800
vincenza.turati@hotmail.com	90
vincenza.turati@hotmail.com	919
vincenza.turati@hotmail.com	545
vincenza.turati@hotmail.com	845
vincenza.turati@hotmail.com	1556
vincenza.turati@hotmail.com	1926
vincenza.turati@hotmail.com	328
vincenza.turati@hotmail.com	568
vincenza.turati@hotmail.com	675
vincenza.turati@hotmail.com	1042
vincenza.turati@hotmail.com	175
vincenza.turati@hotmail.com	2420
vincenza.turati@hotmail.com	2439
vincenza.turati@hotmail.com	1198
vincenza.turati@hotmail.com	1558
vincenza.turati@hotmail.com	147
vincenza.turati@hotmail.com	2656
vincenza.turati@hotmail.com	931
vincenza.turati@hotmail.com	993
vincenza.turati@hotmail.com	661
vincenza.turati@hotmail.com	1907
vincenza.turati@hotmail.com	2813
vincenza.turati@hotmail.com	2266
vincenza.turati@hotmail.com	499
vincenza.turati@hotmail.com	1474
vincenza.turati@hotmail.com	1632
vincenza.turati@hotmail.com	2130
vincenza.turati@hotmail.com	1944
vincenza.turati@hotmail.com	1977
vincenza.turati@hotmail.com	2158
vincenza.turati@hotmail.com	486
vincenza.turati@hotmail.com	2306
vincenza.turati@hotmail.com	537
vincenza.turati@hotmail.com	950
vincenza.turati@hotmail.com	1162
vincenza.turati@hotmail.com	923
vincenza.turati@hotmail.com	653
vincenza.turati@hotmail.com	326
vincenza.turati@hotmail.com	1167
vincenza.turati@hotmail.com	2243
vincenza.turati@hotmail.com	903
vincenza.turati@hotmail.com	2335
vincenza.turati@hotmail.com	1245
vincenza.turati@hotmail.com	717
vincenza.turati@hotmail.com	304
vincenza.turati@hotmail.com	2503
vincenza.turati@hotmail.com	682
vincenza.turati@hotmail.com	2525
vincenza.turati@hotmail.com	1420
vincenza.turati@hotmail.com	2366
vincenza.turati@hotmail.com	1753
vincenza.turati@hotmail.com	1525
vincenza.turati@hotmail.com	2237
vincenza.turati@hotmail.com	2652
vincenza.turati@hotmail.com	72
vincenza.turati@hotmail.com	669
vincenza.turati@hotmail.com	1734
vincenza.turati@hotmail.com	2662
vincenza.turati@hotmail.com	1878
vincenza.turati@hotmail.com	81
vincenza.turati@hotmail.com	1997
vincenza.turati@hotmail.com	1070
vincenza.turati@hotmail.com	2307
tiziano.pederiva@hotmail.com	1711
tiziano.pederiva@hotmail.com	1631
tiziano.pederiva@hotmail.com	1851
tiziano.pederiva@hotmail.com	136
tiziano.pederiva@hotmail.com	1473
tiziano.pederiva@hotmail.com	1199
tiziano.pederiva@hotmail.com	1730
tiziano.pederiva@hotmail.com	836
tiziano.pederiva@hotmail.com	73
tiziano.pederiva@hotmail.com	932
tiziano.pederiva@hotmail.com	1423
tiziano.pederiva@hotmail.com	2531
tiziano.pederiva@hotmail.com	306
tiziano.pederiva@hotmail.com	1211
tiziano.pederiva@hotmail.com	958
tiziano.pederiva@hotmail.com	1722
tiziano.pederiva@hotmail.com	1032
tiziano.pederiva@hotmail.com	2780
tiziano.pederiva@hotmail.com	2633
tiziano.pederiva@hotmail.com	392
tiziano.pederiva@hotmail.com	2110
tiziano.pederiva@hotmail.com	1204
tiziano.pederiva@hotmail.com	2477
tiziano.pederiva@hotmail.com	2331
tiziano.pederiva@hotmail.com	1174
tiziano.pederiva@hotmail.com	1944
tiziano.pederiva@hotmail.com	79
tiziano.pederiva@hotmail.com	113
tiziano.pederiva@hotmail.com	51
tiziano.pederiva@hotmail.com	1727
tiziano.pederiva@hotmail.com	1771
tiziano.pederiva@hotmail.com	2445
tiziano.pederiva@hotmail.com	1378
tiziano.pederiva@hotmail.com	231
tiziano.pederiva@hotmail.com	977
tiziano.pederiva@hotmail.com	2309
tiziano.pederiva@hotmail.com	29
tiziano.pederiva@hotmail.com	31
tiziano.pederiva@hotmail.com	1458
tiziano.pederiva@hotmail.com	1887
tiziano.pederiva@hotmail.com	801
tiziano.pederiva@hotmail.com	1371
tiziano.pederiva@hotmail.com	623
tiziano.pederiva@hotmail.com	1916
tiziano.pederiva@hotmail.com	1607
tiziano.pederiva@hotmail.com	757
tiziano.pederiva@hotmail.com	2442
tiziano.pederiva@hotmail.com	552
tiziano.pederiva@hotmail.com	626
tiziano.pederiva@hotmail.com	2250
tiziano.pederiva@hotmail.com	2261
tiziano.pederiva@hotmail.com	193
tiziano.pederiva@hotmail.com	255
tiziano.pederiva@hotmail.com	2678
tiziano.pederiva@hotmail.com	2311
tiziano.pederiva@hotmail.com	2777
tiziano.pederiva@hotmail.com	2672
tiziano.pederiva@hotmail.com	1383
tiziano.pederiva@hotmail.com	2398
tiziano.pederiva@hotmail.com	737
tiziano.pederiva@hotmail.com	69
tiziano.pederiva@hotmail.com	1221
tiziano.pederiva@hotmail.com	928
tiziano.pederiva@hotmail.com	2470
tiziano.pederiva@hotmail.com	2720
tiziano.pederiva@hotmail.com	2795
tiziano.pederiva@hotmail.com	2490
tiziano.pederiva@hotmail.com	800
tiziano.pederiva@hotmail.com	794
tiziano.pederiva@hotmail.com	533
tiziano.pederiva@hotmail.com	2684
tiziano.pederiva@hotmail.com	130
tiziano.pederiva@hotmail.com	2350
tiziano.pederiva@hotmail.com	871
tiziano.pederiva@hotmail.com	1123
tiziano.pederiva@hotmail.com	857
tiziano.pederiva@hotmail.com	2469
tiziano.pederiva@hotmail.com	80
tiziano.pederiva@hotmail.com	1172
tiziano.pederiva@hotmail.com	545
tiziano.pederiva@hotmail.com	784
tiziano.pederiva@hotmail.com	2583
tiziano.pederiva@hotmail.com	534
tiziano.pederiva@hotmail.com	2086
tiziano.pederiva@hotmail.com	1868
tiziano.pederiva@hotmail.com	217
tiziano.pederiva@hotmail.com	2192
tiziano.pederiva@hotmail.com	2662
tiziano.pederiva@hotmail.com	2071
tiziano.pederiva@hotmail.com	524
tiziano.pederiva@hotmail.com	970
tiziano.pederiva@hotmail.com	383
tiziano.pederiva@hotmail.com	2076
tiziano.pederiva@hotmail.com	1567
tiziano.pederiva@hotmail.com	589
tiziano.pederiva@hotmail.com	862
tiziano.pederiva@hotmail.com	466
tiziano.pederiva@hotmail.com	37
tiziano.pederiva@hotmail.com	1748
tiziano.pederiva@hotmail.com	628
gianluca.carriera@hotmail.com	781
gianluca.carriera@hotmail.com	580
gianluca.carriera@hotmail.com	2517
gianluca.carriera@hotmail.com	1875
gianluca.carriera@hotmail.com	1773
gianluca.carriera@hotmail.com	2058
gianluca.carriera@hotmail.com	937
gianluca.carriera@hotmail.com	576
gianluca.carriera@hotmail.com	1737
gianluca.carriera@hotmail.com	1168
gianluca.carriera@hotmail.com	1721
gianluca.carriera@hotmail.com	1412
gianluca.carriera@hotmail.com	933
gianluca.carriera@hotmail.com	1105
gianluca.carriera@hotmail.com	2856
gianluca.carriera@hotmail.com	1
gianluca.carriera@hotmail.com	2021
gianluca.carriera@hotmail.com	2130
gianluca.carriera@hotmail.com	511
gianluca.carriera@hotmail.com	747
gianluca.carriera@hotmail.com	2175
gianluca.carriera@hotmail.com	6
gianluca.carriera@hotmail.com	263
gianluca.carriera@hotmail.com	712
gianluca.carriera@hotmail.com	2720
gianluca.carriera@hotmail.com	2258
gianluca.carriera@hotmail.com	1450
gianluca.carriera@hotmail.com	646
gianluca.carriera@hotmail.com	897
gianluca.carriera@hotmail.com	2202
gianluca.carriera@hotmail.com	245
gianluca.carriera@hotmail.com	2220
gianluca.carriera@hotmail.com	408
gianluca.carriera@hotmail.com	2183
gianluca.carriera@hotmail.com	959
gianluca.carriera@hotmail.com	406
gianluca.carriera@hotmail.com	727
gianluca.carriera@hotmail.com	1703
gianluca.carriera@hotmail.com	2656
gianluca.carriera@hotmail.com	1451
gianluca.carriera@hotmail.com	248
gianluca.carriera@hotmail.com	804
gianluca.carriera@hotmail.com	2361
gianluca.carriera@hotmail.com	916
gianluca.carriera@hotmail.com	2494
gianluca.carriera@hotmail.com	2111
gianluca.carriera@hotmail.com	900
gianluca.carriera@hotmail.com	479
gianluca.carriera@hotmail.com	1310
gianluca.carriera@hotmail.com	290
gianluca.carriera@hotmail.com	2315
gianluca.carriera@hotmail.com	506
gianluca.carriera@hotmail.com	1622
gianluca.carriera@hotmail.com	2470
gianluca.carriera@hotmail.com	2157
gianluca.carriera@hotmail.com	472
gianluca.carriera@hotmail.com	283
gianluca.carriera@hotmail.com	2022
gianluca.carriera@hotmail.com	543
gianluca.carriera@hotmail.com	2060
gianluca.carriera@hotmail.com	1488
gianluca.carriera@hotmail.com	2549
gianluca.carriera@hotmail.com	2316
gianluca.carriera@hotmail.com	2044
gianluca.carriera@hotmail.com	614
gianluca.carriera@hotmail.com	1455
gianluca.carriera@hotmail.com	1476
gianluca.carriera@hotmail.com	2135
gianluca.carriera@hotmail.com	143
gianluca.carriera@hotmail.com	607
gianluca.carriera@hotmail.com	681
gianluca.carriera@hotmail.com	2831
gianluca.carriera@hotmail.com	2040
gianluca.carriera@hotmail.com	453
gianluca.carriera@hotmail.com	2657
gianluca.carriera@hotmail.com	2457
gianluca.carriera@hotmail.com	315
gianluca.carriera@hotmail.com	2625
gianluca.carriera@hotmail.com	1970
gianluca.carriera@hotmail.com	820
gianluca.carriera@hotmail.com	2387
gianluca.carriera@hotmail.com	2489
gianluca.carriera@hotmail.com	2313
gianluca.carriera@hotmail.com	2610
gianluca.carriera@hotmail.com	1095
gianluca.carriera@hotmail.com	387
gianluca.carriera@hotmail.com	2751
gianluca.carriera@hotmail.com	44
gianluca.carriera@hotmail.com	843
gianluca.carriera@hotmail.com	2620
gianluca.carriera@hotmail.com	993
gianluca.carriera@hotmail.com	2736
gianluca.carriera@hotmail.com	144
gianluca.carriera@hotmail.com	1107
gianluca.carriera@hotmail.com	2819
gianluca.carriera@hotmail.com	1826
gianluca.carriera@hotmail.com	1689
gianluca.carriera@hotmail.com	1282
gianluca.carriera@hotmail.com	2388
gianluca.carriera@hotmail.com	1643
vito.petrocelli@hotmail.com	968
vito.petrocelli@hotmail.com	892
vito.petrocelli@hotmail.com	777
vito.petrocelli@hotmail.com	2460
vito.petrocelli@hotmail.com	1169
vito.petrocelli@hotmail.com	2655
vito.petrocelli@hotmail.com	1543
vito.petrocelli@hotmail.com	2784
vito.petrocelli@hotmail.com	2838
vito.petrocelli@hotmail.com	2561
vito.petrocelli@hotmail.com	2774
vito.petrocelli@hotmail.com	705
vito.petrocelli@hotmail.com	741
vito.petrocelli@hotmail.com	730
vito.petrocelli@hotmail.com	1125
vito.petrocelli@hotmail.com	506
vito.petrocelli@hotmail.com	655
vito.petrocelli@hotmail.com	2845
vito.petrocelli@hotmail.com	1225
vito.petrocelli@hotmail.com	1214
vito.petrocelli@hotmail.com	832
vito.petrocelli@hotmail.com	1258
vito.petrocelli@hotmail.com	432
vito.petrocelli@hotmail.com	884
vito.petrocelli@hotmail.com	2637
vito.petrocelli@hotmail.com	2813
vito.petrocelli@hotmail.com	136
vito.petrocelli@hotmail.com	2162
vito.petrocelli@hotmail.com	513
vito.petrocelli@hotmail.com	1202
vito.petrocelli@hotmail.com	1734
vito.petrocelli@hotmail.com	2395
vito.petrocelli@hotmail.com	1265
vito.petrocelli@hotmail.com	975
vito.petrocelli@hotmail.com	1528
vito.petrocelli@hotmail.com	1108
vito.petrocelli@hotmail.com	1802
vito.petrocelli@hotmail.com	544
vito.petrocelli@hotmail.com	2704
vito.petrocelli@hotmail.com	1670
vito.petrocelli@hotmail.com	2440
vito.petrocelli@hotmail.com	689
vito.petrocelli@hotmail.com	2335
vito.petrocelli@hotmail.com	1298
vito.petrocelli@hotmail.com	120
vito.petrocelli@hotmail.com	1578
vito.petrocelli@hotmail.com	1561
vito.petrocelli@hotmail.com	1814
vito.petrocelli@hotmail.com	1753
vito.petrocelli@hotmail.com	1159
vito.petrocelli@hotmail.com	919
vito.petrocelli@hotmail.com	547
vito.petrocelli@hotmail.com	654
vito.petrocelli@hotmail.com	908
vito.petrocelli@hotmail.com	953
vito.petrocelli@hotmail.com	668
vito.petrocelli@hotmail.com	1122
vito.petrocelli@hotmail.com	407
vito.petrocelli@hotmail.com	1986
vito.petrocelli@hotmail.com	1757
vito.petrocelli@hotmail.com	1098
vito.petrocelli@hotmail.com	616
vito.petrocelli@hotmail.com	1989
vito.petrocelli@hotmail.com	615
vito.petrocelli@hotmail.com	1785
vito.petrocelli@hotmail.com	2115
vito.petrocelli@hotmail.com	2238
vito.petrocelli@hotmail.com	441
vito.petrocelli@hotmail.com	1492
vito.petrocelli@hotmail.com	1911
vito.petrocelli@hotmail.com	373
vito.petrocelli@hotmail.com	238
vito.petrocelli@hotmail.com	1056
vito.petrocelli@hotmail.com	546
vito.petrocelli@hotmail.com	2714
vito.petrocelli@hotmail.com	814
vito.petrocelli@hotmail.com	1711
vito.petrocelli@hotmail.com	2509
vito.petrocelli@hotmail.com	881
vito.petrocelli@hotmail.com	2556
vito.petrocelli@hotmail.com	1941
vito.petrocelli@hotmail.com	2805
vito.petrocelli@hotmail.com	1465
vito.petrocelli@hotmail.com	2368
vito.petrocelli@hotmail.com	1949
vito.petrocelli@hotmail.com	666
vito.petrocelli@hotmail.com	753
vito.petrocelli@hotmail.com	89
vito.petrocelli@hotmail.com	244
vito.petrocelli@hotmail.com	1000
vito.petrocelli@hotmail.com	1999
vito.petrocelli@hotmail.com	779
vito.petrocelli@hotmail.com	1020
vito.petrocelli@hotmail.com	2178
vito.petrocelli@hotmail.com	1680
vito.petrocelli@hotmail.com	635
vito.petrocelli@hotmail.com	2379
vito.petrocelli@hotmail.com	2237
vito.petrocelli@hotmail.com	1458
vito.petrocelli@hotmail.com	636
michelangelo.antonetti@gmail.com	1710
michelangelo.antonetti@gmail.com	2672
michelangelo.antonetti@gmail.com	741
michelangelo.antonetti@gmail.com	2423
michelangelo.antonetti@gmail.com	2107
michelangelo.antonetti@gmail.com	506
michelangelo.antonetti@gmail.com	945
michelangelo.antonetti@gmail.com	362
michelangelo.antonetti@gmail.com	1038
michelangelo.antonetti@gmail.com	1042
michelangelo.antonetti@gmail.com	1049
michelangelo.antonetti@gmail.com	895
michelangelo.antonetti@gmail.com	2698
michelangelo.antonetti@gmail.com	1413
michelangelo.antonetti@gmail.com	488
michelangelo.antonetti@gmail.com	1834
michelangelo.antonetti@gmail.com	1414
michelangelo.antonetti@gmail.com	2534
michelangelo.antonetti@gmail.com	1480
michelangelo.antonetti@gmail.com	628
michelangelo.antonetti@gmail.com	2161
michelangelo.antonetti@gmail.com	1313
michelangelo.antonetti@gmail.com	238
michelangelo.antonetti@gmail.com	75
michelangelo.antonetti@gmail.com	2001
michelangelo.antonetti@gmail.com	710
michelangelo.antonetti@gmail.com	227
michelangelo.antonetti@gmail.com	2023
michelangelo.antonetti@gmail.com	521
michelangelo.antonetti@gmail.com	2741
michelangelo.antonetti@gmail.com	1144
michelangelo.antonetti@gmail.com	2081
michelangelo.antonetti@gmail.com	2636
michelangelo.antonetti@gmail.com	1429
michelangelo.antonetti@gmail.com	1895
michelangelo.antonetti@gmail.com	470
michelangelo.antonetti@gmail.com	331
michelangelo.antonetti@gmail.com	244
michelangelo.antonetti@gmail.com	2829
michelangelo.antonetti@gmail.com	2239
michelangelo.antonetti@gmail.com	898
michelangelo.antonetti@gmail.com	1579
michelangelo.antonetti@gmail.com	1461
michelangelo.antonetti@gmail.com	2702
michelangelo.antonetti@gmail.com	253
michelangelo.antonetti@gmail.com	1897
michelangelo.antonetti@gmail.com	1839
michelangelo.antonetti@gmail.com	396
michelangelo.antonetti@gmail.com	278
michelangelo.antonetti@gmail.com	780
michelangelo.antonetti@gmail.com	1408
michelangelo.antonetti@gmail.com	1236
michelangelo.antonetti@gmail.com	2111
michelangelo.antonetti@gmail.com	976
michelangelo.antonetti@gmail.com	1120
michelangelo.antonetti@gmail.com	67
michelangelo.antonetti@gmail.com	525
michelangelo.antonetti@gmail.com	347
michelangelo.antonetti@gmail.com	2574
michelangelo.antonetti@gmail.com	1599
michelangelo.antonetti@gmail.com	1306
michelangelo.antonetti@gmail.com	190
michelangelo.antonetti@gmail.com	2469
michelangelo.antonetti@gmail.com	63
michelangelo.antonetti@gmail.com	2227
michelangelo.antonetti@gmail.com	2369
michelangelo.antonetti@gmail.com	2839
michelangelo.antonetti@gmail.com	256
michelangelo.antonetti@gmail.com	1815
michelangelo.antonetti@gmail.com	2508
michelangelo.antonetti@gmail.com	587
michelangelo.antonetti@gmail.com	1485
michelangelo.antonetti@gmail.com	2541
michelangelo.antonetti@gmail.com	2396
michelangelo.antonetti@gmail.com	2231
michelangelo.antonetti@gmail.com	2748
michelangelo.antonetti@gmail.com	1887
michelangelo.antonetti@gmail.com	1314
michelangelo.antonetti@gmail.com	518
michelangelo.antonetti@gmail.com	1959
michelangelo.antonetti@gmail.com	1586
michelangelo.antonetti@gmail.com	59
michelangelo.antonetti@gmail.com	1198
michelangelo.antonetti@gmail.com	1455
michelangelo.antonetti@gmail.com	1563
michelangelo.antonetti@gmail.com	2082
michelangelo.antonetti@gmail.com	2809
michelangelo.antonetti@gmail.com	1003
michelangelo.antonetti@gmail.com	886
michelangelo.antonetti@gmail.com	1540
michelangelo.antonetti@gmail.com	2370
michelangelo.antonetti@gmail.com	1570
michelangelo.antonetti@gmail.com	992
michelangelo.antonetti@gmail.com	782
michelangelo.antonetti@gmail.com	1915
michelangelo.antonetti@gmail.com	1013
michelangelo.antonetti@gmail.com	2038
michelangelo.antonetti@gmail.com	810
michelangelo.antonetti@gmail.com	956
michelangelo.antonetti@gmail.com	2141
silvio.cutuli@yahoo.it	2679
silvio.cutuli@yahoo.it	40
silvio.cutuli@yahoo.it	1285
silvio.cutuli@yahoo.it	2264
silvio.cutuli@yahoo.it	2644
silvio.cutuli@yahoo.it	949
silvio.cutuli@yahoo.it	1269
silvio.cutuli@yahoo.it	1798
silvio.cutuli@yahoo.it	1909
silvio.cutuli@yahoo.it	316
silvio.cutuli@yahoo.it	2723
silvio.cutuli@yahoo.it	268
silvio.cutuli@yahoo.it	2127
silvio.cutuli@yahoo.it	2425
silvio.cutuli@yahoo.it	2091
silvio.cutuli@yahoo.it	280
silvio.cutuli@yahoo.it	1034
silvio.cutuli@yahoo.it	1245
silvio.cutuli@yahoo.it	1484
silvio.cutuli@yahoo.it	1782
silvio.cutuli@yahoo.it	1752
silvio.cutuli@yahoo.it	1125
silvio.cutuli@yahoo.it	2754
silvio.cutuli@yahoo.it	570
silvio.cutuli@yahoo.it	2228
silvio.cutuli@yahoo.it	2364
silvio.cutuli@yahoo.it	2290
silvio.cutuli@yahoo.it	262
silvio.cutuli@yahoo.it	964
silvio.cutuli@yahoo.it	1450
silvio.cutuli@yahoo.it	1115
silvio.cutuli@yahoo.it	1920
silvio.cutuli@yahoo.it	1645
silvio.cutuli@yahoo.it	534
silvio.cutuli@yahoo.it	1714
silvio.cutuli@yahoo.it	1742
silvio.cutuli@yahoo.it	984
silvio.cutuli@yahoo.it	1940
silvio.cutuli@yahoo.it	552
silvio.cutuli@yahoo.it	2172
silvio.cutuli@yahoo.it	340
silvio.cutuli@yahoo.it	2156
silvio.cutuli@yahoo.it	458
silvio.cutuli@yahoo.it	1924
silvio.cutuli@yahoo.it	1181
silvio.cutuli@yahoo.it	1101
silvio.cutuli@yahoo.it	2796
silvio.cutuli@yahoo.it	1258
silvio.cutuli@yahoo.it	2366
silvio.cutuli@yahoo.it	271
silvio.cutuli@yahoo.it	494
silvio.cutuli@yahoo.it	2490
silvio.cutuli@yahoo.it	2563
silvio.cutuli@yahoo.it	2093
silvio.cutuli@yahoo.it	810
silvio.cutuli@yahoo.it	1588
silvio.cutuli@yahoo.it	605
silvio.cutuli@yahoo.it	2793
silvio.cutuli@yahoo.it	1311
silvio.cutuli@yahoo.it	537
silvio.cutuli@yahoo.it	543
silvio.cutuli@yahoo.it	2824
silvio.cutuli@yahoo.it	1533
silvio.cutuli@yahoo.it	282
silvio.cutuli@yahoo.it	2149
silvio.cutuli@yahoo.it	1861
silvio.cutuli@yahoo.it	2828
silvio.cutuli@yahoo.it	1541
silvio.cutuli@yahoo.it	1692
silvio.cutuli@yahoo.it	1423
silvio.cutuli@yahoo.it	737
silvio.cutuli@yahoo.it	1510
silvio.cutuli@yahoo.it	2594
silvio.cutuli@yahoo.it	2471
silvio.cutuli@yahoo.it	2122
silvio.cutuli@yahoo.it	2325
silvio.cutuli@yahoo.it	2685
silvio.cutuli@yahoo.it	1777
silvio.cutuli@yahoo.it	2617
silvio.cutuli@yahoo.it	2482
silvio.cutuli@yahoo.it	719
silvio.cutuli@yahoo.it	379
silvio.cutuli@yahoo.it	177
silvio.cutuli@yahoo.it	443
silvio.cutuli@yahoo.it	2330
silvio.cutuli@yahoo.it	406
silvio.cutuli@yahoo.it	220
silvio.cutuli@yahoo.it	1601
silvio.cutuli@yahoo.it	343
silvio.cutuli@yahoo.it	74
silvio.cutuli@yahoo.it	60
silvio.cutuli@yahoo.it	660
silvio.cutuli@yahoo.it	2008
silvio.cutuli@yahoo.it	1799
silvio.cutuli@yahoo.it	1553
silvio.cutuli@yahoo.it	401
silvio.cutuli@yahoo.it	1709
silvio.cutuli@yahoo.it	2226
silvio.cutuli@yahoo.it	1521
silvio.cutuli@yahoo.it	2473
michelotto.alfieri@hotmail.com	2329
michelotto.alfieri@hotmail.com	984
michelotto.alfieri@hotmail.com	1123
michelotto.alfieri@hotmail.com	942
michelotto.alfieri@hotmail.com	253
michelotto.alfieri@hotmail.com	1920
michelotto.alfieri@hotmail.com	2129
michelotto.alfieri@hotmail.com	607
michelotto.alfieri@hotmail.com	1076
michelotto.alfieri@hotmail.com	389
michelotto.alfieri@hotmail.com	961
michelotto.alfieri@hotmail.com	1141
michelotto.alfieri@hotmail.com	850
michelotto.alfieri@hotmail.com	867
michelotto.alfieri@hotmail.com	171
michelotto.alfieri@hotmail.com	383
michelotto.alfieri@hotmail.com	1485
michelotto.alfieri@hotmail.com	2569
michelotto.alfieri@hotmail.com	1872
michelotto.alfieri@hotmail.com	885
michelotto.alfieri@hotmail.com	820
michelotto.alfieri@hotmail.com	2828
michelotto.alfieri@hotmail.com	1679
michelotto.alfieri@hotmail.com	2319
michelotto.alfieri@hotmail.com	1456
michelotto.alfieri@hotmail.com	646
michelotto.alfieri@hotmail.com	2529
michelotto.alfieri@hotmail.com	812
michelotto.alfieri@hotmail.com	1182
michelotto.alfieri@hotmail.com	2056
michelotto.alfieri@hotmail.com	1569
michelotto.alfieri@hotmail.com	1513
michelotto.alfieri@hotmail.com	2570
michelotto.alfieri@hotmail.com	2796
michelotto.alfieri@hotmail.com	388
michelotto.alfieri@hotmail.com	1115
michelotto.alfieri@hotmail.com	2341
michelotto.alfieri@hotmail.com	1909
michelotto.alfieri@hotmail.com	134
michelotto.alfieri@hotmail.com	1053
michelotto.alfieri@hotmail.com	576
michelotto.alfieri@hotmail.com	595
michelotto.alfieri@hotmail.com	1444
michelotto.alfieri@hotmail.com	2156
michelotto.alfieri@hotmail.com	2217
michelotto.alfieri@hotmail.com	1797
michelotto.alfieri@hotmail.com	1068
michelotto.alfieri@hotmail.com	521
michelotto.alfieri@hotmail.com	1041
michelotto.alfieri@hotmail.com	1190
michelotto.alfieri@hotmail.com	936
michelotto.alfieri@hotmail.com	920
michelotto.alfieri@hotmail.com	1376
michelotto.alfieri@hotmail.com	1445
michelotto.alfieri@hotmail.com	1246
michelotto.alfieri@hotmail.com	671
michelotto.alfieri@hotmail.com	1740
michelotto.alfieri@hotmail.com	251
michelotto.alfieri@hotmail.com	2409
michelotto.alfieri@hotmail.com	933
michelotto.alfieri@hotmail.com	353
michelotto.alfieri@hotmail.com	2275
michelotto.alfieri@hotmail.com	62
michelotto.alfieri@hotmail.com	2398
michelotto.alfieri@hotmail.com	2223
michelotto.alfieri@hotmail.com	1878
michelotto.alfieri@hotmail.com	2391
michelotto.alfieri@hotmail.com	2857
michelotto.alfieri@hotmail.com	1095
michelotto.alfieri@hotmail.com	2163
michelotto.alfieri@hotmail.com	1454
michelotto.alfieri@hotmail.com	1975
michelotto.alfieri@hotmail.com	1231
michelotto.alfieri@hotmail.com	1243
michelotto.alfieri@hotmail.com	1991
michelotto.alfieri@hotmail.com	48
michelotto.alfieri@hotmail.com	2077
michelotto.alfieri@hotmail.com	443
michelotto.alfieri@hotmail.com	125
michelotto.alfieri@hotmail.com	306
michelotto.alfieri@hotmail.com	672
michelotto.alfieri@hotmail.com	2053
michelotto.alfieri@hotmail.com	1950
michelotto.alfieri@hotmail.com	176
michelotto.alfieri@hotmail.com	199
michelotto.alfieri@hotmail.com	591
michelotto.alfieri@hotmail.com	2421
michelotto.alfieri@hotmail.com	1160
michelotto.alfieri@hotmail.com	2144
michelotto.alfieri@hotmail.com	484
michelotto.alfieri@hotmail.com	241
michelotto.alfieri@hotmail.com	1529
michelotto.alfieri@hotmail.com	657
michelotto.alfieri@hotmail.com	6
michelotto.alfieri@hotmail.com	879
michelotto.alfieri@hotmail.com	2324
michelotto.alfieri@hotmail.com	2853
michelotto.alfieri@hotmail.com	2562
michelotto.alfieri@hotmail.com	2375
michelotto.alfieri@hotmail.com	520
eliana.accardo@virgilio.it	340
eliana.accardo@virgilio.it	2471
eliana.accardo@virgilio.it	2445
eliana.accardo@virgilio.it	2062
eliana.accardo@virgilio.it	829
eliana.accardo@virgilio.it	171
eliana.accardo@virgilio.it	1453
eliana.accardo@virgilio.it	605
eliana.accardo@virgilio.it	1057
eliana.accardo@virgilio.it	832
eliana.accardo@virgilio.it	2556
eliana.accardo@virgilio.it	1901
eliana.accardo@virgilio.it	1081
eliana.accardo@virgilio.it	38
eliana.accardo@virgilio.it	942
eliana.accardo@virgilio.it	723
eliana.accardo@virgilio.it	1313
eliana.accardo@virgilio.it	2342
eliana.accardo@virgilio.it	1582
eliana.accardo@virgilio.it	992
eliana.accardo@virgilio.it	1936
eliana.accardo@virgilio.it	909
eliana.accardo@virgilio.it	797
eliana.accardo@virgilio.it	409
eliana.accardo@virgilio.it	564
eliana.accardo@virgilio.it	1100
eliana.accardo@virgilio.it	2158
eliana.accardo@virgilio.it	1216
eliana.accardo@virgilio.it	2230
eliana.accardo@virgilio.it	2763
eliana.accardo@virgilio.it	2243
eliana.accardo@virgilio.it	2278
eliana.accardo@virgilio.it	246
eliana.accardo@virgilio.it	716
eliana.accardo@virgilio.it	2175
eliana.accardo@virgilio.it	1455
eliana.accardo@virgilio.it	2397
eliana.accardo@virgilio.it	266
eliana.accardo@virgilio.it	1664
eliana.accardo@virgilio.it	2211
eliana.accardo@virgilio.it	2324
eliana.accardo@virgilio.it	1784
eliana.accardo@virgilio.it	1844
eliana.accardo@virgilio.it	1644
eliana.accardo@virgilio.it	2517
eliana.accardo@virgilio.it	1891
eliana.accardo@virgilio.it	2819
eliana.accardo@virgilio.it	131
eliana.accardo@virgilio.it	1095
eliana.accardo@virgilio.it	779
eliana.accardo@virgilio.it	90
eliana.accardo@virgilio.it	619
eliana.accardo@virgilio.it	378
eliana.accardo@virgilio.it	220
eliana.accardo@virgilio.it	1669
eliana.accardo@virgilio.it	499
eliana.accardo@virgilio.it	2422
eliana.accardo@virgilio.it	2674
eliana.accardo@virgilio.it	1657
eliana.accardo@virgilio.it	1995
eliana.accardo@virgilio.it	1951
eliana.accardo@virgilio.it	2420
eliana.accardo@virgilio.it	742
eliana.accardo@virgilio.it	2154
eliana.accardo@virgilio.it	447
eliana.accardo@virgilio.it	1842
eliana.accardo@virgilio.it	2692
eliana.accardo@virgilio.it	115
eliana.accardo@virgilio.it	790
eliana.accardo@virgilio.it	1292
eliana.accardo@virgilio.it	1973
eliana.accardo@virgilio.it	2794
eliana.accardo@virgilio.it	711
eliana.accardo@virgilio.it	1189
eliana.accardo@virgilio.it	795
eliana.accardo@virgilio.it	1992
eliana.accardo@virgilio.it	64
eliana.accardo@virgilio.it	1788
eliana.accardo@virgilio.it	1647
eliana.accardo@virgilio.it	240
eliana.accardo@virgilio.it	478
eliana.accardo@virgilio.it	1884
eliana.accardo@virgilio.it	2622
eliana.accardo@virgilio.it	2496
eliana.accardo@virgilio.it	2429
eliana.accardo@virgilio.it	2498
eliana.accardo@virgilio.it	1645
eliana.accardo@virgilio.it	47
eliana.accardo@virgilio.it	1135
eliana.accardo@virgilio.it	2522
eliana.accardo@virgilio.it	233
eliana.accardo@virgilio.it	145
eliana.accardo@virgilio.it	2464
eliana.accardo@virgilio.it	2608
eliana.accardo@virgilio.it	827
eliana.accardo@virgilio.it	1206
eliana.accardo@virgilio.it	1752
eliana.accardo@virgilio.it	976
eliana.accardo@virgilio.it	2237
eliana.accardo@virgilio.it	1826
patrizia.cutrufo@virgilio.it	103
patrizia.cutrufo@virgilio.it	680
patrizia.cutrufo@virgilio.it	1697
patrizia.cutrufo@virgilio.it	288
patrizia.cutrufo@virgilio.it	1300
patrizia.cutrufo@virgilio.it	2372
patrizia.cutrufo@virgilio.it	687
patrizia.cutrufo@virgilio.it	1030
patrizia.cutrufo@virgilio.it	2323
patrizia.cutrufo@virgilio.it	1750
patrizia.cutrufo@virgilio.it	1847
patrizia.cutrufo@virgilio.it	1126
patrizia.cutrufo@virgilio.it	626
patrizia.cutrufo@virgilio.it	570
patrizia.cutrufo@virgilio.it	2598
patrizia.cutrufo@virgilio.it	2816
patrizia.cutrufo@virgilio.it	896
patrizia.cutrufo@virgilio.it	1833
patrizia.cutrufo@virgilio.it	671
patrizia.cutrufo@virgilio.it	2141
patrizia.cutrufo@virgilio.it	943
patrizia.cutrufo@virgilio.it	878
patrizia.cutrufo@virgilio.it	2084
patrizia.cutrufo@virgilio.it	70
patrizia.cutrufo@virgilio.it	1371
patrizia.cutrufo@virgilio.it	2394
patrizia.cutrufo@virgilio.it	2496
patrizia.cutrufo@virgilio.it	1127
patrizia.cutrufo@virgilio.it	610
patrizia.cutrufo@virgilio.it	25
patrizia.cutrufo@virgilio.it	784
patrizia.cutrufo@virgilio.it	2601
patrizia.cutrufo@virgilio.it	344
patrizia.cutrufo@virgilio.it	2519
patrizia.cutrufo@virgilio.it	903
patrizia.cutrufo@virgilio.it	2441
patrizia.cutrufo@virgilio.it	1481
patrizia.cutrufo@virgilio.it	1660
patrizia.cutrufo@virgilio.it	2563
patrizia.cutrufo@virgilio.it	265
patrizia.cutrufo@virgilio.it	1228
patrizia.cutrufo@virgilio.it	933
patrizia.cutrufo@virgilio.it	1813
patrizia.cutrufo@virgilio.it	504
patrizia.cutrufo@virgilio.it	294
patrizia.cutrufo@virgilio.it	175
patrizia.cutrufo@virgilio.it	821
patrizia.cutrufo@virgilio.it	2469
patrizia.cutrufo@virgilio.it	755
patrizia.cutrufo@virgilio.it	758
patrizia.cutrufo@virgilio.it	2852
patrizia.cutrufo@virgilio.it	13
patrizia.cutrufo@virgilio.it	2594
patrizia.cutrufo@virgilio.it	1050
patrizia.cutrufo@virgilio.it	970
patrizia.cutrufo@virgilio.it	813
patrizia.cutrufo@virgilio.it	468
patrizia.cutrufo@virgilio.it	2709
patrizia.cutrufo@virgilio.it	2426
patrizia.cutrufo@virgilio.it	1841
patrizia.cutrufo@virgilio.it	2331
patrizia.cutrufo@virgilio.it	443
patrizia.cutrufo@virgilio.it	2001
patrizia.cutrufo@virgilio.it	267
patrizia.cutrufo@virgilio.it	284
patrizia.cutrufo@virgilio.it	934
patrizia.cutrufo@virgilio.it	1059
patrizia.cutrufo@virgilio.it	1729
patrizia.cutrufo@virgilio.it	781
patrizia.cutrufo@virgilio.it	951
patrizia.cutrufo@virgilio.it	2095
patrizia.cutrufo@virgilio.it	1036
patrizia.cutrufo@virgilio.it	1661
patrizia.cutrufo@virgilio.it	2234
patrizia.cutrufo@virgilio.it	2261
patrizia.cutrufo@virgilio.it	1138
patrizia.cutrufo@virgilio.it	1850
patrizia.cutrufo@virgilio.it	1077
patrizia.cutrufo@virgilio.it	2617
patrizia.cutrufo@virgilio.it	1746
patrizia.cutrufo@virgilio.it	27
patrizia.cutrufo@virgilio.it	2168
patrizia.cutrufo@virgilio.it	1316
patrizia.cutrufo@virgilio.it	312
patrizia.cutrufo@virgilio.it	2115
patrizia.cutrufo@virgilio.it	2451
patrizia.cutrufo@virgilio.it	2070
patrizia.cutrufo@virgilio.it	2213
patrizia.cutrufo@virgilio.it	705
patrizia.cutrufo@virgilio.it	2535
patrizia.cutrufo@virgilio.it	879
patrizia.cutrufo@virgilio.it	977
patrizia.cutrufo@virgilio.it	1424
patrizia.cutrufo@virgilio.it	1162
patrizia.cutrufo@virgilio.it	675
patrizia.cutrufo@virgilio.it	2389
patrizia.cutrufo@virgilio.it	487
patrizia.cutrufo@virgilio.it	606
patrizia.cutrufo@virgilio.it	2275
patrizia.cutrufo@virgilio.it	1643
gioacchino.milanesi@libero.it	893
gioacchino.milanesi@libero.it	640
gioacchino.milanesi@libero.it	2660
gioacchino.milanesi@libero.it	541
gioacchino.milanesi@libero.it	934
gioacchino.milanesi@libero.it	2076
gioacchino.milanesi@libero.it	56
gioacchino.milanesi@libero.it	2469
gioacchino.milanesi@libero.it	2768
gioacchino.milanesi@libero.it	415
gioacchino.milanesi@libero.it	2600
gioacchino.milanesi@libero.it	1218
gioacchino.milanesi@libero.it	1086
gioacchino.milanesi@libero.it	1587
gioacchino.milanesi@libero.it	115
gioacchino.milanesi@libero.it	969
gioacchino.milanesi@libero.it	2182
gioacchino.milanesi@libero.it	168
gioacchino.milanesi@libero.it	1206
gioacchino.milanesi@libero.it	232
gioacchino.milanesi@libero.it	2465
gioacchino.milanesi@libero.it	284
gioacchino.milanesi@libero.it	157
gioacchino.milanesi@libero.it	1472
gioacchino.milanesi@libero.it	2552
gioacchino.milanesi@libero.it	1519
gioacchino.milanesi@libero.it	1847
gioacchino.milanesi@libero.it	323
gioacchino.milanesi@libero.it	2819
gioacchino.milanesi@libero.it	2792
gioacchino.milanesi@libero.it	1506
gioacchino.milanesi@libero.it	169
gioacchino.milanesi@libero.it	2130
gioacchino.milanesi@libero.it	2146
gioacchino.milanesi@libero.it	763
gioacchino.milanesi@libero.it	423
gioacchino.milanesi@libero.it	2039
gioacchino.milanesi@libero.it	672
gioacchino.milanesi@libero.it	2632
gioacchino.milanesi@libero.it	1736
gioacchino.milanesi@libero.it	1270
gioacchino.milanesi@libero.it	2846
gioacchino.milanesi@libero.it	357
gioacchino.milanesi@libero.it	2688
gioacchino.milanesi@libero.it	2263
gioacchino.milanesi@libero.it	908
gioacchino.milanesi@libero.it	2522
gioacchino.milanesi@libero.it	1764
gioacchino.milanesi@libero.it	2172
gioacchino.milanesi@libero.it	1902
gioacchino.milanesi@libero.it	911
gioacchino.milanesi@libero.it	1609
gioacchino.milanesi@libero.it	236
gioacchino.milanesi@libero.it	238
gioacchino.milanesi@libero.it	1488
gioacchino.milanesi@libero.it	2320
gioacchino.milanesi@libero.it	924
gioacchino.milanesi@libero.it	1002
gioacchino.milanesi@libero.it	2364
gioacchino.milanesi@libero.it	1585
gioacchino.milanesi@libero.it	2082
gioacchino.milanesi@libero.it	827
gioacchino.milanesi@libero.it	158
gioacchino.milanesi@libero.it	566
gioacchino.milanesi@libero.it	2405
gioacchino.milanesi@libero.it	863
gioacchino.milanesi@libero.it	1199
gioacchino.milanesi@libero.it	976
gioacchino.milanesi@libero.it	814
gioacchino.milanesi@libero.it	1114
gioacchino.milanesi@libero.it	263
gioacchino.milanesi@libero.it	2561
gioacchino.milanesi@libero.it	1879
gioacchino.milanesi@libero.it	1233
gioacchino.milanesi@libero.it	389
gioacchino.milanesi@libero.it	1190
gioacchino.milanesi@libero.it	2474
gioacchino.milanesi@libero.it	2330
gioacchino.milanesi@libero.it	1895
gioacchino.milanesi@libero.it	2066
gioacchino.milanesi@libero.it	2004
gioacchino.milanesi@libero.it	399
gioacchino.milanesi@libero.it	790
gioacchino.milanesi@libero.it	1961
gioacchino.milanesi@libero.it	1027
gioacchino.milanesi@libero.it	1431
gioacchino.milanesi@libero.it	102
gioacchino.milanesi@libero.it	2092
gioacchino.milanesi@libero.it	2010
gioacchino.milanesi@libero.it	2528
gioacchino.milanesi@libero.it	1200
gioacchino.milanesi@libero.it	1107
gioacchino.milanesi@libero.it	2804
gioacchino.milanesi@libero.it	850
gioacchino.milanesi@libero.it	1305
gioacchino.milanesi@libero.it	79
gioacchino.milanesi@libero.it	256
gioacchino.milanesi@libero.it	903
gioacchino.milanesi@libero.it	1996
gioacchino.milanesi@libero.it	279
alessio.giulietti@virgilio.it	1853
alessio.giulietti@virgilio.it	882
alessio.giulietti@virgilio.it	1179
alessio.giulietti@virgilio.it	2022
alessio.giulietti@virgilio.it	38
alessio.giulietti@virgilio.it	393
alessio.giulietti@virgilio.it	2090
alessio.giulietti@virgilio.it	1455
alessio.giulietti@virgilio.it	991
alessio.giulietti@virgilio.it	849
alessio.giulietti@virgilio.it	2262
alessio.giulietti@virgilio.it	1449
alessio.giulietti@virgilio.it	2005
alessio.giulietti@virgilio.it	2156
alessio.giulietti@virgilio.it	1463
alessio.giulietti@virgilio.it	1993
alessio.giulietti@virgilio.it	1976
alessio.giulietti@virgilio.it	1769
alessio.giulietti@virgilio.it	1052
alessio.giulietti@virgilio.it	2635
alessio.giulietti@virgilio.it	820
alessio.giulietti@virgilio.it	1201
alessio.giulietti@virgilio.it	1947
alessio.giulietti@virgilio.it	1887
alessio.giulietti@virgilio.it	414
alessio.giulietti@virgilio.it	2432
alessio.giulietti@virgilio.it	2226
alessio.giulietti@virgilio.it	884
alessio.giulietti@virgilio.it	5
alessio.giulietti@virgilio.it	1016
alessio.giulietti@virgilio.it	1873
alessio.giulietti@virgilio.it	791
alessio.giulietti@virgilio.it	654
alessio.giulietti@virgilio.it	2695
alessio.giulietti@virgilio.it	2294
alessio.giulietti@virgilio.it	1868
alessio.giulietti@virgilio.it	2741
alessio.giulietti@virgilio.it	1454
alessio.giulietti@virgilio.it	1015
alessio.giulietti@virgilio.it	360
alessio.giulietti@virgilio.it	1838
alessio.giulietti@virgilio.it	1502
alessio.giulietti@virgilio.it	1420
alessio.giulietti@virgilio.it	630
alessio.giulietti@virgilio.it	1188
alessio.giulietti@virgilio.it	2601
alessio.giulietti@virgilio.it	1549
alessio.giulietti@virgilio.it	755
alessio.giulietti@virgilio.it	2497
alessio.giulietti@virgilio.it	2627
alessio.giulietti@virgilio.it	1287
alessio.giulietti@virgilio.it	118
alessio.giulietti@virgilio.it	2133
alessio.giulietti@virgilio.it	1282
alessio.giulietti@virgilio.it	642
alessio.giulietti@virgilio.it	1659
alessio.giulietti@virgilio.it	830
alessio.giulietti@virgilio.it	2536
alessio.giulietti@virgilio.it	574
alessio.giulietti@virgilio.it	516
alessio.giulietti@virgilio.it	2803
alessio.giulietti@virgilio.it	1862
alessio.giulietti@virgilio.it	1685
alessio.giulietti@virgilio.it	1592
alessio.giulietti@virgilio.it	810
alessio.giulietti@virgilio.it	185
alessio.giulietti@virgilio.it	1810
alessio.giulietti@virgilio.it	721
alessio.giulietti@virgilio.it	1477
alessio.giulietti@virgilio.it	2479
alessio.giulietti@virgilio.it	2612
alessio.giulietti@virgilio.it	69
alessio.giulietti@virgilio.it	1478
alessio.giulietti@virgilio.it	2858
alessio.giulietti@virgilio.it	942
alessio.giulietti@virgilio.it	101
alessio.giulietti@virgilio.it	1790
alessio.giulietti@virgilio.it	2581
alessio.giulietti@virgilio.it	1831
alessio.giulietti@virgilio.it	122
alessio.giulietti@virgilio.it	577
alessio.giulietti@virgilio.it	1184
alessio.giulietti@virgilio.it	1275
alessio.giulietti@virgilio.it	2372
alessio.giulietti@virgilio.it	291
alessio.giulietti@virgilio.it	129
alessio.giulietti@virgilio.it	192
alessio.giulietti@virgilio.it	756
alessio.giulietti@virgilio.it	2749
alessio.giulietti@virgilio.it	2528
alessio.giulietti@virgilio.it	1968
alessio.giulietti@virgilio.it	2311
alessio.giulietti@virgilio.it	2274
alessio.giulietti@virgilio.it	2717
alessio.giulietti@virgilio.it	2653
alessio.giulietti@virgilio.it	2750
alessio.giulietti@virgilio.it	1220
alessio.giulietti@virgilio.it	2427
alessio.giulietti@virgilio.it	2212
alessio.giulietti@virgilio.it	264
nicoletta.gabbana@gmail.com	309
nicoletta.gabbana@gmail.com	419
nicoletta.gabbana@gmail.com	1220
nicoletta.gabbana@gmail.com	2458
nicoletta.gabbana@gmail.com	1567
nicoletta.gabbana@gmail.com	1749
nicoletta.gabbana@gmail.com	1378
nicoletta.gabbana@gmail.com	243
nicoletta.gabbana@gmail.com	2613
nicoletta.gabbana@gmail.com	494
nicoletta.gabbana@gmail.com	2007
nicoletta.gabbana@gmail.com	1664
nicoletta.gabbana@gmail.com	967
nicoletta.gabbana@gmail.com	449
nicoletta.gabbana@gmail.com	1594
nicoletta.gabbana@gmail.com	76
nicoletta.gabbana@gmail.com	1862
nicoletta.gabbana@gmail.com	948
nicoletta.gabbana@gmail.com	622
nicoletta.gabbana@gmail.com	2753
nicoletta.gabbana@gmail.com	1720
nicoletta.gabbana@gmail.com	1689
nicoletta.gabbana@gmail.com	780
nicoletta.gabbana@gmail.com	2704
nicoletta.gabbana@gmail.com	2318
nicoletta.gabbana@gmail.com	2541
nicoletta.gabbana@gmail.com	2029
nicoletta.gabbana@gmail.com	756
nicoletta.gabbana@gmail.com	2448
nicoletta.gabbana@gmail.com	1965
nicoletta.gabbana@gmail.com	1477
nicoletta.gabbana@gmail.com	1119
nicoletta.gabbana@gmail.com	839
nicoletta.gabbana@gmail.com	47
nicoletta.gabbana@gmail.com	1911
nicoletta.gabbana@gmail.com	755
nicoletta.gabbana@gmail.com	1431
nicoletta.gabbana@gmail.com	1665
nicoletta.gabbana@gmail.com	1142
nicoletta.gabbana@gmail.com	1837
nicoletta.gabbana@gmail.com	302
nicoletta.gabbana@gmail.com	2261
nicoletta.gabbana@gmail.com	703
nicoletta.gabbana@gmail.com	984
nicoletta.gabbana@gmail.com	879
nicoletta.gabbana@gmail.com	1371
nicoletta.gabbana@gmail.com	71
nicoletta.gabbana@gmail.com	1270
nicoletta.gabbana@gmail.com	993
nicoletta.gabbana@gmail.com	1666
nicoletta.gabbana@gmail.com	1167
nicoletta.gabbana@gmail.com	2592
nicoletta.gabbana@gmail.com	1026
nicoletta.gabbana@gmail.com	2082
nicoletta.gabbana@gmail.com	573
nicoletta.gabbana@gmail.com	241
nicoletta.gabbana@gmail.com	368
nicoletta.gabbana@gmail.com	2231
nicoletta.gabbana@gmail.com	2229
nicoletta.gabbana@gmail.com	1673
nicoletta.gabbana@gmail.com	1463
nicoletta.gabbana@gmail.com	740
nicoletta.gabbana@gmail.com	815
nicoletta.gabbana@gmail.com	103
nicoletta.gabbana@gmail.com	846
nicoletta.gabbana@gmail.com	2027
nicoletta.gabbana@gmail.com	533
nicoletta.gabbana@gmail.com	2714
nicoletta.gabbana@gmail.com	1496
nicoletta.gabbana@gmail.com	683
nicoletta.gabbana@gmail.com	768
nicoletta.gabbana@gmail.com	219
nicoletta.gabbana@gmail.com	598
nicoletta.gabbana@gmail.com	2859
nicoletta.gabbana@gmail.com	1213
nicoletta.gabbana@gmail.com	2079
nicoletta.gabbana@gmail.com	1857
nicoletta.gabbana@gmail.com	2263
nicoletta.gabbana@gmail.com	1795
nicoletta.gabbana@gmail.com	1916
nicoletta.gabbana@gmail.com	2651
nicoletta.gabbana@gmail.com	1708
nicoletta.gabbana@gmail.com	965
nicoletta.gabbana@gmail.com	712
nicoletta.gabbana@gmail.com	2227
nicoletta.gabbana@gmail.com	653
nicoletta.gabbana@gmail.com	1684
nicoletta.gabbana@gmail.com	1714
nicoletta.gabbana@gmail.com	1113
nicoletta.gabbana@gmail.com	361
nicoletta.gabbana@gmail.com	1265
nicoletta.gabbana@gmail.com	2394
nicoletta.gabbana@gmail.com	1743
nicoletta.gabbana@gmail.com	501
nicoletta.gabbana@gmail.com	80
nicoletta.gabbana@gmail.com	692
nicoletta.gabbana@gmail.com	969
nicoletta.gabbana@gmail.com	521
nicoletta.gabbana@gmail.com	1454
nicoletta.gabbana@gmail.com	1317
ninetta.spanevello@yahoo.it	2302
ninetta.spanevello@yahoo.it	322
ninetta.spanevello@yahoo.it	248
ninetta.spanevello@yahoo.it	41
ninetta.spanevello@yahoo.it	1880
ninetta.spanevello@yahoo.it	1189
ninetta.spanevello@yahoo.it	1426
ninetta.spanevello@yahoo.it	2410
ninetta.spanevello@yahoo.it	1421
ninetta.spanevello@yahoo.it	1792
ninetta.spanevello@yahoo.it	1551
ninetta.spanevello@yahoo.it	1851
ninetta.spanevello@yahoo.it	1582
ninetta.spanevello@yahoo.it	1740
ninetta.spanevello@yahoo.it	716
ninetta.spanevello@yahoo.it	1069
ninetta.spanevello@yahoo.it	1889
ninetta.spanevello@yahoo.it	1187
ninetta.spanevello@yahoo.it	2115
ninetta.spanevello@yahoo.it	2163
ninetta.spanevello@yahoo.it	45
ninetta.spanevello@yahoo.it	770
ninetta.spanevello@yahoo.it	312
ninetta.spanevello@yahoo.it	1468
ninetta.spanevello@yahoo.it	1423
ninetta.spanevello@yahoo.it	2681
ninetta.spanevello@yahoo.it	2278
ninetta.spanevello@yahoo.it	1635
ninetta.spanevello@yahoo.it	512
ninetta.spanevello@yahoo.it	2612
ninetta.spanevello@yahoo.it	1821
ninetta.spanevello@yahoo.it	644
ninetta.spanevello@yahoo.it	1530
ninetta.spanevello@yahoo.it	1683
ninetta.spanevello@yahoo.it	1722
ninetta.spanevello@yahoo.it	2821
ninetta.spanevello@yahoo.it	1832
ninetta.spanevello@yahoo.it	704
ninetta.spanevello@yahoo.it	2651
ninetta.spanevello@yahoo.it	2258
ninetta.spanevello@yahoo.it	2662
ninetta.spanevello@yahoo.it	2716
ninetta.spanevello@yahoo.it	1288
ninetta.spanevello@yahoo.it	56
ninetta.spanevello@yahoo.it	2852
ninetta.spanevello@yahoo.it	1565
ninetta.spanevello@yahoo.it	913
ninetta.spanevello@yahoo.it	802
ninetta.spanevello@yahoo.it	879
ninetta.spanevello@yahoo.it	184
ninetta.spanevello@yahoo.it	2052
ninetta.spanevello@yahoo.it	2723
ninetta.spanevello@yahoo.it	221
ninetta.spanevello@yahoo.it	766
ninetta.spanevello@yahoo.it	2517
ninetta.spanevello@yahoo.it	1133
ninetta.spanevello@yahoo.it	2482
ninetta.spanevello@yahoo.it	350
ninetta.spanevello@yahoo.it	768
ninetta.spanevello@yahoo.it	372
ninetta.spanevello@yahoo.it	1268
ninetta.spanevello@yahoo.it	868
ninetta.spanevello@yahoo.it	817
ninetta.spanevello@yahoo.it	2076
ninetta.spanevello@yahoo.it	458
ninetta.spanevello@yahoo.it	1447
ninetta.spanevello@yahoo.it	220
ninetta.spanevello@yahoo.it	2722
ninetta.spanevello@yahoo.it	2088
ninetta.spanevello@yahoo.it	890
ninetta.spanevello@yahoo.it	1977
ninetta.spanevello@yahoo.it	2196
ninetta.spanevello@yahoo.it	2619
ninetta.spanevello@yahoo.it	945
ninetta.spanevello@yahoo.it	2313
ninetta.spanevello@yahoo.it	43
ninetta.spanevello@yahoo.it	2018
ninetta.spanevello@yahoo.it	2393
ninetta.spanevello@yahoo.it	2591
ninetta.spanevello@yahoo.it	2794
ninetta.spanevello@yahoo.it	1049
ninetta.spanevello@yahoo.it	1594
ninetta.spanevello@yahoo.it	1690
ninetta.spanevello@yahoo.it	1222
ninetta.spanevello@yahoo.it	2527
ninetta.spanevello@yahoo.it	2433
ninetta.spanevello@yahoo.it	366
ninetta.spanevello@yahoo.it	557
ninetta.spanevello@yahoo.it	1072
ninetta.spanevello@yahoo.it	2215
ninetta.spanevello@yahoo.it	279
ninetta.spanevello@yahoo.it	52
ninetta.spanevello@yahoo.it	1057
ninetta.spanevello@yahoo.it	2849
ninetta.spanevello@yahoo.it	143
ninetta.spanevello@yahoo.it	1219
ninetta.spanevello@yahoo.it	178
ninetta.spanevello@yahoo.it	2066
ninetta.spanevello@yahoo.it	2029
ninetta.spanevello@yahoo.it	874
massimo.sermonti@libero.it	1105
massimo.sermonti@libero.it	1085
massimo.sermonti@libero.it	876
massimo.sermonti@libero.it	1456
massimo.sermonti@libero.it	231
massimo.sermonti@libero.it	1473
massimo.sermonti@libero.it	2411
massimo.sermonti@libero.it	2833
massimo.sermonti@libero.it	1182
massimo.sermonti@libero.it	425
massimo.sermonti@libero.it	2113
massimo.sermonti@libero.it	906
massimo.sermonti@libero.it	1746
massimo.sermonti@libero.it	1016
massimo.sermonti@libero.it	2472
massimo.sermonti@libero.it	1463
massimo.sermonti@libero.it	1892
massimo.sermonti@libero.it	1686
massimo.sermonti@libero.it	1543
massimo.sermonti@libero.it	424
massimo.sermonti@libero.it	803
massimo.sermonti@libero.it	185
massimo.sermonti@libero.it	2646
massimo.sermonti@libero.it	1642
massimo.sermonti@libero.it	367
massimo.sermonti@libero.it	1678
massimo.sermonti@libero.it	2702
massimo.sermonti@libero.it	413
massimo.sermonti@libero.it	2774
massimo.sermonti@libero.it	1740
massimo.sermonti@libero.it	2174
massimo.sermonti@libero.it	2402
massimo.sermonti@libero.it	1596
massimo.sermonti@libero.it	2649
massimo.sermonti@libero.it	2423
massimo.sermonti@libero.it	2480
massimo.sermonti@libero.it	1438
massimo.sermonti@libero.it	2544
massimo.sermonti@libero.it	1587
massimo.sermonti@libero.it	1756
massimo.sermonti@libero.it	1170
massimo.sermonti@libero.it	220
massimo.sermonti@libero.it	422
massimo.sermonti@libero.it	183
massimo.sermonti@libero.it	2615
massimo.sermonti@libero.it	2290
massimo.sermonti@libero.it	107
massimo.sermonti@libero.it	86
massimo.sermonti@libero.it	2522
massimo.sermonti@libero.it	2510
massimo.sermonti@libero.it	704
massimo.sermonti@libero.it	2304
massimo.sermonti@libero.it	1900
massimo.sermonti@libero.it	1083
massimo.sermonti@libero.it	895
massimo.sermonti@libero.it	2627
massimo.sermonti@libero.it	2843
massimo.sermonti@libero.it	2463
massimo.sermonti@libero.it	1015
massimo.sermonti@libero.it	2721
massimo.sermonti@libero.it	2761
massimo.sermonti@libero.it	2689
massimo.sermonti@libero.it	689
massimo.sermonti@libero.it	548
massimo.sermonti@libero.it	458
massimo.sermonti@libero.it	2424
massimo.sermonti@libero.it	1138
massimo.sermonti@libero.it	2618
massimo.sermonti@libero.it	785
massimo.sermonti@libero.it	132
massimo.sermonti@libero.it	2681
massimo.sermonti@libero.it	2058
massimo.sermonti@libero.it	2013
massimo.sermonti@libero.it	1203
massimo.sermonti@libero.it	713
massimo.sermonti@libero.it	1648
massimo.sermonti@libero.it	1022
massimo.sermonti@libero.it	1029
massimo.sermonti@libero.it	36
massimo.sermonti@libero.it	198
massimo.sermonti@libero.it	2658
massimo.sermonti@libero.it	1636
massimo.sermonti@libero.it	397
massimo.sermonti@libero.it	727
massimo.sermonti@libero.it	740
massimo.sermonti@libero.it	1863
massimo.sermonti@libero.it	1985
massimo.sermonti@libero.it	466
massimo.sermonti@libero.it	1691
massimo.sermonti@libero.it	951
massimo.sermonti@libero.it	1966
massimo.sermonti@libero.it	1256
massimo.sermonti@libero.it	761
massimo.sermonti@libero.it	754
massimo.sermonti@libero.it	858
massimo.sermonti@libero.it	262
massimo.sermonti@libero.it	954
massimo.sermonti@libero.it	135
massimo.sermonti@libero.it	4
massimo.sermonti@libero.it	2133
angelina.trupiano@gmail.com	1895
angelina.trupiano@gmail.com	1872
angelina.trupiano@gmail.com	1189
angelina.trupiano@gmail.com	2722
angelina.trupiano@gmail.com	227
angelina.trupiano@gmail.com	1931
angelina.trupiano@gmail.com	40
angelina.trupiano@gmail.com	1616
angelina.trupiano@gmail.com	154
angelina.trupiano@gmail.com	1062
angelina.trupiano@gmail.com	2458
angelina.trupiano@gmail.com	2660
angelina.trupiano@gmail.com	393
angelina.trupiano@gmail.com	950
angelina.trupiano@gmail.com	1567
angelina.trupiano@gmail.com	2018
angelina.trupiano@gmail.com	1251
angelina.trupiano@gmail.com	1512
angelina.trupiano@gmail.com	2104
angelina.trupiano@gmail.com	49
angelina.trupiano@gmail.com	878
angelina.trupiano@gmail.com	2579
angelina.trupiano@gmail.com	144
angelina.trupiano@gmail.com	273
angelina.trupiano@gmail.com	320
angelina.trupiano@gmail.com	2834
angelina.trupiano@gmail.com	504
angelina.trupiano@gmail.com	1854
angelina.trupiano@gmail.com	1446
angelina.trupiano@gmail.com	55
angelina.trupiano@gmail.com	165
angelina.trupiano@gmail.com	886
angelina.trupiano@gmail.com	2658
angelina.trupiano@gmail.com	2495
angelina.trupiano@gmail.com	309
angelina.trupiano@gmail.com	2697
angelina.trupiano@gmail.com	405
angelina.trupiano@gmail.com	279
angelina.trupiano@gmail.com	84
angelina.trupiano@gmail.com	458
angelina.trupiano@gmail.com	510
angelina.trupiano@gmail.com	2838
angelina.trupiano@gmail.com	246
angelina.trupiano@gmail.com	1536
angelina.trupiano@gmail.com	2770
angelina.trupiano@gmail.com	586
angelina.trupiano@gmail.com	1941
angelina.trupiano@gmail.com	13
angelina.trupiano@gmail.com	2763
angelina.trupiano@gmail.com	2021
angelina.trupiano@gmail.com	159
angelina.trupiano@gmail.com	1094
angelina.trupiano@gmail.com	1300
angelina.trupiano@gmail.com	342
angelina.trupiano@gmail.com	146
angelina.trupiano@gmail.com	1407
angelina.trupiano@gmail.com	1707
angelina.trupiano@gmail.com	2721
angelina.trupiano@gmail.com	1681
angelina.trupiano@gmail.com	894
angelina.trupiano@gmail.com	758
angelina.trupiano@gmail.com	141
angelina.trupiano@gmail.com	433
angelina.trupiano@gmail.com	2619
angelina.trupiano@gmail.com	298
angelina.trupiano@gmail.com	2048
angelina.trupiano@gmail.com	1712
angelina.trupiano@gmail.com	236
angelina.trupiano@gmail.com	1229
angelina.trupiano@gmail.com	1290
angelina.trupiano@gmail.com	1259
angelina.trupiano@gmail.com	967
angelina.trupiano@gmail.com	2605
angelina.trupiano@gmail.com	1411
angelina.trupiano@gmail.com	869
angelina.trupiano@gmail.com	263
angelina.trupiano@gmail.com	2665
angelina.trupiano@gmail.com	626
angelina.trupiano@gmail.com	1269
angelina.trupiano@gmail.com	860
angelina.trupiano@gmail.com	2367
angelina.trupiano@gmail.com	1023
angelina.trupiano@gmail.com	198
angelina.trupiano@gmail.com	514
angelina.trupiano@gmail.com	1442
angelina.trupiano@gmail.com	1097
angelina.trupiano@gmail.com	1677
angelina.trupiano@gmail.com	106
angelina.trupiano@gmail.com	58
angelina.trupiano@gmail.com	2059
angelina.trupiano@gmail.com	389
angelina.trupiano@gmail.com	2504
angelina.trupiano@gmail.com	260
angelina.trupiano@gmail.com	2250
angelina.trupiano@gmail.com	646
angelina.trupiano@gmail.com	1792
angelina.trupiano@gmail.com	2421
angelina.trupiano@gmail.com	47
angelina.trupiano@gmail.com	1742
angelina.trupiano@gmail.com	125
donatello.varano@yahoo.it	455
donatello.varano@yahoo.it	2751
donatello.varano@yahoo.it	232
donatello.varano@yahoo.it	2357
donatello.varano@yahoo.it	828
donatello.varano@yahoo.it	1446
donatello.varano@yahoo.it	714
donatello.varano@yahoo.it	2477
donatello.varano@yahoo.it	1519
donatello.varano@yahoo.it	1108
donatello.varano@yahoo.it	540
donatello.varano@yahoo.it	1889
donatello.varano@yahoo.it	2792
donatello.varano@yahoo.it	1605
donatello.varano@yahoo.it	2525
donatello.varano@yahoo.it	1748
donatello.varano@yahoo.it	503
donatello.varano@yahoo.it	60
donatello.varano@yahoo.it	1602
donatello.varano@yahoo.it	673
donatello.varano@yahoo.it	2385
donatello.varano@yahoo.it	920
donatello.varano@yahoo.it	2371
donatello.varano@yahoo.it	672
donatello.varano@yahoo.it	1657
donatello.varano@yahoo.it	1463
donatello.varano@yahoo.it	666
donatello.varano@yahoo.it	2123
donatello.varano@yahoo.it	1236
donatello.varano@yahoo.it	913
donatello.varano@yahoo.it	2367
donatello.varano@yahoo.it	1708
donatello.varano@yahoo.it	378
donatello.varano@yahoo.it	1414
donatello.varano@yahoo.it	2539
donatello.varano@yahoo.it	1058
donatello.varano@yahoo.it	2173
donatello.varano@yahoo.it	697
donatello.varano@yahoo.it	2476
donatello.varano@yahoo.it	2607
donatello.varano@yahoo.it	1826
donatello.varano@yahoo.it	1567
donatello.varano@yahoo.it	2060
donatello.varano@yahoo.it	514
donatello.varano@yahoo.it	504
donatello.varano@yahoo.it	1981
donatello.varano@yahoo.it	807
donatello.varano@yahoo.it	605
donatello.varano@yahoo.it	50
donatello.varano@yahoo.it	2446
donatello.varano@yahoo.it	2463
donatello.varano@yahoo.it	1064
donatello.varano@yahoo.it	862
donatello.varano@yahoo.it	2567
donatello.varano@yahoo.it	2651
donatello.varano@yahoo.it	1569
donatello.varano@yahoo.it	801
donatello.varano@yahoo.it	2225
donatello.varano@yahoo.it	2054
donatello.varano@yahoo.it	2489
donatello.varano@yahoo.it	2480
donatello.varano@yahoo.it	1587
donatello.varano@yahoo.it	2193
donatello.varano@yahoo.it	2300
donatello.varano@yahoo.it	1
donatello.varano@yahoo.it	2298
donatello.varano@yahoo.it	679
donatello.varano@yahoo.it	1524
donatello.varano@yahoo.it	883
donatello.varano@yahoo.it	1256
donatello.varano@yahoo.it	1179
donatello.varano@yahoo.it	2498
donatello.varano@yahoo.it	1547
donatello.varano@yahoo.it	90
donatello.varano@yahoo.it	1939
donatello.varano@yahoo.it	773
donatello.varano@yahoo.it	469
donatello.varano@yahoo.it	1001
donatello.varano@yahoo.it	785
donatello.varano@yahoo.it	2280
donatello.varano@yahoo.it	171
donatello.varano@yahoo.it	589
donatello.varano@yahoo.it	154
donatello.varano@yahoo.it	1241
donatello.varano@yahoo.it	1214
donatello.varano@yahoo.it	1204
donatello.varano@yahoo.it	2111
donatello.varano@yahoo.it	2655
donatello.varano@yahoo.it	2441
donatello.varano@yahoo.it	2268
donatello.varano@yahoo.it	1780
donatello.varano@yahoo.it	2126
donatello.varano@yahoo.it	826
donatello.varano@yahoo.it	1933
donatello.varano@yahoo.it	1626
donatello.varano@yahoo.it	2561
donatello.varano@yahoo.it	111
donatello.varano@yahoo.it	1408
donatello.varano@yahoo.it	2051
donatello.varano@yahoo.it	823
elena.agazzi@libero.it	421
elena.agazzi@libero.it	756
elena.agazzi@libero.it	1237
elena.agazzi@libero.it	881
elena.agazzi@libero.it	992
elena.agazzi@libero.it	344
elena.agazzi@libero.it	259
elena.agazzi@libero.it	663
elena.agazzi@libero.it	2058
elena.agazzi@libero.it	241
elena.agazzi@libero.it	1208
elena.agazzi@libero.it	2770
elena.agazzi@libero.it	1911
elena.agazzi@libero.it	2429
elena.agazzi@libero.it	2022
elena.agazzi@libero.it	1304
elena.agazzi@libero.it	1878
elena.agazzi@libero.it	1950
elena.agazzi@libero.it	2116
elena.agazzi@libero.it	536
elena.agazzi@libero.it	1183
elena.agazzi@libero.it	546
elena.agazzi@libero.it	2859
elena.agazzi@libero.it	2702
elena.agazzi@libero.it	1261
elena.agazzi@libero.it	1133
elena.agazzi@libero.it	752
elena.agazzi@libero.it	1691
elena.agazzi@libero.it	149
elena.agazzi@libero.it	23
elena.agazzi@libero.it	1088
elena.agazzi@libero.it	2192
elena.agazzi@libero.it	2666
elena.agazzi@libero.it	2031
elena.agazzi@libero.it	1500
elena.agazzi@libero.it	2208
elena.agazzi@libero.it	323
elena.agazzi@libero.it	2079
elena.agazzi@libero.it	1578
elena.agazzi@libero.it	2289
elena.agazzi@libero.it	2148
elena.agazzi@libero.it	1530
elena.agazzi@libero.it	713
elena.agazzi@libero.it	1536
elena.agazzi@libero.it	2545
elena.agazzi@libero.it	811
elena.agazzi@libero.it	2248
elena.agazzi@libero.it	2795
elena.agazzi@libero.it	2821
elena.agazzi@libero.it	2745
elena.agazzi@libero.it	537
elena.agazzi@libero.it	1934
elena.agazzi@libero.it	242
elena.agazzi@libero.it	2518
elena.agazzi@libero.it	2055
elena.agazzi@libero.it	650
elena.agazzi@libero.it	1229
elena.agazzi@libero.it	72
elena.agazzi@libero.it	940
elena.agazzi@libero.it	146
elena.agazzi@libero.it	2427
elena.agazzi@libero.it	55
elena.agazzi@libero.it	1984
elena.agazzi@libero.it	64
elena.agazzi@libero.it	932
elena.agazzi@libero.it	1681
elena.agazzi@libero.it	2286
elena.agazzi@libero.it	584
elena.agazzi@libero.it	2393
elena.agazzi@libero.it	723
elena.agazzi@libero.it	2144
elena.agazzi@libero.it	2
elena.agazzi@libero.it	1051
elena.agazzi@libero.it	1844
elena.agazzi@libero.it	851
elena.agazzi@libero.it	247
elena.agazzi@libero.it	2630
elena.agazzi@libero.it	2603
elena.agazzi@libero.it	2404
elena.agazzi@libero.it	371
elena.agazzi@libero.it	454
elena.agazzi@libero.it	828
elena.agazzi@libero.it	817
elena.agazzi@libero.it	1946
elena.agazzi@libero.it	1477
elena.agazzi@libero.it	1999
elena.agazzi@libero.it	384
elena.agazzi@libero.it	1168
elena.agazzi@libero.it	1041
elena.agazzi@libero.it	1861
elena.agazzi@libero.it	1515
elena.agazzi@libero.it	1628
elena.agazzi@libero.it	1981
elena.agazzi@libero.it	196
elena.agazzi@libero.it	2677
elena.agazzi@libero.it	1953
elena.agazzi@libero.it	67
elena.agazzi@libero.it	1378
elena.agazzi@libero.it	1813
elena.agazzi@libero.it	514
francesco.fischetti@hotmail.com	1024
francesco.fischetti@hotmail.com	2517
francesco.fischetti@hotmail.com	1933
francesco.fischetti@hotmail.com	318
francesco.fischetti@hotmail.com	1822
francesco.fischetti@hotmail.com	1171
francesco.fischetti@hotmail.com	2671
francesco.fischetti@hotmail.com	2115
francesco.fischetti@hotmail.com	1675
francesco.fischetti@hotmail.com	1720
francesco.fischetti@hotmail.com	1665
francesco.fischetti@hotmail.com	1986
francesco.fischetti@hotmail.com	1748
francesco.fischetti@hotmail.com	1484
francesco.fischetti@hotmail.com	1207
francesco.fischetti@hotmail.com	2079
francesco.fischetti@hotmail.com	433
francesco.fischetti@hotmail.com	501
francesco.fischetti@hotmail.com	2657
francesco.fischetti@hotmail.com	770
francesco.fischetti@hotmail.com	560
francesco.fischetti@hotmail.com	1746
francesco.fischetti@hotmail.com	1570
francesco.fischetti@hotmail.com	1580
francesco.fischetti@hotmail.com	245
francesco.fischetti@hotmail.com	2615
francesco.fischetti@hotmail.com	2529
francesco.fischetti@hotmail.com	357
francesco.fischetti@hotmail.com	1588
francesco.fischetti@hotmail.com	2076
francesco.fischetti@hotmail.com	2812
francesco.fischetti@hotmail.com	2226
francesco.fischetti@hotmail.com	2203
francesco.fischetti@hotmail.com	2540
francesco.fischetti@hotmail.com	228
francesco.fischetti@hotmail.com	34
francesco.fischetti@hotmail.com	68
francesco.fischetti@hotmail.com	1823
francesco.fischetti@hotmail.com	2317
francesco.fischetti@hotmail.com	933
francesco.fischetti@hotmail.com	2722
francesco.fischetti@hotmail.com	1771
francesco.fischetti@hotmail.com	1652
francesco.fischetti@hotmail.com	1828
francesco.fischetti@hotmail.com	1184
francesco.fischetti@hotmail.com	2158
francesco.fischetti@hotmail.com	2714
francesco.fischetti@hotmail.com	595
francesco.fischetti@hotmail.com	2000
francesco.fischetti@hotmail.com	2802
francesco.fischetti@hotmail.com	516
francesco.fischetti@hotmail.com	2038
francesco.fischetti@hotmail.com	1718
francesco.fischetti@hotmail.com	128
francesco.fischetti@hotmail.com	1566
francesco.fischetti@hotmail.com	1619
francesco.fischetti@hotmail.com	642
francesco.fischetti@hotmail.com	1971
francesco.fischetti@hotmail.com	1915
francesco.fischetti@hotmail.com	1246
francesco.fischetti@hotmail.com	2761
francesco.fischetti@hotmail.com	763
francesco.fischetti@hotmail.com	2181
francesco.fischetti@hotmail.com	1565
francesco.fischetti@hotmail.com	1235
francesco.fischetti@hotmail.com	2707
francesco.fischetti@hotmail.com	59
francesco.fischetti@hotmail.com	1291
francesco.fischetti@hotmail.com	464
francesco.fischetti@hotmail.com	284
francesco.fischetti@hotmail.com	1432
francesco.fischetti@hotmail.com	678
francesco.fischetti@hotmail.com	2253
francesco.fischetti@hotmail.com	2395
francesco.fischetti@hotmail.com	2147
francesco.fischetti@hotmail.com	269
francesco.fischetti@hotmail.com	2143
francesco.fischetti@hotmail.com	562
francesco.fischetti@hotmail.com	37
francesco.fischetti@hotmail.com	1168
francesco.fischetti@hotmail.com	2758
francesco.fischetti@hotmail.com	79
francesco.fischetti@hotmail.com	1083
francesco.fischetti@hotmail.com	1026
francesco.fischetti@hotmail.com	2236
francesco.fischetti@hotmail.com	952
francesco.fischetti@hotmail.com	451
francesco.fischetti@hotmail.com	1434
francesco.fischetti@hotmail.com	529
francesco.fischetti@hotmail.com	591
francesco.fischetti@hotmail.com	2771
francesco.fischetti@hotmail.com	2573
francesco.fischetti@hotmail.com	1691
francesco.fischetti@hotmail.com	2814
francesco.fischetti@hotmail.com	2435
francesco.fischetti@hotmail.com	1105
francesco.fischetti@hotmail.com	1568
francesco.fischetti@hotmail.com	969
francesco.fischetti@hotmail.com	2360
francesco.fischetti@hotmail.com	656
zaira.zeffirelli@virgilio.it	2008
zaira.zeffirelli@virgilio.it	2330
zaira.zeffirelli@virgilio.it	50
zaira.zeffirelli@virgilio.it	194
zaira.zeffirelli@virgilio.it	1508
zaira.zeffirelli@virgilio.it	1190
zaira.zeffirelli@virgilio.it	1664
zaira.zeffirelli@virgilio.it	2116
zaira.zeffirelli@virgilio.it	2091
zaira.zeffirelli@virgilio.it	674
zaira.zeffirelli@virgilio.it	2711
zaira.zeffirelli@virgilio.it	860
zaira.zeffirelli@virgilio.it	2603
zaira.zeffirelli@virgilio.it	610
zaira.zeffirelli@virgilio.it	302
zaira.zeffirelli@virgilio.it	21
zaira.zeffirelli@virgilio.it	1069
zaira.zeffirelli@virgilio.it	1975
zaira.zeffirelli@virgilio.it	2014
zaira.zeffirelli@virgilio.it	928
zaira.zeffirelli@virgilio.it	2524
zaira.zeffirelli@virgilio.it	618
zaira.zeffirelli@virgilio.it	2082
zaira.zeffirelli@virgilio.it	591
zaira.zeffirelli@virgilio.it	881
zaira.zeffirelli@virgilio.it	702
zaira.zeffirelli@virgilio.it	37
zaira.zeffirelli@virgilio.it	356
zaira.zeffirelli@virgilio.it	375
zaira.zeffirelli@virgilio.it	2248
zaira.zeffirelli@virgilio.it	1561
zaira.zeffirelli@virgilio.it	2462
zaira.zeffirelli@virgilio.it	361
zaira.zeffirelli@virgilio.it	2291
zaira.zeffirelli@virgilio.it	2178
zaira.zeffirelli@virgilio.it	906
zaira.zeffirelli@virgilio.it	2457
zaira.zeffirelli@virgilio.it	325
zaira.zeffirelli@virgilio.it	2143
zaira.zeffirelli@virgilio.it	846
zaira.zeffirelli@virgilio.it	571
zaira.zeffirelli@virgilio.it	2450
zaira.zeffirelli@virgilio.it	2677
zaira.zeffirelli@virgilio.it	1815
zaira.zeffirelli@virgilio.it	2736
zaira.zeffirelli@virgilio.it	269
zaira.zeffirelli@virgilio.it	2516
zaira.zeffirelli@virgilio.it	2464
zaira.zeffirelli@virgilio.it	320
zaira.zeffirelli@virgilio.it	1882
zaira.zeffirelli@virgilio.it	2106
zaira.zeffirelli@virgilio.it	742
zaira.zeffirelli@virgilio.it	1029
zaira.zeffirelli@virgilio.it	959
zaira.zeffirelli@virgilio.it	2632
zaira.zeffirelli@virgilio.it	1507
zaira.zeffirelli@virgilio.it	127
zaira.zeffirelli@virgilio.it	1057
zaira.zeffirelli@virgilio.it	1454
zaira.zeffirelli@virgilio.it	945
zaira.zeffirelli@virgilio.it	1535
zaira.zeffirelli@virgilio.it	224
zaira.zeffirelli@virgilio.it	1933
zaira.zeffirelli@virgilio.it	1949
zaira.zeffirelli@virgilio.it	1559
zaira.zeffirelli@virgilio.it	1907
zaira.zeffirelli@virgilio.it	795
zaira.zeffirelli@virgilio.it	926
zaira.zeffirelli@virgilio.it	490
zaira.zeffirelli@virgilio.it	1721
zaira.zeffirelli@virgilio.it	2451
zaira.zeffirelli@virgilio.it	2595
zaira.zeffirelli@virgilio.it	304
zaira.zeffirelli@virgilio.it	2745
zaira.zeffirelli@virgilio.it	1687
zaira.zeffirelli@virgilio.it	2517
zaira.zeffirelli@virgilio.it	1620
zaira.zeffirelli@virgilio.it	717
zaira.zeffirelli@virgilio.it	1496
zaira.zeffirelli@virgilio.it	529
zaira.zeffirelli@virgilio.it	2598
zaira.zeffirelli@virgilio.it	1473
zaira.zeffirelli@virgilio.it	2831
zaira.zeffirelli@virgilio.it	2701
zaira.zeffirelli@virgilio.it	1884
zaira.zeffirelli@virgilio.it	2097
zaira.zeffirelli@virgilio.it	2127
zaira.zeffirelli@virgilio.it	1792
zaira.zeffirelli@virgilio.it	1201
zaira.zeffirelli@virgilio.it	147
zaira.zeffirelli@virgilio.it	533
zaira.zeffirelli@virgilio.it	780
zaira.zeffirelli@virgilio.it	2469
zaira.zeffirelli@virgilio.it	1027
zaira.zeffirelli@virgilio.it	1215
zaira.zeffirelli@virgilio.it	459
zaira.zeffirelli@virgilio.it	2838
zaira.zeffirelli@virgilio.it	2515
zaira.zeffirelli@virgilio.it	1680
zaira.zeffirelli@virgilio.it	2744
ricciotti.nicolucci@hotmail.com	1314
ricciotti.nicolucci@hotmail.com	60
ricciotti.nicolucci@hotmail.com	586
ricciotti.nicolucci@hotmail.com	2859
ricciotti.nicolucci@hotmail.com	1064
ricciotti.nicolucci@hotmail.com	1114
ricciotti.nicolucci@hotmail.com	1625
ricciotti.nicolucci@hotmail.com	121
ricciotti.nicolucci@hotmail.com	887
ricciotti.nicolucci@hotmail.com	768
ricciotti.nicolucci@hotmail.com	965
ricciotti.nicolucci@hotmail.com	611
ricciotti.nicolucci@hotmail.com	178
ricciotti.nicolucci@hotmail.com	1454
ricciotti.nicolucci@hotmail.com	276
ricciotti.nicolucci@hotmail.com	355
ricciotti.nicolucci@hotmail.com	131
ricciotti.nicolucci@hotmail.com	76
ricciotti.nicolucci@hotmail.com	403
ricciotti.nicolucci@hotmail.com	1248
ricciotti.nicolucci@hotmail.com	1302
ricciotti.nicolucci@hotmail.com	390
ricciotti.nicolucci@hotmail.com	937
ricciotti.nicolucci@hotmail.com	1869
ricciotti.nicolucci@hotmail.com	1436
ricciotti.nicolucci@hotmail.com	1060
ricciotti.nicolucci@hotmail.com	2403
ricciotti.nicolucci@hotmail.com	64
ricciotti.nicolucci@hotmail.com	274
ricciotti.nicolucci@hotmail.com	625
ricciotti.nicolucci@hotmail.com	1835
ricciotti.nicolucci@hotmail.com	1423
ricciotti.nicolucci@hotmail.com	791
ricciotti.nicolucci@hotmail.com	464
ricciotti.nicolucci@hotmail.com	1490
ricciotti.nicolucci@hotmail.com	2654
ricciotti.nicolucci@hotmail.com	2513
ricciotti.nicolucci@hotmail.com	134
ricciotti.nicolucci@hotmail.com	1699
ricciotti.nicolucci@hotmail.com	1692
ricciotti.nicolucci@hotmail.com	2753
ricciotti.nicolucci@hotmail.com	645
ricciotti.nicolucci@hotmail.com	1868
ricciotti.nicolucci@hotmail.com	1209
ricciotti.nicolucci@hotmail.com	392
ricciotti.nicolucci@hotmail.com	2209
ricciotti.nicolucci@hotmail.com	694
ricciotti.nicolucci@hotmail.com	2619
ricciotti.nicolucci@hotmail.com	1313
ricciotti.nicolucci@hotmail.com	194
ricciotti.nicolucci@hotmail.com	282
ricciotti.nicolucci@hotmail.com	2801
ricciotti.nicolucci@hotmail.com	2398
ricciotti.nicolucci@hotmail.com	1016
ricciotti.nicolucci@hotmail.com	617
ricciotti.nicolucci@hotmail.com	2046
ricciotti.nicolucci@hotmail.com	2449
ricciotti.nicolucci@hotmail.com	865
ricciotti.nicolucci@hotmail.com	1437
ricciotti.nicolucci@hotmail.com	2601
ricciotti.nicolucci@hotmail.com	1576
ricciotti.nicolucci@hotmail.com	397
ricciotti.nicolucci@hotmail.com	1292
ricciotti.nicolucci@hotmail.com	341
ricciotti.nicolucci@hotmail.com	1900
ricciotti.nicolucci@hotmail.com	929
ricciotti.nicolucci@hotmail.com	2335
ricciotti.nicolucci@hotmail.com	80
ricciotti.nicolucci@hotmail.com	2530
ricciotti.nicolucci@hotmail.com	1951
ricciotti.nicolucci@hotmail.com	2849
ricciotti.nicolucci@hotmail.com	787
ricciotti.nicolucci@hotmail.com	2591
ricciotti.nicolucci@hotmail.com	1638
ricciotti.nicolucci@hotmail.com	1637
ricciotti.nicolucci@hotmail.com	2505
ricciotti.nicolucci@hotmail.com	2768
ricciotti.nicolucci@hotmail.com	139
ricciotti.nicolucci@hotmail.com	1730
ricciotti.nicolucci@hotmail.com	1572
ricciotti.nicolucci@hotmail.com	1018
ricciotti.nicolucci@hotmail.com	1700
ricciotti.nicolucci@hotmail.com	1863
ricciotti.nicolucci@hotmail.com	757
ricciotti.nicolucci@hotmail.com	1470
ricciotti.nicolucci@hotmail.com	1043
ricciotti.nicolucci@hotmail.com	75
ricciotti.nicolucci@hotmail.com	1735
ricciotti.nicolucci@hotmail.com	889
ricciotti.nicolucci@hotmail.com	1300
ricciotti.nicolucci@hotmail.com	2527
ricciotti.nicolucci@hotmail.com	1180
ricciotti.nicolucci@hotmail.com	1199
ricciotti.nicolucci@hotmail.com	186
ricciotti.nicolucci@hotmail.com	2726
ricciotti.nicolucci@hotmail.com	1641
ricciotti.nicolucci@hotmail.com	858
ricciotti.nicolucci@hotmail.com	1017
ricciotti.nicolucci@hotmail.com	2396
ricciotti.nicolucci@hotmail.com	67
lara.grimani@virgilio.it	1082
lara.grimani@virgilio.it	460
lara.grimani@virgilio.it	454
lara.grimani@virgilio.it	2517
lara.grimani@virgilio.it	1460
lara.grimani@virgilio.it	2533
lara.grimani@virgilio.it	1790
lara.grimani@virgilio.it	2382
lara.grimani@virgilio.it	356
lara.grimani@virgilio.it	303
lara.grimani@virgilio.it	1232
lara.grimani@virgilio.it	32
lara.grimani@virgilio.it	2697
lara.grimani@virgilio.it	376
lara.grimani@virgilio.it	1639
lara.grimani@virgilio.it	496
lara.grimani@virgilio.it	1974
lara.grimani@virgilio.it	271
lara.grimani@virgilio.it	2006
lara.grimani@virgilio.it	920
lara.grimani@virgilio.it	1021
lara.grimani@virgilio.it	168
lara.grimani@virgilio.it	1818
lara.grimani@virgilio.it	868
lara.grimani@virgilio.it	1219
lara.grimani@virgilio.it	17
lara.grimani@virgilio.it	259
lara.grimani@virgilio.it	1572
lara.grimani@virgilio.it	2608
lara.grimani@virgilio.it	2473
lara.grimani@virgilio.it	2156
lara.grimani@virgilio.it	2209
lara.grimani@virgilio.it	880
lara.grimani@virgilio.it	1692
lara.grimani@virgilio.it	1644
lara.grimani@virgilio.it	1079
lara.grimani@virgilio.it	1827
lara.grimani@virgilio.it	1511
lara.grimani@virgilio.it	1446
lara.grimani@virgilio.it	2279
lara.grimani@virgilio.it	1302
lara.grimani@virgilio.it	2858
lara.grimani@virgilio.it	2541
lara.grimani@virgilio.it	839
lara.grimani@virgilio.it	175
lara.grimani@virgilio.it	503
lara.grimani@virgilio.it	878
lara.grimani@virgilio.it	1815
lara.grimani@virgilio.it	821
lara.grimani@virgilio.it	2381
lara.grimani@virgilio.it	1748
lara.grimani@virgilio.it	1255
lara.grimani@virgilio.it	292
lara.grimani@virgilio.it	1708
lara.grimani@virgilio.it	1726
lara.grimani@virgilio.it	647
lara.grimani@virgilio.it	2619
lara.grimani@virgilio.it	318
lara.grimani@virgilio.it	731
lara.grimani@virgilio.it	2234
lara.grimani@virgilio.it	591
lara.grimani@virgilio.it	1585
lara.grimani@virgilio.it	692
lara.grimani@virgilio.it	1760
lara.grimani@virgilio.it	1115
lara.grimani@virgilio.it	1043
lara.grimani@virgilio.it	1488
lara.grimani@virgilio.it	1316
lara.grimani@virgilio.it	2638
lara.grimani@virgilio.it	2094
lara.grimani@virgilio.it	2114
lara.grimani@virgilio.it	1423
lara.grimani@virgilio.it	1516
lara.grimani@virgilio.it	597
lara.grimani@virgilio.it	1682
lara.grimani@virgilio.it	1383
lara.grimani@virgilio.it	140
lara.grimani@virgilio.it	2285
lara.grimani@virgilio.it	1781
lara.grimani@virgilio.it	2248
lara.grimani@virgilio.it	343
lara.grimani@virgilio.it	205
lara.grimani@virgilio.it	2690
lara.grimani@virgilio.it	1011
lara.grimani@virgilio.it	42
lara.grimani@virgilio.it	1045
lara.grimani@virgilio.it	1613
lara.grimani@virgilio.it	1172
lara.grimani@virgilio.it	1696
lara.grimani@virgilio.it	943
lara.grimani@virgilio.it	247
lara.grimani@virgilio.it	49
lara.grimani@virgilio.it	926
lara.grimani@virgilio.it	1570
lara.grimani@virgilio.it	2007
lara.grimani@virgilio.it	323
lara.grimani@virgilio.it	262
lara.grimani@virgilio.it	563
lara.grimani@virgilio.it	2122
lara.grimani@virgilio.it	2318
piergiorgio.pininfarina@hotmail.com	82
piergiorgio.pininfarina@hotmail.com	652
piergiorgio.pininfarina@hotmail.com	1670
piergiorgio.pininfarina@hotmail.com	1924
piergiorgio.pininfarina@hotmail.com	2614
piergiorgio.pininfarina@hotmail.com	866
piergiorgio.pininfarina@hotmail.com	766
piergiorgio.pininfarina@hotmail.com	429
piergiorgio.pininfarina@hotmail.com	102
piergiorgio.pininfarina@hotmail.com	582
piergiorgio.pininfarina@hotmail.com	1877
piergiorgio.pininfarina@hotmail.com	218
piergiorgio.pininfarina@hotmail.com	2570
piergiorgio.pininfarina@hotmail.com	1121
piergiorgio.pininfarina@hotmail.com	1687
piergiorgio.pininfarina@hotmail.com	60
piergiorgio.pininfarina@hotmail.com	2438
piergiorgio.pininfarina@hotmail.com	23
piergiorgio.pininfarina@hotmail.com	1618
piergiorgio.pininfarina@hotmail.com	2307
piergiorgio.pininfarina@hotmail.com	1279
piergiorgio.pininfarina@hotmail.com	721
piergiorgio.pininfarina@hotmail.com	967
piergiorgio.pininfarina@hotmail.com	1547
piergiorgio.pininfarina@hotmail.com	1301
piergiorgio.pininfarina@hotmail.com	803
piergiorgio.pininfarina@hotmail.com	1793
piergiorgio.pininfarina@hotmail.com	2634
piergiorgio.pininfarina@hotmail.com	192
piergiorgio.pininfarina@hotmail.com	2083
piergiorgio.pininfarina@hotmail.com	589
piergiorgio.pininfarina@hotmail.com	2832
piergiorgio.pininfarina@hotmail.com	1060
piergiorgio.pininfarina@hotmail.com	1430
piergiorgio.pininfarina@hotmail.com	1556
piergiorgio.pininfarina@hotmail.com	468
piergiorgio.pininfarina@hotmail.com	599
piergiorgio.pininfarina@hotmail.com	154
piergiorgio.pininfarina@hotmail.com	2727
piergiorgio.pininfarina@hotmail.com	2479
piergiorgio.pininfarina@hotmail.com	1225
piergiorgio.pininfarina@hotmail.com	271
piergiorgio.pininfarina@hotmail.com	2427
piergiorgio.pininfarina@hotmail.com	2797
piergiorgio.pininfarina@hotmail.com	651
piergiorgio.pininfarina@hotmail.com	1187
piergiorgio.pininfarina@hotmail.com	130
piergiorgio.pininfarina@hotmail.com	2489
piergiorgio.pininfarina@hotmail.com	114
piergiorgio.pininfarina@hotmail.com	467
piergiorgio.pininfarina@hotmail.com	576
piergiorgio.pininfarina@hotmail.com	2754
piergiorgio.pininfarina@hotmail.com	443
piergiorgio.pininfarina@hotmail.com	1664
piergiorgio.pininfarina@hotmail.com	1491
piergiorgio.pininfarina@hotmail.com	1258
piergiorgio.pininfarina@hotmail.com	1285
piergiorgio.pininfarina@hotmail.com	771
piergiorgio.pininfarina@hotmail.com	1791
piergiorgio.pininfarina@hotmail.com	194
piergiorgio.pininfarina@hotmail.com	1856
piergiorgio.pininfarina@hotmail.com	2225
piergiorgio.pininfarina@hotmail.com	1514
piergiorgio.pininfarina@hotmail.com	2518
piergiorgio.pininfarina@hotmail.com	2408
piergiorgio.pininfarina@hotmail.com	222
piergiorgio.pininfarina@hotmail.com	2293
piergiorgio.pininfarina@hotmail.com	2320
piergiorgio.pininfarina@hotmail.com	1609
piergiorgio.pininfarina@hotmail.com	524
piergiorgio.pininfarina@hotmail.com	2429
piergiorgio.pininfarina@hotmail.com	776
piergiorgio.pininfarina@hotmail.com	177
piergiorgio.pininfarina@hotmail.com	579
piergiorgio.pininfarina@hotmail.com	209
piergiorgio.pininfarina@hotmail.com	1645
piergiorgio.pininfarina@hotmail.com	689
piergiorgio.pininfarina@hotmail.com	820
piergiorgio.pininfarina@hotmail.com	2377
piergiorgio.pininfarina@hotmail.com	1230
piergiorgio.pininfarina@hotmail.com	2366
piergiorgio.pininfarina@hotmail.com	1534
piergiorgio.pininfarina@hotmail.com	2215
piergiorgio.pininfarina@hotmail.com	2154
piergiorgio.pininfarina@hotmail.com	1139
piergiorgio.pininfarina@hotmail.com	2217
piergiorgio.pininfarina@hotmail.com	697
piergiorgio.pininfarina@hotmail.com	375
piergiorgio.pininfarina@hotmail.com	335
piergiorgio.pininfarina@hotmail.com	2795
piergiorgio.pininfarina@hotmail.com	1039
piergiorgio.pininfarina@hotmail.com	1142
piergiorgio.pininfarina@hotmail.com	839
piergiorgio.pininfarina@hotmail.com	2393
piergiorgio.pininfarina@hotmail.com	276
piergiorgio.pininfarina@hotmail.com	160
piergiorgio.pininfarina@hotmail.com	2770
piergiorgio.pininfarina@hotmail.com	244
piergiorgio.pininfarina@hotmail.com	9
piergiorgio.pininfarina@hotmail.com	1648
hugo.morpurgo@hotmail.com	2809
hugo.morpurgo@hotmail.com	2073
hugo.morpurgo@hotmail.com	1863
hugo.morpurgo@hotmail.com	1275
hugo.morpurgo@hotmail.com	1522
hugo.morpurgo@hotmail.com	375
hugo.morpurgo@hotmail.com	1989
hugo.morpurgo@hotmail.com	385
hugo.morpurgo@hotmail.com	1942
hugo.morpurgo@hotmail.com	1784
hugo.morpurgo@hotmail.com	157
hugo.morpurgo@hotmail.com	587
hugo.morpurgo@hotmail.com	500
hugo.morpurgo@hotmail.com	834
hugo.morpurgo@hotmail.com	2739
hugo.morpurgo@hotmail.com	1068
hugo.morpurgo@hotmail.com	594
hugo.morpurgo@hotmail.com	1572
hugo.morpurgo@hotmail.com	2585
hugo.morpurgo@hotmail.com	2723
hugo.morpurgo@hotmail.com	2298
hugo.morpurgo@hotmail.com	615
hugo.morpurgo@hotmail.com	1268
hugo.morpurgo@hotmail.com	534
hugo.morpurgo@hotmail.com	2535
hugo.morpurgo@hotmail.com	2330
hugo.morpurgo@hotmail.com	2545
hugo.morpurgo@hotmail.com	1885
hugo.morpurgo@hotmail.com	942
hugo.morpurgo@hotmail.com	2569
hugo.morpurgo@hotmail.com	710
hugo.morpurgo@hotmail.com	1703
hugo.morpurgo@hotmail.com	800
hugo.morpurgo@hotmail.com	362
hugo.morpurgo@hotmail.com	1249
hugo.morpurgo@hotmail.com	1306
hugo.morpurgo@hotmail.com	2680
hugo.morpurgo@hotmail.com	775
hugo.morpurgo@hotmail.com	2805
hugo.morpurgo@hotmail.com	2207
hugo.morpurgo@hotmail.com	855
hugo.morpurgo@hotmail.com	2544
hugo.morpurgo@hotmail.com	1098
hugo.morpurgo@hotmail.com	1471
hugo.morpurgo@hotmail.com	2341
hugo.morpurgo@hotmail.com	1228
hugo.morpurgo@hotmail.com	1757
hugo.morpurgo@hotmail.com	1097
hugo.morpurgo@hotmail.com	772
hugo.morpurgo@hotmail.com	819
hugo.morpurgo@hotmail.com	802
hugo.morpurgo@hotmail.com	2169
hugo.morpurgo@hotmail.com	824
hugo.morpurgo@hotmail.com	1797
hugo.morpurgo@hotmail.com	1383
hugo.morpurgo@hotmail.com	795
hugo.morpurgo@hotmail.com	1186
hugo.morpurgo@hotmail.com	1674
hugo.morpurgo@hotmail.com	692
hugo.morpurgo@hotmail.com	1224
hugo.morpurgo@hotmail.com	2505
hugo.morpurgo@hotmail.com	337
hugo.morpurgo@hotmail.com	1829
hugo.morpurgo@hotmail.com	1411
hugo.morpurgo@hotmail.com	1457
hugo.morpurgo@hotmail.com	2163
hugo.morpurgo@hotmail.com	2791
hugo.morpurgo@hotmail.com	2442
hugo.morpurgo@hotmail.com	1759
hugo.morpurgo@hotmail.com	667
hugo.morpurgo@hotmail.com	2466
hugo.morpurgo@hotmail.com	2359
hugo.morpurgo@hotmail.com	967
hugo.morpurgo@hotmail.com	2274
hugo.morpurgo@hotmail.com	277
hugo.morpurgo@hotmail.com	2181
hugo.morpurgo@hotmail.com	491
hugo.morpurgo@hotmail.com	286
hugo.morpurgo@hotmail.com	866
hugo.morpurgo@hotmail.com	2188
hugo.morpurgo@hotmail.com	2158
hugo.morpurgo@hotmail.com	2323
hugo.morpurgo@hotmail.com	536
hugo.morpurgo@hotmail.com	688
hugo.morpurgo@hotmail.com	2077
hugo.morpurgo@hotmail.com	466
hugo.morpurgo@hotmail.com	1818
hugo.morpurgo@hotmail.com	161
hugo.morpurgo@hotmail.com	2704
hugo.morpurgo@hotmail.com	1815
hugo.morpurgo@hotmail.com	2377
hugo.morpurgo@hotmail.com	1683
hugo.morpurgo@hotmail.com	1670
hugo.morpurgo@hotmail.com	1880
hugo.morpurgo@hotmail.com	604
hugo.morpurgo@hotmail.com	1873
hugo.morpurgo@hotmail.com	725
hugo.morpurgo@hotmail.com	1564
hugo.morpurgo@hotmail.com	2559
hugo.morpurgo@hotmail.com	2252
lisa.parmitano@libero.it	638
lisa.parmitano@libero.it	2407
lisa.parmitano@libero.it	2336
lisa.parmitano@libero.it	1652
lisa.parmitano@libero.it	1730
lisa.parmitano@libero.it	186
lisa.parmitano@libero.it	2263
lisa.parmitano@libero.it	710
lisa.parmitano@libero.it	1256
lisa.parmitano@libero.it	1567
lisa.parmitano@libero.it	2370
lisa.parmitano@libero.it	2104
lisa.parmitano@libero.it	1035
lisa.parmitano@libero.it	2266
lisa.parmitano@libero.it	673
lisa.parmitano@libero.it	2161
lisa.parmitano@libero.it	526
lisa.parmitano@libero.it	481
lisa.parmitano@libero.it	1490
lisa.parmitano@libero.it	316
lisa.parmitano@libero.it	55
lisa.parmitano@libero.it	1501
lisa.parmitano@libero.it	667
lisa.parmitano@libero.it	907
lisa.parmitano@libero.it	1041
lisa.parmitano@libero.it	38
lisa.parmitano@libero.it	385
lisa.parmitano@libero.it	2677
lisa.parmitano@libero.it	1968
lisa.parmitano@libero.it	474
lisa.parmitano@libero.it	955
lisa.parmitano@libero.it	1190
lisa.parmitano@libero.it	2473
lisa.parmitano@libero.it	200
lisa.parmitano@libero.it	2090
lisa.parmitano@libero.it	2079
lisa.parmitano@libero.it	2490
lisa.parmitano@libero.it	1503
lisa.parmitano@libero.it	1383
lisa.parmitano@libero.it	2213
lisa.parmitano@libero.it	1312
lisa.parmitano@libero.it	795
lisa.parmitano@libero.it	2315
lisa.parmitano@libero.it	2773
lisa.parmitano@libero.it	2117
lisa.parmitano@libero.it	1304
lisa.parmitano@libero.it	1081
lisa.parmitano@libero.it	2194
lisa.parmitano@libero.it	1577
lisa.parmitano@libero.it	700
lisa.parmitano@libero.it	1461
lisa.parmitano@libero.it	951
lisa.parmitano@libero.it	495
lisa.parmitano@libero.it	1430
lisa.parmitano@libero.it	2309
lisa.parmitano@libero.it	2572
lisa.parmitano@libero.it	1934
lisa.parmitano@libero.it	1761
lisa.parmitano@libero.it	36
lisa.parmitano@libero.it	1558
lisa.parmitano@libero.it	2636
lisa.parmitano@libero.it	1566
lisa.parmitano@libero.it	542
lisa.parmitano@libero.it	2688
lisa.parmitano@libero.it	194
lisa.parmitano@libero.it	988
lisa.parmitano@libero.it	2113
lisa.parmitano@libero.it	646
lisa.parmitano@libero.it	538
lisa.parmitano@libero.it	477
lisa.parmitano@libero.it	489
lisa.parmitano@libero.it	1437
lisa.parmitano@libero.it	626
lisa.parmitano@libero.it	537
lisa.parmitano@libero.it	853
lisa.parmitano@libero.it	488
lisa.parmitano@libero.it	1133
lisa.parmitano@libero.it	2739
lisa.parmitano@libero.it	56
lisa.parmitano@libero.it	1753
lisa.parmitano@libero.it	549
lisa.parmitano@libero.it	2678
lisa.parmitano@libero.it	312
lisa.parmitano@libero.it	1276
lisa.parmitano@libero.it	453
lisa.parmitano@libero.it	2074
lisa.parmitano@libero.it	2827
lisa.parmitano@libero.it	1855
lisa.parmitano@libero.it	1645
lisa.parmitano@libero.it	2631
lisa.parmitano@libero.it	1976
lisa.parmitano@libero.it	1896
lisa.parmitano@libero.it	2154
lisa.parmitano@libero.it	1517
lisa.parmitano@libero.it	1165
lisa.parmitano@libero.it	1274
lisa.parmitano@libero.it	1039
lisa.parmitano@libero.it	1729
lisa.parmitano@libero.it	1649
lisa.parmitano@libero.it	2629
flavia.sobrero@virgilio.it	2641
flavia.sobrero@virgilio.it	1741
flavia.sobrero@virgilio.it	1198
flavia.sobrero@virgilio.it	1805
flavia.sobrero@virgilio.it	2699
flavia.sobrero@virgilio.it	2494
flavia.sobrero@virgilio.it	1501
flavia.sobrero@virgilio.it	2002
flavia.sobrero@virgilio.it	2371
flavia.sobrero@virgilio.it	919
flavia.sobrero@virgilio.it	1839
flavia.sobrero@virgilio.it	523
flavia.sobrero@virgilio.it	2475
flavia.sobrero@virgilio.it	836
flavia.sobrero@virgilio.it	1987
flavia.sobrero@virgilio.it	1138
flavia.sobrero@virgilio.it	1122
flavia.sobrero@virgilio.it	2426
flavia.sobrero@virgilio.it	863
flavia.sobrero@virgilio.it	382
flavia.sobrero@virgilio.it	851
flavia.sobrero@virgilio.it	707
flavia.sobrero@virgilio.it	2651
flavia.sobrero@virgilio.it	1956
flavia.sobrero@virgilio.it	841
flavia.sobrero@virgilio.it	1309
flavia.sobrero@virgilio.it	484
flavia.sobrero@virgilio.it	1251
flavia.sobrero@virgilio.it	2717
flavia.sobrero@virgilio.it	37
flavia.sobrero@virgilio.it	2110
flavia.sobrero@virgilio.it	2557
flavia.sobrero@virgilio.it	139
flavia.sobrero@virgilio.it	2678
flavia.sobrero@virgilio.it	643
flavia.sobrero@virgilio.it	2713
flavia.sobrero@virgilio.it	320
flavia.sobrero@virgilio.it	948
flavia.sobrero@virgilio.it	309
flavia.sobrero@virgilio.it	2595
flavia.sobrero@virgilio.it	1416
flavia.sobrero@virgilio.it	1459
flavia.sobrero@virgilio.it	596
flavia.sobrero@virgilio.it	1113
flavia.sobrero@virgilio.it	1563
flavia.sobrero@virgilio.it	2076
flavia.sobrero@virgilio.it	2433
flavia.sobrero@virgilio.it	2487
flavia.sobrero@virgilio.it	2046
flavia.sobrero@virgilio.it	566
flavia.sobrero@virgilio.it	334
flavia.sobrero@virgilio.it	540
flavia.sobrero@virgilio.it	1892
flavia.sobrero@virgilio.it	2305
flavia.sobrero@virgilio.it	1311
flavia.sobrero@virgilio.it	1978
flavia.sobrero@virgilio.it	724
flavia.sobrero@virgilio.it	965
flavia.sobrero@virgilio.it	321
flavia.sobrero@virgilio.it	333
flavia.sobrero@virgilio.it	2342
flavia.sobrero@virgilio.it	241
flavia.sobrero@virgilio.it	2822
flavia.sobrero@virgilio.it	673
flavia.sobrero@virgilio.it	821
flavia.sobrero@virgilio.it	2438
flavia.sobrero@virgilio.it	1926
flavia.sobrero@virgilio.it	1301
flavia.sobrero@virgilio.it	2518
flavia.sobrero@virgilio.it	2334
flavia.sobrero@virgilio.it	1862
flavia.sobrero@virgilio.it	2507
flavia.sobrero@virgilio.it	1111
flavia.sobrero@virgilio.it	22
flavia.sobrero@virgilio.it	933
flavia.sobrero@virgilio.it	2750
flavia.sobrero@virgilio.it	2514
flavia.sobrero@virgilio.it	1659
flavia.sobrero@virgilio.it	2372
flavia.sobrero@virgilio.it	2057
flavia.sobrero@virgilio.it	465
flavia.sobrero@virgilio.it	2528
flavia.sobrero@virgilio.it	1594
flavia.sobrero@virgilio.it	2128
flavia.sobrero@virgilio.it	2673
flavia.sobrero@virgilio.it	2090
flavia.sobrero@virgilio.it	1556
flavia.sobrero@virgilio.it	2096
flavia.sobrero@virgilio.it	1118
flavia.sobrero@virgilio.it	723
flavia.sobrero@virgilio.it	619
flavia.sobrero@virgilio.it	88
flavia.sobrero@virgilio.it	571
flavia.sobrero@virgilio.it	231
flavia.sobrero@virgilio.it	1260
flavia.sobrero@virgilio.it	1637
flavia.sobrero@virgilio.it	1706
flavia.sobrero@virgilio.it	1041
flavia.sobrero@virgilio.it	367
flavia.sobrero@virgilio.it	1039
arsenio.cortese@libero.it	1112
arsenio.cortese@libero.it	2273
arsenio.cortese@libero.it	1459
arsenio.cortese@libero.it	1627
arsenio.cortese@libero.it	1967
arsenio.cortese@libero.it	2705
arsenio.cortese@libero.it	2677
arsenio.cortese@libero.it	138
arsenio.cortese@libero.it	2706
arsenio.cortese@libero.it	1850
arsenio.cortese@libero.it	42
arsenio.cortese@libero.it	1054
arsenio.cortese@libero.it	660
arsenio.cortese@libero.it	177
arsenio.cortese@libero.it	466
arsenio.cortese@libero.it	677
arsenio.cortese@libero.it	732
arsenio.cortese@libero.it	683
arsenio.cortese@libero.it	43
arsenio.cortese@libero.it	957
arsenio.cortese@libero.it	409
arsenio.cortese@libero.it	858
arsenio.cortese@libero.it	2240
arsenio.cortese@libero.it	2616
arsenio.cortese@libero.it	114
arsenio.cortese@libero.it	2417
arsenio.cortese@libero.it	407
arsenio.cortese@libero.it	242
arsenio.cortese@libero.it	1703
arsenio.cortese@libero.it	1077
arsenio.cortese@libero.it	271
arsenio.cortese@libero.it	1474
arsenio.cortese@libero.it	897
arsenio.cortese@libero.it	390
arsenio.cortese@libero.it	2572
arsenio.cortese@libero.it	136
arsenio.cortese@libero.it	1633
arsenio.cortese@libero.it	1138
arsenio.cortese@libero.it	2229
arsenio.cortese@libero.it	517
arsenio.cortese@libero.it	1528
arsenio.cortese@libero.it	491
arsenio.cortese@libero.it	1933
arsenio.cortese@libero.it	2751
arsenio.cortese@libero.it	2234
arsenio.cortese@libero.it	2386
arsenio.cortese@libero.it	2668
arsenio.cortese@libero.it	582
arsenio.cortese@libero.it	2841
arsenio.cortese@libero.it	2403
arsenio.cortese@libero.it	35
arsenio.cortese@libero.it	1215
arsenio.cortese@libero.it	155
arsenio.cortese@libero.it	218
arsenio.cortese@libero.it	988
arsenio.cortese@libero.it	8
arsenio.cortese@libero.it	230
arsenio.cortese@libero.it	873
arsenio.cortese@libero.it	298
arsenio.cortese@libero.it	589
arsenio.cortese@libero.it	1855
arsenio.cortese@libero.it	2277
arsenio.cortese@libero.it	365
arsenio.cortese@libero.it	770
arsenio.cortese@libero.it	1995
arsenio.cortese@libero.it	185
arsenio.cortese@libero.it	2125
arsenio.cortese@libero.it	2009
arsenio.cortese@libero.it	1540
arsenio.cortese@libero.it	1125
arsenio.cortese@libero.it	423
arsenio.cortese@libero.it	2722
arsenio.cortese@libero.it	1721
arsenio.cortese@libero.it	579
arsenio.cortese@libero.it	882
arsenio.cortese@libero.it	2700
arsenio.cortese@libero.it	2731
arsenio.cortese@libero.it	94
arsenio.cortese@libero.it	1924
arsenio.cortese@libero.it	2020
arsenio.cortese@libero.it	1659
arsenio.cortese@libero.it	1756
arsenio.cortese@libero.it	2469
arsenio.cortese@libero.it	2111
arsenio.cortese@libero.it	2843
arsenio.cortese@libero.it	514
arsenio.cortese@libero.it	636
arsenio.cortese@libero.it	824
arsenio.cortese@libero.it	402
arsenio.cortese@libero.it	1047
arsenio.cortese@libero.it	2660
arsenio.cortese@libero.it	1160
arsenio.cortese@libero.it	1050
arsenio.cortese@libero.it	2360
arsenio.cortese@libero.it	1420
arsenio.cortese@libero.it	541
arsenio.cortese@libero.it	204
arsenio.cortese@libero.it	2794
arsenio.cortese@libero.it	2854
arsenio.cortese@libero.it	830
roman.marrone@libero.it	967
roman.marrone@libero.it	2534
roman.marrone@libero.it	1478
roman.marrone@libero.it	485
roman.marrone@libero.it	1919
roman.marrone@libero.it	2466
roman.marrone@libero.it	1838
roman.marrone@libero.it	124
roman.marrone@libero.it	1258
roman.marrone@libero.it	1905
roman.marrone@libero.it	167
roman.marrone@libero.it	1237
roman.marrone@libero.it	728
roman.marrone@libero.it	1743
roman.marrone@libero.it	1577
roman.marrone@libero.it	1594
roman.marrone@libero.it	120
roman.marrone@libero.it	508
roman.marrone@libero.it	2660
roman.marrone@libero.it	476
roman.marrone@libero.it	883
roman.marrone@libero.it	2827
roman.marrone@libero.it	311
roman.marrone@libero.it	182
roman.marrone@libero.it	1723
roman.marrone@libero.it	1891
roman.marrone@libero.it	2649
roman.marrone@libero.it	1111
roman.marrone@libero.it	825
roman.marrone@libero.it	1789
roman.marrone@libero.it	1989
roman.marrone@libero.it	458
roman.marrone@libero.it	395
roman.marrone@libero.it	427
roman.marrone@libero.it	125
roman.marrone@libero.it	919
roman.marrone@libero.it	699
roman.marrone@libero.it	1925
roman.marrone@libero.it	412
roman.marrone@libero.it	2814
roman.marrone@libero.it	219
roman.marrone@libero.it	1647
roman.marrone@libero.it	2120
roman.marrone@libero.it	505
roman.marrone@libero.it	272
roman.marrone@libero.it	2058
roman.marrone@libero.it	2755
roman.marrone@libero.it	1659
roman.marrone@libero.it	2016
roman.marrone@libero.it	1508
roman.marrone@libero.it	135
roman.marrone@libero.it	365
roman.marrone@libero.it	2607
roman.marrone@libero.it	2338
roman.marrone@libero.it	504
roman.marrone@libero.it	226
roman.marrone@libero.it	480
roman.marrone@libero.it	2456
roman.marrone@libero.it	566
roman.marrone@libero.it	2742
roman.marrone@libero.it	1311
roman.marrone@libero.it	557
roman.marrone@libero.it	2769
roman.marrone@libero.it	2328
roman.marrone@libero.it	281
roman.marrone@libero.it	1253
roman.marrone@libero.it	879
roman.marrone@libero.it	2483
roman.marrone@libero.it	175
roman.marrone@libero.it	1479
roman.marrone@libero.it	661
roman.marrone@libero.it	207
roman.marrone@libero.it	1215
roman.marrone@libero.it	1292
roman.marrone@libero.it	2005
roman.marrone@libero.it	315
roman.marrone@libero.it	1232
roman.marrone@libero.it	2061
roman.marrone@libero.it	422
roman.marrone@libero.it	433
roman.marrone@libero.it	2606
roman.marrone@libero.it	2286
roman.marrone@libero.it	90
roman.marrone@libero.it	1688
roman.marrone@libero.it	1837
roman.marrone@libero.it	1887
roman.marrone@libero.it	317
roman.marrone@libero.it	1878
roman.marrone@libero.it	2046
roman.marrone@libero.it	1206
roman.marrone@libero.it	533
roman.marrone@libero.it	1422
roman.marrone@libero.it	345
roman.marrone@libero.it	1266
roman.marrone@libero.it	2735
roman.marrone@libero.it	2141
roman.marrone@libero.it	1485
roman.marrone@libero.it	622
roman.marrone@libero.it	1744
roman.marrone@libero.it	1430
costanzo.bosurgi@virgilio.it	1792
costanzo.bosurgi@virgilio.it	2084
costanzo.bosurgi@virgilio.it	67
costanzo.bosurgi@virgilio.it	2268
costanzo.bosurgi@virgilio.it	440
costanzo.bosurgi@virgilio.it	2681
costanzo.bosurgi@virgilio.it	600
costanzo.bosurgi@virgilio.it	329
costanzo.bosurgi@virgilio.it	255
costanzo.bosurgi@virgilio.it	1659
costanzo.bosurgi@virgilio.it	902
costanzo.bosurgi@virgilio.it	1013
costanzo.bosurgi@virgilio.it	1964
costanzo.bosurgi@virgilio.it	188
costanzo.bosurgi@virgilio.it	1652
costanzo.bosurgi@virgilio.it	1003
costanzo.bosurgi@virgilio.it	859
costanzo.bosurgi@virgilio.it	871
costanzo.bosurgi@virgilio.it	243
costanzo.bosurgi@virgilio.it	1955
costanzo.bosurgi@virgilio.it	2043
costanzo.bosurgi@virgilio.it	542
costanzo.bosurgi@virgilio.it	969
costanzo.bosurgi@virgilio.it	1687
costanzo.bosurgi@virgilio.it	1890
costanzo.bosurgi@virgilio.it	1444
costanzo.bosurgi@virgilio.it	2020
costanzo.bosurgi@virgilio.it	2697
costanzo.bosurgi@virgilio.it	113
costanzo.bosurgi@virgilio.it	2345
costanzo.bosurgi@virgilio.it	1965
costanzo.bosurgi@virgilio.it	2834
costanzo.bosurgi@virgilio.it	1243
costanzo.bosurgi@virgilio.it	1881
costanzo.bosurgi@virgilio.it	496
costanzo.bosurgi@virgilio.it	150
costanzo.bosurgi@virgilio.it	2399
costanzo.bosurgi@virgilio.it	353
costanzo.bosurgi@virgilio.it	1779
costanzo.bosurgi@virgilio.it	225
costanzo.bosurgi@virgilio.it	1724
costanzo.bosurgi@virgilio.it	223
costanzo.bosurgi@virgilio.it	853
costanzo.bosurgi@virgilio.it	404
costanzo.bosurgi@virgilio.it	2435
costanzo.bosurgi@virgilio.it	2196
costanzo.bosurgi@virgilio.it	73
costanzo.bosurgi@virgilio.it	745
costanzo.bosurgi@virgilio.it	1896
costanzo.bosurgi@virgilio.it	2403
costanzo.bosurgi@virgilio.it	1572
costanzo.bosurgi@virgilio.it	1536
costanzo.bosurgi@virgilio.it	945
costanzo.bosurgi@virgilio.it	1234
costanzo.bosurgi@virgilio.it	870
costanzo.bosurgi@virgilio.it	488
costanzo.bosurgi@virgilio.it	2411
costanzo.bosurgi@virgilio.it	673
costanzo.bosurgi@virgilio.it	779
costanzo.bosurgi@virgilio.it	1091
costanzo.bosurgi@virgilio.it	1599
costanzo.bosurgi@virgilio.it	733
costanzo.bosurgi@virgilio.it	335
costanzo.bosurgi@virgilio.it	555
costanzo.bosurgi@virgilio.it	1860
costanzo.bosurgi@virgilio.it	2604
costanzo.bosurgi@virgilio.it	845
costanzo.bosurgi@virgilio.it	2522
costanzo.bosurgi@virgilio.it	1462
costanzo.bosurgi@virgilio.it	1218
costanzo.bosurgi@virgilio.it	2044
costanzo.bosurgi@virgilio.it	117
costanzo.bosurgi@virgilio.it	926
costanzo.bosurgi@virgilio.it	677
costanzo.bosurgi@virgilio.it	183
costanzo.bosurgi@virgilio.it	207
costanzo.bosurgi@virgilio.it	691
costanzo.bosurgi@virgilio.it	1443
costanzo.bosurgi@virgilio.it	2780
costanzo.bosurgi@virgilio.it	1835
costanzo.bosurgi@virgilio.it	2854
costanzo.bosurgi@virgilio.it	674
costanzo.bosurgi@virgilio.it	726
costanzo.bosurgi@virgilio.it	2117
costanzo.bosurgi@virgilio.it	51
costanzo.bosurgi@virgilio.it	2200
costanzo.bosurgi@virgilio.it	1535
costanzo.bosurgi@virgilio.it	400
costanzo.bosurgi@virgilio.it	2692
costanzo.bosurgi@virgilio.it	107
costanzo.bosurgi@virgilio.it	1030
costanzo.bosurgi@virgilio.it	1297
paloma.barozzi@hotmail.com	1073
lilla.ceci@virgilio.it	1073
flavia.sobrero@virgilio.it	1073
piergiorgio.pininfarina@hotmail.com	1102
costanzo.bosurgi@virgilio.it	1463
costanzo.bosurgi@virgilio.it	374
costanzo.bosurgi@virgilio.it	1831
costanzo.bosurgi@virgilio.it	537
costanzo.bosurgi@virgilio.it	2062
costanzo.bosurgi@virgilio.it	1694
costanzo.bosurgi@virgilio.it	1646
costanzo.bosurgi@virgilio.it	135
paoletta.crespi@yahoo.it	230
paoletta.crespi@yahoo.it	1794
paoletta.crespi@yahoo.it	688
paoletta.crespi@yahoo.it	2107
paoletta.crespi@yahoo.it	2684
paoletta.crespi@yahoo.it	1420
paoletta.crespi@yahoo.it	2227
paoletta.crespi@yahoo.it	2802
paoletta.crespi@yahoo.it	2602
paoletta.crespi@yahoo.it	1703
paoletta.crespi@yahoo.it	984
paoletta.crespi@yahoo.it	802
paoletta.crespi@yahoo.it	161
paoletta.crespi@yahoo.it	2403
paoletta.crespi@yahoo.it	854
paoletta.crespi@yahoo.it	2261
paoletta.crespi@yahoo.it	320
paoletta.crespi@yahoo.it	1477
paoletta.crespi@yahoo.it	1539
paoletta.crespi@yahoo.it	2316
paoletta.crespi@yahoo.it	2821
paoletta.crespi@yahoo.it	2012
paoletta.crespi@yahoo.it	2673
paoletta.crespi@yahoo.it	581
paoletta.crespi@yahoo.it	2697
paoletta.crespi@yahoo.it	2286
paoletta.crespi@yahoo.it	468
paoletta.crespi@yahoo.it	2301
paoletta.crespi@yahoo.it	23
paoletta.crespi@yahoo.it	749
paoletta.crespi@yahoo.it	454
paoletta.crespi@yahoo.it	1475
paoletta.crespi@yahoo.it	2150
paoletta.crespi@yahoo.it	1804
paoletta.crespi@yahoo.it	2571
paoletta.crespi@yahoo.it	817
paoletta.crespi@yahoo.it	1946
paoletta.crespi@yahoo.it	2691
paoletta.crespi@yahoo.it	2072
paoletta.crespi@yahoo.it	2549
paoletta.crespi@yahoo.it	1813
paoletta.crespi@yahoo.it	1655
paoletta.crespi@yahoo.it	1587
paoletta.crespi@yahoo.it	1268
paoletta.crespi@yahoo.it	2511
paoletta.crespi@yahoo.it	1258
paoletta.crespi@yahoo.it	1679
paoletta.crespi@yahoo.it	283
paoletta.crespi@yahoo.it	20
paoletta.crespi@yahoo.it	491
paoletta.crespi@yahoo.it	1082
paoletta.crespi@yahoo.it	1148
paoletta.crespi@yahoo.it	2789
paoletta.crespi@yahoo.it	523
paoletta.crespi@yahoo.it	2161
paoletta.crespi@yahoo.it	2204
paoletta.crespi@yahoo.it	76
paoletta.crespi@yahoo.it	892
paoletta.crespi@yahoo.it	1290
paoletta.crespi@yahoo.it	2706
paoletta.crespi@yahoo.it	1408
paoletta.crespi@yahoo.it	1096
paoletta.crespi@yahoo.it	1970
paoletta.crespi@yahoo.it	29
paoletta.crespi@yahoo.it	829
paoletta.crespi@yahoo.it	1114
paoletta.crespi@yahoo.it	1213
paoletta.crespi@yahoo.it	758
paoletta.crespi@yahoo.it	899
paoletta.crespi@yahoo.it	41
paoletta.crespi@yahoo.it	1177
paoletta.crespi@yahoo.it	1421
paoletta.crespi@yahoo.it	567
paoletta.crespi@yahoo.it	1030
paoletta.crespi@yahoo.it	1729
paoletta.crespi@yahoo.it	736
paoletta.crespi@yahoo.it	2229
paoletta.crespi@yahoo.it	2717
paoletta.crespi@yahoo.it	1535
paoletta.crespi@yahoo.it	812
paoletta.crespi@yahoo.it	1101
paoletta.crespi@yahoo.it	2630
paoletta.crespi@yahoo.it	427
paoletta.crespi@yahoo.it	1234
paoletta.crespi@yahoo.it	2806
paoletta.crespi@yahoo.it	760
paoletta.crespi@yahoo.it	2128
paoletta.crespi@yahoo.it	662
paoletta.crespi@yahoo.it	1593
paoletta.crespi@yahoo.it	580
paoletta.crespi@yahoo.it	1501
paoletta.crespi@yahoo.it	73
paoletta.crespi@yahoo.it	539
paoletta.crespi@yahoo.it	2323
paoletta.crespi@yahoo.it	441
paoletta.crespi@yahoo.it	2021
paoletta.crespi@yahoo.it	55
paoletta.crespi@yahoo.it	477
paoletta.crespi@yahoo.it	1739
paoletta.crespi@yahoo.it	1
zaira.bellocchio@yahoo.it	1292
zaira.bellocchio@yahoo.it	2348
zaira.bellocchio@yahoo.it	1674
zaira.bellocchio@yahoo.it	2277
zaira.bellocchio@yahoo.it	2051
zaira.bellocchio@yahoo.it	2601
zaira.bellocchio@yahoo.it	1453
zaira.bellocchio@yahoo.it	806
zaira.bellocchio@yahoo.it	132
zaira.bellocchio@yahoo.it	1202
zaira.bellocchio@yahoo.it	2064
zaira.bellocchio@yahoo.it	315
zaira.bellocchio@yahoo.it	1854
zaira.bellocchio@yahoo.it	1950
zaira.bellocchio@yahoo.it	727
zaira.bellocchio@yahoo.it	1955
zaira.bellocchio@yahoo.it	2065
zaira.bellocchio@yahoo.it	1569
zaira.bellocchio@yahoo.it	2684
zaira.bellocchio@yahoo.it	2832
zaira.bellocchio@yahoo.it	2056
zaira.bellocchio@yahoo.it	2228
zaira.bellocchio@yahoo.it	2282
zaira.bellocchio@yahoo.it	1407
zaira.bellocchio@yahoo.it	974
zaira.bellocchio@yahoo.it	286
zaira.bellocchio@yahoo.it	1079
zaira.bellocchio@yahoo.it	1760
zaira.bellocchio@yahoo.it	1461
zaira.bellocchio@yahoo.it	2176
zaira.bellocchio@yahoo.it	1540
zaira.bellocchio@yahoo.it	2582
zaira.bellocchio@yahoo.it	578
zaira.bellocchio@yahoo.it	2648
zaira.bellocchio@yahoo.it	2333
zaira.bellocchio@yahoo.it	2477
zaira.bellocchio@yahoo.it	160
zaira.bellocchio@yahoo.it	2358
zaira.bellocchio@yahoo.it	1740
zaira.bellocchio@yahoo.it	2068
zaira.bellocchio@yahoo.it	2417
zaira.bellocchio@yahoo.it	522
zaira.bellocchio@yahoo.it	1992
zaira.bellocchio@yahoo.it	1846
zaira.bellocchio@yahoo.it	2638
zaira.bellocchio@yahoo.it	2529
zaira.bellocchio@yahoo.it	610
zaira.bellocchio@yahoo.it	2626
zaira.bellocchio@yahoo.it	2378
zaira.bellocchio@yahoo.it	16
zaira.bellocchio@yahoo.it	2229
zaira.bellocchio@yahoo.it	909
zaira.bellocchio@yahoo.it	2631
zaira.bellocchio@yahoo.it	20
zaira.bellocchio@yahoo.it	567
zaira.bellocchio@yahoo.it	1228
zaira.bellocchio@yahoo.it	1116
zaira.bellocchio@yahoo.it	2093
zaira.bellocchio@yahoo.it	1233
zaira.bellocchio@yahoo.it	1216
zaira.bellocchio@yahoo.it	914
zaira.bellocchio@yahoo.it	440
zaira.bellocchio@yahoo.it	901
zaira.bellocchio@yahoo.it	61
zaira.bellocchio@yahoo.it	1904
zaira.bellocchio@yahoo.it	199
zaira.bellocchio@yahoo.it	2244
zaira.bellocchio@yahoo.it	1973
zaira.bellocchio@yahoo.it	272
zaira.bellocchio@yahoo.it	2456
zaira.bellocchio@yahoo.it	299
zaira.bellocchio@yahoo.it	2334
zaira.bellocchio@yahoo.it	2410
zaira.bellocchio@yahoo.it	1919
zaira.bellocchio@yahoo.it	1737
zaira.bellocchio@yahoo.it	593
zaira.bellocchio@yahoo.it	2388
zaira.bellocchio@yahoo.it	2572
zaira.bellocchio@yahoo.it	543
zaira.bellocchio@yahoo.it	1699
zaira.bellocchio@yahoo.it	2278
zaira.bellocchio@yahoo.it	2213
zaira.bellocchio@yahoo.it	1731
zaira.bellocchio@yahoo.it	2001
zaira.bellocchio@yahoo.it	2123
zaira.bellocchio@yahoo.it	537
zaira.bellocchio@yahoo.it	96
zaira.bellocchio@yahoo.it	2168
zaira.bellocchio@yahoo.it	667
zaira.bellocchio@yahoo.it	2816
zaira.bellocchio@yahoo.it	2009
zaira.bellocchio@yahoo.it	236
zaira.bellocchio@yahoo.it	1106
zaira.bellocchio@yahoo.it	2394
zaira.bellocchio@yahoo.it	714
zaira.bellocchio@yahoo.it	1442
zaira.bellocchio@yahoo.it	2431
zaira.bellocchio@yahoo.it	1926
zaira.bellocchio@yahoo.it	2447
zaira.bellocchio@yahoo.it	2763
manuel.lucciano@virgilio.it	2201
manuel.lucciano@virgilio.it	2369
manuel.lucciano@virgilio.it	1598
manuel.lucciano@virgilio.it	1951
manuel.lucciano@virgilio.it	897
manuel.lucciano@virgilio.it	1564
manuel.lucciano@virgilio.it	2436
manuel.lucciano@virgilio.it	742
manuel.lucciano@virgilio.it	2789
manuel.lucciano@virgilio.it	686
manuel.lucciano@virgilio.it	38
manuel.lucciano@virgilio.it	1965
manuel.lucciano@virgilio.it	2544
manuel.lucciano@virgilio.it	886
manuel.lucciano@virgilio.it	1209
manuel.lucciano@virgilio.it	163
manuel.lucciano@virgilio.it	1842
manuel.lucciano@virgilio.it	2190
manuel.lucciano@virgilio.it	2176
manuel.lucciano@virgilio.it	1620
manuel.lucciano@virgilio.it	1617
manuel.lucciano@virgilio.it	534
manuel.lucciano@virgilio.it	1372
manuel.lucciano@virgilio.it	1789
manuel.lucciano@virgilio.it	1718
manuel.lucciano@virgilio.it	1889
manuel.lucciano@virgilio.it	2293
manuel.lucciano@virgilio.it	2207
manuel.lucciano@virgilio.it	1036
manuel.lucciano@virgilio.it	1607
manuel.lucciano@virgilio.it	1252
manuel.lucciano@virgilio.it	1256
manuel.lucciano@virgilio.it	1100
manuel.lucciano@virgilio.it	302
manuel.lucciano@virgilio.it	1047
manuel.lucciano@virgilio.it	1871
manuel.lucciano@virgilio.it	1981
manuel.lucciano@virgilio.it	2475
manuel.lucciano@virgilio.it	88
manuel.lucciano@virgilio.it	2490
manuel.lucciano@virgilio.it	2791
manuel.lucciano@virgilio.it	2056
manuel.lucciano@virgilio.it	1792
manuel.lucciano@virgilio.it	1944
manuel.lucciano@virgilio.it	2381
manuel.lucciano@virgilio.it	2396
manuel.lucciano@virgilio.it	1911
manuel.lucciano@virgilio.it	1424
manuel.lucciano@virgilio.it	689
manuel.lucciano@virgilio.it	339
manuel.lucciano@virgilio.it	2732
manuel.lucciano@virgilio.it	1439
manuel.lucciano@virgilio.it	2840
manuel.lucciano@virgilio.it	2035
manuel.lucciano@virgilio.it	398
manuel.lucciano@virgilio.it	299
manuel.lucciano@virgilio.it	2302
manuel.lucciano@virgilio.it	1683
manuel.lucciano@virgilio.it	1602
manuel.lucciano@virgilio.it	2702
manuel.lucciano@virgilio.it	525
manuel.lucciano@virgilio.it	668
manuel.lucciano@virgilio.it	2050
manuel.lucciano@virgilio.it	971
manuel.lucciano@virgilio.it	2821
manuel.lucciano@virgilio.it	565
manuel.lucciano@virgilio.it	2090
manuel.lucciano@virgilio.it	563
manuel.lucciano@virgilio.it	2524
manuel.lucciano@virgilio.it	1492
manuel.lucciano@virgilio.it	218
manuel.lucciano@virgilio.it	2195
manuel.lucciano@virgilio.it	2438
manuel.lucciano@virgilio.it	2350
manuel.lucciano@virgilio.it	2115
manuel.lucciano@virgilio.it	190
manuel.lucciano@virgilio.it	1452
manuel.lucciano@virgilio.it	332
manuel.lucciano@virgilio.it	297
manuel.lucciano@virgilio.it	1921
manuel.lucciano@virgilio.it	2012
manuel.lucciano@virgilio.it	1371
manuel.lucciano@virgilio.it	876
manuel.lucciano@virgilio.it	2159
manuel.lucciano@virgilio.it	1998
manuel.lucciano@virgilio.it	993
manuel.lucciano@virgilio.it	752
manuel.lucciano@virgilio.it	1963
manuel.lucciano@virgilio.it	2069
manuel.lucciano@virgilio.it	1446
manuel.lucciano@virgilio.it	184
manuel.lucciano@virgilio.it	5
manuel.lucciano@virgilio.it	386
manuel.lucciano@virgilio.it	839
manuel.lucciano@virgilio.it	606
manuel.lucciano@virgilio.it	2143
manuel.lucciano@virgilio.it	594
manuel.lucciano@virgilio.it	2004
manuel.lucciano@virgilio.it	1170
manuel.lucciano@virgilio.it	1260
milena.grifeo@libero.it	2054
milena.grifeo@libero.it	2808
milena.grifeo@libero.it	582
milena.grifeo@libero.it	648
milena.grifeo@libero.it	2411
milena.grifeo@libero.it	2194
milena.grifeo@libero.it	1514
milena.grifeo@libero.it	94
milena.grifeo@libero.it	2317
milena.grifeo@libero.it	1993
milena.grifeo@libero.it	1517
milena.grifeo@libero.it	1925
milena.grifeo@libero.it	1530
milena.grifeo@libero.it	66
milena.grifeo@libero.it	230
milena.grifeo@libero.it	1603
milena.grifeo@libero.it	749
milena.grifeo@libero.it	2538
milena.grifeo@libero.it	106
milena.grifeo@libero.it	2857
milena.grifeo@libero.it	1523
milena.grifeo@libero.it	2717
milena.grifeo@libero.it	894
milena.grifeo@libero.it	2410
milena.grifeo@libero.it	110
milena.grifeo@libero.it	145
milena.grifeo@libero.it	1502
milena.grifeo@libero.it	1820
milena.grifeo@libero.it	1449
milena.grifeo@libero.it	2648
milena.grifeo@libero.it	2365
milena.grifeo@libero.it	2092
milena.grifeo@libero.it	2164
milena.grifeo@libero.it	381
milena.grifeo@libero.it	1023
milena.grifeo@libero.it	2372
milena.grifeo@libero.it	2805
milena.grifeo@libero.it	657
milena.grifeo@libero.it	704
milena.grifeo@libero.it	2701
milena.grifeo@libero.it	154
milena.grifeo@libero.it	2500
milena.grifeo@libero.it	478
milena.grifeo@libero.it	1882
milena.grifeo@libero.it	88
milena.grifeo@libero.it	1895
milena.grifeo@libero.it	2106
milena.grifeo@libero.it	1638
milena.grifeo@libero.it	22
milena.grifeo@libero.it	2312
milena.grifeo@libero.it	742
milena.grifeo@libero.it	692
milena.grifeo@libero.it	662
milena.grifeo@libero.it	1529
milena.grifeo@libero.it	1589
milena.grifeo@libero.it	2082
milena.grifeo@libero.it	1189
milena.grifeo@libero.it	991
milena.grifeo@libero.it	948
milena.grifeo@libero.it	1859
milena.grifeo@libero.it	2080
milena.grifeo@libero.it	1943
milena.grifeo@libero.it	28
milena.grifeo@libero.it	1496
milena.grifeo@libero.it	391
milena.grifeo@libero.it	1835
milena.grifeo@libero.it	118
milena.grifeo@libero.it	1735
milena.grifeo@libero.it	2018
milena.grifeo@libero.it	2506
milena.grifeo@libero.it	1917
milena.grifeo@libero.it	115
milena.grifeo@libero.it	1213
milena.grifeo@libero.it	140
milena.grifeo@libero.it	1282
milena.grifeo@libero.it	2157
milena.grifeo@libero.it	283
milena.grifeo@libero.it	521
milena.grifeo@libero.it	1089
milena.grifeo@libero.it	135
milena.grifeo@libero.it	494
milena.grifeo@libero.it	97
milena.grifeo@libero.it	146
milena.grifeo@libero.it	945
milena.grifeo@libero.it	250
milena.grifeo@libero.it	389
milena.grifeo@libero.it	1166
milena.grifeo@libero.it	921
milena.grifeo@libero.it	1503
milena.grifeo@libero.it	467
milena.grifeo@libero.it	70
milena.grifeo@libero.it	799
milena.grifeo@libero.it	887
milena.grifeo@libero.it	2298
milena.grifeo@libero.it	194
milena.grifeo@libero.it	766
milena.grifeo@libero.it	232
milena.grifeo@libero.it	2402
milena.grifeo@libero.it	2686
milena.grifeo@libero.it	281
lilla.ceci@virgilio.it	2275
lilla.ceci@virgilio.it	170
lilla.ceci@virgilio.it	193
lilla.ceci@virgilio.it	883
lilla.ceci@virgilio.it	727
lilla.ceci@virgilio.it	2544
lilla.ceci@virgilio.it	1486
lilla.ceci@virgilio.it	1867
lilla.ceci@virgilio.it	1113
lilla.ceci@virgilio.it	404
lilla.ceci@virgilio.it	1680
lilla.ceci@virgilio.it	29
lilla.ceci@virgilio.it	509
lilla.ceci@virgilio.it	1531
lilla.ceci@virgilio.it	1411
lilla.ceci@virgilio.it	20
lilla.ceci@virgilio.it	2080
lilla.ceci@virgilio.it	1244
lilla.ceci@virgilio.it	2261
lilla.ceci@virgilio.it	878
lilla.ceci@virgilio.it	1214
lilla.ceci@virgilio.it	2679
lilla.ceci@virgilio.it	813
lilla.ceci@virgilio.it	1316
lilla.ceci@virgilio.it	253
lilla.ceci@virgilio.it	542
lilla.ceci@virgilio.it	538
lilla.ceci@virgilio.it	1429
lilla.ceci@virgilio.it	2742
lilla.ceci@virgilio.it	2381
lilla.ceci@virgilio.it	1491
lilla.ceci@virgilio.it	2109
lilla.ceci@virgilio.it	1648
lilla.ceci@virgilio.it	19
lilla.ceci@virgilio.it	374
lilla.ceci@virgilio.it	2060
lilla.ceci@virgilio.it	1264
lilla.ceci@virgilio.it	2138
lilla.ceci@virgilio.it	2167
lilla.ceci@virgilio.it	2048
lilla.ceci@virgilio.it	1118
lilla.ceci@virgilio.it	2586
lilla.ceci@virgilio.it	1479
lilla.ceci@virgilio.it	1939
lilla.ceci@virgilio.it	621
lilla.ceci@virgilio.it	2364
lilla.ceci@virgilio.it	114
lilla.ceci@virgilio.it	2489
lilla.ceci@virgilio.it	1969
lilla.ceci@virgilio.it	1235
lilla.ceci@virgilio.it	2665
lilla.ceci@virgilio.it	2594
lilla.ceci@virgilio.it	1518
lilla.ceci@virgilio.it	1110
lilla.ceci@virgilio.it	1816
lilla.ceci@virgilio.it	2832
lilla.ceci@virgilio.it	235
lilla.ceci@virgilio.it	1413
lilla.ceci@virgilio.it	1417
lilla.ceci@virgilio.it	926
lilla.ceci@virgilio.it	363
lilla.ceci@virgilio.it	2070
lilla.ceci@virgilio.it	75
lilla.ceci@virgilio.it	2130
lilla.ceci@virgilio.it	841
lilla.ceci@virgilio.it	478
lilla.ceci@virgilio.it	1180
lilla.ceci@virgilio.it	1215
lilla.ceci@virgilio.it	2701
lilla.ceci@virgilio.it	1650
lilla.ceci@virgilio.it	1089
lilla.ceci@virgilio.it	1229
lilla.ceci@virgilio.it	1732
lilla.ceci@virgilio.it	661
lilla.ceci@virgilio.it	1819
lilla.ceci@virgilio.it	1172
lilla.ceci@virgilio.it	1857
lilla.ceci@virgilio.it	2539
lilla.ceci@virgilio.it	2798
lilla.ceci@virgilio.it	688
lilla.ceci@virgilio.it	654
lilla.ceci@virgilio.it	4
lilla.ceci@virgilio.it	2487
lilla.ceci@virgilio.it	911
lilla.ceci@virgilio.it	1152
lilla.ceci@virgilio.it	160
lilla.ceci@virgilio.it	116
lilla.ceci@virgilio.it	2225
lilla.ceci@virgilio.it	585
lilla.ceci@virgilio.it	1916
lilla.ceci@virgilio.it	316
lilla.ceci@virgilio.it	1498
lilla.ceci@virgilio.it	652
lilla.ceci@virgilio.it	49
lilla.ceci@virgilio.it	65
lilla.ceci@virgilio.it	2558
lilla.ceci@virgilio.it	479
lilla.ceci@virgilio.it	1551
lilla.ceci@virgilio.it	1025
lilla.ceci@virgilio.it	2646
roberto.lussu@yahoo.it	2338
roberto.lussu@yahoo.it	823
roberto.lussu@yahoo.it	2205
roberto.lussu@yahoo.it	2402
roberto.lussu@yahoo.it	1250
roberto.lussu@yahoo.it	1190
roberto.lussu@yahoo.it	1756
roberto.lussu@yahoo.it	1605
roberto.lussu@yahoo.it	2464
roberto.lussu@yahoo.it	1426
roberto.lussu@yahoo.it	2802
roberto.lussu@yahoo.it	147
roberto.lussu@yahoo.it	517
roberto.lussu@yahoo.it	2085
roberto.lussu@yahoo.it	2516
roberto.lussu@yahoo.it	175
roberto.lussu@yahoo.it	1924
roberto.lussu@yahoo.it	207
roberto.lussu@yahoo.it	1299
roberto.lussu@yahoo.it	1000
roberto.lussu@yahoo.it	110
roberto.lussu@yahoo.it	2806
roberto.lussu@yahoo.it	1534
roberto.lussu@yahoo.it	38
roberto.lussu@yahoo.it	2433
roberto.lussu@yahoo.it	2657
roberto.lussu@yahoo.it	274
roberto.lussu@yahoo.it	2035
roberto.lussu@yahoo.it	1875
roberto.lussu@yahoo.it	549
roberto.lussu@yahoo.it	2450
roberto.lussu@yahoo.it	1642
roberto.lussu@yahoo.it	788
roberto.lussu@yahoo.it	1723
roberto.lussu@yahoo.it	2016
roberto.lussu@yahoo.it	222
roberto.lussu@yahoo.it	1089
roberto.lussu@yahoo.it	16
roberto.lussu@yahoo.it	1812
roberto.lussu@yahoo.it	748
roberto.lussu@yahoo.it	1928
roberto.lussu@yahoo.it	758
roberto.lussu@yahoo.it	948
roberto.lussu@yahoo.it	2293
roberto.lussu@yahoo.it	2268
roberto.lussu@yahoo.it	294
roberto.lussu@yahoo.it	1620
roberto.lussu@yahoo.it	713
roberto.lussu@yahoo.it	237
roberto.lussu@yahoo.it	2129
roberto.lussu@yahoo.it	1286
roberto.lussu@yahoo.it	1868
roberto.lussu@yahoo.it	723
roberto.lussu@yahoo.it	1712
roberto.lussu@yahoo.it	2700
roberto.lussu@yahoo.it	1136
roberto.lussu@yahoo.it	1378
roberto.lussu@yahoo.it	1028
roberto.lussu@yahoo.it	2610
roberto.lussu@yahoo.it	605
roberto.lussu@yahoo.it	835
roberto.lussu@yahoo.it	523
roberto.lussu@yahoo.it	683
roberto.lussu@yahoo.it	2773
roberto.lussu@yahoo.it	2631
roberto.lussu@yahoo.it	1881
roberto.lussu@yahoo.it	314
roberto.lussu@yahoo.it	539
roberto.lussu@yahoo.it	747
roberto.lussu@yahoo.it	1504
roberto.lussu@yahoo.it	2371
roberto.lussu@yahoo.it	2711
roberto.lussu@yahoo.it	1042
roberto.lussu@yahoo.it	959
roberto.lussu@yahoo.it	2777
roberto.lussu@yahoo.it	601
roberto.lussu@yahoo.it	2510
roberto.lussu@yahoo.it	253
roberto.lussu@yahoo.it	398
roberto.lussu@yahoo.it	439
roberto.lussu@yahoo.it	1115
roberto.lussu@yahoo.it	1212
roberto.lussu@yahoo.it	1187
roberto.lussu@yahoo.it	1676
roberto.lussu@yahoo.it	689
roberto.lussu@yahoo.it	559
roberto.lussu@yahoo.it	1602
roberto.lussu@yahoo.it	1768
roberto.lussu@yahoo.it	2123
roberto.lussu@yahoo.it	1423
roberto.lussu@yahoo.it	35
roberto.lussu@yahoo.it	305
roberto.lussu@yahoo.it	360
roberto.lussu@yahoo.it	1788
roberto.lussu@yahoo.it	2086
roberto.lussu@yahoo.it	25
roberto.lussu@yahoo.it	1106
roberto.lussu@yahoo.it	635
roberto.lussu@yahoo.it	2359
roberto.lussu@yahoo.it	887
bettina.scarlatti@yahoo.it	2398
bettina.scarlatti@yahoo.it	2566
bettina.scarlatti@yahoo.it	1996
bettina.scarlatti@yahoo.it	1298
bettina.scarlatti@yahoo.it	643
bettina.scarlatti@yahoo.it	2512
bettina.scarlatti@yahoo.it	25
bettina.scarlatti@yahoo.it	805
bettina.scarlatti@yahoo.it	1424
bettina.scarlatti@yahoo.it	2805
bettina.scarlatti@yahoo.it	2210
bettina.scarlatti@yahoo.it	2334
bettina.scarlatti@yahoo.it	1430
bettina.scarlatti@yahoo.it	2213
bettina.scarlatti@yahoo.it	525
bettina.scarlatti@yahoo.it	2648
bettina.scarlatti@yahoo.it	1074
bettina.scarlatti@yahoo.it	2005
bettina.scarlatti@yahoo.it	2077
bettina.scarlatti@yahoo.it	953
bettina.scarlatti@yahoo.it	162
bettina.scarlatti@yahoo.it	2059
bettina.scarlatti@yahoo.it	692
bettina.scarlatti@yahoo.it	1199
bettina.scarlatti@yahoo.it	2473
bettina.scarlatti@yahoo.it	1873
bettina.scarlatti@yahoo.it	1212
bettina.scarlatti@yahoo.it	1371
bettina.scarlatti@yahoo.it	1014
bettina.scarlatti@yahoo.it	261
bettina.scarlatti@yahoo.it	931
bettina.scarlatti@yahoo.it	2796
bettina.scarlatti@yahoo.it	2044
bettina.scarlatti@yahoo.it	2470
bettina.scarlatti@yahoo.it	1696
bettina.scarlatti@yahoo.it	751
bettina.scarlatti@yahoo.it	1003
bettina.scarlatti@yahoo.it	1628
bettina.scarlatti@yahoo.it	611
bettina.scarlatti@yahoo.it	1382
bettina.scarlatti@yahoo.it	129
bettina.scarlatti@yahoo.it	1813
bettina.scarlatti@yahoo.it	66
bettina.scarlatti@yahoo.it	478
bettina.scarlatti@yahoo.it	2395
bettina.scarlatti@yahoo.it	962
bettina.scarlatti@yahoo.it	1076
bettina.scarlatti@yahoo.it	1299
bettina.scarlatti@yahoo.it	2828
bettina.scarlatti@yahoo.it	1795
bettina.scarlatti@yahoo.it	1669
bettina.scarlatti@yahoo.it	2505
bettina.scarlatti@yahoo.it	2559
bettina.scarlatti@yahoo.it	1945
bettina.scarlatti@yahoo.it	552
bettina.scarlatti@yahoo.it	964
bettina.scarlatti@yahoo.it	665
bettina.scarlatti@yahoo.it	2352
bettina.scarlatti@yahoo.it	190
bettina.scarlatti@yahoo.it	1745
bettina.scarlatti@yahoo.it	1309
bettina.scarlatti@yahoo.it	902
bettina.scarlatti@yahoo.it	510
bettina.scarlatti@yahoo.it	2377
bettina.scarlatti@yahoo.it	362
bettina.scarlatti@yahoo.it	1877
bettina.scarlatti@yahoo.it	2567
bettina.scarlatti@yahoo.it	2015
bettina.scarlatti@yahoo.it	2109
bettina.scarlatti@yahoo.it	130
bettina.scarlatti@yahoo.it	124
bettina.scarlatti@yahoo.it	1447
bettina.scarlatti@yahoo.it	222
bettina.scarlatti@yahoo.it	2144
bettina.scarlatti@yahoo.it	2146
bettina.scarlatti@yahoo.it	2155
bettina.scarlatti@yahoo.it	1759
bettina.scarlatti@yahoo.it	2589
bettina.scarlatti@yahoo.it	721
bettina.scarlatti@yahoo.it	2793
bettina.scarlatti@yahoo.it	988
bettina.scarlatti@yahoo.it	2790
bettina.scarlatti@yahoo.it	2259
bettina.scarlatti@yahoo.it	2296
bettina.scarlatti@yahoo.it	2123
bettina.scarlatti@yahoo.it	2031
bettina.scarlatti@yahoo.it	2557
bettina.scarlatti@yahoo.it	1432
bettina.scarlatti@yahoo.it	1189
bettina.scarlatti@yahoo.it	1639
bettina.scarlatti@yahoo.it	1667
bettina.scarlatti@yahoo.it	1167
bettina.scarlatti@yahoo.it	2233
bettina.scarlatti@yahoo.it	1603
bettina.scarlatti@yahoo.it	827
bettina.scarlatti@yahoo.it	2758
bettina.scarlatti@yahoo.it	850
bettina.scarlatti@yahoo.it	648
bettina.scarlatti@yahoo.it	1285
bettina.scarlatti@yahoo.it	2604
gianfranco.angiolello@yahoo.it	653
gianfranco.angiolello@yahoo.it	652
gianfranco.angiolello@yahoo.it	1072
gianfranco.angiolello@yahoo.it	2506
gianfranco.angiolello@yahoo.it	2194
gianfranco.angiolello@yahoo.it	2549
gianfranco.angiolello@yahoo.it	124
gianfranco.angiolello@yahoo.it	707
gianfranco.angiolello@yahoo.it	2344
gianfranco.angiolello@yahoo.it	814
gianfranco.angiolello@yahoo.it	416
gianfranco.angiolello@yahoo.it	840
gianfranco.angiolello@yahoo.it	2151
gianfranco.angiolello@yahoo.it	2386
gianfranco.angiolello@yahoo.it	1417
gianfranco.angiolello@yahoo.it	160
gianfranco.angiolello@yahoo.it	2818
gianfranco.angiolello@yahoo.it	820
gianfranco.angiolello@yahoo.it	1679
gianfranco.angiolello@yahoo.it	1053
gianfranco.angiolello@yahoo.it	393
gianfranco.angiolello@yahoo.it	632
gianfranco.angiolello@yahoo.it	1512
gianfranco.angiolello@yahoo.it	566
gianfranco.angiolello@yahoo.it	449
gianfranco.angiolello@yahoo.it	395
gianfranco.angiolello@yahoo.it	512
gianfranco.angiolello@yahoo.it	628
gianfranco.angiolello@yahoo.it	1593
gianfranco.angiolello@yahoo.it	597
gianfranco.angiolello@yahoo.it	2660
gianfranco.angiolello@yahoo.it	2479
gianfranco.angiolello@yahoo.it	439
gianfranco.angiolello@yahoo.it	1406
gianfranco.angiolello@yahoo.it	729
gianfranco.angiolello@yahoo.it	1019
gianfranco.angiolello@yahoo.it	441
gianfranco.angiolello@yahoo.it	104
gianfranco.angiolello@yahoo.it	1959
gianfranco.angiolello@yahoo.it	312
gianfranco.angiolello@yahoo.it	2109
gianfranco.angiolello@yahoo.it	1278
gianfranco.angiolello@yahoo.it	1281
gianfranco.angiolello@yahoo.it	1188
gianfranco.angiolello@yahoo.it	137
gianfranco.angiolello@yahoo.it	2172
gianfranco.angiolello@yahoo.it	1704
gianfranco.angiolello@yahoo.it	1316
gianfranco.angiolello@yahoo.it	168
gianfranco.angiolello@yahoo.it	575
gianfranco.angiolello@yahoo.it	2465
gianfranco.angiolello@yahoo.it	896
gianfranco.angiolello@yahoo.it	2458
gianfranco.angiolello@yahoo.it	651
gianfranco.angiolello@yahoo.it	2472
gianfranco.angiolello@yahoo.it	579
gianfranco.angiolello@yahoo.it	2320
gianfranco.angiolello@yahoo.it	1793
gianfranco.angiolello@yahoo.it	146
gianfranco.angiolello@yahoo.it	1295
gianfranco.angiolello@yahoo.it	1640
gianfranco.angiolello@yahoo.it	496
gianfranco.angiolello@yahoo.it	2283
gianfranco.angiolello@yahoo.it	1250
gianfranco.angiolello@yahoo.it	2000
gianfranco.angiolello@yahoo.it	1222
gianfranco.angiolello@yahoo.it	2545
gianfranco.angiolello@yahoo.it	2507
gianfranco.angiolello@yahoo.it	1536
gianfranco.angiolello@yahoo.it	1895
gianfranco.angiolello@yahoo.it	119
gianfranco.angiolello@yahoo.it	935
gianfranco.angiolello@yahoo.it	1307
gianfranco.angiolello@yahoo.it	1116
gianfranco.angiolello@yahoo.it	2483
gianfranco.angiolello@yahoo.it	2415
gianfranco.angiolello@yahoo.it	748
gianfranco.angiolello@yahoo.it	108
gianfranco.angiolello@yahoo.it	1649
gianfranco.angiolello@yahoo.it	1713
gianfranco.angiolello@yahoo.it	1799
gianfranco.angiolello@yahoo.it	1098
gianfranco.angiolello@yahoo.it	1662
gianfranco.angiolello@yahoo.it	2405
gianfranco.angiolello@yahoo.it	1684
gianfranco.angiolello@yahoo.it	456
gianfranco.angiolello@yahoo.it	2115
gianfranco.angiolello@yahoo.it	1103
gianfranco.angiolello@yahoo.it	2537
gianfranco.angiolello@yahoo.it	2103
gianfranco.angiolello@yahoo.it	1179
gianfranco.angiolello@yahoo.it	815
gianfranco.angiolello@yahoo.it	1118
gianfranco.angiolello@yahoo.it	535
gianfranco.angiolello@yahoo.it	1431
gianfranco.angiolello@yahoo.it	2526
gianfranco.angiolello@yahoo.it	677
gianfranco.angiolello@yahoo.it	2705
gianfranco.angiolello@yahoo.it	1477
gianfranco.angiolello@yahoo.it	2539
antonia.ramazzotti@hotmail.com	2399
antonia.ramazzotti@hotmail.com	1956
antonia.ramazzotti@hotmail.com	1595
antonia.ramazzotti@hotmail.com	267
antonia.ramazzotti@hotmail.com	1032
antonia.ramazzotti@hotmail.com	326
antonia.ramazzotti@hotmail.com	2617
antonia.ramazzotti@hotmail.com	28
antonia.ramazzotti@hotmail.com	247
antonia.ramazzotti@hotmail.com	1247
antonia.ramazzotti@hotmail.com	826
antonia.ramazzotti@hotmail.com	1303
antonia.ramazzotti@hotmail.com	345
antonia.ramazzotti@hotmail.com	918
antonia.ramazzotti@hotmail.com	1930
antonia.ramazzotti@hotmail.com	1936
antonia.ramazzotti@hotmail.com	486
antonia.ramazzotti@hotmail.com	820
antonia.ramazzotti@hotmail.com	1482
antonia.ramazzotti@hotmail.com	162
antonia.ramazzotti@hotmail.com	1739
antonia.ramazzotti@hotmail.com	2330
antonia.ramazzotti@hotmail.com	1887
antonia.ramazzotti@hotmail.com	831
antonia.ramazzotti@hotmail.com	1662
antonia.ramazzotti@hotmail.com	1704
antonia.ramazzotti@hotmail.com	100
antonia.ramazzotti@hotmail.com	2281
antonia.ramazzotti@hotmail.com	2212
antonia.ramazzotti@hotmail.com	1201
antonia.ramazzotti@hotmail.com	2578
antonia.ramazzotti@hotmail.com	2731
antonia.ramazzotti@hotmail.com	2397
antonia.ramazzotti@hotmail.com	74
antonia.ramazzotti@hotmail.com	653
antonia.ramazzotti@hotmail.com	51
antonia.ramazzotti@hotmail.com	2676
antonia.ramazzotti@hotmail.com	2091
antonia.ramazzotti@hotmail.com	2419
antonia.ramazzotti@hotmail.com	1493
antonia.ramazzotti@hotmail.com	1003
antonia.ramazzotti@hotmail.com	917
antonia.ramazzotti@hotmail.com	2197
antonia.ramazzotti@hotmail.com	2078
antonia.ramazzotti@hotmail.com	2681
antonia.ramazzotti@hotmail.com	1159
antonia.ramazzotti@hotmail.com	119
antonia.ramazzotti@hotmail.com	853
antonia.ramazzotti@hotmail.com	806
antonia.ramazzotti@hotmail.com	2812
antonia.ramazzotti@hotmail.com	1276
antonia.ramazzotti@hotmail.com	2069
antonia.ramazzotti@hotmail.com	2644
antonia.ramazzotti@hotmail.com	1707
antonia.ramazzotti@hotmail.com	1894
antonia.ramazzotti@hotmail.com	2547
antonia.ramazzotti@hotmail.com	1705
antonia.ramazzotti@hotmail.com	2167
antonia.ramazzotti@hotmail.com	900
antonia.ramazzotti@hotmail.com	1048
antonia.ramazzotti@hotmail.com	714
antonia.ramazzotti@hotmail.com	2467
antonia.ramazzotti@hotmail.com	2390
antonia.ramazzotti@hotmail.com	2049
antonia.ramazzotti@hotmail.com	2215
antonia.ramazzotti@hotmail.com	2493
antonia.ramazzotti@hotmail.com	604
antonia.ramazzotti@hotmail.com	2525
antonia.ramazzotti@hotmail.com	1177
antonia.ramazzotti@hotmail.com	415
antonia.ramazzotti@hotmail.com	648
antonia.ramazzotti@hotmail.com	335
antonia.ramazzotti@hotmail.com	2510
antonia.ramazzotti@hotmail.com	2058
antonia.ramazzotti@hotmail.com	1290
antonia.ramazzotti@hotmail.com	232
antonia.ramazzotti@hotmail.com	2188
antonia.ramazzotti@hotmail.com	2723
antonia.ramazzotti@hotmail.com	1075
antonia.ramazzotti@hotmail.com	405
antonia.ramazzotti@hotmail.com	973
antonia.ramazzotti@hotmail.com	1036
antonia.ramazzotti@hotmail.com	2300
antonia.ramazzotti@hotmail.com	2129
antonia.ramazzotti@hotmail.com	457
antonia.ramazzotti@hotmail.com	507
antonia.ramazzotti@hotmail.com	1627
antonia.ramazzotti@hotmail.com	36
antonia.ramazzotti@hotmail.com	338
antonia.ramazzotti@hotmail.com	1103
antonia.ramazzotti@hotmail.com	1613
antonia.ramazzotti@hotmail.com	2242
antonia.ramazzotti@hotmail.com	393
antonia.ramazzotti@hotmail.com	2096
antonia.ramazzotti@hotmail.com	1746
antonia.ramazzotti@hotmail.com	499
antonia.ramazzotti@hotmail.com	694
antonia.ramazzotti@hotmail.com	1573
antonia.ramazzotti@hotmail.com	606
antonia.ramazzotti@hotmail.com	2084
luigi.borgia@virgilio.it	1626
luigi.borgia@virgilio.it	899
luigi.borgia@virgilio.it	448
luigi.borgia@virgilio.it	1534
luigi.borgia@virgilio.it	1069
luigi.borgia@virgilio.it	2646
luigi.borgia@virgilio.it	1914
luigi.borgia@virgilio.it	2029
luigi.borgia@virgilio.it	1744
luigi.borgia@virgilio.it	2425
luigi.borgia@virgilio.it	2711
luigi.borgia@virgilio.it	152
luigi.borgia@virgilio.it	194
luigi.borgia@virgilio.it	893
luigi.borgia@virgilio.it	2377
luigi.borgia@virgilio.it	1835
luigi.borgia@virgilio.it	102
luigi.borgia@virgilio.it	662
luigi.borgia@virgilio.it	229
luigi.borgia@virgilio.it	441
luigi.borgia@virgilio.it	1783
luigi.borgia@virgilio.it	304
luigi.borgia@virgilio.it	837
luigi.borgia@virgilio.it	1041
luigi.borgia@virgilio.it	237
luigi.borgia@virgilio.it	472
luigi.borgia@virgilio.it	1476
luigi.borgia@virgilio.it	16
luigi.borgia@virgilio.it	1969
luigi.borgia@virgilio.it	1175
luigi.borgia@virgilio.it	1839
luigi.borgia@virgilio.it	1454
luigi.borgia@virgilio.it	991
luigi.borgia@virgilio.it	1664
luigi.borgia@virgilio.it	952
luigi.borgia@virgilio.it	281
luigi.borgia@virgilio.it	2297
luigi.borgia@virgilio.it	1846
luigi.borgia@virgilio.it	1009
luigi.borgia@virgilio.it	215
luigi.borgia@virgilio.it	2563
luigi.borgia@virgilio.it	2146
luigi.borgia@virgilio.it	2840
luigi.borgia@virgilio.it	461
luigi.borgia@virgilio.it	885
luigi.borgia@virgilio.it	2212
luigi.borgia@virgilio.it	924
luigi.borgia@virgilio.it	2085
luigi.borgia@virgilio.it	606
luigi.borgia@virgilio.it	354
luigi.borgia@virgilio.it	2326
luigi.borgia@virgilio.it	2568
luigi.borgia@virgilio.it	1798
luigi.borgia@virgilio.it	2642
luigi.borgia@virgilio.it	2125
luigi.borgia@virgilio.it	637
luigi.borgia@virgilio.it	1050
luigi.borgia@virgilio.it	2521
luigi.borgia@virgilio.it	1408
luigi.borgia@virgilio.it	1303
luigi.borgia@virgilio.it	601
luigi.borgia@virgilio.it	1503
luigi.borgia@virgilio.it	232
luigi.borgia@virgilio.it	593
luigi.borgia@virgilio.it	2321
luigi.borgia@virgilio.it	740
luigi.borgia@virgilio.it	1209
luigi.borgia@virgilio.it	2480
luigi.borgia@virgilio.it	269
luigi.borgia@virgilio.it	2619
luigi.borgia@virgilio.it	940
luigi.borgia@virgilio.it	2478
luigi.borgia@virgilio.it	1556
luigi.borgia@virgilio.it	2513
luigi.borgia@virgilio.it	2190
luigi.borgia@virgilio.it	2645
luigi.borgia@virgilio.it	2276
luigi.borgia@virgilio.it	1372
luigi.borgia@virgilio.it	610
luigi.borgia@virgilio.it	1371
luigi.borgia@virgilio.it	944
luigi.borgia@virgilio.it	492
luigi.borgia@virgilio.it	1071
luigi.borgia@virgilio.it	326
luigi.borgia@virgilio.it	1265
luigi.borgia@virgilio.it	236
luigi.borgia@virgilio.it	2564
luigi.borgia@virgilio.it	2328
luigi.borgia@virgilio.it	226
luigi.borgia@virgilio.it	14
luigi.borgia@virgilio.it	1445
luigi.borgia@virgilio.it	935
luigi.borgia@virgilio.it	866
luigi.borgia@virgilio.it	743
luigi.borgia@virgilio.it	2606
luigi.borgia@virgilio.it	1939
luigi.borgia@virgilio.it	340
luigi.borgia@virgilio.it	227
luigi.borgia@virgilio.it	286
luigi.borgia@virgilio.it	1828
paoletta.pirandello@yahoo.it	252
paoletta.pirandello@yahoo.it	1038
paoletta.pirandello@yahoo.it	388
paoletta.pirandello@yahoo.it	2097
paoletta.pirandello@yahoo.it	1810
paoletta.pirandello@yahoo.it	2466
paoletta.pirandello@yahoo.it	1725
paoletta.pirandello@yahoo.it	281
paoletta.pirandello@yahoo.it	1572
paoletta.pirandello@yahoo.it	1288
paoletta.pirandello@yahoo.it	2123
paoletta.pirandello@yahoo.it	288
paoletta.pirandello@yahoo.it	642
paoletta.pirandello@yahoo.it	1978
paoletta.pirandello@yahoo.it	876
paoletta.pirandello@yahoo.it	1231
paoletta.pirandello@yahoo.it	2387
paoletta.pirandello@yahoo.it	2775
paoletta.pirandello@yahoo.it	1837
paoletta.pirandello@yahoo.it	749
paoletta.pirandello@yahoo.it	1290
paoletta.pirandello@yahoo.it	1
paoletta.pirandello@yahoo.it	2753
paoletta.pirandello@yahoo.it	913
paoletta.pirandello@yahoo.it	462
paoletta.pirandello@yahoo.it	2801
paoletta.pirandello@yahoo.it	487
paoletta.pirandello@yahoo.it	601
paoletta.pirandello@yahoo.it	1785
paoletta.pirandello@yahoo.it	46
paoletta.pirandello@yahoo.it	378
paoletta.pirandello@yahoo.it	2525
paoletta.pirandello@yahoo.it	362
paoletta.pirandello@yahoo.it	1834
paoletta.pirandello@yahoo.it	492
paoletta.pirandello@yahoo.it	451
paoletta.pirandello@yahoo.it	171
paoletta.pirandello@yahoo.it	2394
paoletta.pirandello@yahoo.it	497
paoletta.pirandello@yahoo.it	2615
paoletta.pirandello@yahoo.it	1270
paoletta.pirandello@yahoo.it	2483
paoletta.pirandello@yahoo.it	2590
paoletta.pirandello@yahoo.it	896
paoletta.pirandello@yahoo.it	1938
paoletta.pirandello@yahoo.it	1107
paoletta.pirandello@yahoo.it	1909
paoletta.pirandello@yahoo.it	2575
paoletta.pirandello@yahoo.it	2583
paoletta.pirandello@yahoo.it	807
paoletta.pirandello@yahoo.it	2423
paoletta.pirandello@yahoo.it	207
paoletta.pirandello@yahoo.it	746
paoletta.pirandello@yahoo.it	1383
paoletta.pirandello@yahoo.it	318
paoletta.pirandello@yahoo.it	2585
paoletta.pirandello@yahoo.it	1214
paoletta.pirandello@yahoo.it	1250
paoletta.pirandello@yahoo.it	1584
paoletta.pirandello@yahoo.it	627
paoletta.pirandello@yahoo.it	303
paoletta.pirandello@yahoo.it	2561
paoletta.pirandello@yahoo.it	2551
paoletta.pirandello@yahoo.it	1024
paoletta.pirandello@yahoo.it	1159
paoletta.pirandello@yahoo.it	109
paoletta.pirandello@yahoo.it	2858
paoletta.pirandello@yahoo.it	735
paoletta.pirandello@yahoo.it	1104
paoletta.pirandello@yahoo.it	72
paoletta.pirandello@yahoo.it	2395
paoletta.pirandello@yahoo.it	1946
paoletta.pirandello@yahoo.it	2600
paoletta.pirandello@yahoo.it	1306
paoletta.pirandello@yahoo.it	2533
paoletta.pirandello@yahoo.it	2187
paoletta.pirandello@yahoo.it	973
paoletta.pirandello@yahoo.it	177
paoletta.pirandello@yahoo.it	1437
paoletta.pirandello@yahoo.it	951
paoletta.pirandello@yahoo.it	1072
paoletta.pirandello@yahoo.it	718
paoletta.pirandello@yahoo.it	2186
paoletta.pirandello@yahoo.it	1993
paoletta.pirandello@yahoo.it	1476
paoletta.pirandello@yahoo.it	2353
paoletta.pirandello@yahoo.it	120
paoletta.pirandello@yahoo.it	2816
paoletta.pirandello@yahoo.it	300
paoletta.pirandello@yahoo.it	1539
paoletta.pirandello@yahoo.it	1603
paoletta.pirandello@yahoo.it	804
paoletta.pirandello@yahoo.it	1997
paoletta.pirandello@yahoo.it	599
paoletta.pirandello@yahoo.it	1035
paoletta.pirandello@yahoo.it	1312
paoletta.pirandello@yahoo.it	1233
paoletta.pirandello@yahoo.it	2574
paoletta.pirandello@yahoo.it	872
paoletta.pirandello@yahoo.it	1505
ivan.fantozzi@virgilio.it	2661
ivan.fantozzi@virgilio.it	1676
ivan.fantozzi@virgilio.it	1658
ivan.fantozzi@virgilio.it	2174
ivan.fantozzi@virgilio.it	613
ivan.fantozzi@virgilio.it	1914
ivan.fantozzi@virgilio.it	324
ivan.fantozzi@virgilio.it	1594
ivan.fantozzi@virgilio.it	2763
ivan.fantozzi@virgilio.it	248
ivan.fantozzi@virgilio.it	2822
ivan.fantozzi@virgilio.it	203
ivan.fantozzi@virgilio.it	732
ivan.fantozzi@virgilio.it	1746
ivan.fantozzi@virgilio.it	27
ivan.fantozzi@virgilio.it	666
ivan.fantozzi@virgilio.it	1703
ivan.fantozzi@virgilio.it	2443
ivan.fantozzi@virgilio.it	2213
ivan.fantozzi@virgilio.it	2426
ivan.fantozzi@virgilio.it	2197
ivan.fantozzi@virgilio.it	2204
ivan.fantozzi@virgilio.it	222
ivan.fantozzi@virgilio.it	2011
ivan.fantozzi@virgilio.it	1646
ivan.fantozzi@virgilio.it	2686
ivan.fantozzi@virgilio.it	1152
ivan.fantozzi@virgilio.it	829
ivan.fantozzi@virgilio.it	1980
ivan.fantozzi@virgilio.it	2557
ivan.fantozzi@virgilio.it	1426
ivan.fantozzi@virgilio.it	2141
ivan.fantozzi@virgilio.it	2134
ivan.fantozzi@virgilio.it	933
ivan.fantozzi@virgilio.it	2039
ivan.fantozzi@virgilio.it	2669
ivan.fantozzi@virgilio.it	2554
ivan.fantozzi@virgilio.it	687
ivan.fantozzi@virgilio.it	2195
ivan.fantozzi@virgilio.it	1844
ivan.fantozzi@virgilio.it	2431
ivan.fantozzi@virgilio.it	2547
ivan.fantozzi@virgilio.it	1406
ivan.fantozzi@virgilio.it	2362
ivan.fantozzi@virgilio.it	1862
ivan.fantozzi@virgilio.it	2634
ivan.fantozzi@virgilio.it	875
ivan.fantozzi@virgilio.it	2264
ivan.fantozzi@virgilio.it	132
ivan.fantozzi@virgilio.it	2573
ivan.fantozzi@virgilio.it	377
ivan.fantozzi@virgilio.it	1109
ivan.fantozzi@virgilio.it	403
ivan.fantozzi@virgilio.it	1113
ivan.fantozzi@virgilio.it	1134
ivan.fantozzi@virgilio.it	1474
ivan.fantozzi@virgilio.it	844
ivan.fantozzi@virgilio.it	518
ivan.fantozzi@virgilio.it	347
ivan.fantozzi@virgilio.it	2215
ivan.fantozzi@virgilio.it	1810
ivan.fantozzi@virgilio.it	184
ivan.fantozzi@virgilio.it	889
ivan.fantozzi@virgilio.it	675
ivan.fantozzi@virgilio.it	2352
ivan.fantozzi@virgilio.it	1160
ivan.fantozzi@virgilio.it	517
ivan.fantozzi@virgilio.it	358
ivan.fantozzi@virgilio.it	599
ivan.fantozzi@virgilio.it	2471
ivan.fantozzi@virgilio.it	2358
ivan.fantozzi@virgilio.it	1568
ivan.fantozzi@virgilio.it	1167
ivan.fantozzi@virgilio.it	1659
ivan.fantozzi@virgilio.it	2653
ivan.fantozzi@virgilio.it	1660
ivan.fantozzi@virgilio.it	1665
ivan.fantozzi@virgilio.it	1079
ivan.fantozzi@virgilio.it	2576
ivan.fantozzi@virgilio.it	47
ivan.fantozzi@virgilio.it	1277
ivan.fantozzi@virgilio.it	2510
ivan.fantozzi@virgilio.it	211
ivan.fantozzi@virgilio.it	2606
ivan.fantozzi@virgilio.it	765
ivan.fantozzi@virgilio.it	1941
ivan.fantozzi@virgilio.it	1535
ivan.fantozzi@virgilio.it	456
ivan.fantozzi@virgilio.it	2624
ivan.fantozzi@virgilio.it	616
ivan.fantozzi@virgilio.it	2146
ivan.fantozzi@virgilio.it	1999
ivan.fantozzi@virgilio.it	739
ivan.fantozzi@virgilio.it	1093
ivan.fantozzi@virgilio.it	846
ivan.fantozzi@virgilio.it	2114
ivan.fantozzi@virgilio.it	1782
ivan.fantozzi@virgilio.it	1989
ivan.fantozzi@virgilio.it	1416
ivan.fantozzi@virgilio.it	1905
jolanda.marenzio@virgilio.it	1452
jolanda.marenzio@virgilio.it	1211
jolanda.marenzio@virgilio.it	1853
jolanda.marenzio@virgilio.it	1183
jolanda.marenzio@virgilio.it	1820
jolanda.marenzio@virgilio.it	748
jolanda.marenzio@virgilio.it	2145
jolanda.marenzio@virgilio.it	1421
jolanda.marenzio@virgilio.it	2065
jolanda.marenzio@virgilio.it	8
jolanda.marenzio@virgilio.it	1508
jolanda.marenzio@virgilio.it	395
jolanda.marenzio@virgilio.it	1104
jolanda.marenzio@virgilio.it	486
jolanda.marenzio@virgilio.it	1959
jolanda.marenzio@virgilio.it	16
jolanda.marenzio@virgilio.it	127
jolanda.marenzio@virgilio.it	2474
jolanda.marenzio@virgilio.it	2324
jolanda.marenzio@virgilio.it	877
jolanda.marenzio@virgilio.it	2439
jolanda.marenzio@virgilio.it	1899
jolanda.marenzio@virgilio.it	1976
jolanda.marenzio@virgilio.it	303
jolanda.marenzio@virgilio.it	2167
jolanda.marenzio@virgilio.it	865
jolanda.marenzio@virgilio.it	1209
jolanda.marenzio@virgilio.it	2007
jolanda.marenzio@virgilio.it	1264
jolanda.marenzio@virgilio.it	1818
jolanda.marenzio@virgilio.it	2420
jolanda.marenzio@virgilio.it	2782
jolanda.marenzio@virgilio.it	135
jolanda.marenzio@virgilio.it	1254
jolanda.marenzio@virgilio.it	760
jolanda.marenzio@virgilio.it	2426
jolanda.marenzio@virgilio.it	294
jolanda.marenzio@virgilio.it	1797
jolanda.marenzio@virgilio.it	268
jolanda.marenzio@virgilio.it	1446
jolanda.marenzio@virgilio.it	2607
jolanda.marenzio@virgilio.it	1982
jolanda.marenzio@virgilio.it	1924
jolanda.marenzio@virgilio.it	2074
jolanda.marenzio@virgilio.it	1556
jolanda.marenzio@virgilio.it	1002
jolanda.marenzio@virgilio.it	139
jolanda.marenzio@virgilio.it	1559
jolanda.marenzio@virgilio.it	1055
jolanda.marenzio@virgilio.it	2410
jolanda.marenzio@virgilio.it	2134
jolanda.marenzio@virgilio.it	1027
jolanda.marenzio@virgilio.it	155
jolanda.marenzio@virgilio.it	2771
jolanda.marenzio@virgilio.it	2488
jolanda.marenzio@virgilio.it	866
jolanda.marenzio@virgilio.it	801
jolanda.marenzio@virgilio.it	2576
jolanda.marenzio@virgilio.it	1852
jolanda.marenzio@virgilio.it	695
jolanda.marenzio@virgilio.it	326
jolanda.marenzio@virgilio.it	552
jolanda.marenzio@virgilio.it	241
jolanda.marenzio@virgilio.it	1862
jolanda.marenzio@virgilio.it	2735
jolanda.marenzio@virgilio.it	1635
jolanda.marenzio@virgilio.it	285
jolanda.marenzio@virgilio.it	2294
jolanda.marenzio@virgilio.it	1969
jolanda.marenzio@virgilio.it	653
jolanda.marenzio@virgilio.it	1887
jolanda.marenzio@virgilio.it	642
jolanda.marenzio@virgilio.it	993
jolanda.marenzio@virgilio.it	759
jolanda.marenzio@virgilio.it	1786
jolanda.marenzio@virgilio.it	121
jolanda.marenzio@virgilio.it	1418
jolanda.marenzio@virgilio.it	1989
jolanda.marenzio@virgilio.it	1119
jolanda.marenzio@virgilio.it	700
jolanda.marenzio@virgilio.it	58
jolanda.marenzio@virgilio.it	82
jolanda.marenzio@virgilio.it	2638
jolanda.marenzio@virgilio.it	1084
jolanda.marenzio@virgilio.it	2306
jolanda.marenzio@virgilio.it	1470
jolanda.marenzio@virgilio.it	2347
jolanda.marenzio@virgilio.it	505
jolanda.marenzio@virgilio.it	2478
jolanda.marenzio@virgilio.it	843
jolanda.marenzio@virgilio.it	2565
jolanda.marenzio@virgilio.it	2339
jolanda.marenzio@virgilio.it	33
jolanda.marenzio@virgilio.it	954
jolanda.marenzio@virgilio.it	1273
jolanda.marenzio@virgilio.it	2577
jolanda.marenzio@virgilio.it	2774
jolanda.marenzio@virgilio.it	1240
jolanda.marenzio@virgilio.it	331
jolanda.marenzio@virgilio.it	167
arsenio.fagiani@virgilio.it	1734
arsenio.fagiani@virgilio.it	2503
arsenio.fagiani@virgilio.it	2147
arsenio.fagiani@virgilio.it	1221
arsenio.fagiani@virgilio.it	2284
arsenio.fagiani@virgilio.it	2358
arsenio.fagiani@virgilio.it	331
arsenio.fagiani@virgilio.it	194
arsenio.fagiani@virgilio.it	2761
arsenio.fagiani@virgilio.it	1883
arsenio.fagiani@virgilio.it	1262
arsenio.fagiani@virgilio.it	2509
arsenio.fagiani@virgilio.it	1240
arsenio.fagiani@virgilio.it	1583
arsenio.fagiani@virgilio.it	187
arsenio.fagiani@virgilio.it	239
arsenio.fagiani@virgilio.it	438
arsenio.fagiani@virgilio.it	512
arsenio.fagiani@virgilio.it	825
arsenio.fagiani@virgilio.it	216
arsenio.fagiani@virgilio.it	1998
arsenio.fagiani@virgilio.it	1810
arsenio.fagiani@virgilio.it	418
arsenio.fagiani@virgilio.it	515
arsenio.fagiani@virgilio.it	1475
arsenio.fagiani@virgilio.it	2433
arsenio.fagiani@virgilio.it	762
arsenio.fagiani@virgilio.it	1523
arsenio.fagiani@virgilio.it	197
arsenio.fagiani@virgilio.it	1287
arsenio.fagiani@virgilio.it	1793
arsenio.fagiani@virgilio.it	2620
arsenio.fagiani@virgilio.it	2712
arsenio.fagiani@virgilio.it	96
arsenio.fagiani@virgilio.it	2015
arsenio.fagiani@virgilio.it	2273
arsenio.fagiani@virgilio.it	1608
arsenio.fagiani@virgilio.it	272
arsenio.fagiani@virgilio.it	644
arsenio.fagiani@virgilio.it	2827
arsenio.fagiani@virgilio.it	1913
arsenio.fagiani@virgilio.it	1298
arsenio.fagiani@virgilio.it	2714
arsenio.fagiani@virgilio.it	2460
arsenio.fagiani@virgilio.it	2396
arsenio.fagiani@virgilio.it	443
arsenio.fagiani@virgilio.it	2078
arsenio.fagiani@virgilio.it	2131
arsenio.fagiani@virgilio.it	2406
arsenio.fagiani@virgilio.it	1708
arsenio.fagiani@virgilio.it	717
arsenio.fagiani@virgilio.it	779
arsenio.fagiani@virgilio.it	230
arsenio.fagiani@virgilio.it	922
arsenio.fagiani@virgilio.it	2475
arsenio.fagiani@virgilio.it	1040
arsenio.fagiani@virgilio.it	101
arsenio.fagiani@virgilio.it	329
arsenio.fagiani@virgilio.it	22
arsenio.fagiani@virgilio.it	2769
arsenio.fagiani@virgilio.it	1939
arsenio.fagiani@virgilio.it	2629
arsenio.fagiani@virgilio.it	1478
arsenio.fagiani@virgilio.it	286
arsenio.fagiani@virgilio.it	1488
arsenio.fagiani@virgilio.it	2485
arsenio.fagiani@virgilio.it	1541
arsenio.fagiani@virgilio.it	372
arsenio.fagiani@virgilio.it	2456
arsenio.fagiani@virgilio.it	366
arsenio.fagiani@virgilio.it	2249
arsenio.fagiani@virgilio.it	2568
arsenio.fagiani@virgilio.it	1990
arsenio.fagiani@virgilio.it	2391
arsenio.fagiani@virgilio.it	225
arsenio.fagiani@virgilio.it	1029
arsenio.fagiani@virgilio.it	2600
arsenio.fagiani@virgilio.it	2412
arsenio.fagiani@virgilio.it	520
arsenio.fagiani@virgilio.it	1039
arsenio.fagiani@virgilio.it	988
arsenio.fagiani@virgilio.it	1310
arsenio.fagiani@virgilio.it	681
arsenio.fagiani@virgilio.it	2705
arsenio.fagiani@virgilio.it	853
arsenio.fagiani@virgilio.it	1016
arsenio.fagiani@virgilio.it	52
arsenio.fagiani@virgilio.it	1267
arsenio.fagiani@virgilio.it	829
arsenio.fagiani@virgilio.it	157
arsenio.fagiani@virgilio.it	1264
arsenio.fagiani@virgilio.it	1911
arsenio.fagiani@virgilio.it	2416
arsenio.fagiani@virgilio.it	694
arsenio.fagiani@virgilio.it	2382
arsenio.fagiani@virgilio.it	69
arsenio.fagiani@virgilio.it	773
arsenio.fagiani@virgilio.it	458
arsenio.fagiani@virgilio.it	2849
arsenio.fagiani@virgilio.it	1686
elena.cortese@virgilio.it	805
elena.cortese@virgilio.it	155
elena.cortese@virgilio.it	540
elena.cortese@virgilio.it	652
elena.cortese@virgilio.it	1874
elena.cortese@virgilio.it	2569
elena.cortese@virgilio.it	162
elena.cortese@virgilio.it	1482
elena.cortese@virgilio.it	2021
elena.cortese@virgilio.it	289
elena.cortese@virgilio.it	2428
elena.cortese@virgilio.it	2346
elena.cortese@virgilio.it	1663
elena.cortese@virgilio.it	2464
elena.cortese@virgilio.it	2309
elena.cortese@virgilio.it	1275
elena.cortese@virgilio.it	2131
elena.cortese@virgilio.it	1983
elena.cortese@virgilio.it	1454
elena.cortese@virgilio.it	2584
elena.cortese@virgilio.it	2023
elena.cortese@virgilio.it	1447
elena.cortese@virgilio.it	2842
elena.cortese@virgilio.it	895
elena.cortese@virgilio.it	2201
elena.cortese@virgilio.it	789
elena.cortese@virgilio.it	2790
elena.cortese@virgilio.it	2624
elena.cortese@virgilio.it	2793
elena.cortese@virgilio.it	1885
elena.cortese@virgilio.it	1579
elena.cortese@virgilio.it	2399
elena.cortese@virgilio.it	1621
elena.cortese@virgilio.it	2394
elena.cortese@virgilio.it	2833
elena.cortese@virgilio.it	1079
elena.cortese@virgilio.it	2086
elena.cortese@virgilio.it	2258
elena.cortese@virgilio.it	825
elena.cortese@virgilio.it	1934
elena.cortese@virgilio.it	1523
elena.cortese@virgilio.it	2601
elena.cortese@virgilio.it	2121
elena.cortese@virgilio.it	2064
elena.cortese@virgilio.it	1761
elena.cortese@virgilio.it	2248
elena.cortese@virgilio.it	2057
elena.cortese@virgilio.it	2627
elena.cortese@virgilio.it	642
elena.cortese@virgilio.it	2198
elena.cortese@virgilio.it	1559
elena.cortese@virgilio.it	158
elena.cortese@virgilio.it	125
elena.cortese@virgilio.it	2769
elena.cortese@virgilio.it	600
elena.cortese@virgilio.it	1787
elena.cortese@virgilio.it	569
elena.cortese@virgilio.it	2822
elena.cortese@virgilio.it	2762
elena.cortese@virgilio.it	2335
elena.cortese@virgilio.it	1524
elena.cortese@virgilio.it	268
elena.cortese@virgilio.it	773
elena.cortese@virgilio.it	1629
elena.cortese@virgilio.it	2446
elena.cortese@virgilio.it	1916
elena.cortese@virgilio.it	566
elena.cortese@virgilio.it	1910
elena.cortese@virgilio.it	1545
elena.cortese@virgilio.it	437
elena.cortese@virgilio.it	1697
elena.cortese@virgilio.it	1177
elena.cortese@virgilio.it	1167
elena.cortese@virgilio.it	2274
elena.cortese@virgilio.it	784
elena.cortese@virgilio.it	2742
elena.cortese@virgilio.it	2582
elena.cortese@virgilio.it	1507
elena.cortese@virgilio.it	1304
elena.cortese@virgilio.it	1969
elena.cortese@virgilio.it	2350
elena.cortese@virgilio.it	962
elena.cortese@virgilio.it	114
elena.cortese@virgilio.it	2300
elena.cortese@virgilio.it	2436
elena.cortese@virgilio.it	2583
elena.cortese@virgilio.it	1136
elena.cortese@virgilio.it	248
elena.cortese@virgilio.it	436
elena.cortese@virgilio.it	827
elena.cortese@virgilio.it	2074
elena.cortese@virgilio.it	2395
elena.cortese@virgilio.it	732
elena.cortese@virgilio.it	2050
elena.cortese@virgilio.it	489
elena.cortese@virgilio.it	229
elena.cortese@virgilio.it	2352
elena.cortese@virgilio.it	993
elena.cortese@virgilio.it	275
elena.cortese@virgilio.it	824
salvatore.togliatti@virgilio.it	2782
salvatore.togliatti@virgilio.it	1744
salvatore.togliatti@virgilio.it	344
salvatore.togliatti@virgilio.it	1012
salvatore.togliatti@virgilio.it	2139
salvatore.togliatti@virgilio.it	268
salvatore.togliatti@virgilio.it	2421
salvatore.togliatti@virgilio.it	988
salvatore.togliatti@virgilio.it	258
salvatore.togliatti@virgilio.it	2295
salvatore.togliatti@virgilio.it	164
salvatore.togliatti@virgilio.it	1601
salvatore.togliatti@virgilio.it	960
salvatore.togliatti@virgilio.it	791
salvatore.togliatti@virgilio.it	1377
salvatore.togliatti@virgilio.it	2464
salvatore.togliatti@virgilio.it	389
salvatore.togliatti@virgilio.it	647
salvatore.togliatti@virgilio.it	1792
salvatore.togliatti@virgilio.it	2665
salvatore.togliatti@virgilio.it	188
salvatore.togliatti@virgilio.it	1696
salvatore.togliatti@virgilio.it	1573
salvatore.togliatti@virgilio.it	961
salvatore.togliatti@virgilio.it	2484
salvatore.togliatti@virgilio.it	2614
salvatore.togliatti@virgilio.it	1234
salvatore.togliatti@virgilio.it	2487
salvatore.togliatti@virgilio.it	901
salvatore.togliatti@virgilio.it	1290
salvatore.togliatti@virgilio.it	2007
salvatore.togliatti@virgilio.it	866
salvatore.togliatti@virgilio.it	2544
salvatore.togliatti@virgilio.it	1227
salvatore.togliatti@virgilio.it	1262
salvatore.togliatti@virgilio.it	707
salvatore.togliatti@virgilio.it	1274
salvatore.togliatti@virgilio.it	2475
salvatore.togliatti@virgilio.it	3
salvatore.togliatti@virgilio.it	2393
salvatore.togliatti@virgilio.it	424
salvatore.togliatti@virgilio.it	2122
salvatore.togliatti@virgilio.it	1418
salvatore.togliatti@virgilio.it	2401
salvatore.togliatti@virgilio.it	1179
salvatore.togliatti@virgilio.it	829
salvatore.togliatti@virgilio.it	2769
salvatore.togliatti@virgilio.it	1032
salvatore.togliatti@virgilio.it	1925
salvatore.togliatti@virgilio.it	1276
salvatore.togliatti@virgilio.it	2766
salvatore.togliatti@virgilio.it	899
salvatore.togliatti@virgilio.it	2804
salvatore.togliatti@virgilio.it	403
salvatore.togliatti@virgilio.it	2081
salvatore.togliatti@virgilio.it	2253
salvatore.togliatti@virgilio.it	2856
salvatore.togliatti@virgilio.it	1014
salvatore.togliatti@virgilio.it	955
salvatore.togliatti@virgilio.it	2413
salvatore.togliatti@virgilio.it	1896
salvatore.togliatti@virgilio.it	1170
salvatore.togliatti@virgilio.it	2560
salvatore.togliatti@virgilio.it	21
salvatore.togliatti@virgilio.it	770
salvatore.togliatti@virgilio.it	20
salvatore.togliatti@virgilio.it	1429
salvatore.togliatti@virgilio.it	2440
salvatore.togliatti@virgilio.it	2790
salvatore.togliatti@virgilio.it	296
salvatore.togliatti@virgilio.it	2642
salvatore.togliatti@virgilio.it	521
salvatore.togliatti@virgilio.it	1309
salvatore.togliatti@virgilio.it	970
salvatore.togliatti@virgilio.it	248
salvatore.togliatti@virgilio.it	77
salvatore.togliatti@virgilio.it	295
salvatore.togliatti@virgilio.it	1762
salvatore.togliatti@virgilio.it	2608
salvatore.togliatti@virgilio.it	1781
salvatore.togliatti@virgilio.it	873
salvatore.togliatti@virgilio.it	1985
salvatore.togliatti@virgilio.it	2069
salvatore.togliatti@virgilio.it	999
salvatore.togliatti@virgilio.it	2780
salvatore.togliatti@virgilio.it	2833
salvatore.togliatti@virgilio.it	2155
salvatore.togliatti@virgilio.it	2286
salvatore.togliatti@virgilio.it	839
salvatore.togliatti@virgilio.it	2696
salvatore.togliatti@virgilio.it	1515
salvatore.togliatti@virgilio.it	1877
salvatore.togliatti@virgilio.it	737
salvatore.togliatti@virgilio.it	1670
salvatore.togliatti@virgilio.it	1107
salvatore.togliatti@virgilio.it	1652
salvatore.togliatti@virgilio.it	2142
salvatore.togliatti@virgilio.it	2224
salvatore.togliatti@virgilio.it	16
salvatore.togliatti@virgilio.it	2446
dante.chiesa@libero.it	1451
dante.chiesa@libero.it	2234
dante.chiesa@libero.it	1864
dante.chiesa@libero.it	777
dante.chiesa@libero.it	1113
dante.chiesa@libero.it	1445
dante.chiesa@libero.it	237
dante.chiesa@libero.it	627
dante.chiesa@libero.it	689
dante.chiesa@libero.it	2699
dante.chiesa@libero.it	2346
dante.chiesa@libero.it	1378
dante.chiesa@libero.it	2084
dante.chiesa@libero.it	971
dante.chiesa@libero.it	2160
dante.chiesa@libero.it	1246
dante.chiesa@libero.it	1711
dante.chiesa@libero.it	1661
dante.chiesa@libero.it	760
dante.chiesa@libero.it	492
dante.chiesa@libero.it	816
dante.chiesa@libero.it	1529
dante.chiesa@libero.it	1550
dante.chiesa@libero.it	1142
dante.chiesa@libero.it	1114
dante.chiesa@libero.it	2381
dante.chiesa@libero.it	2483
dante.chiesa@libero.it	660
dante.chiesa@libero.it	2187
dante.chiesa@libero.it	2298
dante.chiesa@libero.it	2265
dante.chiesa@libero.it	60
dante.chiesa@libero.it	31
dante.chiesa@libero.it	1530
dante.chiesa@libero.it	1302
dante.chiesa@libero.it	1657
dante.chiesa@libero.it	2776
dante.chiesa@libero.it	1233
dante.chiesa@libero.it	624
dante.chiesa@libero.it	2702
dante.chiesa@libero.it	796
dante.chiesa@libero.it	652
dante.chiesa@libero.it	763
dante.chiesa@libero.it	1625
dante.chiesa@libero.it	876
dante.chiesa@libero.it	873
dante.chiesa@libero.it	407
dante.chiesa@libero.it	548
dante.chiesa@libero.it	1766
dante.chiesa@libero.it	2730
dante.chiesa@libero.it	1888
dante.chiesa@libero.it	2478
dante.chiesa@libero.it	1101
dante.chiesa@libero.it	1216
dante.chiesa@libero.it	1916
dante.chiesa@libero.it	1491
dante.chiesa@libero.it	1994
dante.chiesa@libero.it	1855
dante.chiesa@libero.it	1174
dante.chiesa@libero.it	444
dante.chiesa@libero.it	2612
dante.chiesa@libero.it	2809
dante.chiesa@libero.it	1834
dante.chiesa@libero.it	1271
dante.chiesa@libero.it	1963
dante.chiesa@libero.it	2583
dante.chiesa@libero.it	2223
dante.chiesa@libero.it	2286
dante.chiesa@libero.it	1447
dante.chiesa@libero.it	1978
dante.chiesa@libero.it	822
dante.chiesa@libero.it	2411
dante.chiesa@libero.it	1079
dante.chiesa@libero.it	2101
dante.chiesa@libero.it	743
dante.chiesa@libero.it	131
dante.chiesa@libero.it	1876
dante.chiesa@libero.it	2048
dante.chiesa@libero.it	637
dante.chiesa@libero.it	1186
dante.chiesa@libero.it	404
dante.chiesa@libero.it	1470
dante.chiesa@libero.it	1575
dante.chiesa@libero.it	1901
dante.chiesa@libero.it	1862
dante.chiesa@libero.it	2293
dante.chiesa@libero.it	477
dante.chiesa@libero.it	322
dante.chiesa@libero.it	779
dante.chiesa@libero.it	115
dante.chiesa@libero.it	2812
dante.chiesa@libero.it	2064
dante.chiesa@libero.it	684
dante.chiesa@libero.it	2497
dante.chiesa@libero.it	1750
dante.chiesa@libero.it	59
dante.chiesa@libero.it	654
dante.chiesa@libero.it	2568
dante.chiesa@libero.it	100
dante.chiesa@libero.it	2162
dino.dallara@hotmail.com	788
dino.dallara@hotmail.com	2014
dino.dallara@hotmail.com	885
dino.dallara@hotmail.com	192
dino.dallara@hotmail.com	1220
dino.dallara@hotmail.com	2574
dino.dallara@hotmail.com	427
dino.dallara@hotmail.com	877
dino.dallara@hotmail.com	1312
dino.dallara@hotmail.com	2834
dino.dallara@hotmail.com	2357
dino.dallara@hotmail.com	618
dino.dallara@hotmail.com	2623
dino.dallara@hotmail.com	1804
dino.dallara@hotmail.com	875
dino.dallara@hotmail.com	1678
dino.dallara@hotmail.com	2364
dino.dallara@hotmail.com	1180
dino.dallara@hotmail.com	2315
dino.dallara@hotmail.com	2679
dino.dallara@hotmail.com	2046
dino.dallara@hotmail.com	1663
dino.dallara@hotmail.com	693
dino.dallara@hotmail.com	315
dino.dallara@hotmail.com	925
dino.dallara@hotmail.com	2671
dino.dallara@hotmail.com	2091
dino.dallara@hotmail.com	2533
dino.dallara@hotmail.com	125
dino.dallara@hotmail.com	1175
dino.dallara@hotmail.com	2268
dino.dallara@hotmail.com	1033
dino.dallara@hotmail.com	1408
dino.dallara@hotmail.com	2678
dino.dallara@hotmail.com	2216
dino.dallara@hotmail.com	2641
dino.dallara@hotmail.com	2485
dino.dallara@hotmail.com	113
dino.dallara@hotmail.com	1252
dino.dallara@hotmail.com	339
dino.dallara@hotmail.com	691
dino.dallara@hotmail.com	1749
dino.dallara@hotmail.com	2414
dino.dallara@hotmail.com	860
dino.dallara@hotmail.com	1459
dino.dallara@hotmail.com	1811
dino.dallara@hotmail.com	975
dino.dallara@hotmail.com	2413
dino.dallara@hotmail.com	2635
dino.dallara@hotmail.com	2398
dino.dallara@hotmail.com	16
dino.dallara@hotmail.com	1765
dino.dallara@hotmail.com	1378
dino.dallara@hotmail.com	1431
dino.dallara@hotmail.com	1943
dino.dallara@hotmail.com	1561
dino.dallara@hotmail.com	2506
dino.dallara@hotmail.com	26
dino.dallara@hotmail.com	1086
dino.dallara@hotmail.com	1793
dino.dallara@hotmail.com	746
dino.dallara@hotmail.com	2429
dino.dallara@hotmail.com	1518
dino.dallara@hotmail.com	651
dino.dallara@hotmail.com	132
dino.dallara@hotmail.com	314
dino.dallara@hotmail.com	1903
dino.dallara@hotmail.com	97
dino.dallara@hotmail.com	1558
dino.dallara@hotmail.com	1975
dino.dallara@hotmail.com	1039
dino.dallara@hotmail.com	2251
dino.dallara@hotmail.com	470
dino.dallara@hotmail.com	991
dino.dallara@hotmail.com	1014
dino.dallara@hotmail.com	1816
dino.dallara@hotmail.com	1990
dino.dallara@hotmail.com	2838
dino.dallara@hotmail.com	1089
dino.dallara@hotmail.com	1884
dino.dallara@hotmail.com	2600
dino.dallara@hotmail.com	2668
dino.dallara@hotmail.com	232
dino.dallara@hotmail.com	1094
dino.dallara@hotmail.com	421
dino.dallara@hotmail.com	1531
dino.dallara@hotmail.com	1509
dino.dallara@hotmail.com	1553
dino.dallara@hotmail.com	1676
dino.dallara@hotmail.com	488
dino.dallara@hotmail.com	35
dino.dallara@hotmail.com	721
dino.dallara@hotmail.com	2389
dino.dallara@hotmail.com	1703
dino.dallara@hotmail.com	1838
dino.dallara@hotmail.com	1376
dino.dallara@hotmail.com	767
dino.dallara@hotmail.com	1832
dino.dallara@hotmail.com	2528
dino.dallara@hotmail.com	2826
gianfranco.angiolello@yahoo.it	30
lisa.parmitano@libero.it	30
antonia.ramazzotti@hotmail.com	30
sabatino.bettin@hotmail.com	78
luigi.borgia@virgilio.it	78
silvio.cutuli@yahoo.it	78
eva.carullo@gmail.com	87
paloma.barozzi@hotmail.com	87
manuel.lucciano@virgilio.it	87
ninetta.spanevello@yahoo.it	95
gianluca.carriera@hotmail.com	95
lara.grimani@virgilio.it	95
manuel.lucciano@virgilio.it	123
calcedonio.scarponi@libero.it	123
arsenio.fagiani@virgilio.it	123
dante.mantegazza@yahoo.it	142
lara.grimani@virgilio.it	142
piergiorgio.pininfarina@hotmail.com	142
michelangelo.antonetti@gmail.com	156
vincenza.salandra@yahoo.it	156
paoletta.pirandello@yahoo.it	156
pierina.asprucci@virgilio.it	166
melania.martucci@virgilio.it	166
luigi.borgia@virgilio.it	166
angelina.trupiano@gmail.com	172
silvia.camanni@virgilio.it	172
angelina.trupiano@gmail.com	409
giacinto.scarfoglio@yahoo.it	181
ivan.fantozzi@virgilio.it	181
dante.mantegazza@yahoo.it	181
paoletta.crespi@yahoo.it	189
eva.carullo@gmail.com	189
gianfranco.angiolello@yahoo.it	189
sante.malaparte@libero.it	195
giacinto.scarfoglio@yahoo.it	195
lara.grimani@virgilio.it	195
luigi.borgia@virgilio.it	206
francesco.fischetti@hotmail.com	206
donatello.varano@yahoo.it	206
sante.malaparte@libero.it	208
gianpietro.venturi@yahoo.it	208
melania.martucci@virgilio.it	208
zaira.zeffirelli@virgilio.it	212
pierina.asprucci@virgilio.it	212
nicolò.tedesco@gmail.com	212
fernanda.blasi@libero.it	214
marina.bettoni@libero.it	214
elena.agazzi@libero.it	214
roman.marrone@libero.it	234
zaira.zeffirelli@virgilio.it	234
dino.garibaldi@yahoo.it	234
donatello.varano@yahoo.it	254
angelina.trupiano@gmail.com	254
liberto.cannizzaro@hotmail.com	254
lilla.ceci@virgilio.it	257
pierina.asprucci@virgilio.it	257
silvio.cutuli@yahoo.it	257
ninetta.spanevello@yahoo.it	301
michelotto.alfieri@hotmail.com	301
roman.marrone@libero.it	301
patrizia.cutrufo@virgilio.it	310
vito.petrocelli@hotmail.com	310
pierpaolo.cerquiglini@virgilio.it	310
matteo.pugliese@hotmail.com	327
francesco.fischetti@hotmail.com	327
massimo.sermonti@libero.it	327
zaira.bellocchio@yahoo.it	348
paloma.barozzi@hotmail.com	348
vincenza.turati@hotmail.com	348
dino.dallara@hotmail.com	359
cipriano.vercelloni@virgilio.it	359
dante.chiesa@libero.it	359
zaira.zeffirelli@virgilio.it	428
cipriano.vercelloni@virgilio.it	428
arsenio.fagiani@virgilio.it	428
pierpaolo.cerquiglini@virgilio.it	434
roberto.lussu@yahoo.it	434
paloma.barozzi@hotmail.com	434
elena.agazzi@libero.it	442
lilla.ceci@virgilio.it	442
liberto.cannizzaro@hotmail.com	442
cristina.tedesco@yahoo.it	446
paoletta.pirandello@yahoo.it	446
arsenio.fagiani@virgilio.it	446
salvatore.togliatti@virgilio.it	452
silvia.camanni@virgilio.it	452
dario.battisti@hotmail.com	452
gioacchino.milanesi@libero.it	473
elena.cortese@virgilio.it	473
vincenza.turati@hotmail.com	473
lisa.parmitano@libero.it	530
eliana.peano@libero.it	530
eliana.peano@libero.it	2699
gianluca.carriera@hotmail.com	550
arsenio.cortese@libero.it	550
dario.battisti@hotmail.com	550
eva.carullo@gmail.com	551
angelina.trupiano@gmail.com	551
ricciotti.nicolucci@hotmail.com	551
elena.agazzi@libero.it	634
melania.martucci@virgilio.it	634
irma.cimini@hotmail.com	634
sante.malaparte@libero.it	659
hugo.morpurgo@hotmail.com	659
arsenio.fagiani@virgilio.it	659
laura.lettiere@yahoo.it	664
zaira.zeffirelli@virgilio.it	664
angelina.trupiano@gmail.com	664
milo.casagrande@yahoo.it	670
francesco.fischetti@hotmail.com	670
bettina.scarlatti@yahoo.it	670
dante.chiesa@libero.it	709
vincenza.turati@hotmail.com	709
massimo.sermonti@libero.it	709
cipriano.vercelloni@virgilio.it	715
pierina.asprucci@virgilio.it	1102
massimo.sermonti@libero.it	1102
ivan.fantozzi@virgilio.it	1137
dario.battisti@hotmail.com	1137
ricciotti.nicolucci@hotmail.com	1137
cipriano.vercelloni@virgilio.it	1178
micheletto.saragat@hotmail.com	1178
lamberto.ferrata@libero.it	1178
milena.grifeo@libero.it	1185
giacinto.scarfoglio@yahoo.it	1185
matteo.pugliese@hotmail.com	1185
micheletto.saragat@hotmail.com	1226
silvia.camanni@virgilio.it	1226
gianluca.carriera@hotmail.com	1226
nicolò.tedesco@gmail.com	1296
pierina.asprucci@virgilio.it	1296
lilla.ceci@virgilio.it	1296
sante.malaparte@libero.it	1318
laura.lettiere@yahoo.it	1318
lara.grimani@virgilio.it	1318
patrizia.cutrufo@virgilio.it	1319
gianpietro.venturi@yahoo.it	1319
michelotto.alfieri@hotmail.com	1319
pierpaolo.cerquiglini@virgilio.it	1419
micheletto.saragat@hotmail.com	1419
dino.garibaldi@yahoo.it	1419
zaira.bellocchio@yahoo.it	1497
flavia.sobrero@virgilio.it	1497
angelina.trupiano@gmail.com	1497
roberto.lussu@yahoo.it	1526
melania.martucci@virgilio.it	1526
manuel.lucciano@virgilio.it	1526
bettina.scarlatti@yahoo.it	1527
milo.casagrande@yahoo.it	1527
sabatino.bettin@hotmail.com	1527
elena.agazzi@libero.it	1538
elmo.barbarigo@yahoo.it	1538
silvia.camanni@virgilio.it	1538
dino.garibaldi@yahoo.it	1560
angelina.trupiano@gmail.com	1560
lilla.ceci@virgilio.it	1560
bettina.scarlatti@yahoo.it	1590
jolanda.marenzio@virgilio.it	1590
marina.bettoni@libero.it	1590
eliana.accardo@virgilio.it	1611
silvia.camanni@virgilio.it	1611
gianluca.carriera@hotmail.com	1611
pierpaolo.cerquiglini@virgilio.it	1671
tiziano.pederiva@hotmail.com	1671
paoletta.pirandello@yahoo.it	1671
lara.grimani@virgilio.it	1672
salvatore.togliatti@virgilio.it	1672
pierina.asprucci@virgilio.it	1672
lilla.ceci@virgilio.it	1767
calcedonio.scarponi@libero.it	1767
vincenza.turati@hotmail.com	1767
paoletta.crespi@yahoo.it	1775
gioacchino.milanesi@libero.it	1775
lamberto.ferrata@libero.it	1775
giacinto.scarfoglio@yahoo.it	1796
salvatore.togliatti@virgilio.it	1796
lamberto.ferrata@libero.it	1796
elena.agazzi@libero.it	1800
alessio.giulietti@virgilio.it	1800
diana.guicciardini@libero.it	1800
bianca.traversa@virgilio.it	1801
milena.grifeo@libero.it	1801
vincenza.salandra@yahoo.it	1801
diana.guicciardini@libero.it	1803
roberto.lussu@yahoo.it	1803
donatello.varano@yahoo.it	1803
irma.cimini@hotmail.com	1845
marina.bettoni@libero.it	1845
paoletta.pirandello@yahoo.it	1845
michelangelo.antonetti@gmail.com	1848
liberto.cannizzaro@hotmail.com	1848
pierina.asprucci@virgilio.it	1848
melania.martucci@virgilio.it	1858
donatello.varano@yahoo.it	1858
piergiorgio.pininfarina@hotmail.com	1858
tiziano.pederiva@hotmail.com	1865
luigi.borgia@virgilio.it	1865
luchino.mannoia@gmail.com	1865
micheletto.saragat@hotmail.com	1870
eliana.accardo@virgilio.it	1870
milo.casagrande@yahoo.it	1870
ivan.fantozzi@virgilio.it	1912
milo.casagrande@yahoo.it	1912
fernanda.blasi@libero.it	1912
micheletto.saragat@hotmail.com	1923
jolanda.marenzio@virgilio.it	1923
manuel.lucciano@virgilio.it	1923
michelangelo.antonetti@gmail.com	1948
hugo.morpurgo@hotmail.com	1948
fernanda.blasi@libero.it	1948
paoletta.pirandello@yahoo.it	1962
paloma.barozzi@hotmail.com	1962
liberto.cannizzaro@hotmail.com	1962
laura.lettiere@yahoo.it	1988
elmo.barbarigo@yahoo.it	1988
lisa.parmitano@libero.it	1988
giacinto.scarfoglio@yahoo.it	2003
tiziano.pederiva@hotmail.com	2003
silvio.cutuli@yahoo.it	2003
eva.carullo@gmail.com	2025
calcedonio.scarponi@libero.it	2025
liberto.cannizzaro@hotmail.com	2025
irma.cimini@hotmail.com	2036
patrizia.cutrufo@virgilio.it	2036
irma.cimini@hotmail.com	377
luchino.mannoia@gmail.com	2042
dino.dallara@hotmail.com	2042
roberto.lussu@yahoo.it	2042
luchino.mannoia@gmail.com	2087
alessio.giulietti@virgilio.it	2087
elena.cortese@virgilio.it	2087
matteo.pugliese@hotmail.com	2089
matteo.pugliese@hotmail.com	2539
vincenza.turati@hotmail.com	2089
luigi.borgia@virgilio.it	2136
micheletto.saragat@hotmail.com	2136
nicoletta.gabbana@gmail.com	2136
marina.bettoni@libero.it	2140
laura.lettiere@yahoo.it	2140
marina.bettoni@libero.it	964
sabatino.bettin@hotmail.com	2177
giulietta.moretti@libero.it	2177
cristina.tedesco@yahoo.it	2177
liberto.cannizzaro@hotmail.com	2180
paoletta.pirandello@yahoo.it	2180
gianfranco.angiolello@yahoo.it	2180
michelotto.alfieri@hotmail.com	2184
lara.grimani@virgilio.it	2184
nicoletta.gabbana@gmail.com	2184
paloma.barozzi@hotmail.com	2185
dino.dallara@hotmail.com	2185
dino.garibaldi@yahoo.it	2185
michelotto.alfieri@hotmail.com	2219
vincenza.salandra@yahoo.it	2219
patrizia.cutrufo@virgilio.it	2219
lilla.ceci@virgilio.it	2222
micheletto.saragat@hotmail.com	2222
lamberto.ferrata@libero.it	2222
milena.grifeo@libero.it	2245
nicolò.tedesco@gmail.com	2245
elena.cortese@virgilio.it	2245
hugo.morpurgo@hotmail.com	2246
paoletta.crespi@yahoo.it	2246
costanzo.bosurgi@virgilio.it	2246
roman.marrone@libero.it	2255
lamberto.ferrata@libero.it	2255
paoletta.pirandello@yahoo.it	2255
lara.grimani@virgilio.it	2267
milo.casagrande@yahoo.it	2267
sante.malaparte@libero.it	2267
silvio.cutuli@yahoo.it	2299
elena.cortese@virgilio.it	2299
diana.guicciardini@libero.it	2299
roman.marrone@libero.it	2310
zaira.bellocchio@yahoo.it	2310
salvatore.togliatti@virgilio.it	2310
roberto.lussu@yahoo.it	2327
melania.martucci@virgilio.it	2327
micheletto.saragat@hotmail.com	2327
cristina.tedesco@yahoo.it	2363
nicolò.tedesco@gmail.com	2363
fernanda.blasi@libero.it	2363
lara.grimani@virgilio.it	2380
michelangelo.antonetti@gmail.com	2380
tiziano.pederiva@hotmail.com	2380
paoletta.pirandello@yahoo.it	2383
eliana.accardo@virgilio.it	2383
michelangelo.antonetti@gmail.com	2383
eva.carullo@gmail.com	2392
giulietta.moretti@libero.it	2392
patrizia.accardo@yahoo.it	2392
elena.agazzi@libero.it	2434
massimo.sermonti@libero.it	2434
michelangelo.antonetti@gmail.com	2434
dario.battisti@hotmail.com	2454
eliana.peano@libero.it	2454
vincenza.salandra@yahoo.it	2454
sante.malaparte@libero.it	2459
paoletta.pirandello@yahoo.it	2459
luigi.borgia@virgilio.it	2459
vito.petrocelli@hotmail.com	2532
lisa.parmitano@libero.it	2532
marina.bettoni@libero.it	2532
calcedonio.scarponi@libero.it	2647
patrizia.cutrufo@virgilio.it	2647
gianfranco.angiolello@yahoo.it	2647
sabatino.bettin@hotmail.com	2694
milena.grifeo@libero.it	2694
silvia.camanni@virgilio.it	2694
ninetta.spanevello@yahoo.it	2718
milena.grifeo@libero.it	2718
roman.marrone@libero.it	2718
milo.casagrande@yahoo.it	2719
angelina.trupiano@gmail.com	2719
calcedonio.scarponi@libero.it	2719
vincenza.turati@hotmail.com	2830
arsenio.cortese@libero.it	2830
laura.lettiere@yahoo.it	2830
\.


--
-- Data for Name: drug_prescription; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.drug_prescription (drug_prescription_id, practitioner_id, patient_id, drug_type, date_prescribed, date_sold, chemist_id, ticket, ticket_paid, description) FROM stdin;
31	giorgio.barcaccia@yahoo.it	orlando.boito@virgilio.it	2	2019-12-26 12:06:54.654	2019-12-26 17:54:15.576	ippazio.gabbana@libero.it	3	f	 
\.


--
-- Data for Name: drug_type; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.drug_type (drug_id, drug_description) FROM stdin;
1	Acamprosato
2	Acarbosio
3	Acebutololo
4	Aceclofenac
5	Acenocumarolo
6	Acetazolamide
7	Aciclovir
8	Acido acetilsalicilico
9	Acido alendronico
10	Acido carglumico
11	Acido clodronico
12	Acido folico
13	Acido micofenolico
14	Acido tauroursodesossicolico
15	Acido tiaprofenico
16	Acido tranexamico
17	Acido ursodesossicolico
18	Acitretina
19	Aclidinio
20	Acqua per preparazioni iniettabili
21	Adrenalina
22	Albendazolo
23	Albumina umana
24	Albutrepenonacog alfa
25	Alcinonide
26	alfacalcidolo
27	Alfuzosina
28	Alirocumab
29	Aliskiren
30	Alizapride
31	Allopurinolo
32	Almotriptan
33	Alogliptin
34	Aloperidolo
35	Alprostadil
36	Ambrisentan
37	Amikacina
38	Aminofillina
39	Amiodarone
40	Amisulpride
41	Amitriptilina
42	Amlodipina
43	Amoxicillina
44	Ampicillina
45	Amtolmetina guacile
46	Anagrelide
47	Anastrozolo
48	Apixaban
49	Apomorfina
50	Apraclonidina
51	Apremilast
52	Aripiprazolo
53	Asenapina
54	Atenololo
55	Atomoxetina
56	Atorvastatina
57	Atropina
58	Atropina solfato
59	Avanafil
60	Azatioprina
61	Azitromicina
62	Bacampicillina
63	Baclofene
64	Balsalazide
65	Barnidipina
66	Bazedoxifene
67	Beclometasone
68	Bemiparina
69	Benazepril
70	Benralizumab
71	Benzilpenicillina benzatinica
72	Betaina
73	Betametasone
74	Betaxololo
75	Bexarotene
76	Bezafibrato
77	Bicalutamide
78	Bimatoprost
79	Biperidene
80	Bisoprololo
81	Bornaprina
82	Bosentan
83	Brimonidina
84	Brinzolamide
85	Brivaracetam
86	Brivudina
87	Bromocriptina
88	Bromperidolo
89	Budesonide
90	Buprenorfina
91	Bupropione
92	Buserelin
93	Cabergolina
94	Calcifediolo
95	Calcio carbonato
96	Calcio cloruro
97	Calcio folinato
98	Calcio polistirensolfonato
99	Calcipotriolo
100	Calcitriolo
101	Canagliflozin
102	Candesartan cilexetil
103	Canrenone
104	Capecitabina
105	Captopril
106	Carbamazepina
107	Carbomer
108	Cariprazina
109	Carteololo
110	Carvedilolo
111	Cefaclor
112	Cefalexina
113	Cefazolina
114	Cefditoren
115	Cefepime
116	Cefixima
117	Cefmetazolo
118	Cefodizima
119	Cefotaxima
120	Cefoxitina
121	Cefpodoxima
122	Cefprozil
123	Ceftazidima
124	Ceftibuten
125	Ceftriaxone
126	Cefuroxima
127	Celecoxib
128	Celiprololo
129	Cetirizina
130	Cianocobalamina
131	Ciclesonide
132	Ciclofosfamide
133	Ciclosporina
134	Cilazapril
135	Cinacalcet
136	Cinnoxicam
137	Ciprofloxacina
138	Ciproterone
139	Citalopram
140	Cladribina
141	Claritromicina
142	Clindamicina
143	Clobetasolo
144	Clomifene
145	Clomipramina
146	Clonazepam
147	Clonidina
148	Clopidogrel
149	Clorambucile
150	Clorochina
151	Clorpromazina
152	Clortalidone
153	Clotiapina
154	Clozapina
155	Colchicina
156	Colecalciferolo
157	Colestiramina
158	Corifollitropina alfa
159	Coriogonadotropina alfa
160	Cortisone
161	Dabigatran
162	Daclatasvir
163	Danazolo
164	Dapagliflozin
165	Darbepoetina alfa
166	Dasabuvir
167	Deferasirox
168	Deferiprone
169	Deferoxamina
170	Degarelix
171	Delapril
172	Denosumab
173	Desametasone
174	Desloratadina
175	Desmopressina
176	Desossiribonucleasi
177	Dexibuprofene
178	Diazossido
179	Diclofenac
180	Didrogesterone
181	Diflucortolone
182	Digossina
183	Diidrochinidina
184	Diidrocodeina
185	Diltiazem
186	Dimetilfumarato
187	Disopiramide
188	Disulfiram
189	Donepezil
190	Dorzolamide
191	Doxazosin
192	Doxazosina
193	Doxiciclina
194	Doxofillina
195	Dronedarone
196	Dulaglutide
197	Duloxetina
198	Dutasteride
199	Ebastina
200	Edoxaban
201	Efmoroctocog alfa
202	Eftrenonacog alfa
203	Eletriptan
204	Eliglustat
205	Emicizumab
206	Empagliflozin
207	Enalapril
208	Enoxaparina sodica
209	Entacapone
210	Entecavir
211	Eparina calcica
212	Eparina sodica
213	Eplerenone
214	Epoetina alfa
215	Epoetina beta
216	Epoetina teta
217	Epoetina zeta
218	Eprosartan
219	Eritromicina
220	Escitalopram
221	Eslicarbazepina
222	Esomeprazolo
223	Estradiolo
224	Estramustina
225	Estratto di foglie di te verde
226	Estriolo
227	Etambutolo
228	Etelcalcetide
229	Etinilestradiolo
230	Etoposide
231	Etoricoxib
232	Etosuccimide
233	Everolimus
234	Evolocumab
235	Exemestane
236	Exenatide
237	Ezetimibe
238	Famciclovir
239	Famotidina
240	Febuxostat
241	Felbamato
242	Felodipina
243	Fenitoina
244	Fenobarbital
245	Fenofibrato
246	Fenoterolo
247	Fentanil
248	Ferro polimaltosato
249	Ferroso glicina solfato
250	Ferroso gluconato
251	Ferroso solfato
252	Fexofenadina
253	Filgrastim
254	Finasteride
255	Fingolimod
256	Fitomenadione
257	Flecainide
258	Floroglucinolo
259	Flucloxacillina
260	Fluconazolo
261	Fludarabina
262	Flufenazina
263	Flunisolide
264	Fluocinolone acetonide
265	Fluocinonide
266	Fluoxetina
267	Flurbiprofene
268	Flutamide
269	Fluticasone
270	Fluvastatina
271	Fluvoxamina
272	Follitropina alfa
273	Follitropina beta
274	Follitropina delta
275	Fondaparinux
276	Formoterolo
277	Fosfomicina
278	Fosinopril
279	Frovatriptan
280	Furosemide
281	Gabapentin
282	Galantamina
283	Gemfibrozil
284	Glatiramer
285	Glibenclamide
286	Glicerolo fenilbutirrato
287	Gliclazide
288	Glicopirronio
289	Glimepiride
290	Glipizide
291	Gliquidone
292	Glucagone
293	Glucosio
294	Gonadorelina
295	Gonadotropina corionica
296	Goserelin
297	Granisetrone
298	Griseofulvina
299	Ibuprofene
300	Idarubicina
301	Idebenone
302	Idroclorotiazide
303	Idrocortisone
304	Idromorfone
305	Idrossiprogesterone
306	Idroxicarbamide
307	Idroxiclorochina
308	Idroxocobalamina
309	Iloprost
310	Imatinib
311	Imiquimod
312	Immunoglobulina umana anti-D
313	Immunoglobulina umana antiepatite B
314	Immunoglobulina umana antitetanica
315	Indacaterolo
316	Indapamide
317	Indometacina
318	Ingenolo mebutato
319	Insulina aspart
320	Insulina degludec
321	Insulina detemir
322	Insulina glargine
323	Insulina glulisina
324	Insulina lispro da DNA ricombinante
325	Insulina umana da DNA ricombinante
326	Insulina umana isofano da DNA ricombinante
327	Interferone alfa 2A
328	Interferone alfa 2B
329	Interferone beta 1A
330	Interferone beta 1B
331	Ipratropio bromuro
332	Irbesartan
333	Isavuconazolo
334	Isoniazide
335	Isosorbide dinitrato
336	Isosorbide mononitrato
337	Isotretinoina
338	Isradipina
339	Itraconazolo
340	Ivabradina
341	Ivacaftor
342	Josamicina
343	Ketoconazolo
344	Ketoprofene
345	Ketorolac
346	Ketotifene
347	Labetalolo
348	Lacidipina
349	Lacosamide
350	Lamivudina
351	Lamotrigina
352	Lanreotide
353	Lansoprazolo
354	Lantanio
355	Latanoprost
356	Lattitolo
357	Lattulosio
358	Leflunomide
359	Lenograstim
360	Lercanidipina
361	Lesinurad
362	Letermovir
363	Letrozolo
364	Leuprorelina
365	Levetiracetam
366	Levobunololo
367	Levocarnitina
368	Levocetirizina
369	Levodropropizina
370	Levofloxacina
371	Levomepromazina
372	Levosulpiride
373	Levotiroxina
374	Lidocaina
375	Limeciclina
376	Linagliptin
377	Lincomicina
378	Linezolid
379	Liotironina
380	Lipegfilgrastim
381	Liraglutide
382	Lisinopril
383	Litio carbonato
384	Lixisenatide
385	Lomefloxacina
386	Lomitapide
387	Lonoctocog alfa
388	Loratadina
389	Lornoxicam
390	Losartan
391	Lovastatina
392	Lurasidone
393	Lutropina alfa
394	Macitentan
395	Magaldrato
396	Magnesio valproato
397	Manidipina
398	Mannitolo
399	Mebendazolo
400	Medrossiprogesterone
401	Meflochina
402	Megestrolo
403	Melfalan
404	Meloxicam
405	Memantina
406	Menotropina
407	Mepolizumab
408	Mercaptamina
409	Mercaptopurina
410	Mesalazina
411	Mesna
412	Metaciclina
413	Metadone
414	Metformina
415	Metildopa
416	Metilergometrina
417	Metilfenidato
418	Metilnaltrexone
419	Metilprednisolone
420	Metirapone
421	Metixene
422	Metoclopramide
423	Metolazone
424	Metoprololo
425	Metossipolietilenglicole-epoetina beta
426	Metotrexato
427	Metronidazolo
428	Mianserina
429	Micofenolato mofetile
430	Miconazolo
431	Midazolam
432	Migalastat
433	Miglustat
434	Minociclina
435	Miocamicina
436	Mirtazapina
437	Misoprostolo
438	Mitotano
439	Mizolastina
440	Modafinil
441	Mometasone
442	Montelukast
443	Morfina cloridrato
444	Morfina solfato
445	Moroctocog alfa
446	Moxifloxacina
447	Moxonidina
448	Nabumetone
449	Nadroparina
450	Naloxegol
451	Naltrexone
452	Naprossene
453	Naproxene
454	Nebivololo
455	Nedocromile
456	Neostigmina
457	Netilmicina
458	Nicardipina
459	Niclosamide
460	Nifedipina
461	Nimesulide
462	Nimesulide betaciclodestrina
463	Nisoldipina
464	Nistatina
465	Nitisinone
466	Nitrendipina
467	Nitroglicerina
468	Nizatidina
469	Nomegestrolo
470	Nonacog alfa
471	Nonacog gamma
472	Noretisterone
473	Norfloxacina
474	Nortriptilina
475	Octocog alfa
476	Octreotide
477	Olanzapina
478	Olmesartan medoxomil
479	Olodaterolo
480	Omalizumab
481	Omeprazolo
482	Ondansetrone
483	Opicapone
484	Ossibutinina cloridrato
485	Ossidrossido sucroferrico
486	Ossigeno
487	Oxacillina
488	Oxatomide
489	Oxcarbazepina
490	Oxibutinina
491	Oxicodone
492	Oxitropio bromuro
493	Paliperidone
494	Palivizumab
495	Pancrelipasi
496	Pantoprazolo
497	Paracalcitolo
498	Parnaparina
499	Paromomicina
500	Paroxetina
501	Pasireotide
502	Pegfilgrastim
503	Peginterferone alfa 2A
504	Peginterferone alfa 2B
505	Peginterferone beta 1A
506	Pegvisomant
507	Pentaeritritile tetranitrato
508	Pentamidina
509	Perampanel
510	Periciazina
511	Perindopril
512	Pilocarpina
513	Pimozide
514	Pindololo
515	Pioglitazone
516	Piperacillina
517	Pipetanato
518	Pirantel
519	Pirazinamide
520	Piridostigmina
521	Piroxicam
522	Pizotifene
523	Polline graminacee phleum pratense
524	Posaconazolo
525	Potassio canrenoato
526	Potassio cloruro
527	Pralidoxima
528	Pramipexolo
529	Prasugrel
530	Pravastatina
531	Prednicarbato
532	Prednisolone
533	Prednisone
534	Pregabalin
535	Primidone
536	Procarbazina
537	Progesterone
538	Proglumetacina
539	Promestriene
540	Prometazina
541	Propafenone
542	Propranololo
543	Protamina
544	Proteina del plasma umano antiangioedema
545	Prulifloxacina
546	Quetiapina
547	Quinapril
548	Rabeprazolo
549	Raloxifene
550	Ramipril
551	Ranitidina
552	Ranolazina
553	Rasagilina
554	Reboxetina
555	Regorafenib
556	Repaglinide
557	Retigabina
558	Ribavirina
559	Rifabutina
560	Rifampicina
561	Rifaximina
562	Riluzolo
563	Riociguat
564	Risperidone
565	Ritodrina
566	Rivaroxaban
567	Rivastigmina
568	Rizatriptan
569	Roflumilast
570	Ropinirolo
571	Rosuvastatina
572	Rotigotina
573	Roxitromicina
574	Rufinamide
575	Rufloxacina
576	Rupatadina
577	Safinamide
578	Salbutamolo
579	Salmeterolo
580	Sapropterina
581	Saxagliptin
582	Scopolamina
583	Selegilina
584	Selexipag
585	Sertralina
586	Sevelamer
587	Sildenafil
588	Silodosina
589	Simoctocog alfa
590	Simvastatina
591	Sirolimus
592	Sitagliptin
593	Sodio cloruro
594	Sodio fenilbutirrato
595	Sodio ferrigluconato
596	Sodio ibandronato
597	Sodio neridronato
598	Sodio polistirensolfonato
599	Sodio risedronato
600	Sodio valproato
601	Somatropina
602	Sotalolo
603	Spiramicina
604	Spironolattone
605	Stronzio ranelato
606	Sucralfato
607	Sulfasalazina
608	Sumatriptan
609	Tacalcitolo
610	Tacrolimus
611	Tadalafil
612	Tafluprost
613	Tamoxifene
614	Tamsulosina
615	Tapentadolo
616	Tazarotene
617	Tedizolid
618	Teicoplanina
619	Telbivudina
620	Telitromicina
621	Telmisartan
622	Temozolomide
623	Tenoxicam
624	Teofillina
625	Terazosina
626	Terbinafina
627	Teriflunomide
628	Teriparatide
629	Testosterone
630	Tetrabenazina
631	Tiagabina
632	Tiamazolo
633	Tiapride
634	Tibolone
635	Ticagrelor
636	Ticlopidina
637	Timololo
638	Tinidazolo
639	Tioguanina
640	Tiotropio
641	Tobramicina
642	Tolcapone
643	Tolterodina
644	Tolvaptan
645	Topiramato
646	Topotecan
647	Torasemide
648	Toremifene
649	Tramadolo
650	Trandolapril
651	Travoprost
652	Trazodone
653	Tretinoina
654	Triamcinolone
655	Triesifenidile
656	Trifluoperazina
657	Trimipramina
658	Triptorelina
659	Turoctocog alfa
660	Ulipristal
661	Umeclidinio
662	Urofollitropina
663	Valaciclovir
664	Valganciclovir
665	Valpromide
666	Valsartan
667	Vancomicina
668	Vardenafil
669	Venlafaxina
670	Verapamil
671	Vigabatrin
672	Vildagliptin
673	Vinorelbina
674	Voriconazolo
675	Vortioxetina
676	Warfarin
677	Zinco acetato
678	Ziprasidone
679	Zofenopril
680	Zolmitriptan
681	Zonisamide
682	Zuclopentixolo
\.


--
-- Data for Name: exam; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.exam (exam_id, patient_id, doctor_id, exam_type, done, date, result, health_service_id, ticket, ticket_paid, practitioner_id, booked, recall) FROM stdin;
123	alberico.marcacci@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
82	orlando.boito@virgilio.it	sabatino.bettin@hotmail.com	1428	t	2019-12-26 08:30:00	L'esame è stato completato con successo.	\N	50	f	giorgio.barcaccia@yahoo.it	t	\N
83	livia.agostini@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
84	ornella.altera@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
85	costantino.andreozzi@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
86	vincenzo.angiolello@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
87	annunziata.badoglio@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
88	gianpietro.bajardi@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
89	cecilia.baracca@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
90	fiorenzo.berlusconi@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
91	niccolò.blasi@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
92	ubaldo.bocelli@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
93	orlando.boito@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
94	patrizia.bonomo@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
95	tonia.bossi@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
96	concetta.botticelli@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
97	melania.bruscantini@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
98	pierluigi.capone@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
99	marta.casarin@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
100	stefani.castellitto@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
101	aria.castioni@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
102	leonardo.chiappetta@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
103	veronica.cilea@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
104	cassandra.crispi@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
105	stefano.dulbecco@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
106	massimiliano.fagotto@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
107	antonina.filzi@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
108	enzo.fittipaldi@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
109	giovanni.flaiano@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
110	martina.fracci@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
111	gemma.gagliano@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
112	dante.gagliardi@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
113	michelangelo.garobbio@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
114	nadia.giusti@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
115	annunziata.goldstein@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
116	manuel.grossi@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
117	bruno.guariento@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
118	federigo.guarneri@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
119	vittoria.gucci@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
120	marta.guidone@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
121	graziella.leone@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
122	isa.lollobrigida@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
124	santino.micheletti@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
125	tina.monicelli@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
126	ruggero.muratori@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
127	agnolo.mussolini@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
128	rosa.nicolini@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
129	ugolino.nosiglia@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
130	corrado.perozzo@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
131	piergiuseppe.piccinni@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
132	filippo.piccinni@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
133	paulina.pizzo@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
134	sergius.polani@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
135	nanni.saffi@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
136	angelina.sermonti@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
137	ruggiero.simeoni@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
138	ezio.soffici@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
139	adelmo.stein@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
140	sante.storladi@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
141	pasquale.tarantino@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
142	raffaella.tonisto@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
143	amadeo.toscanini@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
144	ubaldo.totino@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
145	benvenuto.tozzi@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
146	lamberto.treves@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
147	dolores.trillini@gmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
148	massimo.troisi@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
149	nina.verdi@yahoo.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
150	leone.verdi@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
151	aria.vergassola@virgilio.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
152	giosuè.vigorelli@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
153	tatiana.villarosa@hotmail.com	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
154	mauro.visintini@libero.it	\N	2831	f	\N	\N	ssp.nuoro@gmail.com	0	f	\N	f	31
\.


--
-- Data for Name: exam_type; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.exam_type (exam_id, exam_description) FROM stdin;
3	Acidi biliari
4	Acido 5 idrossi 3 indolacetico
247	Creatinuria
691	Cistografia
964	Colposcopia
1068	Vcp
1281	Adroterapia (a seduta)
1961	Adesiolisi
2157	Asportazione della fistola
1	Anticorpi anti bordetella pertussis ig totali
2831	Ablazione tartaro
1428	Ablazione transcatetere
2445	Aborto terapeutico
1490	Accesso periferico per posizionamento di catetere venoso
5	Acido delta ammino levulinico
6	Acido folico
7	Acido lattico
8	Acido ossalico
9	Acido vanilmandelico (vma)
2316	Acromioplastica anteriore
2556	Adduttori, intervento per paralisi degli
2503	Adenoidectomia
2504	Adenotonsillectomia
10	Adrenalina plasmatica
11	Adrenalina urinaria
1376	Aferesi terapeutica, eritro aferesi con sacche multiple
13	Agglutinazione per brucella (wright)
12	Agglutinazione per brucella abortus
15	Agglutinazione per tifo e paratifo (widal)
14	Agglutinazione per tifo e paratifo più melitense
16	Agglutinazione per tifo petecchiale (weil-felix)
960	Agoaspirati o biopsie di lesioni superficiali escluso esame citoistologico
1491	Agoaspirati/agobiopsie, di qualsiasi parte anatomica, salvo i casi descritti
942	Agoaspirato ecoguidato tiroide
747	Agoaspirato mammario ecoguidato
2317	Agoaspirato osseo
2683	Agoaspirato/agobiopsia prostata
944	Agobiopsia epatica percutanea
1825	Agobiopsia pleurica/puntura esplorativa
1111	Agobiopsia prostatica (tru cut)
1112	Agobiopsia renale percutanea
2622	Agobiopsia renale percutanea
1826	Agobiopsia tc guidata
1729	Agobiopsia/agoaspirato
1652	Agobiopsia/agoaspirato pancreas
1962	Agobiopsie/agoaspirati parti anatomiche profonde
1226	Agopuntura (per seduta)
17	Aldolasi sierica
18	Aldosterone
19	Aldosterone urinario
20	Alfa 1 antitripsina
21	Alfa 1 fetoproteina
22	Alfa 1 fetoproteina nel liquido amniotico
23	Alfa 1 glicoproteina acida
24	Alfa 1 microglobulina
25	Alfa 2 macroglobulina
26	Alfa 3 androstanediolo
2	Alfa idrossi progesterone (17 ohp)
27	Alfa lattoalbumina
1777	Allestimento lembo peduncolato
2318	Alluce valgo
2319	Allungamento arti superiori e/o inferiori (per segmento, trattamento completo)
539	Altri batteri eseguibili con metodica pcr
540	Altri virus eseguibili con metodica pcr
28	Amilasi isoenzimi ematica (frazione pancreatica)
29	Amilasi isoenzimi urinaria (frazione pancreatica)
30	Amilasi sierica
31	Amilasi urinaria
32	Ammonio plasmatici
977	Amniocentesi (cariotipo su liquido amniotico compreso prelievo)
2446	Amnioscopia
2320	Amputazione grandi segmenti (trattamento completo)
2321	Amputazione medi segmenti (trattamento completo)
2734	Amputazione parziale del pene
2322	Amputazione piccoli segmenti (trattamento completo)
2735	Amputazione totale con linfoadenectomia pene
2736	Amputazione totale del pene
2832	Amputazioni radicolari (per radice escluso il lembo di accesso)
564	Analisi del gene del fattore viii per l'emofilia a
566	Analisi di mutazione del collagene di tipo 11
565	Analisi di mutazione del gene vdr della vitamina d
1035	Analisi fibre nervo ottico (gdx, hrt) - ciascuno
567	Analisi genetica per fibrosi cistica
1730	Anastomosi porto-cava o spleno-renale o mesenterica-cava
2046	Anastomosi spino-facciale e simili
2047	Anastomosi vasi intra-extra cranici
593	Anatomia ed istologia patologica
945	Anestesia/ sedazione per endoscopia
1887	Aneurisma aorta addominale (trattamento con stent endovascolare)
1888	Aneurismi aorta addominale + dissecazione: resezione e trapianto
1889	Aneurismi arterie distali degli arti
1890	Aneurismi, resezione e trapianto: arterie glutee, arterie viscerali e tronchi sovraortici
808	Angio rm (1 distretto) (1 sequenza)
778	Angio tc distretti esocranici
779	Angio tc distretti intracranici
827	Angiocardioscintigrafia all'equilibrio con calcolo parametri funzionali
828	Angiocardioscintigrafia all'equilibrio con test
829	Angiocardioscintigrafia primo transito con calcolo parametri funzionali
830	Angiocardioscintigrafia primo transito con test
1779	Angiomi del tronco e arti grandi dimensioni (più di 7 cm). Con laser, (trattamento totale)
1778	Angiomi del tronco e arti grandi dimensioni (più di 7 cm). Con tecnica tradizionale, (escluso espansore)
1781	Angiomi del tronco e arti piccole/medie dimensioni (meno di 7 cm). Con laser, (trattamento totale)
1780	Angiomi del tronco e arti piccole/medie dimensioni (meno di 7 cm). Con tecnica tradizionale
1782	Angiomi del viso grandi dimensioni (più di 4 cm). Con laser, (trattamento totale)
1783	Angiomi del viso grandi dimensioni (più di 4 cm). Con tecnica tradizionale (escluso espansore)
1784	Angiomi del viso piccole dimensioni (meno di 4 cm). Con laser, (trattamento totale)
1785	Angiomi del viso piccole dimensioni (meno di 4 cm). Con tecnica tradizionale
1892	Angioplastica arteriosa (carotidea, arti inferiori - come unico intervento)
1429	Angioplastica coronarica multipla
1430	Angioplastica coronarica singola
1891	Angioplastica di arterie viscerali (come unico intervento)
869	Angioscintigrafia cerebrale con calcolo di indici emodinamici
870	Angioscintigrafia più scintigrafia cerebrale
33	Angiotensin converting enzyme (ace)
34	Angiotensina 1
1575	Ano preternaturale, chiusura, ricostruzione continuità
36	Antibiogramma (almeno 10 antibiotici con mic)
37	Antibiogramma (almeno 10 antibiotici)
35	Antibiogramma per micobatteri (almeno 3 antibiotici)
38	Anticorpi anti adenovirus
39	Anticorpi anti asca (anti - saccharomyces - cerevisiae) iga
40	Anticorpi anti asca (anti - saccharomyces - cerevisiae) igg
41	Anticorpi anti asca (anti - saccharomyces - cerevisiae) igm
42	Anticorpi anti bordetella pertussis iga
43	Anticorpi anti bordetella pertussis igg
44	Anticorpi anti bordetella pertussis igm
45	Anticorpi anti borrelia burgdoferi
46	Anticorpi anti candida iga
47	Anticorpi anti candida igg
48	Anticorpi anti candida igm
49	Anticorpi anti cardiolipina iga
50	Anticorpi anti cardiolipina igg
51	Anticorpi anti cardiolipina igm
52	Anticorpi anti cellule apicali dello stomaco (apca)
53	Anticorpi anti centromero (aca)
54	Anticorpi anti citomegalovirus ig totali
55	Anticorpi anti citomegalovirus igg
56	Anticorpi anti citomegalovirus igm
58	Anticorpi anti clamydia iga
59	Anticorpi anti clamydia igg
60	Anticorpi anti clamydia igm
61	Anticorpi anti colon
63	Anticorpi anti coxackie (b1/b2/b3/b4/b5/b6) - ciascuno
62	Anticorpi anti coxackie (b1+b2+b3+b4+b5+b6) - tutti
64	Anticorpi anti dotti salivari
65	Anticorpi anti echinococco (echinotest)
66	Anticorpi anti echo virus
67	Anticorpi anti echo virus neurotropi ig totali
68	Anticorpi anti endomisio (iga,igm per ciascuno)
69	Anticorpi anti endotelio
70	Anticorpi anti entamoeba
74	Anticorpi anti epstein barr virus antigene capsidico (vca) igg
75	Anticorpi anti epstein barr virus antigene capsidico (vca) igm
76	Anticorpi anti epstein barr virus antigene early (ea)
77	Anticorpi anti epstein barr virus antigene nucleare (ebna)
71	Anticorpi anti epstein barr virus iga
72	Anticorpi anti epstein barr virus igg
73	Anticorpi anti epstein barr virus igm
78	Anticorpi anti eritrocitari attivi a freddo (crioagglutine)
79	Anticorpi anti fattore intrinseco
80	Anticorpi anti febbre q (per ogni anticorpo)
81	Anticorpi anti fosfolipidi (beta 2 glicoproteina igg/igm) - ciascuno
83	Anticorpi anti gad
84	Anticorpi anti giardia lamblia
85	Anticorpi anti gliadina iga
86	Anticorpi anti gliadina igg
87	Anticorpi anti gor (epitopo core dell'hcv)
88	Anticorpi anti hav igg
89	Anticorpi anti hav igm
90	Anticorpi anti hav totali
91	Anticorpi anti hbcag
92	Anticorpi anti hbcag igm
93	Anticorpi anti hbeag
94	Anticorpi anti hbs con titolazione
95	Anticorpi anti hbsag
96	Anticorpi anti hcv
97	Anticorpi anti hcv igm
98	Anticorpi anti helicobacter pylori igaanticorpi anti helicobacter pylori igg
99	Anticorpi anti helicobacter pylori igm
102	Anticorpi anti herpes simplex virus 1 e 2
100	Anticorpi anti herpes simplex virus 1 igg
101	Anticorpi anti herpes simplex virus 1 igm
103	Anticorpi anti herpes simplex virus 2 igg
104	Anticorpi anti herpes simplex virus 2 igm
105	Anticorpi anti hiv i e ii
106	Anticorpi anti htlv i e ii
107	Anticorpi anti ia2
108	Anticorpi anti influenza
109	Anticorpi anti insula pancreatica
110	Anticorpi anti insulina (aiaa)
111	Anticorpi anti istoni
112	Anticorpi anti legionelle (iga,igm per ciascuno)
113	Anticorpi anti leishmaniosi
114	Anticorpi anti leptospira
115	Anticorpi anti leucocitari (ricerca ed eventuale titolo)
116	Anticorpi anti listeria (4 anticorpi)
117	Anticorpi anti listeria (4 anticorpi) / ciascuno
118	Anticorpi anti membrana
119	Anticorpi anti micoplasma igg
120	Anticorpi anti micoplasma igm
121	Anticorpi anti microsoma epatico renale (lkm)
122	Anticorpi anti microsomiali (abtms)
123	Anticorpi anti mitocondri
124	Anticorpi anti morbillo ig totali
125	Anticorpi anti morbillo igg
126	Anticorpi anti morbillo igm
127	Anticorpi anti muscolo liscio
128	Anticorpi anti muscolo striato (cuore)
129	Anticorpi anti ndna
131	Anticorpi anti nucleo
132	Anticorpi anti nucleo estraibili (anti ena / 6 anticorpi)
133	Anticorpi anti ovaio
134	Anticorpi anti pancreas
137	Anticorpi anti parotite ig totali
135	Anticorpi anti parotite igg
136	Anticorpi anti parotite igm
139	Anticorpi anti parvovirus
138	Anticorpi anti perossidasi (abtpo)
140	Anticorpi anti piastrine (ricerca ed eventuale titolo)
141	Anticorpi anti plasmodi (anti malaria)
142	Anticorpi anti pneumococco
143	Anticorpi anti polisaccaride c streptococco b emol. Gr a
144	Anticorpi anti recettore del tsh (tr ab)
145	Anticorpi anti recettore per acetilcolina
146	Anticorpi anti rickettsie
147	Anticorpi anti rna
148	Anticorpi anti rosolia igg
149	Anticorpi anti rosolia igm
150	Anticorpi anti schistosoma
151	Anticorpi anti spermatozoi: plasma seminale
152	Anticorpi anti spermatozoi: sangue periferico
153	Anticorpi anti streptokinasi
154	Anticorpi anti surrene
155	Anticorpi anti testicoloanticorpi anti tetano
156	Anticorpi anti tireoglobulina (abtg)
157	Anticorpi anti toxoplasma iga
158	Anticorpi anti toxoplasma igg
159	Anticorpi anti toxoplasma igm
160	Anticorpi anti transglutaminasi
161	Anticorpi anti treponema pallido igg (fta abs)
162	Anticorpi anti treponema pallido igm (fta igm)
163	Anticorpi anti tripanosoma cruzi
164	Anticorpi anti varicella zoster virus ig totali
165	Anticorpi anti varicella zoster virus igg
166	Anticorpi anti varicella zoster virus igm
167	Anticorpi anti virus respiratorio sinciziale
57	Anticorpi anticitrullina
82	Anticorpi antifosfolipidici (ricerca)
130	Anticorpi anti-neutrofili citoplasmatici
168	Anticorpi igg/igm specifici (qualunque virus)
169	Antigene carboidratico 125 (ca 125 - antigene tumori ovarici)
170	Antigene carboidratico 15-3 (ca 15-3 / antigene tumori mammari)
171	Antigene carboidratico 195 (ca 195 / antigene tumori mammari)
172	Antigene carboidratico 19-9 (ca 19-9 - gica - antigene tumori gastrointestinali)
173	Antigene carboidratico 50 (ca 50)
174	Antigene carboidratico 549
175	Antigene carboidratico tag 72-4 (antigene tumori polmonare e gastrico)
176	Antigene carcinoembrionario (cea)
177	Antigene e virus epatite b (hbeag)
178	Antigene hla b27
179	Antigene p24 dell'hiv
180	Antigene polipeptidico tissutale (tpa) (specifico tps)
181	Antigene prostatico specifico (psa)
182	Antigene prostatico specifico free (free psa)
183	Antigene s virus epatite b (hbsag) (antigene australia)
184	Antigene ta 4 (scc)
185	Antigene tumorale vescicale (bta)
186	Antigene von willebrand
188	Antitrombina iii
187	Antitrombina iii qualitativa
2469	Antroatticotomia con labirintectomia
2801	Apicectomia (compresa cura canalare)
189	Apolipoproteina a
190	Apolipoproteina b
1465	Aponeurectomia, morbo di dupuytren
2548	Aportazione di leucoplachia
2748	Apparecchio laringofono
2821	Apparecchio scheletrato (struttura lnp o lp, comprensivo di elementi - per arcata)
1576	Appendicectomia con peritonite diffusa
1577	Appendicectomia semplice a freddo
2695	Applcazione di sfinteri artificiali incontinenza urinaria
2293	Applicazione di filo o chiodo transcheletrico
2709	Applicazione di protesi testicolare (come unico intervento)
2294	Applicazione di skin traction
1431	Applicazione di stent intracoronarico a completamento di angioplastica
191	Aptoglobina
1183	Areoionoterapia (per seduta)
1184	Areosolterapia (per seduta)
2272	Arto inferiore: coscia, gamba, piede (pelvipedidio) arto inferiore: gamba, piede (gambaletto)
2273	Arto inferiore: ginocchiera
2274	Arto superiore: avambraccio e mano
2275	Arto superiore: braccio, avambraccio e mano
2276	Arto superiore: torace ed arto superiore (toraco brachiale)
2323	Artrocentesi
2324	Artrocentesi con introduzione di medicamento
1466	Artrodesi carpale
1467	Artrodesi metacarpo-falangea e/o interfalangea
2325	Artrodesi vertebrale per via anteriore o spondilolistesi
2326	Artrodesi vertebrale per via posteriore
2327	Artrodesi vertebrale per via posteriore e anteriore
2328	Artrodesi: grandi articolazioni
2329	Artrodesi: medie articolazioni
2330	Artrodesi: piccole articolazioni
2331	Artrolisi: grandi articolazioni
2332	Artrolisi: medie articolazioni
2333	Artrolisi: piccole articolazioni
1468	Artroplastica
2334	Artroplastiche con materiali biologici: grandi articolazioni
2335	Artroplastiche con materiali biologici: medie articolazioni
2336	Artroplastiche con materiali biologici: piccole articolazioni
1469	Artroprotesi carpale
1470	Artroprotesi metacarpo-falangea e/o interfalangea
2340	Artroprotesi: anca parziale (trattamento completo)
2341	Artroprotesi: anca totale (trattamento completo)
2344	Artroprotesi: ginocchio
2345	Artroprotesi: gomito, tibiotarsica
2337	Artroprotesi: polso
2338	Artroprotesi: spalla, parziale
2339	Artroprotesi: spalla, totale
809	Artro-rm (grandi articolazioni) (compreso contrasto)
2348	Artroscopia diagnostica (come unico intervento)
2346	Artroscopia operativa
2347	Artroscopia operativa anca
1669	Artroscopia, artocentesi temporo-mandibolare
780	Artro-tc (grandi articolazioni)
2470	Ascesso cerebrale, apertura per via transmastoidea
2471	Ascesso del condotto, incisione di
1698	Ascesso del douglas, drenaggio
2557	Ascesso dell'epiglottide, incisione
2660	Ascesso dello spazio prevescicale del retzius
2472	Ascesso extradurale, apertura per via transmastoidea
2349	Ascesso freddo, drenaggio di
1492	Ascesso o flemmone diffuso, incisione di
1494	Ascesso o flemmone superficiale, incisione di
2133	Ascesso palpebre, incisione di
1968	Ascesso pelvico, trattamento chirurgico
2544	Ascesso peritonsillare, incisione
2545	Ascesso retro-faringeo o latero-faringeo
1699	Ascesso sub-frenico, drenaggio
1969	Aspirazione ecoguidata di cisti ovarica
2802	Asportazione cisti mascellari (per seduta)
1923	Asportazione con laser di cheratosi seborroiche (per seduta, qualunque numero)
1924	Asportazione con laser di tumori benigni cutanei o delle mucose esclusi quelli del viso (unica seduta)
1925	Asportazione con laser di tumori benigni del viso (unica seduta)
2149	Asportazione con plastica di tumori per innesto
2150	Asportazione con plastica di tumori per scorrimento
2152	Asportazione con plastica per scorrimento dello xantelasma
2160	Asportazione del sacco lacrimale o della ghiandola lacrimale
1670	Asportazione di calcolo salivare
1832	Asportazione di cisti (echinococco od altre)
2358	Asportazione di cisti del becker
1972	Asportazione di cisti della ghiandola del bartolini
2506	Asportazione di cisti e piccoli tumori benigni delle fosse nasali
2357	Asportazione di cisti meniscale o parameniscale
2127	Asportazione di cisti o corpi estranei
1523	Asportazione di cisti o fistola congenita
1973	Asportazione di cisti ovarica intralegamentosa
1497	Asportazione di cisti pilonidale
2121	Asportazione di cisti profonde o neoplasie contorno orbita
1974	Asportazione di cisti vaginale
2507	Asportazione di corpi estranei
2360	Asportazione di corpi estranei e mobili endoarticolari (come unico intervento)
2122	Asportazione di corpi estranei endoorbitali
1674	Asportazione di corpi estranei profondi di tessuti molli, cavità orale e/o faccia
1675	Asportazione di corpi estranei superficiali dei tessuti molli, cavità orale e/o faccia
2054	Asportazione di corpo estraneo intracranico
2803	Asportazione di epulide (per seduta)
2375	Asportazione di esostosi semplice
2478	Asportazione di fistole congenite
2434	Asportazione di gangli tendinei e/o artrogeni
1459	Asportazione di neoplasie e/o cisti benigne
2078	Asportazione di neoplasie endocraniche
2079	Asportazione di neoplasie endorachidee extradurali
1759	Asportazione di neoplasie maligne del labbro/guancia con svuotamento della loggia sottomascellare
1760	Asportazione di neoplasie maligne del labbro/guancia senza svuotamento della loggia sottomascellare
2488	Asportazione di osteomi del condotto
2144	Asportazione di piccoli tumori o cisti
2011	Asportazione di polipi cervicali
2491	Asportazione di polipi o cisti del padiglione o retroauricolari
1612	Asportazione di polipo rettale
1770	Asportazione di ranula
2551	Asportazione di tumore benigno faringotonsillare
1541	Asportazione di tumore maligno del collo
2552	Asportazione di tumore maligno faringotonsillare
1516	Asportazione di tumore profondo extracavitario
1926	Asportazione di tumore superficiale maligno (trattamento completo)
2535	Asportazione di tumori benigni dei seni paranasali
2115	Asportazione di tumori dei nervi periferici
2501	Asportazione di tumori dell'orecchio medio
2536	Asportazione di tumori maligni del naso o dei seni
2425	Asportazione di tumori ossei e forme pseudo tumorali, grandi segmenti o articolazioni
2426	Asportazione di tumori ossei e forme pseudo tumorali, medi segmenti o articolazioni
2427	Asportazione di tumori ossei e forme pseudo tumorali, piccoli segmenti o articolazioni
2428	Asportazione di tumori ossei e forme pseudo tumorali, vertebrali
1518	Asportazione di unghia incarnita,
2151	Asportazione di xantelasma semplice
2219	Asportazione e plastica di cisti iridee
2190	Asportazione ed impianto di cristallino artificiale pseudo accomodativo in camera anteriore o posteriore con correzione di difetti visivi e impianto di lente correttiva per cataratta
1731	Asportazione endoscopica litiasi biliare
1526	Asportazione per tumori maligni di ghiandola sottomascellare
1621	Asportazione per via sacrale di tumore del retto
1498	Asportazione radicale di cisti sinoviale
2516	Asportazione semplice di polipi nasali o coanali
2227	Asportazione, cerchiaggio, rimozione materiali usati durante l'intervento di distacco
2447	Assistenza al parto a domicilio da parte di ostetrica professionista
2448	Assistenza al parto a domicilio da parte di specialista ostetrico ginecologo
897	Assistenza anestesiologica agli esami radiologici
898	Assistenza anestesiologica agli esami radiologici (per seduta) compresa eventuale sedazione
831	Assistenza cardiologica a parte
921	Assistenza cardiologica intra-operatoria
2473	Atresia auris congenita completa
2474	Atresia auris congenita incompletacateterismo tubarico (per seduta)
192	Attività reninica attiva
193	Attività reninica plasmatici
194	Azotemia
195	Bacillo di koch: ricerca microscopica ed esame colturale
1212	Bagnoterapia (per seduta)
2258	Bendaggio alla colla di zinco: coscia, gamba e piede
2259	Bendaggio alla colla di zinco: gamba e piede
2260	Bendaggio collare di schanz
2261	Bendaggio con doccia di immobilizzazione: gomito e polso
2262	Bendaggio con doccia di immobilizzazione: in abduzione per arto superiore
2263	Bendaggio con doccia di immobilizzazione: per arto inferiore
2264	Bendaggio con medicazione
1893	Bendaggio elasto-compressivo arti inferiori
1718	Bendaggio gastrico regolabile per via laparoscopica
2265	Bendaggio secondo desault: amidato o gessato
2266	Bendaggio secondo desault: semplice
2267	Bendaggio semplice con ovatta e garza
2268	Bendaggio torace senza arto superiore
196	Beta 2 microglobulina nelle urine delle 24 ore
197	Beta 2 microglobulina plasmatici
1282	Betaterapia superficiale con radioisotopi artificiali (per seduta)
198	Bicarbonati
199	Bilirubina nel liquido amniotico (curva spettrofotometrica)
201	Bilirubinemia totale
200	Bilirubinemia totale e frazionata
1244	Biofeedback (per seduta)
538	Biologia molecolare
1036	Biometria
2350	Biopsia articolare
1654	Biopsia con laparotomia (come unico intervento)
893	Biopsia del linfonodo sentinella
1971	Biopsia della portio, vulva, vagina, endometrio
748	Biopsia ecoguidata (escluso esame citoistologico)
1432	Biopsia endomiocardica destra
1433	Biopsia endomiocardica sinistra
1732	Biopsia epatica con laparotomia (come unico intervento)
1495	Biopsia escissionale come unico atto chirurgico, qualsiasi parte anatomica, salvo i casi descritti
2804	Biopsia generica
946	Biopsia in corso di endoscopia escluso esame citoistologico
2558	Biopsia in laringoscopia
2559	Biopsia in microlaringoscopia
1829	Biopsia laterocervicale
1010	Biopsia muscolare
2119	Biopsia orbitaria
2351	Biopsia ossea
1522	Biopsia prescalenica
1113	Biopsia prostatica
1830	Biopsia sopraclaveare
781	Biopsia tac guidata escluso esame citoistologico
1114	Biopsia testicolare bilaterale
1115	Biopsia testicolare monolaterale
2352	Biopsia trans-peduncolare somi vertebrale
2353	Biopsia vertebrale a cielo aperto
1496	Biopsie (ogni tipo) successive alla prima
2849	Bite wing (massimo 4 per ogni piano di cura)
2134	Blefarocalasi o traumi o ferite, intervento di blefaroplastica: 1 palpebra
2135	Blefarocalasi o traumi o ferite, intervento di blefaroplastica: ogni altra palpebra
1168	Blocchi antalgici dei nervi periferici
1169	Blocchi antalgici del ganglio
1170	Blocchi antalgici del plesso
1167	Blocchi antalgici nervi cranici e loro rami
1166	Blocchi antalgici periarticolari e/o intrarticolari
1171	Blocchi antalgici tronculari del nervo
2354	Borsectomia
1283	Brachiterapia (courieterapia) interstiziale od endocavitaria o coronarica (prima seduta)
1284	Brachiterapia (courieterapia) interstiziale od endocavitaria o coronarica (sedute successive)
1285	Brachiterapia (courieterapia) superficiale (apparecchi modellati)
1286	Brachiterapia interstiziale con impianto permanente di semi radioattivi nella prostata (compreso costo dei semi)
202	Brain natriuretic peptide (bnp)
203	Breath test
1831	Broncoinstillazione endoscopica
1116	Brushing citologico compresa citoscopia
2589	Brushing citologico in cistoscopia (come unico intervento)
1406	Bypass aorto coronarici multipli
1407	Bypass aorto coronarico singolo
1895	By-pass aorto-anonima, aorto-carotideo, carotido-succlavio
1894	By-pass aorto-iliaco o aorto-femorale
1896	By-pass aorto-renale, aorto-mesenterico o celiaco ed eventuale tea e plastica vasale
1897	By-pass arterie periferiche: femoro-tibiali, axillo-femorale, femoro-femorale, femoro-popliteo
1580	By-pass gastro intestinali o intestinali per patologie maligne
1719	By-pass intestinali per il trattamento obesità patologica
948	C.p.r.e. Diagnostica
2136	Calazio
2355	Calcaneo stop
204	Calcemia
205	Calcio intraeritrocitario
206	Calcio ionizzato
207	Calcio nelle urine delle 24 ore
208	Calcitonina
2277	Calco di gesso per protesi arti
2597	Calcoli ureterali, estrazione con sonde apposite
209	Calcolo renale (analisi chimica)
210	Calprotectina fecale
211	Cam 26 (marcatore tumorale)
212	Cam 29 (marcatore tumorale)
2581	Cambio tubo cistostomico cambio tubo pielostomico
1037	Campimetria
2137	Cantoplastica
911	Capillaroscopia
912	Capillaroscopia con videoregistrazione
1273	Carbossiterapia
1408	Cardiochirurgia a cuore aperto, compresi aneurismi e sostituzioni valvolari multiple (c.e.c.)
1410	Cardiochirurgia a cuore chiuso (senza c.e.c.) - interventi di, salvo gli interventi descritti
979	Cardiotocografia (monitoraggio fetale)
980	Cariotipo su aborto
568	Cariotipo su sangue periferico (mappa cromosomica)
2049	Carotide endocranica, legatura della
2689	Caruncola uretrale
213	Catecolamine totali urinariecellule l.e. (ricerca nel sangue periferico)
1434	Cateterismo destro e sinistro, e calcolo portate e gradienti con coronarografia
1172	Cateterismo plessico per blocco continuo
2583	Cateterismo vescicale nella donna (come unico trattamento)
2582	Cateterismo vescicale nell'uomo con patologia stenotica (unico trattamento)
2560	Cauterizzazione endolaringea
2449	Cerchiaggio cervicale
214	Ch50
1787	Cheloidi di grandi dimensioni, asportazione di: con laser, (trattamento totale)
1786	Cheloidi di grandi dimensioni, asportazione di: con tecnica tradizionale
1788	Cheloidi piccole dimensioni asportazione di: con laser, (trattamento totale)
1789	Cheloidi piccole dimensioni asportazione di: con tecnica tradizionale
1142	Chemioterapia ambulatoriale antineoplastica (per seduta)
2356	Chemonucleolisi per ernia discale
1038	Cheratometria (come unico atto medico)
2175	Cheratoplastica a tutto spessore
2176	Cheratoplastica lamellare
1230	Chinesiterapia (per seduta)
2833	Chirurgia gengivale, per arcata (incluso qualsiasi tipo di lembo, inclusa sutura)
2834	Chirurgia muco gengivale o abbassamento di fornice, per arcata (incluso qualsiasi tipo di lembo, inclusa sutura)
2836	Chirurgia ossea (incluso il lembo di accesso, inclusa sutura) trattamento completo per quadrante
2248	Chirurgia refrattiva (qualunque tecnica) per 1 occhio
2249	Chirurgia refrattiva (qualunque tecnica) per 2 occhi
1436	Chiusura del forame ovale
2154	Chiusura del puntino lacrimale
2155	Chiusura del puntino lacrimale con protesi
2205	Ciclodialisi
2206	Ciclodiatermia perforante
810	Cine rm cuore
847	Cinetica leucocitaria con misure sulle sedi di cateresi
848	Cinetica piastrinica con misure sulle sedi di cateresi
2716	Circoncisione per fimosi con frenulo plastica
557	Cish: solo su prescrizione di specialista oncologo o chirurgo operante presso struttura pubblica
2661	Cistectomia parziale con ureterocistoneostomia
2662	Cistectomia parziale semplice
2663	Cistectomia totale compresa linfoadenectomia e prostatovesciculectomia o uteroannessectomia con ureterosigmoidostomia bilaterale o ureterocutaneostomia
2665	Cistectomia totale compresa linfoadenectomia e prostatovesciculectomia o uteroannessiectomia con ileo o colobladder
2666	Cistectomia totale compresa linfoadenectomia e prostatovessciculectomia o uteroannessiectomia con neovescica rettale compresa
1734	Cisti da echinococco multiple, pericistectomia
1735	Cisti da echinococco, ascessi epatici
1411	Cisti del cuore o del pericardio
2623	Cisti renale per via percutanea, puntura di
2624	Cisti renale, puntura evacuativa percutanea con iniezione di sostanze sclerosanti
2625	Cisti renale, resezione
2431	Cisti tendinea (come unico intervento)
1624	Cisti, ematomi, ascessi, neoplasia benigna, flemmoni parete addominale
692	Cistografia doppio contrasto
2668	Cistolitotomia (come uico intervento)
2669	Cistopessi
2670	Cistorrafia per rottura traumatica
1117	Cistoscopia compresa eventuale biopsia
2590	Cistoscopia ed eventuale biopsia
2671	Cistostomia sovrapubica
693	Cistoureterografia minzionale
215	Citologia urinaria
216	Citotossicità spontanea t e k / ciascuno
217	Citrato urinario nelle 24 ore
218	Clamydia (ricerca dna)
219	Clamydia (ricerca ed identificazione)
961	Clamydia su striscio vaginale: prelievo per ricerca
613	Clisma opaco
614	Clisma opaco a doppio contrasto
220	Cloremia
221	Cloro nelle urine
541	Cmv (citomegalovirus)
2698	Coagulazione di polipi del meato
222	Cobalto
949	Colangiografia retrograda endoscopica
811	Colangio-rm
1736	Colecistectomia per via laparoscopica
1737	Colecistectomia per via laparotomica
1738	Colecistogastrostomia o colecistoenterostomia
615	Colecistografia
1739	Colecistostomia per neoplasie non resecabili
1584	Colectomia segmentaria
1583	Colectomia segmentaria con linfoadenectomia ed eventuale colostomia
1586	Colectomia totale
1585	Colectomia totale con linfoadenectomia
1740	Coledoco-epatico digiunostomia con o senza colecistectomia
1741	Coledoco-epatico duodenostomia con o senza colecistectomia
1742	Coledoco-epatico-digiunoduodenostomia con o senza colecistectomia
1743	Coledoctomia e coledocolicotomia (come unico intervento)
223	Colesterolo hdl
224	Colesterolo ldl
225	Colesterolo totale
226	Colinesterasi (pseudo che)
2749	Collare cervicale
2598	Collo vescicale e prostata, resezione endoscopica del
2672	Collo vescicale, plastica y/v (come unico intervento)
2599	Collo vescicale, resezione per sclerosi recidiva
1555	Collocazione di protesi endo-esofagee
950	Colonscopia diagnostica
1938	Colonscopia totale operativa
1939	Colonscopia totale operativa con posizionamento endo-loop
1587	Colotomia con colorrafia (come unico intervento)
1976	Colpoperineorrafia per lacerazioni perineali
1975	Colpoperineorrafia per lacerazioni perineali interessanti il retto
962	Colposcopia più biopsia
963	Colposcopia più pap-test
1977	Colpotomia e svuotamento di raccolte ematiche e purolente
227	Coltura linfocitaria
1412	Commissurotomia per stenosi mitralica
228	Complemento c3 proattivatore
229	Complemento frazione c 1 inibitore
230	Complemento frazione c1 q
231	Complemento frazione c3
232	Complemento frazione c4
2052	Compressione del g. Di gasser con palloncino fogarky
1671	Condilectomia (come unico intervento)
1673	Condilectomia con condiloplastica per anchilosi dell'articolazione temporo mandibolare bilaterale
1672	Condilectomia con condiloplastica per anchilosi dell'articolazione temporo-mandibolare monolaterale
2359	Condrectomia
1588	Confezionamento di ano artificiale (come unico intervento)
1589	Confezionamento di ilestomia continente (come unico intervento)
1978	Conizzazione e tracheloplastica
233	Conta batterica in materiali biologici (conta colonie)
234	Conta di addis
235	Conteggio dei reticolociti
236	Conteggio delle piastrine
1287	Contornazione del target e degli organi critici per piani 3d, valutazione radioterapica dei piani 3d
1288	Contornazione del target e degli organi critici per piani imrt, valutazione radioterapica dei piani imrt e validazione
812	Contrasto paramagnetico
782	Contrasto per tomografia assiale
1437	Controllo elettronico del pace maker impiantato (compresa consulenza ingegnere)
1413	Contropulsazione aortica mediante incannulamento arterioso
2561	Corde vocali, decorticazione in microlaringoscopia
2562	Cordectomia
2563	Cordectomia con il laser
2451	Cordocentesi
749	Core biopsy (compresa ecografia)
783	Coronaro tc
1438	Coronarografia + ventricolografia sinistra + cateterismo sinistro
1439	Coronarografia circolo nativo + studio selettivo di by-pass venosi ed arteriosi + ventricolografia sinistra + cateterismo sinistro
2476	Corpi estranei dal condotto, asportazione per via naturale con lavaggio
2477	Corpi estranei dal condotto, asportazione strumentale
2177	Corpi estranei dalla cornea, estrazione di
2546	Corpi estranei endofaringei, asportazione di
2564	Corpi estranei, asportazione in laringoscopia
2475	Corpi estranei, asportazione per via chirurgica retroauricolare
1499	Corpo estraneo profondo extracavitario, estrazione di
1500	Corpo estraneo superficiale, estrazione di
1676	Correzione di esiti di labioschisi
1677	Correzione di naso da labioschisi
1267	Correzione incruenta del disallineamento vertebrale (per seduta)
1790	Correzioni di cicatrici del tronco o degli arti di grandi dimensioni (escluso espansore)
1791	Correzioni di cicatrici del viso di grandi dimensioni
2278	Corsetto con spalle
2750	Corsetto ortopedico
2751	Corsetto ortopedico per scoliosi
2279	Corsetto senza spalle
2280	Corsetto speciale per scoliosi e/o cifosi
2281	Corsetto tipo minerva
237	Cortisolo plasmatico
238	Cortisolo urinario
2362	Costruzione di monconi cinematici
1940	Cpre operativa
2055	Cranioplastica
2056	Craniotomia a scopo decompresssivo/esplorativo
2057	Craniotomia per ematoma extradurale
2058	Craniotomia per lesioni traumatiche intracerebrali
2059	Craniotomia per tumori cerebellari, anche basali
240	Creatinfosfochinasi (cpk)
239	Creatinfosfochinasi isoenzimi
241	Creatinfosfochinasi-mb (cpk-mb)
242	Creatinfosfochinasi-mb massa
243	Creatinina clearance
244	Creatinina nel liquido amniotico
245	Creatinina nelle urine delle 24 ore
246	Creatininemia
1213	Crenoterapia (per seduta)
248	Crioagglutinine (dosaggio)
2207	Crioapplicazione antiglaucomatosa
2179	Crioapplicazioni corneali
249	Crioglobuline (ricerca)
1259	Crioterapia (per seduta)
2228	Criotrattamento (come unico intervento)
2193	Cristallino artificiale, impianto secondario in camera anteriore
2194	Cristallino artificiale, impianto secondario in camera posteriore
2195	Cristallino artificiale, rimozione dalla camera anteriore (come unico intervento)
2196	Cristallino artificiale, rimozione dalla camera posteriore (come unico intervento)
569	Cromatina sessuale
250	Cromo sierico
1118	Cromocistoscopia e cateterismo ureterale bilaterale
2591	Cromocistoscopia e cateterismo ureterale bilaterale
1119	Cromocistoscopia e cateterismo ureterale monolaterale
2592	Cromocistoscopia e cateterismo ureterale monolaterale
2593	Cromocistoscopia per valutazione funzionale
251	Cromogranina a
1011	Cronassia
254	Cross links urinari
252	Cross-links del piridinio
253	Cross-links del piridinolinio
1501	Cuoio capelluto, vasta ferita e scollamento del
2515	Cura chirurgica dell'ozena
2684	Cura per affezione della prostata con prostathermer (per ciclo di cura annuale)
1519	Cura radicale di unghia incarnita
255	Curva delle gonadotropine (fsh+lh) dopo somministrazione di gnrh
256	Curva delle gonadotropine (fsh+lh) senza somministrazione di farmaco di stimolo (3 dosaggi)
257	Curva glicemica da carico (5 dosaggi / sostanza compresa)
258	Curva insulinemica da carico (5 dosaggi / sostanza compresa)
259	Curva prolattina dopo somministrazione di trh (minimo 5 dosaggi) (escluso farmaco)
1039	Curva tonometrica
260	Curva tsh dopo somministrazione di trh (minimo 5 dosaggi) (escluso farmaco)
1133	Cvc per dialisi
261	Cyfra 21/1
2156	Dacriocistorinostomia o intubazione
262	D-dimero
1744	Dearterializzazione epatica, con o senza chemioterapia
1745	Deconnessione azygos-portale per via addominale
616	Defecografia
2753	Defibrillatore cardiaco impiantabile
922	Defibrillazione o cardioversione elettrica (escluso anestesista)
2432	Deformità ad asola
263	Deidroepiandrosterone (dea)
264	Deidroepiandrosterone solfato (deas)
2282	Delbet
265	Delta 4 androstenedione sierico (d4)
1979	Denervazione vulvare
1655	Denervazioni pancretiche, (come unico intervento)
773	Densitometria mineralometria ossea (moc)
774	Densitometria ortopedica periprotesica
775	Densitometria ossea (moc) total body
776	Densitometria ossea (moc) vertebrale e/o femorale
784	Dentalscan 1 arcata
785	Dentalscan 2 arcata
1656	Derivazione pancreatico-wirsung digestive
266	Desossipiridonilinio urinario
871	Determinazione del flusso regionale quantitativo
849	Determinazione del volume eritrocitario
850	Determinazione del volume plasmatico
913	Determinazione transcutanea pressione parziale o2 (tcpo2) arti inferiori
914	Determinazione transcutanea pressione parziale o2 (tcpo2) arti inferiori e superiori
915	Determinazione transcutanea pressione parziale o2 (tcpo2) arti superiori
2719	Detorsione del funicolo
1199	Diadinamica (per seduta)
2508	Diaframma coanale osseo, asportazione per via transpalatina
2565	Diaframma laringeo, escissione con ricostruzione plastica
900	Diagnostica strumentale allergologia - test in vivo
910	Diagnostica strumentale angiologia
920	Diagnostica strumentale cardiologia
937	Diagnostica strumentale dermatologia
941	Diagnostica strumentale endocrinologia
943	Diagnostica strumentale gastroenterologia
1009	Diagnostica strumentale neurologia
1034	Diagnostica strumentale oculistica (effettuata da medico specialista oculista)
1069	Diagnostica strumentale ortopedia
1072	Diagnostica strumentale otorinolaringoiatria
1088	Diagnostica strumentale pneumologia
1110	Diagnostica strumentale urologia
899	Diagnostiche specialistiche
1134	Dialisi domiciliare (per seduta)
1625	Diastasi dei retti, intervento per (come unico intervento)
1200	Diatermia (per seduta)
1980	Diatermocoagulazione della portio uterina o vulva
2691	Diatermocoagulazione di condilomi uretrali con messa a piatto dell'uretra
1928	Diatermocoagulazione o crioterapia per una o più lesioni, alterazioni, neoformazioni, cheratosi seborroiche (per seduta, qualunque numero)
2229	Diatermocoagulazione retinica per distacco
1201	Diatermoterapia (per seduta)
267	Diidrotestosterone (dht)
1981	Dilatazione del collo e applicazione di tubetto di petit- leufour endouterino
1941	Dilatazione graduale del retto (per seduta)
2566	Dilatazione laringea (per seduta)
2364	Disarticolazione interscapolo toracica
2365	Disarticolazioni, grandi articolazioni
2366	Disarticolazioni, medie articolazioni
2367	Disarticolazioni, piccole articolazioni
2192	Discissione di cataratta secondaria
2805	Disinclusione denti ritenuti (per ciascun elemento)
2433	Dito a martello
1721	Diversione bilio pancreatica con duodenal switch (dopo slevee gastrectomy)
1720	Diversione bilio pancreatica laparoscopica (standard sec scopinaro o con duodenal switch)
2673	Diverticulectomia
268	Dopamina plasmatica
269	Dopamina urinaria
270	Dosaggio di farmaci nel sangue per monitoraggio (per ogni determinazione)
1834	Drenaggi di mediastiniti acute o croniche o di ascessi
1746	Drenaggio bilio digestivo intraepatico
1835	Drenaggio cavità empiematica
1653	Drenaggio di ascessi pancreatici
2363	Drenaggio ematoma profondo organizzato sottofasciale
1219	Drenaggio linfatico manuale (per seduta)
1414	Drenaggio pericardico o riapertura per sanguinamento
1836	Drenaggio pleurico per emo e/o pneumotorace traumatico
1837	Drenaggio pleurico per pneumotorace spontaneo
965	Duo test
1657	Duodeno cefalo pancreatectomia compresa eventuale linfoadenectomia
1593	Duodeno digiunostomia (come unico intervento)
542	Ebv (epstein barr virus)
983	Ecocardiografia fetale (non ripetibile nel corso della gravidanza)
750	Ecocardiogramma
923	Ecocardiogramma transesofageo colordoppler
924	Ecocardiogramma transtoracico m-b e colordoppler
984	Ecocolordoppler fetale
751	Ecocolordoppler per ogni organo o apparato
752	Ecocolordoppler per ogni organo o apparato succesivo nella stessa seduta
753	Ecocolordoppler tronchi sovraortici
754	Ecoendoscopia operativa
746	Ecografia / doppler / ecodoppler / colordoppler
755	Ecografia addome completo
756	Ecografia addome inferiore
757	Ecografia addome superiore
758	Ecografia di organo o apparato successivo nella stessa seduta
759	Ecografia di organo o apparatoecografia endovasale
985	Ecografia fetale (massimo 4 per l'intero ciclo di gravidanza) #
760	Ecografia mammaria bilaterale
986	Ecografia morfologica (non ripetibile nel corso della gravidanza)
762	Ecografia peniena
761	Ecografia peniena dinamica (farmacologica)
763	Ecografia prostatica sovrapubica
765	Ecografia transesofagea
764	Ecografia transrettale
766	Ecografia transvaginale
925	Eco-stress
1898	Elefantiasi degli arti
926	Elettrocardiogramma basale
927	Elettrocardiogramma dinamico secondo holter 24 ore
928	Elettrocardiogramma dinamico secondo holter 48 ore
2601	Elettrocoagulazione di piccoli tumori vescicali (per seduta)
1012	Elettroencefalogramma con analisi spettrale
1013	Elettroencefalogramma con sonno farmacologico
1014	Elettroencefalogramma dinamico 24 ore
1015	Elettroencefalogramma standard o con sensibilizzazione
271	Elettroforesi della emoglobinaelettroforesi delle lipoproteine (lipidogramma)
272	Elettroforesi delle proteine urinarie (compreso dosaggio proteine tot.)
273	Elettroforesi delle sieroproteine (protidogramma)
2138	Elettrolisi delle ciglia (massimo due sedute)
1040	Elettromiografia
1016	Elettromiografia (2 segmenti)
1017	Elettromiografia (per segmento)
1018	Elettromiografia completa senza distinzione di segmento
1019	Elettromiografia ed elettroneurografia degli arti superiori e/o inferiori
1120	Elettromiografia sfinterica
1020	Elettroneurografia con velocità conduzione motoria e sensitiva (ad arto)
1041	Elettronistagmografia
1042	Elettrooculogramma (eog)
1043	Elettrooculomotilogramma (eomg)
1044	Elettroretinogramma dinamico (erg dinamico)
1045	Elettroretinogramma standard (erg standard)
1202	Elettrosonoterapia (per seduta)
1203	Elettrostimolazioni esponenziali (per seduta)
1198	Elettroterapia
1204	Elettroterapia (per seduta)
2713	Emasculatio totale ed eventuale linfoadenectomia
1502	Ematoma superficiale, svuotamento di
1503	Ematomi profondi extracavitari, svuotamento di
1415	Embolectomia con fogarty
1899	Embolectomia e/o trombectomia arteriosa o vene profonde o cava
2452	Embryo-transfer prestazione riconosciuta solo per l'atto operativo, non per le
1594	Emicolectomia destra con linfoadenectomia
1595	Emicolectomia sinistra con linfoadenectomia ed eventuale colostomia
2626	Eminefrectomia
2369	Emipelvectomia
2370	Emipelvectomie â€œinterneâ€ con salvataggio dell'arto
274	Emoagglutinazione treponema pallidum (tpha)
275	Emocoltura
1135	Emodialisi (per seduta)
1377	Emofiltrazioni depurative
1089	Emogasanalisi arteriosa basale (ph, po2, pco2 bicarbonati, compreso prelievo)
1090	Emogasanalisi arteriosa sotto sforzo (compreso prelievo)
1091	Emogasanalisi durante respirazione di o2 (compreso prelievo)
1092	Emogasanalisi prima e dopo iperventilazione (compreso prelievo)
276	Emoglobina (hb)
277	Emoglobina a2 (emoglobina patologica)
278	Emoglobina glicosilata hba 1c
279	Emoglobina nel liquido amniotico
280	Emoglobine alcali resistente
281	Emoglobine fetali (dosaggio)
1596	Emorroidi (trattamento con legatura elastica)
1597	Emorroidi e/o ragadi intervento radicale (qualsiasi tecnica)
1598	Emorroidi interne, iniezione sclerosanti delle (a seduta)
2790	Endodonzia (prestazione a due canali) (comprese rx)
2792	Endodonzia (prestazione a quattro canali) (comprese rx)
2791	Endodonzia (prestazione a tre canali) (comprese rx)
2789	Endodonzia (prestazione ad un canale) (comprese rx)
1838	Enfisema bolloso, trattamento chirurgico
282	Enolasi neurone specifica (nse)
951	Enteroscopia con videocapsula
1599	Enterostomia (come unico intervento)
2139	Entropion-ectropion
2244	Enucleazione con innesto protesi mobile
2245	Enucleazione o exenteratio
1681	Enucleoresezione di formazioni cistiche endoparotidee
283	Eparina
2140	Epicanto-coloboma
2180	Epicheratoplastica
2714	Epididimectomia
2371	Epifisiodesiernia del disco dorsale e/o lombare
1245	Ergoterapia (per seduta)
1378	Eritro aferesi terapeutica
284	Eritropoietina
1626	Ernia crurale recidiva (comprensiva di ernioplastica protesica)
1627	Ernia crurale semplice (comprensiva di ernioplastica protesica)
1628	Ernia crurale strozzata (comprensiva di ernioplastica protesica)
2063	Ernia del disco dorsale per via laterale
2372	Ernia del disco dorsale per via transtoracica
2064	Ernia del disco dorsale per via trans-toracica
2065	Ernia del disco intervertebrale cervicale, mielopatie, radiculopatie
2066	Ernia del disco per via anteriore con artrodesi intersomatica
1629	Ernia diaframmatica
1630	Ernia epigastrica (comprensiva di ernioplastica protesica)
1631	Ernia epigastrica strozzata o recidiva (comprensiva di ernioplastica protesica)
1564	Ernia iatale, interventi per (compresa plastica antireflusso)
1632	Ernia inguinale bilaterale (comprensiva di ernioplastica protesica)
1633	Ernia inguinale con ectopia testicolare (comprensiva di ernioplastica protesica)
1634	Ernia inguinale recidiva (comprensiva di ernioplastica protesica)
1635	Ernia inguinale semplice (comprensiva di ernioplastica protesica)
1636	Ernia inguinale strozzata (comprensiva di ernioplastica protesica)
1637	Ernia ombelicale
1638	Ernia ombelicale recidiva
2141	Ernia palpebrale, correzione con riduzione di sovrabbondanza cutanea: 1 palpebra (escluse finalità estetiche)
2142	Ernia palpebrale, correzione con riduzione di sovrabbondanza cutanea: ogni altra palpebra (escluse finalità estetiche)
1839	Ernie diaframmatiche traumatiche
2143	Ernie palpebrali, correzione di (escluse finalità estetiche)
1639	Ernie rare (ischiatica, otturatoria, lombare, perineale)
1073	Esame audiometrico
1070	Esame baropodometrico dinamico
1071	Esame baropodometrico statico
285	Esame batteriologico liquido prostatico (ricerca su vetrino)
286	Esame batterioscopico (ricerca su vetrino)
287	Esame batterioscopico tampone (ricerca su vetrino)
594	Esame citologico per diagnostica ormonale
595	Esame citologico per diagnostica tumorale
1074	Esame cocleo vestibolare semplice
288	Esame colturale materiale biologico
289	Esame colturale materiale biologico + antibiogramma
290	Esame colturale micoplasmi
297	Esame completo del liquido seminale con indice di capacitazione
1046	Esame del senso cromatico (come unico atto medico)
1047	Esame del senso luminoso (come unico atto medico)
2852	Esame diretto ghiandole salivari
2853	Esame elettromiografico
291	Esame emocromocitometrico completo con formula
292	Esame feci: chimico, fisico e parassitologico
293	Esame he4 (uman epididymis protein 4)
295	Esame immunoistochimico su preparato biologico
596	Esame istologico con inclusione
597	Esame istologico con inclusione: ogni inclusione in più
598	Esame istologico estemporaneo max 3 inclusioni
599	Esame istologico estemporaneo ogni inclusione successiva (oltre il terzo)
294	Esame jak2
2854	Esame kinesiografico
296	Esame liquido cefalorachidiano
298	Esame liquido seminale completo per studio fertilità
299	Esame liquido seminale con indice di fertilità (spermiogramma)
300	Esame liquido sinoviale
301	Esame microscopico dei peli e squame cutanee per micosi
302	Esame microscopico diretto su cellofan adesivo per ossiuri
303	Esame microscopico flora microbica (eventuale arricchimento)
1048	Esame ortottico completoesercizi ortottici (per seduta)
1075	Esame per adattamento protesico
304	Esame phi (indice di salute prostatica)
1076	Esame spettrografico della voce
305	Esame urine chimico, fisico e microscopico completo
1121	Esame urodinamico completo (compresi eventuali test farmacologici)
2584	Esame urodinamico completo (compresi eventuali test farmacologici)
1077	Esame vestibolare con eng (qualunque tecnica)
1545	Esofagectomia totale con esofagoplastica, in un tempo, compresa linfoadenectomia
1549	Esofago-gastrectomia totale, per via toraco-laparotomica ed eventuale linfoadenectomia
952	Esofagogastroduodenoscopia e test rapido per h. Pylori
1942	Esofagogastroduodenoscopia operativa
1550	Esofagogastroplastica-esofagodigiunoplastica- esofagocoloplastica (sostitutiva o palliativa)
1551	Esofagostomia
1049	Esolftalmometria
1504	Espianto di catetere peritoneale
1143	Espianto di cvc
2389	Espianto di midollo osseo
1144	Espianto di sistemi venosi impiantabili tipo port - a - cath, groshong ed altri (come unico intervento)
2726	Esplorazione scrotale noduli testicolari
306	Estradiolo (e2 o 17 beta)
2715	Estrazione chirurgica di spermatozoi testicolari
2600	Estrazione cistoscopica di corpi estranei vescicali
1591	Estrazione con sfinterotomia di corpi estranei
2242	Estrazione di corpo estraneo endobulbare calamitabile
2243	Estrazione di corpo estraneo endobulbare non calamitabile
2197	Estrazione di cristallino lussato-cataratta complicata
2806	Estrazione di dente in soggetto sottoposto a narcosi in circuito
2808	Estrazione di dente o radice in inclusione ossea totale
2178	Estrazione in camera anteriore di corpi estranei
1590	Estrazione per via addominale di corpi estranei del retto
988	Estriolo plasmatico
989	Estriolo urinario
2674	Estrofia vescicale (trattamento completo)
309	Estrone
2509	Etmoide, svuotamento radicale bilaterale
2510	Etmoide, svuotamento radicale monolaterale
2246	Eviscerazione con impianto intraoculare
1982	Eviscerazione pelvica
1078	Evoked response audiometry (e.r.a.)
2123	Exenteratio orbitae
1983	Exeresi di cisti ovarica per via laparoscopica
1756	Exeresi di neoformazioni endossee di grandi dimensioni
2484	Exeresi di neoplasia del padiglione
1749	Exeresi di papilla di vater
1715	Exeresi di tumore retroperitoneale
2710	Exeresi per cisti del funicolo, didimo ed epididimo
310	Faber test (ricerca ige specifiche) qualunque numero
1260	Fangoterapia (per seduta)
2230	Farmaco per iniezione intravitreale (rimborso pari all' 80% della spesa sostenuta)
1900	Fasciotomia decompressiva
311	Fattore reumatoide (reuma test)
312	Fattori della coagulazione (f, ii, vii, viii, ix, x, xi, xii, xiii)
313	Fenomeno l.e.
314	Fenotipo rh (compreso du)
1506	Ferita profonda, sutura di
1507	Ferita superficiale della faccia, sutura di
1508	Ferita superficiale, sutura di
1840	Ferita toraco-addominale con lesioni viscerali
1841	Ferita toraco-addominale senza lesioni viscerali
1842	Ferite con lesioni viscerali del torace
315	Ferritina
316	Ferro urinario
2511	Fess per trattamento di sinusopatie croniche e/o poliposi
2454	Fetoscopia
317	Fibrinogeno
318	Fibrinopeptide a
1079	Fibrolaringoscopia
2547	Fibroma rinofaringeo
767	Fibroscan
1290	Film di verifica in corso di trattamento (massimo uno a settimana)
319	Filtrato glomerulare
991	Fish amniociti in interfase 2 sonde
992	Fish amniociti in interfase 4 sonde
993	Fish con altre sonde
570	Fish con altre sonde*
571	Fish su liquido seminale*
559	Fish: (fluorescent in situ hybridization) - solo su prescrizione di specialista oncologo o chirurgo operante
1274	Fisioterapia secondo souchard (per seduta)
1678	Fissazione con ferule di elementi dentali lussati (per arcata)
1600	Fistola anale extrasfinterica
1601	Fistola anale intrasfinterica
2067	Fistola liquorale
2676	Fistola sovrapubica, intervento per (come unico intervento)
1602	Fistole anali, laserchirurgia per trattamento (completo)
2068	Fistole artero venose, terapia chirurgica con legatura vaso afferente extra cranico
2069	Fistole artero venose, terapia chirurgica con legatura vaso afferente intra cranico
2070	Fistole artero venose, terapia chirurgica per aggressione diretta
2512	Fistole oro antrali
2717	Fistole scrotali o inguinali
1680	Fistole trans-alveolari, plastiche cutanee delle
2694	Fistole uretrali
1261	Fitoterapia (per seduta)
2158	Flemmone, incisione di (come unico intervento)
1050	Fluorangiografia del segmento anteriore (compreso anestetista)
1051	Fluorangiografia della retina (compreso anestetista)
320	Fluoro
768	Flussimetria + ecografia
1682	Fornice gengivale superiore o inferiore, plastica del
324	Fosfatasi acida
323	Fosfatasi acida prostatica
321	Fosfatasi acida prostatica compresa la totale
322	Fosfatasi acida prostatica ria (pap)
326	Fosfatasi alcalina
325	Fosfatasi alcalina isoenzimi
327	Fosfati clearance
328	Fosfaturia
329	Fosfoesoso isomerasi (phi)fosfolipasi a
330	Fosfolipidemia
331	Fosfolipidi nel liquido amniotico (fosfoatidilglicerolo)
332	Fosforemia
1683	Fossa pterigo-mascellare, chirurgia della
2210	Fotosclerectomia con laser ad eccimeri (per 2 occhi)
2209	Fotosclerectomia con laser ad eccimeri (per occhio)
1207	Fototerapia
1845	Fratture costali o sternali, trattamento chirurgico
1846	Fratture costali o sternali, trattamento conservativo
1685	Fratture della mandibola e del condilo, terapia chirurgica delle
1471	Fratture e lussazioni dei metacarpi e falangi, trattamento cruento
1472	Fratture e lussazioni dei metacarpi e falangi, trattamento incruento
1473	Fratture e lussazioni del polso, trattamento cruento
1474	Fratture e lussazioni del polso, trattamento incruento
1686	Fratture mandibolari, riduzione con ferule
1687	Frenulotomia con frenuloplastica superiore ed inferiore
2718	Frenulotomia e frenuloplastica
2809	Frenulotomia o frenulectomia
333	Fruttosamina (proteine glicate)
334	Fruttosio su liquido spermatico
335	Gamma glutamil transpeptidasi (gamma gt)
336	Gamma glutamil transpeptidasi isoenzimi
337	Gamma glutamil transpeptidasi urinaria
2071	Gangliectomia lombare e splancnicectomia
1566	Gastrectomia totale con linfoadenectomia
1722	Gastrectomia verticale laparoscopica (slevee gastrectomy)
1723	Gastric by-pass per via laparoscopica
338	Gastrina
1567	Gastro-enterostomia per neoplasie non resecabili
1568	Gastrostomia
563	Genetica e genetica molecolare
2838	Gengivectomia (per quadrante come unica prestazione)
572	Genotipizzazione del locus apoe dell'alzheimer
1525	Ghiandola sottomascellare, asportazione per infiammazioni croniche o neoplasie benigne
339	Giardia lamblia ricerca nelle feci
1792	Ginecomastia bilaterale
1793	Ginecomastia monolaterale
1231	Ginnastica correttiva (per seduta)
1232	Ginnastica medica (non a scopo estetico) (per seduta)
1275	Ginnastica posturale (per seduta)
1233	Ginnastica propriocettiva (per seduta)
1234	Ginnastica respiratoria (per seduta)
1235	Ginnastica segmentaria (per seduta)
1214	Ginnastica vascolare idrica (per seduta)
2754	Ginocchiera articolata post intervento chirurgico al ginocchio
341	Glicemia
340	Glicemia o glicosuria frazionata nelle 24 ore a campione
342	Glicerofosforilcolina
343	Globulina legante gli ormoni sessuali (sex hormon binding globulin - shbg)
344	Globulina legante la tiroxina (tbg)
345	Glucagone
346	Glucosio 6 fosfato deidrogenasi (g6pdh)
347	Glucosio nel liquido amniotico
348	Glutatione reduttasi
350	Gonadotropina corionica (hcg)
1052	Gonioscopia
2208	Goniotomia
353	Gruppo sanguigno ab0 e fattore rh (con 2 anticorpi)
2283	Gypsotomia
1603	Hartmann, intervento
545	Hbv dna polimerasi
543	Hbv dna qualitativo
544	Hbv dna quantitativo
548	Hcv (epatite c) genotipo
546	Hcv (epatite c) qualitativo
547	Hcv (epatite c) quantitativo
354	Helicobacter pylori (ricerca diretta su materiale bioptico)
549	Helicobacter pylori amplificazione genica
355	Helicobacter pylori ricerca nelle feci
967	Herpes su striscio vaginale: prelievo per ricerca
550	Hiv rna qualitativo
551	Hiv rna quantitativo
553	Hpv - b19 (parvo virus)
552	Hpv - b19 genotipo
968	Hpv (materiale biologico) dna test compreso prelievo
573	Hpv (materiale biologico) mrna (tipi 16 - 18 - 31 - 35 - 51) compreso prelievo
969	Hpv (materiale biologico) mrna (tipi 16-18-31-35-51) compreso prelievo
1215	Idrochinesiterapia (per seduta)
1276	Idrocolonterapia (per seduta)
1216	Idrogalvanoterapia (per seduta)
1217	Idromassoterapia (per seduta)
357	Idrossiprolinuria
356	Idrossiprolinuria ii minzione
1211	Idroterapia
1985	Idrotubazione medicata (per seduta)
1604	Ileostomia (come unico intervento)
1986	Imenotomia-imenectomia (come unico intervento)
1291	Immobilizzazione con casco stereotassico (compreso anestesista)
600	Immuno fenotipo di popolazioni cellulari neoplastiche (per ogni anticorpo)
601	Immuno fenotipo di popolazioni linfocitarie (linfoma)
358	Immunoanticorpi anti eritrocitari (identificazione)
359	Immunocomplessi circolanti
360	Immunocomplessi hbsag/hbsab / igm
362	Immunoelettroforesi delle urine
361	Immunofissazione sierica
365	Immunoglobuline a
363	Immunoglobuline a secretorie in altri liquidi biologici
364	Immunoglobuline a secretorie nella saliva
366	Immunoglobuline d
368	Immunoglobuline e screening max 7 allergeni
370	Immunoglobuline e specifiche.
367	Immunoglobuline e totali
373	Immunoglobuline g
371	Immunoglobuline g sottoclasse 2 e 3 ciascuna
372	Immunoglobuline g specifiche allergologiche
374	Immunoglobuline liquor (igg/igm/iga) - ciascuna
375	Immunoglobuline m
376	Immunoglobuline superficie linfocitarie
953	Impedenzometria
1080	Impedenzometria timpanica
1510	Impianto chirurgico di catetere peritoneale
1145	Impianto di cvc (come unica prestazione)
929	Impianto di loop recorder sottocutaneo (omnicomprensivo)
1450	Impianto di protesi mammaria in seguito a mastectomia per neoplasia maligna
1146	Impianto di sistemi venosi impiantabili tipo port - a - cath, ed altri simili (come unica prestazione) con eventuale guida ecografica
2816	Impianto osteointegrato ricoperti in ceramica, carbon-vitreous, idrossiapatite, titanio puro) per elemento
2159	Impianto tubi di silicone nella stenosi delle vie lacrimali
1185	Inalazioni (per seduta)
1747	Incannulazione dell'arteria epatica per perfusione antiblastica
2793	Incappucciamento della polpa
2161	Incisione del sacco lacrimale (come unico intervento)
1449	Incisione di ascesso mammario
1493	Incisione di ascesso o flemmone sottoaponeurotico
1966	Incisione e drenaggio di ascessi delle ghiandole vulvari o cisti ghiandola
1521	Incisione e drenaggio di ascessi, favi, flemmoni (trattamento completo)
2603	Incontinenza urinaria, intervento (teflon)
1987	Incontinenza urinaria, intervento per via vaginale o addominale
2377	Infiltrazione anca
2378	Infiltrazione articolare
2379	Infiltrazione tc guidata
1208	Infrarossi (per seduta)
1156	Infusione di farmaci in cavità naturali con o senza evacuazione di liquidi biologici/patologici o terapia endovescicale con cateterismo,  unica seduta
2755	Infusore continuo di farmaci antiblastici
377	Inibina b
1794	Iniezione compositi
2072	Iniezione di botulino per patologia neurologica (non per fini estetici) per seduta
1901	Iniezione endoarteriosa
2722	Iniezione endocavernosa
2124	Iniezione endorbitale
1795	Iniezione intracheloidea
2231	Iniezione intravitreale (il costo del farmaco viene rimborsato a parte previa presentazione di documento di spesa idoneo e dettagliato)
1902	Iniezione sclerosante
2167	Iniezione sottocongiuntivale
2839	Innesto autogeno (sito multiplo incluso lembo di accesso)
1796	Innesto dermo epidermico adiposo o cutaneo libero o di mucosa
1797	Innesto di fascia lata
2840	Innesto di materiale biocompatibile (qualunque numero o sede degli impianti)
1798	Innesto di nervo o di tendine
2181	Innesto membrana amniotica
1799	Innesto osseo o cartilagineo
2455	Inseminazione artificiale intrauterina (solo per le iscritte alla cassa)
1847	Instillazione medicamentosa endopleurica isolata
2514	Instillazione sinusale (per ciclo di terapia)
1988	Insufflazione tubarica
1186	Insufflazioni endotimpaniche (per seduta)
378	Insulina (dosaggio)
2794	Intarsi l.p. / inlay od onlay
379	Interferone
380	Interleuchina 2
1963	Interventi conservativi di annessiectomia bilaterale
1964	Interventi conservativi di annessiectomia bilaterale, interventi demolitivi diannessiectomia monolaterale
1965	Interventi demolitivi di annessiectomia monolaterale
2053	Interventi di cordotomia, rizotomia e affezioni mieloradicolari varie
1844	Interventi di fistole esofago-bronchiali
2723	Interventi di legatura per impotenza da fuga venosa
1563	Interventi di riconversione per dumping syndrome
1848	Interventi in videotoracoscopia
1827	Interventi per ascessi
1416	Interventi per fistole arterovenose del polmone
2724	Interventi per induratio penis plastica
1660	Interventi per neoplasie del pancreas endocrino
1557	Interventi per stenosi benigne dell'esofago
2743	Interventi per tumori del testicolo con eventuale linfoadenectomia
1828	Intervento di bilobectomie
2450	Intervento di colpoperineorrafia per deiescenza sutura
1833	Intervento di decorticazione pleuro polmonare
2368	Intervento di elsmie-trillat
2198	Intervento di fukala e impianto di cristallino artificiale in camera anteriore o posteriore
1173	Intervento di impianto di elettrostimolazione midollare
1991	Intervento di isterectomia totale semplice con annessictomia mono/bilaterale per via laparotomica o per via vaginale
2635	Intervento di nefroureterectomia radicale con linfoadenectomia più eventuale surrenectomia
2009	Intervento di plastica vaginale anteriore
2008	Intervento di plastica vaginale anteriore e posteriore
2010	Intervento di plastica vaginale posteriore
1865	Intervento di pleurotomia e drenaggio (con resezione di una o più coste)
1866	Intervento di pneumectomia
1800	Intervento di push-back e faringoplastica
2492	Intervento di revisione di mastoidectomia radicale
2818	Intervento di rialzo del seno mascellare (per emiarcata - tratt. Completo e non ripetibile)
2465	Intervento di riduzione manuale per inversione di utero per via laparatomica
2466	Intervento di riduzione manuale per inversione di utero per via vaginale
2742	Intervento di riparazione per traumi del testicolo
2652	Intervento di ureteroenteroplastiche con tasche continenti (bilaterale)
2651	Intervento di ureteroenteroplastiche con tasche continenti (monolaterale)
2705	Intervento di uretroplastiche (in un tempo)
2041	Intervento di vulvectomia parziale con linfoadenectomia bilaterale diagnostica dei linfonodi inguinali superficiali
2042	Intervento di vulvectomia radicale allargata con linfoadenectomia inguinale e pelvica
2043	Intervento di vulvectomia semplice (locale o cutanea)
2309	Mobilizzazione incruenta di rigidità: grandi articolazioni
2080	Intervento endorachideo per neoplasie, cordotomie, radicotomie ed affezioni meningomidollari
2616	Intervento endoscopico per ureterocele
2696	Intervento per (trattamento completo-plastica) ipospadia scrotale o perineale
2739	Intervento per 66priapismo (percutaneo)
2204	Intervento per alcoolizzazione nervo cigliare
2048	Intervento per ascesso o ematoma intracranico
1578	Intervento per ascesso o fistola del cavo ischio-rettale
1579	Intervento per ascesso perianale
2505	Intervento per atresia coanale
1733	Intervento per calcolosi intraepatica
1582	Intervento per cisti dermoide, fistola sacro coccigea (anche recidive)
2690	Intervento per cisti o diverticoli o ascessi parauretrali
2361	Intervento per costola cervicale e outlet syndrome
2060	Intervento per derivazione liquorale diretta e indiretta
1543	Intervento per diverticoli dell'esofago cervicale (compresa miotomia)
1544	Intervento per diverticoli dell'esofago toracico
2128	Intervento per elevazione del sopracciglio
2061	Intervento per encefalomeningocele
2062	Intervento per epilessia focale
2692	Intervento per epispadia e ipospadia balanica e uretroplastica
2693	Intervento per epispadia e ipospadia peniena e uretroplastica
1546	Intervento per esofagite, ulcera esofagea
1540	Intervento per ferite del tubo laringo-tracheale e faringo-esofageo
1679	Intervento per fistola del dotto di stenone
2675	Intervento per fistola e/o cisti dell'uraco
1524	Intervento per fistola esofago-tracheale
1565	Intervento per fistola gastro-digiuno-colica
1658	Intervento per fistola pancreatica
2677	Intervento per fistola vescico-intestinale con resezione intestinale e/o cistoplastica
2678	Intervento per fistola vescico-vaginale o vescico-rettale
1843	Intervento per fistole del moncone bronchiale dopo exeresi o interventi assimilabili
1984	Intervento per fistole ureterali, vescicovaginale, rettovaginale
2812	Intervento per flemmone delle logge perimascellari
2720	Intervento per idrocele
1605	Intervento per incontinenza anale
1607	Intervento per invaginazione, volvolo, ernie interne
1993	Intervento per isteroscopia operativa compresa ablazione endometriale e/o rcu
1995	Intervento per isteroscopia operativa: sinechie-setti-fibromi-polipi
1640	Intervento per laparocele
1475	Intervento per lesioni tendinee
1692	Intervento per linfoangioma cistico del collo
2077	Intervento per malformazione aneurismatica (aneurismi sacculari, aneurismi arterovenosi)mielomeningocele
1802	Intervento per malformazione dell'areola e del capezzolo
2050	Intervento per malformazioni via posteriore per cerniera atlanto-occipitale
2051	Intervento per malformazioni via transorale per cerniera atlanto-occipitale
1608	Intervento per megacolon
1553	Intervento per megaesofago
2436	Intervento per neurinoma di morton
2391	Intervento per osteiti e osteomieliti (trattamento completo)
2733	Intervento per parafimosi
2740	Intervento per priapismo (shunt)
1615	Intervento per prolasso rettale, per via addominale
1665	Intervento per pseudocisti con digiunostomia o altra derivazione
2463	Intervento per revisione delle vie del parto
2464	Intervento per revisione di cavità uterina per aborto in atto- postabortivo-in puerperio
2416	Intervento per scoliosi
2240	Intervento per strabismo paralitico
2442	Intervento per torcicollo miogeno congenito
2112	Intervento per traumi vertebro-midollari via anteriore
2113	Intervento per traumi vertebro-midollari via posteriore
1822	Intervento per tumori maligni profondi del viso
2745	Intervento per varicocele
2073	Intervento per via transfenoidale per ipofisi
1622	Intervento per viscerolisi estesa (enteroplicatio)
2037	Intervento radicale per tumori maligni vaginali con linfoadenectomia
2038	Intervento radicale per tumori maligni vaginali senza linfoadenectomia
2086	Intervento sul plesso brachiale
2094	Intervento sul simpatico cervicale: enervazione del seno carotideo
2095	Intervento sul simpatico cervicale: gangliectomia
2096	Intervento sul simpatico cervicale: stellectomia
2097	Intervento sul simpatico dorsale: gangliectomia lombare
2099	Intervento sul simpatico lombare: gangliectomia lombare
2100	Intervento sul simpatico lombare: resezione del nervo presacrale
2101	Intervento sul simpatico lombare: simpaticectomia periarteriosa
2102	Intervento sul simpatico lombare: simpaticectomia post gangliare
2103	Intervento sul simpatico lombare: simpatico pelvico
2104	Intervento sul simpatico lombare: splacnicectomia
1532	Intervento sulle paratiroidi-trattamento completo
1614	Intervento transanale per prolasso rettale
1606	Intestino, resezione dell'
1750	Inteventi per malformazioni dento-maxillo-facciali della mandibola e della mascella
2639	Intevento di ielonefrolitotomia complessa (nefrotomia e/o bivalve)
902	Intradermoreazioni (qualsiasi numero)
1205	Ionoforesi (per seduta)
1262	Ipertermia (per seduta)
1292	Ipertermia associata alla radioterapia (per seduta)
1371	Ipotermia (come unica prestazione)
2220	Iridectomia
2211	Iridocicloretrazione
2222	Iridoplastica
2223	Iridotomia
1320	Irradiazione intraoperatoria (iort)
1187	Irrigazioni nasali e/o vaginali (per seduta)
1246	Isocineticaterapia (per seduta)
1989	Isterectomia radicale per via laparotomica o vaginale con linfoadenectomia
2310	Mobilizzazione incruenta di rigidità: medie articolazioni
1990	Isterectomia radicale per via laparotomica o vaginale senza linfoadenectomia
769	Isteroecosalpingografia
1992	Isteropessi
632	Isterosalpingografia
970	Isteroscopia diagnostica con biopsia
1277	Istruzione alla deambulazione (per seduta)
1689	Labioalveoloschisi bilaterale
1688	Labioalveoloschisi monolaterale
1690	Labioschisi (semplice) monolaterale
1691	Labioschisi bilaterale
2074	Laminectomia ed esplorazione di tumori intra-durali extra midollari
2075	Laminectomia ed esplorazione di tumori intramidollari
2076	Laminectomia esplorativa, decompressiva e per interventi extradurali
381	Lamotrigina
2627	Laparatomia esplorativa del rene comprese eventuali biopsie
971	Laparoscopia diagnostica e/o salpingocromoscopia
1996	Laparoscopia diagnostica e/o salpingocromoscopia comprese eventuali biopsie
1700	Laparoscopia esplorativa/diagnostica
1701	Laparoscopia operativa
1702	Laparotomia con lesione di organi interni perenchimali che richiedono emostasi
1703	Laparotomia con resezione intestinale
2457	Laparotomia esplorativa
1997	Laparotomia esplorativa (come unico intervento)
1998	Laparotomia esplorativa con linfoadenectomia lombo pelvica selettiva e bioptica
1704	Laparotomia esplorativa quale intervento principale per neoplasie non resecabili
2458	Laparotomia esplorativa, con intervento demolitore
1705	Laparotomia per contusioni e ferite dell'addome senza lesioni di organi interni
1999	Laparotomia per ferite e rotture dell'utero
1706	Laparotomia per lesioni di organi interni parenchimali che richiedono exeresi
1707	Laparotomia per lesioni gastro-intestinali che richiedono sutura
1708	Laparotomia per peritonite diffusa
1709	Laparotomia per peritonite saccata
1710	Laparotomia semplice (esplorativa e/o lisi aderenze)
2567	Laringectomia parziale
2568	Laringectomia parziale con svuotamento laterocervicale monolaterale
2570	Laringectomia totale con svuotamento laterocervicale bilaterale
2569	Laringectomia totale con svuotamento laterocervicale monolaterale
2571	Laringectomia totale senza svuotamento laterocervicale
2572	Laringocele
2573	Laringofaringectomia totale
1247	Laserstimolazione (per seduta)
1248	Laserterapia (per seduta)
2250	Laserterapia degli annessi, della congiuntiva, neovasicorneali
2251	Laserterapia del glaucoma e delle sue complicanze(trattamento completo)
2252	Laserterapia delle vasculopatie e/o malformazioni (a seduta)
2253	Laserterapia iridea (per intero ciclo)
2254	Laserterapia lesioni retiniche(per intero ciclo)
2255	Laserterapia nella retinopatia diabetica (per seduta)
2000	Laserterapia vaginale o vulvare o della portio (per seduta)
2380	Laterale release
382	Lattico deidrogenasi (ldh)
383	Lattico deidrogenasi isoenzimi
384	Lattico deidrogenasi nel liquido cefalorachidianolattosio
1093	Lavaggio bronco alveolare endoscopico
1711	Lavaggio peritoneale diagnostico
1850	Lavaggio pleurico
1081	Lavaggio tappo cerume
385	Lecitina e sfingomielina nel liquido amniotico
2383	Legamenti articolari del ginocchio con meniscectomia (anche in artroscopia) ricostruzione di
2711	Legatura dei deferenti (per patologie croniche)
1911	Legatura delle vene comunicanti o correzioni emodinamiche chivasindromi neurovascolari degli arti inferiori
1903	Legatura di vene comunicanti (come unico intervento)
1904	Legatura e/o sutura di grossi vasi: aorta-cava-iliaca
1905	Legatura e/o sutura di medi vasi: femorale-poplitea-omerale-mammaria interna-brachiale-ascellareglutea-carotide-vertebrale-succlavia-anonima
1907	Legatura e/o sutura di piccoli vasi: tibiali-linguale- tiroidea-mascellare-temporale-facciale-radicalecubitali-arcate palmari/pedide
2841	Legature dentali extracoronali (per 4 denti)
2842	Legature dentali intracoronali (per 4 denti)
2843	Lembi (liberi o peduncolati) per la correzione di difetti muco gengivali
1851	Lembo mobile del torace, trattamento chirurgico del (flail chest)
1852	Lembo mobile toracico (flail chest), trattamento conservativo del
2182	Lenticolo biologico, apposizione a scopo terapeutico
1552	Lesioni traumatiche o spontanee, corpi estranei, tumori benigni, biopsia e cauterizzazione non endoscopica
386	Leucinaminopeptidasi (lap)
1379	Leuco aferesi terapeutica
2845	Levigatura delle radici e/o courettage gengivale (per 4 denti)
1642	Linfoadenectomia inguinale o crurale bilaterale (come unico intervento)
1641	Linfoadenectomia inguinale o crurale monolaterale (come unico intervento)
1451	Linfoadenectomia isolata in tempi successivi ad interventi sulla mammella
2001	Linfoadenectomia laparotomica (come unico intervento)
1528	Linfoadenectomia latero cervicale bilaterale (come unico intervento)
1527	Linfoadenectomia latero cervicale monolaterale (come unico intervento)
1853	Linfoadenectomia mediastinica (come unico intervento)
1529	Linfoadenectomia sopraclaveare
387	Linfociti b con ig di membrana (okb7)
388	Linfociti natural killer (nk)
389	Linfociti t attivati (lta)
390	Linfociti t helper (okt4)
391	Linfociti t periferici (okt3)
392	Linfociti t rosettanti (okt11)
393	Linfociti t suppressor (okt8)
1530	Linfonodi, asportazione chirurgica a scopo diagnostico
851	Linfoscintigrafia (qualsiasi segmento)
1693	Lingua e pavimento orale, intervento per tumori maligni con svuotamento della loggia sottomascellare
2585	Parafimosi, riduzione incruenta di
1695	Lingua e pavimento orale, intervento per tumori maligni con svuotamento laterocervicale funzionale o radicale
1694	Lingua e pavimento orale, intervento per tumori maligni senza svuotamento della loggia sottomascellare
1696	Lingua, amputazione parziale per tumori benigni, angiomi, macroglossia
394	Lipasi
1452	Lipofilling in caso di exeresi per neoplasia maligna
395	Lipoproteina a
396	Lipoproteina x
1174	Lisi peridurale (peridurolisi con catetere di racz )
1748	Litotripsia per calcoli delle vie biliari principale ed accessoria (trattamento completo)
2629	Litotripsia per calcolosi renale e/o ureterale bilaterale (tratt. Completo)
2628	Litotripsia per calcolosi renale e/o ureterale monolaterale (tratt. Completo)
2604	Litotripsia ureterale con ultrasuoni, laser, ecc...
2605	Litotripsia, litolapassi vescicale endoscopica
2630	Lobotomia per ascessi pararenalinefrectomia allargata per tumore (compresa surrenectomia)
1249	Logoterapia (per seduta)magnetoterapia (per seduta)
397	Lupus anti coagulant (lac)
1697	Lussazione mandibolare, lussazione menisco monolaterale terapiachirurgicainterventi chirurgici chirurgia generale - peritoneo
398	Macroglobulina di waldestrom
399	Magnesemia
400	Magnesio ionizzato plasmatico
401	Magnesuria
1803	Malformazione semplice delle mani e dei piedi (sindattilia, polidattilia)
1804	Malformazioni complesse delle mani e dei piedi (trattamento completo)
702	Mammografia bilaterale
703	Mammotome (comprensivo di esame istologico)
1752	Mandibola, resezione parziale per neoplasia della
1268	Manipolazioni vertebrali (per seduta)
1943	Manometria ano rettale
1944	Manometria colon
954	Manometria esofagea
1053	Mappa strumentale della cornea: tomografia
1054	Mappa strumentale della cornea: topografia
1122	Mapping vescicale (omnicomprensivo)
1263	Marconiterapia (per seduta)
1753	Mascellare superiore per neoplasie, resezione del
1417	Massaggio cardiaco interno
1220	Massaggio riflessogeno (per seduta)
1221	Massaggio strumentale (per seduta)
1754	Massiccio facciale, operazione demolitrice per tumori con svuotamento orbitario
1218	Massoterapia
1222	Massoterapia segmentaria per qualunque segmento (per seduta)
1453	Mastectomia (qualsiasi tecnica con resezione del linfonodo sentinella e/o linfoadenectomie associate)
1454	Mastectomia con eventuale impianto di protesi o estensore
1455	Mastectomia per ginecomastia maschile mammelle bilaterali
1456	Mastectomia radicale, qualsiasi tecnica, con linfoadenectomie associate
1457	Mastectomia semplice
1458	Mastectomia sottocutanea
2459	Mastite puerperale, trattamento chirurgico
2479	Mastoidectomia
2480	Mastoidectomia radicale
2697	Meatotomia e meatoplastica
2606	Meatotomia ureterale (come unico intervento)
2607	Meatotomia uretrale (come unico intervento)
1250	Meccanoterapia (per seduta)
1854	Mediastinoscopia diagnostica
1855	Mediastinoscopia operativa
1856	Mediastinotomia soprasternale per enfisema mediastinico
1511	Medicazione ambulatoriale di ferita chirurgica
2813	Medicazione chirurgica (per seduta - max 3 sedute)
826	Medicina nucleare apparato cardiocircolatorio
839	Medicina nucleare apparato digerente
846	Medicina nucleare apparato ematopoietico
855	Medicina nucleare apparato osteoarticolare e tessuti molli
862	Medicina nucleare apparato respiratorio
865	Medicina nucleare apparato urinario
884	Medicina nucleare cellule autologhe marcate
888	Medicina nucleare indicatori positivi
868	Medicina nucleare sistema nervoso
876	Medicina nucleare surreni
878	Medicina nucleare tiroide
892	Medicina nucleare traccianti immunologici
1609	Megacolon: colostomia
1805	Melanoma del capomodellamento di lembo in situ
1512	Melanoma tronco/arti asportazione di (qualunque numero)
2386	Meniscectomia (in artroscopia) (trattamento completo)
2387	Meniscectomia (in artroscopia) + rimozione di corpi mobili (trattamento completo)
2388	Meniscectomia (in artroscopia) + rimozione di corpi mobili + condroabrasione (trattamento completo)
2385	Meniscectomia (tecnica tradizionale) (trattamento completo)
1755	Meniscectomia dell'articolazione temporo-mandibolare (come unico intervento)
1227	Mesoterapia a fini antalgici (senza medicinali) (per seduta)
402	Metaemoglobina
403	Metanefrine
2002	Metroplastica (come unico intervento)
404	Microalbuminuria
2212	Microchirurgia dell'angolo camerulare
574	Microdelezioni del cromosoma y(azf)* (@)
1209	Microfototerapia per seduta (per seduta)
405	Microglobulina beta 2
1055	Microscopia corneale (conconale), conta endoteliale
940	Microscopia di superficie in epiluminescenza digitale
1610	Mikulicz, estrinsecazione secondo
1659	Milza, interventi chirurgici conservativi (splenorrafie, resezioni spleniche)
2819	Mini implant compresi attacchi di precisione per elemento - come unica prestazione
406	Mioglobina (dosaggio)
2003	Miomectomie per via laparotomica e ricostruzione plastica dell'utero
2004	Miomectomie per via vaginale
1620	Miotomia del sigma
2481	Miringoplastica per via endoaurale
2482	Miringoplastica per via retroauricolare
2483	Miringotomia (come unico intervento)
2756	Mitral clip
2311	Mobilizzazione incruenta di rigidità: piccole articolazioni
2846	Molaggio selettivo parziale (per seduta - max 3)
930	Monitoraggio dinamico pressorio delle 24 ore
770	Monitoraggio ovulazione (1 ciclo)
407	Mononucleosi (mono test)
1278	Moorterapia (per seduta)
1477	Morbo di notta (dito a scatto), morbo di de quervain, tenosinoviti
813	Mri fetale
408	Mucoprotidemia
2236	Muscoli retti esterni o retti interni, avanzamento
2237	Muscoli superiori o inferiori o obliqui, avanzamento
554	Mycobacterium tuberculosis pcr
2631	Nefrectomia polare
2632	Nefrectomia semplice
2633	Nefropessi
2634	Nefrostomia o pielostomia (come unico intervento)
2608	Nefrostomia percutanea bilaterale
2609	Nefrostomia percutanea monolaterale
2636	Nefroureterectomia radicale più trattamento trombocavale (compresa surrenectomia)
2574	Neoformazioni benigne, asportazione in laringoscopia
2575	Neoformazioni benigne, asportazione in microlaringoscopia
2576	Neoformazioni benigne, stenosi organiche e funzionali in microchirurgia laringea con laser co2
1857	Neoformazioni costali localizzate
1858	Neoformazioni del diaframma
1859	Neoformazioni della trachea
2005	Neoformazioni della vulva, asportazione
1757	Neoformazioni endossee di piccole dimensioni (osteomi, cementomi, odontomi, tours palatino e mandibolare),
2168	Neoplasie congiuntivali, asportazione con innesto
2169	Neoplasie congiuntivali, asportazione con plastica per scorrimento
2485	Neoplasie del condotto, exeresi
1860	Neoplasie e/o cisti del mediastinoneoplasie maligne coste e/o sterno
1861	Neoplasie maligne della trachea
2549	Neoplasie parafaringee
2577	Nervo laringeo superiore, alcoolizzazione del
2486	Nervo vestibolare, sezione del
2006	Neurectomia semplice
2487	Neurinoma dell'ottavo paio
2081	Neurolisi (come unico intervento)
2082	Neurorrafia primaria (come unico intervento)
2083	Neurotomia retrogasseriana, sezione intracranica di altri nervi (come unico intervento)
2084	Neurotomia semplice (come unico intervento)
1531	Nodulectomia/emitiroidectomia
409	Noradrenalina plasmatica
410	Noradrenalina urinaria
2390	Nucleoaspirazione e/o nucleolisi lombare
411	Numero di dibucaina
1712	Occlusione intestinale con resezione
1713	Occlusione intestinale senza resezione
1056	Oct - tomografia a coerenza ottica
2183	Odontocheratoprotesi
1057	Oftalmodinamometria
1058	Oftalmoscopia diretta o indiretta (come unico atto)
1082	Olfattometria
2799	Oligoelementi (per arcata)
412	Omocisteina
2271	Onorari per l'effettuazione di apparecchi gessati da parte di specialisti ortopedici
2125	Operazione di kronlein od orbitotomia
2213	Operazione fistolizzante
2203	Operazione per glaucoma
2126	Orbita, intervento di decompressione per via inferioreinterventi chirurgici oculistica - sopracciglio
2727	Orchidopessi bilaterale
2728	Orchidopessi monolaterale
2729	Orchiectomia allargata con linfoadenectomia addominale
2730	Orchiectomia sottocapsulare bilaterale
2731	Orchiepididimectomia bilaterale con eventuale protesi
2732	Orchiepididimectomia monolaterale con eventuale protesi
413	Ormone adrenocorticotropo (acth)
414	Ormone antimulleriano
415	Ormone follicolo stimolante (fsh)
416	Ormone lattogeno placentare o somatomammotropina (hpl)
417	Ormone luteinizzante biologico (lh biologico)
418	Ormone luteinizzante plasmatico (lh)
419	Ormone somatotropo plasmatico o urinario (sth)
420	Ormone tireotropo (tsh)
421	Ormoni (dosaggio per singolo ormone)
2855	Ortopantomografia od ortopanoramica
422	Osmolalità/osmolarità plasmatica
423	Osmolalità/osmolarità urinaria
1188	Ossigenoterapia iperbarica (per seduta)
1094	Ossimetria arteriosa (pa o2 o sa o2)
1761	Osteiti circoscritte dei mascellari, trattamento di
424	Osteocalcina
2312	Osteoclasia
2392	Osteosintesi vertebrale
2393	Osteosintesi: grandi segmenti
2394	Osteosintesi: medi segmenti
2395	Osteosintesi: piccoli segmenti
2396	Osteotomia complessa (bacino, vertebrale, ecc...)
2397	Osteotomia semplice
1478	Osteotomie (come unico intervento)
2784	Otturazione
425	Oxcarbazepina
1251	Ozonoterapia per infiltrazioni (solo per terapia di ernia discale) (per seduta)
931	Pace-maker mono o bicamerale: impianto definitivo
1442	Pace-maker, impianto temporaneo e relativo espianto (come unico intervento)
932	Pace-maker: controllo elettronico
933	Pace-maker: impianto temporaneo
1059	Pachimetria corneale
1762	Palatoschisi parziale
1763	Palatoschisi totale
1661	Pancreatectomia sinistra compresa splenectomia ed eventuale linfoadenectomia
1662	Pancreatectomia totale (compresa eventuale linfoadenectomia)
1663	Pancreatite acuta, interventi conservativi
1664	Pancreatite acuta, interventi demolitivi
2578	Papilloma laringeo
1645	Papillotomia, per via endoscopica
973	Paptest
1714	Paracentesi
2184	Paracentesi della camera anteriore
1264	Paraffinoterapia (per seduta)
427	Parassita malarico o altri parassiti nel sangue
1533	Paratiroidi, reinterventi
428	Paratormone c terminale (pth)
429	Paratormone intatto
1766	Parotidectomia superficiale
1767	Parotidectomia totale
2462	Parto cesareo: conservativo o demolitivo, comprensivo della normale assistenza alla puerpera durante il ricovero
2460	Parto naturale: eutocico, distocico, plurimo, podalico, prematuro, pilotato
903	Patch test (allergeni da contatto serie completa)
1513	Patereccio superficiale, intervento per
430	Pca3 (prostate cancer gene)
2284	Pelvicondiloideo
2285	Pelvicondiloideo bilaterale
2286	Pelvimalleolare
2287	Pelvimalleolare bilaterale
2288	Pelvipedidio
2289	Pelvipedidio bilaterale
433	Peptide c
432	Peptide c (dopo carico di glucosio - 4 dosaggi)
2398	Perforazione alla boeck
1418	Pericardiectomia parziale
1419	Pericardiectomia totale
1420	Pericardiocentesi
2579	Pericondrite ed ascesso perilaringeo
1060	Perimetria
894	Pet (positron emission tomography) per organo, distretto o apparato
2489	Petrosectomia
2490	Petrositi suppurate, trattamento delle
434	Ph ematico
955	Ph impedenzometria esofagea (24 ore)
956	Ph metria esofagea (24 ore)
435	Phadiatop
1380	Piastrino aferesi terapeutica
2170	Piccole cisti, sutura con innesto placentare
2637	Pielocalicolitotomia (come unico intervento)
2638	Pielocentesi (come unico intervento)
2640	Pielouretero plastica per stenosi del giunto
1569	Piloroplastica (come unico intervento)
436	Piruvatokinasi eritrocitaria
2847	Placca di svincolo
1381	Plasma exchange (pex)
1382	Plasmaferesi terapeutica
1136	Plasmaferesi terapeutica (compreso filtro, linee, sacche escluso plasma e/o albumina)
2007	Plastica con allargamento dell'introito (compreso intervento per vaginismo)
2171	Plastica congiuntivale per innesto
2172	Plastica congiuntivale per scorrimento
1768	Plastica di fistola palatina
2120	Plastica per cavità orbitaria
2129	Plastica per innesto
2384	Plastica per lussazioni recidivanti (spalla, ginocchio)
1764	Plastica per paralisi dinamica del nervo facciale
1765	Plastica per paralisi statica del nervo facciale
2130	Plastica per scorrimento
1806	Plastica ricostruttiva del padiglione auricolare
1801	Plastica ricostruttiva delle labbra (trattamento completo)
2085	Plastica volta cranica
1769	Plastiche mucose per comunicazioni oro-antrali
1293	Plesioroentgenterapia (per seduta)
1095	Pletismografia corporea (misura vgt, resistenze, volumetria)
1096	Pletismografia induttiva toracica
1862	Pleurectomia
1863	Pleurodesi in videotoracoscopia
1864	Pleuropneumectomia
437	Ploidia del dna
555	Pneumocistis carinioncologia molecolare
1867	Pneumotorace terapeutico
1021	Polifisiografia del sonno (1 ciclo)
1022	Polifisiografia del sonno (intera notte)
575	Polimorfismo 5t introne 8 gene cftr*
1611	Polipectomia per via laparotomica
2012	Polipi orifizio uretrale esterno
1189	Politzer (per seduta)
1224	Pompage (per seduta)
786	Porto tc
1137	Posizionamento clip amagnetica
1372	Posizionamento di catetere in succlavia (come unica prestazione)
1148	Posizionamento di cateteri intraddominali in infusione chemioterapica
1175	Posizionamento di dispositivo totalmente impiantabile per la somministrazione di farmaci intratecale/subaracnoidea
1724	Posizionamento di palloncino intragastrico per via endoscopica in day surgery
1725	Posizionamento di palloncino intragastrico per via endoscopica in ricovero
1294	Posizionamento di placche per la radioterapia del melanoma coroidale compresa prestazione del medico oculista
2738	Posizionamento di protesi peniena
1138	Posizionamento di repere metallico ecoguidato
1139	Posizionamento di repere metallico in stereotassi
1945	Posizionamento endoprotesi esofagee (esclusa protesi)
1514	Posizionamento percutaneo di catetere venoso centrale (come unica prestazione)
1460	Posizionamento punto di repere per noduli non palpabili
438	Potassiemia
439	Potassio eritrocitario
440	Potassiuria
1023	Potenziali evocati (a potenziale)
1024	Potenziali evocati baers
1025	Potenziali evocati multimodiali
1026	Potenziali evocati pes
1027	Potenziali evocati pev
1061	Potenziali evocati visivi con determinazione di contrasto
1123	Potenziali sacrali evocati
606	Prelievo arterioso domiciliare
605	Prelievo arterioso in ambulatorio
2399	Prelievo di trapianto osseo con innesto
607	Prelievo venoso o capillare a domicilio
1509	Preparazione di fistola artero-venosa periferica
999	Preparazione psicofisica al parto - ciclo completo
576	Preparazione sperma per frammentazione dna e frammentazione dna spermatozoi*
560	Presso struttura pubblica
1252	Pressoterapia (per seduta)
1160	Prestazioni equipe medica oncologica durante un ricovero senza chemioterapia con degenza notturna: dalla seconda alla decima giornata
1162	Prestazioni equipe medica oncologica durante un ricovero senza chemioterapia con degenza notturna: oltre la decima giornata
1159	Prestazioni equipe medica oncologica durante un ricovero senza chemioterapia con degenza notturna: prima giornata
1154	Prestazioni equipe medica oncologica in regime di ricovero con degenza notturna per mono-polichemioterapia antiblastica, con terapia perfusionale: dalla seconda giornata in poi
1152	Prestazioni equipe medica oncologica in regime di ricovero con degenza notturna per mono-polichemioterapia antiblastica, con terapia perfusionale: prima giornata
976	Prestazioni in gravidanza
1225	Prestazioni manu medica
1613	Procto-colectomia totale con pouch ileale
441	Prodotti degradazione fibrinogeno: plasma/urine (fdp plasmatici urinari)
442	Progesteroneprolattina (prl)
2013	Prolasso cupola vaginale o colpopessia, interventi per via addominale o vaginale
2224	Prolasso irideo, riduzione
2699	Prolasso mucoso uretrale
1124	Prostata, massaggio unicamente a scopo terapeutico
2611	Prostata, resezione endoscopica della + vaporizzazione (turp, tuvp)
2612	Prostata, vaporizzazione con utilizzo di laser al tullio (turp)
2685	Prostatectomia radicale per carcinoma con linfoadenectomia (qualsiasi accesso e tecnica)
2686	Prostatectomia sottocapsulare per adenoma
443	Proteina bence jones
444	Proteina c coagulativa
446	Proteina c reattiva
445	Proteina c reattiva resistenza
447	Proteina s
448	Proteine totali nel liquido amniotico
449	Proteine urinarie
450	Proteinemia totale
2762	Protesi acustica bilaterale
2761	Protesi acustica monolaterale
2763	Protesi articolare
2764	Protesi arto inferiore
2765	Protesi arto superiore
2766	Protesi endoesofagea
2767	Protesi mammaria impiantabile (ciascuna)
2822	Protesi mobile totale per arcata con denti in resina o ceramica comprensiva di protesi parziale rimovibile provvisoria
2768	Protesi oculare (occhio finto)
2824	Protesi parziale definitiva rimovibile (comprensiva di ganci ed elementi e di protesi parziale rimovibile provvisoria)
2769	Protesi testicolare
2826	Protesi totale mobile provvisoria (per arcata)
2770	Protesi vascolare
451	Prova crociata di compatibilità trasfusionale
1097	Prova da sforzo scalare: parametri ventilatori con emogasanalisi
452	Prove emogeniche (coagulazione ed emorragia)
1909	Pseudoaneurismi post-traumatici o iatrogeni
1479	Pseudoartrosi delle ossa lunghe
1480	Pseudoartrosi dello scafoide carpale
2400	Pseudoartrosi grandi segmenti o congenita di tibia (trattamento completo)
2401	Pseudoartrosi medi segmenti (trattamento completo)
2402	Pseudoartrosi piccoli segmenti (trattamento completo)
2173	Pterigio o pinguecola
2238	Ptosi palpebrale, intervento per (escluse finalità estetiche)
2376	Pulizia chirurgica di frattura esposta
2795	Pulpotomia ed otturazione della camera pulpare  (comprese rx)
1868	Puntato sternale o midollare
2403	Puntato tibiale o iliaco
2721	Puntura di idrocele
2087	Puntura epidurale
1000	Puntura epidurale nel parto
1643	Puntura esplorativa addominale
2015	Puntura esplorativa del cavo di douglas
1869	Puntura esplorativa del polmone
2088	Puntura sottoccipitale per prelievo liquorale o per introduzione di farmaci o mezzo di contrasto
1062	Pupillografia
1461	Quadrantectomia con eventuale impianto di protesi o estensore
1462	Quadrantectomia con linfoadenectomie associate
1463	Quadrantectomia senza linfoadenectomie associate
2089	Rachicentesi per qualsiasi indicazione
1265	Radarterapia (per seduta)
2856	Radiografia endorale (ogni due denti) massimo 3 per ogni piano di cura
2857	Radiografia endorale (per arcata)
1280	Radioterapia
1295	Radioterapia con tecniche speciali (trattamento globale): irradiazione cutanea totale con elettroni
1296	Radioterapia con tecniche speciali (trattamento globale): irradiazione emicorporea (hbi)
1297	Radioterapia con tecniche speciali (trattamento globale): panirradiazione (tbi) frazionata, ogni seduta
1298	Radioterapia con tecniche speciali (trattamento globale): panirradiazione (tbi) prima o unica seduta
1299	Radioterapia conformazionale dinamica con collimatore micro-multi-leaf ( per seduta)
1300	Radioterapia imrt (per seduta)
1301	Radioterapia selettiva interna intraepatica (sirt)
1302	Radioterapia stereotassica (trattamento globale, anche cyber knife)radioterapia stereotassica plurifrazionata: frazioni successive (anche cyber knife)
1303	Radioterapia stereotassica plurifrazionata: prima frazione (anche cyber knife)
453	Rame (cupremia)
2016	Raschiamento endouterino diagnostico o terapeutico
2758	Realizzazione di plantari ortopedici
454	Reazione di paul bunnel
455	Reazione di waaler rose
457	Reazione di wasserman
456	Reazione di wasserman più due reazioni di flocculazione
458	Reazione immunologica di gravidanza
577	Recettore androgenico ar*
603	Recettori ormonali (per singola determinazione)
1383	Recupero di sangue intraoperatorio
2613	Reflusso vescico ureterale, intervento endoscopico (teflon)
2090	Registrazione continua della pressione intracranica
2405	Reimpianti di arto o suo segmento
1421	Reintervento con ripristino di c.e.c.
1534	Reintervento per la tiroide
1870	Relaxatio diaframmatica
916	Reografia arti inferiori
917	Reografia arti superiori
918	Reografia arti superiori e inferiori
1240	Rieducazione neuromotoria (per seduta)
1616	Resezione anteriore retto-colica compresa linfoadenectomia ed eventuale colostomia
2406	Resezione articolare
1871	Resezione bronchiale con reimpianto
2404	Resezione con trapianto articolare perone e pro-radio radiodistale
2407	Resezione del sacro
1547	Resezione dell'esofago cervicale
2741	Resezione dello scroto
1872	Resezione di costa soprannumeraria
1592	Resezione di digiunostomia (come unico intervento)
2602	Resezione endoscopica di formazioni ureterali
2610	Resezione endoscopica di neoplasia vescicale
1570	Resezione gastro duodenale
1571	Resezione gastro-digiunale per ulcera peptica anastomotica
2408	Resezione ossea
2017	Resezione ovarica bilaterale per patologia disfunzionale
2018	Resezione ovarica monolaterale per patologia disfunzionale
1548	Resezione parziale dell'esofago
1873	Resezione segmentaria o lobectomia
2700	Resezione uretrale e uretrorrafia anteriore peniena
2701	Resezione uretrale e uretrorrafia posteriore membranosa
1646	Resezioni epatiche maggiori
1647	Resezioni epatiche minori
1874	Resezioni segmentarie atipiche
1875	Resezioni segmentarie tipiche
459	Resistenze globulari
2233	Retina, intervento per distacco, comprensivo di tutte le fasi
1063	Retinografia
1810	Retrazione cicatriziale delle dita con innesto
1811	Retrazione cicatriziale delle dita senza innesto
1481	Retrazioni ischemiche
1617	Retto, amputazione del, per neoplasia dell'ano, con linfoadenectomia inguinale bilaterale
1618	Retto, amputazione per via addomino-perineale, con eventuale linfoadenectomia, del
957	Rettoscopia diagnostica
958	Rettosigmoidoscopia diagnostica
1946	Rettosigmoidoscopia operativa
2342	Revisione di protesi d'anca per complicanza settica
2519	Revisione di rinosettoplastica
1515	Revisione e/o ampliamento di pregressa exeresi per neoplasie maligne
1236	Riabilitazione del pavimento pelvico (per seduta)
1237	Riabilitazione motoria (per seduta)
1238	Riabilitazione post-operatoria (per seduta)
1239	Riabilitazione post-traumatica (per seduta)
2409	Riallineamento metatarsale
934	Rianimazione cardiocircolatoria: massaggio cardiaco esterno
2145	Riapertura di anchiloblefaron
2827	Ribasamento di protesi rimovibile (qualunque sistema)
2712	Ricanalizzazione dei deferenti
895	Ricerca del linfonodo sentinella e punto di repere
588	Ricerca del pannello di mutazioni per trombofilia/ipertensione*
578	Ricerca delle mutazioni del gene per: acondroplasia, anemia falciforme, aneuploidie molecolari, spinocerebellari
581	Ricerca delle mutazioni del gene per: alfa1antitripsina, atrofia spinale muscolare tipo 1
582	Ricerca delle mutazioni del gene per: alzheimer familiare, epidermolisi bullosa, fenilchetonuria, retinite pigmentosa*
579	Ricerca delle mutazioni del gene per: atassia di friedreich, atassia telangectasia, distonia primaria, distrofia miotonica
580	Ricerca delle mutazioni del gene per: distrofia muscolare, emocromatosi, huntington, mcda deficit, sordità congenita, sbma, x fragile
584	Ricerca delle principali mutazioni geniche nelle endocrinopatie congenite: 21idrossilasi, 5alfareduttasi, aromatasi p450, ipoplasia surrenale congenita
585	Ricerca delle principali mutazioni geniche nelle endocrinopatie congenite:recettore androgenico,recettore estrogenico, thyroid hormone receptor
586	Ricerca di mutazioni di geni per malattie cardiovascolari: ace, agt, fattore v di leiden, jka2, mthfr-c677t, mthfr1298a/c
587	Ricerca di mutazioni di geni per malattie cardiovascolari: fattore ii protrombina, ipercolesterolemia familiare, iperlipoproteinemia familiare tipo iii
589	Ricerca di mutazioni di geni per trombofilia*
562	Ricerca di una specifica mutazione
1001	Ricerca dna fetale nel sangue materno
591	Ricerca genetica per anomalie cromosomiche
460	Ricerca miceti su vetrino
2796	Ricostruzione con ancoraggio o perno ad elemento
1771	Ricostruzione con innesti ossei dei mascellari
1772	Ricostruzione con materiali alloplastici o con protesi dei mascellari
2164	Ricostruzione delle vie lacrimali
2381	Ricostruzione di legamenti articolari collo-piede (qualsiasi tecnica)
2382	Ricostruzione di legamenti articolari del ginocchio (anche in artroscopia)
2421	Ricostruzione di tetto cotiloideo
1482	Ricostruzione secondaria del pollice o delle altre dita in microchirurgia
2410	Riduzione cruenta e contenzione di lussazione traumatica di colonna vertebrale
2411	Riduzione cruenta e contenzione di lussazione traumatica di grandi articolazioni
2412	Riduzione cruenta e contenzione di lussazione traumatica di medie o piccole articolazioni
2295	Riduzione incruenta di fratture: applicazione di filo o chiodo transcheletrico
2296	Riduzione incruenta di fratture: applicazione di skin traction
2297	Riduzione incruenta di fratture: colonna vertebrale
2298	Riduzione incruenta di fratture: grandi segmenti
2302	Riduzione incruenta di fratture: medi segmenti (anche clavicola)
2303	Riduzione incruenta di fratture: piccoli segmenti
2299	Riduzione incruenta di fratture-lussazioni: colonna vertebrale
2300	Riduzione incruenta di fratture-lussazioni: grandi articolazioni
2301	Riduzione incruenta di fratture-lussazioni: piccole articolazioni
2304	Riduzione incruenta di lussazione traumatica: colonna vertebrale
2305	Riduzione incruenta di lussazione traumatica: grandi articolazioni
2306	Riduzione incruenta di lussazione traumatica: medie articolazioni
2307	Riduzione incruenta di lussazione traumatica: piccole articolazioni
2513	Riduzioni di fratture delle ossa nasali
1229	Rieducazione funzionale e chinesiterapia
2586	Rigidometria peniena notturna (3 notti - rigiscan)
2782	Rilievo impronte e preparazione modelli di studio
1726	Rimozione bendaggio gastrico regolabile per via laparoscopica
2688	Rimozione di calcoli o corpi estranei
1994	Rimozione di isteroscopia operativa: corpi estranei
2797	Rimozione in sicurezza di amalgama
2413	Rimozione mezzi di sintesi
1727	Rimozione o sostituzione port sottocutaneo
1083	Rinofaringoscopia
2517	Rinofima, intervento
1084	Rinomanometria
2518	Rinosettoplastica con innesti di osso
1812	Riparazione di p.s.c. Con lembo cutaneo di rotazione o di scorrimento di grandi dimensioni
1813	Riparazione di p.s.c. Con lembo cutaneo di rotazione o di scorrimento di piccole dimensioni
1814	Riparazione di p.s.c. Con lembo fasciocutaneo
1815	Riparazione di p.s.c. Con lembo miofasciocutaneo
1816	Riparazione di p.s.c. O esiti ciatriziali mediante espansore tissutale per tempo chirurgico,
2828	Riparazione di protesi rimovibile (qualsiasi tipo)
2829	Riparazione di protesi rimovibile (qualsiasi tipo) con aggiunta di elemento (per elemento)
1443	Riprogrammazione elettronica del pace-maker con misurazione soglia cardiaca con metodo non invasivo
807	Risonanza magnetica
1484	Rivascolarizzazione di arto o di suo segmento (come unico intervento)
2737	Rivascolarizzazione per impotenza vasculogenita in microchirurgia pene
2814	Rizectomia e rizotomia (compreso lembo d'accesso) come unico intervento
1485	Rizoartrosi
1177	Rizotomia trans nasale a fini analgesici
2091	Rizotomie e microdecompressioni radici endocraniche
814	Rm a.t.m.rm arti o articolazioni
815	Rm arto o articolazione aggiuntiva stessa seduta
816	Rm cuore
817	Rm distretto vascolare
818	Rm multiparametrica della prostata
819	Rm per ogni organo, apparato o distretto
820	Rm per ogni organo, apparato o distretto in più stessa seduta
821	Rm rachide per ogni segmento aggiuntivo stessa seduta
822	Rm rachide per segmento (cervicale, dorsale, lombare, sacro coccigeo)
1304	Roentgenterapia superficiale non oncologica (per seduta)
461	Rotavirus nelle feci (ricerca diretta)
2414	Rottura cuffia rotatoria della spalla, riparazione
2702	Rottura traumatica dell'uretra
634	Rx a.t.m.
617	Rx addome: esame diretto
635	Rx anca
694	Rx apparato urinario: esame diretto
636	Rx arti inferiori sotto carico con bacino
637	Rx arti inferiori sotto carico con bacino (2 proiezioni)
638	Rx assiali rotule 30°/60°/90°
639	Rx avambraccio
640	Rx avampiede
641	Rx bacino
686	Rx cavità nasali
642	Rx colonna vertebrale cervicale
643	Rx colonna vertebrale cervicale (proiezioni oblique)
644	Rx colonna vertebrale cervicale transorale
645	Rx colonna vertebrale completa
646	Rx colonna vertebrale completa più bacino sotto carico
647	Rx colonna vertebrale dorsale
648	Rx colonna vertebrale esame morfodinamico per tratto
649	Rx colonna vertebrale lombo-sacrale
650	Rx colonna vertebrale lombo-sacrale (proiezioni oblique)
651	Rx colonna vertebrale sacro-coccigea
652	Rx coscia
653	Rx cranio
654	Rx dinamiche rachide cervicale
655	Rx dinamiche rachide lombare
656	Rx dita avampiede
657	Rx dita mano
658	Rx emimandibola
618	Rx esofago con contrasto opaco
619	Rx esofago: esame diretto
620	Rx faringe: esame diretto
621	Rx fegato, vie biliari, pancreas: esame diretto
659	Rx femorerx forami ottici
660	Rx gamba
622	Rx ghiandole salivari: esame diretto
661	Rx ginocchio
662	Rx ginocchio appoggio monopodalico
663	Rx gomito
664	Rx grandi articolazioni (spalla - anca / gomito / ginocchio)
687	Rx laringe
688	Rx laringe (con contrasto)
665	Rx mano
666	Rx mastoide
710	Rx ogni radiogramma in più
667	Rx omero
699	Rx orbita: esame diretto
668	Rx ortopanoramica
669	Rx ossa nasali
700	Rx per localizzazione corpo estraneo endorbitario
670	Rx per localizzazione corpo estraneo tessuti molli
623	Rx per studio selettivo dell'ultima ansa
624	Rx piccolo intestino con doppio contrasto
671	Rx piede
672	Rx piedi sotto carico
673	Rx polso
695	Rx regione vescicale: esame diretto
674	Rx retropiede
675	Rx rocche petrose
676	Rx scapola
707	Rx sella turcica: esame diretto
677	Rx seni paranasali
678	Rx spalla
679	Rx spalle sotto carico
680	Rx sterno
681	Rx sterno coste clavicola
625	Rx stomaco doppio contrasto
626	Rx tenue a doppio contrasto con studio selettivo
627	Rx tenue seriato
682	Rx tessuti molli
683	Rx torace e arto superiore (toracobrachiale) monolaterale
709	Rx toraceesami radiologici varie
689	Rx trachea
628	Rx tubo digerente: completo compreso esofago (con contrasto)
629	Rx tubo digerente: prime vie (esofago, stomaco, duodeno)
630	Rx tubo digerente: seconde vie (tenue, colon)
2493	Sacco endolinfatico, chirurgia del
1910	Safenectomia della grande e/o della piccola safena, totale o parziale e varicectomia e trombectomia ed eventuale
2019	Salpingectomia bilaterale
2020	Salpingectomia monolaterale
2021	Salpingoplastica
462	Sangue occulto nelle feci
1773	Scappucciamento osteomucoso dente semincluso
2415	Scapulopessi
2290	Scarpetta gessata
2092	Scheggectomia e craniectomia per frattura volta cranica
2093	Scheggectomia e craniectomia per frattura volta cranica con plastica
1305	Schermatura, modificatori del fascio, sistemi di immobilizzazione personalizzati (unica prestazione)
787	Scialo tc
2858	Scialografia con mezzo di contrasto
852	Scintigarfia splenica con emazie autologhe
856	Scintigrafia articolare segmentaria per ogni segmento
857	Scintigrafia articolare totale corporea
872	Scintigrafia cerebrale
873	Scintigrafia cerebrale con tracciante recettoriale (datscan)
879	Scintigrafia con captazione tiroidea dello i 131
889	Scintigrafia con indicatori positivi (tiroide, polmone)
890	Scintigrafia con indicatori positivi altri organi
885	Scintigrafia con uso leucociti marcati
877	Scintigrafia delle ghiandole surrenali (corticale o midollare)
880	Scintigrafia delle paratiroidi con metodica di sottrazione
840	Scintigrafia epatica
841	Scintigrafia epatica o epatobiliare con calcolo indici funzionali
842	Scintigrafia ghiandole salivari
832	Scintigrafia miocardica con indicatori di lesione
834	Scintigrafia miocardica di perfusione a riposo
833	Scintigrafia miocardica di perfusione a riposo e dopo test
863	Scintigrafia polmonare di perfusione
864	Scintigrafia polmonare di perfusione o ventilazione con indici funzionaliscintigrafia polmonare di ventilazione
866	Scintigrafia renale
858	Scintigrafia scheletrica per segmento
859	Scintigrafia scheletrica segmentaria aggiuntiva alla scheletrica totale corporea
860	Scintigrafia scheletrica segmentaria polifasica
861	Scintigrafia scheletrica totale corporea
874	Scintigrafia sequenziale degli spazi liquorali
843	Scintigrafia sequenziale del transito e/o reflusso
844	Scintigrafia sequenziale epatobiliare
845	Scintigrafia sequenziale ghiandole salivari con indici funzionali
867	Scintigrafia sequenziale renale con calcolo indici di funzionalità
881	Scintigrafia tiroidea
886	Scintigrafia totale con tracciante recettoriale
896	Scintigrafia totale corporea
887	Scintigrafia totale corporea con cellule autologhe marcate
853	Scintigrafia totale corporea del midollo osseo
882	Scintigrafia totale corporea per ricerca localizzazioni radioiodiocaptanti
891	Scintigrafia un segmento con indicatori positivi e metodica polifasica
2200	Sclerectomia
2201	Sclerotomia (come unico intervento)
771	Screening per displasia delle anche
1444	Seconda applicazione di stent sulla stessa arteria
2467	Secondamento manuale
2520	Seni paranasali, intervento per mucocele
2521	Seni paranasali, intervento radicale bilaterale
2522	Seni paranasali, intervento radicale monolaterale
2523	Seno frontale, svuotamento per via esterna
2524	Seno frontale, svuotamento per via nasale
1774	Seno mascellare, apertura per processo alveolare
2525	Seno mascellare, puntura diameatica del
2526	Seno mascellare, svuotamento radicale bilaterale
2527	Seno mascellare, svuotamento radicale monolaterale
2528	Seno sfenoidale, apertura per via transnasale
463	Serotonina urinaria
2022	Setto vaginale, asportazione chirurgicatracheloplastica (come unico intervento)
2529	Setto-etmoidosfenotomia decompressiva neurovascolare radicale di primo e secondo grado monolaterale allargata
2530	Setto-etmoidosfenotomia decompressiva neurovascolare radicale di terzo grado monolaterale allargata
2531	Setto-etmoidostenotomia decompressiva neurovascolare conservativa conturbinotomie funzionalisettoplastica ricostruttiva o funzionale con turbinotomia
1422	Sezione o legatura del dotto arterioso di botallo
919	Sfigmogramma periferico per arto
1619	Sfinterotomia (come unico intervento)
464	Sideremia
465	Sierodiagnosi
2098	Simpatico dorsale: intervento associato sul simpatico toracico e sui nervi splancnici+b2035+b1018
1306	Simulazione con fusione di immagini tc e rmn
1307	Simulazione del trattamento: mediante rm
1308	Simulazione del trattamento: mediante tac
1309	Simulazione del trattamento: radiologia tradizionale
1310	Simulazione per radioterapia stereotassica con angiografia
1311	Simulazione per radioterapia stereotassica con tac
2437	Sindromi canalicolari del piede
1876	Sindromi stretto toracico superiore
2532	Sinechie nasali, recisione di
2225	Sinechiotomia
2830	Singolo attacco di semiprecisione /precisione in lnp o lp fuso prefabbricatoigiene orale e parodontologia
1488	Sinovialectomia (come unico intervento)
2417	Sinovialectomia grandi e medie articolazioni (come unico intervento)
2418	Sinoviectomia piccole articolazioni (come unico intervento)
1312	Sistema immobilizzazione per radioterapia 3d e dinamica
904	Skin prick test (qualsiasi numero)
466	Sodiemia
467	Sodio eritrocitario
468	Sodio urinario
469	Somatomedina c
470	Somatomedina igfbp1
471	Somatomedina igfbp3
1178	Somministrazione di farmaco subaracnoideo/ intratecale (test di prova)
1947	Sondaggio duodenale
1556	Sondaggio esofageo per dilatazione graduale (ciclo completo)
1948	Sondaggio gastrico
1949	Sondaggio gastrico frazionato con prove di stimolazione
2162	Sondaggio o lavaggio vie lacrimali (per seduta)
1241	Sonoterapia
472	Sorbitolo deidrogenasi
1179	Sostituzione di elettrostimolatore midollare
1445	Sostituzione generatore pace-maker definitivo
1423	Sostituzione valvolare singola (c.e.c.)
1424	Sostituzioni valvolari con by-pass aorto coronarico (c.e.c.)
823	Spettroscopia in mri
684	Spinal mouse
1098	Spirometria con misura di vt, fr, v, vo2
1099	Spirometria di base (cv o cvf, vems, mvv)
1100	Spirometria di base e dopo test di broncodilatazione
1101	Spirometria di base e dopo test di scatenamento aspecifico (broncocostrizione)spirometria di base e dopo test di scatenamento specifico (allergeni)
1103	Spirometria di base più curva flusso-volume
1102	Spirometria di base più curva flusso-volume dopo test di broncodilatazione
1104	Spirometria globale (cv, vri, vre, cfr, ct, vems, mvv, ci, vr/cpt, vems/cvf)
1106	Spirometria globale più curva flusso-volume
1105	Spirometria globale più curva flusso-volume dopo test di broncodilatazione
1666	Splenectomia
1446	Stand by cardiochirurgico
2494	Stapedectomia
2495	Stapedotomia
2291	Stecca da dito
2269	Stecca di zimmer per dito, applicazione di
1558	Stenosi esofagee, trattamento endoscopico con laser
2419	Stenosi vertebrale e lombare
2105	Stenosi vertebrale lombare
2771	Stent vascolari
2615	Stenting ureterale bilaterale (come unico intervento)
2614	Stenting ureterale monolaterale (come unico intervento)
2106	Stereotassi, intervento di talamotomia, pallidotomia ed altri interventi similari
2107	Strappamenti e blocchi di tronchi periferici del trigemino e di altri nervi cranici
717	Stratigrafia a.t.m. A bocca aperta e chiusa bilaterale
718	Stratigrafia a.t.m. A bocca aperta e chiusa monolaterale
719	Stratigrafia a.t.m. Pluridirezionale
720	Stratigrafia arti o articolazioni
728	Stratigrafia cavità nasali
729	Stratigrafia cavità nasali pluridirezionale
721	Stratigrafia colonna vertebrale
712	Stratigrafia faringe
713	Stratigrafia fegato, vie biliari, pancreas (con o senza contrasto)
714	Stratigrafia ghiandole salivari (con o senza contrasto)
730	Stratigrafia laringe a riposo e con fonazione
731	Stratigrafia laringe pluridirezionale
726	Stratigrafia mastoide / rocca petrosa bilaterale
743	Stratigrafia mediastino
722	Stratigrafia mirata del cranio
723	Stratigrafia mirata del cranio pluridirezionale
711	Stratigrafia o tomografia apparato digerente
716	Stratigrafia o tomografia apparato osteoarticolare e tessuti molli
727	Stratigrafia o tomografia apparato respiratorio
733	Stratigrafia o tomografia apparato urinario
736	Stratigrafia o tomografia apparato visivo
739	Stratigrafia o tomografia sistema nervoso
742	Stratigrafia o tomografia torace e mediastino
737	Stratigrafia orbita
738	Stratigrafia orbita pluridirezionale
734	Stratigrafia regione vescicale
735	Stratigrafia regioni renali
724	Stratigrafia scheletro toracico
740	Stratigrafia sella turcica
741	Stratigrafia sella turcica pluridirezionale
725	Stratigrafia seni paranasali
744	Stratigrafia torace bilaterale
745	Stratigrafia torace monolaterale
732	Stratigrafia trachea
473	Streptococco m test
474	Streptozyme
2163	Stricturotomia (come unico intervento)
974	Striscio vaginale per ricerca epstein bar virus
1085	Stroboscopia
854	Studio completo ferrocinetica con misure sedi emopoiesi e emocratesi
1028	Studio della velocità di conduzione motoria e sensitiva (per arto)
715	Studio dinamico della deglutizione
1313	Studio dosimetrico
1447	Studio elettrofisiologico endocavitario
935	Studio elettrofisiologico trans-esofageo
1029	Studio neurofisiologico del pavimento pelvico
824	Studio perfusionale
1030	Studio reflessologico del tronco dell'encefalo
2641	Surrenectomia (trattamento completo)
2185	Sutura corneale (come unico intervento)
2146	Sutura cute palpebrale (come unico intervento)
2226	Sutura dell'irideinterventi chirurgici oculistica - retina
2174	Sutura di ferita congiuntivale
1505	Sutura di ferita profonda della faccia
2456	Sutura di lacerazione cervicale
2131	Sutura ferite
2147	Sutura per ferite a tutto spessore (come unico intervento)
2202	Sutura sclerale
2420	Svuotamento di focolai metastatici ed armatura con sintesi più cemento
2533	Tamponamento nasale anteriore
2534	Tamponamento nasale antero-posteriore
475	Tampone vaginale
2496	Tappi di cerume, estrazione di
2148	Tarsorrafia (come unico intervento)
2186	Tatuaggio corneale
788	Tc - rm
789	Tc a fascio conico 3d (1 arcata)
790	Tc a fascio conico 3d (2 arcata)
791	Tc a.t.m. 3 d bilaterale
792	Tc a.t.m. Monolaterale
793	Tc addome completo
794	Tc addome inferiore
795	Tc addome superiore
796	Tc calcium score
797	Tc cardiaca completa
798	Tc colonna due metameri
799	Tc colonna: ogni metamero aggiuntivo
800	Tc cuore
801	Tc per endoscopie virtuali
802	Tc per fusione
803	Tc per ogni organo o distretto o apparato
804	Tc per ogni organo, distretto o apparato in più stessa seduta
805	Tc torace
806	Tc total body
1255	Tecarterapia (per seduta)
1140	Tecniche depurative crrt (emodialisi, emofiltrazione, emodiafiltrazione)
1314	Telecobaltoterapia cinetica (per seduta)
1315	Telecobaltoterapia od altre sorgenti gamma - statica (per seduta)
610	Telecuore
611	Telecuore con esofago baritato
2859	Teleradiografia
1064	Tempo di circolo della fluorescina (compreso anestesista)
476	Tempo di protrombina (pt)
477	Tempo di protrombina inr
478	Tempo di protrombina residua
479	Tempo di reptilase
480	Tempo di tromboplastina parziale (ptt)
772	Tempo svuotamento gastrico ecografico
2438	Tenolisi (come unico intervento)
2439	Tenoplastica, mioplastica, miorrafia
2440	Tenorrafia complessa
2441	Tenotomia, miotomia, aponeurectomia (come unico intervento)
1165	Terapia antalgica - compensi professionali - assistenza equipe medica (trattamenti completi)
1180	Terapia antalgica mediante infusione endovenosa (per ogni giornata di trattamento)
1181	Terapia antalgica segmentaria
1206	Terapia antalgica transcutanea (per seduta)
1684	Terapia chirurgica di fratture dei mascellari
1316	Terapia con acceleratore lineare fotoni od elettroni (per seduta)
2313	Terapia con onde d'urto (solo per calcificazioni periarticolari) per seduta
1317	Terapia conformazionale per la prostata od altri organi, ove necessaria (per seduta)
1141	Terapia infusionale (fleboclisi) escluso farmaco
1253	Terapia occupazionale (per seduta)
2703	Terapia rieducativa minzionale (per seduta)
1254	Terapia shiatsu (per seduta)
1243	Terapie fisiche mirate
1272	Terapie varie
2109	Termorizotomia dei nervi spinali
2108	Termorizotomia del g. Di gasser o altri nervi cranici
1258	Termoterapia
1031	Test afasie (diagnostica delle afasie)
1950	Test all'idrogeno respiratorio per malassorbimento od intolleranza al lattosio
1951	Test all'idrogeno respiratorio per proliferazione batterica del tenue
481	Test citotossico per additivi
482	Test citotossico per alimenti
483	Test combinato gnrh e trh per fsh lh e prolattina
901	Test cutanei diretti
484	Test di adesività piastrinica
486	Test di aggregazione piastrinica
485	Test di aggregazione piastrinica con aggregometro
487	Test di autoemolisi
883	Test di captazione tiroidea
488	Test di conferma per infezioni virali hcv (western-blot)
489	Test di coombs moreschi diretto
490	Test di coombs moreschi indiretto
491	Test di frammentazione del dna spermatico
492	Test di inibizione fattore reumatoide e/o c1q al lattice
493	Test di nordin
906	Test di provocazione
907	Test di provocazione bronchiale
908	Test di provocazione con alimenti ed additivitest di provocazione congiuntivale
909	Test di provocazione nasale
494	Test di ricerca emazie fetali (kleihauer)
495	Test di stamey
496	Test di stimolazione linfocitaria (fitoemoagglu. Blastogenesi)
1086	Test diagnostico al mannitolo (sindrome di meniere) compreso farmaco
905	Test epicutanei x farmaci e/o additivi (prick test più 8 test intradermici)
936	Test ergometrico
1032	Test farmacologico per cefalea
1033	Test farmacologico per miastenia
959	Test idrogeno respiratorio per proliferazione batterica nel tenue
497	Test isaac
498	Test per ricerca di intolleranze alimentari, dosaggio delle igg (batteria completa) - esame non ripetibile
499	Test per ricerca di intolleranze alimentari, test citotossico (batteria completa) - esame non ripetibile
500	Test per ricerca hpv (papilloma virus nel secreto vaginale)testosterone libero
501	Testosterone totale plasmatico
502	Testosterone urinario
503	Thinprep
604	Thinprep (esame citologico vaginale su strato sottile in fase liquida)
1877	Timectomia
2497	Timpanoplastica con mastoidectomia
2498	Timpanoplastica senza mastoidectomia
2500	Timpanotomia esplorativa
504	Tipizzazione antigeni ab0/d
505	Tipizzazione crioglobuline
506	Tipizzazione hla b27
507	Tipizzazione linfocitaria
508	Tipizzazione tissutale antigeni hla (loci a.b.c.) Ciascuno
509	Tipizzazione tissutale hla (b, c, dr, dq) ciascuno
510	Tireoglobulina
1535	Tiroidectomia complicata con trattamento per via sternotomica o toracotomia (gozzo immerso)
1536	Tiroidectomia totale con svuotamento laterocervicale bilaterale
1537	Tiroidectomia totale senza svuotamento laterocervicale
511	Tiroxina (t4)
512	Tiroxina libera (ft4 ot4 libero)
1107	Titolazione c-pap
513	Titolo anti o streptolisinico (tas)
514	Titolo anti streptojaluronidasico
515	Titolo antistafilolisinico
2422	Toilette chirurgica e piccole suture
1228	Toilette chirurgica lesioni cutanee da decubito (per seduta)
1818	Toilette di ustioni di grandi estensioni (prestazione ambulatoriale)
1819	Toilette di ustioni di piccole estensioni (prestazione ambulatoriale)
777	Tomografia computerizzata (tac)
875	Tomoscintigrafia (spet) cerebrale
835	Tomoscintigrafia (spet) del pool ematico cardiaco
837	Tomoscintigrafia (spet) miocardica
836	Tomoscintigrafia (spet) miocardica di perfusone a riposo e dopo test
704	Tomosintesi mammaria bilaterale
1318	Tomoterapia pet (per seduta)
1065	Tonografia e test di provocazione
1066	Tonometria (come unico atto medico)
2550	Tonsillectomia
1878	Torace carenato o escavato, trattamento chirurgico correttivo
1879	Toracentesi
1880	Toracoplastica, primo tempo
1881	Toracoplastica, secondo tempo
1108	Toracoscopia diagnostica e di stadiazione
1882	Toracotomia esplorativa (come unico intervento)
2315	Torcicollo e scoliosi su letto speciale, correzione di interventi chirurgici ortopedia e traumatologia - interventi cruenti
2214	Trabeculectomia
2215	Trabeculectomia + asportazione cataratta / intervento combinato
2216	Trabeculectomia + asportazione cataratta + impianto cristallino artificiale intervento combinato
2217	Trabeculotomia
1883	Tracheo- broncoscopia esplorativa
1884	Tracheo- broncoscopia operativa
1109	Tracheobroncoscopia diagnostica
1538	Tracheostomia, chiusura e plastica
1486	Tracheotomia con tracheostomia di elezione
1539	Tracheotomia con tracheostomia d'urgenza
516	Transaminasi glutammico ossalacetica (got o ast)
517	Transaminasi glutammico piruvica (gpt o alt)
519	Transferrina
518	Transferrina (carboidrato carente)
1067	Transilluminazione
1002	Translucenza nucale - ultrascreentri-test (esclusa ecografia)
2644	Transuretero-ureteroanastomosi
2110	Trapanazione cranica per puntura e drenaggio ventricolare
2443	Trapianti tendinei e muscolari o nervosi (trattamento completo)
2111	Trapianti, innesti ed altre operazioni plastiche (come unico intervento)
1425	Trapianto cardiaco
2187	Trapianto corneale a tutto spessore
2188	Trapianto corneale lamellare
1648	Trapianto di fegato
2423	Trapianto di midollo osseo (omnicomprensivo di servizi ed atti medici)
2780	Trapianto di organo
1667	Trapianto di pancreas
1885	Trapianto di polmone
2642	Trapianto di rene
1820	Trasferimento di lembo libero microvascolare
1821	Trasferimento di lembo libero peduncolato
2424	Traslazione muscoli cuffia e rotatori della spalla
2256	Trattamenti laser per cataratta secondaria
2798	Trattamento chimico dell'ipersensibilità e profilassi carie con applicazioni topiche
2035	Trattamento chirurgico conservativo laparotomico per gravidanza extrauterina
2023	Trattamento chirurgico conservativo monolaterale per via laparoscopica localizzazioni endometriosiche addomino-pelviche-annessiali
2025	Trattamento chirurgico conservativo monolaterale per via laparotomica localizzazioni endometriosiche addomino-pelviche-annessiali
2031	Trattamento chirurgico demolitivo bilaterale per via laparoscopica localizzazioni endometriosiche addomino-pelviche-annessiali
2033	Trattamento chirurgico demolitivo bilaterale per via laparotomica localizzazioni endometriosiche addomino-pelviche-annessiali
2036	Trattamento chirurgico demolitivo laparotomico per gravidanza extrauterina
2029	Trattamento chirurgico demolitivo monolaterale per via laparatomica localizzazioni endometriosiche addomino-pelviche-annessiali
2027	Trattamento chirurgico demolitivo monolaterale per via laparoscopica localizzazioni endometriosiche addomino-pelviche-annessiali
1967	Trattamento chirurgico di ascessi o diverticoli o cisti parauretrali
2435	Trattamento chirurgico di neurinomi
2014	Trattamento chirurgico di prolasso mucoso orifizio uretrale esterno
1476	Trattamento chirurgico per mano spastica - paralisi flaccide
2706	Trattamento completo uretroplastiche (lembi liberi o peduncolati)
2239	Trattamento di recessione-resezione-inginocchiamento
1319	Trattamento di termofrequenza mirato (per seduta)
1953	Trattamento endoscopico stenosi esofagee (1a seduta)
1955	Trattamento endoscopico stenosi esofagee (sedute successive)
1956	Trattamento endoscopico varici esofagee (1a seduta)
1959	Trattamento endoscopico varici esofagee (sedute successive)
1970	Trattamento laser per atrofia vaginale
1930	Trattamento mediante laser di alterazioni cutanee virali (verruche, condilomi, ecc...) (prima seduta)
1931	Trattamento mediante laser di alterazioni cutanee virali (verruche, condilomi, ecc...) (sedute successive)
1933	Trattamento mediante laser di malformazioni vascolari superficiali (prima seduta)
1934	Trattamento mediante laser di malformazioni vascolari superficiali (sedute successive)
1936	Trattamento mediante laser di tumori maligni cutanei (trattamento completo)
1489	Trattamento microchirurgico delle lesioni del plesso brachialeinterventi chirurgici chirurgia generale - piccoli interventi - varie
2541	Trattamento per narici del setto
825	Trattografia mnr
1269	Trazioni vertebrali cervicali (per seduta)
1270	Trazioni vertebrali lombosacrali (per seduta)
1271	Trazioni vertebrali meccaniche (per seduta)
520	Trichomonas : ricerca antigene
521	Trichomonas: ricerca microscopica
522	Trigliceridi
523	Triiodotironina libera (ft3 o t3 libero)
524	Triiodotironina totale (t3)
525	Tripsina sangue/urine
1912	Trombectomia venosa superficiale (come unico intervento)
526	Trombina coagulasi
1913	Tromboendoarteriectomia aorto-iliaca ed eventuale plastica vasale
1914	Tromboendoarteriectomia e by-pass e/o embolectomia di carotide e vasi epiaortici
1915	Tromboendoarteriectomia e patch e/o embolectomia di carotide e vasi epiaortici
1916	Tromboendoarteriectomia e plastica arteria femorale
1917	Tromboendoarteriectomia e trapianto e/o embolectomia di carotide e vasi epiaortici
527	Troponina t
1644	Tumore maligno della parete addominale, asportazione dipapillostomia, per via transduodenale (come unico intervento)
2114	Tumore orbitale, asportazione per via endocranica
1517	Tumore superficiale o sottocutaneo benigno o cisti tronco/arti, asportazione di (trattamento completo)
2116	Tumori della base cranica, intervento per via transorale
2117	Tumori orbitali, intervento per via epipalpebrale
1823	Tumori superficiali benigni o cisti del viso, intervento per (trattamento completo)
2537	Turbinati inferiori, svuotamento funzionale (come unico intervento)
2538	Turbinati medi, intervento su (come unico intervento)
2539	Turbinati, cauterizzazione dei (come unico intervento)
2540	Turbinotomia (come unico intervento)
2773	Tutore di funzione arto inferiore
2774	Tutore di funzione arto superiore
2775	Tutore di funzione: tronco corsetti ortopedici
2776	Tutore di riposo o di posizione
2553	Ugulotomia
1242	Ultrasuoni (per seduta)
1210	Ultravioletti applicazioni uva (per seduta)
2429	Uncoforaminotomia o vertebrotomia (trattamento completo)volkmann, intervento per retrazioni ischemiche
528	Urati clearance
529	Urea clearance
2648	Ureterocistoneostomia bilaterale
2647	Ureterocistoneostomia monolaterale
2650	Ureterocutaneostomia bilaterale
2649	Ureterocutaneostomia monolaterale
2646	Uretero-ileo-anastomosi bilaterale
2645	Uretero-ileo-anastomosi monolaterale
2653	Ureteroileocutaneostomia non continente
2654	Ureterolisi più omentoplastica
2655	Ureterolitotomia lombo-iliaca
2656	Ureterolitotomia pelvica
1125	Ureteroscopia
2594	Ureteroscopia (omnicomprensiva)
2658	Ureterosigmoidoscopia bilaterale
2657	Ureterosigmoidoscopia monolaterale
2587	Uretra, dilatazione con sonde morbide o rigide (per seduta)
2704	Uretrectomia totale
2595	Uretrocistoscopia semplice (come unico atto diagnostico)
2707	Uretrostomia perineale
2617	Uretrotomia endoscopica
530	Uricemia
1126	Uroflussimetria
696	Urografia
697	Urografia con stratigrafia e diretta reni
975	V.a.b.r.a. A scopo diagnostico
2039	V.a.b.r.a. A scopo diagnostico
705	Vabb (comprensivo di esame istologico)
1256	Vacumterapia (per seduta)
1572	Vagotomia selettiva, tronculare con piloroplastica
1573	Vagotomia superselettiva
1775	Valutazione elettrognatomiografica delle a.t.m.
2777	Valvola cardiaca
2618	Valvola uretrale, resezione endoscopica (come unico intervento)
1426	Valvuloplastica cardiaca
1918	Varicectomia (come unico intervento)
1919	Varicectomia con legatura di vene comunicanti (come unico intervento)
1559	Varici esofagee, sclero terapia endoscopica
1560	Varici esofagee: emostasi con sonda tamponante
1561	Varici esofagee: intervento transtoracico o addominale
1920	Varici recidive
1921	Varicocele (scleroembolizzazione)
2744	Varicocele con tecnica microchirurgica
532	Velocità di sedimentazione delle emazie (ves)
2554	Velofaringoplastica
1190	Ventilazione polmonare strumentale (per seduta)
1266	Vertebroterapia manu medica
2679	Vescica, plastiche di ampliamento (colon/ileo)
2680	Vescicoplastica antireflusso bilaterale
2681	Vescicoplastica antireflusso unilaterale
533	Vibrione colerico nelle feci (ricerca diretta)
1127	Video urodinamica
1649	Vie biliari, interventi palliativi
1650	Vie biliari, reinterventi
1003	Villocentesi (cariotipo su villi coriali compreso prelievo bioptico)
534	Virus respiratorio sinciziale (ricerca diretta)
535	Viscosità ematica
1279	Viss (vibration sound system) (per seduta)
536	Vitamine (dosaggio per singola determinazione)
2234	Vitrectomia anteriore o posteriore
2040	Vulvectomia parziale
2044	Vulvectomia totale
2619	Wall stent per stenosi uretrali compresa nefrostomia
2620	Wall stent per stenosi uretrali per via endoscopica (urolume)
1182	Wash out farmacologico per cefalea cronica (compresi farmaci) in day hospital - almeno 5 sedute
537	Zinco
\.


--
-- Data for Name: general_practitioner; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.general_practitioner (practitioner_id, first_name, last_name, working_province, working_place) FROM stdin;
aurora.scandone@yahoo.it	Aurora	Scandone	TA	Monteiasi
gianna.cociarelli@hotmail.com	Gianna	Cociarelli	MT	Nova Siri
paloma.zamengo@libero.it	Paloma	Zamengo	TV	Moriago della Battaglia
giorgio.barcaccia@yahoo.it	Giorgio	Barcaccia	NU	Elini
atenulf.lanfranchi@hotmail.com	Atenulf	Lanfranchi	MT	Nova Siri
temistocle.parini@yahoo.it	Temistocle	Parini	TV	Moriago della Battaglia
rosina.tedesco@gmail.com	Rosina	Tedesco	MT	Nova Siri
natalia.zetticci@gmail.com	Natalia	Zetticci	NU	Elini
eraldo.abba@yahoo.it	Eraldo	Abba	NU	Posada
carolina.malatesta@libero.it	Carolina	Malatesta	TA	Avetrana
luciano.sanguineti@hotmail.com	Luciano	Sanguineti	TA	Maruggio
luca.verga@yahoo.it	Luca	Verga	TV	Monastier di Treviso
aldo.morabito@gmail.com	Aldo	Morabito	TV	Sernaglia della Battaglia
ugolino.scaramucci@yahoo.it	Ugolino	Scaramucci	MT	Montescaglioso
ippazio.bettoni@libero.it	Ippazio	Bettoni	MT	Garaguso
marissa.barzini@yahoo.it	Marissa	Barzini	NU	Meana Sardo
toni.gemito@gmail.com	Toni	Gemito	NU	Lei
rosaria.chiaramonte@libero.it	Rosaria	Chiaramonte	TA	Statte
arnaldo.golino@yahoo.it	Arnaldo	Golino	TA	Leporano
sabatino.zanzi@gmail.com	Sabatino	Zanzi	TV	Maserada sul Piave
giovanna.rosiello@virgilio.it	Giovanna	Rosiello	TV	Casier
raffaello.nicoletti@gmail.com	Raffaello	Nicoletti	MT	Miglionico
luca.tutino@gmail.com	Luca	Tutino	MT	Montalbano Jonico
\.


--
-- Data for Name: health_service; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.health_service (health_service_id, operating_province) FROM stdin;
ssp.agrigento@gmail.com	AG
ssp.alessandria@gmail.com	AL
ssp.ancona@gmail.com	AN
ssp.arezzo@gmail.com	AR
ssp.asti@gmail.com	AT
ssp.avellino@gmail.com	AV
ssp.bari@gmail.com	BA
ssp.barlettaandriatrani@gmail.com	BT
ssp.belluno@gmail.com	BL
ssp.benevento@gmail.com	BN
ssp.bergamo@gmail.com	BG
ssp.biella@gmail.com	BI
ssp.bologna@gmail.com	BO
ssp.bolzano@gmail.com	BZ
ssp.brescia@gmail.com	BS
ssp.brindisi@gmail.com	BR
ssp.cagliari@gmail.com	CA
ssp.caltanissetta@gmail.com	CL
ssp.campobasso@gmail.com	CB
ssp.caserta@gmail.com	CE
ssp.catania@gmail.com	CT
ssp.catanzaro@gmail.com	CZ
ssp.chieti@gmail.com	CH
ssp.como@gmail.com	CO
ssp.cosenza@gmail.com	CS
ssp.cremona@gmail.com	CR
ssp.crotone@gmail.com	KR
ssp.cuneo@gmail.com	CN
ssp.enna@gmail.com	EN
ssp.fermo@gmail.com	FM
ssp.ferrara@gmail.com	FE
ssp.firenze@gmail.com	FI
ssp.foggia@gmail.com	FG
ssp.forlicesena@gmail.com	FC
ssp.frosinone@gmail.com	FR
ssp.genova@gmail.com	GE
ssp.gorizia@gmail.com	GO
ssp.grosseto@gmail.com	GR
ssp.imperia@gmail.com	IM
ssp.isernia@gmail.com	IS
ssp.latina@gmail.com	LT
ssp.lecce@gmail.com	LE
ssp.lecco@gmail.com	LC
ssp.livorno@gmail.com	LI
ssp.lodi@gmail.com	LO
ssp.lucca@gmail.com	LU
ssp.macerata@gmail.com	MC
ssp.mantova@gmail.com	MN
ssp.massacarrara@gmail.com	MS
ssp.matera@gmail.com	MT
ssp.messina@gmail.com	ME
ssp.milano@gmail.com	MI
ssp.modena@gmail.com	MO
ssp.monzabrianza@gmail.com	MB
ssp.napoli@gmail.com	NA
ssp.novara@gmail.com	NO
ssp.nuoro@gmail.com	NU
ssp.oristano@gmail.com	OR
ssp.padova@gmail.com	PD
ssp.palermo@gmail.com	PA
ssp.parma@gmail.com	PR
ssp.pavia@gmail.com	PV
ssp.perugia@gmail.com	PG
ssp.pesarourbino@gmail.com	PU
ssp.pescara@gmail.com	PE
ssp.piacenza@gmail.com	PC
ssp.pisa@gmail.com	PI
ssp.pistoia@gmail.com	PT
ssp.pordenone@gmail.com	PN
ssp.potenza@gmail.com	PZ
ssp.prato@gmail.com	PO
ssp.ragusa@gmail.com	RG
ssp.ravenna@gmail.com	RA
ssp.reggioemilia@gmail.com	RE
ssp.rieti@gmail.com	RI
ssp.rimini@gmail.com	RN
ssp.roma@gmail.com	RM
ssp.rovigo@gmail.com	RO
ssp.salerno@gmail.com	SA
ssp.sassari@gmail.com	SS
ssp.savona@gmail.com	SV
ssp.siena@gmail.com	SI
ssp.siracusa@gmail.com	SR
ssp.sondrio@gmail.com	SO
ssp.taranto@gmail.com	TA
ssp.teramo@gmail.com	TE
ssp.terni@gmail.com	TR
ssp.torino@gmail.com	TO
ssp.trapani@gmail.com	TP
ssp.trento@gmail.com	TN
ssp.treviso@gmail.com	TV
ssp.trieste@gmail.com	TS
ssp.udine@gmail.com	UD
ssp.aosta@gmail.com	AO
ssp.varese@gmail.com	VA
ssp.venezia@gmail.com	VE
ssp.verbanocusioossola@gmail.com	VB
ssp.vercelli@gmail.com	VC
ssp.verona@gmail.com	VR
ssp.vicenza@gmail.com	VI
ssp.viterbo@gmail.com	VT
ssp.sudsardegna@gmail.com	SU
ssp.laquila@gmail.com	AQ
ssp.reggiocalabria@gmail.com	RC
ssp.ascolipiceno@gmail.com	AP
ssp.laspezia@gmail.com	SP
ssp.vibovalentia@gmail.com	VV
\.


--
-- Data for Name: password_reset; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.password_reset (user_id, token, expiring_date) FROM stdin;
\.


--
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.patient (patient_id, first_name, last_name, birth_date, birth_place, ssn, gender, practitioner_id, living_province, living_place) FROM stdin;
pompeo.pizzetti@virgilio.it	Pompeo	Pizzetti	1950-01-24 00:00:00	Pieve del Cairo	PZZPMP50A24G639N	M	aurora.scandone@yahoo.it	TA	Montemesola
elmo.murialdo@gmail.com	Elmo	Murialdo	2004-08-12 00:00:00	Cessalto	MRLLME04M12C580V	M	aurora.scandone@yahoo.it	TA	Crispiano
antonello.detti@gmail.com	Antonello	Detti	1988-06-28 00:00:00	Albiano	DTTNNL88H28A158R	M	aurora.scandone@yahoo.it	TA	San Marzano di San Giuseppe
letizia.dibiasi@libero.it	Letizia	Dibiasi	2001-08-11 00:00:00	Capaci	DBSLTZ01M51B645Y	F	aurora.scandone@yahoo.it	TA	Laterza
rosina.abba@yahoo.it	Rosina	Abba	1963-11-26 00:00:00	Roccapiemonte	BBARSN63S66H431K	F	aurora.scandone@yahoo.it	TA	Monteiasi
gioacchino.antonetti@hotmail.com	Gioacchino	Antonetti	2008-10-23 00:00:00	Livraga	NTNGCH08R23E627L	M	aurora.scandone@yahoo.it	TA	Ginosa
michelangelo.gaiatto@virgilio.it	Michelangelo	Gaiatto	2006-02-16 00:00:00	Carovigno	GTTMHL06B16B809W	M	aurora.scandone@yahoo.it	TA	Martina Franca
fortunata.gozzano@libero.it	Fortunata	Gozzano	1994-09-17 00:00:00	Bortigali	GZZFTN94P57B062C	F	aurora.scandone@yahoo.it	TA	Monteparano
fortunata.novaro@virgilio.it	Fortunata	Novaro	2013-10-25 00:00:00	Grassobbio	NVRFTN13R65E148I	F	aurora.scandone@yahoo.it	TA	Montemesola
etta.andreozzi@gmail.com	Etta	Andreozzi	1984-07-02 00:00:00	Casole d'Elsa	NDRTTE84L42B984N	F	aurora.scandone@yahoo.it	TA	Martina Franca
concetta.maccanelli@hotmail.com	Concetta	Maccanelli	1999-12-21 00:00:00	Lozio	MCCCCT99T61E706H	F	aurora.scandone@yahoo.it	TA	Faggiano
giada.niggli@libero.it	Giada	Niggli	1949-01-19 00:00:00	Silvano d'Orba	NGGGDI49A59I738Y	F	aurora.scandone@yahoo.it	TA	Carosino
zaira.zaguri@virgilio.it	Zaira	Zaguri	1990-04-15 00:00:00	Bomporto	ZGRZRA90D55A959H	F	aurora.scandone@yahoo.it	TA	Crispiano
paolo.valmarana@virgilio.it	Paolo	Valmarana	1958-08-21 00:00:00	Sala Comacina	VLMPLA58M21H679T	M	aurora.scandone@yahoo.it	TA	Massafra
matteo.prada@virgilio.it	Matteo	Prada	1991-03-04 00:00:00	Stezzano	PRDMTT91C04I951M	M	aurora.scandone@yahoo.it	TA	Lizzano
rosa.pincherle@libero.it	Rosa	Pincherle	2012-12-04 00:00:00	Trentinara	PNCRSO12T44L377F	F	gianna.cociarelli@hotmail.com	MT	San Mauro Forte
caterina.taliani@yahoo.it	Caterina	Taliani	1968-05-16 00:00:00	Siamanna	TLNCRN68E56I718J	F	gianna.cociarelli@hotmail.com	MT	Grottole
melina.micca@hotmail.com	Melina	Micca	1970-03-01 00:00:00	Montelanico	MCCMLN70C41F534G	F	gianna.cociarelli@hotmail.com	MT	Policoro
annunziata.luzi@yahoo.it	Annunziata	Luzi	1989-05-31 00:00:00	Caraglio	LZUNNZ89E71B719F	F	gianna.cociarelli@hotmail.com	MT	Scanzano Jonico
roberto.pigafetta@hotmail.com	Roberto	Pigafetta	2015-01-30 00:00:00	Pertosa	PGFRRT15A30G476J	M	gianna.cociarelli@hotmail.com	MT	Irsina
laureano.piazzi@virgilio.it	Laureano	Piazzi	1944-12-14 00:00:00	Volpeglino	PZZLRN44T14M121E	M	gianna.cociarelli@hotmail.com	MT	Matera
amalia.ravaglioli@gmail.com	Amalia	Ravaglioli	2011-12-02 00:00:00	Inzago	RVGMLA11T42E317J	F	gianna.cociarelli@hotmail.com	MT	Grassano
rossana.battaglia@virgilio.it	Rossana	Battaglia	1991-06-10 00:00:00	Castel di Tora	BTTRSN91H50C098V	F	gianna.cociarelli@hotmail.com	MT	Grassano
martina.carducci@yahoo.it	Martina	Carducci	1985-08-11 00:00:00	Gadoni	CRDMTN85M51D842Q	F	gianna.cociarelli@hotmail.com	MT	Grottole
serena.giannetti@virgilio.it	Serena	Giannetti	1982-11-15 00:00:00	Grottammare	GNNSRN82S55E207I	F	gianna.cociarelli@hotmail.com	MT	Grassano
tullio.terragni@yahoo.it	Tullio	Terragni	1941-03-27 00:00:00	Carrù	TRRTLL41C27B841B	M	gianna.cociarelli@hotmail.com	MT	Scanzano Jonico
napoleone.bellucci@libero.it	Napoleone	Bellucci	1962-07-07 00:00:00	Arcola	BLLNLN62L07A373A	M	gianna.cociarelli@hotmail.com	MT	Cirigliano
durante.grifeo@virgilio.it	Durante	Grifeo	1969-01-19 00:00:00	Tramutola	GRFDNT69A19L326N	M	gianna.cociarelli@hotmail.com	MT	Scanzano Jonico
paoletta.salandra@hotmail.com	Paoletta	Salandra	1972-03-04 00:00:00	Badolato	SLNPTT72C44A542U	F	gianna.cociarelli@hotmail.com	MT	San Giorgio Lucano
adelasia.vespa@virgilio.it	Adelasia	Vespa	1961-12-21 00:00:00	Faenza	VSPDLS61T61D458Y	F	gianna.cociarelli@hotmail.com	MT	Miglionico
severino.baresi@yahoo.it	Severino	Baresi	2005-09-09 00:00:00	Gavello	BRSSRN05P09D942B	M	paloma.zamengo@libero.it	TV	San Polo di Piave
rosalia.morosini@libero.it	Rosalia	Morosini	1963-09-03 00:00:00	Fombio	MRSRSL63P43D660O	F	paloma.zamengo@libero.it	TV	San Biagio di Callalta
napoleone.crespi@yahoo.it	Napoleone	Crespi	2009-03-01 00:00:00	Frascaro	CRSNLN09C01D770D	M	paloma.zamengo@libero.it	TV	Monfumo
rembrandt.respighi@libero.it	Rembrandt	Respighi	1974-11-17 00:00:00	Ripe San Ginesio	RSPRBR74S17H323H	M	paloma.zamengo@libero.it	TV	Vidor
rosa.lercari@hotmail.com	Rosa	Lercari	1949-03-17 00:00:00	Santo Stefano Ticino	LRCRSO49C57I361F	F	paloma.zamengo@libero.it	TV	Loria
serafina.respighi@hotmail.com	Serafina	Respighi	1998-08-07 00:00:00	Saint-Marcel	RSPSFN98M47H671O	F	paloma.zamengo@libero.it	TV	Crocetta del Montello
letizia.ruggeri@yahoo.it	Letizia	Ruggeri	1974-08-26 00:00:00	San Potito Ultra	RGGLTZ74M66I129O	F	paloma.zamengo@libero.it	TV	Oderzo
gemma.forza@libero.it	Gemma	Forza	2016-03-10 00:00:00	Polinago	FRZGMM16C50G789C	F	paloma.zamengo@libero.it	TV	Salgareda
giacobbe.lucarelli@gmail.com	Giacobbe	Lucarelli	1999-09-20 00:00:00	Castri di Lecce	LCRGBB99P20C334A	M	paloma.zamengo@libero.it	TV	Chiarano
vincenza.lombroso@yahoo.it	Vincenza	Lombroso	2019-12-12 00:00:00	Moso in Passiria	LMBVCN19T52F766B	F	paloma.zamengo@libero.it	TV	Tarzo
livio.camicione@yahoo.it	Livio	Camicione	1968-04-08 00:00:00	Magliano Vetere	CMCLVI68D08E814D	M	paloma.zamengo@libero.it	TV	Roncade
rosina.vento@yahoo.it	Rosina	Vento	2001-12-15 00:00:00	Perletto	VNTRSN01T55G457U	F	paloma.zamengo@libero.it	TV	Fregona
liberto.ricci@virgilio.it	Liberto	Ricci	1975-12-09 00:00:00	Modugno	RCCLRT75T09F262B	M	paloma.zamengo@libero.it	TV	Pederobba
lucia.sibilia@virgilio.it	Lucia	Sibilia	1979-12-19 00:00:00	Pian Camuno	SBLLCU79T59G546B	F	paloma.zamengo@libero.it	TV	Miane
eva.bonolis@hotmail.com	Eva	Bonolis	1968-10-18 00:00:00	Frisanco	BNLVEA68R58D804D	F	paloma.zamengo@libero.it	TV	Fontanelle
fiorenzo.falier@yahoo.it	Fiorenzo	Falier	2019-06-16 00:00:00	Marradi	FLRFNZ19H16E971A	M	giorgio.barcaccia@yahoo.it	NU	Posada
isa.lollobrigida@libero.it	Isa	Lollobrigida	1954-07-28 00:00:00	Loro Piceno	LLLSIA54L68E694J	F	giorgio.barcaccia@yahoo.it	NU	Tortolì
aria.castioni@hotmail.com	Aria	Castioni	1982-01-15 00:00:00	Roddi	CSTRAI82A55H472B	F	giorgio.barcaccia@yahoo.it	NU	Ollolai
mauro.visintini@libero.it	Mauro	Visintini	1951-10-07 00:00:00	San Martino Buon Albergo	VSNMRA51R07I003T	M	giorgio.barcaccia@yahoo.it	NU	Borore
dante.gagliardi@libero.it	Dante	Gagliardi	1952-05-04 00:00:00	Limana	GGLDNT52E04E588O	M	giorgio.barcaccia@yahoo.it	NU	Osidda
lamberto.treves@gmail.com	Lamberto	Treves	2001-06-20 00:00:00	Marcignago	TRVLBR01H20E934Y	M	giorgio.barcaccia@yahoo.it	NU	Cardedu
sergius.polani@virgilio.it	Sergius	Polani	1945-05-30 00:00:00	Borgomanero	PLNSGS45E30B019G	M	giorgio.barcaccia@yahoo.it	NU	Villagrande Strisaili
amadeo.toscanini@libero.it	Amadeo	Toscanini	1943-11-22 00:00:00	Vedeseta	TSCMDA43S22L707C	M	giorgio.barcaccia@yahoo.it	NU	Galtellì
dolores.trillini@gmail.com	Dolores	Trillini	1963-01-03 00:00:00	Campagnatico	TRLDRS63A43B497A	F	giorgio.barcaccia@yahoo.it	NU	Talana
santino.micheletti@yahoo.it	Santino	Micheletti	1990-01-04 00:00:00	San Tammaro	MCHSTN90A04I261C	M	giorgio.barcaccia@yahoo.it	NU	Onanì
antonina.filzi@hotmail.com	Antonina	Filzi	1945-06-24 00:00:00	Ferruzzano	FLZNNN45H64D557V	F	giorgio.barcaccia@yahoo.it	NU	Noragugume
orlando.boito@virgilio.it	Orlando	Boito	1953-07-27 00:00:00	Martignacco	BTORND53L27E982R	M	giorgio.barcaccia@yahoo.it	NU	Siniscola
patrizia.bonomo@virgilio.it	Patrizia	Bonomo	2008-07-09 00:00:00	Beinette	BNMPRZ08L49A735U	F	giorgio.barcaccia@yahoo.it	NU	Onanì
manuel.grossi@yahoo.it	Manuel	Grossi	1967-02-06 00:00:00	Caselette	GRSMNL67B06B955I	M	giorgio.barcaccia@yahoo.it	NU	Ussassai
tatiana.villarosa@hotmail.com	Tatiana	Villarosa	1965-09-19 00:00:00	Grizzana Morandi	VLLTTN65P59E187T	F	giorgio.barcaccia@yahoo.it	NU	Bolotana
virginia.manzoni@libero.it	Virginia	Manzoni	2017-11-25 00:00:00	Caronia	MNZVGN17S65B804O	F	atenulf.lanfranchi@hotmail.com	MT	Bernalda
milena.cerutti@gmail.com	Milena	Cerutti	1943-11-24 00:00:00	San Felice a Cancello	CRTMLN43S64H834M	F	atenulf.lanfranchi@hotmail.com	MT	Stigliano
maria.muratori@virgilio.it	Maria	Muratori	1977-07-22 00:00:00	Agra	MRTMRA77L62A085A	F	atenulf.lanfranchi@hotmail.com	MT	Oliveto Lucano
lorenzo.pagliaro@hotmail.com	Lorenzo	Pagliaro	1962-05-02 00:00:00	Trequanda	PGLLNZ62E02L384F	M	atenulf.lanfranchi@hotmail.com	MT	Tursi
tullio.cundari@virgilio.it	Tullio	Cundari	1980-11-20 00:00:00	Broni	CNDTLL80S20B201V	M	atenulf.lanfranchi@hotmail.com	MT	Matera
gianluca.cainero@gmail.com	Gianluca	Cainero	1981-08-02 00:00:00	Vinchio	CNRGLC81M02M058O	M	atenulf.lanfranchi@hotmail.com	MT	Calciano
armando.bianchi@virgilio.it	Armando	Bianchi	1998-06-18 00:00:00	Ferrera Erbognone	BNCRND98H18D552U	M	atenulf.lanfranchi@hotmail.com	MT	Salandra
griselda.cilea@yahoo.it	Griselda	Cilea	2002-01-16 00:00:00	Monterosso Calabro	CLIGSL02A56F607V	F	atenulf.lanfranchi@hotmail.com	MT	Garaguso
germana.benussi@yahoo.it	Germana	Benussi	1941-07-19 00:00:00	Itri	BNSGMN41L59E375D	F	atenulf.lanfranchi@hotmail.com	MT	Grottole
cipriano.antonello@hotmail.com	Cipriano	Antonello	1994-03-27 00:00:00	Lauco	NTNCRN94C27E476K	M	atenulf.lanfranchi@hotmail.com	MT	Pisticci
coriolano.ferrara@hotmail.com	Coriolano	Ferrara	1980-08-07 00:00:00	Ortona dei Marsi	FRRCLN80M07G142W	M	atenulf.lanfranchi@hotmail.com	MT	Montescaglioso
emma.guidone@libero.it	Emma	Guidone	2015-04-05 00:00:00	Sondrio	GDNMME15D45I829V	F	atenulf.lanfranchi@hotmail.com	MT	Valsinni
giacobbe.bertolucci@libero.it	Giacobbe	Bertolucci	1999-12-07 00:00:00	Marano Lagunare	BRTGBB99T07E910W	M	atenulf.lanfranchi@hotmail.com	MT	Nova Siri
rosario.roero@libero.it	Rosario	Roero	2006-07-12 00:00:00	Melissano	RRORSR06L12F109V	M	atenulf.lanfranchi@hotmail.com	MT	Scanzano Jonico
adelasia.castiglione@hotmail.com	Adelasia	Castiglione	2017-12-29 00:00:00	Villafranca Padovana	CSTDLS17T69L947H	F	atenulf.lanfranchi@hotmail.com	MT	Pomarico
sylvia.raimondi@yahoo.it	Sylvia	Raimondi	1955-05-13 00:00:00	Pavullo nel Frignano	RMNSLV55E53G393V	F	temistocle.parini@yahoo.it	TV	Monastier di Treviso
pasquale.scaduto@libero.it	Pasquale	Scaduto	1992-12-17 00:00:00	San Giorgio Ionico	SCDPQL92T17H882R	M	temistocle.parini@yahoo.it	TV	Maser
agnolo.farnese@virgilio.it	Agnolo	Farnese	2010-01-11 00:00:00	Brissago-Valtravaglia	FRNGNL10A11B191V	M	temistocle.parini@yahoo.it	TV	Resana
amanda.mattarella@gmail.com	Amanda	Mattarella	1949-03-03 00:00:00	Isnello	MTTMND49C43E337V	F	temistocle.parini@yahoo.it	TV	Mogliano Veneto
guido.baggio@gmail.com	Guido	Baggio	2005-05-31 00:00:00	Seclì	BGGGDU05E31I559P	M	temistocle.parini@yahoo.it	TV	Altivole
renzo.gianetti@libero.it	Renzo	Gianetti	1962-01-07 00:00:00	Fornace	GNTRNZ62A07D714N	M	temistocle.parini@yahoo.it	TV	Vidor
ottavio.longhena@gmail.com	Ottavio	Longhena	2005-04-16 00:00:00	Ozegna	LNGTTV05D16G202B	M	temistocle.parini@yahoo.it	TV	Altivole
delfino.rosmini@gmail.com	Delfino	Rosmini	2003-10-21 00:00:00	Palermiti	RSMDFN03R21G272G	M	temistocle.parini@yahoo.it	TV	Montebelluna
maria.scotto@virgilio.it	Maria	Scotto	1986-11-29 00:00:00	Alagna	SCTMRA86S69A118C	F	temistocle.parini@yahoo.it	TV	Sernaglia della Battaglia
benedetto.venturi@yahoo.it	Benedetto	Venturi	1983-03-31 00:00:00	Valfornace	VNTBDT83C31M382W	M	temistocle.parini@yahoo.it	TV	Trevignano
fiamma.iannelli@gmail.com	Fiamma	Iannelli	1970-04-15 00:00:00	Montesilvano	NNLFMM70D55F646X	F	temistocle.parini@yahoo.it	TV	Casier
melissa.navarria@hotmail.com	Melissa	Navarria	2019-03-06 00:00:00	Bagnolo Cremasco	NVRMSS19C46A570P	F	temistocle.parini@yahoo.it	TV	Treviso
ruggero.dossetti@gmail.com	Ruggero	Dossetti	1961-07-30 00:00:00	Mongardino	DSSRGR61L30F361Y	M	temistocle.parini@yahoo.it	TV	Sarmede
tiziana.iannuzzi@yahoo.it	Tiziana	Iannuzzi	2006-05-31 00:00:00	Spiazzo	NNZTZN06E71I899J	F	temistocle.parini@yahoo.it	TV	Spresiano
gioachino.balbi@yahoo.it	Gioachino	Balbi	2013-12-13 00:00:00	Sant'Ilario dello Ionio	BLBGHN13T13I341N	M	temistocle.parini@yahoo.it	TV	Resana
tullio.beffa@hotmail.com	Tullio	Beffa	2008-07-08 00:00:00	Chianni	BFFTLL08L08C609S	M	rosina.tedesco@gmail.com	MT	San Giorgio Lucano
maura.mascagni@hotmail.com	Maura	Mascagni	2012-04-29 00:00:00	Bagnaria	MSCMRA12D69A550M	F	rosina.tedesco@gmail.com	MT	Aliano
olga.moschino@yahoo.it	Olga	Moschino	1941-07-02 00:00:00	Casola Valsenio	MSCLGO41L42B982J	F	rosina.tedesco@gmail.com	MT	Bernalda
adelasia.disdero@virgilio.it	Adelasia	Disdero	1960-12-09 00:00:00	Concordia Sagittaria	DSDDLS60T49C950K	F	rosina.tedesco@gmail.com	MT	Tursi
alessandra.giulietti@hotmail.com	Alessandra	Giulietti	1951-03-09 00:00:00	Caspoggio	GLTLSN51C49B993C	F	rosina.tedesco@gmail.com	MT	Grassano
milo.mussolini@gmail.com	Milo	Mussolini	1978-02-13 00:00:00	Canda	MSSMLI78B13B582C	M	rosina.tedesco@gmail.com	MT	Nova Siri
lara.vattimo@virgilio.it	Lara	Vattimo	1959-09-28 00:00:00	Ferentillo	VTTLRA59P68D538U	F	rosina.tedesco@gmail.com	MT	Tricarico
nicolò.lovato@gmail.com	Nicolò	Lovato	1942-07-13 00:00:00	Salvitelle	LVTNCL42L13H732T	M	rosina.tedesco@gmail.com	MT	Rotondella
milo.borgia@yahoo.it	Milo	Borgia	2017-02-02 00:00:00	Buttapietra	BRGMLI17B02B304H	M	rosina.tedesco@gmail.com	MT	Aliano
irma.manolesso@hotmail.com	Irma	Manolesso	1988-05-25 00:00:00	Frassino	MNLRMI88E65D782K	F	rosina.tedesco@gmail.com	MT	Oliveto Lucano
ivan.raurica@yahoo.it	Ivan	Raurica	1965-01-04 00:00:00	Monte San Biagio	RRCVNI65A04F616P	M	rosina.tedesco@gmail.com	MT	Miglionico
gioffre.tasso@virgilio.it	Gioffre	Tasso	1996-06-29 00:00:00	Plataci	TSSGFR96H29G733Y	M	rosina.tedesco@gmail.com	MT	Grottole
bianca.visintini@gmail.com	Bianca	Visintini	2015-11-12 00:00:00	Ascea	VSNBNC15S52A460K	F	rosina.tedesco@gmail.com	MT	San Mauro Forte
raimondo.ortolani@libero.it	Raimondo	Ortolani	1999-03-11 00:00:00	Casei Gerola	RTLRND99C11B954N	M	rosina.tedesco@gmail.com	MT	San Giorgio Lucano
laureano.bignardi@yahoo.it	Laureano	Bignardi	1945-02-06 00:00:00	Olivadi	BGNLRN45B06G034C	M	rosina.tedesco@gmail.com	MT	Montalbano Jonico
ornella.altera@gmail.com	Ornella	Altera	1949-09-24 00:00:00	Nicorvo	LTRRLL49P64F891C	F	natalia.zetticci@gmail.com	NU	Nuoro
marta.guidone@virgilio.it	Marta	Guidone	1968-07-27 00:00:00	Trezzano Rosa	GDNMRT68L67L408K	F	natalia.zetticci@gmail.com	NU	Gairo
niccolò.blasi@virgilio.it	Niccolò	Blasi	1993-07-06 00:00:00	Crevacuore	BLSNCL93L06D165N	M	natalia.zetticci@gmail.com	NU	Orani
paulina.pizzo@yahoo.it	Paulina	Pizzo	2000-02-29 00:00:00	Codogno	PZZPLN00B69C816S	F	natalia.zetticci@gmail.com	NU	Lodine
livia.agostini@libero.it	Livia	Agostini	1958-07-04 00:00:00	Ospitaletto	GSTLVI58L44G170Y	F	natalia.zetticci@gmail.com	NU	Olzai
bruno.guariento@libero.it	Bruno	Guariento	1961-02-14 00:00:00	Brovello-Carpugnino	GRNBRN61B14B207T	M	natalia.zetticci@gmail.com	NU	Osidda
graziella.leone@virgilio.it	Graziella	Leone	1959-08-20 00:00:00	Frascarolo	LNEGZL59M60D771K	F	natalia.zetticci@gmail.com	NU	Tonara
tina.monicelli@yahoo.it	Tina	Monicelli	1964-04-13 00:00:00	Fraine	MNCTNI64D53D757H	F	natalia.zetticci@gmail.com	NU	Sorgono
leonardo.chiappetta@gmail.com	Leonardo	Chiappetta	1956-06-02 00:00:00	Verderio	CHPLRD56H02M337N	M	natalia.zetticci@gmail.com	NU	Orotelli
piergiuseppe.piccinni@libero.it	Piergiuseppe	Piccinni	1979-02-03 00:00:00	Taino	PCCPGS79B03L032H	M	natalia.zetticci@gmail.com	NU	Perdasdefogu
annunziata.badoglio@gmail.com	Annunziata	Badoglio	1996-01-09 00:00:00	Villaperuccio	BDGNNZ96A49M278Q	F	natalia.zetticci@gmail.com	NU	Bortigali
annunziata.goldstein@gmail.com	Annunziata	Goldstein	1990-09-23 00:00:00	Cava de' Tirreni	GLDNNZ90P63C361N	F	natalia.zetticci@gmail.com	NU	Ussassai
stefano.dulbecco@libero.it	Stefano	Dulbecco	1963-09-17 00:00:00	Domus de Maria	DLBSFN63P17D333R	M	natalia.zetticci@gmail.com	NU	Dorgali
federigo.guarneri@gmail.com	Federigo	Guarneri	2001-10-13 00:00:00	Dumenza	GRNFRG01R13D384M	M	natalia.zetticci@gmail.com	NU	Ovodda
sante.storladi@virgilio.it	Sante	Storladi	1975-10-04 00:00:00	Miglionico	STRSNT75R04F201P	M	natalia.zetticci@gmail.com	NU	Ollolai
massimiliano.fagotto@libero.it	Massimiliano	Fagotto	1988-11-04 00:00:00	Alfiano Natta	FGTMSM88S04A189Q	M	eraldo.abba@yahoo.it	NU	Ortueri
giosuè.vigorelli@libero.it	Giosuè	Vigorelli	1970-06-15 00:00:00	Loreto Aprutino	VGRGSI70H15E691W	M	eraldo.abba@yahoo.it	NU	Orosei
vittoria.gucci@hotmail.com	Vittoria	Gucci	1995-07-22 00:00:00	Villa San Secondo	GCCVTR95L62M019U	F	eraldo.abba@yahoo.it	NU	Oliena
fiorenzo.berlusconi@yahoo.it	Fiorenzo	Berlusconi	2006-11-04 00:00:00	Loreggia	BRLFNZ06S04E684F	M	eraldo.abba@yahoo.it	NU	Teti
stefani.castellitto@libero.it	Stefani	Castellitto	1970-02-07 00:00:00	Colere	CSTSFN70B47C835A	F	eraldo.abba@yahoo.it	NU	Loceri
nina.verdi@yahoo.it	Nina	Verdi	1997-07-16 00:00:00	Valdastico	VRDNNI97L56L554J	F	eraldo.abba@yahoo.it	NU	Torpè
ruggiero.simeoni@yahoo.it	Ruggiero	Simeoni	1959-03-02 00:00:00	Roccavione	SMNRGR59C02H453X	M	eraldo.abba@yahoo.it	NU	Atzara
michelangelo.garobbio@hotmail.com	Michelangelo	Garobbio	1961-09-09 00:00:00	Sant'Arsenio	GRBMHL61P09I307O	M	eraldo.abba@yahoo.it	NU	Noragugume
alberico.marcacci@virgilio.it	Alberico	Marcacci	1962-07-05 00:00:00	Casalciprano	MRCLRC62L05B871S	M	eraldo.abba@yahoo.it	NU	Noragugume
giovanni.flaiano@virgilio.it	Giovanni	Flaiano	1972-05-26 00:00:00	Arzignano	FLNGNN72E26A459H	M	eraldo.abba@yahoo.it	NU	Lula
melania.bruscantini@virgilio.it	Melania	Bruscantini	1958-09-13 00:00:00	Paulilatino	BRSMLN58P53G384U	F	eraldo.abba@yahoo.it	NU	Bolotana
adelmo.stein@hotmail.com	Adelmo	Stein	2007-03-16 00:00:00	Belgioioso	STNDLM07C16A741Q	M	eraldo.abba@yahoo.it	NU	Siniscola
cecilia.baracca@libero.it	Cecilia	Baracca	1950-03-03 00:00:00	Aidomaggiore	BRCCCL50C43A097S	F	eraldo.abba@yahoo.it	NU	Ovodda
massimo.troisi@hotmail.com	Massimo	Troisi	2004-01-03 00:00:00	Sturno	TRSMSM04A03I990B	M	eraldo.abba@yahoo.it	NU	Tortolì
nanni.saffi@virgilio.it	Nanni	Saffi	1985-06-16 00:00:00	Abbadia San Salvatore	SFFNNN85H16A006T	M	eraldo.abba@yahoo.it	NU	Teti
gloria.staglieno@hotmail.com	Gloria	Staglieno	2007-02-01 00:00:00	Monticello Conte Otto	STGGLR07B41F675V	F	carolina.malatesta@libero.it	TA	Palagiano
fulvio.blasi@gmail.com	Fulvio	Blasi	1970-08-26 00:00:00	Ponte di Legno	BLSFLV70M26G844N	M	carolina.malatesta@libero.it	TA	Palagiano
matilda.tutino@virgilio.it	Matilda	Tutino	1940-06-25 00:00:00	Levanto	TTNMLD40H65E560L	F	carolina.malatesta@libero.it	TA	San Giorgio Ionico
lucia.corbo@yahoo.it	Lucia	Corbo	1966-07-04 00:00:00	Raviscanina	CRBLCU66L44H202J	F	carolina.malatesta@libero.it	TA	San Marzano di San Giuseppe
martino.falcone@virgilio.it	Martino	Falcone	2008-08-04 00:00:00	Montemignaio	FLCMTN08M04F565L	M	carolina.malatesta@libero.it	TA	Crispiano
silvestro.dibiasi@yahoo.it	Silvestro	Dibiasi	1949-02-03 00:00:00	Villafranca Tirrena	DBSSVS49B03L950Z	M	carolina.malatesta@libero.it	TA	Manduria
roberto.guarneri@gmail.com	Roberto	Guarneri	1982-05-06 00:00:00	Romano di Lombardia	GRNRRT82E06H509A	M	carolina.malatesta@libero.it	TA	Taranto
salvi.renzi@libero.it	Salvi	Renzi	2014-03-28 00:00:00	Capestrano	RNZSLV14C28B651I	M	carolina.malatesta@libero.it	TA	Grottaglie
rosaria.dellucci@yahoo.it	Rosaria	Dellucci	1977-07-18 00:00:00	Cassano all'Ionio	DLLRSR77L58C002Y	F	carolina.malatesta@libero.it	TA	Roccaforzata
luciana.argenti@virgilio.it	Luciana	Argenti	1977-03-06 00:00:00	Macerata	RGNLCN77C46E783R	F	carolina.malatesta@libero.it	TA	Massafra
sandra.valier@virgilio.it	Sandra	Valier	1960-12-10 00:00:00	Paola	VLRSDR60T50G317H	F	carolina.malatesta@libero.it	TA	Manduria
corrado.donarelli@gmail.com	Corrado	Donarelli	1952-10-19 00:00:00	Roverchiara	DNRCRD52R19H606T	M	carolina.malatesta@libero.it	TA	Lizzano
beppe.campanella@virgilio.it	Beppe	Campanella	1954-04-19 00:00:00	San Giovanni di Fassa	CMPBPP54D19M390K	M	carolina.malatesta@libero.it	TA	Sava
silvio.morucci@yahoo.it	Silvio	Morucci	1963-10-01 00:00:00	Reana del Rojale	MRCSLV63R01H206G	M	carolina.malatesta@libero.it	TA	Massafra
giacobbe.filangieri@yahoo.it	Giacobbe	Filangieri	2010-02-13 00:00:00	Trecase	FLNGBB10B13M280H	M	carolina.malatesta@libero.it	TA	Roccaforzata
mariana.tebaldi@virgilio.it	Mariana	Tebaldi	1980-10-03 00:00:00	San Michele Mondovì	TBLMRN80R43I037P	F	luciano.sanguineti@hotmail.com	TA	Maruggio
ezio.contrafatto@yahoo.it	Ezio	Contrafatto	1978-08-24 00:00:00	Mottafollone	CNTZEI78M24F775O	M	luciano.sanguineti@hotmail.com	TA	Mottola
arnaldo.guidotti@gmail.com	Arnaldo	Guidotti	1987-02-20 00:00:00	Castagnaro	GDTRLD87B20C041O	M	luciano.sanguineti@hotmail.com	TA	Lizzano
pierpaolo.galeati@gmail.com	Pierpaolo	Galeati	2013-07-12 00:00:00	Vallanzengo	GLTPPL13L12L586Z	M	luciano.sanguineti@hotmail.com	TA	Mottola
ernesto.dallapé@hotmail.com	Ernesto	Dallapé	2016-05-16 00:00:00	Pietrafitta	DLLRST16E16G615G	M	luciano.sanguineti@hotmail.com	TA	Sava
leone.marrone@hotmail.com	Leone	Marrone	1958-07-17 00:00:00	Valderice	MRRLNE58L17G319A	M	luciano.sanguineti@hotmail.com	TA	Ginosa
piermaria.jacuzzi@libero.it	Piermaria	Jacuzzi	2003-04-04 00:00:00	Novi di Modena	JCZPMR03D04F966H	M	luciano.sanguineti@hotmail.com	TA	Faggiano
annamaria.mazzocchi@yahoo.it	Annamaria	Mazzocchi	1961-05-22 00:00:00	Portici	MZZNMR61E62G902A	F	luciano.sanguineti@hotmail.com	TA	Monteparano
orazio.paolucci@libero.it	Orazio	Paolucci	1962-02-20 00:00:00	Balmuccia	PLCRZO62B20A600F	M	luciano.sanguineti@hotmail.com	TA	Pulsano
bettina.morucci@hotmail.com	Bettina	Morucci	1971-07-23 00:00:00	Portici	MRCBTN71L63G902F	F	luciano.sanguineti@hotmail.com	TA	Mottola
lisa.carosone@yahoo.it	Lisa	Carosone	1955-01-06 00:00:00	Montevecchia	CRSLSI55A46F657P	F	luciano.sanguineti@hotmail.com	TA	Monteparano
adele.volterra@gmail.com	Adele	Volterra	1966-09-23 00:00:00	Padria	VLTDLA66P63G225B	F	luciano.sanguineti@hotmail.com	TA	Maruggio
lidia.leonetti@libero.it	Lidia	Leonetti	1965-04-02 00:00:00	Siamaggiore	LNTLDI65D42I717G	F	luciano.sanguineti@hotmail.com	TA	Statte
lidia.rastelli@libero.it	Lidia	Rastelli	1945-05-05 00:00:00	Bolgare	RSTLDI45E45A937R	F	luciano.sanguineti@hotmail.com	TA	Torricella
rosaria.gussoni@yahoo.it	Rosaria	Gussoni	1947-08-08 00:00:00	Marano sul Panaro	GSSRSR47M48E905E	F	luciano.sanguineti@hotmail.com	TA	Pulsano
melissa.cipolla@hotmail.com	Melissa	Cipolla	1991-06-22 00:00:00	Ronzone	CPLMSS91H62H552Q	F	luca.verga@yahoo.it	TV	Casale sul Sile
melania.necci@virgilio.it	Melania	Necci	1943-04-11 00:00:00	Santa Giustina	NCCMLN43D51I206E	F	luca.verga@yahoo.it	TV	Susegana
fabrizia.fusani@libero.it	Fabrizia	Fusani	2017-12-28 00:00:00	Casatisma	FSNFRZ17T68B945S	F	luca.verga@yahoo.it	TV	Santa Lucia di Piave
francesco.basadonna@hotmail.com	Francesco	Basadonna	2013-04-30 00:00:00	Tempio Pausania	BSDFNC13D30L093Q	M	luca.verga@yahoo.it	TV	Castelcucco
aurora.emo@gmail.com	Aurora	Emo	2007-10-17 00:00:00	Cossogno	MEORRA07R57D099A	F	luca.verga@yahoo.it	TV	Revine Lago
francesco.tropea@yahoo.it	Francesco	Tropea	1946-04-10 00:00:00	Pontecagnano Faiano	TRPFNC46D10G834S	M	luca.verga@yahoo.it	TV	Conegliano
ronaldo.spallanzani@gmail.com	Ronaldo	Spallanzani	2000-06-06 00:00:00	Pinasca	SPLRLD00H06G672R	M	luca.verga@yahoo.it	TV	Pederobba
antonia.bellucci@gmail.com	Antonia	Bellucci	1950-03-20 00:00:00	Casalbuttano ed Uniti	BLLNTN50C60B869X	F	luca.verga@yahoo.it	TV	Gorgo al Monticano
agostino.ceri@gmail.com	Agostino	Ceri	1999-02-28 00:00:00	Bonavigo	CREGTN99B28A964V	M	luca.verga@yahoo.it	TV	Moriago della Battaglia
eliana.parri@yahoo.it	Eliana	Parri	1997-02-27 00:00:00	San Felice Circeo	PRRLNE97B67H836C	F	luca.verga@yahoo.it	TV	Loria
giulietta.troisi@virgilio.it	Giulietta	Troisi	2010-08-22 00:00:00	Baceno	TRSGTT10M62A534G	F	luca.verga@yahoo.it	TV	Villorba
gioachino.argurio@hotmail.com	Gioachino	Argurio	1945-03-05 00:00:00	Ortezzano	RGRGHN45C05G137M	M	luca.verga@yahoo.it	TV	Ponzano Veneto
tiziano.ciampi@gmail.com	Tiziano	Ciampi	2001-04-27 00:00:00	San Giorgio Albanese	CMPTZN01D27H881H	M	luca.verga@yahoo.it	TV	Zero Branco
livia.sonnino@yahoo.it	Livia	Sonnino	1940-07-24 00:00:00	Centuripe	SNNLVI40L64C471Q	F	luca.verga@yahoo.it	TV	San Biagio di Callalta
susanna.viola@libero.it	Susanna	Viola	2002-11-08 00:00:00	Bessude	VLISNN02S48A827L	F	luca.verga@yahoo.it	TV	Cordignano
toni.trupiano@libero.it	Toni	Trupiano	1961-02-28 00:00:00	Moransengo	TRPTNO61B28F709L	M	aldo.morabito@gmail.com	TV	Borso del Grappa
cecilia.costanzi@yahoo.it	Cecilia	Costanzi	1998-10-06 00:00:00	Vitorchiano	CSTCCL98R46M086R	F	aldo.morabito@gmail.com	TV	Fonte
annunziata.disdero@libero.it	Annunziata	Disdero	1987-01-03 00:00:00	Sarentino	DSDNNZ87A43I431S	F	aldo.morabito@gmail.com	TV	Villorba
coriolano.lattuada@virgilio.it	Coriolano	Lattuada	1971-10-13 00:00:00	Morrovalle	LTTCLN71R13F749H	M	aldo.morabito@gmail.com	TV	Fregona
ramona.bonaventura@gmail.com	Ramona	Bonaventura	1969-12-19 00:00:00	Villaromagnano	BNVRMN69T59M009N	F	aldo.morabito@gmail.com	TV	Ponzano Veneto
osvaldo.falcone@virgilio.it	Osvaldo	Falcone	2015-03-03 00:00:00	San Severo	FLCSLD15C03I158Z	M	aldo.morabito@gmail.com	TV	Quinto di Treviso
enrico.santoro@gmail.com	Enrico	Santoro	1989-09-14 00:00:00	Collepardo	SNTNRC89P14C864J	M	aldo.morabito@gmail.com	TV	Colle Umberto
galasso.baglioni@gmail.com	Galasso	Baglioni	1979-01-07 00:00:00	Naro	BGLGSS79A07F845B	M	aldo.morabito@gmail.com	TV	Carbonera
aurora.faugno@yahoo.it	Aurora	Faugno	1950-01-04 00:00:00	Pentone	FGNRRA50A44G439A	F	aldo.morabito@gmail.com	TV	Caerano di San Marco
costantino.bresciani@yahoo.it	Costantino	Bresciani	1982-03-09 00:00:00	Campolieto	BRSCTN82C09B544C	M	aldo.morabito@gmail.com	TV	Mareno di Piave
licia.pignatti@gmail.com	Licia	Pignatti	2005-05-17 00:00:00	Parella	PGNLCI05E57G330D	F	aldo.morabito@gmail.com	TV	Trevignano
lisa.soprano@gmail.com	Lisa	Soprano	2010-01-26 00:00:00	Cutrofiano	SPRLSI10A66D237M	F	aldo.morabito@gmail.com	TV	San Fior
luisa.bertoli@libero.it	Luisa	Bertoli	1963-01-25 00:00:00	Chiuro	BRTLSU63A65C651E	F	aldo.morabito@gmail.com	TV	Quinto di Treviso
giacobbe.dovara@yahoo.it	Giacobbe	Dovara	2008-09-07 00:00:00	Tornareccio	DVRGBB08P07L224V	M	aldo.morabito@gmail.com	TV	Cison di Valmarino
sonia.cipolla@hotmail.com	Sonia	Cipolla	1969-11-14 00:00:00	Palmiano	CPLSNO69S54G289K	F	aldo.morabito@gmail.com	TV	Povegliano
fulvio.ritacca@yahoo.it	Fulvio	Ritacca	1997-09-10 00:00:00	Vidor	RTCFLV97P10L856P	M	ugolino.scaramucci@yahoo.it	MT	Cirigliano
adelasia.sommaruga@gmail.com	Adelasia	Sommaruga	1982-12-04 00:00:00	Sant'Arcangelo Trimonte	SMMDLS82T44F557Z	F	ugolino.scaramucci@yahoo.it	MT	Montescaglioso
mirco.gaito@gmail.com	Mirco	Gaito	1969-04-14 00:00:00	Pagazzano	GTAMRC69D14G233P	M	ugolino.scaramucci@yahoo.it	MT	Pomarico
fiamma.tarantino@hotmail.com	Fiamma	Tarantino	2006-07-16 00:00:00	Francavilla al Mare	TRNFMM06L56D763U	F	ugolino.scaramucci@yahoo.it	MT	Grassano
elisa.ioppi@libero.it	Elisa	Ioppi	1957-09-11 00:00:00	Celico	PPILSE57P51C430D	F	ugolino.scaramucci@yahoo.it	MT	Rotondella
chiara.travaglia@gmail.com	Chiara	Travaglia	1951-09-07 00:00:00	Adelfia	TRVCHR51P47A055E	F	ugolino.scaramucci@yahoo.it	MT	Montalbano Jonico
mattia.soranzo@yahoo.it	Mattia	Soranzo	1974-03-21 00:00:00	Roascio	SRNMTT74C21H363T	M	ugolino.scaramucci@yahoo.it	MT	Nova Siri
beppe.falcone@hotmail.com	Beppe	Falcone	1980-10-14 00:00:00	Bagnaria	FLCBPP80R14A550A	M	ugolino.scaramucci@yahoo.it	MT	Nova Siri
umberto.jovinelli@virgilio.it	Umberto	Jovinelli	2015-06-12 00:00:00	Santopadre	JVNMRT15H12I351T	M	ugolino.scaramucci@yahoo.it	MT	Matera
piergiuseppe.ortese@virgilio.it	Piergiuseppe	Ortese	2017-11-14 00:00:00	Calliano	RTSPGS17S14B418Q	M	ugolino.scaramucci@yahoo.it	MT	Montescaglioso
sonia.cerquiglini@gmail.com	Sonia	Cerquiglini	1945-12-19 00:00:00	Solero	CRQSNO45T59I798F	F	ugolino.scaramucci@yahoo.it	MT	Pomarico
serafina.napolitano@hotmail.com	Serafina	Napolitano	2016-07-10 00:00:00	Montichiari	NPLSFN16L50F471Q	F	ugolino.scaramucci@yahoo.it	MT	Pisticci
nicola.ferragamo@libero.it	Nicola	Ferragamo	1941-01-05 00:00:00	Mirandola	FRRNCL41A05F240C	M	ugolino.scaramucci@yahoo.it	MT	Aliano
orlando.tarantini@yahoo.it	Orlando	Tarantini	1977-09-30 00:00:00	San Bartolomeo al Mare	TRNRND77P30H763D	M	ugolino.scaramucci@yahoo.it	MT	San Giorgio Lucano
marissa.busoni@libero.it	Marissa	Busoni	2009-03-20 00:00:00	Colli sul Velino	BSNMSS09C60C880C	F	ugolino.scaramucci@yahoo.it	MT	Calciano
imelda.rapisardi@virgilio.it	Imelda	Rapisardi	1987-01-29 00:00:00	Ponte nelle Alpi	RPSMLD87A69B662F	F	ippazio.bettoni@libero.it	MT	Tursi
veronica.polesel@hotmail.com	Veronica	Polesel	1992-03-05 00:00:00	Limosano	PLSVNC92C45E599F	F	ippazio.bettoni@libero.it	MT	Irsina
vincenzo.roth@libero.it	Vincenzo	Roth	1957-09-24 00:00:00	Chiesa in Valmalenco	RTHVCN57P24C628Z	M	ippazio.bettoni@libero.it	MT	Montalbano Jonico
maurizio.treves@hotmail.com	Maurizio	Treves	2001-10-18 00:00:00	San Zeno Naviglio	TRVMRZ01R18I412J	M	ippazio.bettoni@libero.it	MT	Accettura
raffaele.salvemini@hotmail.com	Raffaele	Salvemini	1949-03-19 00:00:00	Pianfei	SLVRFL49C19G561O	M	ippazio.bettoni@libero.it	MT	Montalbano Jonico
durante.corradi@yahoo.it	Durante	Corradi	1989-11-09 00:00:00	Buggerru	CRRDNT89S09B250P	M	ippazio.bettoni@libero.it	MT	Scanzano Jonico
loretta.bersani@virgilio.it	Loretta	Bersani	1975-05-14 00:00:00	Capriva del Friuli	BRSLTT75E54B712M	F	ippazio.bettoni@libero.it	MT	Calciano
tonia.mazzi@yahoo.it	Tonia	Mazzi	1984-10-01 00:00:00	Maltignano	MZZTNO84R41E868U	F	ippazio.bettoni@libero.it	MT	Scanzano Jonico
pasqual.pezzali@virgilio.it	Pasqual	Pezzali	1997-06-30 00:00:00	Rondanina	PZZPQL97H30H546P	M	ippazio.bettoni@libero.it	MT	Pisticci
filippo.bernetti@yahoo.it	Filippo	Bernetti	1998-05-09 00:00:00	Vacri	BRNFPP98E09L526E	M	ippazio.bettoni@libero.it	MT	Bernalda
ugo.interminelli@virgilio.it	Ugo	Interminelli	1983-07-27 00:00:00	Sagliano Micca	NTRGUO83L27H662F	M	ippazio.bettoni@libero.it	MT	Bernalda
berenice.gioberti@virgilio.it	Berenice	Gioberti	2014-01-03 00:00:00	Corropoli	GBRBNC14A43D043A	F	ippazio.bettoni@libero.it	MT	Policoro
santino.randazzo@yahoo.it	Santino	Randazzo	1957-06-02 00:00:00	San Giorgio della Richinvelda	RNDSTN57H02H891U	M	ippazio.bettoni@libero.it	MT	Tursi
hugo.basadonna@yahoo.it	Hugo	Basadonna	1987-09-04 00:00:00	San Gregorio Matese	BSDHGU87P04H939B	M	ippazio.bettoni@libero.it	MT	Tricarico
mauro.dallara@libero.it	Mauro	Dallara	2008-02-02 00:00:00	Filadelfia	DLLMRA08B02D587T	M	ippazio.bettoni@libero.it	MT	San Giorgio Lucano
leone.verdi@virgilio.it	Leone	Verdi	1992-04-09 00:00:00	Ribordone	VRDLNE92D09H270K	M	marissa.barzini@yahoo.it	NU	Torpè
concetta.botticelli@gmail.com	Concetta	Botticelli	1988-11-20 00:00:00	Avetrana	BTTCCT88S60A514Y	F	marissa.barzini@yahoo.it	NU	Tonara
sonia.fabrizi@libero.it	Sonia	Fabrizi	2014-09-02 00:00:00	Nalles	FBRSNO14P42F836C	F	marissa.barzini@yahoo.it	NU	Orani
gianpietro.bajardi@virgilio.it	Gianpietro	Bajardi	1984-09-06 00:00:00	Massalengo	BJRGPT84P06F028J	M	marissa.barzini@yahoo.it	NU	Ollolai
angelina.sermonti@libero.it	Angelina	Sermonti	2003-02-21 00:00:00	Sant'Angelo a Fasanella	SRMNLN03B61I278W	F	marissa.barzini@yahoo.it	NU	Tortolì
aria.vergassola@virgilio.it	Aria	Vergassola	2008-09-20 00:00:00	Asciano	VRGRAI08P60A461Y	F	marissa.barzini@yahoo.it	NU	Ilbono
nadia.giusti@yahoo.it	Nadia	Giusti	1970-02-23 00:00:00	Pandino	GSTNDA70B63G306V	F	marissa.barzini@yahoo.it	NU	Osini
ubaldo.totino@gmail.com	Ubaldo	Totino	2001-01-14 00:00:00	Montanera	TTNBLD01A14F424V	M	marissa.barzini@yahoo.it	NU	Oliena
filippo.piccinni@yahoo.it	Filippo	Piccinni	1962-08-10 00:00:00	Bonate Sopra	PCCFPP62M10A963A	M	marissa.barzini@yahoo.it	NU	Tiana
cassandra.crispi@virgilio.it	Cassandra	Crispi	1948-12-07 00:00:00	Piegaro	CRSCSN48T47G601E	F	marissa.barzini@yahoo.it	NU	Silanus
ezio.soffici@virgilio.it	Ezio	Soffici	1973-03-14 00:00:00	Cittiglio	SFFZEI73C14C751B	M	marissa.barzini@yahoo.it	NU	Bortigali
costantino.andreozzi@hotmail.com	Costantino	Andreozzi	1979-06-21 00:00:00	Demonte	NDRCTN79H21D271Q	M	marissa.barzini@yahoo.it	NU	Tertenia
enzo.fittipaldi@libero.it	Enzo	Fittipaldi	1986-01-20 00:00:00	Rio di Pusteria	FTTNZE86A20H299B	M	marissa.barzini@yahoo.it	NU	Bitti
corrado.perozzo@yahoo.it	Corrado	Perozzo	1962-09-29 00:00:00	Ari	PRZCRD62P29A398E	M	marissa.barzini@yahoo.it	NU	Macomer
gemma.gagliano@gmail.com	Gemma	Gagliano	1974-11-25 00:00:00	Latera	GGLGMM74S65E467T	F	marissa.barzini@yahoo.it	NU	Galtellì
margherita.baracca@gmail.com	Margherita	Baracca	2015-10-02 00:00:00	Mondovì	BRCMGH15R42F351R	F	toni.gemito@gmail.com	NU	Talana
tonia.bossi@gmail.com	Tonia	Bossi	1956-08-29 00:00:00	Colleferro	BSSTNO56M69C858K	F	toni.gemito@gmail.com	NU	Sorgono
rosa.nicolini@virgilio.it	Rosa	Nicolini	1952-12-24 00:00:00	Camastra	NCLRSO52T64B460A	F	toni.gemito@gmail.com	NU	Onanì
ubaldo.bocelli@hotmail.com	Ubaldo	Bocelli	1979-09-18 00:00:00	Châtillon	BCLBLD79P18C294K	M	toni.gemito@gmail.com	NU	Gavoi
benvenuto.tozzi@hotmail.com	Benvenuto	Tozzi	1965-03-28 00:00:00	Gaiola	TZZBVN65C28D856S	M	toni.gemito@gmail.com	NU	Gavoi
vincenzo.angiolello@gmail.com	Vincenzo	Angiolello	1978-03-02 00:00:00	Ville d'Anaunia	NGLVCN78C02M363G	M	toni.gemito@gmail.com	NU	Girasole
ugolino.nosiglia@libero.it	Ugolino	Nosiglia	1986-09-06 00:00:00	Teulada	NSGGLN86P06L154O	M	toni.gemito@gmail.com	NU	Loceri
marta.casarin@libero.it	Marta	Casarin	1981-03-02 00:00:00	Senigallia	CSRMRT81C42I608Q	F	toni.gemito@gmail.com	NU	Elini
raffaella.tonisto@gmail.com	Raffaella	Tonisto	2002-12-01 00:00:00	Ficarra	TNSRFL02T41D569O	F	toni.gemito@gmail.com	NU	Gairo
ruggero.muratori@gmail.com	Ruggero	Muratori	1975-05-29 00:00:00	Boccioleto	MRTRGR75E29A914B	M	toni.gemito@gmail.com	NU	Lanusei
pasquale.tarantino@hotmail.com	Pasquale	Tarantino	1954-07-19 00:00:00	Martinsicuro	TRNPQL54L19E989Y	M	toni.gemito@gmail.com	NU	Dualchi
agnolo.mussolini@virgilio.it	Agnolo	Mussolini	1959-12-05 00:00:00	Montesano sulla Marcellana	MSSGNL59T05F625N	M	toni.gemito@gmail.com	NU	Dualchi
veronica.cilea@hotmail.com	Veronica	Cilea	1943-02-24 00:00:00	Montello	CLIVNC43B64F547O	F	toni.gemito@gmail.com	NU	Fonni
martina.fracci@virgilio.it	Martina	Fracci	1975-04-06 00:00:00	Sassello	FRCMTN75D46I453V	F	toni.gemito@gmail.com	NU	Onifai
pierluigi.capone@virgilio.it	Pierluigi	Capone	1959-10-07 00:00:00	Civita d'Antino	CPNPLG59R07C766W	M	toni.gemito@gmail.com	NU	Macomer
fabrizio.tiepolo@gmail.com	Fabrizio	Tiepolo	1956-06-24 00:00:00	Cusio	TPLFRZ56H24D233G	M	rosaria.chiaramonte@libero.it	TA	San Giorgio Ionico
antonino.visintini@hotmail.com	Antonino	Visintini	1978-12-15 00:00:00	Padula	VSNNNN78T15G226T	M	rosaria.chiaramonte@libero.it	TA	Manduria
luciano.falier@yahoo.it	Luciano	Falier	2009-09-04 00:00:00	Capizzone	FLRLCN09P04B661B	M	rosaria.chiaramonte@libero.it	TA	Monteparano
lara.lanfranchi@hotmail.com	Lara	Lanfranchi	1942-08-27 00:00:00	Legnaro	LNFLRA42M67E515C	F	rosaria.chiaramonte@libero.it	TA	Martina Franca
ugolino.cesarotti@hotmail.com	Ugolino	Cesarotti	2019-07-09 00:00:00	Sapri	CSRGLN19L09I422I	M	rosaria.chiaramonte@libero.it	TA	Pulsano
bianca.malatesta@virgilio.it	Bianca	Malatesta	1949-08-14 00:00:00	Bucchianico	MLTBNC49M54B238O	F	rosaria.chiaramonte@libero.it	TA	Grottaglie
licia.biagi@virgilio.it	Licia	Biagi	1999-10-23 00:00:00	Grotte di Castro	BGILCI99R63E210H	F	rosaria.chiaramonte@libero.it	TA	Maruggio
amleto.bombieri@libero.it	Amleto	Bombieri	1944-05-01 00:00:00	Briga Novarese	BMBMLT44E01B176O	M	rosaria.chiaramonte@libero.it	TA	Monteiasi
lucio.callegaro@yahoo.it	Lucio	Callegaro	2015-05-01 00:00:00	Palermiti	CLLLCU15E01G272P	M	rosaria.chiaramonte@libero.it	TA	Carosino
giuseppe.nugnes@hotmail.com	Giuseppe	Nugnes	2010-02-18 00:00:00	Casalserugo	NGNGPP10B18B912O	M	rosaria.chiaramonte@libero.it	TA	San Giorgio Ionico
dante.pometta@gmail.com	Dante	Pometta	1949-06-19 00:00:00	Povoletto	PMTDNT49H19G949Y	M	rosaria.chiaramonte@libero.it	TA	Maruggio
fortunata.trotta@virgilio.it	Fortunata	Trotta	1968-07-26 00:00:00	Aradeo	TRTFTN68L66A350I	F	rosaria.chiaramonte@libero.it	TA	Palagianello
raffaellino.busoni@yahoo.it	Raffaellino	Busoni	1972-10-01 00:00:00	Chieuti	BSNRFL72R01C633D	M	rosaria.chiaramonte@libero.it	TA	Carosino
milo.nosiglia@libero.it	Milo	Nosiglia	1986-06-16 00:00:00	Borgo a Mozzano	NSGMLI86H16B007Y	M	rosaria.chiaramonte@libero.it	TA	Taranto
lolita.gentili@hotmail.com	Lolita	Gentili	1983-04-28 00:00:00	Roccavione	GNTLLT83D68H453C	F	rosaria.chiaramonte@libero.it	TA	Maruggio
alphons.finzi@virgilio.it	Alphons	Finzi	1943-01-19 00:00:00	Posina	FNZLHN43A19G931Z	M	arnaldo.golino@yahoo.it	TA	Mottola
damiano.schiaparelli@hotmail.com	Damiano	Schiaparelli	1940-09-16 00:00:00	Silandro	SCHDMN40P16I729L	M	arnaldo.golino@yahoo.it	TA	Laterza
ivo.tartaglia@gmail.com	Ivo	Tartaglia	1973-07-04 00:00:00	Platania	TRTVIO73L04G734L	M	arnaldo.golino@yahoo.it	TA	Lizzano
gelsomina.greco@libero.it	Gelsomina	Greco	1958-01-18 00:00:00	Torino di Sangro	GRCGSM58A58L218T	F	arnaldo.golino@yahoo.it	TA	Statte
melina.sagredo@gmail.com	Melina	Sagredo	1941-06-28 00:00:00	Tavenna	SGRMLN41H68L069Q	F	arnaldo.golino@yahoo.it	TA	Monteparano
ronaldo.dandolo@hotmail.com	Ronaldo	Dandolo	1944-06-11 00:00:00	Mira	DNDRLD44H11F229L	M	arnaldo.golino@yahoo.it	TA	Montemesola
rita.tarantini@hotmail.com	Rita	Tarantini	1974-11-13 00:00:00	Altopiano della Vigolana	TRNRTI74S53M350E	F	arnaldo.golino@yahoo.it	TA	Palagianello
marta.marrone@gmail.com	Marta	Marrone	2010-02-04 00:00:00	Pietracamela	MRRMRT10B44G608F	F	arnaldo.golino@yahoo.it	TA	Palagiano
lucia.pisano@hotmail.com	Lucia	Pisano	2005-03-26 00:00:00	Beura-Cardezza	PSNLCU05C66A834K	F	arnaldo.golino@yahoo.it	TA	Roccaforzata
ivan.favata@gmail.com	Ivan	Favata	2007-05-30 00:00:00	Cortenova	FVTVNI07E30D065L	M	arnaldo.golino@yahoo.it	TA	Leporano
fredo.ruberto@libero.it	Fredo	Ruberto	1976-11-25 00:00:00	Colli sul Velino	RBRFRD76S25C880J	M	arnaldo.golino@yahoo.it	TA	Ginosa
coriolano.pastine@hotmail.com	Coriolano	Pastine	1961-11-02 00:00:00	Putignano	PSTCLN61S02H096P	M	arnaldo.golino@yahoo.it	TA	Lizzano
alessia.morandi@libero.it	Alessia	Morandi	1986-06-27 00:00:00	Palmoli	MRNLSS86H67G290A	F	arnaldo.golino@yahoo.it	TA	Manduria
coluccio.cammarata@hotmail.com	Coluccio	Cammarata	1941-04-26 00:00:00	Mileto	CMMCCC41D26F207B	M	arnaldo.golino@yahoo.it	TA	Martina Franca
roman.leopardi@libero.it	Roman	Leopardi	2009-06-29 00:00:00	Scido	LPRRMN09H29I536I	M	arnaldo.golino@yahoo.it	TA	San Marzano di San Giuseppe
barbara.celentano@virgilio.it	Barbara	Celentano	1960-10-21 00:00:00	Cianciana	CLNBBR60R61C668V	F	sabatino.zanzi@gmail.com	TV	Vidor
vittorio.poerio@libero.it	Vittorio	Poerio	1978-08-06 00:00:00	San Pietro Viminario	PROVTR78M06I120W	M	sabatino.zanzi@gmail.com	TV	Casale sul Sile
santino.tartaglia@gmail.com	Santino	Tartaglia	1968-04-01 00:00:00	Quaranti	TRTSTN68D01H102C	M	sabatino.zanzi@gmail.com	TV	Conegliano
fortunata.bignami@yahoo.it	Fortunata	Bignami	1950-08-18 00:00:00	Limbadi	BGNFTN50M58E590K	F	sabatino.zanzi@gmail.com	TV	Maser
stefani.gangemi@yahoo.it	Stefani	Gangemi	1943-06-22 00:00:00	Frugarolo	GNGSFN43H62D813B	F	sabatino.zanzi@gmail.com	TV	Mogliano Veneto
vito.cilea@virgilio.it	Vito	Cilea	1997-02-04 00:00:00	Stigliano	CLIVTI97B04I954C	M	sabatino.zanzi@gmail.com	TV	Gaiarine
teresa.tirabassi@virgilio.it	Teresa	Tirabassi	1976-06-26 00:00:00	Prunetto	TRBTRS76H66H085K	F	sabatino.zanzi@gmail.com	TV	San Vendemiano
martino.spinola@libero.it	Martino	Spinola	1956-11-11 00:00:00	Bagnasco	SPNMTN56S11A555T	M	sabatino.zanzi@gmail.com	TV	Godega di Sant'Urbano
guglielmo.togliatti@yahoo.it	Guglielmo	Togliatti	1943-09-07 00:00:00	Mozzanica	TGLGLL43P07F786S	M	sabatino.zanzi@gmail.com	TV	Monastier di Treviso
giulio.bragaglia@gmail.com	Giulio	Bragaglia	1969-05-03 00:00:00	Abbadia Lariana	BRGGLI69E03A005A	M	sabatino.zanzi@gmail.com	TV	Villorba
vito.campano@hotmail.com	Vito	Campano	1941-06-06 00:00:00	Saliceto	CMPVTI41H06H710B	M	sabatino.zanzi@gmail.com	TV	Silea
michela.sabatini@libero.it	Michela	Sabatini	1994-08-21 00:00:00	Sandrigo	SBTMHL94M61H829J	F	sabatino.zanzi@gmail.com	TV	Trevignano
fabio.aloisio@libero.it	Fabio	Aloisio	1982-05-23 00:00:00	Polesella	LSAFBA82E23G782Z	M	sabatino.zanzi@gmail.com	TV	San Fior
fulvio.pedroni@virgilio.it	Fulvio	Pedroni	1999-01-09 00:00:00	Rovolon	PDRFLV99A09H622V	M	sabatino.zanzi@gmail.com	TV	Fregona
guglielmo.curci@libero.it	Guglielmo	Curci	1989-06-01 00:00:00	Faggeto Lario	CRCGLL89H01D462M	M	sabatino.zanzi@gmail.com	TV	San Biagio di Callalta
stefani.dandolo@libero.it	Stefani	Dandolo	1976-01-25 00:00:00	Erbusco	DNDSFN76A65D421Y	F	giovanna.rosiello@virgilio.it	TV	San Pietro di Feletto
etta.gemito@libero.it	Etta	Gemito	1984-07-22 00:00:00	Sutri	GMTTTE84L62L017Q	F	giovanna.rosiello@virgilio.it	TV	Giavera del Montello
uberto.turchi@gmail.com	Uberto	Turchi	1952-12-13 00:00:00	Serra San Quirico	TRCBRT52T13I653G	M	giovanna.rosiello@virgilio.it	TV	Trevignano
lorenzo.vigliotti@yahoo.it	Lorenzo	Vigliotti	1945-03-26 00:00:00	Bisenti	VGLLNZ45C26A885W	M	giovanna.rosiello@virgilio.it	TV	Godega di Sant'Urbano
patrizia.ramazzotti@gmail.com	Patrizia	Ramazzotti	1942-08-30 00:00:00	Stra	RMZPRZ42M70I965U	F	giovanna.rosiello@virgilio.it	TV	Godega di Sant'Urbano
simonetta.zaccagnini@gmail.com	Simonetta	Zaccagnini	1994-12-28 00:00:00	Bellante	ZCCSNT94T68A746F	F	giovanna.rosiello@virgilio.it	TV	Codognè
marcella.ruggieri@hotmail.com	Marcella	Ruggieri	2008-12-24 00:00:00	Villanova d'Asti	RGGMCL08T64L984O	F	giovanna.rosiello@virgilio.it	TV	Fontanelle
diana.scarfoglio@hotmail.com	Diana	Scarfoglio	1979-04-30 00:00:00	Fiorano al Serio	SCRDNI79D70D606X	F	giovanna.rosiello@virgilio.it	TV	Sarmede
goffredo.pagliaro@gmail.com	Goffredo	Pagliaro	1956-03-25 00:00:00	Alfonsine	PGLGFR56C25A191T	M	giovanna.rosiello@virgilio.it	TV	Vidor
giuseppe.garzoni@gmail.com	Giuseppe	Garzoni	1996-02-10 00:00:00	Pieve a Nievole	GRZGPP96B10G636R	M	giovanna.rosiello@virgilio.it	TV	San Zenone degli Ezzelini
veronica.pietrangeli@virgilio.it	Veronica	Pietrangeli	2015-02-24 00:00:00	Monticello d'Alba	PTRVNC15B64F669K	F	giovanna.rosiello@virgilio.it	TV	Godega di Sant'Urbano
marco.papetti@yahoo.it	Marco	Papetti	2010-05-28 00:00:00	San Casciano dei Bagni	PPTMRC10E28H790O	M	giovanna.rosiello@virgilio.it	TV	Trevignano
durante.fermi@yahoo.it	Durante	Fermi	1955-08-18 00:00:00	Castagnole Monferrato	FRMDNT55M18C047O	M	giovanna.rosiello@virgilio.it	TV	Asolo
antonella.roero@virgilio.it	Antonella	Roero	1995-11-20 00:00:00	Ramacca	RRONNL95S60H168B	F	giovanna.rosiello@virgilio.it	TV	Vidor
fabia.garozzo@hotmail.com	Fabia	Garozzo	1971-10-10 00:00:00	Azzano San Paolo	GRZFBA71R50A528W	F	giovanna.rosiello@virgilio.it	TV	Treviso
raimondo.onisto@gmail.com	Raimondo	Onisto	1998-04-25 00:00:00	Canale Monterano	NSTRND98D25B576X	M	raffaello.nicoletti@gmail.com	MT	Stigliano
gelsomina.comeriato@yahoo.it	Gelsomina	Comeriato	1991-02-15 00:00:00	Lamezia Terme	CMRGSM91B55M208B	F	raffaello.nicoletti@gmail.com	MT	Grottole
berenice.capecchi@virgilio.it	Berenice	Capecchi	1960-12-03 00:00:00	Esanatoglia	CPCBNC60T43D429T	F	raffaello.nicoletti@gmail.com	MT	Nova Siri
ruggiero.juvara@hotmail.com	Ruggiero	Juvara	1949-10-06 00:00:00	Villaricca	JVRRGR49R06G309S	M	raffaello.nicoletti@gmail.com	MT	Tursi
ernesto.tomasetti@hotmail.com	Ernesto	Tomasetti	1953-02-26 00:00:00	Bagheria	TMSRST53B26A546V	M	raffaello.nicoletti@gmail.com	MT	Montalbano Jonico
loretta.balbo@gmail.com	Loretta	Balbo	1990-07-30 00:00:00	Oschiri	BLBLTT90L70G153C	F	raffaello.nicoletti@gmail.com	MT	Grottole
napoleone.tiepolo@virgilio.it	Napoleone	Tiepolo	1954-08-25 00:00:00	Turrivalignani	TPLNLN54M25L475X	M	raffaello.nicoletti@gmail.com	MT	Stigliano
lidia.tutino@libero.it	Lidia	Tutino	1961-04-05 00:00:00	Oschiri	TTNLDI61D45G153H	F	raffaello.nicoletti@gmail.com	MT	Miglionico
piergiuseppe.corradi@libero.it	Piergiuseppe	Corradi	2014-05-03 00:00:00	Ferrazzano	CRRPGS14E03D550Q	M	raffaello.nicoletti@gmail.com	MT	Ferrandina
lara.cassarà@yahoo.it	Lara	Cassarà	2019-11-21 00:00:00	Laces	CSSLRA19S61E398Q	F	raffaello.nicoletti@gmail.com	MT	Irsina
tina.giannone@yahoo.it	Tina	Giannone	1991-10-21 00:00:00	Arba	GNNTNI91R61A354W	F	raffaello.nicoletti@gmail.com	MT	Stigliano
greca.boitani@hotmail.com	Greca	Boitani	2004-11-02 00:00:00	Villa di Serio	BTNGRC04S42L936B	F	raffaello.nicoletti@gmail.com	MT	Miglionico
michele.prodi@yahoo.it	Michele	Prodi	1978-01-05 00:00:00	Baragiano	PRDMHL78A05A615F	M	raffaello.nicoletti@gmail.com	MT	Cirigliano
antonella.petrocelli@yahoo.it	Antonella	Petrocelli	1988-08-16 00:00:00	San Demetrio ne' Vestini	PTRNNL88M56H819F	F	raffaello.nicoletti@gmail.com	MT	San Giorgio Lucano
franco.salvemini@yahoo.it	Franco	Salvemini	1949-02-27 00:00:00	Quinto Vicentino	SLVFNC49B27H134M	M	raffaello.nicoletti@gmail.com	MT	Matera
romina.bellini@virgilio.it	Romina	Bellini	1958-04-08 00:00:00	Sinalunga	BLLRMN58D48A468S	F	luca.tutino@gmail.com	MT	Matera
ennio.benedetti@yahoo.it	Ennio	Benedetti	1980-01-03 00:00:00	Montemarciano	BNDNNE80A03F560F	M	luca.tutino@gmail.com	MT	Tursi
serena.briccialdi@virgilio.it	Serena	Briccialdi	1957-05-10 00:00:00	Civitella Messer Raimondo	BRCSRN57E50C776H	F	luca.tutino@gmail.com	MT	Scanzano Jonico
flavio.galilei@hotmail.com	Flavio	Galilei	1965-09-29 00:00:00	Magherno	GLLFLV65P29E804I	M	luca.tutino@gmail.com	MT	Matera
lilla.parini@virgilio.it	Lilla	Parini	2008-09-15 00:00:00	Uboldo	PRNLLL08P55L480V	F	luca.tutino@gmail.com	MT	Irsina
giorgia.calbo@gmail.com	Giorgia	Calbo	1966-05-29 00:00:00	Pozzilli	CLBGRG66E69G954E	F	luca.tutino@gmail.com	MT	Colobraro
alfio.camuccini@yahoo.it	Alfio	Camuccini	1991-08-22 00:00:00	Grotte di Castro	CMCLFA91M22E210A	M	luca.tutino@gmail.com	MT	Scanzano Jonico
barbara.murialdo@gmail.com	Barbara	Murialdo	1953-12-01 00:00:00	Chiaravalle	MRLBBR53T41C615S	F	luca.tutino@gmail.com	MT	Accettura
alessandra.bettoni@libero.it	Alessandra	Bettoni	1972-12-02 00:00:00	Sovere	BTTLSN72T42I873W	F	luca.tutino@gmail.com	MT	Pomarico
ludovico.pratesi@virgilio.it	Ludovico	Pratesi	1969-03-06 00:00:00	Lungavilla	PRTLVC69C06B387E	M	luca.tutino@gmail.com	MT	Rotondella
laureano.comboni@hotmail.com	Laureano	Comboni	1991-12-03 00:00:00	Quarna Sotto	CMBLRN91T03H107M	M	luca.tutino@gmail.com	MT	Grassano
flavia.bellocchio@virgilio.it	Flavia	Bellocchio	2011-03-06 00:00:00	Mezzana Mortigliengo	BLLFLV11C46F167U	F	luca.tutino@gmail.com	MT	Scanzano Jonico
alfredo.desio@yahoo.it	Alfredo	Desio	1940-11-26 00:00:00	Taormina	DSELRD40S26L042L	M	luca.tutino@gmail.com	MT	Garaguso
massimiliano.maggioli@virgilio.it	Massimiliano	Maggioli	1982-11-15 00:00:00	Villa del Conte	MGGMSM82S15L934K	M	luca.tutino@gmail.com	MT	Bernalda
ida.moresi@yahoo.it	Ida	Moresi	1940-04-02 00:00:00	San Giovanni Bianco	MRSDIA40D42H910U	F	luca.tutino@gmail.com	MT	Calciano
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.photo (photo_id, patient_id, upload_date) FROM stdin;
\.


--
-- Data for Name: province; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.province (province_id, province_name, province_abbreviation, province_region) FROM stdin;
1	Agrigento	AG	Sicilia
2	Alessandria	AL	Piemonte
3	Ancona	AN	Marche
4	Arezzo	AR	Toscana
5	Ascoli Piceno	AP	Marche
6	Asti	AT	Piemonte
7	Avellino	AV	Campania
8	Bari	BA	Puglia
9	Barletta-Andria-Trani	BT	Puglia
10	Belluno	BL	Veneto
11	Benevento	BN	Campania
12	Bergamo	BG	Lombardia
13	Biella	BI	Piemonte
14	Bologna	BO	Emilia-Romagna
15	Bolzano	BZ	Trentino-Alto Adige
16	Brescia	BS	Lombardia
17	Brindisi	BR	Puglia
18	Cagliari	CA	Sardegna
19	Caltanissetta	CL	Sicilia
20	Campobasso	CB	Molise
22	Caserta	CE	Campania
23	Catania	CT	Sicilia
24	Catanzaro	CZ	Calabria
25	Chieti	CH	Abruzzo
26	Como	CO	Lombardia
27	Cosenza	CS	Calabria
28	Cremona	CR	Lombardia
29	Crotone	KR	Calabria
30	Cuneo	CN	Piemonte
31	Enna	EN	Sicilia
32	Fermo	FM	Marche
33	Ferrara	FE	Emilia-Romagna
34	Firenze	FI	Toscana
35	Foggia	FG	Puglia
36	Forlì-Cesena	FC	Emilia-Romagna
37	Frosinone	FR	Lazio
38	Genova	GE	Liguria
39	Gorizia	GO	Friuli-Venezia Giulia
40	Grosseto	GR	Toscana
41	Imperia	IM	Liguria
42	Isernia	IS	Molise
44	La Spezia	SP	Liguria
45	Latina	LT	Lazio
46	Lecce	LE	Puglia
47	Lecco	LC	Lombardia
48	Livorno	LI	Toscana
49	Lodi	LO	Lombardia
50	Lucca	LU	Toscana
51	Macerata	MC	Marche
52	Mantova	MN	Lombardia
53	Massa e Carrara	MS	Toscana
54	Matera	MT	Basilicata
56	Messina	ME	Sicilia
57	Milano	MI	Lombardia
58	Modena	MO	Emilia-Romagna
59	Monza e Brianza	MB	Lombardia
60	Napoli	NA	Campania
61	Novara	NO	Piemonte
62	Nuoro	NU	Sardegna
65	Oristano	OR	Sardegna
66	Padova	PD	Veneto
67	Palermo	PA	Sicilia
68	Parma	PR	Emilia-Romagna
69	Pavia	PV	Lombardia
70	Perugia	PG	Umbria
71	Pesaro e Urbino	PU	Marche
72	Pescara	PE	Abruzzo
73	Piacenza	PC	Emilia-Romagna
74	Pisa	PI	Toscana
75	Pistoia	PT	Toscana
76	Pordenone	PN	Friuli-Venezia Giulia
77	Potenza	PZ	Basilicata
78	Prato	PO	Toscana
79	Ragusa	RG	Sicilia
80	Ravenna	RA	Emilia-Romagna
82	Reggio Emilia	RE	Emilia-Romagna
83	Rieti	RI	Lazio
84	Rimini	RN	Emilia-Romagna
85	Roma	RM	Lazio
86	Rovigo	RO	Veneto
87	Salerno	SA	Campania
88	Sassari	SS	Sardegna
89	Savona	SV	Liguria
90	Siena	SI	Toscana
91	Siracusa	SR	Sicilia
92	Sondrio	SO	Lombardia
93	Taranto	TA	Puglia
94	Teramo	TE	Abruzzo
95	Terni	TR	Umbria
96	Torino	TO	Piemonte
97	Trapani	TP	Sicilia
98	Trento	TN	Trentino-Alto Adige
99	Treviso	TV	Veneto
100	Trieste	TS	Friuli-Venezia Giulia
101	Udine	UD	Friuli-Venezia Giulia
102	Aosta	AO	Valle dAosta
103	Varese	VA	Lombardia
104	Venezia	VE	Veneto
105	Verbano-Cusio-Ossola	VB	Piemonte
106	Vercelli	VC	Piemonte
107	Verona	VR	Veneto
108	Vibo Valentia	VV	Calabria
109	Vicenza	VI	Veneto
110	Viterbo	VT	Lazio
111	Sud Sardegna	SU	Sardegna
43	L'Aquila	AQ	Abruzzo
81	Reggio Calabria	RC	Calabria
\.


--
-- Data for Name: recall; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.recall (recall_id, exam_type, min_age, max_age, start_date, health_service_id) FROM stdin;
11	5	10	50	2019-11-08 15:51:38.939	ssp.frosinone@gmail.com
12	6	10	50	2019-11-08 16:20:56.357	ssp.frosinone@gmail.com
13	45	90	100	2019-11-08 16:21:31.691	ssp.frosinone@gmail.com
14	3	10	50	2019-11-09 10:01:57.945	ssp.frosinone@gmail.com
15	16	10	100	2019-11-09 10:03:33.397	ssp.frosinone@gmail.com
16	78	1	2	2019-11-09 10:05:31.469	ssp.frosinone@gmail.com
19	6	10	50	2019-11-09 10:27:18.817	ssp.frosinone@gmail.com
24	6	10	50	2019-11-09 17:19:47.195	ssp.frosinone@gmail.com
25	6	10	50	2019-11-09 17:24:15.883	ssp.frosinone@gmail.com
26	91	10	50	2019-11-09 17:25:46.157	ssp.frosinone@gmail.com
27	48	10	20	2019-11-09 17:26:57.292	ssp.frosinone@gmail.com
30	2859	10	100	2019-11-10 15:47:19.611	ssp.frosinone@gmail.com
31	2831	10	100	2019-12-26 17:56:28.36	ssp.nuoro@gmail.com
\.


--
-- Data for Name: specialized_doctor; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.specialized_doctor (doctor_id, first_name, last_name, working_place) FROM stdin;
matteo.pugliese@hotmail.com	Matteo	Pugliese	San Gregorio di Catania
irma.cimini@hotmail.com	Irma	Cimini	Gallo Matese
nicolò.tedesco@gmail.com	Nicolò	Tedesco	Sorano
sabatino.bettin@hotmail.com	Sabatino	Bettin	Castello di Godego
cipriano.vercelloni@virgilio.it	Cipriano	Vercelloni	Burolo
fernanda.blasi@libero.it	Fernanda	Blasi	Formigine
eva.carullo@gmail.com	Eva	Carullo	Taranta Peligna
luchino.mannoia@gmail.com	Luchino	Mannoia	Tavoleto
melania.martucci@virgilio.it	Melania	Martucci	Lona-Lases
pierina.asprucci@virgilio.it	Pierina	Asprucci	Albettone
gianpietro.venturi@yahoo.it	Gianpietro	Venturi	Orvinio
liberto.cannizzaro@hotmail.com	Liberto	Cannizzaro	Camposano
giulietta.moretti@libero.it	Giulietta	Moretti	Monteparano
dante.mantegazza@yahoo.it	Dante	Mantegazza	Ranzo
dario.battisti@hotmail.com	Dario	Battisti	Borgo Chiese
bianca.traversa@virgilio.it	Bianca	Traversa	Dimaro Folgarida
micheletto.saragat@hotmail.com	Micheletto	Saragat	Isernia
pierpaolo.cerquiglini@virgilio.it	Pierpaolo	Cerquiglini	Renate
elmo.barbarigo@yahoo.it	Elmo	Barbarigo	Cassola
eliana.peano@libero.it	Eliana	Peano	Campomarino
milo.casagrande@yahoo.it	Milo	Casagrande	Roascio
paloma.barozzi@hotmail.com	Paloma	Barozzi	Fornovo San Giovanni
dino.garibaldi@yahoo.it	Dino	Garibaldi	Cesate
giacinto.scarfoglio@yahoo.it	Giacinto	Scarfoglio	Condrò
patrizia.accardo@yahoo.it	Patrizia	Accardo	Arcidosso
lamberto.ferrata@libero.it	Lamberto	Ferrata	Cavatore
laura.lettiere@yahoo.it	Laura	Lettiere	Torrazzo
sante.malaparte@libero.it	Sante	Malaparte	Torre de' Roveri
vincenza.salandra@yahoo.it	Vincenza	Salandra	Pietralunga
silvia.camanni@virgilio.it	Silvia	Camanni	Arosio
calcedonio.scarponi@libero.it	Calcedonio	Scarponi	Zaccanopoli
cristina.tedesco@yahoo.it	Cristina	Tedesco	Castelnuovo Calcea
marina.bettoni@libero.it	Marina	Bettoni	Ostiano
diana.guicciardini@libero.it	Diana	Guicciardini	Rezzo
vincenza.turati@hotmail.com	Vincenza	Turati	Bognanco
tiziano.pederiva@hotmail.com	Tiziano	Pederiva	Montagano
gianluca.carriera@hotmail.com	Gianluca	Carriera	Alserio
vito.petrocelli@hotmail.com	Vito	Petrocelli	Vivaro Romano
michelangelo.antonetti@gmail.com	Michelangelo	Antonetti	Albaretto della Torre
silvio.cutuli@yahoo.it	Silvio	Cutuli	Pieve di Cento
michelotto.alfieri@hotmail.com	Michelotto	Alfieri	Statte
eliana.accardo@virgilio.it	Eliana	Accardo	Montafia
patrizia.cutrufo@virgilio.it	Patrizia	Cutrufo	Priola
gioacchino.milanesi@libero.it	Gioacchino	Milanesi	Segrate
alessio.giulietti@virgilio.it	Alessio	Giulietti	Castel di Tora
nicoletta.gabbana@gmail.com	Nicoletta	Gabbana	Vairano Patenora
ninetta.spanevello@yahoo.it	Ninetta	Spanevello	Marano Equo
massimo.sermonti@libero.it	Massimo	Sermonti	Cautano
angelina.trupiano@gmail.com	Angelina	Trupiano	Costa Serina
donatello.varano@yahoo.it	Donatello	Varano	Muzzana del Turgnano
elena.agazzi@libero.it	Elena	Agazzi	Palmiano
francesco.fischetti@hotmail.com	Francesco	Fischetti	Atessa
zaira.zeffirelli@virgilio.it	Zaira	Zeffirelli	Marmentino
ricciotti.nicolucci@hotmail.com	Ricciotti	Nicolucci	Mesero
lara.grimani@virgilio.it	Lara	Grimani	Buonabitacolo
piergiorgio.pininfarina@hotmail.com	Piergiorgio	Pininfarina	Pandino
hugo.morpurgo@hotmail.com	Hugo	Morpurgo	Aiello del Friuli
lisa.parmitano@libero.it	Lisa	Parmitano	Grigno
flavia.sobrero@virgilio.it	Flavia	Sobrero	Valleve
arsenio.cortese@libero.it	Arsenio	Cortese	Gaggiano
roman.marrone@libero.it	Roman	Marrone	Brogliano
costanzo.bosurgi@virgilio.it	Costanzo	Bosurgi	Collegno
paoletta.crespi@yahoo.it	Paoletta	Crespi	Roccamandolfi
zaira.bellocchio@yahoo.it	Zaira	Bellocchio	Dervio
manuel.lucciano@virgilio.it	Manuel	Lucciano	Villa d'Almè
milena.grifeo@libero.it	Milena	Grifeo	Cisano sul Neva
lilla.ceci@virgilio.it	Lilla	Ceci	Montegrotto Terme
roberto.lussu@yahoo.it	Roberto	Lussu	Creazzo
bettina.scarlatti@yahoo.it	Bettina	Scarlatti	Carro
gianfranco.angiolello@yahoo.it	Gianfranco	Angiolello	Bressanone
antonia.ramazzotti@hotmail.com	Antonia	Ramazzotti	Brivio
luigi.borgia@virgilio.it	Luigi	Borgia	Vione
paoletta.pirandello@yahoo.it	Paoletta	Pirandello	Girifalco
ivan.fantozzi@virgilio.it	Ivan	Fantozzi	Rocca San Giovanni
jolanda.marenzio@virgilio.it	Jolanda	Marenzio	Zelbio
arsenio.fagiani@virgilio.it	Arsenio	Fagiani	Cesenatico
elena.cortese@virgilio.it	Elena	Cortese	Deruta
salvatore.togliatti@virgilio.it	Salvatore	Togliatti	San Nazzaro Val Cavargna
dante.chiesa@libero.it	Dante	Chiesa	Sommo
dino.dallara@hotmail.com	Dino	Dallara	Tissi
\.


--
-- Data for Name: user_; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.user_ (user_id, hash, salt) FROM stdin;
aurora.scandone@yahoo.it	0ADF2C6AC6045A50F9951DE5C6B7BEBA00BA53E611F48A59D36F8C4EA4931BCD93141EB972C3AA5F6C111C22D0E62E3AFE4D57B5E3B52024EBD787827F90F04C	BC779485964AF652
gianna.cociarelli@hotmail.com	9B9546A1E0F329FAA55F37252618B58EB74F893B2E1CB0774C803BE98168DA2B5CDF66C183959ED734CD2CC7C872E2A3A40A0EAD4970410F4908D322DFB2688D	FA7FD37D7DFDBCD5
paloma.zamengo@libero.it	367CA812AEB1F88C03F9A07E26D00374A4AA25ADC256D166FBCCC7F9BDF63F5650337459369AD269C2132324A2ED31CC0AB89B1C6C70EE445BB5E320594A7486	E287780BDC74C346
giorgio.barcaccia@yahoo.it	754DA17E861414860D68E3190CC7A9004A127FE6DEBD9252D8F15E383B022E16342B29D9B16E6675CAEA14CD4F1EFC48C810672750647AAE8FC1080A036DF9E3	06FEE38E477A8720
atenulf.lanfranchi@hotmail.com	B4A42714A43FAA73E9D291DA9545E15F21068ACC924B46ABF9ECCD13EE1F6EC61F66C886E2A5E78406CB692D5D6A3D7B31DB4C253A8A4E8D488F4C1AE8152B8E	0BB568C4EE6FEB0C
temistocle.parini@yahoo.it	6D6FC60B7B3E45007760F088AAD388026ADF72BECD34FA5CA73C78392C72AD85443DEFC2E669A76B6725903B5DA55D2EF444042E341784A4ADBE3439307B41F5	7CAAFF6F762417A8
rosina.tedesco@gmail.com	419A38AA29D335D40AA21EE8FC17091B8F00145EEC54DE0503ECAFE3545ABD001C3ACEE6C496B5E89961A215D5259F6BAD549FA61FA367EF5B7E4CA21B8D38EC	6D2FBBCD27F8415E
pompeo.pizzetti@virgilio.it	AA76124121FCEBBEF063EAF910269F9B49A964C8CFD85109F033910D76A0E4F7B9B1B9F9D2C54AC6C141A390C90EAD11B6382CFF2A14429C4B8C0CDDE0C5290C	CB5283B5F6772861
elmo.murialdo@gmail.com	09F2443E287EFABAF62E4ED5436284031259E328F898AA4513AEFF5228E602F9C4DED09B31E6420CA58DB59401642F975D4EAE789104C0095C8E29B925DE208C	30633D40CA6C7ED4
antonello.detti@gmail.com	5404209944D6B424A2D96F55D86312C4DC94E6B9696746FDDFC46FB9E48A492B70D275A92814601CC29D3C3990930CAE0390BD5FA2321F7420F28D0C291AA778	C72E6F296EFAE9F2
letizia.dibiasi@libero.it	D87EEC3EB532A6925C3D39E3E45A345741A755886B5409875E63637C8655627EDE040332BBBB28BEDC0C2755984989FD4A533D1DFC7184910ADDF5EF9954880D	57E86BF7BEDAE8F4
rosina.abba@yahoo.it	9BD02B7432454D8C42EED239BD8883BCA8E8E51D1244FF8745EDB7D283171D51B7749D10001BBEDB1E462A474C39F19D69C6ADF0D666A5DB12675950CF083BD6	FB8E8B6BBDC145BD
gioacchino.antonetti@hotmail.com	60551E5F3FD1F701C9B0EC78EBEFADBFBD10D36AAC6FB1EDDF962C93408A3B20FEF1051B902E8615A904EF5544960D28E31023A377F7EA35B92F14E82A006951	3BF4E5DF4CA1FEA9
michelangelo.gaiatto@virgilio.it	E2AAFA0D255EB271834BF801A02ADC7C6A6FADA7942E05DE53C3E6ED180511D6311D6A011FAED342982E2733B1007F201DF9C47844742C3DF6ED25628B122257	EBE3272DB9A2C4FD
fortunata.gozzano@libero.it	CF8A9ECBC9C5D1048EBD4E5C402CAB5D6E98D3F1B979EDA0F83389331D598E61364566290F0A234884DDA10D0F72F48C7071F0FE11C73F233526C9F5AA2D6DF9	60384038FA2B2E8D
fortunata.novaro@virgilio.it	1AF1BF767056A0D95364A3015ABB80D76B743CCEA4C2157246BDEF190A4F7C015A64EBC7C8BEDAB382898887299A5A9622AB25C37E4301CAB84F8F734DD391E1	F1E75AD8CFB6F5E0
etta.andreozzi@gmail.com	EFA91833E0373F4B1644C288BBE231F76ECE11F160716566A7F2181208AFA487B9C495BAEF75DB3575436F62540BFB43A468D6B97DBF26759CFECD2E160FC4D2	74D82ED10FD592AA
concetta.maccanelli@hotmail.com	FF0DCC9A29D60BD04D20568FCD23D5EBBA95EEE4AC7E21C6B295210D64E58283497AC975CFDBE5B6B2E7A36781335D65D54443897D0C7545D2B68DEDD28CF1DE	9615E90D53AAA6BF
giada.niggli@libero.it	86E04441F6EA61843F6B013AA8C8F9C95EFABDD750952D75060B822E617F536ED62151B3A2BBC467DCE1081B0EB89653FB08E85AD83507CFED536173D0D1211D	D641882994152983
zaira.zaguri@virgilio.it	15659646843955A8AE19936F5C7A46127B560B583B77824F41F11DACE9DC8DF280B0976F4C2390AF3E2201B669EFBD7ADCF410EFEC65CB03B6CB9F441EA35F8F	0936C324C881C59C
paolo.valmarana@virgilio.it	BE708EF67A899C73DD9F6BB2487D58FDE2D0B17E4F5FD0767BD8BDE1AF56BDB0BFF0A04A5566B57D79D572B299C090F123A188A24E15E7E1FB0BBBB66F1398FB	57E18ECEC6FF9516
matteo.prada@virgilio.it	0CC5FDD5747E4DD3A521328232C122CAD94DEBAAD265573FEED553D102EC9817BA6D9ED05361D01C9FFB7289D8289C40A7CE5F820B93A07AB2431AAC317E9030	007FA27C5A653F87
rosa.pincherle@libero.it	B5425FDC84BCFAA97592CF519DBE382C5E08F3F17F7BD07C466E576E0C8A9312FBA4AA2B25458DF7BBFD236F0E4594001EF15296C0926B3C6764645A46B86D86	CBCEFD4841613ABD
caterina.taliani@yahoo.it	8FE396D41B4E801CD92B573CB958BFAE086DFC6FEC971AA4851571800217B51846AE0A30434776CD919B6AAEA5BDD17BF9E0E0A2C6263ADA16A0C9858AFF69D1	A3749CE2DBD5BCE3
melina.micca@hotmail.com	607044614419D14D40AD224E3029C9C4961D4F8B27AE7380E4A45073141BE559CAF42A9831190EBC7668DFF09F2942343CD5F5EA79D6853F0AF972D78A594BC2	BD22D4CDE86CD102
annunziata.luzi@yahoo.it	6162DA502E40EF8E615415AF92C6E9AE2C64EF13BA9B6EC1CA2FEC22FE972C5B78B8701704B9AEA8BD5B913D00CEC4792F3275897BD13B164D6B2A812A82D694	C343B8F7422D7287
roberto.pigafetta@hotmail.com	AC3E34DEC7B6CB2EA30A736376D680F99264054A2596010F58BF022B93161BE2BF69D4F0E8597E031F64619E053B43BD6BE7B33CC86403EB4ED1009CD96C3D74	E311555E3ECC7057
laureano.piazzi@virgilio.it	BCD419DE708774F579C2BCDB084068BAD57684C3E960C24E0548EA24C802FF291C63E240D632413297A924494C5089CCED3C6A8450D76EFBFB39991CC0C5E861	80AD23F07D30071E
amalia.ravaglioli@gmail.com	90DCF54F8477489B14A5986D03B9EEC0AEA0E55A717CB84B8C2D877FBED2295ECDA139FF4B64EA3778C596385258410BA87C8A3CB062DF84CABC6B700D55E80C	F991727D1D9BB627
rossana.battaglia@virgilio.it	814E90E3A84DA94A65ABC9EA29486E9CA21B0AE80E63708B1AD855A2388FED5A2FFC7E32403CB8FE30B96917DEC3617362B481C8023074AE383FBBB84787FBF1	9620CED0FB4EBEEA
martina.carducci@yahoo.it	0CBBCC2E3DF25B4B9421AE77EBFE9593AF34755FEB0CD44E0E508CEC0B2075D18C4A3FE6B17D5643BE8429079C0DF244716E95DF891DE7AA7F1326962FB66F3D	EA62B821187D3739
serena.giannetti@virgilio.it	28704D38A4D23EFF792F5792000A5EA19F5D2A68EE041DA2254517F8B88E0E40E80AC5A72DAF10608421CB80536115902D647EC74CDBF6A0AC45EA9C5576626F	2AE66FDF24A4BAB9
tullio.terragni@yahoo.it	CB68F2B2021EAACD7F0DA9089C690127DD047CF643D9CDEBA92477BB4173911EF635FDCF84D68260F2F52B936EE3DDA706B2DF1D2212FBB4ED332FC949BBFD8E	76C788AD43F26F9C
napoleone.bellucci@libero.it	14CAE7D8D74E7BA51C34365649418CA013C0096D1512646F7B569FC16862E2EAEDAB20A324B33EEE1B178C51F8AECFAD37403BE7A5066AB9DACA431CF4F362C2	ACCC4C50DB6AA5C4
durante.grifeo@virgilio.it	E44B5E02301130A709A35E998F0181DD0C081E1B575136F9CF77C198C2CFB9C5EE356B64A29FBD51680C33EEA3A76CD7BA990435120346555B1436AF7CA6CE97	DB6944035A061421
paoletta.salandra@hotmail.com	41806E78A865993E68147C2E2B0644582E1351A6E54ECA434F71C6ECCE61FA3DB34582AEE0EEC9ACDDCE4266C323AA9B4DB31D5FBB59D7B9D33941D8AADC7C5F	6ADF078F5C74E268
adelasia.vespa@virgilio.it	E7705A6DE8BC277B71D175285CF1DF0013904BD8CEEF0ABB33F2717B5D06ED2A303044A598C621716AB9BAE42223558E62C40E1EACE2BA9C2B75AFCBBDF061BB	77E33B8E5A118595
severino.baresi@yahoo.it	D5ECFB0E0209C416406626C5A357B7703E093086AB9956F2E1A57DDB0D8D816302367D359886471ECBF36B006E25402ADE82DE32E6A411DC16436AA7AA7E3662	337E31E2DF47FD67
rosalia.morosini@libero.it	F468D8C803F658071FE7E490FF312BFE8FBE79548B1C84FF0E42710464511481B8C1F1784228A96EFDC5819FD019370B372402587D33394559C4CC7B7E7E45EA	C1CF7DE857CA8AC2
napoleone.crespi@yahoo.it	2A9FF2C6657B793A159D23FD9D5E9DCC13FE76FE1998FCFCF6144BD881DDACB1EECEF227230463E75E29244A1DA1AB47CE28CC117B3C850F6F3AFD056EA37622	78F240FEF7A74E30
rembrandt.respighi@libero.it	D3DC574AA0B52ECB3B2EFFCF526EC98716FF6F56A24AB88D81F1CD2C409C0C81AAC8307F3DFA8E81CAE4BCE8A18DD19D493E7E0A003C19298593FB0EAF75E518	62A29F166AB64D0E
rosa.lercari@hotmail.com	13AA1B2339F1E193E8C0EC40589815D6BC017102965905F31F01832A5FA2D8D268114814D0B3625A4B5D84E7D97F058C552A135333320F4BBED681FB1B2DBC3F	D604544EB3B23B03
serafina.respighi@hotmail.com	8D68E170B5DB05E511CCB1C68E300F47823607EB4DBEFDE25B02A89100495021284052C60A73F211443BA640C2475BFF00127F652BF50AC4BE6896589A24880F	7CC682CE7DF66F2F
letizia.ruggeri@yahoo.it	518AF2B3376B0B0393DD4285EF876CF7E4E0392C55D901AC848268CFA6D1D0AC7EC2CF5293CA22C99A1D4DA375A2CB7CB422908334AE474C80002C3E957062F3	1BF14BBF5F091CC5
gemma.forza@libero.it	FE16EB2749CB76AF13552F20C2D9E5C6D169382B69AB9C9E9ADF085510BBFDC6B64A72F0AFB95BB53FA02FA485C5F3134F6A69BE1C5ADCF40A31E78505206A18	11531440A275A380
giacobbe.lucarelli@gmail.com	AF3ABAF14B14BFCF912421E56243654AB0233F0EF2432F3A9912DD5E7F661A28C12861272B75753854E5A2D1C50C07721CF948D6F8CEBFCDFE5CF6997FE193F1	1CAACB09316F7A45
vincenza.lombroso@yahoo.it	9FE30F0ED6EA7FE4B8FF47D8964A125D018C4486C4650AA14FDE08593210D4276C1D122E4867343F932D0105AAD64D4DA9F7571001D751C0EF2D1936969D3DF1	8FF15CB7D06E8501
livio.camicione@yahoo.it	E8F6D437AC81EB567EF125C940F81693DEE8FEAD8CAAA43489F58CA4128555F82965C0DCBB155CCA4C64FB2456F3F48636A67E531856F370BF1BD8D33F35F9E2	61E9B924F6EC074E
rosina.vento@yahoo.it	83EF89202849AB3302DA768E1231D8BEE6B813AC19976287E66DA5D82A603E972675E6FA25E189C1460D486E18726C73C2FADC13824DE6722F88F433928D7ABA	83438518D3CEA511
liberto.ricci@virgilio.it	0D47EEBA97CC14BF5A85DB1830629C375593A20821C20EA49E7E2170CCE20C8829EB34BFA2FAD4552C4C70F54FB2373E39CAC0E3864F8166AA78C7050D6E4864	366A15194014E4DF
lucia.sibilia@virgilio.it	452B4D8BD84C6DFAADBCF0CC4244EA826FAB2AF8C6ABD2CA70574944036911188986DE98C730E113A9D41CC97A3FDD7C5F38BAFDD18C23A7807B632A78239677	EC9838D3917FACC5
eva.bonolis@hotmail.com	ECD978B8491278EAB6E03DE3746A45A72B5C3507737B95FAC5F9BC4CC5F48C2CAFEF45877BC02AC70F252E64015154B83669983D62803640F43C2B3E8B3CD207	1ED5C175496F95E1
fiorenzo.falier@yahoo.it	7DC2C0A3C9672C04B2E2EF4E0CB024179D17C7E940DB6DC0B531FB00C41CB5A846A451340560AB18BC5826D939A18100BC91EB827E07FC9CF0E3D18650A7EBAB	8C6ECD014E7FF16D
isa.lollobrigida@libero.it	0642F13E20FB6F19CD616B81E100462C66C76745CB0E8B9B4C253730BD765D08DB7E1ACAB7E76C5B3944529ECDF0A8F15C535728F47A0ABB2F360245838F691C	6CEFFDFE907D8A1D
aria.castioni@hotmail.com	A74442E5EB3354F560224310E34DA122FAB623ADE7BA45144D7989765BCACCD121EB4956F842C7C2D7D848E30DB7AEA73C0170F2F7806E48E83F04CFE79A5A3E	612FB9766E0C869B
mauro.visintini@libero.it	A51A1A910C6179EED4DF08207B64378AB947A45B994A8356768246AA6B2C2742D6C665D4054A845AFD89D67489336921F5A796EC62BE4B6176E62A3B683428ED	3542FF65EB8CCE56
dante.gagliardi@libero.it	A93EAE7A675E43C7171F799D931E154803F82D985D28F249C71EEEA3CE1DC03B2E752AEA7C10023190EB30B4F7E8A3CE8A2997723C4AE5796E23EAD801EC1232	8575F2115207683D
lamberto.treves@gmail.com	7BCDAB504005ADA285424189E27D83B3900BD49CDEEEE64AF9B6E265706FFAFE68EAC3F1FA2C60B9349AF6B5B8AD0AD42FA874D64F057D8C9686FA8E85EA3EC9	FE6D4492DBCF56BB
sergius.polani@virgilio.it	9D47A34431C8DA94482A88C1B1A9CFE1E588C9D013C38A319F29624D714168A5C2909EB6BC513607420F264DA8F46DC26E8EA9F8F3D9BA357A52DC5AB23664CB	E13F9998B266866F
amadeo.toscanini@libero.it	E246BD85A9BD8208C7A46CBD1C50C69C6771F5B9E9F1769015074DEB7AEA2CAE881F064822C7449535DCD4706C727CC57406ACB4E00718A0ACC52AC0C7221BC9	FEB639E1CB85A756
dolores.trillini@gmail.com	46CAFF39C95A0AD48C7C83FBB18C53C047C5163A5A869F683EAEB184024E7F6D850FC7C22C68BAA0D13910E17336CF772291E14289175D862A8135A8F9A30E16	D3CD368015E48F63
santino.micheletti@yahoo.it	1F1A894898D1BE709A71378A220BE947D7D355DAD02B4B2849940A174A620087C403EEDB003C703919B08E3FA5553C36BD8D18E7A867B5B2759D4369C0F32794	15C160C6493999A3
antonina.filzi@hotmail.com	3E0B37E5FF96680A61D1B4E43422E11423D8378AD893AB7BB6FEAEBDDCDE2ECD89AD4D24548E0D7E8D8D95B616ACBE33FA544C2AC68DEB84F3A8BB36F0490056	B45D2641D7DF52B1
orlando.boito@virgilio.it	20FC3836A9E7505D6BBBF8E7AE0685645DF018DD8359D345CE7B751CC5AC2E598DDDF857A0FFEB01E55347DE893F324D0656E6A3A6F578FE5C9D4BEFCBE63B5D	E9385F92216DAB1B
patrizia.bonomo@virgilio.it	F05810CBA23BB270A539B9C98477052F98980D3A645566B27DE365FB529EC4234E1310AA6712056DFF1739FADE4EB46CAE25FB48E0D953339103FA3BA80557D7	03F01BEB2A95A776
manuel.grossi@yahoo.it	D04D7068726D86EEAD991B7881E27C726BF7D1DFE860F20FA1EB3B1BBE6766C9A4F983BD3BF272C90A9487F9B98A90AF5E11EA7573FA52AC0D80D7F72847DB87	836B127B9531C2D9
tatiana.villarosa@hotmail.com	00DBA3C2777F85B0945E83334064E8E608AEC692C31B4E7CFE0F0B058F46CACE294238FCBFE40E1709D6C887949FC3E7F535D933E3A2D29B6BE742B782A70943	F4F0D8F0138C3223
virginia.manzoni@libero.it	E869420B8CE50B64E9E06E67821E9CDD97708EAE0AB4E0EBB4F0A96671FE1919EC21142BE97AE81721F1003A160EA315EDC9E191BA9D4CB55367BD35AA3AD5DD	385F99D30F095A94
milena.cerutti@gmail.com	5B5D12A9434995CBBDC2A26E4FA89D69CA203D70DC16D30D4761DACD9E8AAF6CFBBE664F8796A653758BE3F5B0AB76A3F9CF79E8EA08B065575F9E66F584027A	F0FDE2CB36E3F725
maria.muratori@virgilio.it	AFC19C4C27B875E57C39EC1C226BDB33BBF4A7FCC6FD32BC0BE864A38C90C77872CE61BB5BB0EFAC87E4CA1A2FE976136423199AF3CFFEC4D547377AFB6B37BE	1D63EE176EC8D17D
lorenzo.pagliaro@hotmail.com	AAC5BBBEACE1AEF46B6464660995EE74AE6F71530F61672B905B725DC970939F09753EC0D7FE869E6EF991F44AA59C8DCD03F6326E3F9943320718FF098DC3D0	C6D30097B3078EFF
tullio.cundari@virgilio.it	1DC128F2640B3BC543933EDB2607F3892C2EAEE6E42F034AF6765C54A9FE9552BE0750FD3FBD13650471E735416C09A7141F4754EAC4D798B94630F7E47F2A04	9D20230CDF492335
gianluca.cainero@gmail.com	66F62652BF58858FE16BB498540C1C6AE6D59CA47667F3949A6521719E13DDE4C7A005267E3028F9F2289583352F0B85012BF4123DAF21DDCB874AD6AE3CCCA5	0AC34CAEFEE2C4D0
armando.bianchi@virgilio.it	F3707B6D6EDD812BEA82CE559B0BD755FDED2E04554A0D47491B3C5B7E823BE8974009B5DD29F8473FB48D5198E4255C618701AA7A758174D8352BEECD822103	73926F96A22F7010
griselda.cilea@yahoo.it	06D728AE9E9BCF1244BB21821D72BF5021BB0F1112B25FA9E74A28823C4D7A0156ADB1073E6F302D54B871F963D370F8CBCCEBA91B1E79077B5FD1FD65B53260	70982A8B78D46483
germana.benussi@yahoo.it	0115AFEF9316D7FBDF7F5F09DF2D7213FD1CDAA3FF8EAA3D748DA0BC7B580FFF4C8E7C07587A607800F693A529845706674F3AB079F4614A508C1FBCED715E1B	B54E65C5053163D7
cipriano.antonello@hotmail.com	3D9C66F9F65F054511FBF6A23E39A427604C6F7A5C74D3D710CA7AF785A03DDD9FFB98BBF7B536E0ECC45B8B9AF2F0E20C8207DF46AE3CB9FF40BF455D647BAC	73BA23843EC13A7E
coriolano.ferrara@hotmail.com	3BE933A2462832C4B3E407CFDE35F7F0B2C4D0DB5D5A289F8E3DE37006F326408D731F978DF9D0207B5034ECEED114E63E3B98A528095ACDE8F563E21D6D1BA4	DBE1EE7564CE8E3B
emma.guidone@libero.it	C96304B0A10ADCEBB4DCAF04DD6E424EAD4EA5537969F60D157E49D0FEAEC8C49B07DB85F7E27C76F01B2632E9E339C97439078608549316F375B591BEC1598A	75993127E1E752F1
giacobbe.bertolucci@libero.it	1EA7A2BA1138DA8A96A31E905A2571D08ACBF102433B2B5A1CBDB0AB9EE05EEB232266FF87D72A8B02D10DF8FA54D528FCE178039EF58E69C269F7217BE0C74D	F4509D1131D59681
rosario.roero@libero.it	033E3541239A51C3CAE422F97E02A49817F31B583E37B6E9E8B940CC5C287DE112F0E6100EF5B4F152616E1B57F0F93A157A50838F96AFA2F1F30A47BE613372	9956086860D390A4
adelasia.castiglione@hotmail.com	2169C0000418177F8B7BC4098D3E66710991700665738303540AD2EA98A9617276271087999281D2E85F1A5EB5D0BEF1FDC58F630375071715FAF31DE872A5DA	1BFA385AEE56DE8B
sylvia.raimondi@yahoo.it	46824F2943EDEC5233F187591CCB95DDD0CFC67BB69C8800A79125B96ADA4D203E4F47038853775D7792383E569E241EF3A535C517C02955C8D0C028A2B84777	0D35636C374ABAE2
pasquale.scaduto@libero.it	717C518989E68167BB9B9868E8090BC5DCDC983DBEAF202BEAE910A03A0F8BBADB3788ADE5E0D4416B965B965D521566DFA5D01DA6E6FF7972BCC6BFB0651CBF	2875C68FC8F19355
agnolo.farnese@virgilio.it	79E44FF6A9BC68DF5CF679762482E1152A566C6426F9021BDE40486D73A3C0D2E28E50532D166494AC3D54B9FBDE6168990816A18C9D37883C5F5FA0F65DE595	C55111293A48097E
amanda.mattarella@gmail.com	7971181E0850B3A957E2C2E63C71608C0EF02B70256D841ACE2B5BDE19B908421F28D5A865EABB3042E7A1940BEDCAE4DB6DE9D350CCDF2173F3AC452CFB8437	42C867EB20A1B74F
guido.baggio@gmail.com	59DEADB872C22D5A770094C4BDA5349223D45D733202D35E6DE54C9C841EA74846EF9CD04D4E6275DCC9F89B2EC4E8BC5AF0DEE6AC0A3B7E33C0D1E512210507	3E81927E132E9CBF
renzo.gianetti@libero.it	B87B7245F830A0693954B4701AEEC03F6ABB0ED0E6FC833E905C64C57B22AFB5A32D12531E0A59AB44F4C29CBBD57903F7D8EFF28EE8C9A501940FB1FBBF3489	7E06B9C699118887
ottavio.longhena@gmail.com	C942B36D4C8E89AD408A3D65AA188B7D80C7CE121ADF0A17AAD2A870F9235B08C48DA0510331FBE83FC2D58C27D64B284911E0BBFCC40C9E6D4CE3F60DA347EB	4BABD3C46886D752
delfino.rosmini@gmail.com	A67F8B19917041A14DB3AEBB9D1EF6C263013BAE674B5E3A8B23F6710F968567AEE3131FA707F9D74F25762E14492E5188CDB0E44EAFA1D4F05723F1A232DAE4	81295AD4CFDD3EE5
maria.scotto@virgilio.it	3F5B3F456A2601319CBABF591B87A3C16F1807B5A54782CDE2170A24C21F3FCE7BC8A4D2BDFCB8D42632E87A652A0A78BF07C57C744D91EA6928313969539F1C	42ABBA02C59C8B48
benedetto.venturi@yahoo.it	22B711131AAA5C62D79DD7A5897704FB5CF47D6A17741ADBB4257B81A48517F6AC9279AFDEAA3115AD305614A1BE12F517166A45A5DEA04FEA8906A86FC99EED	65908A3842CC7650
fiamma.iannelli@gmail.com	144F4430AEA127F616FCBA70A05BEA817EC3977AF1AFCF94F5B05E19F5DBE92E4D9F377EFC9A22F101420D91576F1BEAFAB40A0EA7BDF04988C6707630F935EE	70169569C5D1B1B8
melissa.navarria@hotmail.com	3A6DDA6A9C6D09FAECB66083D9543D96F4DDF01F2CFAC10F9D2F6B73A17F41F272E9D4B4FB86A7733EA458BAE9A866D1F3CD3E9AE9AAE303FB5DE87F10F340B0	B5892047C78AA344
ruggero.dossetti@gmail.com	DF9DEFA5F43260C6095B1E955E70A46FC300DCC5D00409413881C0C9B05C4971462467732963BAA990FB5C97FFF752884569FEAE6FCD61BB7A32358277EF9A71	1C5C37429E62E1FF
tiziana.iannuzzi@yahoo.it	0D9A1F6C6FBCF9A1FF6B596EDA1F467398F8476581FA25270B6B0E5227085120DCC4269B538CD7E1AE2BC827E9CB2268EE333F807D524311CC213FC9CF9D57F8	AB6F35C12E2325B9
gioachino.balbi@yahoo.it	6E7EA54DB6137CDD3FC9DBDE5140FC5EAD6A64763928ADD4EBC508AF1CF2A1B76431AF306EEE41A6278FEB9816B041644C75C32FBC3B92C8BF8C396323B8B6FD	8167ED1A9F102ED5
tullio.beffa@hotmail.com	F537F01CBDC10B59972FA5966CBEE0DA490E136462E80059C6EB23B238FF0B29BAB42FA366647243BC69D6A32720D8D20DBA4CA7C0BB48A31F677C3B9EB755AD	6D6EDEAA9724979B
maura.mascagni@hotmail.com	B07803EA944CD4F7F7E23CBE0C490C6347B309D10D46D8777C0701C85613F17F4944ACA034C81A9AA72801023065F4C47B470A616434817C9B374165159163D4	9ACB69B7953DEF58
olga.moschino@yahoo.it	0948545DE921142B0977F59BDFA7BD1D67E1836A1C95CCE032B8CD5D6B2E2822CB1800589A4F585265B56BA6FBBCDE4039E15155531502DCE13DD2190332B7FA	7A0C70B64E0C16A9
adelasia.disdero@virgilio.it	472DBDC641839BB9A2F8D5D483870CE59D28DFE9DEBF4CE9EF6784047327B5E373B5B748B785B6ED496A62FEE607BD0AF5C63B9CC542EC79D731ACDB24142296	CB970B1D63F6BD13
alessandra.giulietti@hotmail.com	932AF540CE0E59097481B44F2831ABC8FBE8FFBE499E07D51A29417FB060D65A4AF4EDB4997C2831DCAB4A229945E9B1D1F47C8FB1F8FF628508D69A91EFE1A0	D615CAE10074624B
milo.mussolini@gmail.com	1E3206ED1770D04E65A04DCD0868354C8F1889AF1F0BF1023CDCBD823A98778FA0B443D65254F8D09E77EAE455D1D0DD9A852F946987307FA962E426C5B779F2	89785C2A6FC0F54F
lara.vattimo@virgilio.it	36221CC4E80D27440C8C7E1CAE32C2C826015978F8C8653A3A46D2F65282CCE94987F371A75AC08EE50B67F3408BE71CF539AA3AA05A55B0D38D23A5612F5DB9	51056CD99C9741F4
nicolò.lovato@gmail.com	43BF8185086920EA31CBBDA6A49A7F6DCCB42BBDFC0218B5997FC7601338DCE923206547C547AF4A95957C21DFDF31C041D84C82F44F2D34535942D233CC7D71	F9081067B4F1F974
milo.borgia@yahoo.it	9B6BDD9AC0B4EDF98115AFEB0DE28106428CD2517D78FDFE920694FB00D44E043F5F06FB0DCE0787576D61C5F56129362B6B18A2CA2906B9B3271829D2984B38	DC32CD9103A181D9
irma.manolesso@hotmail.com	D7065EBFA54E85397C5352C64E828A60C69BED4E3ADAC79B28C9A24C57B0806E26E91C9A6B3BA7F18833117FA91814E52BECF0B09989783DB89D3DAF59109C4E	27C04E4CF316878A
ivan.raurica@yahoo.it	5D11510A4CCB15390964B9CC84BD1715B86166BF6F251FFCB753CE9EFDFADCFD91A8F06F9C30D64F49BE7CC23DA69F10CAEEF91EF67A1C1D72711528D43B01A0	6BDE685316FBB6D1
gioffre.tasso@virgilio.it	807ACCF1E17C5166D90182C24641A5B025EFF08BF5D7430EDDFEECD1634E924ED02CB86678BDDFE4D0303B612A33D71D8C36569F5E137E3EBE761C74FC67F94C	02815FF42F373553
bianca.visintini@gmail.com	AA8339436F2EF4467E4BD6B1A1877DAE4C2903A4F1E78C5D13608965466BF240264977E786A966B783CFFFF93A8E9CC0A7A718E2491E7D484632A5BEBA6B9AAB	BD86B3837F4A1635
raimondo.ortolani@libero.it	8D3FA2478DB3622B6BD16A5B5D8C0F77D671DA0D3A51AD0C1A547B2786CACB857E97607AC8CA74EFE516152DB8A77C698E0E0AEC95D789666B8BA491BA7525A7	B2168E4FA736B8A6
laureano.bignardi@yahoo.it	441A1DC1466BC512980886781951699E7AAEF743CE9EB86284E618398AB2A9C020339B3D56DED03868D5E52E4379321EA12171A95BD7A6BC4C13E682A53D3CC0	66DDA183E06C8DAD
natalia.antelami@virgilio.it	1686F658A6AC9AA33412019FEA2C49A020156E054E559EB1E1F017F3EFE55BBD4329BA39C8AA8CF2FDD1A9CD1E09910EF468A57BF020A4290B906581BDD60471	D8E98742119AA913
filippa.salandra@yahoo.it	1611FE3888C45F306946FE647BBF8C625F48A8BFDF9F116A3D03FF56932602574E0B1D8BF3C15436EFBD94FEE54F364D415F64F97F296FBE65825F14B0F6BC53	139007267E3BA481
fredo.bellini@hotmail.com	71E735C386E39B59931794D87A249EB6E58AC9D5F02CFB62F887EDB48336B1AAF72D4775B9A11B893C6EE8F3D39CC48557DE33BFD65C0DA3D279B3D2BCE19B42	BA9AD1A03FAE4855
alessandro.argurio@virgilio.it	711E170402E0EEA3F3C48E1D1BF0F03E170E2D2EBB7E4D48A6D46C011B2CCA0D5BD863FCCF4087C8E3F5C20C573F797DD0A60B639789F18693D85B711008A582	A39730E4A64845C3
toni.emanuelli@gmail.com	9AC5F8D59D91539FA31FD38B60F5E79EAA23E708DE2B959722A4BBE84CD5C4D38A89F8AB588D42A439C6D6200B15FDE93A4F0070CD5A16B8B1DF965BF3981B9C	B6E1D9E4E4D04AF2
giovanni.porzio@virgilio.it	E2CA29034C00B3BEE48E0F25AF871A9B980A14ED3E142755BEF8191F555DB24E3FBA097521EC3A80D1A224C37F30A47CDC70D20B9CC76A0901F99375A3693A52	DCBED9E5F401CE84
laura.baglioni@hotmail.com	372C058068DC78BA4FEAC1DF74D7BC35AE63EB878C2B7D805971DBDF1143BC6F35C57F942B31D2B8F89E2BA118B1D532DF22203A114161A9BF3FC7ADD1E06F91	5171448E69A35E5C
sergius.gregori@gmail.com	A2AD716ABD938746AA479307DDB3326AF14DB4E4B50E0536F558797C989DAC36DC1C0585B2D45F18B64A776873A396EC76227ADCF0C60A70FB31115749AA42ED	394CA51CBA922C2E
amedeo.druso@yahoo.it	A62E69A02FF27E3F9FA258FAF56A4857650B40043BAE62B2771996B84664AE73BC60469C00CDDCD9BC0C49C846F3BD0C24939C56384EB5EB9C346584123C1277	1BFB343DB1A09FC4
beatrice.nordio@libero.it	ACCAEB13FB2252FC2C7160ABEEC56E88207BAA211C69394136AB693E0B986308B361B9179C1179C83939FA40AF5B070D97FFD57158259102CD5CD0DA95E266D9	A3B9E215C8345245
arturo.vespucci@gmail.com	55DF3221D092FA14A961975F5E14FCB25130C9BB9E943755BA3E495FBE21AD6C3C6EE41EAA06D1AB4E5379633FDB5749EEA06D17B44537B815BBD51A5972EBC3	0AB8E10A525F74B5
donatella.giradello@hotmail.com	97CC3C9A0EB71810F2AA70EC794D0ACC97CBC2837FD789C80CF9C2DFA79F48AE0A29830A44EFCC3B97F1A0B8F23CC842044E91DF60439C2DC80D4800EB804C53	AB426C89656DDD23
vito.argenti@virgilio.it	A66F7A66FD68A8AE651076BC13450CD44BD05890EAA154AFBB49AB6C781A8863FE8E2358F82A54DE2C731566312F0386D5B2A8C95709E23788A4A58F94BE3665	04B359B56817647A
giustino.argurio@gmail.com	8AAD18BF089EE0DE0FFE10B5947CBC262E8AB187546F255D89520C46207AB0B3854080EE8E8658397E3CBD7B3915A979DE3757241C6473D9BE23164906ABE5DB	EC7E2424002BBD2C
fredo.bonino@virgilio.it	913D8CE4D38E907C0D08769E5169C7D97371CF0E7D0FB4E2F32BB5AE3EA8553758634BAA45FBD8954C424E0E98D4B5ABF84E23A5896E0A13578A614945DC2AE3	DDA63B43F7DAA658
simonetta.castioni@virgilio.it	5586BDA941EC3C652D0DF1C47FB68AB459C3736EDD482AC7528400C6AE6450803E3CF5C4F1FCC83BBFD2728E4D2387571C7784C816A0C2F44A18B7913475C3CF	6DA5B1B975294893
mariano.golgi@hotmail.com	3EAB56370CDA12421A779EDFAE111E5365CD95C147F3A8A1BCFAB92391811243A87A22FE0D40FEBD2594AB5410E102279C99B5C732FC92D5AED659AB88179552	82B98A4F2961CDB3
sabatino.romagnoli@yahoo.it	D7CC138D6A7E4567F7467F8AD4AF7D50B2E7BEEB8BD1302DE18784EA2BED704746D98546EA5AC048ED5B692037C6230F6A140B981E4121157E90D027CD23DA76	6D51133979F36F70
toni.bettin@gmail.com	104960A501541FBC2C79F909AF4AB4FFB37DEFDD6F2A8DF20A0D5045E8A2EC91838B2BE711C410475F47F9236E05068BC669542AB86D96EA045909CBC34F5EF6	3A980F0F4EA5264C
sandro.pausini@gmail.com	7D5F79B26A5CBCE97BEE70D39023B9131EC7E185C98F9B9FD28A3ACE306E35F7E85BE31E0D9A3D2F600E28D17AD3AECA8E0EDCE756F4DC626CF3E54227ECFFC0	BE0FEC5808049982
vittoria.morgagni@virgilio.it	51AA8105AF3674CC898FC720EDACF9A42CA4C837622E69CC2E606E5EA3953563122D00FDFA0051C496B883D97EAE99FB922A77A2B09649AFDD01D9B42DF507C4	D7689D89D6BA9381
margherita.zampa@gmail.com	ED7D52FCD9228B4867654AE9423155B5400DAA4C0BD85C5D87EA0F7A2D35221E7D5599829C01CD8CA7DE71D101E423B61DB219841FDB67D29787A17C4251D366	EF3C24F29C1FF59B
roman.rienzo@yahoo.it	E0B25B8866CA55823D9D69FCA9959E3170DB924B4797C4534B6F870B43498F39C3B29C61D13A12C815DE40451BC881AF225FBF5F1A098C43B983A3F75825D6A3	53EB313D0DF76C79
filippo.battisti@hotmail.com	50B275882132F46C3823222FE339BB87C0F827DA746EA17C33241663FE7E27DF7FBFA80AA32F566549B600D7A05BBAD3B3DDEE20012CF39703B3BA266F05B154	81D6903E1879FB1E
natalia.trillini@virgilio.it	D27B32830E77D25F769A2FDD3BCAE8E88BB4DF4AE3B90D2775FEA8C675C3F1A530BDD14491144AD83FD71EDB38345E4068B063424AD96DF6D39C5959DB7FF448	061E04E16B2B75D2
fausto.ricciardi@hotmail.com	28C1F01407858EB14F4F61CD4A294908D2BB25784C47C8F38D9D9EACC9F80A6B7FD4DD7681B7FD3FAF051A3158146E4953703077AF8EC1149AB0D29387DFEAF6	2E902AC34CD035C5
gionata.fantoni@yahoo.it	9794E1AB2B767A5634BCBB1A031CCB72B4ED1E3E69CE05548FECBA9CEB61499FF12036C7E050006679C2FC6990A728DDBADED84779A60F30A7B267DDF366EBA5	FDC84D3E3B92C15A
ninetta.camanni@virgilio.it	5DB4A9D4200B075C76C0CD210E75E75A0D4FF18F61B22D21967676E7232C459B6CDBF5E5D0A996D894741B7CA04CE8C6CB8A1D8DF57B903E408E9B85F05A8F4A	B648ED668D660B62
galasso.delle@libero.it	76122DFDC43D07C84FDE8A7C75FD9450256D4AF127F029E7EBEEFA32B23BEEA7CE4141254D6085B10B1A342CF5DE3EBA37AFDFCE9A8EAAD732C88F0865FE47D4	9C5B638629BB73D7
rolando.raurica@libero.it	B76F731C1C9C782D305EB899D5A18FDE5E8D58D699DD9334116614E4C2F2F4BBD07FC2E1935CAD5E66B10D225E715A5462CBE5A8789A133903E0E56AE996B586	5611F01F565628AC
gaetano.capone@yahoo.it	C9AB4E23ED9A81A7F539FC19C137BA7B83575318ED6A2B57C329EC00CC87322AF6338E78C9D68FB2BF8654CC4FA97DA1847BC5A0A637AD2C71130AD1A07149FB	458D7332B224B133
eliana.rossellini@libero.it	38212BD77D90FC4D283A950A9059232D88C44E0282D320140FC88CD02DE734FAC28DF5C14FB3ED02440FC3213B7C273A149BCF8E15CA858EA5E7482968F37502	ACE566EE9C7B6FD4
ilaria.pigafetta@libero.it	5E352C997564B8C665E056DD970A987C1FE045E19E22F3A285DE2BFD8FE718411A237D2858A82AE5E9A814462A7234399D5A71F6113AC379692F03F47D2A039A	CACEC5F51927C3D3
giorgia.zoppetti@virgilio.it	678157E07A3559722858550DAD402BD8C07A4F138D4E6D00B92392CE8166513B522E6F9480690F34E2B8EBA6D11782AE3A7A36A09ACA9993FA7AB1E3D07355D5	9B0A598ACF0FC697
fiorino.pirandello@yahoo.it	F2DA83B40C69B0CB4385CDF938829A687570152BDB0AF37DE1194A8D25D4F3C8EDD1A0222B6D338AA4FC45FF06B39E1D21BD2F3289F9ABCD96FAAA09C4C54795	E67887822650DC23
eleanora.pepe@libero.it	41373FAEB4C4FC27A042B26A94F0A536D83DADDF40F5212DA10163FC6A1B4548CC6BAC208B20D4B6950A14ACD7E16DD2B8971959425EC1142A52D8A379AFA64C	F39E061057A70A06
fiorenzo.fabbri@hotmail.com	3C563CBCA63FC6D7D020A5E596959F2E95F3B7F5348344D256C5409D56349EE2B1A25ABEA2848B3E726FBC91DC74458B6D4A0B0218232784D0412906485D48A8	6CB6D36001FA32F8
flavio.foletti@libero.it	3E4FFA706DEFBED1E64CA784FCC91165D52208AE76940A4F787E35CC08487197F2AE78692FD90A4F506BC664EB332917D3D3BD5BB6415A295F886FEB460C85E7	9D89F859CD8D2144
daniele.gremese@libero.it	A6CD24081C3BB3AA37A51BFC0FB815597741DA9B443D24E2D182B70DC05B44EAE72991091EAA831302618E983AD48DFFADE8B89BB8747D26A0AFFCDEC878E831	9395DBA318B618D4
paoletta.cossiga@virgilio.it	41DEA2AA85FC91FCAE255FEBC12DE4B83649692437A1A8E2638A0F78C9E3D1491D5B1D1F2FAFEFA682D26BB029F01D2081868ECEC22CC27A267783E66C7B0261	E98043DBD1A2AF2A
giovanni.randazzo@libero.it	D27B7B5333A1A666082F44E47CFB7B344118E77AEAE06DDF975C54BD7EDE7F7A2B39F42B814BBE1D6F5ADA2FD583250B278BCA8251653CC12E08B00F0F84F838	91B940D8AA2F784E
goffredo.scarpetta@virgilio.it	C03F9DB716CCAD06E0D55101BEF9F2524EF81875DB9FBA566E744C2D61617B219B7BD8DC04DD581E13A5CE5AF66A9CAED7EEFCB367DB8C3D923CB42A61116669	710CCF46CE3E6A8F
giuseppe.savorgnan@hotmail.com	41883DE56B8A1A254F4BB7A4DE273030EE986969A349E4BA8F75D3F7AFFFA44BD37E787C8071DD8DF16D010591BFF3F39B27AE97807F91E87F1AC57D75B42952	5C32AFF001DF0024
lucrezia.calvo@gmail.com	3263171DD12A61F7323D4B9999228ACBF9D2FC02DF0A105CB7F1F77AF27AAE1C27FD99F833EADC6C346B1E67E518F12C2825E661D32D9794E7612D4C61261503	67C625921409075F
virginia.spallanzani@libero.it	4CF0D011657562F7432F88F3F7E0EF9EDBFCAE872AE2E7DD73FD9DB7CF963C0E7FE64C0B830C4D92FEE1F66F44CB19ED18DAE8BF26F76BFD8231E22E9757DC47	0056EEF76267D596
lucia.satta@libero.it	CE43C7602F5F761D8F00C46E79F0EB55BE0FF77A025B88F156E6DB1D7B68A95C4FE880D71DB2328B0BDC888FC8B94B9AEA92E5928F6B946B24BE86B9537A1135	79F81145C5312BEA
diana.guinizzelli@yahoo.it	089BF3779B120ECDFD98518C9F2F42B57D073D2DE5FA3E1C4CD5C9725F34F7DE840FBB8A727CC6DCDB33DC0F6135C8185AB296BFB94173BF9F2C341F4EB3C8FC	C3944392BFA36B04
michelangelo.persico@virgilio.it	76DFCAE56725E4B02462F6954CD7A563F4F6CF732B6B59A4D11BABE7296ADFED35C78F163AC6A53618F32D9AA18032D109A1FA394FFE6E67954E8E7F146F2B94	AB6F7A9275A788D8
laura.jacuzzi@virgilio.it	AFE6B4060BA0DA539F81CBAA5BBFBE929625CE240FACEC4E62B131D1F770EF5D9480B0929791991D8BF369D77B5C00F280393A95814213257438737D5C924460	BEF4D9D59D7C094E
salvi.stradivari@libero.it	FECB65B67FE276031C56A419D32FA1BAFA9E74B8D31442FDE4DD2C2436AF1391CB916231DF121C1A7CD5FF0E9E6831E324DD4D7274E91B33F7B5DB7F8C86D2FC	698463F16DCF01EE
tiziano.bosurgi@yahoo.it	0D89F2ECB1AFA23A124112D39448920213B78A479F688CCD08E870F7685C19A32033BF1B87C419A4D4787C3D6C10D254CA4F8C34D8F2A94FC4ED8A5BC15A0BAE	8FA22D8CFD74FF08
ippazio.gabbana@libero.it	77478666F07F6787B8A8A4F59F77E1539B2A3E93A16BED56692BC89BEADE6393C19F466E95ED29A97D0F2D86F678BF48DD39439BDAD933701773E0A33D024B73	E8F31F3E1DA6E236
agostino.cappelli@hotmail.com	352227ED22F019AA799F98FD4395E816A3E979BD5368032548E84A043AB54AA706E59999313404DBFE64939527A56C1A6473875E2AFC98B39735829FD2F874E1	EA001B3BC1B8C420
antonello.ubaldi@hotmail.com	00BFBB04980F84AB87AD7FFD65B3CD806289B4FD41EB2B5B9E0F53828F2A056548FBFD7AFB0E4A32E91CBB9E4FBAFBA6F564870524A4F73BDE64C2B4CC11DFE7	F02C5B9C3F7C7139
maria.virgilio@hotmail.com	30C966D719F39AC674ACA113389ADF292CB3F91B8BE9DAA87DFDC84D3F49F969C5453C26401657B8E77CB9E639E066FB06A3C361A09876FCAD13A2D7898E7E7F	93E9E3C6CF439486
morena.avogadro@yahoo.it	043DB41AA01F85071264CC4D23F528FDFB015C1CF4895B61664A59BD75C3909666BC362C8A42E23224B64D1324407A896D0872B9CC7432EF5A15D034FAF0273C	0CA4F1CD202963E1
giulio.bettin@virgilio.it	452A4FEAFCFFE2AF3450B4A148D72AB755420EB74FD7ABE47D42794A1BA9CF88C507F89D2A2C1E64D1D8FA2158DC01248EE50306656DF2ACFC9308984110F9A4	0A2CA37FEF82C578
liberto.borzomì@yahoo.it	6EE8B3AD5D7186CC248DE59E6862BC323CD73FB0AF8B3FC4DB1C55956D7C3B8BB30D220E30EE309096A272DDF3E74D8CB3A612F5F8092DF3770BCDD8654DA2AF	39771CFDB6C68159
marcella.fieramosca@gmail.com	038F694EF1ECAC66973C2FFC29512C40C66A9BCCE654636BDC3311402B6B652A0284A0BB604396028C3F745D6B8EADA7C1BC47D9A76A8DDB0D568AF4463115CD	F9535FD1399007A9
romana.celentano@yahoo.it	D55138B1C3DA6C54C854C4C0A9D94AC9404E1CF2FE0FA7FB3D6B588F4AA4CF66D7E91867D533B19D3CBC33ED8E156ADF5A00D44DE17F37B758CE5A7C93C5A41E	C8444F53E3A93326
fedele.morellato@libero.it	728D2DFB6276779E39EFC6D1C9292B13A2AA3EDFCB7BA7B793BA71C41090DC8182328B552660D3CC87D7B62B78D501821AC5E302436700767368CE1B4474DFC3	7DB0C1785C7A3F45
matilda.monaco@gmail.com	4003D82C7B5D5B86D87359B5F7F148D0724112743BE9CA557F9D0579AE1B1D3794BD0869A0838935D35666BE13F2DAB48E93038244ACB4297C274FC3CC6C74AF	6BAFF1991C4DF76F
vittorio.dossetti@gmail.com	E53E5A7F7FBFEB9B2226CCEEE4E7FB6CB92C25F177CA1480B7B00C61FA0B6C2906C46C72B68B215DB74F3BCD048CB80E6199C03322DEA417764BF678C4D1A1F7	1BEA0E3A5171189B
vanessa.panatta@gmail.com	7E050FA523B487858FA4E783A60FA58BDE345D4E677961361DF499063AF7D15580410B1074E88E553550338E3B3AF3A93AB8E5A7464CF2978333972D28F3BC5A	EB8177877E8394A8
laura.saraceno@gmail.com	087B3CFD01152A7324614C5BD7A68F22857404BDDAA8B97D62DE0B24B3EA1BA72FAD09869B2E42C6D9E6290A87A14696D49B7BAFEDC2AAC669608EA0144C4F99	66C57CFBCE740E13
romeo.zola@gmail.com	FD63B966E0DC499AA48AFE22DD43A1B61E8626C68748BFFB89F2C09D6696D48ECBB0FF31A0E08AE0AF2FC83A03165A5449109A753B5136CE1BBFFE442F90A61E	4868AE0B53BFDF04
armando.giacometti@virgilio.it	FAFE8EF368C4B06C4AB25EF19647748AE44CF61BFCA5DC655B1B758E267882176A7350D7A8A9BF7515F3EBD497AB9E89F2111D4F06189B7676A6C0B40D8793CF	6310B3CB67CD6945
annamaria.pedersoli@yahoo.it	2DC5C23F8EF91E757A35A3D656EDBD4891FB03A0A3BAF6C7DAAA06A8B03AF7ACFAD8350923A5C988037035AF7F3ABF03B4C245A5AF0ECA20190D46284505057B	966711395798F3E2
agnolo.soranzo@virgilio.it	4D8557DCC8CC197235E8BA7D9EC86D91FC3EE9C9AB63A2AD08E19A1F6AA2D8F968AAB141D8F1196C0C9C1E187C474A62EBA43FCD48AEB25C5A281AE126BADD59	4EBC909C3EAB60F8
pina.gianinazzi@libero.it	03F5FA7CF89100A4B2D2F939E58DF7E448ECF432E11919E74E0BB4881670FD2EB3CA4AB56EFC132E934F68284557CA9A8A9ED44F8A99C647F785CE5AA6712165	5296E79BE230B12F
laura.vecoli@hotmail.com	51372547A458A58B455FBCE41B8DB1EC8441BA8B22FC51384257CA3635B509F97E72A978061BC1598E8198471C35BB642F292960072BADACB8DC99917D9963DF	1F9A10C998DA1400
luigina.metella@yahoo.it	94499C1B456F6DB8176176A472EF5CAABD949B7BAEC5A7243DC6228F6A792E327DF72092AA99C7B6864434B52026FE64F1119925F230712ED3FB46201CB4ED02	1E0E711F48B4C7F2
domenico.chinnici@hotmail.com	5EF409051308DE8FD592EEFF09298838828356691E533E1B14099D4E82125B0DF1E25ADCB5F15CFC18CF394D48CF02E8AA045F353286560D6C4421A45DC0FA9C	4BBADD8036A12357
fiorenzo.corcos@virgilio.it	6CA09BFA5FCC4CFDE90880F542EB9CBF0C908B3D11404290ED2605293EBEEB518BE91BD9001942DE318BCDF9D2B2CB939AA365E27D503303745AE0502116D114	ED3FF2C5E6D6C000
anita.lollobrigida@hotmail.com	53C605EC626D505D2960C2E3DC9F6BAEB6969730992173DFA26FAFBBC37BA60B3A67DD5CEB1C38B9B174523C89E6201C1FAFE195E8AAE7CB2B4D347EE6DD81F1	66E2715F7985AFE3
galasso.grasso@hotmail.com	CA7F6D7771E05C1CAC71D6DA1E631F2A7EB33EFABBC2B634E031240AC47D60ACF5A263E94FCDE27C48EE4F8A230A4E4B5352FCF83A6FF18398EF07AC4D225020	8140B6B810058B7F
carla.accardo@yahoo.it	04E862E66075CC46BFBE46C7B073B82841E23EA9BF288131B183929057730E82DB4D6BF44A8CB917FB4015302CEA01DF4FA6B3EF4E6ACD22F38C7A9B3B9AE380	F2F79DC2A461AC57
guglielmo.mannoia@libero.it	F1EAAAE076A98CE55D18EFDEE8E9761BC460033BEF3176D962A727DBF9481EE3378C480AC949884EC3DEC91D1ABF5FEAEFD2E6B03D6FE2849008A6DA2292EEA8	1EBD53D38E357AA5
lauretta.platini@hotmail.com	C9E60477E8B7415D8545C1A2B9F1A93807CF326A6B913D9467321A0F30FCC240580F68C396375736AD815361EF9B015C790AEF71A7C0EA1ED58F8F987C1511FA	19AD238F4E650DD9
rosina.cannizzaro@gmail.com	B559B9CBE9941D744095FDE8C6BB5D5E494F7BC1B55EF92BBDD5DD2EB9B762B4226DDDC508F952E1877DF18D56476F65D49D2CFCCFA056624C434ADC4F44E29A	138FDDF6D4F854CF
amanda.giorgetti@yahoo.it	ABE568FA2D094299118DEA8474EB27FFBD70861BB39B4634CF2035752F940C4224A140658C045AD427ACD8A7882498B2C29547BBA0BED4A364CACAB5718F3249	9BA57AE014913E20
priscilla.mortati@gmail.com	F69EBFBD474B02301D2EE7AE7F3CCB002AF0114ADC1576B9D894CE237EF3000BAA80A0022722A2601BD1993FD915B7A93A97808F0EFA4598E8F61E0A64DCE8DD	415F7ED3D669EF8A
giustino.mogherini@virgilio.it	D05D5FF390386E636F4144EF304574EEBD5A78CC317070E4640BA2BD188EB34C77244131C1AF11EA204BC3D7ADB1B9ABE5792C59780C4D7AB7A8E2C318145EF7	AAFF1C1B79962739
pierpaolo.valentino@virgilio.it	60949413900E0539E77FCC8C84CDB21EAB0FCC485C7236AD8EB24866F30F49CA0F1343C23ADFC70E7F7BD822C9C945E85045A47FDDDBF973EBFA821AD5E9C94C	C89A3379E1464010
federica.zola@virgilio.it	EDF4499134955792BF1CACE61F31AB71FB9DD8B5084558D6A4F818A95353741762CE3FEFA34E035986B983CF31E9A15B5BA1AEDEDC533D917AF25605D13EEAEB	3B6B86443BB42F8B
fiamma.caracciolo@libero.it	C4628219C28521476D98A66AC277CDD908DC8C4B107C4C9B083B4B7BA0690C48BDC7DF6822C83BE3FADD00CFB2811C4A921BC00A1118D3118D24E29C766F743F	A20019F91CD3B26B
letizia.marzorati@libero.it	1FC396CA21242C6ECF112D627958C6BF0D84743EF6DC52465EF94166DC7B83DA9F49B2F53AF6FFD550ECE98692370D58D8A5DC2452CF36FD2C8374C708D46ED1	3895E56812720BCA
nedda.sommaruga@libero.it	64ACC05EEAF32107504E98757FD3EC1B7431B4BF93791FF72D5BECFBF3974432E9AD20CD43255D75D3091C4362EA2A0C298A284652172162E9B109AE4322C71D	9DC2FFF488D42E4F
jolanda.canil@hotmail.com	79EE133A37B8287AF0AB9FDE1B797E16FB40B72033B887A94872CDCB8B81F4C8FF80A7188729D02FDCB4447DCBD0758766FEC596DA6BDF2142AC47A29C5B0518	0795FE667D553816
stefano.carriera@virgilio.it	FAC79D4F2FDE5F200AFC8F9B1F770213A625C036AED51A8DB9B3F4AB2C53E4EF137AA19DBC80C14709E7D3E445B68C3FC2667A23E13C4421AC38F94E1AE27A6D	AE5C7A3A37FF747E
liliana.boldù@yahoo.it	DB8AC8F5DE7FF201CA8118D6E975B750172E09849482351B6D7360B5D62DE15D7080BA7F211581480FFFB6665379E7B839EFA6B525F801DF31399658574FB892	6C061FE0A1AE34FC
calcedonio.norbiato@virgilio.it	609E383C6C7C839AD4E83BF7CB2C041CE015B06DF372F497072D7DAB1826D3FC21BAEA92EECC668F9581DD326D1FB39B03E9FD468600A1B214E1053B981A0D30	957940A1CBE9BB5D
gilberto.prodi@libero.it	D01A07E7379FE8BE4D117A060AA58A71C68CD217DE471EF180B28F15220439B347E48D6D9064A55438C6EE53D2211407720DC79E992D39CBB069CFCF21E0F775	D0A014FF48A160AB
francesca.oliboni@virgilio.it	CC2046F5209330EBDA33E0E06A7B7725E37E35FC1685835E438FF82D2C94F5CE6F1F52A8E872A0208E8B570F30778F990C5FF637200B2BC2C79574A21A1B593B	7FF9606A90EA0C03
arturo.mezzetta@hotmail.com	8966164B20B4ACF98E23F36D01755E1589950ACF2FA85D1F07670E7F44D500199FC203F1A4B7546099494C6EED133AA5CD36F7F9C800AE3CA1957B2BB6523C9C	585D53E5E8BB560B
lucrezia.garzoni@virgilio.it	B62CEB4960B971088D210EACCA1A7B3F5D19759FE2F1E7CE1C22A00B0ED194E6C182AD128C97E7C5DE6177EDA021893B6347EAC92F6DE396747544822D35C54C	6CAF30EE94373C4C
guglielmo.palladio@libero.it	8F4D639227343CE0B46CE74A35AB105FB755760AD0295AFDA782F6B5A8EBFBDDBA975CCEBB7FBDDB4617A92E942667E937CCBD2B579CE6025C211C4D7EB12F60	E38A2446551C9658
alberico.iannuzzi@gmail.com	CE47C14061DAEE4FB61C7DB4F47411380ABDE764F828576EF589FAF088424902ED531F994744C1C3C1062C652AC99FD599CD0281260C9956D06F2EFD881CDC16	00399AEE0ECA518A
domenico.ricciardi@yahoo.it	FF2BFE0CF0DCAD3A029522C00EAFF2824DE6331DCB4C37722A87E8B4331D80AFEF8F8E3C0D8C565BC814A3232A73CF983E24C4D29D2075C644CD6DBAA7EDAE97	038142FFD02440F0
rossana.valguarnera@libero.it	785FDC1B55AE77BB5EEFBAD75F473E576BD55AA1A8DE12C2ADF206098210080A6BAC742F122A03BB6347446BA64C897051B5ADB942E8A4A17122BB272DE17394	F8C5278164DA4391
renata.pausini@yahoo.it	201DFCD9A705EC52E54462282B7C29F0653B74A29F14A3A1DEA93A7AF231759C2A1CC44396AC122067BE606F0C10861A57D50C78FEF98D234C11B3FEED22BFC4	4BAAC69F56C2DDAD
serafina.ruffini@yahoo.it	95CDC145BDE95A73F57FFDEF588FA68EE709309EACC3CDA211BA926F2B71BB3E45C5EC49DB7203B57391135693C930D876D2F445E36A27DA7B6FD05807E2F17C	ACF8AF86DBA06FDD
marcello.castiglione@gmail.com	AE3CDBF25968E5E5AC706361BECB4368F1C13F55CF0A80BE5B41C94AE77A953D3175811DF6FD96E2BEE8C915C1996A49361E5664CFEA0C386AC20D7D353A806B	3372FA259C9817A5
ricciotti.munari@hotmail.com	0CC365007588374C3A68F1EE807F7A8DF034761813059E7326F4C41813BD528A85CE4C04B323BCB375321E2061C7E25AB42793E60CB9F2E135FCC7EE853D3307	D7DCCAB04C150680
giampaolo.salvemini@libero.it	C7C198ECBF574A6182DABCEFA0412582292B97F5388276B5D34C3EF51A3D26AB21BB1FBBFAA5AA4660815F99BF18CCEACA80221B5DB8409B165D15A08E0B6F4D	1C64061DA14ACAD7
matteo.pugliese@hotmail.com	554D00959986C6FED8917AFE7E88AEADEC61FDD5E0C523BDFD2F0B79B57A39C7238BCC100ED6AC8A509557604ED40B848E334F60D7075567C6785AB255AACF79	416E3D5F5DA093CA
irma.cimini@hotmail.com	2383BC27AEF7790BB099947D37507B06A20E6EE3CAE807F34EF2BAA042536FC6EF9094AEF8BA9E2EE682F1EEB2454745AE004AAB690387ED37411D5F7549CD3D	A2C75DAAC7B0A323
nicolò.tedesco@gmail.com	B8C6A86485D670FBB17AF03E76E2C2FB9263C0F0C15961D6A446A7C9132618BDBEC9BB210383413832F23B283698A0B22A5E99244E5830F62F321006DA140DD3	7C15471162AA3C58
sabatino.bettin@hotmail.com	CDDB94681E4451D0B9527B910E23C2C812D89F3D2F3C1166923BD7F1472D41453F1B3741375E1B3C7486B9D39481182A4E0B214738ED6838697A4E22DBCEDF4C	06728B8687C4634D
cipriano.vercelloni@virgilio.it	F1A506D48B7B37CFF132680E159DFB82C7AB05EC225DF2B156E9145571251DB6D2CD03631C1B96ACBCEA66E2257DF6281EE70045BB99C5771F5D746693D8ECD5	275E669C1368B176
fernanda.blasi@libero.it	58ED76B808F16FD5B343380881F13615E2748B592A537EF69CAC661091E63D8AC4BC3D6572D78D578B47F63B983C9D46FF9AAEED6C3EDA655C1081D31700A9B7	00296B953C47D8A3
eva.carullo@gmail.com	D14D6DD8B0F7E8488FEB1DA76E5032407E0672E074B555465514535CD9E0119FE17B39655C13C015362B8FCB992878D112CC7D904AD238ABD8C7DCAEC4C17501	66722AD0B28F1D9F
luchino.mannoia@gmail.com	F9EF3271D115DCE33A4F7736E4DFC62841DC7595226CA35364F1A4A05DFA2DCE94731A0F4BF2BC08FC911E3CBD11837235483950D1FDCFA6F587785E247DC985	550ECC6848D9DB39
melania.martucci@virgilio.it	C456AC185E166ED1C5244C22ED0671B7C3A66EB34ACF3AB432A7AE51BF1ECACA547123A3870930063E650F93E0212037142C69F6FE0B95F978907E333CA82524	2CECA55CE70B2E9E
pierina.asprucci@virgilio.it	618F3EFCCCB7A5B5C43AC055E4447FB357928E8436391BB4D2EDBABB3D3D10AB70D0BD818A6FDA753453694925074F9A7BECC84BF237C733C2469159DD7D69F4	97DB75D75EC5EBD4
gianpietro.venturi@yahoo.it	62DFB34E92B9BB0D5D4495C42B0745A82A79566F2F6D5074AB0F12D5F8DD2812AAB2699B2AB2F9D882D99C7CAF179EB35AFFE8AE30E16039D424794118968ABD	DE5B90A5ACBCB6B9
liberto.cannizzaro@hotmail.com	FC3DD5D92E0416F5E3FF8464C3D0B624FA33FD4645C135411A4C9ED41BF9130C7F962DB9C6946A30AAD6B4354461EB522EE21A8D40F430E26288C6BDF98D6126	4AE73539C4E0FA73
giulietta.moretti@libero.it	47B81A1E5B7DDC442E7723F45299511F82598324D5124F114F8DBF6A2F924E64179818E577F345A1314FA21CB7DBA7181873AF669C5CAB2E53D839DE9462BB3D	A17F790CEA275392
dante.mantegazza@yahoo.it	DFD97EA0B3FC524E6EBECDADD7DAD6BF8065A034DE0982DB09FCBCF728EB3D468B1632B2BB8AFB02C32EE5D91243E6588E8C1DF3F5C829C02035C247E957B217	E7C90F36E12C0CE0
dario.battisti@hotmail.com	632B3C12AF344CB9E396E230F2D3031EC4AFF475DA08ED5F2265D8339AAEC25AF174496662F34A0277856FFBC6418DEA37E1AC2B892A6AF3B0D5055838A10C02	E7E5A16A025B256E
bianca.traversa@virgilio.it	AFA39E50FD4E5E2120D1455E82F051BDF8196F16066D6DBC726BE3C8B235732F39FE9AA3CBEBD554E88B4A123FAC1410CA290C4CC8813A7C0598F96B3082F552	EA492A57CCF469C4
micheletto.saragat@hotmail.com	C7ECE219290FDB956E4C92D421D98C578436ED19188B0ABF71A4D84FBD5F60F9349039CDA73D9BEEE85CE3EA2D50EB5D8AC50092F24F0CF8BF69EE23DC9B9F4C	9216F01D144C5E01
pierpaolo.cerquiglini@virgilio.it	F5C77209BB6AC95021BE37EB7CFBDF28DB8C0451044BFE00CD91415689B5639E015C292D7DB89A744EE09E28EFABE578B6804310083679F9A2AAD437A1E60381	7192026410A73359
elmo.barbarigo@yahoo.it	B28649B63336FF31ED5F27A638E46BF7A091981AD0E951743D67B35087A94D7E40499E5B4A45D5AE528FBA036D9A17801B93EF32DE9F01F5B3083986D120F893	CB02F311838B0163
eliana.peano@libero.it	14DE9C7C4B29E23DEE6D2A40E725B88D76164788DF44A47096CE54B90CD47FC9EB6EF27F69031C0C00D2A61964A5728774A75C34E81B59B2BD8CCAF6BB52B077	4D7D60D0208041E6
milo.casagrande@yahoo.it	257E1F1768AA93DED47978492C7DCE78EB2F649BCBF7CEF1156AD0978857E86CAAFE37E3A779D5C5B1623CF0E1763FBFC1DDB2B945E08FF293A981B306A7FC23	BDDACCCD75945323
paloma.barozzi@hotmail.com	5D25E63CAE77D37D798B15A9C4CF95806023C19766D975E733296B466F078E79D801A45E8A88DB0D5BD0AA8A2DA65DEF169237A40D4C0753F98EC1CEDABA271B	D1D8C88AFA3D1286
dino.garibaldi@yahoo.it	8E64B64703FBB5AF2B649C7BC1B5350A6CC49ACB33B140E7221664C5F6EBD6F69102C92DB0E8217784692677F2D331EE9CC5664A6E7181991E35DA53B2DB511C	5E52BC71CE8B9EA6
giacinto.scarfoglio@yahoo.it	870445B6F55AC05F3EDDB9E82B03E2A0B4A95676EE5DF2D6CA08002891604DF2A649772FB3AB6D9DB6B02FEDDFD80A7ABE868CB54B6FDE2468691B4ED53C3E40	705E80BB42351ECB
patrizia.accardo@yahoo.it	94E2FD805CFE3A8232BADCEBBA34239E3D09E1FA43A7DB52A9A1F6028CDE35DD2C5F83649607089FEA4305BD75429A132F30F9F46FEB6AD4FC256392CC91802F	4A592BD8085D8BB4
lamberto.ferrata@libero.it	839D295B67393BD16515055ACF640F405754C9F9596D1FB895E68172A2F6F798235DFA8EB6EB9BD300D9DB88D5CD86296446696CBD621E6E07EC48148701AC8A	66877A89C0807E53
laura.lettiere@yahoo.it	6F4DEF417F1AB1E6691FB7F620DE826C2F0076F5A817843FD162A42931C6F78868C0D5B60A0719A6D4DCF231DE0261C2C4C36C92E186E8F20C0863FE04B8929F	7F8CA764294670F8
sante.malaparte@libero.it	03603A8BE60802210884692D65D694B509A38E1CF75D1A7A0061ABEC42E47CB5ECD1D3093C3BC696B0E3314F22690585C365B4D0FFB49FFC5ECBEE0935858C01	04C0E1BC9CBEDFD3
vincenza.salandra@yahoo.it	7DBCB247C91ABD9364C08F71FD6BAEB135AFC87EE5D540D96224C3FB7DA0B2A46151B974CA001BE0633ABE00F92B0F8E0BF9D0A0730391E5E197BFFA6F2393E1	D09656B039B006B2
silvia.camanni@virgilio.it	E2EB501BE6FBCBEF7FF49C261B0D6888A29A29E299A1A842806D30A4504C2363DB1FF3E742B87D814A44D2B789D3A0546F39A4B466477782AD3F0A4F51100777	B9FA47B632BFB6B2
calcedonio.scarponi@libero.it	C70B03AAAC7F6F669BCEFD941BA874C8CA2D80401B61B2338E002DD582F4F7178CBDEC58C32357E49885F5446782FB206B0722D634FC14F110C0854DA825A69F	46768DD17850FE8F
cristina.tedesco@yahoo.it	33BA8AED6194592EBC0086705556FCB29361DC505CEBA21ABCC22D18F5EEEA061725E87157993E5DD16EF43066D7BE52302C0FACFB20118190B659D14AB8E2F0	100A4C97AB62E647
marina.bettoni@libero.it	567B89FFE2121D14A29C03DC11D35631814FF7938A8F729D6040543E651ADF0349E9261D18C14D8C4B126FCEC98824F26CC0224EE62268A53B0FE049FB479EDB	B680DD6FB98B3EF8
diana.guicciardini@libero.it	8CDB96904FBAE8F47E78587E19F2B6DD706A3EA5813DC7541773C786ACFAFFADAB64BF15803BAEEAC2FE3586532241273A19807AE567D12271F3C43FA7AF0EE7	C82E2838204EAFB3
vincenza.turati@hotmail.com	33D9C924B7C115108D950670D4006E3F847562EB685DE38C209918D6F5409947B6F17E6F2CCF602F935A0DBA4093E3AB6A3C729F5E7714545B4E1BE878B16490	3683DD5E04034684
tiziano.pederiva@hotmail.com	35EA430A80592864014A9B1CFA8AE01D86639554E7D24017A6A8A2CD85E1DBB941519B1198B7195116F34BB8A774CEDF580D79652EF7083666334232804068B6	2E85156FE0FB27D7
gianluca.carriera@hotmail.com	5E8C9AE9FC5C627A7029341CAB2A183A216957897A59CCC48DE77D9C714898ECF30EB2093E2016CB543496B82168304BE95094B02DFA4373A09040F270133849	BA90B6CAEED01A71
vito.petrocelli@hotmail.com	4B106AF37ABB3C2983FAC4047B6D8AAECBDDA022B36542D879AEFE8CD30DE06DE6569FFB93ECDE0CD11BF8BE115F0CBBCFAF65C621A33D111DCFCC2571834177	6CE05BF57B65D6C3
michelangelo.antonetti@gmail.com	E1183328987D8777FC61C10B33440E24FE66244BD7B2E9331AD8C633205F44FB30CCB1C82A7DDC9B7CE06D7E1371480B0DE6F870A9A202E838900189515CF73A	3BBCF98EF1EBABBD
silvio.cutuli@yahoo.it	11DF3E74CFD877D3FF3212EF8B31E5E1983A6D5A4943E929C7E281A1815DA001229CCD4F6BB3E7F1F76C48C8A1A228CED54E60CEC8A3061FA1A2811DB4B7DBDF	347CB2C00F432FB0
michelotto.alfieri@hotmail.com	285AFA39739E67D67CD8C570DD51D9FE0AE943D237659744FE7D6E6D0F7259EA6058B5A1FDD0663962D7C6952A246640A53BF1744893A36433B2136664511348	3160AC599ACB67F9
eliana.accardo@virgilio.it	3C7DE5163F58A8B6DFF16C815BA7FECABEF7D9700D70BB64894947C9B04830922A6F8734871E3B178BA8E99947C9D8BFF88304D01332E1192D1BDC9BF47A032A	DF2983043071938A
patrizia.cutrufo@virgilio.it	D762CEF5E113F7776514D6DA84505A4098D3E554DA88562E4AF8D4862AA519FDE9F29929C92C3293D14789110F018A826EF7DD0B3A520237EC386A1C5049C638	5F2230DBF21BC76E
gioacchino.milanesi@libero.it	1C512CFD05EAAB2011FC44763D43D886B295EC8ECFA457AD0D012F72D9751FFE8650DC9245CA0874F66C8152565FBCCDD7900166FF1128C6A4E548141D26846C	9951C61752E804B6
alessio.giulietti@virgilio.it	C8C8CFA078EC9E10631B5EB54C6AEB1FC1B3D8CD3438B0210886A6C9DC0D1C3E3AE382D3AD7BBFC3C6266FC492903B11D45D2A2FF0FDA14B6E1A7DB7F0B55671	41D89E866BFBFED3
nicoletta.gabbana@gmail.com	2F897949FB77EDFD539F393B012A0CB4944AA596A95700B5D295CBAA0DC6EF6A96DBD8A608C4163E6C89650A0FC040DEDC927E584DBF26F4D1F101E7C31B1AEA	ED3AF9032DDB7548
ninetta.spanevello@yahoo.it	8372647E0CF015E02B38519F6EE595425E6BD5C5F1C4175FE16DC4AC24C255674B3EB7C820EC4CAE869A170532270EA850379293C5B86BE90A912FE9FF50A824	37DFAE0CBB1AD4E7
massimo.sermonti@libero.it	E66ACA724C7403632CB24603C8FDFD1972B0DE756AAB0FBCE2BFE482B72EF3995E172364DBC2510C60BB605989A20856681413FA930D19BB5D394CF5AC80739D	2214AC09108FD102
angelina.trupiano@gmail.com	76408F21F71974C7B229270879EF54DA759A5F5204200B2E5C91D7D8770E6307A5DE6A46B4A87A0B2A90C7EA6DB5C8DA63C6591294D0ED3463DE552B5ABBDD0E	3A7DD08062522334
donatello.varano@yahoo.it	793345878DBAD0C25184D30EBBF528656E8689FCDA47679600EFB3FE2F98EF9072300336718EFD7F0BB5635D9F134764CDC5A761E270C1EF94A765976DE72331	4A2838BF2700E4A6
elena.agazzi@libero.it	CBA23C75F38863938F627EC7509AB86AE43CCB2C56BE577FD912AA0A57EFE7EE137F4170EBCB9D95A72611B5E4F52CBF9A662ABE205549B6028B3AEAD77823FB	49E8789F06775457
francesco.fischetti@hotmail.com	5302FEAD56C3671751E964DFCB0A5ADC25DC63B01BD2C08BEDF73F4865C45F9B6E3EC9E553206F2513DA92BE3605F8811319163725EC355A2EF7CF9704D84BB3	07B58B08A90D2C72
zaira.zeffirelli@virgilio.it	9B887DC98A491BA551120CC0A767426A9FC263E4F4CF973D1DE7B4E48FE2787C7BE5FDB08DDC4ACC9141793C4A6B285CFC45EEF84635EBCC329B8545530F61ED	4E2DBCAAC355502D
ricciotti.nicolucci@hotmail.com	1BFD3C0F66DADA1C35A8EF39CE50CA64EFBA98B471E955FAEE8A633F4A8639D24B18C6F164EAC0B1C73A499688279A2E78A5B58770B00B25C0A147D846553B48	AE8EE2B43D421F60
lara.grimani@virgilio.it	D5015506A5DF44306511D5FB25585D04BF9FCAC61CADED8DDD09CB51373BD88B57E2DCF27B57DCE0984695FC699EBE5BA1CC5169F77C491B15ACB2A504626CAE	C9328E954C47B6D6
piergiorgio.pininfarina@hotmail.com	EFD38222CCA8D2A552D9B976F320D00DAA2E23095494D0A76D65ED4391C9AC81DDC33149F32AD18E5D531432B49BB96CD8E82CD41959368D4D104998D0B204E2	38EA4D8AC7ADE752
hugo.morpurgo@hotmail.com	651B234B7FC6CACE01563E79091EADDDDDB31A3DF241851D9699A61228990ABB67DB3C701FC51D6972F459E7C3A425EDF017FC619A74B6F95F56F8AC30D892EA	0F2E401F86288205
lisa.parmitano@libero.it	59725EF9E6CC16AE2ECB1300F587D880A351223116C112D2B1E0C7B0C9CCBDBCE8EB5DCB0EF6DE9C81B333B6D9ADECA0FD48B308D46ECE37E1A5D93752245223	2975629B5802852C
flavia.sobrero@virgilio.it	DC0844CBA91A64DF485D6DAD53E0A07BE7F086D3ADDFF179AC9DEC4C29AE2EE0D87FD6B213DBF2780A62E14C1E38D03186D8DE9A7C231F2D3E4B73696F514DB8	625813EF2C989AF8
arsenio.cortese@libero.it	43D000241112860EDD2E263E4515CB122C4D3CB2143F55784ABD7839C6C449877BD37C765DD1E5D9A187D5F698B663EFDC780548ADF3E033D421018F1A748047	50F6EA087539BE79
roman.marrone@libero.it	CF1F1AF8F75D35D172C481D7E019A18F64FEA036AE39CA212A413E3C82647352265C03D1D7547D9CB8FC68FB3BF1ADDAB2329914F15E4458B8E5BC7835D2B259	90F2A2560DCADAC0
costanzo.bosurgi@virgilio.it	9B0C8156F171D0B7AB10BBA1A86D4659933DD14EA2793E709190FFC81DB66E2A7C22049421E169D2D3FC0B58D5DCD53AAD414472D6BA53D3C4FF0B60B83829FA	9E2AB2DC45E9078F
paoletta.crespi@yahoo.it	23F9A2D0A44B67E4D6B5F9672F2E83DB310C03BF9446F8F5145E228D87E2FDAD95F79898583B919C31E61389FE630438F5253B2BF535D57925F946B31BD2AB74	192B1AFC7FC77D71
zaira.bellocchio@yahoo.it	825EA3BE7EB0D2BF6C4713864BDAB93DEB544815887B851DFB366FC3C3B02D85BF1EBEA24C1D0EB6AAD23A3C8B5B7218918A69B333905095FF8106B5A1CC8D95	3672AF0D0F6ED0BF
manuel.lucciano@virgilio.it	762A8E90A1BECE9DF5FA47DA855CF3BCA8E91274FAC011A22B6DA9F6373EC09C6BC37490448DF80146140E134442612CA45C79112841ED5BD6B441030578ED1A	C33C205E4F1A28DA
milena.grifeo@libero.it	9C0BF04E1AE8E9EF69C20D44054B78F8D97802BDCA336B3075BC80D2E363314A6A2F642D5F2DFBF328051A7D1EACE97D0D4444E6C5E1CAC08E84FE39A1AF972F	ECD326521FBA3F15
lilla.ceci@virgilio.it	63F2A2DF48357392A02F39F40FC7B034225F37483EA74E8E148E575E7EAA044F74D5F5AC377CF73608AA85C24A6A8512F3383F4B067C4692F0310B58BB3665A4	42B5AC5BBC1ED6B0
roberto.lussu@yahoo.it	0EE8A67FBB41A9EF622CD9249CF5DFD3610FF594CE906F58FC5A864221ADA5317DA273B00ED6C6050765660DC078A1FA5095E59A97CDB4C3C511D46028806DEF	BC5E6782A632B5B3
bettina.scarlatti@yahoo.it	8FF08D8EBD209403650D38C509FC5C2DEDB4ED7723C631A10CAF373DD7B69E00F36E2D8A325FED0B61566D08F80862D963EC3F7273DFC263D9C86F4B33C727C6	E5796D181BCBE205
gianfranco.angiolello@yahoo.it	A39873EEFE118B8A5D01F84DA8EA1DD3BF8FCF53989C4F46493B09A0DEC2137D618343E6A5ADEA212D128313A0CFDF5B1A3EAA7F8550B1F8671DFD98C24E14CD	F94EFB754E245B69
antonia.ramazzotti@hotmail.com	B7235753E4F8EC0EF7DA164D59957CBE4E39F6CEBBAB9AC3F815A4B5A29F96BE574A72F0A718BB12882D078A861E3C4CDE326CB8B0F97C65D85211CA885F25CF	3D29BB861F1BD585
luigi.borgia@virgilio.it	FC059A51105A445F4A848771302C590AA25A985F84F8E6C62E9E89E70416E49A12DE385CD7098FF8C9439131241C143C2BADC3842CD1D6D2E73AEC338758BBEC	62F808BC04323987
paoletta.pirandello@yahoo.it	5CB5769941B0F77942EB0FF58EAACBFF303B7B79925C01376890457BA0779076A17DA40CE0D69EFBD0BD436D0D841A82F89160ED9626883FE2A428A0EF994A73	AFE7CEDB21482344
ivan.fantozzi@virgilio.it	F312204477D210A1BF6F3D70C888702D4870231E1D2DEEBE87439B72DA2FB58DA183529AB878584E259C2BB4EF337747ACAD3BE59D0533E42F7F84181CA12664	13DF7AA64969C2CB
jolanda.marenzio@virgilio.it	F06372F9D83A1D3909655B5F2B12E4FD5754EF6F223D31B0F1FBA4419221F4E78EE3C4163EE85A4C82CEFE1252CE2A6AB57DBE4BA18691E5D0D108F696D79D6A	CF1BC01085CF6067
arsenio.fagiani@virgilio.it	C4CF37554B0A6606B99EA93AD0CD77779C2B9DCE7D4D0FA8F85E2EA1CCC3A7D3EFCBAF85C8C0A5618B319E4DF062AABA26643C88A37DA4452C9BCB60AE42DF01	D9B2E50BA2640B1F
elena.cortese@virgilio.it	356CCE741FDB98AA0D8D7440BBB56ACAA568305DCF1FDC510882099F0BDB49CE77B305E94434984E672A7A290D47BD6DB5C3B7FD51C864E76889EC8803DE1DB3	F10BEA7AF36525AE
salvatore.togliatti@virgilio.it	D7580888165E00E5E1279B29AB826997CB69E84B68DBE00D99674688F6A3F6C45B0E714D71CB2E7C5CB983333A5194F5E0BD4C645A5CC4D1B960C50CF4AA6C6B	BE48C87A3C2AD3F8
dante.chiesa@libero.it	9159DE530A0B50BE33A20D65EB89E3F77F2EAE3658F019515750ACCDE505E3DE583CD635078F043B6C90B6ABCD0E7D1F02EC5B982F3EF01C598297579153F80D	4A5F381F08B9EE14
dino.dallara@hotmail.com	A7D957933C170E4EBBF4B6537E72AC6720714D532FC4BBA6BB98AC3C47B65BEBE40E05D075CB5FEA455ABE8BE93E2ED40FD7480CE35DB99ABBF9C72E66403681	F6710EA0F2107A45
simonetta.zaccagnini@gmail.com	DB3EBB15C9BF116EA0E886C45DACBB22765ABE80A0FD8D9CD2D0DEA0800830833D0CE1323F26B2C4F4BC14CD0A327795B1F56369346BF1B3184FA9674919A25D	4F805805A2F50B67
marcella.ruggieri@hotmail.com	2D4F78895081615D963D50A7E144245367F2E7FBE430A2178702EDA3331B800664444962C9090B10092CB4EF7CDB82EF88989A51568457E213A4BA7DA7F2E0C6	3844FE3FB5C6F694
diana.scarfoglio@hotmail.com	9D3A8039508D6C1563DDA502F47D4ACAC8BCDDE9B2B234D258B1E4F9EA1160B927B069279FD0A243F7E36974E1DA1273240AE56E2A0B14114A13B8C4E27E8894	4ACF7DBC365AE987
goffredo.pagliaro@gmail.com	2F0EB4EB05F24BAF974DB41E7AE4DEBC42B7365B53FA5F46153AB7B5C4DB0A4DA90DDE8EEA2B547D98B91124369915154D4133F86642E9AC305E5A8B9D362EEB	EF3E0914C8E52556
giuseppe.garzoni@gmail.com	4EDE1549A503393EF598AAE71BDB47CF80AACD7514273A939DB27EDC518155C28D51102C9E6B88DE19B95521AE311E31D5F93E20ABD678DCF57FD0582B3185AB	4220D834511119C6
veronica.pietrangeli@virgilio.it	B0D61CD81A86C6D0A2BE93788CB8AF545289493DBF0668F4DC540B18F96091F8F021EAA3243B29274A04FAE107A03EBCA19ECD7014081FE8B578A9190C577E39	93A6351D0816668B
marco.papetti@yahoo.it	854F61433D62868C93633D45F2C862096EE48A7C5BED08E245B56121D95034FE3C834AF059CC975CD846FC2A6CBA8131C7FF2E67782A6791900CEE9002DFC99F	8707C5C657F33639
natalia.zetticci@gmail.com	254A6C344DB0BEB612524C2E7BF81EE999B08EDA3ECD98107D62FA8600B54AECC7EDFAE635F4B5E1F5FE831077CEB4DE99B237ADBC4D30A3668E1D9F4DE93691	80FDFC20DBB4BBB3
ornella.altera@gmail.com	60860EFE472365076475AB91E96F332D712CD09F35A2E3D4543D393942A31551AF4107CBC38CEDCF104E6FEA329CAF864703EE11D4AAD697144A9BE2C06384E6	1F0294260F5DCCB9
marta.guidone@virgilio.it	109868F53F99DE5CB41A1627E88E42ABE02647042C828B3B26AF3D837ACEE22568EBE3DCD51BAEB15B3E7330C80A5049F7BC6CF1812DCD85C87B9F176530F8F2	FF479EE37015498E
niccolò.blasi@virgilio.it	92D5C0E95A6F8F1BEF241472FADBC7BA8E1172D3D182755F6C0FFE5BA57AD0B3C8F64593044DC439FB0CF670054A8966AF366E5F21E33E2FD89D662FA12CB440	07E0E0DFA105B30B
paulina.pizzo@yahoo.it	C0EF1CE4E25A6C3712121AE179A65BAFDE7C7BF9118BB32F2993EEB9F51E946134E22F1097B65FAD83C70F19CA02F758D68D747E0574690CB4C4E84086975258	596A3E2327D9566A
livia.agostini@libero.it	F523B7FF115AB73966A62374F98B59DECD08ECB56D45DAAFCEB9C20C16491C1A36EE4A26E1D80C47E8DACABFC5ED02ECC4BE5C810DFA3474042A082E5AF30348	FC7FDD824EE06034
bruno.guariento@libero.it	E44D7C4A762A7A3B30E3095BB4525A4255E7734983464CE0E329A6CB7AC74E685DD5623C2BBA847AE98AE1BCFD05F2C73F6CB7CC077EF59151885A523B89E26D	59D1F23112508469
graziella.leone@virgilio.it	C134512E05E0FEFA74D99BD2BD49CEBDF7662139D5F81F6B833881A046C32B9CE1E3A5E22BC7DC01005F34BE7C887D77EFBA8208BBDD26CD21C0C3CB25FA2A6F	2040CA0ECB7ECB1F
tina.monicelli@yahoo.it	CACEDBCB7ECEAA8660B4275E0FFF9A315093CBEA137E621719D1CC9D5962C8AC26C104AE4F18DC24ABE66C44E35369800F9CCADA4A4E170A56BBA6B52836AB73	A524593926F180A9
leonardo.chiappetta@gmail.com	CECDD1184E3FC665464BADBF2BBB90BA58BF3DECA0E0CC9AC1D6CC48E07AD8265D31C009C39FACB5886B093B32507761E0AF6F3082CF28BC7EA70E1CC59E4D75	16A9FCC96D34F3C5
piergiuseppe.piccinni@libero.it	0B9A5B59E40CB5A60E77E096F542720E19B1E70CCEB9CC1484AC67F694136CEB3F1F7A0742C29B7A2979E108EC67A68CE7624605829B5A6A698B650CEE2619DB	1E4AFAB3555AD9E3
annunziata.badoglio@gmail.com	7D309FA49853E56DA4A2DDBD3212FD5762A13FB7966FCBB35B61043587B22929CC530B6C2FBC7B1A44F33A03E1B9A6DB030103D6FC02AD1EC6E1538265334E80	7543E997BF018E85
annunziata.goldstein@gmail.com	BEA8A6A248D1FA53E1CD891276B6512C2B8D9F0B562E08F4EC6464DE81686356AFE29C1D634C47CF33AA0257F8F0AA94B1536DBB152DEB9AF73953D3A6BD3132	A7EF8DF9DBE3F87E
stefano.dulbecco@libero.it	F50C5CE16FB50F767443363030F89161218CC1FA8CFE2D28BAF27D5FF84244D54A9A5A66C98855E78920C2AB028D8D27FFB0230FA08372A2A8AB83DE85FF6968	DDCAFC49B4A5B2A5
federigo.guarneri@gmail.com	75252C6E243B7FC5F5776360DE6AAF26238CF9BED3F005C97E5F8A36777128451A3A5DBF9C9985634C7E512861CFFF9E69A6566CE8A6522A3B4A6E8E9FD5C850	DAB406C9F678EC49
sante.storladi@virgilio.it	FA71D2F9D10DE2BC9604EA4A1CA262D96B6B55FD5E473DB120B9E8F0ACB1C3935F02633D44DC3DCFB1A1279041674182E28161F195B1E0083820D831FE81455D	FFB661C08BAB02C0
eraldo.abba@yahoo.it	EB8DA42310818AEF1531C6C8C9CF329288477328D7F906A8C9F1F5A29BBF8F53EE6CD8364FDD8C582CB66E0B28C60BE2B3C2F7EA7F79530AF40C717032E7955F	D0DC124F0038CDDB
massimiliano.fagotto@libero.it	907150DA57680EE95E63AB78E6DFA1E11F42EFC55B17DA396366BDBDBE700E78754A26F9B7240D6BF8B2FD970264AE8017CB0A112F3E887B075B46D37893474C	58EDAAFAE287ABC6
giosuè.vigorelli@libero.it	E9FC1752D8FBB5E2625A339848BEB497F90BF17F1D8D9EF0686B1CD96A66E6075F82195253DA4C6B1FD0010324FF8EC7BE641EB8FEABFA791E094071A6CD90BA	E7D56C84F605341D
vittoria.gucci@hotmail.com	E60952444E2D05FA79BB0051631A1FE8D8050B7F03ABD88D7948731915DBE227E0B17A6CD5ADF1F073EA85C6A80633651B864DD191C0A1015D51C33300F162B4	B2DFBCF9E9A777C2
fiorenzo.berlusconi@yahoo.it	B3E98CBAA9909B0763A973F72FA028DC355D27107B0F647E07B9ACE01BFECB11845988C326C37B4ACF93060F655AF07EBF19E9A971C9DB757FCF13FA8CEBD6D2	041889EAA3ABC965
stefani.castellitto@libero.it	90A53E1380687F6DE048A654257496330DA5733FACE67A2678A22FA8CBB6AF4B3C6D35731069E05A90A46787E7A1CDA2F09E0E8577735CC6994A9FD39BAAE616	D9C3226F5B59F12B
nina.verdi@yahoo.it	4DDBE19281D140557C110624A7592096D56CD00CF5033C193BEE982125D2C8E92C84C5A82510D4E5A8528217F5052C1A6306B1C0479F12576303EE48A07FBF59	3D6D68A5D34A1B5F
ruggiero.simeoni@yahoo.it	138132BB3811F0DA97D3DA930334F6F2B24DC5DF239EE5B227304DB796A2EB74B3664AAB15D4258A4428934AD6290CBCF843E9A839332CE560D9330EBF553B44	B74AD4BAD64B6BF0
michelangelo.garobbio@hotmail.com	14CABBAA1F14F01674B68D59DDD0412DE6DF1B34EF1E75A9FF4D36F61F3ECB34161C8B34AAD439D1CDC8DD815CC4A493A86EF6E042B90B2052715F9F9A40C6D2	B1F874871321CB2C
alberico.marcacci@virgilio.it	95E7BEA76258F1B163498EEF1F84FD8412CDAF1449C7BD4083F8B5B9658A344A656220E8B33960450BCB67A3CCA1648EE343D4B5D7825FA1F8E2F53D6C5058D3	F9003BB93BDA322C
giovanni.flaiano@virgilio.it	0EEF1619014C8752090814E2E183A6657CDB1C6665A6FED714B734645585A97C3BDF30DC9D2FEC007C869B9512E926FC095CBAF620492F17D366203C874286F2	E106C94545FA0075
melania.bruscantini@virgilio.it	B45ED87133B8EE8955E5D5E2CD4E118CCC2352750107B2073504B033D2B76F55925711AA8C33FB385247CFE6673C715BCFB6A0B8603B1421885C44F235FD330B	6E38FCF994FF17DB
adelmo.stein@hotmail.com	801203A87734BD87BD0C55488F0C112021F3AB11DB8369B73D4413E22ECE56E35042783476D340ADFB5179CAD2D7E2107C7124068E6ECE7A336274BDF3CCF4DE	3EA7994F81FBF7B4
cecilia.baracca@libero.it	C20D25E882729C8AAA25CC025A002613CDDC767596B5EA072FE6B6240531B42EA2F628879081666D621D8EAB3D502E0811F232FA95EF261371007A4B3BCDF065	F8633A66F7BF0BDE
massimo.troisi@hotmail.com	7C1A2C9BA31818AD1251FBCB4507A765FEFAA199BE18297A458310040814C2A808F418FA361EDC191BF5A124DB7129E31F149E347681B6C8AD3DDF61F6A642D7	F048D721653F7537
nanni.saffi@virgilio.it	186DE9EA602870DC89BFF77A20DA06D2486AD39004B0AF982BB899FC0CB50ED08119E1C8A49978F7D3DFFCA52585C8FDAFEA6F8D1038F082E709CFBE97C1BAF9	4F68CB29E21D30A6
carolina.malatesta@libero.it	70A7799A342EF98E6602D94A2CA24666CFDAB8E2771E3CD9DDC0D1BC35FE759C512F0FCC2D50B4D868F888A66E170EC66B3B91191B7DA6154F8510F12A2341B0	E0A54DD3A25DB103
gloria.staglieno@hotmail.com	31C4160722826D2E46DC1A0492CDADC9B8ACBF5D5AEEB17B63B15343B198842B1DFF5615D3DB58FB0B9DBD3723676E7AE8F4B9902166114438439E6E83C03DE4	5EE4226CCC7D55D1
fulvio.blasi@gmail.com	96B498DB05A21C2155CD35BE7AA3572D691C2A8B9C996CF885FF8456B17D6EB06A7947D1F74FD54F06301B3F3132F7F3A44B4067F54DA0ECCC3B57DC4668F205	1207D225C1B0BA3A
matilda.tutino@virgilio.it	266DCCD9F78248334B4B86BEE57E3EEACAE3DB7FCB3FFC26ACF3A3D9EB5A8410D7006D998F463D3A5DBAABC67D7174D3F8339D1E8B6F36A1CBC976CDD76069F1	7FE67565685127D3
lucia.corbo@yahoo.it	7EDC5DF6FD99F340014066DDA68699FC6F5BC9E7D6EEFCA81B896C7699700AA9563FA3C72670161ACD8C63F54FB6737888A726CB0C842E407E5BF5042ED08FCA	75E509F0A2432711
martino.falcone@virgilio.it	01978224F6E7AD88EDE3000A79D8D18A15723C593996508C2505FAB55D08654311E778F5EBB6BA7BF87DB7FD0ACE9F740A94523E60CDED9A39051F37C9C76CD7	52948A400094852D
silvestro.dibiasi@yahoo.it	A558E97B111FA9E24210148B813B1B91DF8829D9C79CB93F1F8056E8AA654AEE0D2120039C6F4E2927C1934842B91AB3ACCA5F9E5E6C4822B7FC4B2A47DCAC31	E635E13D1D12EB71
roberto.guarneri@gmail.com	5ABA66C94C087D72F2DF1FBD6309EA404BE324990CE06275E861C9AB920616CEE8475E1DCF6C877CF5CA7FCE19A2212A82E740B3E0B6F964DC69A71A445124E8	6047EF8710F491C1
salvi.renzi@libero.it	0149D84F08995C12311DCB75CA9D3FB30C6BF0E02D6AD6F70B5C6580B061EECBC65845DD8EB4CB535E26A8FB84057FC87FD202D3507142B1B8547FA8D44DA378	D9F893E76CA4FA51
rosaria.dellucci@yahoo.it	7874A32EA6B135DC3767FB36EBB3D0687AF1678F14D34B75F02F8F67CAA3FE2D90B25D4E73DA99F277B6FD13AF57125F3595FAFE925AF7B8A8B6B402B14E5D26	BD3A9F13DBE14E7D
luciana.argenti@virgilio.it	583FB99562E21A65ED513D8B9B50D6BD300B2DAA4C24E83CD770BD5CCECD5680E01B65545F78496E30FAA2466506C2F6B68796E5DA9326EF17687D6BB235B1B1	AB7C0A7FB9A36933
sandra.valier@virgilio.it	D33DD380441B90DC2D76D1562A5FF0E25AC7F75DC83CB04A04D8D521FFA8A026D1E9F58231110CD915ABCAB16CBBC6747FE87C88A15284ABB3D8B198A47DE77A	F560D5E4E1DBF3CD
corrado.donarelli@gmail.com	592789AD1907C6A556682503690A59CD3A61681CB5AE3FE5D9EEB6920ECD76D0540D598704FCB38D90A4A66BB0D6D257B50BE9511666D2D08518FEC906FF792A	9D16234A3A4D1861
beppe.campanella@virgilio.it	FB8A5BD125DEEBD622DF9324FFE96316983FE367C456C1B680265A33C327695B29BE6832E70E43C170DFF3DCDC1EF287E54BB3419476E9D001F352477EDC3A20	0B392FCF3790F65E
silvio.morucci@yahoo.it	21006ED0772D548630FBC103DB515DB41F72492AB5E180689EFF612029B2C96F6A16C1D01876FAA4254B7C4ACB7DD0584D86D76F07E712178E8187C5DB58D8CD	69AC8A6B3B77902F
giacobbe.filangieri@yahoo.it	ABE26C305EBBDFE5ECDC50AD93053F18A43C9594257B210CF959002A71A6D90974241DD8E3FF8D3E4234C64AD51FA7C05C3AE6B144135883A7A13B473C14A728	4569EC9DF00D1F48
luciano.sanguineti@hotmail.com	F1ABC6EC4DD44397F114E2B706354FE0573CE65EBC685EF0C2EE6F7E2B6236DA53D1923E7FCBD2F6273C40E3498CB7710612C33F227D2E670DFB0E887FC298D5	6C8057BE79CA8BAD
mariana.tebaldi@virgilio.it	42CB96B448C97B61495F045749CDF4B3EA8059F8F97F53EE30FE8D97D8A9C6133A719AE145CB08EC81C3475F070B7DE82255A9FD7C0C325F84D0891A163DB9E3	A375FDC6CC1E8493
ezio.contrafatto@yahoo.it	2331E6558D3A0B2DAAE3E68A2B69182A122F88A2CC94F8D716B1747B119BF1A6D9CDA4B427650E9735A51AD581DBE147B9375BF9F189B77137758D1E42544C77	FD55C7753D82D115
arnaldo.guidotti@gmail.com	90B880CABF9CAAF2AF0D5B9A3D89054085409C2C7A8999BD290EEB3EAAF8DB5BC47625430DE11046C706839D6531161881B166863A96657F7D42D963D5F5836C	4530AD9C6297FE72
pierpaolo.galeati@gmail.com	2F9D6E158AF63249354F3931DA10FCEE1951132F2809B85FE2854DF0EBF101CE3CDC08465667733240DB12AD74FABA9A6A23B945171F8C56A71C91E909A89241	7AC044B5427524AC
ernesto.dallapé@hotmail.com	9901EA12A06A9105EEB85A36F592C767CDEC5887FD2999A8F127CF647CBA1DD7A67B08D07E2E6E51F736C63CB353CF10B952AC30478632257800DD2155BE292E	849F6FDA6381D7EB
leone.marrone@hotmail.com	E5A0C8C84D42D67A66F5FD5E690EBB172D781F20346B1B7AFAA7B1782E76AD32782BE6FEC7601FB7DF259547EB07A830088F3DC21039916E92DC7BE19197C8F9	D1060881EEE6C83D
piermaria.jacuzzi@libero.it	D4F7CA60DE584425C8A9DFF2794F26D53F2BA22D5DFCB5795F0F6D11FBDB993FA7253529DB7EE4514408457712A59907C4B236FEFE5E3F4B114CA25BF9003183	9D37CE3C69F49112
annamaria.mazzocchi@yahoo.it	E6C095EB57E726C266F0CEFD6F4E15C50FB95251DEE40AC761B622CF4AEBD2736EE441F8E14945390028132E77AB18C033618CDAA05AF82BA13CB82DC28AE3EA	38B25361207D1926
orazio.paolucci@libero.it	0A5D444BF3E93434DE0C8E4578EDD9F203632F99804EDF53F65B4A155D61C0FAFAD265C0E9B02BD8A9D53EB2E0DBE9BF26C858BACC64B85C72EC947268DB9FAB	0E25C1C422F3B43B
bettina.morucci@hotmail.com	FA67705845074B66C9220734D3631774A6992EB783A9FA62F637AD9DE7B0B5AD2337651CE049F1DBF72E3FBD80D0F0CDC06ED8A7C4EDEF4EEF0326CA037F5D5E	96241666AD0B3C7D
lisa.carosone@yahoo.it	A04C062750E59C5B02619D919B9ABC7F5DF06DFAD7AE3762C6652AB3558C05F723AAF80F1F32103673982A428C71274CBEB55ACDF7134E71B7663352FFDF2367	7CED044CFAB8EEA6
adele.volterra@gmail.com	6A9AE38C286EDEDB8E79D0DC089AE0927AE3DC7E380AE3508411B3DA86574B6ECA5F2367FF8F9D77582202863A3EEA083A1F53144DDC1FE6977DE8D1835FCA19	CC7D26398D1717E2
lidia.leonetti@libero.it	1042E9474841D4990AF523A84A9B676B6B78D96D1BB5DC2570836715BBCB34F9A83604E872BB474124B9431811ED996C47A47D591DF4507CAE12F52F1AFAD5E0	350C1D30090E8E3D
lidia.rastelli@libero.it	4B622FCAD3910DDADB10E82BE3EDCB628934255779407F7C7BB6FC897027C5A557C1CA8F081C0A9FE183613E7F79D3335EAFE6B26A3939C31CC854459F567CF1	AC4A44D482ECFAD1
rosaria.gussoni@yahoo.it	A345653AD8D0D0F0F09B207B92F7DA6209B0FD7A04D297A3158D862D7A9F3D49A743E97067B409B427BD787BA28FC48FAC7DFED75FF15A0DE921A392CF201528	700E8AD0313A15DA
luca.verga@yahoo.it	5BA899B591A94094B3D4FCAAA6BCC6627CE8D1749DFC76A71A58E9858CAAAA50B323D8EC8D9C9E405A4BB4304664BEFB477CB6FFBA3B76DF1879FB0498DCDDDA	7431DAB467666A1B
melissa.cipolla@hotmail.com	1784455165FE5832F9629CF431EBA078EEF9A1E2E51D87030A7DD002C24CC0280585D6DFA64D59729D73334D47D0E1C86456E16162EBC3A2FBA277127A1A0B91	C66BED23D4C81298
melania.necci@virgilio.it	6FE9A46481A981A68070A87CCE68B6AD9EEE39C31FE73898A95BC44D1B8CCF75E16734144BE1FF3AE62EC3D2F6EFBFECD18D197FCEAD23CD8F9CC3E892BAD750	62F39FAD65EA0D62
fabrizia.fusani@libero.it	4C3A2C484106321DFD821D6BA135527CED4B88B42A595A7BEA12C2D3538982E13718CED9AC5A0CF01E260434CFBA72A5E7118E3EA0AF3217E692474745BA43B2	EF19F70CB26F83EC
francesco.basadonna@hotmail.com	4F14DC22E6E2EF06DEADDAAB29C6D28AA4BE564E617307776FEDBBA90C666BAAE1E05A98C115922125AD6546C5B01A0F087689636F1F9694989D0780E1E424EC	81F2AA3EFAF092CC
aurora.emo@gmail.com	C0AA544DAFAC5C5A26BB446DDC5D6E9646FD571825254BFA55280C0A75DA83B2D3CF4E4CD9BD7286F39656FD0650BF9EB918A2C597F0BBBA08CE8FC88954DF05	2B46F656E8107824
francesco.tropea@yahoo.it	0CE079EFF57647B44427083D09FA6AC07D881A2FD767122F8173743B4D104E627289A8B1AB21667BB56FA69A3B5369DC3EFE6C8FF5FC1E7F36260BC5226A62D1	A2DFD224400A59C3
ronaldo.spallanzani@gmail.com	0B03EF89BA0287035670573D1224F84FD7969BA00D4FAC45795B75D2E86DF4CD6A34C461D7AFB5175E83DDF0F6756D9B98D8130953F2D119C8BB1820B0E016CA	70FC2ACD7A90B549
antonia.bellucci@gmail.com	49CAFB1794BBFF43AD669F21C98269EBD9FEFD0D00EE8F3CF12FBEAA2A16361086F4060C106EEC7024D970E15D0BC5B658AC4EF20FE1AD641BD2D037C34BDD27	47501A399E056617
agostino.ceri@gmail.com	514527DC6358AC2C1E4C16A575ED2BE7CD0425E9C31CD0E3A0AF5BE8DA5E868D39C43D12AE512CEFEAA95C916FAD566E43AB2D172F503E7D755FC2D52343E681	FC4ED44CADB350D0
eliana.parri@yahoo.it	FC52E82EE958A5ABDDC9A0D4F52383F4934B05DA753CB3828F5260389F8C00166D83176DDEF4516CB0885AAA53BCD340EB45C2155DC7F17168D9134D823FC75F	77282BE247DFB993
giulietta.troisi@virgilio.it	3BA5DA489DCF5CE7EC0B00619DBF35024BCB062EF078B675D5AB906E212E1DE287ABB91144D8ABC8CC19118E4BB9327D80C9EF337D14AAEF852E866A235301F2	4BED6BD2D06EF47B
gioachino.argurio@hotmail.com	7270704DDA4CA993BF38C45812738C886AAFF555979FF87DC80B4742DF5F0B345B737E5ADEBC15642702B0A229DE27AD6BCE1E31CFE3C62141A939CDC15FDE00	3823A8D1E284A204
tiziano.ciampi@gmail.com	B8B8FA654D0EFA1FC7D565CF42264A64C81481F3D513BC182D8BDF20B6192153261C7D7F6E04D1D8325D9A7813D6F41A29B86B882B6C2E4630B1E8F227CA3EBB	1F226BC558DD2D2D
livia.sonnino@yahoo.it	1575A8378906ECA4136C5FE734451D7B1950ED822DFF339F840ABA84C32BF24D7806ADED1873A6E856E46CC277F313CFA56DA32079F8483EC0109EDF8B46644B	4A29B42B5F05DAD6
susanna.viola@libero.it	D8ABEDE8BBD3180413943CFB3603EC2829169D3CB804EF68F4D84E38691FAD72A040CD12E2DC2173A0BF92A2914EA6ADE87343845FE5ED04FD1A4AA3E34B65A1	7975B2728C85669B
aldo.morabito@gmail.com	60564D4A52276B4D6DB2EE02B6C9CE31CEB673C5ADC51704F76B965928B4D4BDE2CBF8B9804AAC656970966AB3C63202F2AEAF76721D60AC8ED67A01E5354953	51E1EA731FB00F84
toni.trupiano@libero.it	B789A553B755D1BEDE0428EB07FC10352B11AEE494E0A747F3CD77D24F4579C0CF079753CB5DFF79EFD9C8BAE1B896F7287959BCC70FA85FF5FC17FFEDF55F5A	215FDACAFEE5E491
cecilia.costanzi@yahoo.it	A43C5A312188E107210877AFA60BA07F36AD6FC493BF76718E922CADCDA64FD56509BA20EDB407FE08ABEDF18FB22A94B5E595A81388A686A6CC1A9F41DCDB90	14F6D1BF240C0242
annunziata.disdero@libero.it	B12EA6A406F98392C02CBDFAC794E446C2E2CAD6AB151B1923D24B08DD1FE703385BF43565514965243CEB764DC3BA6C5E597FB8565CF54CCF4EC433E9599BA4	4EB6680B418246D4
coriolano.lattuada@virgilio.it	6461792AD4E91ACBD8506446CA5AA67571BBBFC2FBB277DB744ACDBE36F271A22DA2D935C56C422197E2661184C8CE5F9F64C767DDE53BE320C061A5C5119FF2	2B447B868129A8B9
ramona.bonaventura@gmail.com	E562956927D3C63B0D75FDE364C3443A1D1EFA0DAB0C690F6FC032347E5C42FBB6BD63086C44E703770F16E7D04625239C212DF370EE77D569AE3348D312061C	C855B8AADCD34D87
osvaldo.falcone@virgilio.it	804C6423C86A3A6A98842A9511E55BE96B12B1157FC8E9C8B598F32BDC765D16D5DFFDFC4149EBF454907DBD964FEBD4A5CDAC7C0E1BB60F5A60069F3BFBA313	A7AB22FBF19F81C7
enrico.santoro@gmail.com	7630210A6358279FB1D2EDCD87B169BAE95BBAFEFAE0F854F2C11BD82F5708D2CFDCB5081787D78AD2D162D9366294181C19F8C3C2A60229854AA6895D0373A2	73CFBE5C2C153EDC
galasso.baglioni@gmail.com	22C8C48F9FA9BC470E0397ED91E9A9778486DD771642A730EB05203BCEAAE5975167FDFC8FCF0C4ADC016F5EBC59B8CAB3FF9B9099395B7BB1F3BD36022752AF	223946B0AF599196
aurora.faugno@yahoo.it	C3F90E38A4831D5F01D202F2A46FC0C1458CBF943095EC05FF5616ECAA6FF98ED3B7E087522CB3DB9433754D5F4404335B7538CF05F7225176E8766BB495AAF6	E063DA60B78C5774
costantino.bresciani@yahoo.it	E9E1137811EE220AB5E474250258F2F0C063F9E7571EB7DA860F08FAA68766BA41934508933ED4F6841F37494000D1EB26B8070AB79B75A7591FC3BB2EABE77E	3A76B3174AF9E8BB
licia.pignatti@gmail.com	8B45A5180CC4D3CDDA2E8CBA600B387E4EA35EE73C7182CBEDE83B148C4B28EB128F0244D9B4801B502A0EBBFE0047048A9F1D3DC99CDFEA4935B421E09F0F8D	9E87544A67D3A4EB
lisa.soprano@gmail.com	45A85F2595279FBE48EE11D3B83414F2624592FD79CD7CA27EA921B4E81F3E7B4A296DB1F27D68873C75DAB952794F7D93FDC9DFA746D449CAA718957358D260	DFF88897557A35C1
luisa.bertoli@libero.it	BAF4A591A33B635B27B1FE94FC8B359EDAFD9C86B646468DD6F955D50638361DA61E35568743FB70B3B28D25A85A166E03B49F966A923CF8DF39A6187FEB6F4C	3E8102FE7694BFAD
giacobbe.dovara@yahoo.it	BC4599715DD24702C7D73E64E551CEC683A26C72979A35C9B3816DEAC51535A7A70593032A2B0BEA935A814785A90B104C9F2A314053121A5CA7427CC371570B	160E72E8D484B760
sonia.cipolla@hotmail.com	783819645BAC9AE85799D1770ED121D83904AB1FB36807D579352F34A5DD37834CB1208BA6FBD4169DD5A6A80AF0FAD8BD8D1496FB2CC823A4D1030BC07295BF	86003183E58FF0BC
ugolino.scaramucci@yahoo.it	6B4E184530FAF7259391DE4B6F679DB627BFE8295D251F1129217F83B278D9D14256B76BBFCD3926A7BFCCA8A1E419DD6138D7BB637F9ACA869BBC230F4F2430	A4CD474264056C3F
fulvio.ritacca@yahoo.it	CA1CAF3AFEBC2E92DB6B844A3F36D113F69354E320F18FDECD8F948E68ABFE06CFC025DD747D4EA4C3547E5FC2D32C63C7B7ABAD6B961F80FD857F044EFB6BE0	AD7AE1FEDF25C0F2
adelasia.sommaruga@gmail.com	426229452DD31A3526CCFF3DA329BADB1CD95EECFC1AF8C10057C4D8EC26132C4A7AE80B8DF6C577E2B0FC8726E88E681800FBC0BD65F2ADB915FDBC92AD8647	DA0E79421C714DD2
mirco.gaito@gmail.com	A15AFA5FB746F31605A5592E953D41E9639E31775400A9AA6F60611A9B0B6D6B2F7350FBEF8543CA6281092A5063C947B4F540513C3DCB3478F33B39B1C81E6D	8616E33CC95959A7
fiamma.tarantino@hotmail.com	BA5E3F26B87F2BEA13EDC2A837FB581C0DA7FDF96E94B492CB38457058E2914A3E988DEB2E1DFC75137C5E4094DA325E9E465EEB23A5FA26FFA73B414A494724	4C6ECDDF1D825AEA
elisa.ioppi@libero.it	F14893244B21C39A2C23E9BBC432B61501B91190DB03C9061D3C0D9AE14B5DB0332D55232DFCBBFE0047EF583D96384D0F75BC2C58D4E3F35B0E99805FCF67D9	CE588A02E6CDC313
chiara.travaglia@gmail.com	4F74F9E2F445B0EB8BFECBA061FFCE337E840E0760DD63D38DAA0D7EE2EF2D140268DAF4CE64A523A9E34850EB3C5CD7D14989B82A629AF24BA831C9C0C3488D	AD864FCD0C8B3CE9
mattia.soranzo@yahoo.it	0F88FFC84AC784516B0D82A405B5F5CA978AFD7F9ADD8A3C14EFD2B358BC349EDD50B0DFE5D616D73F10B35CFEB4B8F2EE17F8DBA28C018DB8D88F19D4908F22	38378BF8CEFAB542
beppe.falcone@hotmail.com	0BF1D078CB2960EECF468F500BD8DD0D81DBFEA65B28E8C6782E407E5FA1A074DC991CC1C4056AEDA0A83AD295F8A0382F50A74F2F48DEB3D20BDAFC8CCD874F	0588FE0302CEE1DC
umberto.jovinelli@virgilio.it	FDF79F16F5FC53A8BE7C698F9A0130AEF058CBB2A12FAD551E23BC2614FD5B96839399A8EFB9177CE06C78E4CD93FB055A028668453BCB6B5F89E35CB54C2B1F	5A62670E3DE6ABF3
piergiuseppe.ortese@virgilio.it	C3C0DFFCEAA3B6C6D47CF08AC46A3FCF4DE598094F5C08F85D399BEAB9F280246EF6D235846A8229C6DCD0AD8E563CEA06C08619FC0003C2A622AC20F6E69F13	6B95A7A486C2793A
sonia.cerquiglini@gmail.com	F9CB9E279C2A84B1608E3060C5AE596207B2FF0C88347E471C7B3758A2A78EAF5DBA9E9C31038AC845A65CA37DA98E4CB7093EB0514EF1FDF17642CF3A844D9D	E579E9B8BEA5E7DC
serafina.napolitano@hotmail.com	4EE4F70E9BD6391A0799045B001F361660675BB04587E0FA6563FB2071194D06834E2DE1C8029924F50E79F6C365B1F7A8915BE2EC7BCB1A7DFAB3DE36153AEA	858D85A1B69622D8
nicola.ferragamo@libero.it	64F63B93472CB5FA5E6E78C55A999C77EB5D73D4100469899A0DFED1E1DC8BCF09593D2A08FC83E9D8C4E00E1DA066E7A6EF49B199580197FC4CDCAC7EF42BBA	A825CCBB617434ED
orlando.tarantini@yahoo.it	20CB7789B3797DD76531714C1BEF1EAB1E5D78D394B0CF22DBD4D1888230007E828DD7E3C037D6870DF4C1FE62A6026022B653482314A883ED4AB341BD1A108E	B704AEFDD480EB7F
marissa.busoni@libero.it	25357A4E8C730CF9464362165C86D92D86FBD4F33B1C7CBC5EE25848086710F3899D6B0A0FA7DD9F3C627202DEE88FD6B74AE806B2105D8A47D935FA032BC081	75649D7F74758CAC
ippazio.bettoni@libero.it	248B679759CA6AC217CBE17B5318324DADA6A6BE7E93AEDC928EC82DFAC392EE88AB75AE20DBC87C9DE25E27615B74163517D064BC1B92D760BA483AD453D5E7	B06970E58920FCD5
imelda.rapisardi@virgilio.it	9F96BFDCE212A320ED71EB66AFBF82323308360FE47DE7B53E190B10283BE8A3826FEB0BD32F7C8F091C5AAAFA9C495503E55C036ACE3FF93AC166D7A354E020	97BF88797F298912
veronica.polesel@hotmail.com	FD07C52C6C47C8358930E1D24CAEAFBE9B047AB97D84E2EDF1EC9DBBA2B2750E131E4DD3169B27BFC372982F41270ED239538FBBD5FA9E054A64DC1C7B216ACC	DBA0338B35BB3A1C
vincenzo.roth@libero.it	A9DFC616A97CC3AFB9529494235ED91946DDFF12F4A5F1E412F02FDC056F220CE2511B2E3DBA73FC1C808E374CDA73A4486515D5B2CCE31D934C2B2327CA171C	62359C7C5B81C2C2
maurizio.treves@hotmail.com	A8F289EBDDDA34DA0981A0289FC25AADE43F3CF23792CE067162B8E0803B32A9143A648B29B79E7386D76CB4408D091215190264C5E20118601E8552485DDCF6	46113A0E224DE2E3
raffaele.salvemini@hotmail.com	6D4D0CA97E57B0531242ED29FAE4025C0ACC335F002C31E976CC52C15418E6CF468EF6D2B72DD4EC49070ABCA126D166B807069E0303CB733F798FF89BEF9078	56C38EDC821BFC49
durante.corradi@yahoo.it	AACEC24585A1C3F54025B90CD1272EC19ED40F31D22A4F6A8624F4D00477365BDA61457CFF0F4EC058AF87F1C14CA93488F91B9A7739E85190A3ECEA5D842EF1	C90CC4F9BF128286
loretta.bersani@virgilio.it	DF582E1B2DD5BDFA210D8B489A20FE1283C9FF6214FEE693A3D99400D63C517C65F27EC364C812F0492B47A6BBFF98158686AF8F1AC00A0B48AD3B0F7960B415	5AE12BC95FEEF08E
tonia.mazzi@yahoo.it	9EFDCC05279EF2DB48F6BED2BE9901DA92A70D9A4F997FD066A69DFD5520E5DC8073A7935D56FD8C815AE0687E47316191A4ECC8123F8E9B707FF1ED2BDF6CE4	D9A62560D483E427
pasqual.pezzali@virgilio.it	AACE79EFBCCEEA67B5B64DD72754C52D0777BCDC3AF5665D48C4C1CE28400F06548A4F385B0FFDA7C5D9BB0EBA1F0DDAEB17E9A9E7F866BAE32D4E583AA531AB	5D887C1E12837BB5
filippo.bernetti@yahoo.it	DB33444C5075780E9A0042E1695BB7CA232CD6FA79A5C0DAA3A10F84D0592219C09A6E246B9B042C2F9456E46FDAF687E340683DE11E381DCFD88731F94AC16E	E62C6026E99B4D9D
ugo.interminelli@virgilio.it	373A2901DF277ABE0BCF0CA2DE58EC35758B8FD2B59C6BCE18711C26FD5614B48D32A02CB370D503F21A4AC01000DF193CCB3E19A959263C359D45762C252824	9A563EF642588934
berenice.gioberti@virgilio.it	1953D99B01F493D2DEC7A73471AA8BE68498402B39A5C6FABAF6172F2B1C178DBA4524736636438913791446634782277F9158810CFC0A473C87C9F2BB658F2A	2DD1A730C40B3529
santino.randazzo@yahoo.it	72AB2AC6C4F7B6305088AF3E52F0DD8722541E407843C40DA801CCDAA4E10B5D16412C0E31C1DE85A0AF2E6950B54B2E376B6737FC1107520AEC26C6DD4D49AB	D9CD4643977F1232
hugo.basadonna@yahoo.it	AB7518ED8C530E20A13884525FD264ED66E6BD7E2416418EBEB61BF4A0AF78ECCC2CAFE1EC9F292FB3C335FBD2078BA457B728AA75EEF315BF83CDACE431D278	56D1A14829603D0B
mauro.dallara@libero.it	A38474421CB7B109F2FF8284D83B80B62096ADF43BB0C73C4AD6A4CB40706642B3E4BEA6027E0D3F330237886F068EF6F4F7954B4161A5F3D861EC6ADF7D822B	FBA687204470F5E6
durante.fermi@yahoo.it	2329275DC9476BC8B947D9C2B8E5F62AA6B2EFE28946BAA75B74F73E5CF5EE8A5780244A8598B052D67EE5DCE11D83A1262C6809113EE94886748508D289B956	C6782028C1863737
antonella.roero@virgilio.it	4D33EC3BC0C5B9FC4FFF96FA1A14DB586D4C53A370091A58A6383989760AA36EEAD263545E7BCC089030499474AA99E3D57C9845A164924C070EB3B02E3BC68C	A8DCEBB709DFA80D
fabia.garozzo@hotmail.com	DFE5E6E5E42874EB172FE20D72F864B6CE4150FDA12400EEBFAA9B790318F02BAA7EC87D80CDF8FA24F8A4BE34F902091873300CB7E110481FA03B075728A94B	A436399D4DF66A87
raffaello.nicoletti@gmail.com	72CDDF0D5FDF5EBA0F66B8EF51D8A2EC64BB4FF44E8906E3F8500579A0D5D4476244FBD414A9EE647BA99371CDF0D5618AF5EB0B1E7EC6B65A2AE0F656DC065F	00BBA99C5E12AB58
raimondo.onisto@gmail.com	2E0A43930C3BEC137DE6348C8624853F9704BB9841CC8F77026F3D488D85B819BC426558531875BE686E2B1E56FD7CF54192C7641D8277417D2D81AC7081CFAC	B8AE9F7E0FB67E04
gelsomina.comeriato@yahoo.it	E0D3290E0C0E80BF42A9F14CF03597028D981B5C7917736ABADBD626A753CCB10DB8BFE088B896EC8DA3B97695F5F61FD14264376B5233AD50C296A97382B671	775A60506D9EC6F4
berenice.capecchi@virgilio.it	085C62B10A1235ACBB3FF0D6E7E755D6D1CA19D67F3CA7BA73F4516E81C3D27209688D7964FDBAABCCE6ABC20E1E6D17A0C824138EF58CA6132C5A33F778CAA3	0F6923299BF15BFB
ruggiero.juvara@hotmail.com	6C17D788FB8BC3FD5C5170698DC1EF5B3A8612C165A174BEFF7BCA2869A8332615C6067F51F1544D861A7A5659C27A5B50748907D12F52035A407E0D32625446	B5173930CAF5F806
ernesto.tomasetti@hotmail.com	CE10A831DD74536864CC8B08AEB09B3F6AA9E5062A50BACE4565D0F1A1B35694491B45898F7D855347180D2046BD958D897C949D7D5A18B59047416399FEF360	DD5084F3BA15F238
loretta.balbo@gmail.com	13B990537495FA45C1FE8478EBB9002A4103D8C61715F71405CC0132EB9AD9132E482F7BB83602FEFBF04165D0080DD8C4A9DD29743C1C7CBE1A789B7B5A8A02	5112889F38C2B3F4
napoleone.tiepolo@virgilio.it	CA44073A346416846458B1EBF071483E5E6F52DD861EFE72CB8D8A14E899EFFC823BBD375368FC314A15E79B8B418A316F4B54DB93E77010172003C4B432A4F8	8E3F77C8BF43A469
lidia.tutino@libero.it	23AE0FB53038810BB4FCBD68482F1899CFCB09A3AD444A5305B883B6FD6CE6509D0971B1F8911FACAF5A131355ABE98408AE77187FA6237932488368D1397D9F	801D65F8A7E7EBAE
piergiuseppe.corradi@libero.it	DB510DA17CC8C6F8BC2C8A4431C22A4E009C0841A3FC5DE13510DE754B9D4DD5CAD1EF1188E3B321636266F4AA4D87D7A2FF657A878FFBA1EAA2C884EF316F89	21600D23268CF2EF
lara.cassarà@yahoo.it	6F30BFDB35628B3EC6896E094B13808C67549ED50171811E7A1E6F2C97B915605E7FA187E8103A21201A9902F1470DC5F159D6069E0F1AF574C2F83757E9E3A6	2EC46F0670FBBF22
tina.giannone@yahoo.it	F575FEE357D1461D8DB902931DFFE3B8F8C5DD9D72A323865BD8D82CBBE909AC504D53A00AD33D22C40A1FAD1FF277E49E5FE9C6DFD0B49EAE5B471977F6020D	A64C4539D52915DE
greca.boitani@hotmail.com	1040561C5FDB5D63FC3997CAC4CAF3F8DBD8390241517BA916C64B469D2C0B7716BE21D616FA7791A4AE9F01DFB53F9C69250673E168246B99A5A5C706729094	89B489E0367306F7
michele.prodi@yahoo.it	8FCC6BC194628C6C6422049B02D2134F0638B1818E69C0713B2BA354D5DEB9C9320292C459AB36853C1103962B1F39B36DF775F9DF8E796F2FEDE5CA426E1340	BE9ABFA20BBD8311
antonella.petrocelli@yahoo.it	7578499D787280ACB0961B3234F91F6D7EBF841A955D4B81AA788A28A07826EA7B4F0FAE02A992D53247972FE0384C8AEB122F46BF4388B86E658AB9564BBF00	9D9385B499C509F9
franco.salvemini@yahoo.it	50313F39A331942AC06E4B93FA552D525BC9D782CF4E4E2BBE6FBEDCC0D99411B402C0FDE23C9CAA80EA14B051C5B2A9D97032F415A15A5FA01DD3E203FFFA5F	7230F6E74DD365B7
luca.tutino@gmail.com	FD6A2B66C8988F652A7950C6D582B38E1EA5ACC2750C9961C92FF34332D20B7AF2D4A5732A6EFE9E26974B6F27019A70D5AA199C7C3067288BF3B8D2D2D1AD5F	59DAC344A6629EF2
romina.bellini@virgilio.it	333C64016210E115EC09FFD4C453D47A6E84FF020C595B62CD3F99185428B28B9FDCD4B044EAE6920A68DB0F949B14734DCD5A8E98060D33E334E5657C7E959D	AFE1A75F34BAB873
ennio.benedetti@yahoo.it	7DACA63252E22E0062926F30D356ECAAE81B20BA273643107A71ED4185D1AE64E07C2F2DFB83AEFAC5AEE907B90CA204F2F3B78A9C8F046E9AB26459B2B0EF78	2B6E2D7EB97B4F25
serena.briccialdi@virgilio.it	1FAD950EF4419CC549033EF43D03ED21724D7A89A3F08FD9BF70991CFAF63D1AE8C009A16345CA5655C513192E7DA1F25F89E0114EC2E11E79C77F09067ECE6D	37DD58D8802589BC
flavio.galilei@hotmail.com	202B0FCA569905150580E33E839DF74F3454930B3B438AB84FC919A8E866B247B9A010FDC5C8FB0373618C82ADAD25929CB00D6E7DE699A0DF96B0D0A43C707B	8972B15FFFCD8D5E
marissa.barzini@yahoo.it	ABDBC4FCF1E04E9E7FAA58FC7E54E99C1A0C8E54CF401177D68B1265CF0F3C124A985FCD47A2C5E3DAFE4C608C51454F9EB3857714BA6E95CB9B6417BE8C1FFE	48232A4C71141E9C
leone.verdi@virgilio.it	E9A68890F8CE0160D410B983942325A6E7B5B153D1FC547B189EC1E9D4F9C6848661F765B135CD67C76323B20D762672753B98228EDD07AD18A8E53CAE63FE3E	D22E71C8394F483E
concetta.botticelli@gmail.com	C48C578E32E9CCB97B6945BB685A2BFE3719BC30674927E9640AE748C962276E4700775C51603CB9D43ED1409133DBFAB6C9168BEF34E05BA1D6D036F40E5676	53AC2658CBBA8674
sonia.fabrizi@libero.it	2A91116B5F7C0CB609908BFE12523962D45071593E070C3DDB8BEA5159B358AD379EDAD21D13219C92693F46FF276111B7800110E60C68CD05F1ED7545AC6972	269F38C51650D197
gianpietro.bajardi@virgilio.it	A9EA86FEDC0C75FCD931F5FA0213521FE2BFE861330B5D1E468CB1B23BCCA45C6EB9CD13219EB9468ADD0AE35DF08A274FB4F2536C493C08DD0CF7FF988D910B	8A451FE73D8BAF74
angelina.sermonti@libero.it	B3ADCAD3617AC9639F904AEEDDD870E11B70B7DDE16CF4EACCF6D2DABEE4AB2FEEDC8FA6EEF862074D7CC4BA20C8C2639BEE85308324E54D4FF62C7B08A6A4A7	4C6748DD4C81CEB6
aria.vergassola@virgilio.it	9432CD10AB45C47656BD54DFED82D9BD6ADAE4E71D2A9C87E5BDE2DB2C976B1F3B8DC1F35A312B25163637F8DAED3FE06266E62DB3D7377858E5EB0C5425C241	1EC1A2BE370D8945
nadia.giusti@yahoo.it	A62E09690937A9965945C42FCDA4E03A69B9178AEEA621A3FC3E8552AA4C7FB16C15DA31F8610C5D68DD6E4347363E9499E83BB830CA7F448578A142A4F6AD71	C56E4C2DE339D343
ubaldo.totino@gmail.com	BCA244C2E1E3CC187BEDA10FF14438FB5A97006E9351B74C03411BB3C270B812A4ACC31E2A88CA91747E32CA1A3917641408C2890ED5C3625C83E9F37C127747	C059D98CE57B8DB9
filippo.piccinni@yahoo.it	77AB4EFE4150F3F7F8EFF359A8FACCD992786EC9DAC7EE30E9AD87A2D070EC89987867F2E9AA635528E82433995C673BE8ACB3C236640A6E8B60995D3DF69ACA	924B2C3D55C2E5EB
cassandra.crispi@virgilio.it	9C686073961BDC69533DC80EB38CA5F7A22931101BE8E90337D9D7DB91E6F394072FF3863A3727E66620DD3A0D50EADE4B6993310427D5DD1AC805F733E46BCE	DCBBB7F5F8ED70D0
ezio.soffici@virgilio.it	E5329188C17A2A529DA700FDEE9FB38E69355AD03B8190DBE333FD7D746BEB615F3D65DD0A16C49C98C6961E0FB3FA419E0194027CE7E0C0CA28A1F7A860AB54	F0D75C543F98A2A3
costantino.andreozzi@hotmail.com	64E3A7734683B61AF93A9CE4B0CF3199A9B3D1B9C1E92787504A410CC17629E204E18BE88684FAD64DAFA9547A981A6A04D57952CCE3D0AB045A921550B8717A	0E412CC8DE4FCB4D
enzo.fittipaldi@libero.it	C0C1C64ED483BD22DF2E8FEB0600468BE398F61880F6FDA78F2ACB9EEA022E7C0D1080D075667642C84CDCF2B5465C9AD3ADD297E00AEF7777F9B2E72BE30502	3DD83375D88CDBD0
corrado.perozzo@yahoo.it	C6EDC873583057E42D3C4CA95FA3BA07B3C6247648B62300E2F4BCDCAC2B6E39B0E0FB203EBE4B3A8390BAC7710614F3B22B492A71FA0C8760D9C6C18B603A6F	DDE6753747064306
gemma.gagliano@gmail.com	CF97042345E9DDE5781597ECFD8F93FE62264A409944688441DCAA153EC658C830A403195467EC78B0EE5AB100D8EC3CAADD1E54F0097E9FD5C4FE6159469072	95EE4F60E8ECE6AC
toni.gemito@gmail.com	656C40E6411BBD4E3C6C62B512BE00A07A9B3B8BFD058CA8C9229F63445DC87401124D3F06EBA12418D82A4CD6B195186B13D940CF7C44A70452A87443CC640E	D98FB27F09A99A6E
margherita.baracca@gmail.com	D99883878BDEE69B85EB9011487D86CA0F2F19958C9009B76ACB38471BDDE906DA1B0BB091B3EF600C8676F350B44C167ADBC5CAABA021FAABED1A14C0A06F18	DC6D4B9D8CF6F179
tonia.bossi@gmail.com	4728AFEF8C0DC27D5E0B724E4D8E28A5592C54630903193D578D8B282CE98A357E7DA0B009C329B279C7082BC371CE881CB67E25370B31DDB4FF78249E25CFD4	39402896E4DABB17
rosa.nicolini@virgilio.it	147C5DB62DF25EF5F76384658E4C487F232A04231387A38FADEE95A10EAE3D07B1CB2AEE397D9DACB3728D42D95B7CC5E2BF7711E4A031480F82E074D97C622D	F1C6461D63A6D8CE
ubaldo.bocelli@hotmail.com	76D73C14A7F14A70C9B187314B0BF52B756B848EF64FCFE1364BAB4C5EDFBEB5B616C0AFC52CF4749E00C225CB55EA79059C264237CE3D5C32C553D6B8BE2D36	6ACB9FB3277E196E
benvenuto.tozzi@hotmail.com	5F4F3A32D77BA7BF6324973CC9B518C226E610BA4DEF0A425022DB658B22A249A93EFBE76B88C68F514D55CD036767C2EBB0D98E411C83F1F1D02959E97CA94A	E6857A0BE3F1DBB5
vincenzo.angiolello@gmail.com	473ACC744A3661C9B91ED23544887A6E67F1DA83324A5D6C5A787CF2F35DF6EA70AE4F515C9CADC26A77A56AB86F5C7605AAD5315B04884C5052382D4A9A39A6	6B454C58713BAA4F
ugolino.nosiglia@libero.it	7F9B4F025193C414AB6D925EB39164EDE14286FEAF232F4C90E607E251A7C2D7488B2AABD019CCA8EED387BE3832757F6804F411F5118AE2F27AC63F0B779C67	6D10C6B2B402D2A5
marta.casarin@libero.it	9E1DA3024B3D25222DEC98C07F1D74A47F3D65CADB9F0819D6B8D21F6F563F3567059084FC13653B35BD8DE88CE040CCFEB845988F261D923F8C3C12F18BAF7D	005166E3D0E6037C
raffaella.tonisto@gmail.com	82E261BEDC72D4671CAA3EC7CE3E5580A8A5CF9705789A0F6F81744AEE522A9A3B835F2DA4C9622C78676674209B2B0E360554DF265334C53179C9A90A4735BC	8A06FAD4E0F9168A
ruggero.muratori@gmail.com	AD6D828FBB1B29C5FA1FE2007BDAC325056D20CF41AC367B43BFA656D164E3A5C36BE78B7A8D95959F4826327427E18588B2D608CD89BB3F5F6388F80D4F49AE	8D4F2962235B3C2B
pasquale.tarantino@hotmail.com	C570395F20777D12DD880049C5C118A363A95FB52E1773EADD4FDC00FA789EF1D91671F4DF0C4C99EEDC62F8FB2F341ABD2E332C8C418E2B31308CD305FC922E	CB6E5D725D1AEF25
agnolo.mussolini@virgilio.it	6849255048E82EAE40269AD4FF38E11A7947490EA17C01C126C67475912F85C804A546A9892D650665C8726CC848F6527C359E9C710A136A383D1B6CC3F8C5D0	D34BAA608C07193B
veronica.cilea@hotmail.com	AE8AAE959077FDB41916E42AEE40CEE43283161A907542EA99A6E397A904E96C9437E60274275F0DCD0A373137E4E11B1D97F50F06A5935501F0BA5F7B0140D3	4467B885D889A720
martina.fracci@virgilio.it	82BA02B2EF66F23AE5D54787078428865B52D1CE7ACCF5BC0059E711506AC199F84AA8B1816B49865F1AFAC30579A26B5312A2C9CFE8F265922A217637F946AF	B14DDBD4859F2928
pierluigi.capone@virgilio.it	44088184439E362D4D259B1219351603B17D24BF2FD1BB89002B0D922F44AB4E2DB204DBD334027C65376120BD69CC33A8B3A3B70AC625121C28CADCDE093661	0E448B9885710708
rosaria.chiaramonte@libero.it	2325B2E3F1A02B913B4D2559FD02B9A50F4F809F99F5EA008E4B48EF0D5885E8489BF5B146591501025277C07A4FACA8FB608E126DCDA31FBC16F22467073F68	3B5943921A95E0D7
fabrizio.tiepolo@gmail.com	E41023B64D17878227E4DBDA151E402727987BDE131483C6E31695C1B6E4FF897EECF8AC10A1E09A6B2484D4B797426BAA17773789344BFE18AF86D35D16BBAF	CF0B62D513C7713B
antonino.visintini@hotmail.com	B50D948E873F7920416A336AC047A003C7133ECEE2161AC88D5C41F74DBB52138E5A410C7C523CBCCC3899FA7E4AD18E405F69AA6D696E5040A3045848875D03	BFA507A36EE492D1
luciano.falier@yahoo.it	1D7CEB4D81562F7FFD164B776E127F67627E66DF9C959643A5BA7081869352A74EE219FDE9AD9F4A0BA525C3524DE5BD328D84E490B5018A121D6029B59CCC55	68DEDB9DDB5336F9
lara.lanfranchi@hotmail.com	5DC3DF49B60835FEAA36A341B36474DADE740253FFD288FF8237CB017CBE2BA02393276A4A9728209F8C86D5D1E1C6D9241902CFB0D3BB8B0C459DDEB179BCD9	FEF062CDFCEA1C71
ugolino.cesarotti@hotmail.com	DFD891FF6DD43A4B74014A7070F4B0C07D9ED9064F7CEE5C055E8C76A8AEEAFC3992A36D359779D3F3C3B1418B71BDBB1A0EA59E3ADEA3DDAD617D590F43A9D2	2235E5105F2BA40F
bianca.malatesta@virgilio.it	26A84392663A7005C379506D88058EB0F8AA98D16AD66820B0F960890602CB620B3AB3BA2CC1E3A40348C087BC3A09B9EB14162E1F2DA1D81F7B1390961E551B	A61EB48CE50EA7CD
licia.biagi@virgilio.it	92836B3D796F7EEC0E3E63E4921A349ABC9305BFEB331C6126A5CA42206933706F92B3ADBC633F92028368D1AAAF121365017D15BF8305F2A0EE44B12541A65B	2196FE3388270210
amleto.bombieri@libero.it	328CA181A5455A1F1561C3D8314C6BB83384AAA13A67CE58EB5A872962AD2F880D3D7A96E7CFD84FB509F347E2247F6D74AC08DD0E2DF20357D4647FC317202A	30CE07FC0C4EB900
lucio.callegaro@yahoo.it	8CD4CA4B620D33A5CB0597D444B26F5ECAEB5F31A633B61BF142E9F8CD0F127B9AB81AC724EF5253906702A9C648186BE7E7BFB7DC64B0FA13B890256A3776A3	A999AA05CE177F67
giuseppe.nugnes@hotmail.com	9823380D2C5B560B7C5643F02B98BC1F6011B0F2F83BD1538084B512F804DB0301DD3BAA73038951E3B2764A650B2F52D51E538F67D5835FCCD5D2531CA8F0B9	3C8C0EF0AB0EFEC1
dante.pometta@gmail.com	120DFBF6263D644F1DB2EF97DC848EF3972F82694722521AA3A77AE3896545247B78D8EDB52C8236DE280E2E0637EDA271F947A386730C4643EAA73FFC1DA8CC	2E99B3A8038E04B4
fortunata.trotta@virgilio.it	1BF3C936C662D46A28FC95913A2A36347B26BC3E61927078574B4F7383E3916C989EBD72D32C78A315107E3B532340FD3CFCA6AE34EC2EE50A51C2C91BF8DD15	EC561CEEAE563DF8
raffaellino.busoni@yahoo.it	6375ED3DB0376867D872515B2FD2406C9DA536DF32DDE99348FD8B23DCAEAC6EF31BD222A88DB2F42807D52B75F85AA48697BDBA598D4309D0F764F6A3E5EC61	70CF33F320ED4501
milo.nosiglia@libero.it	686DE49FDEB8BF7D1896DFACDF7559DBE701C37F35F577A8936C3A8689A5485C417175F7DD9DA8844043C868B466045E8CB37DCA53451631EFFCA6A03410E5B7	CCFE9252C1BB7001
lolita.gentili@hotmail.com	B7B28AE1F8CFA70FC6977601C305777FA32D2FD21EB61CBCD2E0825F75219F042A521EDBFB975F53AA0089A05C209C4129FEC8F539B9D4C00218F009C8CDFE44	35E667CCC2AC5780
arnaldo.golino@yahoo.it	D0D78DA04FC073E7D69E31C2C6297CDBCE1931627E6BBD0DEC2AABC696D83A2B07ECA409CC4E310E08A6B590057E2DC5EF79F1DD75CDBF15477669B3FF275A0C	883090166E6729E2
alphons.finzi@virgilio.it	30E573E7F7EDF10A579FE6078464B18F6C9D914C241E03C45189DCB13B5624DEC77D4A80D651F6B47AC2B67B9A122C56BA48659629CD8BCADDDE09D640BB360B	FB8419AD1875ACB7
damiano.schiaparelli@hotmail.com	301F78346A2A5F678A8BB43DB52A6353CAAE1A24DD4F1531CB20ECA7F6001CB9AEF849BF716282C73B2287E5DE1F8D8124DCB01219422BA3613573D1C8FA7293	23265FA2B4E89BE9
ivo.tartaglia@gmail.com	B2101A5E311555FD4AD815465F1ABFE20B6349EE6AE9BC811B8104D9CEFE0AFFE3A8073115541EB02D4D63A1133287DE122C49D7C797579C77195210512D8A92	E7D69F117C392B2E
gelsomina.greco@libero.it	85D1000B3C7B92CBFF242AB230262BC89A4AADBE34D46A4B4A74AF0D61BB82A89ACC6FDA99FA6892F747D5F2E3E59D5514F0E26FFDAE548406570A9740B5AB6C	637EA1C5D3061743
melina.sagredo@gmail.com	BB848D29A6F5A0BF56A25DC603FDBFD22578D2898CE0F153CF8A6C1110716D8648D120B357643C1F119749D9A08C2C16C25815C7D6C2785EFB91FF6B710341C5	F78ECFF028BA6D71
ronaldo.dandolo@hotmail.com	3A121829D06E231F015831F8DEBD2CA0CAA46575A1871802A1423CACB3C5FC4AF0F43A1A17A22987FFB1949526D8D99C19C3F2C62915A8524E639FD50F58D882	6DC7F0F6C9AE5FAB
rita.tarantini@hotmail.com	708B40153E9E6EBFAC40C35F447358C4143DA30FC4411ADC2E88E02D2D75670B0E27D0B0355DFEFA6032270ECBB4D665E54B497135765505C6EB5CD24D5E15B4	ED05C804E962A1CF
marta.marrone@gmail.com	7D6253E86F1A15C05464A55CEFF522EFAFD5007DD5A2D6007519EA308AA239967F5EEB012E4D6379983E116682CC7BF77AFD1EB8CB5E0164D70C1C883A9EE608	086975EBE0D9D92C
lucia.pisano@hotmail.com	3EAAD435A2EC365C467A96AD1DB41FD61A312733DFBC66E12B2E03002B1109E7435E0E95DE8F880593A2A12B87B8F93E87BD5FD92074CFFA875F740F7F60B660	BA9778A2030AE0EC
ivan.favata@gmail.com	D18C28AE2C5112834A4A22CB28CE175EF5D61F4AA4DA6FC7300E065DC7CDF110B09598227BFC3DD93989D5830081F956E5D397D23D09FA7FC1A2FA7CC076099D	DE6F750F22123998
fredo.ruberto@libero.it	A95D683FC2337D1710A12B5EBFA19CFC6026859C9C3FA49BFF8EE777E9E85F6D0D1D3F1C142F27FB9A2CBF9FA8F24D74D640E7494F9ADB7F4D06FAB8C36639E8	85582CCC4364DD7A
coriolano.pastine@hotmail.com	A987C5993ACB0F0B1A8C9709E1B1B52D178B2C0488A096EBA758CC9A27F610AEEE8287E990DA7292C402DBE892F9D0CCCEA65C0837F2E637690151CDB16BEDD4	7CEC130102490707
alessia.morandi@libero.it	A4518FF7A9B3F6F4C66E120468F86ABA800878EE07E5744F959610F7E237F6D4E85732EB66444B98E273E6A5BDCF635BFA19D28763E67DADA982DFEE789AC8EC	E6521469B3B113AB
coluccio.cammarata@hotmail.com	7C54E749A075C90513BB17CF825AA582BCDD4222A2D77C900BF66394ABA225D195421293F4EABC63362B662F0889AFFBF82F34D68A57113BF04761114384FEA3	B542CC994F7C928E
roman.leopardi@libero.it	3D43B914E0E35E5FA311A29B3EA51A7B5FF5515F6DBC3C06770642EF8FC04A777CBE34CF369C40316EAC5AB31AF816171F902D82883867C2E189F6CF6A8DD7BB	1B2521DBB0FFF9E9
sabatino.zanzi@gmail.com	47F9F8579850BD36118B7230BEA5E9C5BE4A83310C587A7C129A34DA610AA14C9966D9A646C7DC91618E1E40093AC8271AE8D09C2E6EF8B7DBBDBBA646494C83	17A47A40E5BCCFBB
barbara.celentano@virgilio.it	32AA84C2DE3B213E53E653B7E73642BEE6DF2F7E70A41A2FFD8661107BB81FEE91B505D041B924F31EA25086C9BBF180BE2C68465ACDC34B5C5DB1C1015AE084	89C4E44A8402581E
vittorio.poerio@libero.it	ED3F5ECA1FFDE355D00E2F7C449485F32BE83CDC21130C704D6414A9586E9D6CC305386B9D37B3B6B03125E7EB25D138A1CF0934B96D5B57884B0DD08F6DCCCC	91746C77688D6678
santino.tartaglia@gmail.com	DE8D418056D6469F7B6FD8810AD20EDFF8566D6E266CA98E7DBC507944FDEC1401C39D36209B9D3A6F244533565AED9328F133B34E1722489AABF725B1E2BFA7	9EA02D64F8A24A2B
fortunata.bignami@yahoo.it	D36583443AD0DEDEF7D5B98A9A2038B0DAEA9A9471D797544F2651320A11313A728634897E93B42D1FB17CB2B0D4EEED52699A537A543DFD0CEC46513E0CAAF4	D91AA9579758A12F
stefani.gangemi@yahoo.it	0740E54744E855F29D7BB9239320F72E20C19696380F5DB20A02A34D27C5E157801EC6268D6BB72E0CD5945AEABCCDAABD1BBDCD206EC780E45EE4DB5AA7ADBC	5F2816622759EE2F
vito.cilea@virgilio.it	9856A55F3567D3A9887F1BFAC9A1DC41CEF1174C6E3D258F956DB1654F0F0A7BBDFAFFCFC6E603C6FA69370B3796D7D97C1F264378FBE6CDAD5F23C6BBE36E77	5EA83DB29CB5F387
teresa.tirabassi@virgilio.it	76637D24C868D2B1562D2F96B078F49880917B66431EE6AA1D8D87BC87EC5408D84808C6569E936AF44F786E04B82BFB2301146343CF84DC7CFEEAFD2F839CD8	C5B8C9338A3DB875
martino.spinola@libero.it	450EB42D4C3799EE3BED5F4FF4A4230B753620A1782BE29FDE6AE5FD66A6D330C743AE5EE890966D3B6F825512589A2CA24BD660E46A660C9DF917DC2612D059	ED1BE1064C2A01EC
guglielmo.togliatti@yahoo.it	9F4FF3174BEA4CE58F684447BE17F126E1E3EA71AAD01521BDB7228016AC2B68E0732AB6A76A1083243CA51326A3EDA0DC562721D19D32FA406E33A73ED15500	0060E53B23253E53
giulio.bragaglia@gmail.com	7BE5B5340614313FC40B2F1BB11C4AEFDAC74D7EB5E5D1243744BDED31E5799C6D3CA69E52471AD360E0C0F5B2C58F97718220A8F3ECC8950FA88D973F782B15	D645FD1EFF6345F8
vito.campano@hotmail.com	125135D4454860072CD4B92F0FB11EE419A373638C92481C2B7125390D44EFF2E6D597C12AF6F92360D90A4A3941AA720840F21D74BA234AB1E5C2FB712A00C6	B5E2939342480448
michela.sabatini@libero.it	C9EC7D22DF7FD2A6DAE5E3CC4F87633F0BF569EA5A3251DE275800F788CFB1D022AA41566019DDDFDFA1659072E964EE14C1BFFE83233FF71A1C737BBCC1BA10	3B590C0D0E9B2137
ssp.agrigento@gmail.com	5585CD03B2F4EDFFE7C95B0FD73B921ADE901854837B38300748D89F20ECBD320C2AF475FF405C2D5A82D36EDF5371559A3D51D91FFC3A618CD6482E49DD2C8B	BC7159D43150E554
ssp.alessandria@gmail.com	67DD3317F51D4184997372191C6D0585CED3EE2461152430443BF9120343354C6A95FFDAF187CE571CCBA2C1BE1955C5D541EBB3DD0C22EE0FA9399ABB454430	3EB5F1D7DB26A8C9
ssp.ancona@gmail.com	1C79AF9F557AAB23679781D54F2C5AF9C3985BD8565689E720F2ED10443F5F581018A1EEC1BEDD04F58B72EE662E2014937F870013392E6F6B6195D6594B48CE	EF3FED09918A611A
ssp.arezzo@gmail.com	829622AA4E4D1187E9B86A20405CBDAAF114A1176B48FB674D3155F56307862625426E803648B8E6F5E251B8F4B0E833C935673EF46D6B60F9EB92D1A28F49D9	CBCCD3E9759B060F
fabio.aloisio@libero.it	3F39BF1CFA7BDCA62EF07AC74E4032689CAEB1618B0BF5C56FAB30B87BC93B913ECF0486FDF177D5B677060372D48C991F6388BA431E5C321501A814B2155604	6CAE8788A2B4597C
ssp.asti@gmail.com	801477C10B8A1A33D8067BB517801AC3BDDDFA22FA2A7242A44236BB82912481C97C351B77ABF1685060CC60AF6AD1F420D048FAAE7D3D1F0F20F046E7C72962	7E985030B56F7FB3
ssp.avellino@gmail.com	B60A6621D5A8A8B3624386E4BD86D73936800467E53E9EB1AE630C5ABFF1B4DE489EDCF4D257C06D43F0360B10F219E208E2F25C62ABDE0D194AA964322519C6	2B6595639F8620DB
ssp.bari@gmail.com	8FFF5443D83FD6F101983880711DD10879A18E1A60E116862783971BE50966A1B1606864C32EEA3E8E1E0B5CF14A8C39E1C44CF855AB47BBEB976ACE970BD87F	A9A152051DC9F68D
ssp.barlettaandriatrani@gmail.com	658FD62391521D78FEF2D31927AAB42A603960670EF4EF27097D52DDA79A8E0CFB479646F990546D3EF1FD03B8E936D5FAE01D3C099E52775D7EE0EE5E49DD9E	B8712D36D5F719BE
ssp.belluno@gmail.com	0635AD3FEF0095545FCDC2C426B5BF858A89A1B95EEC29DD82533DE2ED0CD9B6FB15750FBB24907B3C523C9D2701BFFD19E022CE4483721118552971F75865F5	20C27408D567C850
ssp.benevento@gmail.com	947E433D42BB7BDA2DD1CDB176F6EB72634C012FFFA55B2E255DAA455F947DF17BCAD1FC033C69AD1E1C098F5C35880DF8B58F8EDDFC27BC0512B452921D5F84	BD96F3ED935C2C37
ssp.bergamo@gmail.com	94BFDB60D3C827257B92BF3FDF0D09D8EF5BE0A60D5798F20920925460EF6C9F91AA426229F23E4B6238318A9E93525EC248806F808CBFEF3849E6D2B828ED80	1C2A9937E8C37E11
ssp.biella@gmail.com	9C46D30EA93094438038A8887F1BAC3AD0CA5A313557FEE02B4F1D170C323EB321643D8D9097E2955C042C6F09B113F961FEF7176F387E59A1E51529C6330252	FB9150D3E575848E
ssp.bologna@gmail.com	532D021BCB90155C5714626B06F2A8DB32A751ADC50B8307BF132D1A8B86235A71249E5657DD24E69090B7201F5D7650B8427C26D1843DF988A143560B38B66D	8D8D2E45A60F530E
ssp.bolzano@gmail.com	D75319288838A62AFEB7039BFB12A8852B45917F2E4388B45C618E13D0A5E5F40DEF3D30CBA72AC367A7EBA58D9CA0BDFE145A895C9107C6AB7BC55CBA284971	8EBAC360123E2DC1
ssp.brescia@gmail.com	A074AB8F601846FF4E154CCD8AF693D6049053106E3F23A22CD5BB5BB792DD7DE490EC7F302E859F0CE5621A904A323632900A1120C99EB20F5CB763748B1701	8E903C740C4EBF4E
ssp.brindisi@gmail.com	7A012FFB11161F27740118671E2BE7F43EB7FCE281F7B7CE05EA82A810E599BC06715A9263760C34A9E049BDE12CFC4FB0C5405F8BD3825E23DA02711EE413FD	B0D45EEFC22C1C61
ssp.cagliari@gmail.com	9805640A3D4FB9AC3B94A67620BB0D9D3989BB0F05CCF997C4C001188320692BA69358431B0732C246DB8650D0CFC8C1BB716648C1AF64A0239EE38965285B30	16EC4F0C2B4932E4
ssp.caltanissetta@gmail.com	059D9606B5844687C753C225223A56A60F9CD1E1AC1AC5CE87A452C418B1200F1F12DC35AD6AFBD4477B66AECCB5DCF622882D141AD2FF32A9EDC59B55DEE5BE	3BB2E2772676B174
ssp.campobasso@gmail.com	BB74A260320FE40F4A0A0170949E3E76D605B2F190821BF5B60C2DF48B8DCDED0D0F85B1B8F13CA8F8E049209D45B887B3BE15286A0E4BF1412C64CCEF85B695	46F54195E9E2EFAE
ssp.caserta@gmail.com	250182D29E2F4AAC82345AD55110195DAF1CB31DCCEB77D6E6EFECFE5744D2D81BE7E28B06597880A5C80CC0EE13CD1C786FAFA760AC4FC28B110BA469ED0A0A	22E67266C807EDA3
ssp.catania@gmail.com	C4B3D4B755F8A638AC362C121A0802E74D76B75D1B8AAA61E85F46CD7A45A15D37814B0805FE77A960A0957BF97902183D9302A6D56D86E353DA60067D3C6849	20A826F813FAB3C7
ssp.catanzaro@gmail.com	00711BC3FAB7645E51F0CF3B1314F7EF660E8D766D6CBD36D70A24B264F872587C2F26D901006FDEDE39405C7385B6816E2222B4E039268B9C35BCEAF000856F	730113D7B162871C
ssp.chieti@gmail.com	5851516D0F59DDF5BEFAF7A17EF32EE804A5B426ADA7198FA6C30B1FF55FC3A5D2AD766DAF3E61C90877D88CEC95938C2DECFC09A975249BC75808AE992C3E59	AFC7CD807236A83E
ssp.como@gmail.com	C1FAD4FF01F2F1671DEC25E65D37BC997F293DC8849519CCA6DF287D187C0DEC054493C36777380195AFBDC9A44E1AE206BFC9725CEE68DA3FF891B43714038B	6A7740054CA07FD0
ssp.cosenza@gmail.com	548DBA3BD4BAB3377305CAADEC566233F0CAC2268E2715494519BAEFAA128898700F6A6353D9B1216E32903F95251A30208C623F0EA22FC5CC516B2B0ACB7D27	DA8FF3050C3E378C
ssp.cremona@gmail.com	805A0E7D13EAA88B41808966461A0BDFDAF43690119EF9CD99AC6C1450A21B8B942F3DC66407CA2CFCA77D630BE0AC62406F36B7DCCFBD6868E10F044A809B37	37AE4045F634EB8A
ssp.crotone@gmail.com	16FA9CB12A30978DEE2967893E15618B65CC83C1C0D4F4796A7C71AF4207F96AFBAD9C07F79503FA417539B14B18B43DB2BAE8B391FCEAEB9BCDA737BF887E68	54AAB66945B39356
ssp.cuneo@gmail.com	1A26D7C11FEC59BE322C4381CB03A870A80F757B94CB038CA15394CEA774E7306C78FBC41999EC6C3CF0508B1695CF1815A0BC43CD7230F9EBFFCB2494544A06	BBBFC45E405C8566
ssp.enna@gmail.com	E7E981C8C01EAF37294EE787302DFF4A054740E651BF51152E05BC1ACBE4AE76BECC4C2610BED98E95DE1D687993099DEDCA6D30836C566D47AC102A5D523215	4B1E0F8D861CB2C0
ssp.fermo@gmail.com	025342FD3969416E151E3C48284F6D6E00971B607B0F9B50B6A700120D93A42D4F77525D5957D01290EA0490A7F41D21358746185699717FCE55131E79F7270E	24650D18D2DF3980
ssp.ferrara@gmail.com	2F2501C5080F324E343FCC111E73BFB303CA7733E603BEEB238EF280B9FD9A303D5411EB5186746BC935FE549041076BCC6DA5CDB349C57DEF2D4C38E7844880	F621DD180D1F90C2
ssp.firenze@gmail.com	2CDB77CFDE94B21507B17F21B9212CA27878509C3D9B9C75D7BD2D1AE918EA55DAF42855ED229A19841A74DDAE4CDF2521E9BFB3F42C518FE81589FEEAB3F3B1	D79BB46968360B52
ssp.foggia@gmail.com	0B40412F350C7D42F6C5DA4278E818FE7367CFD36FBBF8333EDA5AB86ED62B6135B2DACE4A5F871756D2A46716AA9555456ECA57E56F9B3BA9BF96E1ABB38A0C	535204B55EF72405
ssp.forlicesena@gmail.com	23D144325AAEE92D3F229B53A519B173FFF400E3949B9DF0E601038B3EAE79A0FC410CA8EF0948D621AC6596CF16F44B73F5FA41AAE3066223031D97B5C78F99	E5095235E0B95B88
ssp.frosinone@gmail.com	525457732F9CE9904182424C87903841E9B024E52A4A07C738CB610D6CB5C83FB72920EA1E57C5D7D744B21F933465ECA45D4AA3474040361758C7913B4781EC	CC0D7F726C37E377
ssp.genova@gmail.com	E00F5DAA2102E3183FEFA1745A275207A92658F7E1CC7103A02AC910C72B0E0FE7A6FBC0A16A1F0644987900AB61D53951BE7F0805450B27330BD61CFACF1CA8	74131DBB6ABDFA25
ssp.gorizia@gmail.com	3F3A232B718CD78DFAF07D7CE922B3EC0C1C4F32F454430E610AE9C97639EABBA1817DF3D87CF8EC374C639DFDBB77E4370326FF4663E9A25AE6C35E0E89A4F9	A939BCE0F80AA36E
ssp.grosseto@gmail.com	E439966E9785CF60B5E685924B4BBC1309AA39D62E4127527BAC8E11111AC1510357AEF639EEFC815CF5849F981474DD2AEB91FE05BB3C89C032EB96E0CEEA42	CEDECF360A6B9FD5
ssp.imperia@gmail.com	DB482A9DE604980D9265BCA5B9560BAA8E3B2F3F183261D1E4D6F5D8AE944C917B6FAE89866B08DC0F4543A03E8CA06CCAB3D95614D3E31B09454DB4F9BF90FB	D7B31A25D1E914E1
ssp.isernia@gmail.com	1C78266BC145332D7B4D701C16B63A974166274D928AEB38CF8B2277CBFDAE4139884AA689E4A728653EC9E9EDBAFAD879B5AED90906DF4EA7A7BCD1D038C515	DC97C0EF94EB2B59
fulvio.pedroni@virgilio.it	27948DE5EC453B9AD1FB0016FA1ACD5537B25E1C68303A043029EB4FD792E47339C2EAACE48245EDD033AA273AC90D8D6199F7373E9041DDB3CDF9BDE855C4ED	C183455DB64ABF4B
ssp.latina@gmail.com	1D75DAC07971EDB4145B539F9D823A2F7B95CDF1C8FC0338511A71E8ED4141DAFEFDFEC91F27C8148661018992CEE866333F36F003889B694F6C52CF106C1155	93DAA2F68986BAAF
ssp.lecce@gmail.com	0EBA82828BB83077CC73119D5714D70D5EE4C4F56E848B410D0759D2C87F995838BCEFC8D86BCEAB2A84F14113CE6341BECD88A9469A696E42236EDC6ACF0A8E	0181CF93D11BF869
ssp.lecco@gmail.com	4571ED2D7022816507BF1023699E4A7B2E86280945ADF6BB2149192BE3AFDB02A2D249CF134120C61D70ACCA21A3CC4A676C78A497B8172ADA3D38F6BD1940A0	EC8C960DD7B69CFE
ssp.livorno@gmail.com	1980FA75AF2E413D000AC0A85D0A22D96D6E24B6482BDBFD5532A27397029665FF76C5B08F9B618F099C75802A32ABB29A85D98185CD215569653C0C5B6D55DB	59D858CA4D764E1F
ssp.lodi@gmail.com	ED795BDB4D7CED4F38F504783CC3F96FE530B5F4F40CE2E7B178FA637AD21A214C7E68E8E5F739901923EA93858F793742ED1C78D7AA3BB3D8A8FBC6276DD532	78EACE23901ADB50
ssp.lucca@gmail.com	2374DA7EDE1DC034B9979162E65C6F856FB76C5256B2921E56858DD1B0C06158EF5BED04BDBC451E27451AA2688BBEDBBAA5AA90ED67B45ACA380E146B27EC02	5F76D8AEA6E83482
ssp.macerata@gmail.com	0011E6FDC4958DCABD7359439C956DFD37EE436BE251A06FE7258305DAF36B5BB9B60DBAE84DA11B25569F8BBB7A3D1721A8998C167DD4E127415E3CB5EADABE	45D3FA273B498EC9
ssp.mantova@gmail.com	EB3D31E74A67303E270CD6DF7399C717E09FC8C438B8BD13FB7B407762D00A5AEC6613B2069CFD5ED1AC29C982F8FEA5037DFCC72239ECF923EF43A6E264232C	E86EF2DDD4A0532A
ssp.massacarrara@gmail.com	38DA6199D92F3FD15D84E4D094ACE5123D03A59766826A5C739E838AE39BE58A68E489CC9EAE7AF50C693F84349900EACA7D145EE062DF34A4B91B089F284AD1	D063F364821C2A0D
ssp.matera@gmail.com	AA8DDFBEDC741B4B8FCCE80A0656232838C0B7758C1641F4F5C6A1B6E53117E950C9672907DABF857322E70AC5A704167125EA3C7CB2B03AF2E3F6C66346B55F	37CCFEE1E87EB4A1
ssp.messina@gmail.com	21F8A2716E3A8EBA326E569D03D9548411FA035AE08C67B5DD6557354BDD763D2F0A70584440507A43312892BC6CF1A9F521150248E19D94FC3DF8FEFFF62703	9188453675DFFBED
ssp.milano@gmail.com	11B2A1BE5C01C543E2A57CF5CCDA7204E02D82C3EE906614072AAA7FE4A671305433681254E44A01162FA4789D007BEADFF472C5F5E3F1CFB7BE7F9083B7B14B	1741C010E69CA5E4
ssp.modena@gmail.com	C75967E297ECA307689CD749D5839D64E9B47F4704B1B05B52DB32A42F1A42CB910956AE7ED84489F673047EC5AAADDD195861070CB8662823EBC8C3521521C5	1B3E9CC75F43915A
ssp.monzabrianza@gmail.com	E78821497B33C21695D472B3AABC6238D41E2C0168BB6111AB96575B546044901D8105E14A01B564F44C112C7ED25148A3AC60A994C892AC9995A013C1A33CE0	B18E9912F7A3D67A
ssp.napoli@gmail.com	E57B2B515BD81D7AA2AC479321D2BB38CEA090247A56D3D149DE10401E6BBC214115DBB828E364B3332B2A0BCF79A8BB04A87F69D60327872C0CA1362138E449	8F9FEF57009ED594
ssp.novara@gmail.com	762B51FF5D2D3A015D76F832FC64A483F81672F2848C71419AA807C51DBACFC84E070B08A6DF630C8BFC1ED2E092D99462223D40D5731067DBE7324D2451C726	A107075B8871261B
ssp.nuoro@gmail.com	E8A4658E356EFCC21D2FDCDB295C6D667F834CF1DFEA71C20585FA7293000EDEC7E97E5C712246B6B046E711951BF23C6ACA840B8D49ECA8BC83ACA7F9EBA72F	D7468B7D829F9E36
ssp.oristano@gmail.com	59E1764A16EB0D73CAC4E3BE04AC35131768A445193DFDD3819F4D98DA9DE5F8A5E62CF3892374E1AD17593ED9DD6D0A38ABC88FAE17B68FA7F5CBB63B4591C7	AC674795195E1215
ssp.padova@gmail.com	BEEFDA1A6E8B861C00A8EAFFF28F1353D65A14EEFA49543CBF12CE2515C76E2263AF39E87C278676FD6EC2850F60F3F2A1EA36458CF8C4C7ABCC295C8219C3B1	2D53CE4FF83E8B5D
ssp.palermo@gmail.com	A26631C3867EA6CEA4CEDB89FAA8ADF364513C6FD3BD70E82D75853C97045181F9EDB11AE45F5293EB3EDEC55FA58F490C019504A95BE3BAD529FEBD888263E2	82526CD15B453BE3
ssp.parma@gmail.com	8FDD6A8B1D993278D8DC1079D36B6B48353997B9BE7A8A4A4CE288D3C0F02E86F9CE1A4D82406CB625025B48E66DC9FAB8D7449BE55DF71EF806620D5F2C62CE	78F5DC3A1C695BB6
ssp.pavia@gmail.com	9796201FC68928F0008F45EF9D44220D1277071D1045AD76003CE5BE3E48907EA517DB65A1AAA56B00D4BFF8D51825608875AAEB1E0754895C5844E012F7D38E	60A9471867DD7855
ssp.perugia@gmail.com	E0F4FDF4E7F0B28EA7BD58D30F54CB78B4A3DA64CF9833A9A7D1DDB7319277FE4F7467630B9B22120246553C12C484F47130C3E3247B444C55D680D7A0EC6D7A	877101164188FF40
ssp.pesarourbino@gmail.com	0DF95805FAB04C46956D1670492B8458AB83EF9B009B53BF0F3BFC7BAD313D3DC86CE3235B70848791F69D1D1F69AAF96CA2ACDC7717BBD92BFB39684B0C52F2	4ECCD916469B7F14
ssp.pescara@gmail.com	A9D15195CDB4EF292715CC0EB08CA6E5BB36815C104A243CB785ED90F89EFB0B565C1C41687BDCC95B87805ED8C49FF4A6F2ADAE6C326BE925733AD69AC519A0	0F37EE71D8F0B54B
ssp.piacenza@gmail.com	8438E3BDCD55B661F71795AE8EDA44BF2D0392AEA646A01642EFE21F4EC142A81A6FD86E654C3C807EE123578E8C7B84FE6C05CCFAF361603210EBDCEF7A65CF	ADEB25CEC4BDF6D2
ssp.pisa@gmail.com	940363EBA6537F84CAFEEF175281A451F6322A9608CF788372FFC50D3C685B2F86A4456079A2CE4B47A1B6F61EB9B788261E660669C18FE18DDD5867205AE728	EB0102F0ED787342
ssp.pistoia@gmail.com	7F7159893E96F092F1577639B4073B5EC0474743AB6B98DE43565DC73E1E700F30F64B0F4B03F1994B2B6E239C0495ED14FFDE9A3F8255215D3AF3071A2A5C8B	C0FDC92DE2D4A340
ssp.pordenone@gmail.com	693CB33379D131DD5C793ED3CD4941D130BC287294457119A444CA75E5CE44DFE839AC13CD45D10D0AA27D681F8474809A1492019647BFFB761FA215F35901C9	BE4422C25F246CA0
ssp.potenza@gmail.com	4ABE6CE0B9811FC61BBC648D69577EC291F75506F737E2AF11D1DDA72DE7ECE55190C40372D8FAC62F3918409FF3C7F04B97FB5F891E9FECC069CE6EFA0FE341	D7F2127A82DC8532
ssp.prato@gmail.com	FD0808AC69B1ED14D91CA74136709A314F23F7C2558A1421C6F3CE47B174604683C8BFD7D11DB7B33ADA9B0E5BBCAFDEDCABFC338C46D1460B1CC06B95FFB99A	6DE6BD979B35BFB5
ssp.ragusa@gmail.com	83AE22EA8A38BF985D8861C001845DBD6AE0CDF478961D27449494C3D14F34189CDABA006D7E868FC75D55C1CA3ADCEFB0903084F1A19411A00B222B5C65E37C	C00F5BB6F2671D4B
ssp.ravenna@gmail.com	753522612CFE181950A39654CAFDD7E130038168031F5189DC2F6ACEEBA57CA0266E6B342683944A1C1D271A4B8A935D57123ECFB74BC4870252DCD485867A8A	506B1EB95EB308C5
ssp.reggioemilia@gmail.com	E6D2E5F3FD6CABDBE46C50526E2352DFCA5A6AAB5AAF97D81AD21F67A3D31DE6BD1256429540FE8223E2ECFADC7DF2F520ACE40A343E986AF1780EE56AE04DA2	AE855CD494FCB9D3
ssp.rieti@gmail.com	7B7289F78120000D6CFC8A5D70DD67BA82EC865CD36F03CB6D00308755A1E0A6349F85153FD12B21C808C67E19E378715BC1E3DB7C2F39526EC3F9547506A33B	FD869741EBF03295
ssp.rimini@gmail.com	D095887BC83C5621A86718581FCFDE3BD809F2A7AF90BED9B368B9C54468E762590F789EA422AC7A2A4E79CC9B5A21699AFEE9356632669E8CBA77BB8D5AA668	4AD69B8042FC05D0
ssp.roma@gmail.com	7A2FF5EA4DB7E70C420A89C391661DCA1B43BA3296735CE0608EB92A0CECCD404A33245855C1503020FD17F8D79DD1F277B464D76531CCF56B55218E9D0DB5F2	C3F3F35AE22F3D1A
ssp.rovigo@gmail.com	B7D885F9536F71E96951C6B19D9BA1FA73E32CC7A9DFDD46EC4FF8901F027D0AC6DCEA107D62E154F4AE2FEE94A645DDD686D17B7E79C6875DA6BD3A89C41124	CF78F0CB92EBAFD0
ssp.salerno@gmail.com	156971C5DC429972D0D0B53CA4ECB6A691BA0D500E545BBACC856D07A7AA26D0BB1519B0851935965139951B0870E615DDFA80B1CDD06FE2561E2C430447CF1B	2FE56CD24C4FF0B0
ssp.sassari@gmail.com	D97C1417F2DBB4C06BEFE1F659441B85F9ED0106517453895866446CE7FCD35F88C609EB279F2348131AB9B256A17CE6A6FC158455773EBD967708C5124AE579	887DE2B2BECD18CD
ssp.savona@gmail.com	B329A0488CADF34F3960FA3BF53AF06304272379EC16CFDF805CAAF92185866011E27A9DE6623C23F27E6ED8B2A53D2B92D3A40E83B12BD5B67B3FD24F0EE231	3DD6E1037F7D7E3B
ssp.siena@gmail.com	63C0727FFC8EFA9BD376BE35EBD6545EFDFCC84904182529B78DBA9E513469DDCF88A55C7177DCCFE051424E9447A5C34653A5519FAB72A57CE797327C71E5B4	E54EF846C184DDFF
ssp.siracusa@gmail.com	19DBC3514317BFE6E2D44E71E696F295F08C4DC550033D601B808D61236608CBD83483612931F069C4C3AFB36C4B87C40C2C67F5AF45B46369976A57481CCD07	C533203514B4EE5C
ssp.sondrio@gmail.com	E007BD6DC674BB6F4F88A6F79359A99E1E2128D2AE5EBAFC3E5F1618F3D30EF1FDF69279FE77F63E10653AEFA73E4546A498B211FA0E45B75E5234466F11E5FA	DAA344BBA5C014DF
ssp.taranto@gmail.com	82B415D6F7E94332C3ED75C80399F62345356FFE2FC0089B13B49AB4D3C99DDB9E47DCC1027F78247F42E6980D5D7AE9283109BEE5E1473912F4CA3FC986A6B5	4E50FBB9F3D2B639
ssp.teramo@gmail.com	3FAFAC4BEEFA3D4C2B97E8E2EA3A2E2B759497F3BD90D1242E09A0AA5F8D37D68C68AD52DBB63D9AE4BDF066052A9CA7F035650C9ACB4115142730BA29E9A000	58C140D00964B07D
ssp.terni@gmail.com	BAA9E881BF975BADB532F9DA22F65189A6BA4C5D05B3B24280C2526753110BBCEB18CF2A1DDC1D6D40CD2C5ED4FE35A7C7327629CFDD877D76EDDE71D0D044AE	E91328556216F125
ssp.torino@gmail.com	7364E02FD84A074B31F49FB86249B2BF82BA5639099AFD9F82C83A62AE842795558E7248FFB939336F7A2494FD2247C752FD32C704A2F1BEFEB22F384BCB8E09	2C954366B7E6CDCD
ssp.trapani@gmail.com	F20DA4808699C10C583930E76D27F0FC0A275113A23DF1AFD032E17BBC097CED6DC4D946AFC311DA0BE77A305B31EA5A5E9826E8473318C1B2920944473B2020	BBD32634938FBB6F
ssp.trento@gmail.com	DDA691B7B47C00A5333291396051C0071575B93A72A86E9818B7E0AD7D50272C3BE5016F2AB0FB1BA9573166D15C78507F22D12CD18B3D0C47142CFEDBFAE05A	D2C9B3664C3A810C
ssp.treviso@gmail.com	73496065138A809166CD06CE454C79903D60C8A466241EF72FA3A4418644026D5519D64C2AED68956AFCF45726DCCE62038F1F938E20CC0561F00247A039C3CB	F18EDF870A711DDE
ssp.trieste@gmail.com	B1DC8CBE597228DD789D3AD743134F5F2A86BCAD06C95833BCA7E62A0B9B310124B46B387D91DB38680A37AD876D4BA1924D5420A23ABD880B4417EB500C6DC1	8A50747035507FDC
ssp.udine@gmail.com	5E8E96C38212B3FCADACEF086A6B865DD281EB1FFE3421D06AD305DE7A6E2A8439633C68A3BADA00B7A88338A4ECF4E7D62120558B2571C3E3DBA4F681380075	2E2EE058488B3B0E
ssp.aosta@gmail.com	716FA8814D58C3B362B67F90DED646B8DC756F4B7D2A63D70305839C90C6B108750743FAF0E22C84EB05495A82554C65D34C54BDEA8991E587D751C99E1A778A	2CDE39CE5B3F899C
ssp.varese@gmail.com	3B90988A67F1B6394F777970981DEF235908D2F25D91BCD801D4570C188F54ECB3BB7E91F65F11AC262285529F4EEB7A0D3086DBE45FD94B424A0DA5CC4DF315	7E3722F0EBA92863
ssp.venezia@gmail.com	ADE4A9F9CC1D3B8687A7AB256BD82E996DC4F1F125C440F2DB6E7654B2D0C2856156F51F8B51AC3EDCED810E3F632469BEB7E1BB535C82FDE2E4C62FD7414AFA	1F0C3F86B4A46781
ssp.verbanocusioossola@gmail.com	14224B0C3F3A377A815EF211A1B4820C3F92D8A97C2D238ABF05A2F96819A0187F3625A6A4F6166FE4256806C90872934BC0BB742CCC885A21FD2906A02BFE8B	B197449DD9EEBA91
ssp.vercelli@gmail.com	524E10F9219390CE95E081E444BF6DD4A11843E16E07445257049C0456B381676FD5AD18D51F36F42F1E48EA13BDD5F7EF87028DC1EEBB188DEBE5AFFAAE2FA8	4DD5BC7EE644EDA9
ssp.verona@gmail.com	F8A9B35ADB8B94925343F62FF26E31F5B282BEC7D5499E8FE6FC3F3CD9E6E2724F4E75FA5AF2BCDC38B84917B8468D26C3DD9824DCB1DED404EE783234E0BC54	13EE0D245755E8E2
guglielmo.curci@libero.it	4FB10BDE5AC53B08C1A04A5806CC09D022E1A149B00E2B28DA269CF7DB463BD997F07452CA78B9ABBFC1A7B4AD6A7D7624AE0A03D1C984C0688FEB4017495E80	142898D39B38E2DC
ssp.vicenza@gmail.com	F7B21021648BB2E4C8AD99768BE7092F5F2BE1514AE92C73E573160BD5F2D3BEBB00E1C7B60179C69E3ECEE7B7F48B6F80CE2C978F3ACB9A0B77FE129929A5E0	2DF45E6F70EF9535
ssp.viterbo@gmail.com	4FDA44EB38B7CBDC36E2F258B37C1F838A87CF6F6A1086C1F1B37F11E7003A1D0E03F442775D22AB47015BC2A33C0B186A5BF8F3BD0BC387A7B3D0AAC8AFD879	0B66DDACD5794D4D
ssp.sudsardegna@gmail.com	88491331DD80D25E5782B9A3F656C4307F272F7839FADD7C593B61D84D2D68F7DAA33D3D780C80ABE07C35510AF1F9729F085B5ECE8A5A5F84AB39FB37044515	90442C781C915C0A
ssp.laquila@gmail.com	0FB120B79111A7F86493BFF4169E90C7A85F38EB39306D91067B24409BDEE3AA690B6F9C4125005ABC34C00E63202D0C76CA0F1BFABBAE5C1034F76714312B0C	4511DC018308FDDA
ssp.reggiocalabria@gmail.com	2DD28E7C8E74B00E681475715173A49F5A14CDD4DDF86E1A0B551F3BC57A5ADBABD8685453B35710A83A4B381C8125CB51616A09391ADBA724FD0A5295BC771A	D60A9C8851EE76B9
giovanna.rosiello@virgilio.it	1DC0B0842D4EBED6FFC3DA7A79D66E130AD62CF0FD6303C7202020272369AB5A40022AADC8034C075F6141895233AB7EA0BC9DC8FB9D6316D02DFBFDEAD70E10	E73C655E0CBCF6EA
stefani.dandolo@libero.it	7A3F64E46421186D0D6CC4610E8A3710FB389DEEA81CB6B3952C4C5DF3AD87E910A05DE9838A9281B0C85D2036524D7846DD3E45FA5A1DFA900FB5D4CDADB19F	BF622CE54C7AF195
ssp.ascolipiceno@gmail.com	243EC6EF8A1AB200AFD4117732E34457F70839AA0B77C7C940DC496A8891F884B8800076DACFBF2A555104CC03AC8DF13C1ED33D3A0686D4246DB93E6B830853	695056656A8A2C5A
ssp.laspezia@gmail.com	0FD491DED8D0A690CC5C1FDA22440BB3B2280E7951C928F7893732C45A8B3D4640FC315484F2208979BB8AF808DB2120DC6415124066C4D497618A138D3FF256	49B330209AA8B78C
ssp.vibovalentia@gmail.com	4B613904276720875DB61C5ECD4E5F6968865D57A130BBCE14B150C3D06DC92D8081556DC7F66429915A60349B0C4687A810B68559B0F1A0872BD372364063EB	9276113C0532879F
etta.gemito@libero.it	6F85E3FF7EB95063F784253B1E25701A636A2F0B14EB9CD5DF63FFA1A338C8DF29732C5DC8BD5D4785739C93D59562133C3A53EB59FF752A1E4F174D3C786869	A07BA75AC3C6E805
uberto.turchi@gmail.com	D2DDC4408D4F1AE001C5D61C8AEB442A1D8E08775517CD0D3448D89D129C58AF87B5B1D1325051A6FAE0A770807E076A5269A785D9DC6B0C491078E31AA7005C	EE0671E36D46274D
lorenzo.vigliotti@yahoo.it	619DF267A4F954954034B76F32E4A283D8644A81AC856B101A6A099BDC481CFD7FB7A196BC4201BF19105A9884022DD23C71313A62351E9D65E88FD8F8EC9777	C2E2031C347DB616
patrizia.ramazzotti@gmail.com	637FB666DE1FAC730C38028FE4533A5E73AD14D5EFDA16C4CE1798170AA48DCC5459A28BE9045C7EC46EED89B3E727B998944E7852C031D91710AB9A9ACBC590	0752E0A847E44DA5
lilla.parini@virgilio.it	5D315C0D770579F575B9A172224B38B56422806D2658FE29730E1EFE177666C5EC40A469113D739F54E8E681B8C6C775D82682A27686506C177199DF5EC7C739	983E1C60361431F2
giorgia.calbo@gmail.com	4D3E160F3AEBB140E4580B1092FDB19C6D434E2E901E05BF9C48AE84E9B78FD1B4564B3BF228169BD753A05575267FC8D3D68E34A893155D9F2D56AF581D0BEA	0E19A112D8580057
alfio.camuccini@yahoo.it	788C2923E4DA05333BFF70C2665B5ADFD5A506E42DD549E69911FBC5B3613BB9C9C1B735950531876164F06EE6FFD49E48FD85D7034BD77BBF8FD53FE72D237E	23A72C6E2806C127
barbara.murialdo@gmail.com	8F3AAD363FDC4D75467D3D46C21513E3801879D285E6134C61F4F1E76F31680C28F42D8F871E99ABCF7C54720AA5E759732342364C48C164336B664D50A2FF43	4681F90C4CDE45E7
alessandra.bettoni@libero.it	6715AC7D900DF959CBD5B1B418F07E6921C50E28D0D593A8E1EE37B0D92C2C70F7E41D4B21CA342D495C0A26A7EFC0FF0A69893C846C603C3486C2AF45810448	B9B8AF6B6C714F58
ludovico.pratesi@virgilio.it	C57E8454CB2F2ABE58DD3ECFB63FE4F73241F093893C1CC06CB6D61735050D1FF6DA255EF1DEA1CED95FCAF0767ECA9DA75F075E1B4B8056A195B1CCABAECA2E	9D35430D3F2C10A3
laureano.comboni@hotmail.com	E5BC81707A3B6CFED79143B602E0A08393C1B5868CC118B2F82AE7CFAC423CB2C2DB44DFCE07C04BD143C326E593F45A3B8296034D969F1474B55DAB40E08AD7	F8FC143A6880DC21
flavia.bellocchio@virgilio.it	0485B35F177CDF0C0E57E49528F31EDCE708B2062BB183D89D0341A62C6F81AA81E292AAE9089F3BBB546A1A2CEB4B5FA217A94EA39D5ED40EE846883309DF98	34986AF790BB8175
alfredo.desio@yahoo.it	DFD15458013126DA8972B384B934B8A32F01A67B5B3C2DCE33941A5465C25D320F0C8E1AFF0F53251D3EC2E58612764E8D94AA111EEB8E204D3047B9260E45FA	83C5D1F9853FBC62
massimiliano.maggioli@virgilio.it	AE8F45DD1DDDED6A5EA977047A9C2924BE6EF6D8967AADDD1D2E40E7DA2314DF08ADA90A36D7B58C55C38F3E1D94EEDCB762E7472599B6A1E1474717646381E2	1105E581A3DA2CCC
ida.moresi@yahoo.it	3DDD58B2159F127022E586D1174929A312C1F18FBB613D92D122158E97A55C9340180249F37CB01E0FD6A7DDD7CD622A6DDC7478A6C51E5C21EF9CC8DAFD5D8B	41047AB9F3459669
\.


--
-- Data for Name: visit; Type: TABLE DATA; Schema: public; Owner: guhncjua
--

COPY public.visit (visit_id, practitioner_id, patient_id, visit_date, report_available, report, booked) FROM stdin;
20	giorgio.barcaccia@yahoo.it	orlando.boito@virgilio.it	2019-12-26 11:34:00	t	Il paziente è in un ottimo stato di salute.	t
\.


--
-- Name: drug_list_drug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guhncjua
--

SELECT pg_catalog.setval('public.drug_list_drug_id_seq', 682, true);


--
-- Name: drug_prescription_drug_prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guhncjua
--

SELECT pg_catalog.setval('public.drug_prescription_drug_prescription_id_seq', 31, true);


--
-- Name: exams_exam_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guhncjua
--

SELECT pg_catalog.setval('public.exams_exam_id_seq', 154, true);


--
-- Name: exams_list_exam_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guhncjua
--

SELECT pg_catalog.setval('public.exams_list_exam_id_seq', 2859, true);


--
-- Name: photo_new_photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guhncjua
--

SELECT pg_catalog.setval('public.photo_new_photo_id_seq', 60, true);


--
-- Name: recall_recall_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guhncjua
--

SELECT pg_catalog.setval('public.recall_recall_id_seq', 31, true);


--
-- Name: temp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guhncjua
--

SELECT pg_catalog.setval('public.temp_id_seq', 15828, true);


--
-- Name: visit_visit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guhncjua
--

SELECT pg_catalog.setval('public.visit_visit_id_seq', 20, true);


--
-- Name: chemist chemist_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.chemist
    ADD CONSTRAINT chemist_pkey PRIMARY KEY (chemist_id);


--
-- Name: doctor_exams doctor_exams_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.doctor_exams
    ADD CONSTRAINT doctor_exams_pkey PRIMARY KEY (doctor_id, exam_id);


--
-- Name: drug_type drug_list_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.drug_type
    ADD CONSTRAINT drug_list_pkey PRIMARY KEY (drug_id);


--
-- Name: drug_prescription drug_prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.drug_prescription
    ADD CONSTRAINT drug_prescription_pkey PRIMARY KEY (drug_prescription_id);


--
-- Name: exam_type exams_list_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam_type
    ADD CONSTRAINT exams_list_pkey PRIMARY KEY (exam_id);


--
-- Name: exam exams_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exams_pkey PRIMARY KEY (exam_id);


--
-- Name: general_practitioner general_practitioner_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.general_practitioner
    ADD CONSTRAINT general_practitioner_pkey PRIMARY KEY (practitioner_id);


--
-- Name: health_service health_service_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.health_service
    ADD CONSTRAINT health_service_pkey PRIMARY KEY (health_service_id);


--
-- Name: password_reset password_reset_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.password_reset
    ADD CONSTRAINT password_reset_pkey PRIMARY KEY (user_id);


--
-- Name: password_reset password_reset_token_key; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.password_reset
    ADD CONSTRAINT password_reset_token_key UNIQUE (token);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (patient_id);


--
-- Name: photo photo_new_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_new_pkey PRIMARY KEY (photo_id);


--
-- Name: province province_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (province_abbreviation);


--
-- Name: recall recall_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.recall
    ADD CONSTRAINT recall_pkey PRIMARY KEY (recall_id);


--
-- Name: specialized_doctor specialized_doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.specialized_doctor
    ADD CONSTRAINT specialized_doctor_pkey PRIMARY KEY (doctor_id);


--
-- Name: comune temp_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.comune
    ADD CONSTRAINT temp_pkey PRIMARY KEY (comune_id);


--
-- Name: user_ user__pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT user__pkey PRIMARY KEY (user_id);


--
-- Name: visit visit_pkey; Type: CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_pkey PRIMARY KEY (visit_id);


--
-- Name: unique_pending_exam_by_type; Type: INDEX; Schema: public; Owner: guhncjua
--

CREATE UNIQUE INDEX unique_pending_exam_by_type ON public.exam USING btree (patient_id, exam_type) WHERE ((booked IS FALSE) AND (done IS FALSE) AND ((doctor_id IS NULL) OR (health_service_id IS NULL)));


--
-- Name: unique_pending_visit; Type: INDEX; Schema: public; Owner: guhncjua
--

CREATE UNIQUE INDEX unique_pending_visit ON public.visit USING btree (practitioner_id, patient_id) WHERE (booked IS FALSE);


--
-- Name: chemist chemist_chemist_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.chemist
    ADD CONSTRAINT chemist_chemist_province_fkey FOREIGN KEY (chemist_province) REFERENCES public.province(province_abbreviation);


--
-- Name: chemist chemist_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.chemist
    ADD CONSTRAINT chemist_email_fkey FOREIGN KEY (chemist_id) REFERENCES public.user_(user_id);


--
-- Name: comune comune_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.comune
    ADD CONSTRAINT comune_province_fkey FOREIGN KEY (province) REFERENCES public.province(province_abbreviation);


--
-- Name: doctor_exams doctor_exams_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.doctor_exams
    ADD CONSTRAINT doctor_exams_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.specialized_doctor(doctor_id);


--
-- Name: doctor_exams doctor_exams_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.doctor_exams
    ADD CONSTRAINT doctor_exams_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.exam_type(exam_id);


--
-- Name: drug_prescription drug_prescription_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.drug_prescription
    ADD CONSTRAINT drug_prescription_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: drug_prescription drug_prescription_practitioner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.drug_prescription
    ADD CONSTRAINT drug_prescription_practitioner_id_fkey FOREIGN KEY (practitioner_id) REFERENCES public.general_practitioner(practitioner_id);


--
-- Name: exam exam___recall_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam___recall_fkey FOREIGN KEY (recall) REFERENCES public.recall(recall_id);


--
-- Name: exam exam_health_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam_health_service_id_fkey FOREIGN KEY (health_service_id) REFERENCES public.health_service(health_service_id);


--
-- Name: exam exam_practitioner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam_practitioner_id_fkey FOREIGN KEY (practitioner_id) REFERENCES public.general_practitioner(practitioner_id);


--
-- Name: exam exams_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exams_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.specialized_doctor(doctor_id);


--
-- Name: exam exams_exam_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exams_exam_type_fkey FOREIGN KEY (exam_type) REFERENCES public.exam_type(exam_id);


--
-- Name: exam exams_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exams_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: general_practitioner general_practitioner_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.general_practitioner
    ADD CONSTRAINT general_practitioner_email_fkey FOREIGN KEY (practitioner_id) REFERENCES public.user_(user_id);


--
-- Name: general_practitioner general_practitioner_working_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.general_practitioner
    ADD CONSTRAINT general_practitioner_working_province_fkey FOREIGN KEY (working_province) REFERENCES public.province(province_abbreviation);


--
-- Name: health_service health_service_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.health_service
    ADD CONSTRAINT health_service_email_fkey FOREIGN KEY (health_service_id) REFERENCES public.user_(user_id);


--
-- Name: health_service health_service_operating_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.health_service
    ADD CONSTRAINT health_service_operating_province_fkey FOREIGN KEY (operating_province) REFERENCES public.province(province_abbreviation);


--
-- Name: password_reset password_reset_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.password_reset
    ADD CONSTRAINT password_reset_email_fkey FOREIGN KEY (user_id) REFERENCES public.user_(user_id);


--
-- Name: patient patient_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_email_fkey FOREIGN KEY (patient_id) REFERENCES public.user_(user_id);


--
-- Name: patient patient_general_practitioner_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_general_practitioner_email_fkey FOREIGN KEY (practitioner_id) REFERENCES public.general_practitioner(practitioner_id);


--
-- Name: patient patient_living_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_living_province_fkey FOREIGN KEY (living_province) REFERENCES public.province(province_abbreviation);


--
-- Name: photo photo_new_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_new_email_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: recall recall_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.recall
    ADD CONSTRAINT recall_exam_id_fkey FOREIGN KEY (exam_type) REFERENCES public.exam_type(exam_id);


--
-- Name: recall recall_health_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.recall
    ADD CONSTRAINT recall_health_service_id_fkey FOREIGN KEY (health_service_id) REFERENCES public.health_service(health_service_id);


--
-- Name: specialized_doctor specialized_doctor_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.specialized_doctor
    ADD CONSTRAINT specialized_doctor_email_fkey FOREIGN KEY (doctor_id) REFERENCES public.user_(user_id);


--
-- Name: visit visit_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: visit visit_practitioner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guhncjua
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_practitioner_id_fkey FOREIGN KEY (practitioner_id) REFERENCES public.general_practitioner(practitioner_id);


--
-- PostgreSQL database dump complete
--

