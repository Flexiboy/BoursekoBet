--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Homebrew)
-- Dumped by pg_dump version 14.17 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: companies; Type: TABLE; Schema: public; Owner: julienmp
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    name text NOT NULL,
    next_earnings date
);


ALTER TABLE public.companies OWNER TO julienmp;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: julienmp
--

CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO julienmp;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: julienmp
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: julienmp
--

CREATE TABLE public.votes (
    id integer NOT NULL,
    company_id integer,
    sentiment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT votes_sentiment_check CHECK ((sentiment = ANY (ARRAY['bearish'::text, 'neutral'::text, 'bullish'::text])))
);


ALTER TABLE public.votes OWNER TO julienmp;

--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: julienmp
--

CREATE SEQUENCE public.votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.votes_id_seq OWNER TO julienmp;

--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: julienmp
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: julienmp
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: julienmp
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: julienmp
--

COPY public.companies (id, name, next_earnings) FROM stdin;
1	Apple	2025-05-02
2	Microsoft	2025-05-03
3	Amazon	2025-05-05
\.


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: julienmp
--

COPY public.votes (id, company_id, sentiment, created_at) FROM stdin;
1	1	bearish	2025-04-30 23:35:52.063451
2	1	bullish	2025-04-30 23:35:53.055871
3	1	bullish	2025-04-30 23:35:53.737994
4	1	bullish	2025-04-30 23:35:54.045918
5	1	bullish	2025-04-30 23:35:54.201033
6	1	bullish	2025-04-30 23:35:54.357873
7	1	bullish	2025-04-30 23:35:54.500312
8	2	bullish	2025-04-30 23:35:55.595223
9	2	bullish	2025-04-30 23:35:55.750734
10	2	bullish	2025-04-30 23:35:55.888638
11	2	bullish	2025-04-30 23:35:56.029817
12	2	bullish	2025-04-30 23:35:56.180535
13	2	bullish	2025-04-30 23:35:56.328724
14	2	neutral	2025-04-30 23:35:57.135754
15	2	neutral	2025-04-30 23:35:57.563153
16	3	bullish	2025-04-30 23:35:58.765189
17	3	bullish	2025-04-30 23:35:58.922051
18	3	bullish	2025-04-30 23:35:59.089395
19	3	bullish	2025-04-30 23:35:59.24088
20	3	neutral	2025-04-30 23:35:59.717906
21	3	neutral	2025-04-30 23:35:59.87495
22	3	neutral	2025-04-30 23:36:00.032653
23	3	neutral	2025-04-30 23:36:00.447906
24	1	bearish	2025-04-30 23:37:18.506902
25	1	bearish	2025-04-30 23:37:18.650227
26	1	bearish	2025-04-30 23:37:18.803273
27	1	bearish	2025-04-30 23:37:18.969435
28	1	bearish	2025-04-30 23:37:19.134935
29	1	bearish	2025-04-30 23:37:19.309055
30	1	bearish	2025-04-30 23:37:19.457362
31	1	bearish	2025-04-30 23:37:19.611957
32	1	bearish	2025-04-30 23:37:19.777951
33	1	bearish	2025-04-30 23:37:19.933726
34	1	bearish	2025-04-30 23:37:20.095881
\.


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: julienmp
--

SELECT pg_catalog.setval('public.companies_id_seq', 3, true);


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: julienmp
--

SELECT pg_catalog.setval('public.votes_id_seq', 34, true);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: julienmp
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: julienmp
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: votes votes_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: julienmp
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- PostgreSQL database dump complete
--

