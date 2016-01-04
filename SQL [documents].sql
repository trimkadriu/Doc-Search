--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5rc1
-- Dumped by pg_dump version 9.5rc1

-- Started on 2016-01-04 00:29:58

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2148 (class 1262 OID 12373)
-- Dependencies: 2147
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 183 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2151 (class 0 OID 0)
-- Dependencies: 183
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 182 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2152 (class 0 OID 0)
-- Dependencies: 182
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 185 (class 3079 OID 16435)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 2153 (class 0 OID 0)
-- Dependencies: 185
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 184 (class 3079 OID 16446)
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- TOC entry 2154 (class 0 OID 0)
-- Dependencies: 184
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 16425)
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE documents (
    id integer NOT NULL,
    doc_text text NOT NULL
);


ALTER TABLE documents OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 16423)
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents_id_seq OWNER TO postgres;

--
-- TOC entry 2155 (class 0 OID 0)
-- Dependencies: 180
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- TOC entry 2024 (class 2604 OID 16428)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- TOC entry 2142 (class 0 OID 16425)
-- Dependencies: 181
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY documents (id, doc_text) FROM stdin;
8	The Third Man
9	Citizen Kane
10	All About Eve
11	Modern Times
12	Das Cabinet des Dr. Caligari.
13	A Hard Days Night
14	The Godfather
15	E.T. The Extra-Terrestrial
16	Metropolis
17	It Happened One Night
18	Inside Out
19	Singin in the Rain
20	Laura
21	The Adventures of Robin Hood
22	Repulsion
23	Boyhood
24	North by Northwest
25	King Kong
26	Snow White and the Seven Dwarfs
27	The Maltese Falcon
28	La Battaglia di Algeri
29	Rear Window
30	The Philadelphia Story
31	Sunset Boulevard
32	Toy Story 2
33	Rashômon
34	The Bride of Frankenstein
35	Toy Story 3
36	The Bicycle Thief
37	The 400 Blows
38	Lawrence of Arabia
39	Up
40	The Treasure of the Sierra Madre
41	Seven Samurai
42	Selma
43	12 Angry Men
44	The Night of the Hunter
45	Rebecca
46	Finding Nemo
47	The Conformist
48	Dr. Strangelove Or How I Learned to Stop Worrying and Love the Bomb
49	A Streetcar Named Desire
50	Rosemarys Baby
51	L.A. Confidential
52	Frankenstein
53	The Wrestler
54	The 39 Steps
55	The Grapes of Wrath
56	The Hurt Locker
57	The Last Picture Show
58	Tokyo Story
59	Pinocchio
60	The Wages of Fear
61	Toy Story
62	Man on Wire
63	Taxi Driver
64	Anatomy of a Murder
65	Roman Holiday
66	The Best Years of Our Lives
67	Annie Hall
68	The Leopard
69	Chinatown
70	Battleship Potemkin
71	Cool Hand Luke
72	The Searchers
73	On the Waterfront
74	The Rules of the Game
75	The Gold Rush
76	Mr. Turner
77	Before Midnight
78	Sweet Smell of Success
79	The Terminator
80	The Babadook
81	Short Term 12
82	Mary Poppins
83	Let the Right One In
84	Playtime
85	Brooklyn
86	The Wild Bunch
87	Mud
88	The French Connection
89	Invasion of the Body Snatchers
90	Shaun the Sheep
91	City Lights
92	Badlands
93	Aliens
94	The Discreet Charm Of The Bourgeoisie
95	Eyes Without a Face
96	How to Train Your Dragon
97	Mean Streets
98	Once Upon a Time in the West
99	The Manchurian Candidate
100	Gloria
101	Leviathan
102	Aguirre, der Zorn Gottes
103	The Sweet Hereafter
104	The Conversation
105	The Legend of Tarzan, Lord of the Apes
106	Lord of Illusions
107	Shall we Dance?
108	Dances with Wolves
109	Lord Jim
110	Lord of the Flies
\.


--
-- TOC entry 2156 (class 0 OID 0)
-- Dependencies: 180
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('documents_id_seq', 110, true);


--
-- TOC entry 2026 (class 2606 OID 16433)
-- Name: documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- TOC entry 2150 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-01-04 00:29:58

--
-- PostgreSQL database dump complete
--

