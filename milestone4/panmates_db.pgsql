--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: diet; Type: TABLE; Schema: public; Owner: mosabfaozi
--

CREATE TABLE public.diet (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    disc text,
    tags character(20)[]
);


ALTER TABLE public.diet OWNER TO mosabfaozi;

--
-- Name: diet_id_seq; Type: SEQUENCE; Schema: public; Owner: mosabfaozi
--

CREATE SEQUENCE public.diet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.diet_id_seq OWNER TO mosabfaozi;

--
-- Name: diet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosabfaozi
--

ALTER SEQUENCE public.diet_id_seq OWNED BY public.diet.id;


--
-- Name: level; Type: TABLE; Schema: public; Owner: mosabfaozi
--

CREATE TABLE public.level (
    id integer NOT NULL,
    name character(20) NOT NULL,
    difficulty smallint NOT NULL,
    "Disc" text,
    CONSTRAINT level_difficulty_check CHECK ((difficulty <= 5))
);


ALTER TABLE public.level OWNER TO mosabfaozi;

--
-- Name: level_id_seq; Type: SEQUENCE; Schema: public; Owner: mosabfaozi
--

CREATE SEQUENCE public.level_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.level_id_seq OWNER TO mosabfaozi;

--
-- Name: level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosabfaozi
--

ALTER SEQUENCE public.level_id_seq OWNED BY public.level.id;


--
-- Name: recipe; Type: TABLE; Schema: public; Owner: mosabfaozi
--

CREATE TABLE public.recipe (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    author integer,
    vid_link text NOT NULL,
    image text,
    ingredients text[] NOT NULL,
    steps text[] NOT NULL,
    diet integer,
    difficulty_level integer,
    sponsored boolean DEFAULT false NOT NULL
);


ALTER TABLE public.recipe OWNER TO mosabfaozi;

--
-- Name: recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: mosabfaozi
--

CREATE SEQUENCE public.recipe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipe_id_seq OWNER TO mosabfaozi;

--
-- Name: recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosabfaozi
--

ALTER SEQUENCE public.recipe_id_seq OWNED BY public.recipe.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: mosabfaozi
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character(30) NOT NULL,
    password character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    firstname character(30),
    lastname character(30),
    masterlevel integer NOT NULL,
    diet integer,
    favorites integer[]
);


ALTER TABLE public."user" OWNER TO mosabfaozi;

--
-- Name: user_diet_seq; Type: SEQUENCE; Schema: public; Owner: mosabfaozi
--

CREATE SEQUENCE public.user_diet_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_diet_seq OWNER TO mosabfaozi;

--
-- Name: user_diet_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosabfaozi
--

ALTER SEQUENCE public.user_diet_seq OWNED BY public."user".diet;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: mosabfaozi
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO mosabfaozi;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosabfaozi
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: user_masterlevel_seq; Type: SEQUENCE; Schema: public; Owner: mosabfaozi
--

CREATE SEQUENCE public.user_masterlevel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_masterlevel_seq OWNER TO mosabfaozi;

--
-- Name: user_masterlevel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosabfaozi
--

ALTER SEQUENCE public.user_masterlevel_seq OWNED BY public."user".masterlevel;


--
-- Name: diet id; Type: DEFAULT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.diet ALTER COLUMN id SET DEFAULT nextval('public.diet_id_seq'::regclass);


--
-- Name: level id; Type: DEFAULT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.level ALTER COLUMN id SET DEFAULT nextval('public.level_id_seq'::regclass);


