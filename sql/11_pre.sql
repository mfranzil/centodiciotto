--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-1.pgdg16.04+1)
-- Dumped by pg_dump version 13.3 (Ubuntu 13.3-1.pgdg20.04+1)

SET
statement_timeout = 0;
SET
lock_timeout = 0;
SET
idle_in_transaction_session_timeout = 0;
SET
client_encoding = 'UTF8';
SET
standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET
check_function_bodies = false;
SET
xmloption = content;
SET
client_min_messages = warning;
SET
row_security = off;

CREATE TABLE public.chemist
(
    chemist_id       character varying(254) NOT NULL,
    name             character varying(255) NOT NULL,
    chemist_province character varying(5)   NOT NULL,
    working_place    text                   NOT NULL
);


ALTER TABLE public.chemist OWNER TO sqldiciotto;

--
-- Name: comune; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.comune
(
    comune_id integer NOT NULL,
    name      text,
    province  text,
    belfiore  text
);


ALTER TABLE public.comune OWNER TO sqldiciotto;

--
-- Name: doctor_exam; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.doctor_exam
(
    doctor_id character varying(254) NOT NULL,
    exam_id   integer                NOT NULL
);


ALTER TABLE public.doctor_exam OWNER TO sqldiciotto;

--
-- Name: drug_type; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.drug_type
(
    drug_id          integer NOT NULL,
    drug_description text
);


ALTER TABLE public.drug_type OWNER TO sqldiciotto;

--
-- Name: drug_list_drug_id_seq; Type: SEQUENCE; Schema: public; Owner: sqldiciotto
--

CREATE SEQUENCE public.drug_list_drug_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE CACHE 1;


ALTER TABLE public.drug_list_drug_id_seq OWNER TO sqldiciotto;

--
-- Name: drug_list_drug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqldiciotto
--

ALTER SEQUENCE public.drug_list_drug_id_seq OWNED BY public.drug_type.drug_id;


--
-- Name: drug_prescription; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.drug_prescription
(
    drug_prescription_id integer                NOT NULL,
    practitioner_id      character varying(254) NOT NULL,
    patient_id           character varying(254) NOT NULL,
    drug_type            integer                NOT NULL,
    date_prescribed      timestamp without time zone NOT NULL,
    date_sold            timestamp without time zone,
    chemist_id           character varying(254),
    ticket               integer                NOT NULL,
    ticket_paid          boolean DEFAULT false  NOT NULL,
    description          text,
    CONSTRAINT drug_prescription_check CHECK ((NOT ((ticket_paid IS TRUE) AND (chemist_id IS NULL) AND (date_sold IS NULL))))
);


ALTER TABLE public.drug_prescription OWNER TO sqldiciotto;

--
-- Name: drug_prescription_drug_prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: sqldiciotto
--

CREATE SEQUENCE public.drug_prescription_drug_prescription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE CACHE 1;


ALTER TABLE public.drug_prescription_drug_prescription_id_seq OWNER TO sqldiciotto;

--
-- Name: drug_prescription_drug_prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqldiciotto
--

ALTER SEQUENCE public.drug_prescription_drug_prescription_id_seq OWNED BY public.drug_prescription.drug_prescription_id;


--
-- Name: exam; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.exam
(
    exam_id           integer                NOT NULL,
    patient_id        character varying(254) NOT NULL,
    doctor_id         character varying(254),
    exam_type         integer                NOT NULL,
    done              boolean DEFAULT false  NOT NULL,
    date              timestamp without time zone,
    result            text,
    health_service_id character varying(254),
    ticket            integer                NOT NULL,
    ticket_paid       boolean DEFAULT false  NOT NULL,
    practitioner_id   character varying(254),
    booked            boolean DEFAULT false  NOT NULL,
    recall            integer,
    CONSTRAINT exam_check CHECK (((NOT booked) OR (date IS NOT NULL))),
    CONSTRAINT exam_check1 CHECK ((NOT ((NOT booked) AND ticket_paid))),
    CONSTRAINT exam_check2 CHECK (((NOT done) OR booked)),
    CONSTRAINT exam_check3 CHECK (((NOT (result IS NOT NULL)) OR done)),
    CONSTRAINT exam_check4 CHECK (((NOT (recall IS NOT NULL)) OR (doctor_id IS NOT NULL) OR
                                   ((NOT (recall IS NOT NULL)) OR (NOT booked)) OR
                                   ((NOT (recall IS NOT NULL)) OR (health_service_id IS NOT NULL)))),
    CONSTRAINT performed_not_both_chk CHECK (((booked IS FALSE) OR
                                              (NOT ((doctor_id IS NOT NULL) AND (health_service_id IS NOT NULL))))),
    CONSTRAINT performed_not_null_chk CHECK (((booked IS FALSE) OR
                                              ((doctor_id IS NOT NULL) OR (health_service_id IS NOT NULL)))),
    CONSTRAINT ticket_paid CHECK ((NOT ((ticket_paid IS TRUE) AND (done IS FALSE))))
);


