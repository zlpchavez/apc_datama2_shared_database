--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 12.0

-- Started on 2019-12-05 14:25:17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 21 (class 2615 OID 16740)
-- Name: zpchavez; Type: SCHEMA; Schema: -; Owner: datama2mi182
--

CREATE SCHEMA zpchavez;


ALTER SCHEMA zpchavez OWNER TO datama2mi182;

--
-- TOC entry 1415 (class 1247 OID 20176)
-- Name: prog_type; Type: TYPE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TYPE zpchavez.prog_type AS ENUM (
    'P',
    'G',
    'J',
    'S'
);


ALTER TYPE zpchavez.prog_type OWNER TO datama2mi182;

--
-- TOC entry 1244 (class 1247 OID 21595)
-- Name: staff_type; Type: TYPE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TYPE zpchavez.staff_type AS ENUM (
    'T',
    'N'
);


ALTER TYPE zpchavez.staff_type OWNER TO datama2mi182;

--
-- TOC entry 1579 (class 1247 OID 22266)
-- Name: student_type; Type: TYPE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TYPE zpchavez.student_type AS ENUM (
    'O',
    'T',
    'N'
);


ALTER TYPE zpchavez.student_type OWNER TO datama2mi182;

SET default_tablespace = '';

--
-- TOC entry 309 (class 1259 OID 21025)
-- Name: classes; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.classes (
    id character varying(7) NOT NULL,
    class_time time without time zone NOT NULL,
    class_section character varying(20) NOT NULL,
    class_room integer NOT NULL
);


ALTER TABLE zpchavez.classes OWNER TO datama2mi182;

--
-- TOC entry 510 (class 1259 OID 24623)
-- Name: clinic; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.clinic (
    id integer NOT NULL,
    clin_sched time without time zone NOT NULL,
    clin_assign_doc character varying(1000) NOT NULL,
    clin_inventory character varying(1000) NOT NULL
);


ALTER TABLE zpchavez.clinic OWNER TO datama2mi182;

--
-- TOC entry 509 (class 1259 OID 24620)
-- Name: course; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.course (
    id integer NOT NULL,
    crs_title character varying(30) NOT NULL,
    crs_description character varying(1000) NOT NULL,
    crs_units integer NOT NULL,
    department_id character varying(10) NOT NULL,
    classes_id character varying(7) NOT NULL
);


ALTER TABLE zpchavez.course OWNER TO datama2mi182;

--
-- TOC entry 313 (class 1259 OID 21047)
-- Name: department; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.department (
    id integer NOT NULL,
    dept_name character varying(20) NOT NULL
);


ALTER TABLE zpchavez.department OWNER TO datama2mi182;

--
-- TOC entry 314 (class 1259 OID 21074)
-- Name: department_has_staff; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.department_has_staff (
    department_id integer NOT NULL,
    staff_id integer NOT NULL
);


ALTER TABLE zpchavez.department_has_staff OWNER TO datama2mi182;

--
-- TOC entry 515 (class 1259 OID 24690)
-- Name: medical; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.medical (
    id integer NOT NULL,
    med_bmi bytea NOT NULL,
    med_dental bytea NOT NULL,
    med_diseases character varying(1000) NOT NULL,
    med_allergies character varying(1000) NOT NULL,
    clinic_id integer NOT NULL
);


ALTER TABLE zpchavez.medical OWNER TO datama2mi182;

--
-- TOC entry 513 (class 1259 OID 24648)
-- Name: prog; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.prog (
    id integer NOT NULL,
    prog_level character varying NOT NULL,
    prog_type zpchavez.prog_type,
    school_id character varying(4) NOT NULL,
    department_id character varying(5) NOT NULL
);


ALTER TABLE zpchavez.prog OWNER TO datama2mi182;

--
-- TOC entry 315 (class 1259 OID 21077)
-- Name: school; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.school (
    id integer NOT NULL,
    sch_address character varying(100) DEFAULT '123 Sesame Street'::character varying NOT NULL,
    sch_name character varying(100) DEFAULT 'Philippine University of the Philippines'::character varying NOT NULL
);


ALTER TABLE zpchavez.school OWNER TO datama2mi182;

--
-- TOC entry 356 (class 1259 OID 21714)
-- Name: staff; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.staff (
    id integer NOT NULL,
    staff_fname character varying(100) NOT NULL,
    staff_mname character varying(100) NOT NULL,
    staff_lname character varying(100) NOT NULL,
    staff zpchavez.staff_type,
    sch_id integer
);


ALTER TABLE zpchavez.staff OWNER TO datama2mi182;

--
-- TOC entry 590 (class 1259 OID 27460)
-- Name: staff_school_views; Type: VIEW; Schema: zpchavez; Owner: datama2mi182
--

CREATE VIEW zpchavez.staff_school_views AS
 SELECT staff.id,
    staff.staff_fname,
    staff.staff_mname,
    staff.staff_lname,
    staff.sch_id,
    school.sch_name
   FROM (zpchavez.staff
     JOIN zpchavez.school ON ((staff.sch_id = school.id)));