--
-- Name: recipe id; Type: DEFAULT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.recipe ALTER COLUMN id SET DEFAULT nextval('public.recipe_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: diet; Type: TABLE DATA; Schema: public; Owner: mosabfaozi
--

COPY public.diet (id, name, disc, tags) FROM stdin;
3	No diet	They don't follow a specific diet or their diet is not listed. (Default)	\N
4	Vegetarian	They don't eat meat related products. Their diet is contricted to vegetables.	{"tofu                ","vegetables          "}
5	Vegan	They don't eat animal related products such as milk, honey, etc.	{"non-dairy products  ","vegetables          "}
6	Pescatarian	They don't ear meat related products with the exception of fish.	{"fish                ","sea food            ","vegetables          "}
7	Halal	Religious diet followed by followers of Islam.	\N
8	Kosher	Religious diet followed by followers of Judaism.	\N
\.


--
-- Data for Name: level; Type: TABLE DATA; Schema: public; Owner: mosabfaozi
--

COPY public.level (id, name, difficulty, "Disc") FROM stdin;
1	Novice              	1	Starting to learn how to cook.
2	Beginner            	2	Can cook basic recipes and would like to learn more.
3	Intermediate        	3	Can cook complicated recipes by reading them. Also understands the terminology associated with cooking.
4	Experienced         	4	Can cook most recipes and can make their own changes on the recipes.
5	Expert              	5	Make their own recipes and could take their skills professionally.
\.


--
-- Data for Name: recipe; Type: TABLE DATA; Schema: public; Owner: mosabfaozi
--

COPY public.recipe (id, name, author, vid_link, image, ingredients, steps, diet, difficulty_level, sponsored) FROM stdin;
1	Chicken soup	1	www.google.com	image.google.com	{"1oz of Chicken","a bag of soup"}	{"put chicken","put soup",mix}	3	2	f
3	Chicken soup 2	1	www.google.com/admin	image.google.com/admin	{"1oz of Chicken","a bag of soup"}	{"put chicken","put soup",mix}	7	4	t
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: mosabfaozi
--

COPY public."user" (id, username, password, email, firstname, lastname, masterlevel, diet, favorites) FROM stdin;
1	musaab                        	1111	mmm@mmm.mm	musaab                        	albakry                       	2	7	\N
2	victor                        	2222	vvv@vvv.vv	victor                        	victor                        	5	3	\N
\.


--
-- Name: diet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosabfaozi
--

SELECT pg_catalog.setval('public.diet_id_seq', 8, true);


--
-- Name: level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosabfaozi
--

SELECT pg_catalog.setval('public.level_id_seq', 5, true);


--
-- Name: recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosabfaozi
--

SELECT pg_catalog.setval('public.recipe_id_seq', 3, true);


--
-- Name: user_diet_seq; Type: SEQUENCE SET; Schema: public; Owner: mosabfaozi
--

SELECT pg_catalog.setval('public.user_diet_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosabfaozi
--

SELECT pg_catalog.setval('public.user_id_seq', 2, true);


--
-- Name: user_masterlevel_seq; Type: SEQUENCE SET; Schema: public; Owner: mosabfaozi
--

SELECT pg_catalog.setval('public.user_masterlevel_seq', 1, false);


--
-- Name: diet diet_name_key; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.diet
    ADD CONSTRAINT diet_name_key UNIQUE (name);


--
-- Name: diet diet_pkey; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.diet
    ADD CONSTRAINT diet_pkey PRIMARY KEY (id);


--
-- Name: level level_difficulty_key; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_difficulty_key UNIQUE (difficulty);


--
-- Name: level level_name_key; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_name_key UNIQUE (name);


--
-- Name: level level_pkey; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_pkey PRIMARY KEY (id);


--
-- Name: recipe recipe_image_key; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT recipe_image_key UNIQUE (image);


--
-- Name: recipe recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT recipe_pkey PRIMARY KEY (id);


--
-- Name: recipe recipe_vid_link_key; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT recipe_vid_link_key UNIQUE (vid_link);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: recipe diet; Type: FK CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT diet FOREIGN KEY (diet) REFERENCES public.diet(id) ON DELETE SET NULL;


--
-- Name: user diet; Type: FK CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT diet FOREIGN KEY (diet) REFERENCES public.diet(id) ON DELETE SET NULL;


--
-- Name: recipe difficulty; Type: FK CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT difficulty FOREIGN KEY (difficulty_level) REFERENCES public.level(id) ON DELETE SET NULL;


--
-- Name: user mastery_level; Type: FK CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT mastery_level FOREIGN KEY (masterlevel) REFERENCES public.level(id) ON DELETE SET NULL;


--
-- Name: recipe user; Type: FK CONSTRAINT; Schema: public; Owner: mosabfaozi
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT "user" FOREIGN KEY (author) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