ALTER TABLE public.exam OWNER TO sqldiciotto;

--
-- Name: exam_type; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.exam_type
(
    exam_id          integer NOT NULL,
    exam_description text
);


ALTER TABLE public.exam_type OWNER TO sqldiciotto;

--
-- Name: exams_exam_id_seq; Type: SEQUENCE; Schema: public; Owner: sqldiciotto
--

CREATE SEQUENCE public.exams_exam_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE CACHE 1;


ALTER TABLE public.exams_exam_id_seq OWNER TO sqldiciotto;

--
-- Name: exams_exam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqldiciotto
--

ALTER SEQUENCE public.exams_exam_id_seq OWNED BY public.exam.exam_id;


--
-- Name: exams_list_exam_id_seq; Type: SEQUENCE; Schema: public; Owner: sqldiciotto
--

CREATE SEQUENCE public.exams_list_exam_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE CACHE 1;


ALTER TABLE public.exams_list_exam_id_seq OWNER TO sqldiciotto;

--
-- Name: exams_list_exam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqldiciotto
--

ALTER SEQUENCE public.exams_list_exam_id_seq OWNED BY public.exam_type.exam_id;


--
-- Name: general_practitioner; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.general_practitioner
(
    practitioner_id  character varying(254) NOT NULL,
    first_name       character varying(255) NOT NULL,
    last_name        character varying(255) NOT NULL,
    working_province character varying(5)   NOT NULL,
    working_place    text                   NOT NULL
);


ALTER TABLE public.general_practitioner OWNER TO sqldiciotto;

--
-- Name: health_service; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.health_service
(
    health_service_id  character varying(254) NOT NULL,
    operating_province character varying(5)   NOT NULL
);


ALTER TABLE public.health_service OWNER TO sqldiciotto;

--
-- Name: password_reset; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.password_reset
(
    user_id       character varying(254) NOT NULL,
    token         character varying(64)  NOT NULL,
    expiring_date timestamp without time zone
);


ALTER TABLE public.password_reset OWNER TO sqldiciotto;

--
-- Name: patient; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.patient
(
    patient_id      character varying(254) NOT NULL,
    first_name      character varying(255) NOT NULL,
    last_name       character varying(255) NOT NULL,
    birth_date      timestamp without time zone NOT NULL,
    birth_place     character varying(255) NOT NULL,
    ssn             character varying(16)  NOT NULL,
    gender          character(1)           NOT NULL,
    practitioner_id character varying(254) NOT NULL,
    living_province character varying(5)   NOT NULL,
    living_place    text                   NOT NULL
);


ALTER TABLE public.patient OWNER TO sqldiciotto;

--
-- Name: photo; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.photo
(
    photo_id    integer                NOT NULL,
    patient_id  character varying(254) NOT NULL,
    upload_date timestamp without time zone DEFAULT now() NOT NULL,
    extension   character varying(6)   NOT NULL
);


ALTER TABLE public.photo OWNER TO sqldiciotto;

--
-- Name: photo_new_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: sqldiciotto
--

CREATE SEQUENCE public.photo_new_photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE CACHE 1;


ALTER TABLE public.photo_new_photo_id_seq OWNER TO sqldiciotto;

--
-- Name: photo_new_photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqldiciotto
--

ALTER SEQUENCE public.photo_new_photo_id_seq OWNED BY public.photo.photo_id;


--
-- Name: province; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.province
(
    province_name   character varying(128) NOT NULL,
    province_id     character varying(2)   NOT NULL,
    province_region character varying(128) DEFAULT NULL:: character varying
);


ALTER TABLE public.province OWNER TO sqldiciotto;

--
-- Name: recall; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.recall
(
    recall_id         integer                NOT NULL,
    exam_type         integer                NOT NULL,
    min_age           integer                NOT NULL,
    max_age           integer                NOT NULL,
    start_date        timestamp without time zone NOT NULL,
    health_service_id character varying(254) NOT NULL,
    CONSTRAINT recall_check CHECK ((min_age < max_age))
);