ALTER TABLE zpchavez.staff_school_views OWNER TO datama2mi182;

--
-- TOC entry 373 (class 1259 OID 22710)
-- Name: student; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.student (
    id integer NOT NULL,
    stud_fname character varying(45) NOT NULL,
    stud_mname character varying(45) NOT NULL,
    stud_lname character varying(45) NOT NULL,
    stud_cor bytea NOT NULL,
    stud_phone integer NOT NULL,
    student zpchavez.student_type,
    stud_dob date NOT NULL
);


ALTER TABLE zpchavez.student OWNER TO datama2mi182;

--
-- TOC entry 516 (class 1259 OID 24702)
-- Name: student_has_class; Type: TABLE; Schema: zpchavez; Owner: datama2mi182
--

CREATE TABLE zpchavez.student_has_class (
    student_id integer NOT NULL
);


ALTER TABLE zpchavez.student_has_class OWNER TO datama2mi182;

--
-- TOC entry 4145 (class 0 OID 21025)
-- Dependencies: 309
-- Data for Name: classes; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.classes (id, class_time, class_section, class_room) FROM stdin;
\.


--
-- TOC entry 4152 (class 0 OID 24623)
-- Dependencies: 510
-- Data for Name: clinic; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.clinic (id, clin_sched, clin_assign_doc, clin_inventory) FROM stdin;
\.


--
-- TOC entry 4151 (class 0 OID 24620)
-- Dependencies: 509
-- Data for Name: course; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.course (id, crs_title, crs_description, crs_units, department_id, classes_id) FROM stdin;
\.


--
-- TOC entry 4146 (class 0 OID 21047)
-- Dependencies: 313
-- Data for Name: department; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.department (id, dept_name) FROM stdin;
1	Elmos World
2	Oscars Trash Can
\.


--
-- TOC entry 4147 (class 0 OID 21074)
-- Dependencies: 314
-- Data for Name: department_has_staff; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.department_has_staff (department_id, staff_id) FROM stdin;
1	12345
2	22345
\.


--
-- TOC entry 4154 (class 0 OID 24690)
-- Dependencies: 515
-- Data for Name: medical; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.medical (id, med_bmi, med_dental, med_diseases, med_allergies, clinic_id) FROM stdin;
\.


--
-- TOC entry 4153 (class 0 OID 24648)
-- Dependencies: 513
-- Data for Name: prog; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.prog (id, prog_level, prog_type, school_id, department_id) FROM stdin;
1	6	J	101	1010
2	5	J	202	2020
3	4	J	303	3030
\.


--
-- TOC entry 4148 (class 0 OID 21077)
-- Dependencies: 315
-- Data for Name: school; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.school (id, sch_address, sch_name) FROM stdin;
1	123 Sesame Street	Cartoon University
2	3 Humabon Place, Magallanes	Asia Pacific College
\.


--
-- TOC entry 4149 (class 0 OID 21714)
-- Dependencies: 356
-- Data for Name: staff; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.staff (id, staff_fname, staff_mname, staff_lname, staff, sch_id) FROM stdin;
42345	Oscar	The	Grouch	T	1
12345	Elmo	Red	Puppet	T	2
22345	Yellow	Big	Bird	N	1
32345	Cookie	Jar	Monster	N	2
\.


--
-- TOC entry 4150 (class 0 OID 22710)
-- Dependencies: 373
-- Data for Name: student; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.student (id, stud_fname, stud_mname, stud_lname, stud_cor, stud_phone, student, stud_dob) FROM stdin;
20190001	Juan	Dela	Cruz	\\x	912345678	O	2001-01-01
20190002	Happee	Valentines	Day	\\x	912345679	N	1999-02-14
\.


--
-- TOC entry 4155 (class 0 OID 24702)
-- Dependencies: 516
-- Data for Name: student_has_class; Type: TABLE DATA; Schema: zpchavez; Owner: datama2mi182
--

COPY zpchavez.student_has_class (student_id) FROM stdin;
\.


--
-- TOC entry 3979 (class 2606 OID 27218)
-- Name: school school_pk; Type: CONSTRAINT; Schema: zpchavez; Owner: datama2mi182
--

ALTER TABLE ONLY zpchavez.school
    ADD CONSTRAINT school_pk PRIMARY KEY (id);


--
-- TOC entry 3981 (class 2606 OID 27220)
-- Name: staff staff_pk; Type: CONSTRAINT; Schema: zpchavez; Owner: datama2mi182
--

ALTER TABLE ONLY zpchavez.staff
    ADD CONSTRAINT staff_pk PRIMARY KEY (id);


--
-- TOC entry 3982 (class 2606 OID 27221)
-- Name: staff school_id; Type: FK CONSTRAINT; Schema: zpchavez; Owner: datama2mi182
--

ALTER TABLE ONLY zpchavez.staff
    ADD CONSTRAINT school_id FOREIGN KEY (sch_id) REFERENCES zpchavez.school(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2019-12-05 14:25:18

--
-- PostgreSQL database dump complete
--

