--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg120+1)

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
-- Name: game; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA game;


ALTER SCHEMA game OWNER TO postgres;



--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.game (
    game_id bigint NOT NULL,
    cover character varying,
    name character varying,
    rating double precision,
    rating_count integer,
    url character varying,
    release_year integer
);


ALTER TABLE game.game OWNER TO postgres;


--
-- Data for Name: game; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.game (game_id, cover, name, rating, rating_count, url, release_year) FROM stdin;
47530	co600u	The Legend of Zelda: Ocarina of Time 3D	91.36218019198398	390	https://www.igdb.com/games/the-legend-of-zelda-ocarina-of-time-3d	2011
47539	co1xii	Assassin's Creed III	77.44232064343174	1201	https://www.igdb.com/games/assassin-s-creed-iii	2012
47545	co1rbu	Tomb Raider	83.27365398585445	1921	https://www.igdb.com/games/tomb-raider--2	2013
47550	co4qfn	Assassin's Creed IV Black Flag	83.74376722083412	1413	https://www.igdb.com/games/assassins-creed-iv-black-flag	2013
47557	co1r7f	The Last of Us	92.46041583186334	2549	https://www.igdb.com/games/the-last-of-us	2013
47558	co2xlq	Escape from Tarkov	37.61447013117938	84	https://www.igdb.com/games/escape-from-tarkov	2017
47562	co1nyd	Command & Conquer: Generals	80.37507212213795	196	https://www.igdb.com/games/command-conquer-generals	2003
47565	co1rbj	What Remains of Edith Finch	85.43096806188521	767	https://www.igdb.com/games/what-remains-of-edith-finch	2017
47570	co20li	Command & Conquer: Red Alert 2 - Yuri's Revenge	81.66883907277298	114	https://www.igdb.com/games/command-and-conquer-red-alert-2-yuris-revenge	2001
47572	co20kb	Command & Conquer 4: Tiberian Twilight	51.41954075407359	37	https://www.igdb.com/games/command-conquer-4-tiberian-twilight	2010
47573	co1mw8	American Truck Simulator	81.15648323140806	69	https://www.igdb.com/games/american-truck-simulator	2016
47575	co1n7i	F1 2019	83.93168404587658	49	https://www.igdb.com/games/f1-2019	2019
47577	co7et5	Euro Truck Simulator 2	83.70825846494151	272	https://www.igdb.com/games/euro-truck-simulator-2	2012
47579	co1zv1	Command & Conquer 3: Kane's Wrath	78.1381291755993	52	https://www.igdb.com/games/command-conquer-3-kane-s-wrath	2008
47583	co1tnt	Half-Life	84.3898163128974	2154	https://www.igdb.com/games/half-life	1998
47585	co3m4l	Command & Conquer: Red Alert 3	74.71432894215872	182	https://www.igdb.com/games/command-conquer-red-alert-3	2008
47586	co20k7	Command & Conquer: Tiberian Sun - Firestorm	83.998492566933	40	https://www.igdb.com/games/command-and-conquer-tiberian-sun-firestorm	2000
47589	co2345	Command & Conquer: Red Alert 2	88.44965904603083	337	https://www.igdb.com/games/command-conquer-red-alert-2	2000
47590	co21c0	Wolfenstein: The New Order	79.49991141596055	1055	https://www.igdb.com/games/wolfenstein-the-new-order	2014
47591	co1qq5	Amnesia: The Dark Descent	83.74300143626145	400	https://www.igdb.com/games/amnesia-the-dark-descent	2010
47592	co1nxm	Command & Conquer: Tiberian Sun	82.22416379634868	125	https://www.igdb.com/games/command-conquer-tiberian-sun	1999
47594	co21fq	Agatha Christie: The ABC Murders	67.20491791957103	36	https://www.igdb.com/games/agatha-christie-the-abc-murders--1	2016
47598	co2nul	Assassin's Creed Odyssey	84.89076996537062	684	https://www.igdb.com/games/assassins-creed-odyssey	2018
47599	co2on1	Crysis	82.62350807091762	628	https://www.igdb.com/games/crysis	2007
47600	co2on2	Crysis 2	81.97743878257438	519	https://www.igdb.com/games/crysis-2	2011
47601	co1mx3	Cities: Skylines	78.55329633574176	547	https://www.igdb.com/games/cities-skylines	2015
47602	co2on3	Crysis 3	74.26377496832484	334	https://www.igdb.com/games/crysis-3	2013
47603	co6f8q	Emily is Away	66.49970372628746	117	https://www.igdb.com/games/emily-is-away	2015
47606	co1xr3	Emily is Away <3	70.67520214151544	13	https://www.igdb.com/games/emily-is-away-3	2021
47607	co2on4	Crysis Warhead	75.99295279187378	205	https://www.igdb.com/games/crysis-warhead	2008
47608	co24r9	Emily Is Away Too	78.6804154224864	50	https://www.igdb.com/games/emily-is-away-too	2017
47609	co1srp	Dirt Rally	83.54212733757356	125	https://www.igdb.com/games/dirt-rally	2015
47624	co24ml	Chuchel	78.01006464051738	43	https://www.igdb.com/games/chuchel	2018
47626	co1qri	Just Cause 2	81.3249520530754	402	https://www.igdb.com/games/just-cause-2	2010
47627	co4aqi	Kingdom Come: Deliverance	76.47923623745909	280	https://www.igdb.com/games/kingdom-come-deliverance	2018
47628	co1r8e	Life is Strange	80.94519417516953	1510	https://www.igdb.com/games/life-is-strange	2015
47630	co2a20	Soma	82.0226250676729	522	https://www.igdb.com/games/soma	2015
47631	co1ypl	Tom Clancy's Splinter Cell: Conviction	80.90801037840879	282	https://www.igdb.com/games/tom-clancy-s-splinter-cell-conviction	2010
47632	co1m35	Firewatch	79.18244889690861	894	https://www.igdb.com/games/firewatch	2016
47633	co1ygp	Tom Clancy's Splinter Cell: Blacklist	80.35078531232915	286	https://www.igdb.com/games/tom-clancy-s-splinter-cell-blacklist	2013
47635	co1qrs	Limbo	82.6389646505848	1283	https://www.igdb.com/games/limbo	2010
47639	co1yi1	Tom Clancy's Splinter Cell: Pandora Tomorrow	80.17206384057627	206	https://www.igdb.com/games/tom-clancy-s-splinter-cell-pandora-tomorrow	2004
47643	co2s5q	Until Dawn	79.89387180422659	590	https://www.igdb.com/games/until-dawn	2015
47644	co1ypg	Tom Clancy's Splinter Cell: Double Agent	77.5754688953061	163	https://www.igdb.com/games/tom-clancy-s-splinter-cell-double-agent	2006
47646	co2fca	Inside	89.29881354532915	1330	https://www.igdb.com/games/inside	2016
47649	co3wl7	F1 2018	79.44081598853398	43	https://www.igdb.com/games/f1-2018	2018
47650	co1qrt	Mafia	74.94986812432289	1087	https://www.igdb.com/games/mafia	2002
47656	co2mll	Mafia III	67.5345991521016	396	https://www.igdb.com/games/mafia-iii	2016
47657	co1yc6	Fallout 4	82.35719825651154	1335	https://www.igdb.com/games/fallout-4	2015
47660	co2q4b	F1 2016	80.05484585712522	35	https://www.igdb.com/games/f1-2016	2016
47661	co1u60	Fallout: New Vegas	84.42085827924797	1707	https://www.igdb.com/games/fallout-new-vegas	2010
47662	co237a	F1 2017	82.76797009134145	41	https://www.igdb.com/games/f1-2017	2017
47664	co2ysx	Tom Clancy's Splinter Cell: Chaos Theory	81.18635954808238	276	https://www.igdb.com/games/tom-clancy-s-splinter-cell-chaos-theory	2005
47666	co20ig	Command & Conquer: Renegade	64.70887223045878	73	https://www.igdb.com/games/command-conquer-renegade	2002
47667	co28g8	The Bureau: XCOM Declassified	64.11895768017321	92	https://www.igdb.com/games/the-bureau-xcom-declassified	2013
47672	co4kpk	DNF Duel	85	4	https://www.igdb.com/games/dnf-duel	2022
47674	co2ysy	Tom Clancy's Splinter Cell	83.77771239497267	341	https://www.igdb.com/games/tom-clancy-s-splinter-cell	2002
47675	co1mzh	F1 2015	66.17731080600848	37	https://www.igdb.com/games/f1-2015	2015
47676	co3q2v	Nephise: Ascension	70	0	https://www.igdb.com/games/nephise-ascension	2018
47677	co1y8y	Mount & Blade: Warband	77.26873150681736	310	https://www.igdb.com/games/mount-blade-warband	2010
47678	co2w7n	Lost Planet 3	63.52434796511166	45	https://www.igdb.com/games/lost-planet-3	2013
47681	co3s5l	Payday 2	74.06852850672809	385	https://www.igdb.com/games/payday-2	2013
47682	co6g3a	F1 23	87.8	7	https://www.igdb.com/games/f1-23	2023
47683	co2egl	Mount & Blade	69.13588823465233	104	https://www.igdb.com/games/mount-blade	2008
47684	co6kqt	Among Us	77.13500531051844	347	https://www.igdb.com/games/among-us	2018
47685	co1x7d	Portal	83.40628291528847	2894	https://www.igdb.com/games/portal	2007
47686	co4kxq	LEGO Bricktales	66.97209302325581	13	https://www.igdb.com/games/lego-bricktales	2022
47689	co27mn	Musynx	32.11997008208574	7	https://www.igdb.com/games/musynx	2015
47692	co5zgp	Perish	80	1	https://www.igdb.com/games/perish	2023
47694	co53b6	The Mortuary Assistant	79.27507999211002	16	https://www.igdb.com/games/the-mortuary-assistant	2022
47697	co5bh3	Trinity Fusion	85	1	https://www.igdb.com/games/trinity-fusion	2023
47698	co4ehj	Sniper Elite 5	75.47046881629193	34	https://www.igdb.com/games/sniper-elite-5	2022
47699	co1rs4	Portal 2	92.11756438215741	3209	https://www.igdb.com/games/portal-2	2011
47702	co1rqa	Rise of the Tomb Raider	84.36064398984456	1048	https://www.igdb.com/games/rise-of-the-tomb-raider	2015
47704	co1t5o	Phageborn Online Card Game	70	0	https://www.igdb.com/games/phageborn-online-card-game	2020
47706	co4k8e	PC Building Simulator 2	70	1	https://www.igdb.com/games/pc-building-simulator-2	2022
47709	co45g0	Lost Planet: Extreme Condition	72.21946337748611	86	https://www.igdb.com/games/lost-planet-extreme-condition	2006
47710	co5s2b	Steelrising: Cagliostro's Secrets	70	1	https://www.igdb.com/games/steelrising-cagliostros-secrets	2022
47713	co48sm	Togges	75	1	https://www.igdb.com/games/togges	2022
47715	co6qox	Somerville	70.96663880731634	42	https://www.igdb.com/games/somerville	2022
47716	co1vca	A Way Out	76.80534553411833	411	https://www.igdb.com/games/a-way-out	2018
47717	co20f2	Nira	70	0	https://www.igdb.com/games/nira	2020
47718	co1qy6	Assassin's Creed Chronicles: China	70.18875524835542	109	https://www.igdb.com/games/assassins-creed-chronicles-china--1	2015
47720	co50kv	Fallout 2	89.70285793775454	660	https://www.igdb.com/games/fallout-2	1998
47724	co4v5c	Scorn	68.1129789489543	73	https://www.igdb.com/games/scorn	2022
47725	co62kn	A Space for the Unbound	71.24081229840314	13	https://www.igdb.com/games/a-space-for-the-unbound	2023
47727	co2fzb	The Shapeshifting Detective	69.98626432133042	12	https://www.igdb.com/games/the-shapeshifting-detective	2018
47729	co1ybr	Fallout Tactics: Brotherhood of Steel	70.23499565206812	81	https://www.igdb.com/games/fallout-tactics-brotherhood-of-steel	2001
47730	co5pd0	Dishonored 2	85.66000404920567	591	https://www.igdb.com/games/dishonored-2	2016
47732	co1vcn	Shadow of the Tomb Raider	78.90970620196325	470	https://www.igdb.com/games/shadow-of-the-tomb-raider	2018
47734	co2xnk	Assassin's Creed Chronicles: Trilogy Pack	50.76390209985423	9	https://www.igdb.com/games/assassins-creed-chronicles-trilogy-pack	2016
47735	co4rp1	WRC Generations	80	1	https://www.igdb.com/games/wrc-generations	2022
47736	co5th8	Dead Space	72.85783338222618	12	https://www.igdb.com/games/dead-space--2	2011
47739	co1y9h	Saints Row IV: Re-Elected	76.36225439844132	30	https://www.igdb.com/games/saints-row-iv-re-elected	2015
47741	co1zt9	Rome: Total War	86.63752260002241	262	https://www.igdb.com/games/rome-total-war	2004
47742	co1xbu	Battlefield 3	82.58659168625117	866	https://www.igdb.com/games/battlefield-3	2011
47743	co21dg	Napoleon: Total War	80.4132119834409	78	https://www.igdb.com/games/napoleon-total-war	2010
47744	co1yo2	Warrior Kings	67.5	3	https://www.igdb.com/games/warrior-kings	2002
47746	co214k	Empire: Total War	83.95433225585562	137	https://www.igdb.com/games/empire-total-war	2009
47747	co496y	Bloodshore	65.95628055140422	8	https://www.igdb.com/games/bloodshore	2021
\.



--
-- Name: game game_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (game_id);



--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