ALTER TABLE public.recall OWNER TO sqldiciotto;

--
-- Name: recall_recall_id_seq; Type: SEQUENCE; Schema: public; Owner: sqldiciotto
--

CREATE SEQUENCE public.recall_recall_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE CACHE 1;


ALTER TABLE public.recall_recall_id_seq OWNER TO sqldiciotto;

--
-- Name: recall_recall_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqldiciotto
--

ALTER SEQUENCE public.recall_recall_id_seq OWNED BY public.recall.recall_id;


--
-- Name: specialized_doctor; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.specialized_doctor
(
    doctor_id     character varying(254) NOT NULL,
    first_name    character varying(255) NOT NULL,
    last_name     character varying(255) NOT NULL,
    working_place text
);


ALTER TABLE public.specialized_doctor OWNER TO sqldiciotto;

--
-- Name: temp_id_seq; Type: SEQUENCE; Schema: public; Owner: sqldiciotto
--

CREATE SEQUENCE public.temp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE CACHE 1;


ALTER TABLE public.temp_id_seq OWNER TO sqldiciotto;

--
-- Name: temp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqldiciotto
--

ALTER SEQUENCE public.temp_id_seq OWNED BY public.comune.comune_id;


--
-- Name: user_; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.user_
(
    user_id character varying(254) NOT NULL,
    hash    character varying(256) NOT NULL,
    salt    character varying(16)  NOT NULL
);


ALTER TABLE public.user_ OWNER TO sqldiciotto;

--
-- Name: visit; Type: TABLE; Schema: public; Owner: sqldiciotto
--

CREATE TABLE public.visit
(
    visit_id         integer                NOT NULL,
    practitioner_id  character varying(254) NOT NULL,
    patient_id       character varying(254) NOT NULL,
    visit_date       timestamp without time zone,
    report_available boolean DEFAULT false  NOT NULL,
    report           text,
    booked           boolean DEFAULT false  NOT NULL,
    completed        boolean DEFAULT false  NOT NULL,
    CONSTRAINT date_booked CHECK ((NOT ((visit_date IS NULL) AND report_available))),
    CONSTRAINT visit_check CHECK ((NOT (completed AND (NOT booked)))),
    CONSTRAINT visit_check1 CHECK ((NOT (report_available AND (report IS NULL)))),
    CONSTRAINT visit_check2 CHECK ((NOT (report_available AND (NOT completed)))),
    CONSTRAINT visit_check3 CHECK ((NOT ((report IS NOT NULL) AND (NOT report_available))))
);


ALTER TABLE public.visit OWNER TO sqldiciotto;

--
-- Name: visit_visit_id_seq; Type: SEQUENCE; Schema: public; Owner: sqldiciotto
--

CREATE SEQUENCE public.visit_visit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE CACHE 1;


ALTER TABLE public.visit_visit_id_seq OWNER TO sqldiciotto;

--
-- Name: visit_visit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqldiciotto
--

ALTER SEQUENCE public.visit_visit_id_seq OWNED BY public.visit.visit_id;


--
-- Name: comune comune_id; Type: DEFAULT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.comune ALTER COLUMN comune_id SET DEFAULT nextval('public.temp_id_seq'::regclass);


--
-- Name: drug_prescription drug_prescription_id; Type: DEFAULT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.drug_prescription ALTER COLUMN drug_prescription_id SET DEFAULT nextval('public.drug_prescription_drug_prescription_id_seq'::regclass);


--
-- Name: drug_type drug_id; Type: DEFAULT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.drug_type ALTER COLUMN drug_id SET DEFAULT nextval('public.drug_list_drug_id_seq'::regclass);


--
-- Name: exam exam_id; Type: DEFAULT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam ALTER COLUMN exam_id SET DEFAULT nextval('public.exams_exam_id_seq'::regclass);


--
-- Name: exam_type exam_id; Type: DEFAULT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam_type ALTER COLUMN exam_id SET DEFAULT nextval('public.exams_list_exam_id_seq'::regclass);


--
-- Name: photo photo_id; Type: DEFAULT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.photo ALTER COLUMN photo_id SET DEFAULT nextval('public.photo_new_photo_id_seq'::regclass);


--
-- Name: recall recall_id; Type: DEFAULT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.recall ALTER COLUMN recall_id SET DEFAULT nextval('public.recall_recall_id_seq'::regclass);


--
-- Name: visit visit_id; Type: DEFAULT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.visit ALTER COLUMN visit_id SET DEFAULT nextval('public.visit_visit_id_seq'::regclass);
