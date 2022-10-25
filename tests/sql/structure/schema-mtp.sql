--
-- PostgreSQL database dump
--

-- Dumped from database version 12.12 (Ubuntu 12.12-1.pgdg20.04+1)
-- Dumped by pg_dump version 12.12 (Ubuntu 12.12-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: cadastre_mtp; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA cadastre_mtp;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: annul; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.annul (
    annul text NOT NULL,
    annul_lib text
);


--
-- Name: bati; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.bati (
    tmp text
);


--
-- Name: carvoi; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.carvoi (
    carvoi text NOT NULL,
    carvoi_lib text
);


--
-- Name: cbtabt; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.cbtabt (
    cbtabt text NOT NULL,
    cbtabt_lib text
);


--
-- Name: ccoaff; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccoaff (
    ccoaff text NOT NULL,
    ccoaff_lib text
);


--
-- Name: ccocac; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccocac (
    ccocac text NOT NULL,
    ccocac_lib text
);


--
-- Name: ccodem; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccodem (
    ccodem text NOT NULL,
    ccodem_lib text
);


--
-- Name: ccodro; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccodro (
    ccodro text NOT NULL,
    ccodro_lib text
);


--
-- Name: ccoeva; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccoeva (
    ccoeva text NOT NULL,
    ccoeva_lib text
);


--
-- Name: ccogrm; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccogrm (
    ccogrm text NOT NULL,
    ccogrm_lib text
);


--
-- Name: ccolloc; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccolloc (
    ccolloc text NOT NULL,
    ccolloc_lib text
);


--
-- Name: cconac; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.cconac (
    cconac text NOT NULL,
    cconac_lib text
);


--
-- Name: cconad; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.cconad (
    cconad text NOT NULL,
    cconad_lib text
);


--
-- Name: cconlc; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.cconlc (
    cconlc text NOT NULL,
    cconlc_lib text
);


--
-- Name: cconlo; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.cconlo (
    cconlo text NOT NULL,
    cconlo_lib text
);


--
-- Name: ccoplc; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccoplc (
    ccoplc text NOT NULL,
    ccoplc_lib text
);


--
-- Name: ccoqua; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccoqua (
    ccoqua text NOT NULL,
    ccoqua_lib text
);


--
-- Name: ccthp; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ccthp (
    ccthp text NOT NULL,
    ccthp_lib text
);


--
-- Name: cgrnum; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.cgrnum (
    cgrnum text NOT NULL,
    cgrnum_lib text
);


--
-- Name: cnatsp; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.cnatsp (
    cnatsp text NOT NULL,
    cnatsp_lib text
);


--
-- Name: commune; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.commune (
    commune text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    clerivili text,
    libcom text,
    typcom text,
    ruract text,
    carvoi text,
    indpop text,
    poprel integer,
    poppart integer,
    popfict integer,
    annul text,
    dteannul text,
    dtecreart text,
    codvoi text,
    typvoi text,
    indldnbat text,
    motclas text,
    geo_commune text,
    lot text
);


--
-- Name: TABLE commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.commune IS 'Commune (Fantoir)';


--
-- Name: COLUMN commune.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.ccodep IS 'Code département - Code département INSEE';


--
-- Name: COLUMN commune.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.ccodir IS 'Code direction - Code direction dge';


--
-- Name: COLUMN commune.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.ccocom IS 'Code commune - code commune définie par Majic2';


--
-- Name: COLUMN commune.clerivili; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.clerivili IS 'Clé RIVOLI - zone alphabétique fournie par MAJIC2';


--
-- Name: COLUMN commune.libcom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.libcom IS 'Libellé - désignation de la commune';


--
-- Name: COLUMN commune.typcom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.typcom IS 'Type de commune actuel (R ou N) - N - commune rurale, R - commune rencencée';


--
-- Name: COLUMN commune.ruract; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.ruract IS 'RUR actuel - indique si la commune est pseudo-recensée ou non (3-commune pseudo-recensée, blanc si rien)';


--
-- Name: COLUMN commune.carvoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.carvoi IS 'caractère de voie - zone indiquant si la voie est privée (1) ou publique (0)';


--
-- Name: COLUMN commune.indpop; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.indpop IS 'indicateur de population - Précise la dernière situation connue de la commune au regard de la limite de 3000 habitants (= blanc si < 3000 h sinon = *).';


--
-- Name: COLUMN commune.poprel; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.poprel IS 'population réelle - dénombre la population recencée lors du dernier recensement';


--
-- Name: COLUMN commune.poppart; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.poppart IS 'population à part - dénombre la population comptée à part dans la commune';


--
-- Name: COLUMN commune.popfict; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.popfict IS 'population fictive - population fictive de la commune';


--
-- Name: COLUMN commune.annul; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.annul IS 'Annulation Cet article indique que plus aucune entité topo n’est représentée par ce code. - O - voie annulée sans transfert, Q - voie annulée avec transfert, Q - commune annulée avec transfert.';


--
-- Name: COLUMN commune.dteannul; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.dteannul IS 'date d''annulation - ';


--
-- Name: COLUMN commune.dtecreart; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.dtecreart IS 'Date de création de l''article - Date à laquelle l''article a été créé par création MAJIC2.';


--
-- Name: COLUMN commune.codvoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.codvoi IS 'Code identifiant la voie dans MAJIC2. - Permet de faire le lien entre le code voie RIVOLI et le code voie MAJIC2.';


--
-- Name: COLUMN commune.typvoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.typvoi IS 'Type de voie - Indicateur de la classe de la voie. - 1 - voie, 2 - ensemble immobilier, 3 - lieu-dit, 4 -  pseudo-voie, 5 - voie provisoire.';


--
-- Name: COLUMN commune.indldnbat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.indldnbat IS 'Indicateur lieu-dit non bâti - Zone servie uniquement pour les lieux-dits.Permet d’indiquer si le lieu-dit comporte ou non un bâtiment dans MAJIC.1 pour lieu-dit non bâti, 0 sinon.';


--
-- Name: COLUMN commune.motclas; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune.motclas IS 'Mot classant - Dernier mot entièrement alphabétique du libellé de voie - Permet de restituer l''ordre alphabétique.';


--
-- Name: commune_majic; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.commune_majic (
    commune text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    libcom text,
    lot text
);


--
-- Name: TABLE commune_majic; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.commune_majic IS 'Commune (MAJIC - introduit depuis le millésime 2015). Cet article contient le code INSEE associé au libellé de la commune.';


--
-- Name: COLUMN commune_majic.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune_majic.ccodep IS 'Code département - Code département INSEE';


--
-- Name: COLUMN commune_majic.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune_majic.ccodir IS 'Code direction - Code direction dge';


--
-- Name: COLUMN commune_majic.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune_majic.ccocom IS 'Code commune - 3 caractères';


--
-- Name: COLUMN commune_majic.libcom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.commune_majic.libcom IS 'Libellé de la commune';


--
-- Name: comptecommunal; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.comptecommunal (
    comptecommunal text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    dnupro text,
    ajoutcoherence text,
    lot text
);


--
-- Name: ctpdl; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.ctpdl (
    ctpdl text NOT NULL,
    ctpdl_lib text
);


--
-- Name: detent; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.detent (
    detent text NOT NULL,
    detent_lib text
);


--
-- Name: dformjur; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.dformjur (
    dformjur text NOT NULL,
    formjur text,
    libformjur text
);


--
-- Name: dmatgm; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.dmatgm (
    dmatgm text NOT NULL,
    dmatgm_lib text
);


--
-- Name: dmatto; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.dmatto (
    dmatto text NOT NULL,
    dmatto_lib text
);


--
-- Name: dnatcg; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.dnatcg (
    dnatcg text NOT NULL,
    dnatcg_lib text
);


--
-- Name: dnatlc; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.dnatlc (
    dnatlc text NOT NULL,
    dnatlc_lib text
);


--
-- Name: dnatpr; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.dnatpr (
    dnatpr text NOT NULL,
    dnatpr_lib text
);


--
-- Name: drgpos; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.drgpos (
    dgrpos text NOT NULL,
    dgrpos_lib text
);


--
-- Name: dsgrpf; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.dsgrpf (
    dsgrpf text NOT NULL,
    dsgrpf_lib text
);


--
-- Name: dteloc; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.dteloc (
    dteloc text NOT NULL,
    dteloc_lib text
);


--
-- Name: edigeo_rel; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.edigeo_rel (
    edigeo_rel integer NOT NULL,
    nom text,
    de text,
    vers text
);


--
-- Name: edigeo_rel_edigeo_rel_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.edigeo_rel_edigeo_rel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: edigeo_rel_edigeo_rel_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.edigeo_rel_edigeo_rel_seq OWNED BY cadastre_mtp.edigeo_rel.edigeo_rel;


--
-- Name: fanr; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.fanr (
    tmp text
);


--
-- Name: fburx; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.fburx (
    fburx text NOT NULL,
    fburx_lib text
);


--
-- Name: geo_batiment; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_batiment (
    geo_batiment text NOT NULL,
    annee text NOT NULL,
    object_rid text,
    geo_dur text,
    tex text,
    creat_date date,
    update_dat date,
    lot text,
    ogc_fid integer NOT NULL,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_batiment; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_batiment IS 'Construction assise sur une ou plusieurs parcelles cadastrales.';


--
-- Name: COLUMN geo_batiment.geo_batiment; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment.geo_batiment IS 'Identifiant';


--
-- Name: COLUMN geo_batiment.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment.annee IS 'Année';


--
-- Name: COLUMN geo_batiment.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_batiment.geo_dur; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment.geo_dur IS 'Type de bâtiment';


--
-- Name: COLUMN geo_batiment.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment.tex IS 'Texte du bâtiment';


--
-- Name: COLUMN geo_batiment.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_batiment.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment.update_dat IS 'Date de dernière modification';


--
-- Name: geo_batiment_ogc_fid_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_batiment_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_batiment_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_batiment_ogc_fid_seq OWNED BY cadastre_mtp.geo_batiment.ogc_fid;


--
-- Name: geo_batiment_parcelle; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_batiment_parcelle (
    geo_batiment_parcelle integer NOT NULL,
    annee text NOT NULL,
    geo_batiment text NOT NULL,
    geo_parcelle text NOT NULL
);


--
-- Name: TABLE geo_batiment_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_batiment_parcelle IS 'Lien subdivision fiscale - parcelle';


--
-- Name: COLUMN geo_batiment_parcelle.geo_batiment_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment_parcelle.geo_batiment_parcelle IS 'Identifiant';


--
-- Name: COLUMN geo_batiment_parcelle.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment_parcelle.annee IS 'Année';


--
-- Name: COLUMN geo_batiment_parcelle.geo_batiment; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment_parcelle.geo_batiment IS 'Bâtiment';


--
-- Name: COLUMN geo_batiment_parcelle.geo_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_batiment_parcelle.geo_parcelle IS 'Parcelle';


--
-- Name: geo_batiment_parcelle_geo_batiment_parcelle_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_batiment_parcelle_geo_batiment_parcelle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_batiment_parcelle_geo_batiment_parcelle_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_batiment_parcelle_geo_batiment_parcelle_seq OWNED BY cadastre_mtp.geo_batiment_parcelle.geo_batiment_parcelle;


--
-- Name: geo_borne; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_borne (
    geo_borne integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(Point,2154)
);


--
-- Name: TABLE geo_borne; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_borne IS 'Borne située en limite de propriété et représentée par un symbole ponctuel.';


--
-- Name: COLUMN geo_borne.geo_borne; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_borne.geo_borne IS 'Identifiant';


--
-- Name: COLUMN geo_borne.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_borne.annee IS 'Année';


--
-- Name: COLUMN geo_borne.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_borne.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_borne.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_borne.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_borne.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_borne.update_dat IS 'Date de dernière modification';


--
-- Name: geo_borne_geo_borne_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_borne_geo_borne_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_borne_geo_borne_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_borne_geo_borne_seq OWNED BY cadastre_mtp.geo_borne.geo_borne;


--
-- Name: geo_borne_parcelle; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_borne_parcelle (
    geo_borne_parcelle integer NOT NULL,
    annee text NOT NULL,
    geo_borne integer NOT NULL,
    geo_parcelle text NOT NULL
);


--
-- Name: TABLE geo_borne_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_borne_parcelle IS 'Lien borne - parcelle';


--
-- Name: COLUMN geo_borne_parcelle.geo_borne_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_borne_parcelle.geo_borne_parcelle IS 'Identifiant';


--
-- Name: COLUMN geo_borne_parcelle.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_borne_parcelle.annee IS 'Année';


--
-- Name: COLUMN geo_borne_parcelle.geo_borne; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_borne_parcelle.geo_borne IS 'borne';


--
-- Name: COLUMN geo_borne_parcelle.geo_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_borne_parcelle.geo_parcelle IS 'Parcelle';


--
-- Name: geo_borne_parcelle_geo_borne_parcelle_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_borne_parcelle_geo_borne_parcelle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_borne_parcelle_geo_borne_parcelle_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_borne_parcelle_geo_borne_parcelle_seq OWNED BY cadastre_mtp.geo_borne_parcelle.geo_borne_parcelle;


--
-- Name: geo_can; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_can (
    geo_can text NOT NULL,
    geo_can_lib text
);


--
-- Name: geo_commune; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_commune (
    geo_commune text NOT NULL,
    annee text NOT NULL,
    object_rid text,
    idu text,
    tex2 text,
    creat_date date,
    update_dat date,
    commune text,
    lot text,
    ogc_fid integer NOT NULL,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_commune IS 'Territoire contenant un nombre entier de subdivisions de section cadastrales';


--
-- Name: COLUMN geo_commune.geo_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_commune.geo_commune IS 'Identifiant';


--
-- Name: COLUMN geo_commune.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_commune.annee IS 'Année';


--
-- Name: COLUMN geo_commune.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_commune.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_commune.idu; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_commune.idu IS 'Code INSEE';


--
-- Name: COLUMN geo_commune.tex2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_commune.tex2 IS 'Nom commune';


--
-- Name: COLUMN geo_commune.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_commune.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_commune.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_commune.update_dat IS 'Date de dernière modification';


--
-- Name: geo_commune_ogc_fid_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_commune_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_commune_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_commune_ogc_fid_seq OWNED BY cadastre_mtp.geo_commune.ogc_fid;


--
-- Name: geo_copl; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_copl (
    geo_copl text NOT NULL,
    geo_copl_lib text
);


--
-- Name: geo_croix; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_croix (
    geo_croix integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(Point,2154)
);


--
-- Name: TABLE geo_croix; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_croix IS 'Borne située en limite de propriété et représentée par un symbole ponctuel.';


--
-- Name: COLUMN geo_croix.geo_croix; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_croix.geo_croix IS 'Identifiant';


--
-- Name: COLUMN geo_croix.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_croix.annee IS 'Année';


--
-- Name: COLUMN geo_croix.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_croix.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_croix.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_croix.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_croix.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_croix.update_dat IS 'Date de dernière modification';


--
-- Name: geo_croix_geo_croix_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_croix_geo_croix_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_croix_geo_croix_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_croix_geo_croix_seq OWNED BY cadastre_mtp.geo_croix.geo_croix;


--
-- Name: geo_croix_parcelle; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_croix_parcelle (
    geo_croix_parcelle integer NOT NULL,
    annee text NOT NULL,
    geo_croix integer NOT NULL,
    geo_parcelle text NOT NULL
);


--
-- Name: TABLE geo_croix_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_croix_parcelle IS 'Lien croix - parcelle';


--
-- Name: COLUMN geo_croix_parcelle.geo_croix_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_croix_parcelle.geo_croix_parcelle IS 'Identifiant';


--
-- Name: COLUMN geo_croix_parcelle.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_croix_parcelle.annee IS 'Année';


--
-- Name: COLUMN geo_croix_parcelle.geo_croix; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_croix_parcelle.geo_croix IS 'Croix';


--
-- Name: COLUMN geo_croix_parcelle.geo_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_croix_parcelle.geo_parcelle IS 'Parcelle';


--
-- Name: geo_croix_parcelle_geo_croix_parcelle_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_croix_parcelle_geo_croix_parcelle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_croix_parcelle_geo_croix_parcelle_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_croix_parcelle_geo_croix_parcelle_seq OWNED BY cadastre_mtp.geo_croix_parcelle.geo_croix_parcelle;


--
-- Name: geo_dur; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_dur (
    geo_dur text NOT NULL,
    geo_dur_lib text
);


--
-- Name: geo_indp; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_indp (
    geo_indp text NOT NULL,
    geo_indp_lib text
);


--
-- Name: geo_inp; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_inp (
    geo_inp text NOT NULL,
    geo_inp_lib text
);


--
-- Name: geo_label; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_label (
    ogc_fid integer NOT NULL,
    object_rid text,
    fon text,
    hei numeric(24,15),
    tyu text,
    cef numeric(24,15),
    csp numeric(24,15),
    di1 numeric(24,15),
    di2 numeric(24,15),
    di3 numeric(24,15),
    di4 numeric(24,15),
    tpa text,
    hta text,
    vta text,
    atr text,
    ogr_obj_lnk text,
    ogr_obj_lnk_layer text,
    ogr_atr_val text,
    ogr_angle double precision,
    ogr_font_size double precision,
    x_label numeric,
    y_label numeric,
    geom public.geometry(Point,2154)
);


--
-- Name: TABLE geo_label; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_label IS 'Libellés';


--
-- Name: COLUMN geo_label.ogc_fid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.ogc_fid IS 'Numéro d''enregistrement source';


--
-- Name: COLUMN geo_label.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_label.fon; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.fon IS 'Nom en clair de la police typographique';


--
-- Name: COLUMN geo_label.hei; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.hei IS 'Hauteur des caractères';


--
-- Name: COLUMN geo_label.tyu; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.tyu IS 'Type de l''unité utilisée';


--
-- Name: COLUMN geo_label.cef; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.cef IS 'Facteur d''agrandissement';


--
-- Name: COLUMN geo_label.csp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.csp IS 'Espacement intercaractères';


--
-- Name: COLUMN geo_label.di1; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.di1 IS 'Orientation composante X du vecteur hauteur';


--
-- Name: COLUMN geo_label.di2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.di2 IS 'Orientation composante Y du vecteur hauteur';


--
-- Name: COLUMN geo_label.di3; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.di3 IS 'Orientation composante X du vecteur base';


--
-- Name: COLUMN geo_label.di4; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.di4 IS 'Orientation composante Y du vecteur base';


--
-- Name: COLUMN geo_label.tpa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.tpa IS 'Sens de l''écriture';


--
-- Name: COLUMN geo_label.hta; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.hta IS 'Alignement horizontal du texte';


--
-- Name: COLUMN geo_label.vta; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.vta IS 'Alignement vertical du texte';


--
-- Name: COLUMN geo_label.atr; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.atr IS 'Identificateur de l''attribut à écrire';


--
-- Name: COLUMN geo_label.ogr_obj_lnk; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.ogr_obj_lnk IS 'lien n°objet';


--
-- Name: COLUMN geo_label.ogr_obj_lnk_layer; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.ogr_obj_lnk_layer IS 'type objet';


--
-- Name: COLUMN geo_label.ogr_atr_val; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.ogr_atr_val IS 'Ogr valeur';


--
-- Name: COLUMN geo_label.ogr_angle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.ogr_angle IS 'Ogr angle';


--
-- Name: COLUMN geo_label.ogr_font_size; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.ogr_font_size IS 'Ogr taille fonte';


--
-- Name: COLUMN geo_label.x_label; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.x_label IS 'Longitude';


--
-- Name: COLUMN geo_label.y_label; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_label.y_label IS 'Latitude';


--
-- Name: geo_label_ogc_fid_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_label_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_label_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_label_ogc_fid_seq OWNED BY cadastre_mtp.geo_label.ogc_fid;


--
-- Name: geo_lieudit; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_lieudit (
    geo_lieudit integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    tex text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_lieudit; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_lieudit IS 'Ensemble de parcelles entières comportant une même dénomination géographique résultant de l''usage.';


--
-- Name: COLUMN geo_lieudit.geo_lieudit; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_lieudit.geo_lieudit IS 'Identifiant';


--
-- Name: COLUMN geo_lieudit.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_lieudit.annee IS 'Année';


--
-- Name: COLUMN geo_lieudit.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_lieudit.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_lieudit.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_lieudit.tex IS 'Libellé';


--
-- Name: COLUMN geo_lieudit.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_lieudit.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_lieudit.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_lieudit.update_dat IS 'Date de dernière modification';


--
-- Name: geo_lieudit_geo_lieudit_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_lieudit_geo_lieudit_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_lieudit_geo_lieudit_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_lieudit_geo_lieudit_seq OWNED BY cadastre_mtp.geo_lieudit.geo_lieudit;


--
-- Name: geo_map; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_map (
    geo_map text NOT NULL,
    geo_map_lib text
);


--
-- Name: geo_numvoie; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_numvoie (
    geo_numvoie integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    tex text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(Point,2154)
);


--
-- Name: TABLE geo_numvoie; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_numvoie IS 'Numéro correspondant à l''adresse de la parcelle.';


--
-- Name: COLUMN geo_numvoie.geo_numvoie; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie.geo_numvoie IS 'Identifiant';


--
-- Name: COLUMN geo_numvoie.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie.annee IS 'Année';


--
-- Name: COLUMN geo_numvoie.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_numvoie.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie.tex IS 'Numéro';


--
-- Name: COLUMN geo_numvoie.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_numvoie.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie.update_dat IS 'Date de dernière modification';


--
-- Name: geo_numvoie_geo_numvoie_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_numvoie_geo_numvoie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_numvoie_geo_numvoie_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_numvoie_geo_numvoie_seq OWNED BY cadastre_mtp.geo_numvoie.geo_numvoie;


--
-- Name: geo_numvoie_parcelle; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_numvoie_parcelle (
    geo_numvoie_parcelle integer NOT NULL,
    annee text NOT NULL,
    geo_numvoie integer NOT NULL,
    geo_parcelle text NOT NULL
);


--
-- Name: TABLE geo_numvoie_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_numvoie_parcelle IS 'Lien subdivision fiscale - parcelle';


--
-- Name: COLUMN geo_numvoie_parcelle.geo_numvoie_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie_parcelle.geo_numvoie_parcelle IS 'Identifiant';


--
-- Name: COLUMN geo_numvoie_parcelle.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie_parcelle.annee IS 'Année';


--
-- Name: COLUMN geo_numvoie_parcelle.geo_numvoie; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie_parcelle.geo_numvoie IS 'Subdivision fiscale';


--
-- Name: COLUMN geo_numvoie_parcelle.geo_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_numvoie_parcelle.geo_parcelle IS 'Parcelle';


--
-- Name: geo_numvoie_parcelle_geo_numvoie_parcelle_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_numvoie_parcelle_geo_numvoie_parcelle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_numvoie_parcelle_geo_numvoie_parcelle_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_numvoie_parcelle_geo_numvoie_parcelle_seq OWNED BY cadastre_mtp.geo_numvoie_parcelle.geo_numvoie_parcelle;


--
-- Name: geo_palt; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_palt (
    geo_palt text NOT NULL,
    geo_palt_lib text
);


--
-- Name: geo_parcelle; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_parcelle (
    geo_parcelle text NOT NULL,
    annee text NOT NULL,
    object_rid text,
    idu text,
    geo_section text NOT NULL,
    geo_subdsect text,
    supf numeric,
    geo_indp text,
    coar text,
    tex text,
    tex2 text,
    codm text,
    creat_date date,
    update_dat date,
    inspireid text,
    lot text,
    ogc_fid integer NOT NULL,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_parcelle IS 'Portion de section cadastrale disposant de caractéristiques propres au regard notamment de son échelle, sa qualité, son mode de confection. Une section a au moins une subdivision de section. Cet objet correspond à la feuille cadastrale.';


--
-- Name: COLUMN geo_parcelle.geo_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.geo_parcelle IS 'Identifiant';


--
-- Name: COLUMN geo_parcelle.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.annee IS 'Année';


--
-- Name: COLUMN geo_parcelle.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_parcelle.idu; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.idu IS 'Identifiant';


--
-- Name: COLUMN geo_parcelle.geo_section; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.geo_section IS 'Section';


--
-- Name: COLUMN geo_parcelle.supf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.supf IS 'Contenance MAJIC';


--
-- Name: COLUMN geo_parcelle.geo_indp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.geo_indp IS 'Figuration de la parcelle au plan';


--
-- Name: COLUMN geo_parcelle.coar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.coar IS 'Code arpentage';


--
-- Name: COLUMN geo_parcelle.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.tex IS 'Numéro parcellaire';


--
-- Name: COLUMN geo_parcelle.tex2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.tex2 IS 'tex2 - non documenté';


--
-- Name: COLUMN geo_parcelle.codm; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.codm IS 'codm - non documenté';


--
-- Name: COLUMN geo_parcelle.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_parcelle.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_parcelle.update_dat IS 'Date de dernière modification';


--
-- Name: geo_parcelle_ogc_fid_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_parcelle_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_parcelle_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_parcelle_ogc_fid_seq OWNED BY cadastre_mtp.geo_parcelle.ogc_fid;


--
-- Name: geo_ppln; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_ppln (
    geo_ppln text NOT NULL,
    geo_ppln_lib text
);


--
-- Name: geo_ptcanv; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_ptcanv (
    geo_ptcanv integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    idu text,
    geo_can text,
    geo_ppln text,
    geo_palt text,
    geo_map text,
    geo_sym text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(Point,2154)
);


--
-- Name: TABLE geo_ptcanv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_ptcanv IS 'Objet ponctuel servant d''appui aux opérations de lever des plans..';


--
-- Name: COLUMN geo_ptcanv.geo_ptcanv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.geo_ptcanv IS 'Identifiant';


--
-- Name: COLUMN geo_ptcanv.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.annee IS 'Année';


--
-- Name: COLUMN geo_ptcanv.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_ptcanv.idu; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.idu IS 'Identifiant PCI';


--
-- Name: COLUMN geo_ptcanv.geo_can; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.geo_can IS 'Origine du point';


--
-- Name: COLUMN geo_ptcanv.geo_ppln; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.geo_ppln IS 'Précision planimétrique';


--
-- Name: COLUMN geo_ptcanv.geo_palt; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.geo_palt IS 'Précision altimétrique';


--
-- Name: COLUMN geo_ptcanv.geo_map; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.geo_map IS 'Stabilité de matérialisation du support';


--
-- Name: COLUMN geo_ptcanv.geo_sym; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.geo_sym IS 'Genre du point';


--
-- Name: COLUMN geo_ptcanv.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_ptcanv.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_ptcanv.update_dat IS 'Date de dernière modification';


--
-- Name: geo_ptcanv_geo_ptcanv_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_ptcanv_geo_ptcanv_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_ptcanv_geo_ptcanv_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_ptcanv_geo_ptcanv_seq OWNED BY cadastre_mtp.geo_ptcanv.geo_ptcanv;


--
-- Name: geo_qupl; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_qupl (
    geo_qupl text NOT NULL,
    geo_qupl_lib text
);


--
-- Name: geo_section; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_section (
    geo_section text NOT NULL,
    annee text NOT NULL,
    object_rid text,
    idu text,
    tex text,
    geo_commune text NOT NULL,
    creat_date date,
    update_dat date,
    lot text,
    ogc_fid integer NOT NULL,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_section; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_section IS 'Partie du plan cadastral correspondant à une portion du territoire communal et comportant, suivant le cas, une ou plusieurs subdivisions de section';


--
-- Name: COLUMN geo_section.geo_section; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_section.geo_section IS 'Identifiant';


--
-- Name: COLUMN geo_section.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_section.annee IS 'Année';


--
-- Name: COLUMN geo_section.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_section.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_section.idu; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_section.idu IS 'Identifiant';


--
-- Name: COLUMN geo_section.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_section.tex IS 'Lettre(s) de section';


--
-- Name: COLUMN geo_section.geo_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_section.geo_commune IS 'Commune';


--
-- Name: COLUMN geo_section.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_section.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_section.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_section.update_dat IS 'Date de dernière modification';


--
-- Name: geo_section_ogc_fid_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_section_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_section_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_section_ogc_fid_seq OWNED BY cadastre_mtp.geo_section.ogc_fid;


--
-- Name: geo_subdfisc; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_subdfisc (
    geo_subdfisc integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    tex text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_subdfisc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_subdfisc IS 'Partie d''une parcelle ayant une seule nature de culture ou de propriété et constituant une unité au regard de la fiscalité directe locale.';


--
-- Name: COLUMN geo_subdfisc.geo_subdfisc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc.geo_subdfisc IS 'Identifiant';


--
-- Name: COLUMN geo_subdfisc.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc.annee IS 'Année';


--
-- Name: COLUMN geo_subdfisc.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_subdfisc.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc.tex IS 'Lettre d''ordre';


--
-- Name: COLUMN geo_subdfisc.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_subdfisc.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc.update_dat IS 'Date de dernière modification';


--
-- Name: geo_subdfisc_geo_subdfisc_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_subdfisc_geo_subdfisc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_subdfisc_geo_subdfisc_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_subdfisc_geo_subdfisc_seq OWNED BY cadastre_mtp.geo_subdfisc.geo_subdfisc;


--
-- Name: geo_subdfisc_parcelle; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_subdfisc_parcelle (
    geo_subdfisc_parcelle integer NOT NULL,
    annee text NOT NULL,
    geo_subdfisc integer NOT NULL,
    geo_parcelle text NOT NULL
);


--
-- Name: TABLE geo_subdfisc_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_subdfisc_parcelle IS 'Lien subdivision fiscale - parcelle';


--
-- Name: COLUMN geo_subdfisc_parcelle.geo_subdfisc_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc_parcelle.geo_subdfisc_parcelle IS 'Identifiant';


--
-- Name: COLUMN geo_subdfisc_parcelle.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc_parcelle.annee IS 'Année';


--
-- Name: COLUMN geo_subdfisc_parcelle.geo_subdfisc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc_parcelle.geo_subdfisc IS 'subdivision fiscale';


--
-- Name: COLUMN geo_subdfisc_parcelle.geo_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdfisc_parcelle.geo_parcelle IS 'geo_parcelle';


--
-- Name: geo_subdfisc_parcelle_geo_subdfisc_parcelle_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_subdfisc_parcelle_geo_subdfisc_parcelle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_subdfisc_parcelle_geo_subdfisc_parcelle_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_subdfisc_parcelle_geo_subdfisc_parcelle_seq OWNED BY cadastre_mtp.geo_subdfisc_parcelle.geo_subdfisc_parcelle;


--
-- Name: geo_subdsect; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_subdsect (
    geo_subdsect text NOT NULL,
    annee text NOT NULL,
    object_rid text,
    idu text,
    geo_section text NOT NULL,
    geo_qupl text,
    geo_copl text,
    eor integer,
    dedi date,
    icl integer,
    dis date,
    geo_inp text,
    dred date,
    creat_date date,
    update_dat date,
    lot text,
    ogc_fid integer NOT NULL,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_subdsect; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_subdsect IS 'Portion de section cadastrale disposant de caractéristiques propres au regard notamment de son échelle, sa qualité, son mode de confection. Une section a au moins une subdivision de section. Cet objet correspond à la feuille cadastrale.';


--
-- Name: COLUMN geo_subdsect.geo_subdsect; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.geo_subdsect IS 'Identifiant';


--
-- Name: COLUMN geo_subdsect.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.annee IS 'Année';


--
-- Name: COLUMN geo_subdsect.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_subdsect.idu; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.idu IS 'Identifiant';


--
-- Name: COLUMN geo_subdsect.geo_section; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.geo_section IS 'Section';


--
-- Name: COLUMN geo_subdsect.geo_qupl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.geo_qupl IS 'Qualité du plan';


--
-- Name: COLUMN geo_subdsect.geo_copl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.geo_copl IS 'Mode de confection';


--
-- Name: COLUMN geo_subdsect.eor; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.eor IS 'Échelle d''origine du plan (que le dénominateur)';


--
-- Name: COLUMN geo_subdsect.dedi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.dedi IS 'Date d''édition ou du confection du plan';


--
-- Name: COLUMN geo_subdsect.icl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.icl IS 'Orientation d''origine (en grade)';


--
-- Name: COLUMN geo_subdsect.dis; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.dis IS 'Date d''incorporation PCI';


--
-- Name: COLUMN geo_subdsect.geo_inp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.geo_inp IS 'Mode d''incorporation au plan';


--
-- Name: COLUMN geo_subdsect.dred; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.dred IS 'Date de réédition';


--
-- Name: COLUMN geo_subdsect.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_subdsect.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_subdsect.update_dat IS 'Date de dernière modification';


--
-- Name: geo_subdsect_ogc_fid_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_subdsect_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_subdsect_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_subdsect_ogc_fid_seq OWNED BY cadastre_mtp.geo_subdsect.ogc_fid;


--
-- Name: geo_sym; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_sym (
    geo_sym text NOT NULL,
    geo_sym_lib text
);


--
-- Name: geo_symblim; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_symblim (
    geo_symblim integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    ori numeric(12,9),
    geo_sym text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(Point,2154)
);


--
-- Name: TABLE geo_symblim; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_symblim IS 'Symbole de limite de propriété représenté par un signe conventionnel de type ponctuel permettant de documenter le plan cadastral et d''en améliorer la lisibilité.';


--
-- Name: COLUMN geo_symblim.geo_symblim; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim.geo_symblim IS 'Identifiant';


--
-- Name: COLUMN geo_symblim.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim.annee IS 'Année';


--
-- Name: COLUMN geo_symblim.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_symblim.ori; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim.ori IS 'Orientation';


--
-- Name: COLUMN geo_symblim.geo_sym; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim.geo_sym IS 'Genre';


--
-- Name: COLUMN geo_symblim.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_symblim.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim.update_dat IS 'Date de dernière modification';


--
-- Name: geo_symblim_geo_symblim_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_symblim_geo_symblim_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_symblim_geo_symblim_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_symblim_geo_symblim_seq OWNED BY cadastre_mtp.geo_symblim.geo_symblim;


--
-- Name: geo_symblim_parcelle; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_symblim_parcelle (
    geo_symblim_parcelle integer NOT NULL,
    annee text NOT NULL,
    geo_symblim integer NOT NULL,
    geo_parcelle text NOT NULL
);


--
-- Name: TABLE geo_symblim_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_symblim_parcelle IS 'Lien symblim - parcelle';


--
-- Name: COLUMN geo_symblim_parcelle.geo_symblim_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim_parcelle.geo_symblim_parcelle IS 'Identifiant';


--
-- Name: COLUMN geo_symblim_parcelle.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim_parcelle.annee IS 'Année';


--
-- Name: COLUMN geo_symblim_parcelle.geo_symblim; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim_parcelle.geo_symblim IS 'symblim';


--
-- Name: COLUMN geo_symblim_parcelle.geo_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_symblim_parcelle.geo_parcelle IS 'Parcelle';


--
-- Name: geo_symblim_parcelle_geo_symblim_parcelle_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_symblim_parcelle_geo_symblim_parcelle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_symblim_parcelle_geo_symblim_parcelle_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_symblim_parcelle_geo_symblim_parcelle_seq OWNED BY cadastre_mtp.geo_symblim_parcelle.geo_symblim_parcelle;


--
-- Name: geo_tline; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_tline (
    geo_tline integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    tex text,
    geo_sym text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(MultiLineString,2154)
);


--
-- Name: TABLE geo_tline; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_tline IS 'Détail topographique linéaire représenté par un signe conventionnel de type linéaire permettant de documenter le plan cadastral et d''en améliorer la lisibilité.';


--
-- Name: COLUMN geo_tline.geo_tline; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline.geo_tline IS 'Identifiant';


--
-- Name: COLUMN geo_tline.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline.annee IS 'Année';


--
-- Name: COLUMN geo_tline.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_tline.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline.tex IS 'Texte du détail';


--
-- Name: COLUMN geo_tline.geo_sym; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline.geo_sym IS 'Genre';


--
-- Name: COLUMN geo_tline.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_tline.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline.update_dat IS 'Date de dernière modification';


--
-- Name: geo_tline_commune; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_tline_commune (
    geo_tline_commune integer NOT NULL,
    annee text NOT NULL,
    geo_tline integer NOT NULL,
    geo_commune text NOT NULL
);


--
-- Name: TABLE geo_tline_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_tline_commune IS 'Lien tline - commune';


--
-- Name: COLUMN geo_tline_commune.geo_tline_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline_commune.geo_tline_commune IS 'Identifiant';


--
-- Name: COLUMN geo_tline_commune.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline_commune.annee IS 'Année';


--
-- Name: COLUMN geo_tline_commune.geo_tline; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline_commune.geo_tline IS 'tline';


--
-- Name: COLUMN geo_tline_commune.geo_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tline_commune.geo_commune IS 'commune';


--
-- Name: geo_tline_commune_geo_tline_commune_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_tline_commune_geo_tline_commune_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_tline_commune_geo_tline_commune_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_tline_commune_geo_tline_commune_seq OWNED BY cadastre_mtp.geo_tline_commune.geo_tline_commune;


--
-- Name: geo_tline_geo_tline_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_tline_geo_tline_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_tline_geo_tline_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_tline_geo_tline_seq OWNED BY cadastre_mtp.geo_tline.geo_tline;


--
-- Name: geo_tpoint; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_tpoint (
    geo_tpoint integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    ori numeric(12,9),
    tex text,
    geo_sym text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(Point,2154)
);


--
-- Name: TABLE geo_tpoint; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_tpoint IS 'Détail topographique ponctuel représenté par un signe conventionnel de type ponctuel permettant de documenter le plan cadastral et d''en améliorer la lisibilité.';


--
-- Name: COLUMN geo_tpoint.geo_tpoint; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint.geo_tpoint IS 'Identifiant';


--
-- Name: COLUMN geo_tpoint.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint.annee IS 'Année';


--
-- Name: COLUMN geo_tpoint.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_tpoint.ori; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint.ori IS 'Orientation';


--
-- Name: COLUMN geo_tpoint.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint.tex IS 'Texte du détail';


--
-- Name: COLUMN geo_tpoint.geo_sym; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint.geo_sym IS 'Genre';


--
-- Name: COLUMN geo_tpoint.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_tpoint.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint.update_dat IS 'Date de dernière modification';


--
-- Name: geo_tpoint_commune; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_tpoint_commune (
    geo_tpoint_commune integer NOT NULL,
    annee text NOT NULL,
    geo_tpoint integer NOT NULL,
    geo_commune text NOT NULL
);


--
-- Name: TABLE geo_tpoint_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_tpoint_commune IS 'Lien tpoint - commune';


--
-- Name: COLUMN geo_tpoint_commune.geo_tpoint_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint_commune.geo_tpoint_commune IS 'Identifiant';


--
-- Name: COLUMN geo_tpoint_commune.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint_commune.annee IS 'Année';


--
-- Name: COLUMN geo_tpoint_commune.geo_tpoint; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint_commune.geo_tpoint IS 'tpoint';


--
-- Name: COLUMN geo_tpoint_commune.geo_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tpoint_commune.geo_commune IS 'commune';


--
-- Name: geo_tpoint_commune_geo_tpoint_commune_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_tpoint_commune_geo_tpoint_commune_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_tpoint_commune_geo_tpoint_commune_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_tpoint_commune_geo_tpoint_commune_seq OWNED BY cadastre_mtp.geo_tpoint_commune.geo_tpoint_commune;


--
-- Name: geo_tpoint_geo_tpoint_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_tpoint_geo_tpoint_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_tpoint_geo_tpoint_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_tpoint_geo_tpoint_seq OWNED BY cadastre_mtp.geo_tpoint.geo_tpoint;


--
-- Name: geo_tronfluv; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_tronfluv (
    geo_tronfluv integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    tex text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_tronfluv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_tronfluv IS 'Élément surfacique (fermé) utilisé pour tous les cours d''eau et les rivages de mers. Un libellé y est associé.';


--
-- Name: COLUMN geo_tronfluv.geo_tronfluv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronfluv.geo_tronfluv IS 'Identifiant';


--
-- Name: COLUMN geo_tronfluv.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronfluv.annee IS 'Année';


--
-- Name: COLUMN geo_tronfluv.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronfluv.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_tronfluv.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronfluv.tex IS 'Nom du cours d''eau';


--
-- Name: COLUMN geo_tronfluv.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronfluv.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_tronfluv.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronfluv.update_dat IS 'Date de dernière modification';


--
-- Name: geo_tronfluv_geo_tronfluv_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_tronfluv_geo_tronfluv_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_tronfluv_geo_tronfluv_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_tronfluv_geo_tronfluv_seq OWNED BY cadastre_mtp.geo_tronfluv.geo_tronfluv;


--
-- Name: geo_tronroute; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_tronroute (
    geo_tronroute integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    tex text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_tronroute; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_tronroute IS 'Élément surfacique (fermé) utilisé pour tous les tronçons de routes. Un libellé y est associé.';


--
-- Name: COLUMN geo_tronroute.geo_tronroute; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronroute.geo_tronroute IS 'Identifiant';


--
-- Name: COLUMN geo_tronroute.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronroute.annee IS 'Année';


--
-- Name: COLUMN geo_tronroute.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronroute.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_tronroute.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronroute.tex IS 'Nom du cours d''eau';


--
-- Name: COLUMN geo_tronroute.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronroute.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_tronroute.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tronroute.update_dat IS 'Date de dernière modification';


--
-- Name: geo_tronroute_geo_tronroute_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_tronroute_geo_tronroute_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_tronroute_geo_tronroute_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_tronroute_geo_tronroute_seq OWNED BY cadastre_mtp.geo_tronroute.geo_tronroute;


--
-- Name: geo_tsurf; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_tsurf (
    geo_tsurf integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    tex text,
    geo_sym text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_tsurf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_tsurf IS 'Détail topographique surfacique représenté par un signe conventionnel de type surfacique permettant de documenter le plan cadastral et d''en améliorer la lisibilité';


--
-- Name: COLUMN geo_tsurf.geo_tsurf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf.geo_tsurf IS 'Identifiant';


--
-- Name: COLUMN geo_tsurf.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf.annee IS 'Année';


--
-- Name: COLUMN geo_tsurf.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_tsurf.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf.tex IS 'Texte du détail';


--
-- Name: COLUMN geo_tsurf.geo_sym; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf.geo_sym IS 'Genre';


--
-- Name: COLUMN geo_tsurf.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_tsurf.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf.update_dat IS 'Date de dernière modification';


--
-- Name: geo_tsurf_commune; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_tsurf_commune (
    geo_tsurf_commune integer NOT NULL,
    annee text NOT NULL,
    geo_tsurf integer NOT NULL,
    geo_commune text NOT NULL
);


--
-- Name: TABLE geo_tsurf_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_tsurf_commune IS 'Lien tsurf - commune';


--
-- Name: COLUMN geo_tsurf_commune.geo_tsurf_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf_commune.geo_tsurf_commune IS 'Identifiant';


--
-- Name: COLUMN geo_tsurf_commune.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf_commune.annee IS 'Année';


--
-- Name: COLUMN geo_tsurf_commune.geo_tsurf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf_commune.geo_tsurf IS 'tsurf';


--
-- Name: COLUMN geo_tsurf_commune.geo_commune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_tsurf_commune.geo_commune IS 'commune';


--
-- Name: geo_tsurf_commune_geo_tsurf_commune_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_tsurf_commune_geo_tsurf_commune_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_tsurf_commune_geo_tsurf_commune_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_tsurf_commune_geo_tsurf_commune_seq OWNED BY cadastre_mtp.geo_tsurf_commune.geo_tsurf_commune;


--
-- Name: geo_tsurf_geo_tsurf_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_tsurf_geo_tsurf_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_tsurf_geo_tsurf_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_tsurf_geo_tsurf_seq OWNED BY cadastre_mtp.geo_tsurf.geo_tsurf;


--
-- Name: geo_unite_fonciere; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_unite_fonciere (
    id integer NOT NULL,
    comptecommunal text,
    annee text NOT NULL,
    lot text,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE geo_unite_fonciere; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_unite_fonciere IS 'Regroupe les unités foncières, c est a dire la fusion de parcelles adjacentes d un même propriétaire';


--
-- Name: COLUMN geo_unite_fonciere.id; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_unite_fonciere.id IS 'Identifiant des unités foncières';


--
-- Name: COLUMN geo_unite_fonciere.comptecommunal; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_unite_fonciere.comptecommunal IS 'Compte communal des parcelles composant l unité foncière';


--
-- Name: COLUMN geo_unite_fonciere.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_unite_fonciere.annee IS 'Année';


--
-- Name: geo_unite_fonciere_id_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_unite_fonciere_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_unite_fonciere_id_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_unite_fonciere_id_seq OWNED BY cadastre_mtp.geo_unite_fonciere.id;


--
-- Name: geo_voiep; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_voiep (
    geo_voiep integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    tex text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(Point,2154)
);


--
-- Name: TABLE geo_voiep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_voiep IS 'Élément ponctuel permettant la gestion de l''ensemble immobilier auquel est associé son libellé.';


--
-- Name: COLUMN geo_voiep.geo_voiep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_voiep.geo_voiep IS 'Identifiant';


--
-- Name: COLUMN geo_voiep.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_voiep.annee IS 'Année';


--
-- Name: COLUMN geo_voiep.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_voiep.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_voiep.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_voiep.tex IS 'Nom de la voie';


--
-- Name: COLUMN geo_voiep.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_voiep.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_voiep.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_voiep.update_dat IS 'Date de dernière modification';


--
-- Name: geo_voiep_geo_voiep_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_voiep_geo_voiep_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_voiep_geo_voiep_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_voiep_geo_voiep_seq OWNED BY cadastre_mtp.geo_voiep.geo_voiep;


--
-- Name: geo_zoncommuni; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.geo_zoncommuni (
    geo_zoncommuni integer NOT NULL,
    annee text NOT NULL,
    object_rid text,
    tex text,
    creat_date date,
    update_dat date,
    lot text,
    geom public.geometry(MultiLineString,2154)
);


--
-- Name: TABLE geo_zoncommuni; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.geo_zoncommuni IS 'Voie du domaine non cadastré (ou passant sur des parcelles non figurées au plan) représentée par un élément linéaire correspondant à son axe.';


--
-- Name: COLUMN geo_zoncommuni.geo_zoncommuni; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_zoncommuni.geo_zoncommuni IS 'Identifiant';


--
-- Name: COLUMN geo_zoncommuni.annee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_zoncommuni.annee IS 'Année';


--
-- Name: COLUMN geo_zoncommuni.object_rid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_zoncommuni.object_rid IS 'Numéro d''objet';


--
-- Name: COLUMN geo_zoncommuni.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_zoncommuni.tex IS 'Nom de la voie';


--
-- Name: COLUMN geo_zoncommuni.creat_date; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_zoncommuni.creat_date IS 'Date de création';


--
-- Name: COLUMN geo_zoncommuni.update_dat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.geo_zoncommuni.update_dat IS 'Date de dernière modification';


--
-- Name: geo_zoncommuni_geo_zoncommuni_seq; Type: SEQUENCE; Schema: cadastre_mtp; Owner: -
--

CREATE SEQUENCE cadastre_mtp.geo_zoncommuni_geo_zoncommuni_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_zoncommuni_geo_zoncommuni_seq; Type: SEQUENCE OWNED BY; Schema: cadastre_mtp; Owner: -
--

ALTER SEQUENCE cadastre_mtp.geo_zoncommuni_geo_zoncommuni_seq OWNED BY cadastre_mtp.geo_zoncommuni.geo_zoncommuni;


--
-- Name: gimtom; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gimtom (
    gimtom text NOT NULL,
    gimtom_lib text
);


--
-- Name: gnexpl; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gnexpl (
    gnexpl text NOT NULL,
    gnexpl_lib text
);


--
-- Name: gnexps; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gnexps (
    gnexps text NOT NULL,
    gnexps_lib text
);


--
-- Name: gnextl; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gnextl (
    gnextl text NOT NULL,
    gnextl_lib text
);


--
-- Name: gnexts; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gnexts (
    gnexts text NOT NULL,
    gnexts_lib text
);


--
-- Name: gpdl; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gpdl (
    gpdl text NOT NULL,
    gpdl_lib text
);


--
-- Name: gtoper; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gtoper (
    gtoper text NOT NULL,
    gtoper_lib text
);


--
-- Name: gtyp3; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gtyp3 (
    gtyp3 text NOT NULL,
    gtyp3_lib text
);


--
-- Name: gtyp4; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gtyp4 (
    gtyp4 text NOT NULL,
    gtyp4_lib text
);


--
-- Name: gtyp5; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gtyp5 (
    gtyp5 text NOT NULL,
    gtyp5_lib text
);


--
-- Name: gtyp6; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.gtyp6 (
    gtyp6 text NOT NULL,
    gtyp6_lib text
);


--
-- Name: hlmsem; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.hlmsem (
    hlmsem text NOT NULL,
    hlmsem_lib text
);


--
-- Name: indldnbat; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.indldnbat (
    indldnbat text NOT NULL,
    indldnbat_lib text
);


--
-- Name: lloc; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.lloc (
    tmp text
);


--
-- Name: local00; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.local00 (
    local00 text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    ccopre text,
    ccosec text,
    dnupla text,
    parcelle text,
    dnubat text,
    descr text,
    dniv text,
    dpor text,
    ccoriv text,
    voie text,
    ccovoi text,
    dnvoiri text,
    dindic text,
    ccocif text,
    dvoilib text,
    cleinvar text,
    ccpper text,
    locinc text,
    lot text
);


--
-- Name: TABLE local00; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.local00 IS 'Article identifiant du local';


--
-- Name: COLUMN local00.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.ccodep IS 'code département - ';


--
-- Name: COLUMN local00.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.ccodir IS 'code direction - ';


--
-- Name: COLUMN local00.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.ccocom IS 'code commune INSEE - ';


--
-- Name: COLUMN local00.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.invar IS 'numéro invariant - ';


--
-- Name: COLUMN local00.ccopre; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.ccopre IS 'préfixe de section ou quartier servi pour les communes associées, - ';


--
-- Name: COLUMN local00.ccosec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.ccosec IS 'lettres de section - ';


--
-- Name: COLUMN local00.dnupla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.dnupla IS 'numéro de plan - ';


--
-- Name: COLUMN local00.dnubat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.dnubat IS 'lettre de bâtiment - ';


--
-- Name: COLUMN local00.descr; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.descr IS 'numéro d’entrée - ';


--
-- Name: COLUMN local00.dniv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.dniv IS 'niveau étage - ';


--
-- Name: COLUMN local00.dpor; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.dpor IS 'numéro de local - ';


--
-- Name: COLUMN local00.ccoriv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.ccoriv IS 'Code Rivoli de la voie - ';


--
-- Name: COLUMN local00.ccovoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.ccovoi IS 'Code Majic2 de la voie - ';


--
-- Name: COLUMN local00.dnvoiri; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.dnvoiri IS 'Numéro de voirie - ';


--
-- Name: COLUMN local00.dindic; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.dindic IS 'indice de répétition - ';


--
-- Name: COLUMN local00.ccocif; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.ccocif IS 'code du cdi/cdif (code topad) - ';


--
-- Name: COLUMN local00.dvoilib; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.dvoilib IS 'libelle de la voie - ';


--
-- Name: COLUMN local00.cleinvar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.cleinvar IS 'clé alpha no invariant - ';


--
-- Name: COLUMN local00.ccpper; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.ccpper IS 'Code de trésorerie gestionnaire - ';


--
-- Name: COLUMN local00.locinc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local00.locinc IS 'code local sans évaluation - INDISPONIBLE';


--
-- Name: local10; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.local10 (
    local10 text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    local00 text,
    ccopre text,
    ccosec text,
    dnupla text,
    parcelle text,
    ccoriv text,
    voie text,
    ccovoi text,
    dnvoiri text,
    gpdl text,
    dsrpar text,
    dnupro text,
    comptecommunal text,
    jdatat text,
    dnufnl text,
    ccoeva text,
    ccitlv text,
    dteloc text,
    gtauom text,
    dcomrd text,
    ccoplc text,
    cconlc text,
    dvltrt integer,
    ccoape text,
    cc48lc text,
    dloy48a integer,
    top48a text,
    dnatlc text,
    dnupas text,
    gnexcf text,
    dtaucf text,
    cchpr text,
    jannat text,
    dnbniv text,
    hlmsem text,
    postel text,
    dnatcg text,
    jdatcgl text,
    dnutbx text,
    dvltla text,
    janloc text,
    ccsloc text,
    fburx integer,
    gimtom text,
    cbtabt text,
    jdtabt text,
    jrtabt text,
    jacloc text,
    cconac text,
    toprev text,
    ccoifp integer,
    lot text
);


--
-- Name: TABLE local10; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.local10 IS 'Article identifiant du local';


--
-- Name: COLUMN local10.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.ccodep IS 'code département - ';


--
-- Name: COLUMN local10.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.ccodir IS 'code direction - ';


--
-- Name: COLUMN local10.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.ccocom IS 'code commune INSEE - ';


--
-- Name: COLUMN local10.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.invar IS 'numéro invariant - ';


--
-- Name: COLUMN local10.gpdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.gpdl IS 'indicateur d’appartenance à un lot de pdl - 1 = oui, sinon 0';


--
-- Name: COLUMN local10.dsrpar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dsrpar IS 'lettre de série rôle - INDISPONIBLE';


--
-- Name: COLUMN local10.dnupro; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dnupro IS 'compte communal de propriétaire - ';


--
-- Name: COLUMN local10.jdatat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.jdatat IS 'date d’acte de mutation - jjmmaaaa';


--
-- Name: COLUMN local10.dnufnl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dnufnl IS 'compte communal de fonctionnaire logé - redevable de la tom';


--
-- Name: COLUMN local10.ccoeva; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.ccoeva IS 'code évaluation - A B C D E T tableau 2.3.1';


--
-- Name: COLUMN local10.ccitlv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.ccitlv IS 'local imposable à la taxe sur les locaux vacants - indisponible';


--
-- Name: COLUMN local10.dteloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dteloc IS 'type de local - 1 à 8 tableau 2.3.2';


--
-- Name: COLUMN local10.gtauom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.gtauom IS 'zone de ramassage des ordures ménagères - P RA RB RC RD ou blanc';


--
-- Name: COLUMN local10.dcomrd; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dcomrd IS 'Pourcentage de réduction sur tom - ';


--
-- Name: COLUMN local10.ccoplc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.ccoplc IS 'Code de construction particulière - R U V W X Y Z ou blanc tabl. 2.3.3';


--
-- Name: COLUMN local10.cconlc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.cconlc IS 'Code nature de local - voir tableau 2.3.4';


--
-- Name: COLUMN local10.dvltrt; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dvltrt IS 'Valeur locative totale retenue pour le local - ';


--
-- Name: COLUMN local10.ccoape; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.ccoape IS 'Code NAF pour les locaux professionnels - ';


--
-- Name: COLUMN local10.cc48lc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.cc48lc IS 'Catégorie de loi de 48 - ';


--
-- Name: COLUMN local10.dloy48a; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dloy48a IS 'Loyer de 48 en valeur de l’année - ';


--
-- Name: COLUMN local10.top48a; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.top48a IS 'top taxation indiquant si la pev est impose au loyer ou a la vl - 1 = loyer o = vl';


--
-- Name: COLUMN local10.dnatlc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dnatlc IS 'Nature d occupation - A P V L T D tableau 2.3.6';


--
-- Name: COLUMN local10.dnupas; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dnupas IS 'no passerelle TH/TP - INDISPONIBLE';


--
-- Name: COLUMN local10.gnexcf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.gnexcf IS 'code nature exo ecf - INDISPONIBLE';


--
-- Name: COLUMN local10.dtaucf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dtaucf IS 'taux exo ecf - INDISPONIBLE';


--
-- Name: COLUMN local10.cchpr; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.cchpr IS 'Top indiquant une mutation propriétaire - * ou blanc';


--
-- Name: COLUMN local10.jannat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.jannat IS 'Année de construction - ';


--
-- Name: COLUMN local10.dnbniv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dnbniv IS 'Nombre de niveaux de la construction - ';


--
-- Name: COLUMN local10.hlmsem; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.hlmsem IS 'Local appartenant à hlm ou sem - 5 = hlm, 6 = sem, sinon blanc';


--
-- Name: COLUMN local10.postel; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.postel IS 'Local de Poste ou France Telecom - X, Y, Z, ou blanc ';


--
-- Name: COLUMN local10.dnatcg; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dnatcg IS 'Code nature du changement d’évaluation (depuis 2013)';


--
-- Name: COLUMN local10.jdatcgl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.jdatcgl IS 'Date changement évaluation - JJMMSSAA (Depuis 2013)';


--
-- Name: COLUMN local10.dnutbx; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dnutbx IS 'no gestionnaire déclarant taxe bureaux - INDISPONIBLE';


--
-- Name: COLUMN local10.dvltla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.dvltla IS 'VL totale du local actualisée - INDISPONIBLE';


--
-- Name: COLUMN local10.janloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.janloc IS 'Année de création du local - INDISPONIBLE';


--
-- Name: COLUMN local10.ccsloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.ccsloc IS 'Code cause création du local - INDISPONIBLE';


--
-- Name: COLUMN local10.fburx; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.fburx IS 'Indicateur présence bureaux - INDISPONIBLE';


--
-- Name: COLUMN local10.gimtom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.gimtom IS 'Indicateur imposition OM exploitable à partir de 2002  - D, E, V ou blanc';


--
-- Name: COLUMN local10.cbtabt; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.cbtabt IS 'Code exonération HLM zone sensible - ZS, ZT ou blanc';


--
-- Name: COLUMN local10.jdtabt; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.jdtabt IS 'Année début d’exonération ZS - ';


--
-- Name: COLUMN local10.jrtabt; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.jrtabt IS 'Année fin d’exonération ZS - ';


--
-- Name: COLUMN local10.jacloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.jacloc IS 'Année d’achèvement du local - INDISPONIBLE';


--
-- Name: COLUMN local10.cconac; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.cconac IS 'Code NACE pour les locaux professionnels';


--
-- Name: COLUMN local10.toprev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.toprev IS 'Top local révisé. 0 si non révisé, 1 si révisé.';


--
-- Name: COLUMN local10.ccoifp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.local10.ccoifp IS 'Code IFP';


--
-- Name: lots; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.lots (
    lots text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    ccopre text,
    ccosec text,
    dnupla text,
    parcelle text,
    dnupdl text,
    pdl text,
    dnulot text,
    cconlo text,
    dcntlo integer,
    dnumql integer,
    ddenql integer,
    dfilot text,
    datact text,
    dnuprol text,
    comptecommunal text,
    dreflf text,
    ccocif text,
    lot text
);


--
-- Name: TABLE lots; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.lots IS 'Article descriptif du lot';


--
-- Name: COLUMN lots.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.ccodep IS 'code département - ';


--
-- Name: COLUMN lots.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.ccodir IS 'code direction - ';


--
-- Name: COLUMN lots.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.ccocom IS 'code commune INSEE - ';


--
-- Name: COLUMN lots.ccopre; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.ccopre IS 'code du préfixe - ';


--
-- Name: COLUMN lots.ccosec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.ccosec IS 'lettres de section - ';


--
-- Name: COLUMN lots.dnupla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.dnupla IS 'numéro de plan - ';


--
-- Name: COLUMN lots.dnupdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.dnupdl IS 'no de pdl - ';


--
-- Name: COLUMN lots.dnulot; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.dnulot IS 'Numéro de lot - ';


--
-- Name: COLUMN lots.cconlo; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.cconlo IS 'Code nature du lot - ';


--
-- Name: COLUMN lots.dcntlo; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.dcntlo IS 'Superficie du lot - ';


--
-- Name: COLUMN lots.dnumql; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.dnumql IS 'Numérateur - ';


--
-- Name: COLUMN lots.ddenql; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.ddenql IS 'Dénominateur - ';


--
-- Name: COLUMN lots.dfilot; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.dfilot IS 'pdl-fille du lot - ';


--
-- Name: COLUMN lots.datact; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.datact IS 'date de l''acte - ';


--
-- Name: COLUMN lots.dnuprol; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.dnuprol IS 'Compte du lot - ';


--
-- Name: COLUMN lots.dreflf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.dreflf IS 'Référence livre foncier - ';


--
-- Name: COLUMN lots.ccocif; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lots.ccocif IS 'code cdif - ';


--
-- Name: lotslocaux; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.lotslocaux (
    lotslocaux text NOT NULL,
    annee text,
    ccodepl text,
    ccodirl text,
    ccocoml text,
    ccoprel text,
    ccosecl text,
    dnuplal text,
    dnupdl text,
    dnulot text,
    lots text,
    ccodebpb text,
    ccodird text,
    ccocomb text,
    ccopreb text,
    invloc text,
    local00 text,
    local10 text,
    dnumql text,
    ddenql text,
    lot text
);


--
-- Name: TABLE lotslocaux; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.lotslocaux IS 'Article descriptif du lot';


--
-- Name: COLUMN lotslocaux.ccodepl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ccodepl IS 'Lot - Code département - ';


--
-- Name: COLUMN lotslocaux.ccodirl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ccodirl IS 'Lot - Code direction - ';


--
-- Name: COLUMN lotslocaux.ccocoml; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ccocoml IS 'Lot - Code INSEE de la commune - ';


--
-- Name: COLUMN lotslocaux.ccoprel; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ccoprel IS 'Lot - Code préfixe - ';


--
-- Name: COLUMN lotslocaux.ccosecl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ccosecl IS 'Lot - Code section - ';


--
-- Name: COLUMN lotslocaux.dnuplal; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.dnuplal IS 'Lot - Numéro du plan - ';


--
-- Name: COLUMN lotslocaux.dnupdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.dnupdl IS 'Lot - Numéro de PDL - ';


--
-- Name: COLUMN lotslocaux.dnulot; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.dnulot IS 'Lot - Numéro de lot - ';


--
-- Name: COLUMN lotslocaux.ccodebpb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ccodebpb IS 'Local - Code département - ';


--
-- Name: COLUMN lotslocaux.ccodird; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ccodird IS 'Local - Code direction - ';


--
-- Name: COLUMN lotslocaux.ccocomb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ccocomb IS 'Local - Code commune - ';


--
-- Name: COLUMN lotslocaux.ccopreb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ccopreb IS 'Local - Code préfixe - ';


--
-- Name: COLUMN lotslocaux.invloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.invloc IS 'Local - Numéro invariant du local - ';


--
-- Name: COLUMN lotslocaux.dnumql; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.dnumql IS 'Local - Numérateur du lot - ';


--
-- Name: COLUMN lotslocaux.ddenql; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.lotslocaux.ddenql IS 'Local - Dénominateur du lot - ';


--
-- Name: natvoi; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.natvoi (
    natvoi text NOT NULL,
    natvoi_lib text
);


--
-- Name: natvoiriv; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.natvoiriv (
    natvoiriv text NOT NULL,
    natvoiriv_lib text
);


--
-- Name: nbat; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.nbat (
    tmp text
);


--
-- Name: parcelle; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.parcelle (
    parcelle text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    ccopre text,
    ccosec text,
    dnupla text,
    dcntpa integer,
    dsrpar text,
    dnupro text,
    comptecommunal text,
    jdatat text,
    dreflf text,
    gpdl text,
    cprsecr text,
    ccosecr text,
    dnuplar text,
    dnupdl text,
    pdl text,
    gurbpa text,
    dparpi text,
    ccoarp text,
    gparnf text,
    gparbat text,
    parrev text,
    gpardp text,
    fviti text,
    dnvoiri text,
    dindic text,
    ccovoi text,
    ccoriv text,
    voie text,
    ccocif text,
    ccpper text,
    gpafpd text,
    ajoutcoherence text,
    cconvo text,
    dvoilib text,
    ccocomm text,
    ccoprem text,
    ccosecm text,
    dnuplam text,
    parcellefiliation text,
    type_filiation text,
    ccoifp integer,
    inspireid text,
    lot text
);


--
-- Name: TABLE parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.parcelle IS 'Article descriptif de parcelle';


--
-- Name: COLUMN parcelle.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccodep IS 'Code département - ';


--
-- Name: COLUMN parcelle.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccodir IS 'Code direction - ';


--
-- Name: COLUMN parcelle.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccocom IS 'Code commune INSEE ou DGI d’arrondissement - ';


--
-- Name: COLUMN parcelle.ccopre; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccopre IS 'Préfixe de section ou quartier servi pour les communes associées. - ';


--
-- Name: COLUMN parcelle.ccosec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccosec IS 'Section cadastrale - ';


--
-- Name: COLUMN parcelle.dnupla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dnupla IS 'Numéro de plan - ';


--
-- Name: COLUMN parcelle.dcntpa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dcntpa IS 'Contenance de la parcelle - en centiares';


--
-- Name: COLUMN parcelle.dsrpar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dsrpar IS 'Lettre de série-role - INDISPONIBLE depuis 2018';


--
-- Name: COLUMN parcelle.dnupro; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dnupro IS 'Compte communal du propriétaire de la parcelle - ';


--
-- Name: COLUMN parcelle.jdatat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.jdatat IS 'Date de l acte - jjmmaaaa';


--
-- Name: COLUMN parcelle.dreflf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dreflf IS 'Référence au Livre Foncier en Alsace-Moselle - ';


--
-- Name: COLUMN parcelle.gpdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.gpdl IS 'Indicateur d’appartenance à pdl Identifiant de la pdl - cf. détail supra si gpdl =2';


--
-- Name: COLUMN parcelle.cprsecr; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.cprsecr IS 'Préfixe de la parcelle de référence - ';


--
-- Name: COLUMN parcelle.ccosecr; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccosecr IS 'Section de la parcelle de référence - ';


--
-- Name: COLUMN parcelle.dnuplar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dnuplar IS 'N° de plan de la parcelle de référence - ';


--
-- Name: COLUMN parcelle.dnupdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dnupdl IS 'Numéro d’ordre de la pdl - en général, 001';


--
-- Name: COLUMN parcelle.gurbpa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.gurbpa IS 'Caractère Urbain de la parcelle - U, * ou blanc';


--
-- Name: COLUMN parcelle.dparpi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dparpi IS 'Numéro de parcelle primitive - ';


--
-- Name: COLUMN parcelle.ccoarp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccoarp IS 'Indicateur d’arpentage - A ou blanc';


--
-- Name: COLUMN parcelle.gparnf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.gparnf IS 'Indicateur de parcelle non figurée au plan - 1 = figurée, 0 = non figurée';


--
-- Name: COLUMN parcelle.gparbat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.gparbat IS 'Indicateur de parcelle référençant un bâtiment - 1 = oui, sinon 0';


--
-- Name: COLUMN parcelle.parrev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.parrev IS 'Info de la révision - INDISPONIBLE';


--
-- Name: COLUMN parcelle.gpardp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.gpardp IS 'parcelle n''appartenant pas au domaine public - INDISPONIBLE';


--
-- Name: COLUMN parcelle.fviti; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.fviti IS 'parcelle au casier viticole  Adresse de la parcelle - INDISPONIBLE';


--
-- Name: COLUMN parcelle.dnvoiri; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dnvoiri IS 'Numéro de voirie - ';


--
-- Name: COLUMN parcelle.dindic; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dindic IS 'Indice de répétition - ';


--
-- Name: COLUMN parcelle.ccovoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccovoi IS 'Code Majic2 de la voie - ';


--
-- Name: COLUMN parcelle.ccoriv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccoriv IS 'Code Rivoli de la voie - ';


--
-- Name: COLUMN parcelle.ccocif; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccocif IS 'Code du cdif (code topad) - ';


--
-- Name: COLUMN parcelle.ccpper; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccpper IS 'Code de la trésorerie (code TOPAD) - ';


--
-- Name: COLUMN parcelle.gpafpd; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.gpafpd IS 'Domanialité, représentation au plan - INDISPONIBLE';


--
-- Name: COLUMN parcelle.cconvo; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.cconvo IS 'Code nature de la voie';


--
-- Name: COLUMN parcelle.dvoilib; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dvoilib IS 'Libellé de la voie';


--
-- Name: COLUMN parcelle.ccocomm; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccocomm IS 'Code INSEE de la commune de la parcelle mère';


--
-- Name: COLUMN parcelle.ccoprem; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccoprem IS 'Code du préfixe de section de la parcelle mère';


--
-- Name: COLUMN parcelle.ccosecm; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccosecm IS 'Code section de la parcelle mère';


--
-- Name: COLUMN parcelle.dnuplam; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.dnuplam IS 'Numéro de plan de la parcelle mère';


--
-- Name: COLUMN parcelle.parcellefiliation; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.parcellefiliation IS 'Parcelle en filiation';


--
-- Name: COLUMN parcelle.type_filiation; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.type_filiation IS 'Type de filiation (D, R, T ou blanc)';


--
-- Name: COLUMN parcelle.ccoifp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle.ccoifp IS 'Code IFP';


--
-- Name: parcelle_info; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.parcelle_info (
    ogc_fid integer NOT NULL,
    geo_parcelle text,
    idu text,
    tex text,
    geo_section text,
    nomcommune text,
    codecommune text,
    surface_geo bigint,
    contenance bigint,
    lot text,
    geom public.geometry(MultiPolygon,2154)
);


--
-- Name: TABLE parcelle_info; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.parcelle_info IS 'Table de parcelles consolidées, proposant les géométries et les informations MAJIC principales, dont les propriétaires';


--
-- Name: COLUMN parcelle_info.ogc_fid; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.ogc_fid IS 'Identifiant unique (base de données)';


--
-- Name: COLUMN parcelle_info.geo_parcelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.geo_parcelle IS 'Identifiant de la parcelle : année + département + direction + idu';


--
-- Name: COLUMN parcelle_info.idu; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.idu IS 'Identifiant de la parcelle (unique par département et direction seulement)';


--
-- Name: COLUMN parcelle_info.tex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.tex IS 'Etiquette (code à 3 chiffres)';


--
-- Name: COLUMN parcelle_info.geo_section; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.geo_section IS 'Code de la section (lien vers table geo_section.geo_section)';


--
-- Name: COLUMN parcelle_info.nomcommune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.nomcommune IS 'Nom de la commune';


--
-- Name: COLUMN parcelle_info.codecommune; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.codecommune IS 'Code de la commune à 3 chiffres';


--
-- Name: COLUMN parcelle_info.surface_geo; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.surface_geo IS 'Surface de la parcelle, calculée spatialement';


--
-- Name: COLUMN parcelle_info.contenance; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.contenance IS 'Surface cadastrale de la parcelle';


--
-- Name: COLUMN parcelle_info.lot; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcelle_info.lot IS 'Lot utilisé pendant l''import';


--
-- Name: parcellecomposante; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.parcellecomposante (
    parcellecomposante text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    ccopre text,
    ccosec text,
    dnupla text,
    parcelle text,
    dnupdl text,
    pdl text,
    ccoprea text,
    ccoseca text,
    dnuplaa text,
    parcellea text,
    ccocif text,
    lot text
);


--
-- Name: TABLE parcellecomposante; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.parcellecomposante IS 'Parcelle composante de la pdl autre que la parcelle de référence';


--
-- Name: COLUMN parcellecomposante.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.ccodep IS 'code département - ';


--
-- Name: COLUMN parcellecomposante.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.ccodir IS 'code direction - ';


--
-- Name: COLUMN parcellecomposante.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.ccocom IS 'code commune INSEE - ';


--
-- Name: COLUMN parcellecomposante.ccopre; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.ccopre IS 'code du préfixe - ';


--
-- Name: COLUMN parcellecomposante.ccosec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.ccosec IS 'lettres de section - ';


--
-- Name: COLUMN parcellecomposante.dnupla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.dnupla IS 'numéro de plan - ';


--
-- Name: COLUMN parcellecomposante.dnupdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.dnupdl IS 'no de pdl - ';


--
-- Name: COLUMN parcellecomposante.ccoprea; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.ccoprea IS 'code du préfixe - ';


--
-- Name: COLUMN parcellecomposante.ccoseca; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.ccoseca IS 'lettres de section - ';


--
-- Name: COLUMN parcellecomposante.dnuplaa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.dnuplaa IS 'numéro de plan - ';


--
-- Name: COLUMN parcellecomposante.ccocif; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.parcellecomposante.ccocif IS 'code cdif - ';


--
-- Name: pdl; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pdl (
    pdl text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    ccopre text,
    ccosec text,
    dnupla text,
    parcelle text,
    dnupdl text,
    dnivim text,
    ctpdl text,
    dmrpdl text,
    gprmut text,
    dnupro text,
    comptecommunal text,
    ccocif text,
    lot text
);


--
-- Name: TABLE pdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pdl IS 'Propriétés divisées en lots';


--
-- Name: COLUMN pdl.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.ccodep IS 'code département - ';


--
-- Name: COLUMN pdl.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.ccodir IS 'code direction - ';


--
-- Name: COLUMN pdl.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.ccocom IS 'code commune INSEE - ';


--
-- Name: COLUMN pdl.ccopre; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.ccopre IS 'code du préfixe - ';


--
-- Name: COLUMN pdl.ccosec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.ccosec IS 'lettres de section - ';


--
-- Name: COLUMN pdl.dnupla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.dnupla IS 'numéro de plan - ';


--
-- Name: COLUMN pdl.dnupdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.dnupdl IS 'no de pdl - ';


--
-- Name: COLUMN pdl.dnivim; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.dnivim IS 'niveau imbrication - ';


--
-- Name: COLUMN pdl.ctpdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.ctpdl IS 'type de pdl - bnd, cl, cv, tf, clv, mp.';


--
-- Name: COLUMN pdl.dmrpdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.dmrpdl IS 'lot mère(plan+pdl+lot) - ';


--
-- Name: COLUMN pdl.gprmut; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.gprmut IS 'top ''1ere mut effectuée - ';


--
-- Name: COLUMN pdl.dnupro; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.dnupro IS 'compte de la pdl - ';


--
-- Name: COLUMN pdl.ccocif; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pdl.ccocif IS 'code cdif - ';


--
-- Name: pdll; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pdll (
    tmp text
);


--
-- Name: pev; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pev (
    pev text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    local10 text,
    dnupev text,
    ccoaff text,
    ccostb text,
    dcapec text,
    dcetlc numeric(3,2),
    dcsplc text,
    dsupot integer,
    dvlper integer,
    dvlpera integer,
    gnexpl text,
    libocc text,
    ccthp text,
    retimp text,
    dnuref text,
    rclsst text,
    gnidom text,
    dcsglc text,
    ccogrb text,
    cocdi text,
    cosatp text,
    gsatp text,
    clocv text,
    dvltpe integer,
    dcralc text,
    dcsplca text,
    dcsglca text,
    dcralca text,
    topcn integer,
    tpevtieom integer,
    ccocac text,
    dnutrf text,
    dcfloc integer,
    ccortar integer,
    ccorvl text,
    dtaurv integer,
    dcmloc integer,
    lot text
);


--
-- Name: TABLE pev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pev IS 'Article descriptif de pev';


--
-- Name: COLUMN pev.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccodep IS 'Code département - ';


--
-- Name: COLUMN pev.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccodir IS 'Code direction - ';


--
-- Name: COLUMN pev.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccocom IS 'Code commune INSEE - ';


--
-- Name: COLUMN pev.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.invar IS 'Numéro invariant - ';


--
-- Name: COLUMN pev.dnupev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dnupev IS 'Numéro de pev - ';


--
-- Name: COLUMN pev.ccoaff; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccoaff IS 'Affectation de la pev - H P L S K tableau 2.3.7';


--
-- Name: COLUMN pev.ccostb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccostb IS 'lettre de série tarif bâtie ou secteur locatif - A à Z sauf';


--
-- Name: COLUMN pev.dcapec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcapec IS 'Catégorie - Commentaires 2.2.3';


--
-- Name: COLUMN pev.dcetlc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcetlc IS 'Coefficient d entretien - 9V99';


--
-- Name: COLUMN pev.dcsplc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcsplc IS 'Coefficient de situation particulière - S9V99 - INDISPONIBLE';


--
-- Name: COLUMN pev.dsupot; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dsupot IS 'Surface pondérée - Présence non systématique';


--
-- Name: COLUMN pev.dvlper; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dvlper IS 'Valeur locative de la pev, en valeur de référence (1970) sauf pour les établissements de code évaluation A - ';


--
-- Name: COLUMN pev.dvlpera; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dvlpera IS 'Valeur locative de la pev, en valeur de l’année - ';


--
-- Name: COLUMN pev.gnexpl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.gnexpl IS 'Nature d’exonération permanente - Gérée dans pour les tableau 2.3.8';


--
-- Name: COLUMN pev.libocc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.libocc IS 'nom de l occupant INDISPONIBLE - ';


--
-- Name: COLUMN pev.ccthp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccthp IS 'Code occupation à la Th ou à la TP - ';


--
-- Name: COLUMN pev.retimp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.retimp IS 'Top : retour partiel ou total à imposition - ';


--
-- Name: COLUMN pev.dnuref; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dnuref IS 'Numéro de local type - ';


--
-- Name: COLUMN pev.rclsst; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.rclsst IS 'Données reclassement - INDISPONIBLE';


--
-- Name: COLUMN pev.gnidom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.gnidom IS 'Top : pev non imposable (Dom) - ';


--
-- Name: COLUMN pev.dcsglc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcsglc IS 'Coefficient de situation générale - S9V99';


--
-- Name: COLUMN pev.ccogrb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccogrb IS 'Code groupe bâti révisé - INDISPONIBLE';


--
-- Name: COLUMN pev.cocdi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.cocdi IS 'Code cdi topad - INDISPONIBLE';


--
-- Name: COLUMN pev.cosatp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.cosatp IS 'Code service topad - INDISPONIBLE';


--
-- Name: COLUMN pev.gsatp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.gsatp IS 'Nature service gérant tp - INDISPONIBLE';


--
-- Name: COLUMN pev.clocv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.clocv IS 'Indicateur local vacant - INDISPONIBLE';


--
-- Name: COLUMN pev.dvltpe; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dvltpe IS 'VL TOTALE DE LA PEV MAJIC2 - ';


--
-- Name: COLUMN pev.dcralc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcralc IS 'correctif d’ascenseur - format S9V99 - INDISPONIBLE';


--
-- Name: COLUMN pev.dcsplca; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcsplca IS 'Coefficient de situation particulière';


--
-- Name: COLUMN pev.dcsglca; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcsglca IS 'Coefficient de situation générale';


--
-- Name: COLUMN pev.dcralca; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcralca IS 'Correctif d’ascenseur';


--
-- Name: COLUMN pev.topcn; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.topcn IS 'Top construction nouvelle (à partir de 2013)';


--
-- Name: COLUMN pev.tpevtieom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.tpevtieom IS 'Top Local passible de la TEOM (à partir de 2013)';


--
-- Name: COLUMN pev.ccocac; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccocac IS 'Code catégorie du local';


--
-- Name: COLUMN pev.dnutrf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dnutrf IS 'Secteur révisé';


--
-- Name: COLUMN pev.dcfloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcfloc IS 'Coefficient de localisation';


--
-- Name: COLUMN pev.ccortar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccortar IS 'Code commune origine du tarif';


--
-- Name: COLUMN pev.ccorvl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.ccorvl IS 'Code réduction du local';


--
-- Name: COLUMN pev.dtaurv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dtaurv IS 'Taux de réduction';


--
-- Name: COLUMN pev.dcmloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pev.dcmloc IS 'Coefficient de modulation du local';


--
-- Name: pevdependances; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pevdependances (
    pevdependances text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    dnupev text,
    pev text,
    dnudes text,
    dsudep integer,
    cconad text,
    asitet text,
    dmatgm text,
    dmatto text,
    detent text,
    geaulc text,
    gelelc text,
    gchclc text,
    dnbbai text,
    dnbdou text,
    dnblav text,
    dnbwc text,
    deqtlc integer,
    dcimlc numeric(2,1),
    dcetde numeric(3,2),
    dcspde text,
    dcspdea text,
    lot text
);


--
-- Name: TABLE pevdependances; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pevdependances IS 'Article descriptif de dépendance. Bati enregistrement 60';


--
-- Name: COLUMN pevdependances.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.ccodep IS 'Code département - ';


--
-- Name: COLUMN pevdependances.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.ccodir IS 'Code direction - ';


--
-- Name: COLUMN pevdependances.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.ccocom IS 'Code commune INSEE - ';


--
-- Name: COLUMN pevdependances.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.invar IS 'Numéro invariant - ';


--
-- Name: COLUMN pevdependances.dnupev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dnupev IS 'Numéro de pev - ';


--
-- Name: COLUMN pevdependances.dnudes; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dnudes IS 'Numéro d’ordre de descriptif - 001, 002';


--
-- Name: COLUMN pevdependances.dsudep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dsudep IS 'Surface réelle de la dépendance - ';


--
-- Name: COLUMN pevdependances.cconad; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.cconad IS 'Nature de dépendance - cf tableau des codes';


--
-- Name: COLUMN pevdependances.asitet; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.asitet IS 'Localisation (bat, esc, niv) - ';


--
-- Name: COLUMN pevdependances.dmatgm; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dmatgm IS 'Matériaux des gros murs - 0 à 9 cf art 40';


--
-- Name: COLUMN pevdependances.dmatto; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dmatto IS 'Matériaux des toitures - 0 à 4 cf art 40';


--
-- Name: COLUMN pevdependances.detent; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.detent IS 'état d''entretien - 1 à 5 cf art 40';


--
-- Name: COLUMN pevdependances.geaulc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.geaulc IS 'Présence d''eau - O = oui, N = non';


--
-- Name: COLUMN pevdependances.gelelc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.gelelc IS 'Présence d’électricité - O = oui, N = non';


--
-- Name: COLUMN pevdependances.gchclc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.gchclc IS 'Présence du chauffage central - O = oui, N = non';


--
-- Name: COLUMN pevdependances.dnbbai; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dnbbai IS 'Nombre de baignoires - ';


--
-- Name: COLUMN pevdependances.dnbdou; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dnbdou IS 'Nombre de douches - ';


--
-- Name: COLUMN pevdependances.dnblav; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dnblav IS 'Nombre de lavabos - ';


--
-- Name: COLUMN pevdependances.dnbwc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dnbwc IS 'Nombre de WC - ';


--
-- Name: COLUMN pevdependances.deqtlc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.deqtlc IS 'Equivalence superficielle des - ';


--
-- Name: COLUMN pevdependances.dcimlc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dcimlc IS 'Coefficient de pondération - 1,0 - 0,2 à 0,6';


--
-- Name: COLUMN pevdependances.dcetde; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dcetde IS 'Coefficient d entretien - 9V99';


--
-- Name: COLUMN pevdependances.dcspde; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dcspde IS 'Coefficient de situation particulière - S9V99 de -0,10 à +0,10  -- INDISPONIBLE';


--
-- Name: COLUMN pevdependances.dcspdea; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevdependances.dcspdea IS 'Coefficient de situation particulière';


--
-- Name: pevexoneration; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pevexoneration (
    pevexoneration text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    janbil text,
    dnupev text,
    pev text,
    dnuexb text,
    ccolloc text,
    pexb numeric(5,2),
    gnextl text,
    jandeb text,
    janimp text,
    vecdif text,
    vecdifa text,
    fcexb text,
    fcexba text,
    rcexba text,
    dvldif2 integer,
    dvldif2a integer,
    fcexb2 integer,
    fcexba2 integer,
    rcexba2 integer,
    valplaf text,
    lot text
);


--
-- Name: TABLE pevexoneration; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pevexoneration IS 'Article exonération de pev imposable';


--
-- Name: COLUMN pevexoneration.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.ccodep IS 'Code département - ';


--
-- Name: COLUMN pevexoneration.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.ccodir IS 'Code direction - ';


--
-- Name: COLUMN pevexoneration.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.ccocom IS 'Code commune INSEE - ';


--
-- Name: COLUMN pevexoneration.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.invar IS 'Numéro invariant - ';


--
-- Name: COLUMN pevexoneration.janbil; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.janbil IS 'Année d’immobilisation - servie pour ets. industriels';


--
-- Name: COLUMN pevexoneration.dnupev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.dnupev IS 'Numéro de pev - ';


--
-- Name: COLUMN pevexoneration.dnuexb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.dnuexb IS 'Numéro d’ordre de l’article - 001 à 015';


--
-- Name: COLUMN pevexoneration.ccolloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.ccolloc IS 'Code de collectivité locale accordant l’exonération - C D R TC tableau 2.3.9';


--
-- Name: COLUMN pevexoneration.pexb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.pexb IS 'Taux d’exonération accordée - 999V99';


--
-- Name: COLUMN pevexoneration.gnextl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.gnextl IS 'Nature d’exonération temporaire (et permanente pour ets. Industriels) - tableau des codes 2.3.10 et 2.3.8';


--
-- Name: COLUMN pevexoneration.jandeb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.jandeb IS 'année de début d’exonération - ';


--
-- Name: COLUMN pevexoneration.janimp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.janimp IS 'année de retour à imposition - ';


--
-- Name: COLUMN pevexoneration.vecdif; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.vecdif IS 'montant saisi de l’EC bénéficiant exo - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration.vecdifa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.vecdifa IS 'vecdif multiplié par coeff - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration.fcexb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.fcexb IS 'Fraction EC exonérée - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration.fcexba; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.fcexba IS 'fcexb multiplié par coeff - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration.rcexba; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.rcexba IS 'revenu cadastral exonéré - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration.dvldif2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.dvldif2 IS 'Montant de VL exonérée (valeur 70) - ';


--
-- Name: COLUMN pevexoneration.dvldif2a; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.dvldif2a IS 'Montant de VL exonérée (valeur de l’année) - ';


--
-- Name: COLUMN pevexoneration.fcexb2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.fcexb2 IS 'Fraction de VL exonérée (valeur 70) - ';


--
-- Name: COLUMN pevexoneration.fcexba2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.fcexba2 IS 'Fraction de VL exonérée (valeur de l’année) - ';


--
-- Name: COLUMN pevexoneration.rcexba2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.rcexba2 IS 'Revenu cadastral exonéré (valeur de l’année) - ';


--
-- Name: COLUMN pevexoneration.valplaf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration.valplaf IS 'Montant du planchonnement sur la base exonérée neutralisée';


--
-- Name: pevexoneration_imposable; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pevexoneration_imposable (
    pevexoneration_imposable text,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    janbil text,
    dnupev text,
    pev text,
    dnuexb text,
    ccolloc text,
    pexb numeric(5,2),
    gnextl text,
    jandeb text,
    janimp text,
    vecdif text,
    vecdifa text,
    fcexb text,
    fcexba text,
    rcexba text,
    dvldif2 integer,
    dvldif2a integer,
    fcexb2 integer,
    fcexba2 integer,
    rcexba2 integer,
    valplaf text,
    lot text
);


--
-- Name: TABLE pevexoneration_imposable; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pevexoneration_imposable IS 'Article exonération de pev imposable';


--
-- Name: COLUMN pevexoneration_imposable.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.ccodep IS 'Code département - ';


--
-- Name: COLUMN pevexoneration_imposable.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.ccodir IS 'Code direction - ';


--
-- Name: COLUMN pevexoneration_imposable.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.ccocom IS 'Code commune INSEE - ';


--
-- Name: COLUMN pevexoneration_imposable.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.invar IS 'Numéro invariant - ';


--
-- Name: COLUMN pevexoneration_imposable.janbil; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.janbil IS 'Année d’immobilisation - servie pour ets. industriels';


--
-- Name: COLUMN pevexoneration_imposable.dnupev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.dnupev IS 'Numéro de pev - ';


--
-- Name: COLUMN pevexoneration_imposable.dnuexb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.dnuexb IS 'Numéro d’ordre de l’article - 001 à 015';


--
-- Name: COLUMN pevexoneration_imposable.ccolloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.ccolloc IS 'Code de collectivité locale accordant l’exonération - C D R TC tableau 2.3.9';


--
-- Name: COLUMN pevexoneration_imposable.pexb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.pexb IS 'Taux d’exonération accordée - 999V99';


--
-- Name: COLUMN pevexoneration_imposable.gnextl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.gnextl IS 'Nature d’exonération temporaire (et permanente pour ets. Industriels) - tableau des codes 2.3.10 et 2.3.8';


--
-- Name: COLUMN pevexoneration_imposable.jandeb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.jandeb IS 'année de début d’exonération - ';


--
-- Name: COLUMN pevexoneration_imposable.janimp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.janimp IS 'année de retour à imposition - ';


--
-- Name: COLUMN pevexoneration_imposable.vecdif; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.vecdif IS 'montant saisi de l’EC bénéficiant exo - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposable.vecdifa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.vecdifa IS 'vecdif multiplié par coeff - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposable.fcexb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.fcexb IS 'Fraction EC exonérée - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposable.fcexba; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.fcexba IS 'fcexb multiplié par coeff - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposable.rcexba; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.rcexba IS 'revenu cadastral exonéré - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposable.dvldif2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.dvldif2 IS 'Montant de VL exonérée (valeur 70) - ';


--
-- Name: COLUMN pevexoneration_imposable.dvldif2a; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.dvldif2a IS 'Montant de VL exonérée (valeur de l’année) - ';


--
-- Name: COLUMN pevexoneration_imposable.fcexb2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.fcexb2 IS 'Fraction de VL exonérée (valeur 70) - ';


--
-- Name: COLUMN pevexoneration_imposable.fcexba2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.fcexba2 IS 'Fraction de VL exonérée (valeur de l’année) - ';


--
-- Name: COLUMN pevexoneration_imposable.rcexba2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.rcexba2 IS 'Revenu cadastral exonéré (valeur de l’année) - ';


--
-- Name: COLUMN pevexoneration_imposable.valplaf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposable.valplaf IS 'Montant du planchonnement sur la base exonérée neutralisée';


--
-- Name: pevexoneration_imposee; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pevexoneration_imposee (
    pevexoneration_imposee text,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    janbil text,
    dnupev text,
    pev text,
    dnuexb text,
    ccolloc text,
    pexb numeric(5,2),
    gnextl text,
    jandeb text,
    janimp text,
    vecdif text,
    vecdifa text,
    fcexb text,
    fcexba text,
    rcexba text,
    dvldif2 integer,
    dvldif2a integer,
    fcexb2 integer,
    fcexba2 integer,
    rcexba2 integer,
    valplaf text,
    lot text
);


--
-- Name: TABLE pevexoneration_imposee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pevexoneration_imposee IS 'Article exonération de pev imposée';


--
-- Name: COLUMN pevexoneration_imposee.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.ccodep IS 'Code département - ';


--
-- Name: COLUMN pevexoneration_imposee.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.ccodir IS 'Code direction - ';


--
-- Name: COLUMN pevexoneration_imposee.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.ccocom IS 'Code commune INSEE - ';


--
-- Name: COLUMN pevexoneration_imposee.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.invar IS 'Numéro invariant - ';


--
-- Name: COLUMN pevexoneration_imposee.janbil; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.janbil IS 'Année d’immobilisation - servie pour ets. industriels';


--
-- Name: COLUMN pevexoneration_imposee.dnupev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.dnupev IS 'Numéro de pev - ';


--
-- Name: COLUMN pevexoneration_imposee.dnuexb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.dnuexb IS 'Numéro d’ordre de l’article - 001 à 015';


--
-- Name: COLUMN pevexoneration_imposee.ccolloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.ccolloc IS 'Code de collectivité locale accordant l’exonération - C D R TC tableau 2.3.9';


--
-- Name: COLUMN pevexoneration_imposee.pexb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.pexb IS 'Taux d’exonération accordée - 999V99';


--
-- Name: COLUMN pevexoneration_imposee.gnextl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.gnextl IS 'Nature d’exonération temporaire (et permanente pour ets. Industriels) - tableau des codes 2.3.10 et 2.3.8';


--
-- Name: COLUMN pevexoneration_imposee.jandeb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.jandeb IS 'année de début d’exonération - ';


--
-- Name: COLUMN pevexoneration_imposee.janimp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.janimp IS 'année de retour à imposition - ';


--
-- Name: COLUMN pevexoneration_imposee.vecdif; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.vecdif IS 'montant saisi de l’EC bénéficiant exo - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposee.vecdifa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.vecdifa IS 'vecdif multiplié par coeff - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposee.fcexb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.fcexb IS 'Fraction EC exonérée - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposee.fcexba; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.fcexba IS 'fcexb multiplié par coeff - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposee.rcexba; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.rcexba IS 'revenu cadastral exonéré - INDISPONIBLE';


--
-- Name: COLUMN pevexoneration_imposee.dvldif2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.dvldif2 IS 'Montant de VL exonérée (valeur 70) - ';


--
-- Name: COLUMN pevexoneration_imposee.dvldif2a; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.dvldif2a IS 'Montant de VL exonérée (valeur de l’année) - ';


--
-- Name: COLUMN pevexoneration_imposee.fcexb2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.fcexb2 IS 'Fraction de VL exonérée (valeur 70) - ';


--
-- Name: COLUMN pevexoneration_imposee.fcexba2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.fcexba2 IS 'Fraction de VL exonérée (valeur de l’année) - ';


--
-- Name: COLUMN pevexoneration_imposee.rcexba2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.rcexba2 IS 'Revenu cadastral exonéré (valeur de l’année) - ';


--
-- Name: COLUMN pevexoneration_imposee.valplaf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevexoneration_imposee.valplaf IS 'Montant du planchonnement sur la base exonérée neutralisée';


--
-- Name: pevlissage; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pevlissage (
    pevlissage text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    dnupev text,
    pev text,
    mlbcom integer,
    mlbsyn integer,
    mlbcu integer,
    mlbdep integer,
    mlbts1 integer,
    mlbts2 integer,
    mlbtas integer,
    mlbgem integer,
    mlbtom integer,
    tbfpas integer,
    mlbtfc integer,
    lot text
);


--
-- Name: TABLE pevlissage; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pevlissage IS 'Descriptif des quotes-parts de lissage (locaux révisés). Bati enregistrement 52';


--
-- Name: COLUMN pevlissage.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.ccodep IS 'Code du département';


--
-- Name: COLUMN pevlissage.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.ccodir IS 'Code de direction';


--
-- Name: COLUMN pevlissage.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.ccocom IS 'Code commune INSEE';


--
-- Name: COLUMN pevlissage.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.invar IS 'Numéro invariant';


--
-- Name: COLUMN pevlissage.dnupev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.dnupev IS 'Numéro de PEV';


--
-- Name: COLUMN pevlissage.pev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.pev IS 'Code unique de PEV';


--
-- Name: COLUMN pevlissage.mlbcom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbcom IS 'Quote-part de lissage de la commune';


--
-- Name: COLUMN pevlissage.mlbsyn; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbsyn IS 'Quote-part de lissage du syndicat intercommunal';


--
-- Name: COLUMN pevlissage.mlbcu; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbcu IS 'Quote-part de lissage de l’intercommunalité';


--
-- Name: COLUMN pevlissage.mlbdep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbdep IS 'Quote-part de lissage du département';


--
-- Name: COLUMN pevlissage.mlbts1; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbts1 IS 'Quote-part de lissage de la TSE';


--
-- Name: COLUMN pevlissage.mlbts2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbts2 IS 'Quote-part de lissage de la TSE autre';


--
-- Name: COLUMN pevlissage.mlbtas; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbtas IS 'Quote-part de lissage de la TASA';


--
-- Name: COLUMN pevlissage.mlbgem; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbgem IS 'Quote-part de lissage GEMAPI';


--
-- Name: COLUMN pevlissage.mlbtom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbtom IS 'Quote-part de lissage TEOM';


--
-- Name: COLUMN pevlissage.tbfpas; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.tbfpas IS 'Pas de lissage du local';


--
-- Name: COLUMN pevlissage.mlbtfc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.mlbtfc IS 'Quote-parte de lissage sur les friches commerciales (TFC)';


--
-- Name: COLUMN pevlissage.lot; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevlissage.lot IS 'Code de lot d''import';


--
-- Name: pevprincipale; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pevprincipale (
    pevprincipale text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    dnupev text,
    pev text,
    dnudes text,
    dep1_cconad text,
    dep1_dsueic integer,
    dep1_dcimei numeric(2,1),
    dep2_cconad text,
    dep2_dsueic integer,
    dep2_dcimei numeric(2,1),
    dep3_cconad text,
    dep3_dsueic integer,
    dep3_dcimei numeric(2,1),
    dep4_cconad text,
    dep4_dsueic integer,
    dep4_dcimei numeric(2,1),
    geaulc text,
    gelelc text,
    gesclc text,
    ggazlc text,
    gasclc text,
    gchclc text,
    gvorlc text,
    gteglc text,
    dnbbai text,
    dnbdou text,
    dnblav text,
    dnbwc text,
    deqdha integer,
    dnbppr text,
    dnbsam text,
    dnbcha text,
    dnbcu8 text,
    dnbcu9 text,
    dnbsea text,
    dnbann text,
    dnbpdc text,
    dsupdc integer,
    dmatgm text,
    dmatto text,
    jannat text,
    detent text,
    dnbniv text,
    lot text
);


--
-- Name: TABLE pevprincipale; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pevprincipale IS 'Article descriptif partie principale habitation';


--
-- Name: COLUMN pevprincipale.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.ccodep IS 'Code département - ';


--
-- Name: COLUMN pevprincipale.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.ccodir IS 'Code direction - ';


--
-- Name: COLUMN pevprincipale.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.ccocom IS 'Code commune INSEE - ';


--
-- Name: COLUMN pevprincipale.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.invar IS 'Numéro invariant - ';


--
-- Name: COLUMN pevprincipale.dnupev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnupev IS 'Numéro de pev - ';


--
-- Name: COLUMN pevprincipale.dnudes; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnudes IS 'Numéro d’ordre de descriptif - bHb, bHA...';


--
-- Name: COLUMN pevprincipale.dep1_cconad; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep1_cconad IS 'Dépendance 1 - Nature de dépendance - Tableau 2.3.5';


--
-- Name: COLUMN pevprincipale.dep1_dsueic; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep1_dsueic IS 'Dépendance 1 - Surface réelle de l’élément incorporé - ';


--
-- Name: COLUMN pevprincipale.dep1_dcimei; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep1_dcimei IS 'Dépendance 1 - Coefficient de pondération - 9V9';


--
-- Name: COLUMN pevprincipale.dep2_cconad; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep2_cconad IS 'Dépendance 2 - Nature de dépendance - Tableau 2.3.5';


--
-- Name: COLUMN pevprincipale.dep2_dsueic; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep2_dsueic IS 'Dépendance 2 - Surface réelle de l’élément incorporé - ';


--
-- Name: COLUMN pevprincipale.dep2_dcimei; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep2_dcimei IS 'Dépendance 2 - Coefficient de pondération - 9V9';


--
-- Name: COLUMN pevprincipale.dep3_cconad; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep3_cconad IS 'Dépendance 3 - Nature de dépendance - Tableau 2.3.5';


--
-- Name: COLUMN pevprincipale.dep3_dsueic; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep3_dsueic IS 'Dépendance 3 - Surface réelle de l’élément incorporé - ';


--
-- Name: COLUMN pevprincipale.dep3_dcimei; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep3_dcimei IS 'Dépendance 3 - Coefficient de pondération - 9V9';


--
-- Name: COLUMN pevprincipale.dep4_cconad; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep4_cconad IS 'Dépendance 4 - Nature de dépendance - Tableau 2.3.5';


--
-- Name: COLUMN pevprincipale.dep4_dsueic; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep4_dsueic IS 'Dépendance 4 - Surface réelle de l’élément incorporé - ';


--
-- Name: COLUMN pevprincipale.dep4_dcimei; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dep4_dcimei IS 'Dépendance 4 - Coefficient de pondération - 9V9';


--
-- Name: COLUMN pevprincipale.geaulc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.geaulc IS 'Présence d’eau - O = oui, N = non';


--
-- Name: COLUMN pevprincipale.gelelc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.gelelc IS 'Présence d’électricité - O = oui, N = non';


--
-- Name: COLUMN pevprincipale.gesclc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.gesclc IS 'Présence d’escalier de service (appartement) - O = oui, N = non, blanc';


--
-- Name: COLUMN pevprincipale.ggazlc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.ggazlc IS 'Présence du gaz - O = oui, N = non';


--
-- Name: COLUMN pevprincipale.gasclc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.gasclc IS 'Présence d’ascenseur (appartement) - O = oui, N = non, blanc';


--
-- Name: COLUMN pevprincipale.gchclc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.gchclc IS 'Présence du chauffage central - O = oui, N = non';


--
-- Name: COLUMN pevprincipale.gvorlc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.gvorlc IS 'Présence de vide-ordures (appartement)  - O = oui, N = non, blanc';


--
-- Name: COLUMN pevprincipale.gteglc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.gteglc IS 'Présence du tout à l’égout - O = oui, N = non';


--
-- Name: COLUMN pevprincipale.dnbbai; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbbai IS 'Nombre de baignoires - ';


--
-- Name: COLUMN pevprincipale.dnbdou; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbdou IS 'Nombre de douches - ';


--
-- Name: COLUMN pevprincipale.dnblav; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnblav IS 'Nombre de lavabos - ';


--
-- Name: COLUMN pevprincipale.dnbwc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbwc IS 'Nombre de WC - ';


--
-- Name: COLUMN pevprincipale.deqdha; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.deqdha IS 'Equivalence superficielle des éléments de confort Répartition des pièces - ';


--
-- Name: COLUMN pevprincipale.dnbppr; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbppr IS 'Nombre de pièces principales - ';


--
-- Name: COLUMN pevprincipale.dnbsam; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbsam IS 'Nombre de salles à manger - ';


--
-- Name: COLUMN pevprincipale.dnbcha; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbcha IS 'Nombre de chambres - ';


--
-- Name: COLUMN pevprincipale.dnbcu8; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbcu8 IS 'Nombre de cuisines de moins de 9 m2 - ';


--
-- Name: COLUMN pevprincipale.dnbcu9; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbcu9 IS 'Nombre de cuisines d’au moins 9 m2 - ';


--
-- Name: COLUMN pevprincipale.dnbsea; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbsea IS 'Nombre de salles d’eau - ';


--
-- Name: COLUMN pevprincipale.dnbann; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbann IS 'Nombre de pièces annexes - ';


--
-- Name: COLUMN pevprincipale.dnbpdc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbpdc IS 'Nombre de pièces - ';


--
-- Name: COLUMN pevprincipale.dsupdc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dsupdc IS 'Superficie des pièces - ';


--
-- Name: COLUMN pevprincipale.dmatgm; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dmatgm IS 'Matériaux des gros murs - 0 indéterminé 1 pierre 2 meulière 3 béton 4 briques 5 aggloméré 6 bois 9 autres ';


--
-- Name: COLUMN pevprincipale.dmatto; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dmatto IS 'Matériaux des toitures - 0 indéterminé 1 tuiles 2 ardoises 3 zinc aluminium 4 béton';


--
-- Name: COLUMN pevprincipale.jannat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.jannat IS 'Année d’achèvement - ';


--
-- Name: COLUMN pevprincipale.detent; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.detent IS 'état d’entretien - 1 bon 2 assez bon 3 passable 4 médiocre 5 mauvais';


--
-- Name: COLUMN pevprincipale.dnbniv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprincipale.dnbniv IS 'Nombre de niveaux - ';


--
-- Name: pevprofessionnelle; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pevprofessionnelle (
    pevprofessionnelle text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    dnupev text,
    pev text,
    dnudes text,
    vsupot text,
    vsurz1 text,
    vsurz2 text,
    vsurz3 text,
    vsurzt integer,
    vsurb1 text,
    vsurb2 text,
    dsupot text,
    dsup1 text,
    dsup2 text,
    dsup3 text,
    dsupk1 text,
    dsupk2 text,
    lot text
);


--
-- Name: TABLE pevprofessionnelle; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pevprofessionnelle IS 'Article descriptif professionnel';


--
-- Name: COLUMN pevprofessionnelle.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.ccodep IS 'Code département - ';


--
-- Name: COLUMN pevprofessionnelle.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.ccodir IS 'Code direction - ';


--
-- Name: COLUMN pevprofessionnelle.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.ccocom IS 'Code commune INSEE - ';


--
-- Name: COLUMN pevprofessionnelle.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.invar IS 'Numéro invariant - ';


--
-- Name: COLUMN pevprofessionnelle.dnupev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.dnupev IS 'Numéro de pev - ';


--
-- Name: COLUMN pevprofessionnelle.dnudes; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.dnudes IS 'Numéro d’ordre de descriptif - P01';


--
-- Name: COLUMN pevprofessionnelle.vsupot; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.vsupot IS 'surface pondérée - INDISPONIBLE';


--
-- Name: COLUMN pevprofessionnelle.vsurz1; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.vsurz1 IS 'Surface réelle totale zone 1 - INDISPONIBLE';


--
-- Name: COLUMN pevprofessionnelle.vsurz2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.vsurz2 IS 'Surface réelle totale zone 2 - INDISPONIBLE';


--
-- Name: COLUMN pevprofessionnelle.vsurz3; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.vsurz3 IS 'Surface réelle totale zone 3 - INDISPONIBLE';


--
-- Name: COLUMN pevprofessionnelle.vsurzt; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.vsurzt IS 'Surface réelle totale - ';


--
-- Name: COLUMN pevprofessionnelle.vsurb1; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.vsurb1 IS 'surface réelle des bureaux 1 - INDISPONIBLE';


--
-- Name: COLUMN pevprofessionnelle.vsurb2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.vsurb2 IS 'surface réelle des bureaux 2 - INDISPONIBLE';


--
-- Name: COLUMN pevprofessionnelle.dsupot; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.dsupot IS 'Surface pondérée';


--
-- Name: COLUMN pevprofessionnelle.dsup1; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.dsup1 IS 'Surface des parties principales';


--
-- Name: COLUMN pevprofessionnelle.dsup2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.dsup2 IS 'Surface des parties secondaires couvertes';


--
-- Name: COLUMN pevprofessionnelle.dsup3; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.dsup3 IS 'Surface des parties secondaires non couvertes';


--
-- Name: COLUMN pevprofessionnelle.dsupk1; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.dsupk1 IS 'Surface des stationnements couverts';


--
-- Name: COLUMN pevprofessionnelle.dsupk2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevprofessionnelle.dsupk2 IS 'Surface des stationnements non couverts';


--
-- Name: pevtaxation; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.pevtaxation (
    pevtaxation text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    invar text,
    janbil text,
    dnupev text,
    pev text,
    co_vlbai integer,
    co_vlbaia integer,
    co_bipevla integer,
    de_vlbai integer,
    de_vlbaia integer,
    de_bipevla integer,
    re_vlbai integer,
    re_vlbaia integer,
    re_bipevla integer,
    gp_vlbai integer,
    gp_vlbaia integer,
    gp_bipevla integer,
    bateom integer,
    baomec integer,
    tse_vlbai integer,
    tse_vlbaia integer,
    tse_bipevla integer,
    mvltieomx integer,
    pvltieom bigint,
    lot text
);


--
-- Name: TABLE pevtaxation; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.pevtaxation IS 'Article taxation de pev';


--
-- Name: COLUMN pevtaxation.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.ccodep IS 'Code département - ';


--
-- Name: COLUMN pevtaxation.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.ccodir IS 'Code direction - ';


--
-- Name: COLUMN pevtaxation.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.ccocom IS 'Code commune INSEE - ';


--
-- Name: COLUMN pevtaxation.invar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.invar IS 'Numéro invariant - ';


--
-- Name: COLUMN pevtaxation.janbil; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.janbil IS 'Année d’immobilisation - High value pour ets. Industriels';


--
-- Name: COLUMN pevtaxation.dnupev; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.dnupev IS 'Numéro de pev - ';


--
-- Name: COLUMN pevtaxation.co_vlbai; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.co_vlbai IS 'Commune - Part de VL imposée (valeur70) - ';


--
-- Name: COLUMN pevtaxation.co_vlbaia; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.co_vlbaia IS 'Commune - Part de VL imposée (valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.co_bipevla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.co_bipevla IS 'Commune - Base d’imposition de la pev(valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.de_vlbai; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.de_vlbai IS 'Département - Part de VL imposée (valeur70) - ';


--
-- Name: COLUMN pevtaxation.de_vlbaia; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.de_vlbaia IS 'Département - Part de VL imposée (valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.de_bipevla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.de_bipevla IS 'Département - Base d’imposition de la pev(valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.re_vlbai; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.re_vlbai IS 'Région (avant 2012) - Part de VL imposée (valeur70) - ';


--
-- Name: COLUMN pevtaxation.re_vlbaia; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.re_vlbaia IS 'Région (avant 2012) - Part de VL imposée (valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.re_bipevla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.re_bipevla IS 'Région (avant 2012) - Base d’imposition de la pev(valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.gp_vlbai; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.gp_vlbai IS 'Groupement de commune - Part de VL imposée (valeur70) - ';


--
-- Name: COLUMN pevtaxation.gp_vlbaia; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.gp_vlbaia IS 'Groupement de commune - Part de VL imposée (valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.gp_bipevla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.gp_bipevla IS 'Groupement de commune - Base d’imposition de la pev(valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.bateom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.bateom IS 'BASE ORDURES MENAGERES - ';


--
-- Name: COLUMN pevtaxation.baomec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.baomec IS 'BASE ORDURES MENAGERES ECRETEE - ';


--
-- Name: COLUMN pevtaxation.tse_vlbai; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.tse_vlbai IS 'TSE (à partir de 2012) - Part de VL imposée (valeur70) - ';


--
-- Name: COLUMN pevtaxation.tse_vlbaia; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.tse_vlbaia IS 'TSE (à partir de 2012) - Part de VL imposée (valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.tse_bipevla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.tse_bipevla IS 'TSE (à partir de 2012) - Base d’imposition de la pev(valeur de l’année) - ';


--
-- Name: COLUMN pevtaxation.mvltieomx; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.mvltieomx IS 'Montant TIEOM (depuis 2013)';


--
-- Name: COLUMN pevtaxation.pvltieom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.pevtaxation.pvltieom IS 'Ratio VL n-1 de la PEV / VL n-1 collectivité - 9v999999999999999 (Depuis 2013 mais supprimée en 2014)';


--
-- Name: prop; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.prop (
    tmp text
);


--
-- Name: proprietaire; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.proprietaire (
    proprietaire text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    dnupro text,
    comptecommunal text,
    dnulp text,
    ccocif text,
    dnuper text,
    ccodro text,
    ccodem text,
    gdesip text,
    gtoper text,
    ccoqua text,
    gnexcf text,
    dtaucf text,
    dnatpr text,
    ccogrm text,
    dsglpm text,
    dforme text,
    ddenom text,
    gtyp3 text,
    dlign3 text,
    gtyp4 text,
    dlign4 text,
    gtyp5 text,
    dlign5 text,
    gtyp6 text,
    dlign6 text,
    ccopay text,
    ccodep1a2 text,
    ccodira text,
    ccocom_adr text,
    ccovoi text,
    ccoriv text,
    dnvoiri text,
    dindic text,
    ccopos text,
    dnirpp text,
    dqualp text,
    dnomlp text,
    dprnlp text,
    jdatnss text,
    dldnss text,
    epxnee text,
    dnomcp text,
    dprncp text,
    topcdi text,
    oriard text,
    fixard text,
    datadr text,
    topdec text,
    datdec text,
    dsiren text,
    ccmm text,
    topja text,
    datja text,
    anospi text,
    cblpmo text,
    gtodge text,
    gpctf text,
    gpctsb text,
    jmodge text,
    jandge text,
    jantfc text,
    jantbc text,
    dformjur text,
    dnomus text,
    dprnus text,
    lot text
);


--
-- Name: TABLE proprietaire; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.proprietaire IS 'Propriétaire';


--
-- Name: COLUMN proprietaire.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccodep IS 'code département - ';


--
-- Name: COLUMN proprietaire.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccodir IS 'code direction - ';


--
-- Name: COLUMN proprietaire.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccocom IS 'code commune INSEE - ';


--
-- Name: COLUMN proprietaire.dnupro; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dnupro IS 'compte communal - cgroup groupe de compte communal + * A B .. - ';


--
-- Name: COLUMN proprietaire.dnulp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dnulp IS 'numéro de libellé partiel - 01 à 06';


--
-- Name: COLUMN proprietaire.ccocif; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccocif IS 'code cdif - ';


--
-- Name: COLUMN proprietaire.dnuper; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dnuper IS 'numéro de personne dans le cdif - Il s’agit du numéro de personne ';


--
-- Name: COLUMN proprietaire.ccodro; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccodro IS 'code du droit réel ou particulier - Nouveau code en 2009 : C (fiduciaire)';


--
-- Name: COLUMN proprietaire.ccodem; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccodem IS 'code du démembrement/indivision - C S L I V';


--
-- Name: COLUMN proprietaire.gdesip; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gdesip IS 'indicateur du destinataire de l’avis d’imposition - 1 = oui, 0 = non';


--
-- Name: COLUMN proprietaire.gtoper; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gtoper IS 'indicateur de personne physique ou morale - 1 = physique, 2 = morale';


--
-- Name: COLUMN proprietaire.ccoqua; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccoqua IS 'Code qualité de personne physique - 1, 2 ou 3';


--
-- Name: COLUMN proprietaire.gnexcf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gnexcf IS 'code exo ecf - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.dtaucf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dtaucf IS 'taux exo ecf - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.dnatpr; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dnatpr IS 'Code nature de personne physique ou morale - Voir $ 2.2.7';


--
-- Name: COLUMN proprietaire.ccogrm; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccogrm IS 'Code groupe de personne morale - 0 à 9 - 0A à 9A';


--
-- Name: COLUMN proprietaire.dsglpm; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dsglpm IS 'sigle de personne morale - ';


--
-- Name: COLUMN proprietaire.dforme; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dforme IS 'forme juridique abrégée majic2 X Données Générales - ';


--
-- Name: COLUMN proprietaire.ddenom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ddenom IS 'Dénomination de personne physique ou morale - ';


--
-- Name: COLUMN proprietaire.gtyp3; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gtyp3 IS 'type de la 3eme ligne d’adresse - ';


--
-- Name: COLUMN proprietaire.dlign3; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dlign3 IS '3eme ligne d’adresse - ';


--
-- Name: COLUMN proprietaire.gtyp4; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gtyp4 IS 'Type de la 4eme ligne d’adresse - ';


--
-- Name: COLUMN proprietaire.dlign4; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dlign4 IS '4eme ligne d’adresse - ';


--
-- Name: COLUMN proprietaire.gtyp5; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gtyp5 IS 'type de la 5eme ligne d’adresse - ';


--
-- Name: COLUMN proprietaire.dlign5; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dlign5 IS '5eme ligne d’adresse - ';


--
-- Name: COLUMN proprietaire.gtyp6; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gtyp6 IS 'type de la 6eme ligne d’adresse - ';


--
-- Name: COLUMN proprietaire.dlign6; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dlign6 IS '6eme ligne d’adresse X Codification de l’adresse - ';


--
-- Name: COLUMN proprietaire.ccopay; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccopay IS 'code de pays étranger et TOM - non servi pour France métropole et Dom';


--
-- Name: COLUMN proprietaire.ccodep1a2; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccodep1a2 IS 'Code département de l’adresse - ';


--
-- Name: COLUMN proprietaire.ccodira; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccodira IS 'Code direction de l’adresse - ';


--
-- Name: COLUMN proprietaire.ccocom_adr; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccocom_adr IS 'Code commune de l’adresse - ';


--
-- Name: COLUMN proprietaire.ccovoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccovoi IS 'Code majic2 de la voie - ';


--
-- Name: COLUMN proprietaire.ccoriv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccoriv IS 'Code rivoli de la voie - ';


--
-- Name: COLUMN proprietaire.dnvoiri; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dnvoiri IS 'numéro de voirie - ';


--
-- Name: COLUMN proprietaire.dindic; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dindic IS 'indice de répétition de voirie - ';


--
-- Name: COLUMN proprietaire.ccopos; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccopos IS 'Code postal X Dénomination formatée de personne physique - ';


--
-- Name: COLUMN proprietaire.dnirpp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dnirpp IS 'zone à blanc - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.dqualp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dqualp IS 'Qualité abrégée - M, MME ou MLE';


--
-- Name: COLUMN proprietaire.dnomlp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dnomlp IS 'Nom d’usage - ';


--
-- Name: COLUMN proprietaire.dprnlp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dprnlp IS 'Prénoms associés au nom d’usage - ';


--
-- Name: COLUMN proprietaire.jdatnss; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.jdatnss IS 'date de naissance - sous la forme jj/mm/aaaa';


--
-- Name: COLUMN proprietaire.dldnss; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dldnss IS 'lieu de naissance - ';


--
-- Name: COLUMN proprietaire.epxnee; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.epxnee IS 'mention du complément - EPX ou NEE si complément';


--
-- Name: COLUMN proprietaire.dnomcp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dnomcp IS 'Nom complément - ';


--
-- Name: COLUMN proprietaire.dprncp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dprncp IS 'Prénoms associés au complément - ';


--
-- Name: COLUMN proprietaire.topcdi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.topcdi IS 'top transalp - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.oriard; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.oriard IS 'origine adresse - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.fixard; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.fixard IS 'pérennité adresse - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.datadr; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.datadr IS 'date adresse - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.topdec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.topdec IS 'origine décès - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.datdec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.datdec IS 'date de décès - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.dsiren; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dsiren IS 'numéro siren - ';


--
-- Name: COLUMN proprietaire.ccmm; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.ccmm IS 'création compte cadastral - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.topja; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.topja IS 'indic jeune agriculteur - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.datja; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.datja IS 'date jeune agriculteur - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.anospi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.anospi IS 'ano transalp - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.cblpmo; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.cblpmo IS 'code blocage caractère personne morale - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.gtodge; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gtodge IS 'top appartenance à la DGE - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.gpctf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gpctf IS 'top paiement centralisé à la taxe foncière - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.gpctsb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.gpctsb IS 'top paiement centralisé à la TSBCS - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.jmodge; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.jmodge IS 'mois d’entrée à la DGE - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.jandge; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.jandge IS 'année d’entrée à la DGE - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.jantfc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.jantfc IS 'année d’entrée paiement TF - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.jantbc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.jantbc IS 'année d’entrée paiement TSBCS - INDISPONIBLE';


--
-- Name: COLUMN proprietaire.dformjur; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dformjur IS 'Forme juridique (Depuis 2013)';


--
-- Name: COLUMN proprietaire.dnomus; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dnomus IS 'Nom d''usage (Depuis 2015)';


--
-- Name: COLUMN proprietaire.dprnus; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.proprietaire.dprnus IS 'Prénom d''usage (Depuis 2015)';


--
-- Name: suf; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.suf (
    suf text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    ccopre text,
    ccosec text,
    dnupla text,
    parcelle text,
    ccosub text,
    dcntsf integer,
    dnupro text,
    comptecommunal text,
    gnexps text,
    drcsub numeric(10,2),
    drcsuba numeric(10,2),
    ccostn text,
    cgrnum text,
    dsgrpf text,
    dclssf text,
    cnatsp text,
    drgpos text,
    ccoprel text,
    ccosecl text,
    dnuplal text,
    dnupdl text,
    pdl text,
    dnulot text,
    rclsi text,
    gnidom text,
    topja text,
    datja text,
    postel text,
    ccortar integer,
    lot text
);


--
-- Name: TABLE suf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.suf IS 'Article descriptif de suf';


--
-- Name: COLUMN suf.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccodep IS 'Code département - ';


--
-- Name: COLUMN suf.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccodir IS 'Code direction - ';


--
-- Name: COLUMN suf.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccocom IS 'Code commune INSEE ou DGI d’arrondissement - ';


--
-- Name: COLUMN suf.ccopre; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccopre IS 'Préfixe de section ou quartier servi pour les communes associées - ';


--
-- Name: COLUMN suf.ccosec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccosec IS 'Section cadastrale - ';


--
-- Name: COLUMN suf.dnupla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.dnupla IS 'Numéro de plan - ';


--
-- Name: COLUMN suf.ccosub; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccosub IS 'Lettres indicatives de suf - ';


--
-- Name: COLUMN suf.dcntsf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.dcntsf IS 'Contenance de la suf - en centiares';


--
-- Name: COLUMN suf.dnupro; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.dnupro IS 'Compte communal du propriétaire de la suf - ';


--
-- Name: COLUMN suf.gnexps; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.gnexps IS 'Code exonération permanente - ep cd cr dr ni rt';


--
-- Name: COLUMN suf.drcsub; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.drcsub IS 'Revenu cadastral en valeur actualise référence 1980 - Exprimé Euros';


--
-- Name: COLUMN suf.drcsuba; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.drcsuba IS 'Revenu cadastral revalorisé en valeur du 01-01 de l’année - Exprimé en Euros';


--
-- Name: COLUMN suf.ccostn; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccostn IS 'Série-tarif - A à Z, sauf I,O,Q';


--
-- Name: COLUMN suf.cgrnum; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.cgrnum IS 'Groupe de nature de culture - 01 à 13';


--
-- Name: COLUMN suf.dsgrpf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.dsgrpf IS 'Sous-groupe alphabétique - ';


--
-- Name: COLUMN suf.dclssf; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.dclssf IS 'Classe dans le groupe et la série-tarif - ';


--
-- Name: COLUMN suf.cnatsp; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.cnatsp IS 'code nature de culture spéciale - ';


--
-- Name: COLUMN suf.drgpos; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.drgpos IS 'Top terrain constructible Liaison avec un lot de pdl - « 0 » ou « 9 » ';


--
-- Name: COLUMN suf.ccoprel; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccoprel IS 'Préfixe de la parcelle identifiant le lot - ';


--
-- Name: COLUMN suf.ccosecl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccosecl IS 'Section de la parcelle identifiant le lot - ';


--
-- Name: COLUMN suf.dnuplal; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.dnuplal IS 'N° de plan de la parcelle de référence - ';


--
-- Name: COLUMN suf.dnupdl; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.dnupdl IS 'Numéro d ordre de la pdl - en général, 001';


--
-- Name: COLUMN suf.dnulot; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.dnulot IS 'Numéro du lot - Le lot de BND se présente sous la forme 00Axxxx - ';


--
-- Name: COLUMN suf.rclsi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.rclsi IS 'Données classement révisé - INDISPONIBLE';


--
-- Name: COLUMN suf.gnidom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.gnidom IS 'Indicateur de suf non imposable - * ou blanc';


--
-- Name: COLUMN suf.topja; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.topja IS 'Indicateur jeune agriculteur - J ou blanc';


--
-- Name: COLUMN suf.datja; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.datja IS 'Date d’installation jeune agriculteur - peut être servie si topja = J';


--
-- Name: COLUMN suf.postel; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.postel IS 'Indicateur de bien appartenant à la Poste - X ou blanc';


--
-- Name: COLUMN suf.ccortar; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suf.ccortar IS 'Code commune origine du tarif';


--
-- Name: sufexoneration; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.sufexoneration (
    sufexoneration text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    ccopre text,
    ccosec text,
    dnupla text,
    ccosub text,
    suf text,
    rnuexn text,
    vecexn numeric(10,2),
    ccolloc text,
    pexn integer,
    gnexts text,
    jandeb text,
    jfinex text,
    fcexn text,
    fcexna text,
    rcexna text,
    rcexnba numeric(10,2),
    mpexnba text,
    lot text
);


--
-- Name: TABLE sufexoneration; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.sufexoneration IS 'Article exonération de suf';


--
-- Name: COLUMN sufexoneration.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.ccodep IS 'Code département - ';


--
-- Name: COLUMN sufexoneration.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.ccodir IS 'Code direction - ';


--
-- Name: COLUMN sufexoneration.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.ccocom IS 'Code commune INSEE ou DGI d’arrondissement - ';


--
-- Name: COLUMN sufexoneration.ccopre; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.ccopre IS 'Préfixe de section ou quartier servi pour les communes associées - ';


--
-- Name: COLUMN sufexoneration.ccosec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.ccosec IS 'Section cadastrale - ';


--
-- Name: COLUMN sufexoneration.dnupla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.dnupla IS 'Numéro de plan - ';


--
-- Name: COLUMN sufexoneration.ccosub; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.ccosub IS 'Lettres indicatives de suf - ';


--
-- Name: COLUMN sufexoneration.rnuexn; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.rnuexn IS 'Numéro d ordre d’exonération temporaire - 01 à 04';


--
-- Name: COLUMN sufexoneration.vecexn; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.vecexn IS 'Montant de VL sur lequel porte l’exonération - en Euros';


--
-- Name: COLUMN sufexoneration.ccolloc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.ccolloc IS 'Collectivité accordant l’exonération - TC, C, R d OU GC';


--
-- Name: COLUMN sufexoneration.pexn; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.pexn IS 'Pourcentage d’exonération - 100';


--
-- Name: COLUMN sufexoneration.gnexts; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.gnexts IS 'Code d’exonération temporaire - TA TR NO PB PP PR PF ER TU OL HP HR ou NA';


--
-- Name: COLUMN sufexoneration.jandeb; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.jandeb IS 'Année de début d’exonération - à blanc';


--
-- Name: COLUMN sufexoneration.jfinex; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.jfinex IS 'Année de retour à imposition - à blanc';


--
-- Name: COLUMN sufexoneration.fcexn; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.fcexn IS 'Fraction de vecsuf exonérée - INDISPONIBLE';


--
-- Name: COLUMN sufexoneration.fcexna; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.fcexna IS 'fcexn en année N - INDISPONIBLE';


--
-- Name: COLUMN sufexoneration.rcexna; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.rcexna IS 'revenu (4/5 fcexna) correspondant - INDISPONIBLE';


--
-- Name: COLUMN sufexoneration.rcexnba; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.rcexnba IS 'Revenu cadastral exonéré, en valeur de l’année - Exprimé en Euros';


--
-- Name: COLUMN sufexoneration.mpexnba; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.sufexoneration.mpexnba IS 'Fraction majo TC exonérée, en valeur de l’année - INDISPONIBLE';


--
-- Name: suftaxation; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.suftaxation (
    suftaxation text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    ccopre text,
    ccosec text,
    dnupla text,
    ccosub text,
    suf text,
    c1majposa numeric(10,2),
    c1bisufad numeric(10,2),
    c2majposa numeric(10,2),
    c2bisufad numeric(10,2),
    c3majposa numeric(10,2),
    c3bisufad numeric(10,2),
    c4majposa numeric(10,2),
    c4bisufad numeric(10,2),
    cntmajtc integer,
    majposca numeric(10,2),
    lot text
);


--
-- Name: TABLE suftaxation; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.suftaxation IS 'Article taxation de suf';


--
-- Name: COLUMN suftaxation.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.ccodep IS 'Code département - ';


--
-- Name: COLUMN suftaxation.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.ccodir IS 'Code direction - ';


--
-- Name: COLUMN suftaxation.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.ccocom IS 'Code commune INSEE ou DGI d’arrondissement - ';


--
-- Name: COLUMN suftaxation.ccopre; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.ccopre IS 'Préfixe de section ou quartier servi pour les communes associées - ';


--
-- Name: COLUMN suftaxation.ccosec; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.ccosec IS 'Section cadastrale - ';


--
-- Name: COLUMN suftaxation.dnupla; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.dnupla IS 'Numéro de plan - ';


--
-- Name: COLUMN suftaxation.ccosub; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.ccosub IS 'Lettres indicatives de suf - ';


--
-- Name: COLUMN suftaxation.c1majposa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.c1majposa IS 'c1 - Montant de la majoration terrain constructible. Servi pour la part communale. Toujours à zéro pour autres collectivités. - exprimé en Euros';


--
-- Name: COLUMN suftaxation.c1bisufad; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.c1bisufad IS 'c1 - Base d’imposition de la suf en valeur de l’année - exprimé en Euros';


--
-- Name: COLUMN suftaxation.c2majposa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.c2majposa IS 'c2 - Montant de la majoration terrain constructible. Servi pour la part communale. Toujours à zéro pour autres collectivités. - exprimé en Euros';


--
-- Name: COLUMN suftaxation.c2bisufad; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.c2bisufad IS 'c2 - Base d’imposition de la suf en valeur de l’année - exprimé en Euros';


--
-- Name: COLUMN suftaxation.c3majposa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.c3majposa IS 'c3 - Montant de la majoration terrain constructible. Servi pour la part communale. Toujours à zéro pour autres collectivités. - exprimé en Euros';


--
-- Name: COLUMN suftaxation.c3bisufad; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.c3bisufad IS 'c3 - Base d’imposition de la suf en valeur de l’année - exprimé en Euros';


--
-- Name: COLUMN suftaxation.c4majposa; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.c4majposa IS 'c4 - Montant de la majoration terrain constructible. Servi pour la part communale. Toujours à zéro pour autres collectivités. - exprimé en Euros';


--
-- Name: COLUMN suftaxation.c4bisufad; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.c4bisufad IS 'c4 - Base d’imposition de la suf en valeur de l’année - exprimé en Euros';


--
-- Name: COLUMN suftaxation.cntmajtc; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.cntmajtc IS 'Nouvelle contenance suf pour calcul majorationn TC';


--
-- Name: COLUMN suftaxation.majposca; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.suftaxation.majposca IS 'Majoration TC pour les chambres d’agriculture, exprimé en centimes d’Euros (à partir de 2014)';


--
-- Name: top48a; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.top48a (
    top48a text NOT NULL,
    top48a_lib text
);


--
-- Name: typcom; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.typcom (
    typcom text NOT NULL,
    typcom_lib text
);


--
-- Name: type_filiation; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.type_filiation (
    type_filiation text NOT NULL,
    type_filiation_lib text
);


--
-- Name: typvoi; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.typvoi (
    typvoi text NOT NULL,
    typvoi_lib text
);


--
-- Name: v_geo_parcelle; Type: VIEW; Schema: cadastre_mtp; Owner: -
--

CREATE VIEW cadastre_mtp.v_geo_parcelle AS
 SELECT g.geo_parcelle,
    g.annee,
    g.object_rid,
    g.idu,
    g.geo_section,
    g.geo_subdsect,
    g.supf,
    g.geo_indp,
    g.coar,
    g.tex,
    g.tex2,
    g.codm,
    g.creat_date,
    g.update_dat,
    g.inspireid,
    g.lot,
    g.ogc_fid,
    g.geom,
    p.comptecommunal,
    p.voie
   FROM (cadastre_mtp.geo_parcelle g
     LEFT JOIN cadastre_mtp.parcelle p ON ((g.geo_parcelle = p.parcelle)));


--
-- Name: voie; Type: TABLE; Schema: cadastre_mtp; Owner: -
--

CREATE TABLE cadastre_mtp.voie (
    voie text NOT NULL,
    annee text,
    ccodep text,
    ccodir text,
    ccocom text,
    commune text,
    natvoiriv text,
    ccoriv text,
    clerivili text,
    natvoi text,
    libvoi text,
    typcom text,
    ruract text,
    carvoi text,
    indpop text,
    poprel text,
    poppart integer,
    popfict integer,
    annul text,
    dteannul text,
    dtecreart text,
    codvoi text,
    typvoi text,
    indldnbat text,
    motclas text,
    lot text
);


--
-- Name: TABLE voie; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON TABLE cadastre_mtp.voie IS 'Voie (Fantoir)';


--
-- Name: COLUMN voie.ccodep; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.ccodep IS 'Code département - Code département INSEE';


--
-- Name: COLUMN voie.ccodir; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.ccodir IS 'Code direction - Code direction dge';


--
-- Name: COLUMN voie.ccocom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.ccocom IS 'Code commune - code commune définie par Majic2';


--
-- Name: COLUMN voie.natvoiriv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.natvoiriv IS 'Nature de voie rivoli - ';


--
-- Name: COLUMN voie.ccoriv; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.ccoriv IS 'Code voie Rivoli - identifiant de voie dans la commune';


--
-- Name: COLUMN voie.clerivili; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.clerivili IS 'Clé RIVOLI - zone alphabétique fournie par MAJIC2';


--
-- Name: COLUMN voie.natvoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.natvoi IS 'nature de voie - ';


--
-- Name: COLUMN voie.libvoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.libvoi IS 'libellé de voie - ';


--
-- Name: COLUMN voie.typcom; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.typcom IS 'Type de commune actuel (R ou N) - N - commune rurale, R - commune rencencée';


--
-- Name: COLUMN voie.ruract; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.ruract IS 'RUR actuel - indique si la commune est pseudo-recensée ou non (3-commune pseudo-recensée, blanc si rien)';


--
-- Name: COLUMN voie.carvoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.carvoi IS 'caractère de voie - zone indiquant si la voie est privée (1) ou publique (0)';


--
-- Name: COLUMN voie.indpop; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.indpop IS 'indicateur de population - Précise la dernière situation connue de la commune au regard de la limite de 3000 habitants (= blanc si < 3000 h sinon = *).';


--
-- Name: COLUMN voie.poprel; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.poprel IS 'population réelle - dénombre la population recencée lors du dernier recensement';


--
-- Name: COLUMN voie.poppart; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.poppart IS 'population à part - dénombre la population comptée à part dans la commune';


--
-- Name: COLUMN voie.popfict; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.popfict IS 'population fictive - population fictive de la commune';


--
-- Name: COLUMN voie.annul; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.annul IS 'Annulation Cet article indique que plus aucune entité topo n’est représentée par ce code. - O - voie annulée sans transfert, Q - voie annulée avec transfert, Q - commune annulée avec transfert.';


--
-- Name: COLUMN voie.dteannul; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.dteannul IS 'date d''annulation - ';


--
-- Name: COLUMN voie.dtecreart; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.dtecreart IS 'Date de création de l''article - Date à laquelle l''article a été créé par création MAJIC2.';


--
-- Name: COLUMN voie.codvoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.codvoi IS 'Code identifiant la voie dans MAJIC2. - Permet de faire le lien entre le code voie RIVOLI et le code voie MAJIC2.';


--
-- Name: COLUMN voie.typvoi; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.typvoi IS 'Type de voie - Indicateur de la classe de la voie. - 1 - voie, 2 - ensemble immobilier, 3 - lieu-dit, 4 -  pseudo-voie, 5 - voie provisoire.';


--
-- Name: COLUMN voie.indldnbat; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.indldnbat IS 'Indicateur lieu-dit non bâti - Zone servie uniquement pour les lieux-dits.Permet d’indiquer si le lieu-dit comporte ou non un bâtiment dans MAJIC.1 pour lieu-dit non bâti, 0 sinon.';


--
-- Name: COLUMN voie.motclas; Type: COMMENT; Schema: cadastre_mtp; Owner: -
--

COMMENT ON COLUMN cadastre_mtp.voie.motclas IS 'Mot classant - Dernier mot entièrement alphabétique du libellé de voie - Permet de restituer l''ordre alphabétique.';


--
-- Name: edigeo_rel edigeo_rel; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.edigeo_rel ALTER COLUMN edigeo_rel SET DEFAULT nextval('cadastre_mtp.edigeo_rel_edigeo_rel_seq'::regclass);


--
-- Name: geo_batiment ogc_fid; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_batiment ALTER COLUMN ogc_fid SET DEFAULT nextval('cadastre_mtp.geo_batiment_ogc_fid_seq'::regclass);


--
-- Name: geo_batiment_parcelle geo_batiment_parcelle; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_batiment_parcelle ALTER COLUMN geo_batiment_parcelle SET DEFAULT nextval('cadastre_mtp.geo_batiment_parcelle_geo_batiment_parcelle_seq'::regclass);


--
-- Name: geo_borne geo_borne; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_borne ALTER COLUMN geo_borne SET DEFAULT nextval('cadastre_mtp.geo_borne_geo_borne_seq'::regclass);


--
-- Name: geo_borne_parcelle geo_borne_parcelle; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_borne_parcelle ALTER COLUMN geo_borne_parcelle SET DEFAULT nextval('cadastre_mtp.geo_borne_parcelle_geo_borne_parcelle_seq'::regclass);


--
-- Name: geo_commune ogc_fid; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_commune ALTER COLUMN ogc_fid SET DEFAULT nextval('cadastre_mtp.geo_commune_ogc_fid_seq'::regclass);


--
-- Name: geo_croix geo_croix; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_croix ALTER COLUMN geo_croix SET DEFAULT nextval('cadastre_mtp.geo_croix_geo_croix_seq'::regclass);


--
-- Name: geo_croix_parcelle geo_croix_parcelle; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_croix_parcelle ALTER COLUMN geo_croix_parcelle SET DEFAULT nextval('cadastre_mtp.geo_croix_parcelle_geo_croix_parcelle_seq'::regclass);


--
-- Name: geo_label ogc_fid; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_label ALTER COLUMN ogc_fid SET DEFAULT nextval('cadastre_mtp.geo_label_ogc_fid_seq'::regclass);


--
-- Name: geo_lieudit geo_lieudit; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_lieudit ALTER COLUMN geo_lieudit SET DEFAULT nextval('cadastre_mtp.geo_lieudit_geo_lieudit_seq'::regclass);


--
-- Name: geo_numvoie geo_numvoie; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_numvoie ALTER COLUMN geo_numvoie SET DEFAULT nextval('cadastre_mtp.geo_numvoie_geo_numvoie_seq'::regclass);


--
-- Name: geo_numvoie_parcelle geo_numvoie_parcelle; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_numvoie_parcelle ALTER COLUMN geo_numvoie_parcelle SET DEFAULT nextval('cadastre_mtp.geo_numvoie_parcelle_geo_numvoie_parcelle_seq'::regclass);


--
-- Name: geo_parcelle ogc_fid; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_parcelle ALTER COLUMN ogc_fid SET DEFAULT nextval('cadastre_mtp.geo_parcelle_ogc_fid_seq'::regclass);


--
-- Name: geo_ptcanv geo_ptcanv; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_ptcanv ALTER COLUMN geo_ptcanv SET DEFAULT nextval('cadastre_mtp.geo_ptcanv_geo_ptcanv_seq'::regclass);


--
-- Name: geo_section ogc_fid; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_section ALTER COLUMN ogc_fid SET DEFAULT nextval('cadastre_mtp.geo_section_ogc_fid_seq'::regclass);


--
-- Name: geo_subdfisc geo_subdfisc; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_subdfisc ALTER COLUMN geo_subdfisc SET DEFAULT nextval('cadastre_mtp.geo_subdfisc_geo_subdfisc_seq'::regclass);


--
-- Name: geo_subdfisc_parcelle geo_subdfisc_parcelle; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_subdfisc_parcelle ALTER COLUMN geo_subdfisc_parcelle SET DEFAULT nextval('cadastre_mtp.geo_subdfisc_parcelle_geo_subdfisc_parcelle_seq'::regclass);


--
-- Name: geo_subdsect ogc_fid; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_subdsect ALTER COLUMN ogc_fid SET DEFAULT nextval('cadastre_mtp.geo_subdsect_ogc_fid_seq'::regclass);


--
-- Name: geo_symblim geo_symblim; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_symblim ALTER COLUMN geo_symblim SET DEFAULT nextval('cadastre_mtp.geo_symblim_geo_symblim_seq'::regclass);


--
-- Name: geo_symblim_parcelle geo_symblim_parcelle; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_symblim_parcelle ALTER COLUMN geo_symblim_parcelle SET DEFAULT nextval('cadastre_mtp.geo_symblim_parcelle_geo_symblim_parcelle_seq'::regclass);


--
-- Name: geo_tline geo_tline; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tline ALTER COLUMN geo_tline SET DEFAULT nextval('cadastre_mtp.geo_tline_geo_tline_seq'::regclass);


--
-- Name: geo_tline_commune geo_tline_commune; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tline_commune ALTER COLUMN geo_tline_commune SET DEFAULT nextval('cadastre_mtp.geo_tline_commune_geo_tline_commune_seq'::regclass);


--
-- Name: geo_tpoint geo_tpoint; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tpoint ALTER COLUMN geo_tpoint SET DEFAULT nextval('cadastre_mtp.geo_tpoint_geo_tpoint_seq'::regclass);


--
-- Name: geo_tpoint_commune geo_tpoint_commune; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tpoint_commune ALTER COLUMN geo_tpoint_commune SET DEFAULT nextval('cadastre_mtp.geo_tpoint_commune_geo_tpoint_commune_seq'::regclass);


--
-- Name: geo_tronfluv geo_tronfluv; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tronfluv ALTER COLUMN geo_tronfluv SET DEFAULT nextval('cadastre_mtp.geo_tronfluv_geo_tronfluv_seq'::regclass);


--
-- Name: geo_tronroute geo_tronroute; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tronroute ALTER COLUMN geo_tronroute SET DEFAULT nextval('cadastre_mtp.geo_tronroute_geo_tronroute_seq'::regclass);


--
-- Name: geo_tsurf geo_tsurf; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tsurf ALTER COLUMN geo_tsurf SET DEFAULT nextval('cadastre_mtp.geo_tsurf_geo_tsurf_seq'::regclass);


--
-- Name: geo_tsurf_commune geo_tsurf_commune; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tsurf_commune ALTER COLUMN geo_tsurf_commune SET DEFAULT nextval('cadastre_mtp.geo_tsurf_commune_geo_tsurf_commune_seq'::regclass);


--
-- Name: geo_unite_fonciere id; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_unite_fonciere ALTER COLUMN id SET DEFAULT nextval('cadastre_mtp.geo_unite_fonciere_id_seq'::regclass);


--
-- Name: geo_voiep geo_voiep; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_voiep ALTER COLUMN geo_voiep SET DEFAULT nextval('cadastre_mtp.geo_voiep_geo_voiep_seq'::regclass);


--
-- Name: geo_zoncommuni geo_zoncommuni; Type: DEFAULT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_zoncommuni ALTER COLUMN geo_zoncommuni SET DEFAULT nextval('cadastre_mtp.geo_zoncommuni_geo_zoncommuni_seq'::regclass);


--
-- Name: annul annul_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.annul
    ADD CONSTRAINT annul_pkey PRIMARY KEY (annul);


--
-- Name: carvoi carvoi_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.carvoi
    ADD CONSTRAINT carvoi_pkey PRIMARY KEY (carvoi);


--
-- Name: cbtabt cbtabt_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.cbtabt
    ADD CONSTRAINT cbtabt_pkey PRIMARY KEY (cbtabt);


--
-- Name: ccoaff ccoaff_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccoaff
    ADD CONSTRAINT ccoaff_pkey PRIMARY KEY (ccoaff);


--
-- Name: ccocac ccocac_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccocac
    ADD CONSTRAINT ccocac_pkey PRIMARY KEY (ccocac);


--
-- Name: ccodem ccodem_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccodem
    ADD CONSTRAINT ccodem_pkey PRIMARY KEY (ccodem);


--
-- Name: ccodro ccodro_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccodro
    ADD CONSTRAINT ccodro_pkey PRIMARY KEY (ccodro);


--
-- Name: ccoeva ccoeva_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccoeva
    ADD CONSTRAINT ccoeva_pkey PRIMARY KEY (ccoeva);


--
-- Name: ccogrm ccogrm_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccogrm
    ADD CONSTRAINT ccogrm_pkey PRIMARY KEY (ccogrm);


--
-- Name: ccolloc ccolloc_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccolloc
    ADD CONSTRAINT ccolloc_pkey PRIMARY KEY (ccolloc);


--
-- Name: cconac cconac_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.cconac
    ADD CONSTRAINT cconac_pkey PRIMARY KEY (cconac);


--
-- Name: cconad cconad_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.cconad
    ADD CONSTRAINT cconad_pkey PRIMARY KEY (cconad);


--
-- Name: cconlc cconlc_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.cconlc
    ADD CONSTRAINT cconlc_pkey PRIMARY KEY (cconlc);


--
-- Name: cconlo cconlo_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.cconlo
    ADD CONSTRAINT cconlo_pkey PRIMARY KEY (cconlo);


--
-- Name: ccoplc ccoplc_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccoplc
    ADD CONSTRAINT ccoplc_pkey PRIMARY KEY (ccoplc);


--
-- Name: ccoqua ccoqua_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccoqua
    ADD CONSTRAINT ccoqua_pkey PRIMARY KEY (ccoqua);


--
-- Name: ccthp ccthp_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ccthp
    ADD CONSTRAINT ccthp_pkey PRIMARY KEY (ccthp);


--
-- Name: cgrnum cgrnum_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.cgrnum
    ADD CONSTRAINT cgrnum_pkey PRIMARY KEY (cgrnum);


--
-- Name: cnatsp cnatsp_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.cnatsp
    ADD CONSTRAINT cnatsp_pkey PRIMARY KEY (cnatsp);


--
-- Name: commune_majic commune_majic_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.commune_majic
    ADD CONSTRAINT commune_majic_pk PRIMARY KEY (commune);


--
-- Name: commune commune_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.commune
    ADD CONSTRAINT commune_pk PRIMARY KEY (commune);


--
-- Name: comptecommunal comptecommunal_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.comptecommunal
    ADD CONSTRAINT comptecommunal_pk PRIMARY KEY (comptecommunal);


--
-- Name: ctpdl ctpdl_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.ctpdl
    ADD CONSTRAINT ctpdl_pkey PRIMARY KEY (ctpdl);


--
-- Name: detent detent_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.detent
    ADD CONSTRAINT detent_pkey PRIMARY KEY (detent);


--
-- Name: dformjur dformjur_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.dformjur
    ADD CONSTRAINT dformjur_pkey PRIMARY KEY (dformjur);


--
-- Name: dmatgm dmatgm_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.dmatgm
    ADD CONSTRAINT dmatgm_pkey PRIMARY KEY (dmatgm);


--
-- Name: dmatto dmatto_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.dmatto
    ADD CONSTRAINT dmatto_pkey PRIMARY KEY (dmatto);


--
-- Name: dnatcg dnatcg_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.dnatcg
    ADD CONSTRAINT dnatcg_pkey PRIMARY KEY (dnatcg);


--
-- Name: dnatlc dnatlc_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.dnatlc
    ADD CONSTRAINT dnatlc_pkey PRIMARY KEY (dnatlc);


--
-- Name: dnatpr dnatpr_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.dnatpr
    ADD CONSTRAINT dnatpr_pkey PRIMARY KEY (dnatpr);


--
-- Name: drgpos drgpos_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.drgpos
    ADD CONSTRAINT drgpos_pkey PRIMARY KEY (dgrpos);


--
-- Name: dsgrpf dsgrpf_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.dsgrpf
    ADD CONSTRAINT dsgrpf_pkey PRIMARY KEY (dsgrpf);


--
-- Name: dteloc dteloc_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.dteloc
    ADD CONSTRAINT dteloc_pkey PRIMARY KEY (dteloc);


--
-- Name: edigeo_rel edigeo_rel_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.edigeo_rel
    ADD CONSTRAINT edigeo_rel_pkey PRIMARY KEY (edigeo_rel);


--
-- Name: fburx fburx_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.fburx
    ADD CONSTRAINT fburx_pkey PRIMARY KEY (fburx);


--
-- Name: geo_batiment_parcelle geo_batiment_parcelle_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_batiment_parcelle
    ADD CONSTRAINT geo_batiment_parcelle_pk PRIMARY KEY (geo_batiment_parcelle);


--
-- Name: geo_batiment geo_batiment_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_batiment
    ADD CONSTRAINT geo_batiment_pk PRIMARY KEY (ogc_fid);


--
-- Name: geo_borne_parcelle geo_borne_parcelle_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_borne_parcelle
    ADD CONSTRAINT geo_borne_parcelle_pk PRIMARY KEY (geo_borne_parcelle);


--
-- Name: geo_borne geo_borne_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_borne
    ADD CONSTRAINT geo_borne_pk PRIMARY KEY (geo_borne);


--
-- Name: geo_can geo_can_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_can
    ADD CONSTRAINT geo_can_pkey PRIMARY KEY (geo_can);


--
-- Name: geo_commune geo_commune_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_commune
    ADD CONSTRAINT geo_commune_pk PRIMARY KEY (ogc_fid);


--
-- Name: geo_copl geo_copl_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_copl
    ADD CONSTRAINT geo_copl_pkey PRIMARY KEY (geo_copl);


--
-- Name: geo_croix_parcelle geo_croix_parcelle_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_croix_parcelle
    ADD CONSTRAINT geo_croix_parcelle_pk PRIMARY KEY (geo_croix_parcelle);


--
-- Name: geo_croix geo_croix_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_croix
    ADD CONSTRAINT geo_croix_pk PRIMARY KEY (geo_croix);


--
-- Name: geo_dur geo_dur_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_dur
    ADD CONSTRAINT geo_dur_pkey PRIMARY KEY (geo_dur);


--
-- Name: geo_indp geo_indp_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_indp
    ADD CONSTRAINT geo_indp_pkey PRIMARY KEY (geo_indp);


--
-- Name: geo_inp geo_inp_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_inp
    ADD CONSTRAINT geo_inp_pkey PRIMARY KEY (geo_inp);


--
-- Name: geo_label geo_label_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_label
    ADD CONSTRAINT geo_label_pk PRIMARY KEY (ogc_fid);


--
-- Name: geo_lieudit geo_lieudit_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_lieudit
    ADD CONSTRAINT geo_lieudit_pk PRIMARY KEY (geo_lieudit);


--
-- Name: geo_map geo_map_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_map
    ADD CONSTRAINT geo_map_pkey PRIMARY KEY (geo_map);


--
-- Name: geo_numvoie_parcelle geo_numvoie_parcelle_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_numvoie_parcelle
    ADD CONSTRAINT geo_numvoie_parcelle_pk PRIMARY KEY (geo_numvoie_parcelle);


--
-- Name: geo_numvoie geo_numvoie_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_numvoie
    ADD CONSTRAINT geo_numvoie_pk PRIMARY KEY (geo_numvoie);


--
-- Name: geo_palt geo_palt_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_palt
    ADD CONSTRAINT geo_palt_pkey PRIMARY KEY (geo_palt);


--
-- Name: geo_parcelle geo_parcelle_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_parcelle
    ADD CONSTRAINT geo_parcelle_pk PRIMARY KEY (ogc_fid);


--
-- Name: geo_ppln geo_ppln_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_ppln
    ADD CONSTRAINT geo_ppln_pkey PRIMARY KEY (geo_ppln);


--
-- Name: geo_ptcanv geo_ptcanv_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_ptcanv
    ADD CONSTRAINT geo_ptcanv_pk PRIMARY KEY (geo_ptcanv);


--
-- Name: geo_qupl geo_qupl_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_qupl
    ADD CONSTRAINT geo_qupl_pkey PRIMARY KEY (geo_qupl);


--
-- Name: geo_section geo_section_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_section
    ADD CONSTRAINT geo_section_pk PRIMARY KEY (ogc_fid);


--
-- Name: geo_subdfisc_parcelle geo_subdfisc_parcelle_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_subdfisc_parcelle
    ADD CONSTRAINT geo_subdfisc_parcelle_pk PRIMARY KEY (geo_subdfisc_parcelle);


--
-- Name: geo_subdfisc geo_subdfisc_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_subdfisc
    ADD CONSTRAINT geo_subdfisc_pk PRIMARY KEY (geo_subdfisc);


--
-- Name: geo_subdsect geo_subdsect_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_subdsect
    ADD CONSTRAINT geo_subdsect_pk PRIMARY KEY (ogc_fid);


--
-- Name: geo_sym geo_sym_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_sym
    ADD CONSTRAINT geo_sym_pkey PRIMARY KEY (geo_sym);


--
-- Name: geo_symblim_parcelle geo_symblim_parcelle_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_symblim_parcelle
    ADD CONSTRAINT geo_symblim_parcelle_pk PRIMARY KEY (geo_symblim_parcelle);


--
-- Name: geo_symblim geo_symblim_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_symblim
    ADD CONSTRAINT geo_symblim_pk PRIMARY KEY (geo_symblim);


--
-- Name: geo_tline_commune geo_tline_commune_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tline_commune
    ADD CONSTRAINT geo_tline_commune_pk PRIMARY KEY (geo_tline_commune);


--
-- Name: geo_tline geo_tline_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tline
    ADD CONSTRAINT geo_tline_pk PRIMARY KEY (geo_tline);


--
-- Name: geo_tpoint_commune geo_tpoint_commune_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tpoint_commune
    ADD CONSTRAINT geo_tpoint_commune_pk PRIMARY KEY (geo_tpoint_commune);


--
-- Name: geo_tpoint geo_tpoint_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tpoint
    ADD CONSTRAINT geo_tpoint_pk PRIMARY KEY (geo_tpoint);


--
-- Name: geo_tronfluv geo_tronfluv_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tronfluv
    ADD CONSTRAINT geo_tronfluv_pk PRIMARY KEY (geo_tronfluv);


--
-- Name: geo_tronroute geo_tronroute_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tronroute
    ADD CONSTRAINT geo_tronroute_pk PRIMARY KEY (geo_tronroute);


--
-- Name: geo_tsurf_commune geo_tsurf_commune_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tsurf_commune
    ADD CONSTRAINT geo_tsurf_commune_pk PRIMARY KEY (geo_tsurf_commune);


--
-- Name: geo_tsurf geo_tsurf_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_tsurf
    ADD CONSTRAINT geo_tsurf_pk PRIMARY KEY (geo_tsurf);


--
-- Name: geo_unite_fonciere geo_unite_fonciere_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_unite_fonciere
    ADD CONSTRAINT geo_unite_fonciere_pk PRIMARY KEY (id);


--
-- Name: geo_voiep geo_voiep_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_voiep
    ADD CONSTRAINT geo_voiep_pk PRIMARY KEY (geo_voiep);


--
-- Name: geo_zoncommuni geo_zoncommuni_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.geo_zoncommuni
    ADD CONSTRAINT geo_zoncommuni_pk PRIMARY KEY (geo_zoncommuni);


--
-- Name: gimtom gimtom_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gimtom
    ADD CONSTRAINT gimtom_pkey PRIMARY KEY (gimtom);


--
-- Name: gnexpl gnexpl_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gnexpl
    ADD CONSTRAINT gnexpl_pkey PRIMARY KEY (gnexpl);


--
-- Name: gnexps gnexps_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gnexps
    ADD CONSTRAINT gnexps_pkey PRIMARY KEY (gnexps);


--
-- Name: gnextl gnextl_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gnextl
    ADD CONSTRAINT gnextl_pkey PRIMARY KEY (gnextl);


--
-- Name: gnexts gnexts_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gnexts
    ADD CONSTRAINT gnexts_pkey PRIMARY KEY (gnexts);


--
-- Name: gpdl gpdl_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gpdl
    ADD CONSTRAINT gpdl_pkey PRIMARY KEY (gpdl);


--
-- Name: gtoper gtoper_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gtoper
    ADD CONSTRAINT gtoper_pkey PRIMARY KEY (gtoper);


--
-- Name: gtyp3 gtyp3_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gtyp3
    ADD CONSTRAINT gtyp3_pkey PRIMARY KEY (gtyp3);


--
-- Name: gtyp4 gtyp4_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gtyp4
    ADD CONSTRAINT gtyp4_pkey PRIMARY KEY (gtyp4);


--
-- Name: gtyp5 gtyp5_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gtyp5
    ADD CONSTRAINT gtyp5_pkey PRIMARY KEY (gtyp5);


--
-- Name: gtyp6 gtyp6_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.gtyp6
    ADD CONSTRAINT gtyp6_pkey PRIMARY KEY (gtyp6);


--
-- Name: hlmsem hlmsem_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.hlmsem
    ADD CONSTRAINT hlmsem_pkey PRIMARY KEY (hlmsem);


--
-- Name: indldnbat indldnbat_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.indldnbat
    ADD CONSTRAINT indldnbat_pkey PRIMARY KEY (indldnbat);


--
-- Name: local00 local00_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.local00
    ADD CONSTRAINT local00_pk PRIMARY KEY (local00);


--
-- Name: local10 local10_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.local10
    ADD CONSTRAINT local10_pk PRIMARY KEY (local10);


--
-- Name: lotslocaux loclocaux_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.lotslocaux
    ADD CONSTRAINT loclocaux_pk PRIMARY KEY (lotslocaux);


--
-- Name: lots lots_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.lots
    ADD CONSTRAINT lots_pk PRIMARY KEY (lots);


--
-- Name: natvoi natvoi_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.natvoi
    ADD CONSTRAINT natvoi_pkey PRIMARY KEY (natvoi);


--
-- Name: natvoiriv natvoiriv_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.natvoiriv
    ADD CONSTRAINT natvoiriv_pkey PRIMARY KEY (natvoiriv);


--
-- Name: parcelle_info parcelle_info_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.parcelle_info
    ADD CONSTRAINT parcelle_info_pk PRIMARY KEY (ogc_fid);


--
-- Name: parcelle parcelle_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.parcelle
    ADD CONSTRAINT parcelle_pk PRIMARY KEY (parcelle);


--
-- Name: parcellecomposante parcellecomposante_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.parcellecomposante
    ADD CONSTRAINT parcellecomposante_pk PRIMARY KEY (parcellecomposante);


--
-- Name: pdl pdl_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.pdl
    ADD CONSTRAINT pdl_pk PRIMARY KEY (pdl);


--
-- Name: pev pev_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.pev
    ADD CONSTRAINT pev_pk PRIMARY KEY (pev);


--
-- Name: pevdependances pevdependances_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.pevdependances
    ADD CONSTRAINT pevdependances_pk PRIMARY KEY (pevdependances);


--
-- Name: pevexoneration pevexoneration_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.pevexoneration
    ADD CONSTRAINT pevexoneration_pk PRIMARY KEY (pevexoneration);


--
-- Name: pevlissage pevlissage_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.pevlissage
    ADD CONSTRAINT pevlissage_pk PRIMARY KEY (pevlissage);


--
-- Name: pevprincipale pevprincipale_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.pevprincipale
    ADD CONSTRAINT pevprincipale_pk PRIMARY KEY (pevprincipale);


--
-- Name: pevprofessionnelle pevprofessionnelle_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.pevprofessionnelle
    ADD CONSTRAINT pevprofessionnelle_pk PRIMARY KEY (pevprofessionnelle);


--
-- Name: pevtaxation pevtaxation_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.pevtaxation
    ADD CONSTRAINT pevtaxation_pk PRIMARY KEY (pevtaxation);


--
-- Name: proprietaire proprietaire_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.proprietaire
    ADD CONSTRAINT proprietaire_pk PRIMARY KEY (proprietaire);


--
-- Name: suf suf_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.suf
    ADD CONSTRAINT suf_pk PRIMARY KEY (suf);


--
-- Name: sufexoneration sufexoneration_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.sufexoneration
    ADD CONSTRAINT sufexoneration_pk PRIMARY KEY (sufexoneration);


--
-- Name: suftaxation suftaxation_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.suftaxation
    ADD CONSTRAINT suftaxation_pk PRIMARY KEY (suftaxation);


--
-- Name: top48a top48a_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.top48a
    ADD CONSTRAINT top48a_pkey PRIMARY KEY (top48a);


--
-- Name: typcom typcom_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.typcom
    ADD CONSTRAINT typcom_pkey PRIMARY KEY (typcom);


--
-- Name: type_filiation type_filiation_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.type_filiation
    ADD CONSTRAINT type_filiation_pkey PRIMARY KEY (type_filiation);


--
-- Name: typvoi typvoi_pkey; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.typvoi
    ADD CONSTRAINT typvoi_pkey PRIMARY KEY (typvoi);


--
-- Name: voie voie_pk; Type: CONSTRAINT; Schema: cadastre_mtp; Owner: -
--

ALTER TABLE ONLY cadastre_mtp.voie
    ADD CONSTRAINT voie_pk PRIMARY KEY (voie);


--
-- Name: geo_batiment_centroide_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_batiment_centroide_geom_idx ON cadastre_mtp.geo_batiment USING gist (public.st_centroid(geom));


--
-- Name: geo_batiment_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_batiment_geom_idx ON cadastre_mtp.geo_batiment USING gist (geom);


--
-- Name: geo_borne_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_borne_geom_idx ON cadastre_mtp.geo_borne USING gist (geom);


--
-- Name: geo_commune_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_commune_geom_idx ON cadastre_mtp.geo_commune USING gist (geom);


--
-- Name: geo_commune_tex2_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_commune_tex2_idx ON cadastre_mtp.geo_commune USING btree (tex2);


--
-- Name: geo_croix_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_croix_geom_idx ON cadastre_mtp.geo_croix USING gist (geom);


--
-- Name: geo_label_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_label_geom_idx ON cadastre_mtp.geo_label USING gist (geom);


--
-- Name: geo_label_ogc_fid_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_label_ogc_fid_idx ON cadastre_mtp.geo_label USING btree (ogc_fid);


--
-- Name: geo_label_ogr_obj_lnk_layer_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_label_ogr_obj_lnk_layer_idx ON cadastre_mtp.geo_label USING btree (ogr_obj_lnk_layer);


--
-- Name: geo_label_x_label_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_label_x_label_idx ON cadastre_mtp.geo_label USING btree (x_label);


--
-- Name: geo_label_y_label_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_label_y_label_idx ON cadastre_mtp.geo_label USING btree (y_label);


--
-- Name: geo_lieudit_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_lieudit_geom_idx ON cadastre_mtp.geo_lieudit USING gist (geom);


--
-- Name: geo_numvoie_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_numvoie_geom_idx ON cadastre_mtp.geo_numvoie USING gist (geom);


--
-- Name: geo_parcelle_centroide_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_parcelle_centroide_geom_idx ON cadastre_mtp.geo_parcelle USING gist (public.st_centroid(geom));


--
-- Name: geo_parcelle_geo_parcelle; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_parcelle_geo_parcelle ON cadastre_mtp.geo_parcelle USING btree (geo_parcelle);


--
-- Name: geo_parcelle_geo_section_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_parcelle_geo_section_idx ON cadastre_mtp.geo_parcelle USING btree (geo_section);


--
-- Name: geo_parcelle_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_parcelle_geom_idx ON cadastre_mtp.geo_parcelle USING gist (geom);


--
-- Name: geo_parcelle_idu_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_parcelle_idu_idx ON cadastre_mtp.geo_parcelle USING btree (idu);


--
-- Name: geo_ptcanv_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_ptcanv_geom_idx ON cadastre_mtp.geo_ptcanv USING gist (geom);


--
-- Name: geo_section_geo_commune_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_section_geo_commune_idx ON cadastre_mtp.geo_section USING btree (geo_commune);


--
-- Name: geo_section_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_section_geom_idx ON cadastre_mtp.geo_section USING gist (geom);


--
-- Name: geo_section_idu_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_section_idu_idx ON cadastre_mtp.geo_section USING btree (idu);


--
-- Name: geo_subdfisc_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_subdfisc_geom_idx ON cadastre_mtp.geo_subdfisc USING gist (geom);


--
-- Name: geo_subdsect_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_subdsect_geom_idx ON cadastre_mtp.geo_subdsect USING gist (geom);


--
-- Name: geo_symblim_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_symblim_geom_idx ON cadastre_mtp.geo_symblim USING gist (geom);


--
-- Name: geo_tline_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_tline_geom_idx ON cadastre_mtp.geo_tline USING gist (geom);


--
-- Name: geo_tpoint_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_tpoint_geom_idx ON cadastre_mtp.geo_tpoint USING gist (geom);


--
-- Name: geo_tronfluv_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_tronfluv_geom_idx ON cadastre_mtp.geo_tronfluv USING gist (geom);


--
-- Name: geo_tronroute_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_tronroute_geom_idx ON cadastre_mtp.geo_tronroute USING gist (geom);


--
-- Name: geo_tsurf_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_tsurf_geom_idx ON cadastre_mtp.geo_tsurf USING gist (geom);


--
-- Name: geo_unite_fonciere_comptecommunal_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_unite_fonciere_comptecommunal_idx ON cadastre_mtp.geo_unite_fonciere USING btree (comptecommunal);


--
-- Name: geo_unite_fonciere_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_unite_fonciere_geom_idx ON cadastre_mtp.geo_unite_fonciere USING gist (geom);


--
-- Name: geo_voiep_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_voiep_geom_idx ON cadastre_mtp.geo_voiep USING gist (geom);


--
-- Name: geo_zoncommuni_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX geo_zoncommuni_geom_idx ON cadastre_mtp.geo_zoncommuni USING gist (geom);


--
-- Name: idx_commune_ccocom; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_commune_ccocom ON cadastre_mtp.commune USING btree (ccocom);


--
-- Name: idx_commune_majic_ccocom; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_commune_majic_ccocom ON cadastre_mtp.commune_majic USING btree (ccocom);


--
-- Name: idx_local00_parcelle; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_local00_parcelle ON cadastre_mtp.local00 USING btree (parcelle);


--
-- Name: idx_local00_voie; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_local00_voie ON cadastre_mtp.local00 USING btree (voie);


--
-- Name: idx_local10_comptecommunal; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_local10_comptecommunal ON cadastre_mtp.local10 USING btree (comptecommunal);


--
-- Name: idx_local10_local00; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_local10_local00 ON cadastre_mtp.local10 USING btree (local00);


--
-- Name: idx_parcelle_comptecommunal; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_parcelle_comptecommunal ON cadastre_mtp.parcelle USING btree (comptecommunal);


--
-- Name: idx_parcelle_voie; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_parcelle_voie ON cadastre_mtp.parcelle USING btree (voie);


--
-- Name: idx_pevexoneration_pev; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_pevexoneration_pev ON cadastre_mtp.pevexoneration USING btree (pev);


--
-- Name: idx_pevtaxation_pev; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_pevtaxation_pev ON cadastre_mtp.pevtaxation USING btree (pev);


--
-- Name: idx_proprietaire_ccocom; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_proprietaire_ccocom ON cadastre_mtp.proprietaire USING btree (ccocom);


--
-- Name: idx_proprietaire_ccodro; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_proprietaire_ccodro ON cadastre_mtp.proprietaire USING btree (ccodro);


--
-- Name: idx_proprietaire_comptecommunal; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX idx_proprietaire_comptecommunal ON cadastre_mtp.proprietaire USING btree (comptecommunal);


--
-- Name: parcelle_info_codecommune_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX parcelle_info_codecommune_idx ON cadastre_mtp.parcelle_info USING btree (codecommune);


--
-- Name: parcelle_info_geo_parcelle_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX parcelle_info_geo_parcelle_idx ON cadastre_mtp.parcelle_info USING btree (geo_parcelle);


--
-- Name: parcelle_info_geo_parcelle_sub; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX parcelle_info_geo_parcelle_sub ON cadastre_mtp.parcelle_info USING btree (substr(geo_parcelle, 1, 10));


--
-- Name: parcelle_info_geo_section_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX parcelle_info_geo_section_idx ON cadastre_mtp.parcelle_info USING btree (geo_section);


--
-- Name: parcelle_info_geom_idx; Type: INDEX; Schema: cadastre_mtp; Owner: -
--

CREATE INDEX parcelle_info_geom_idx ON cadastre_mtp.parcelle_info USING gist (geom);


--
-- PostgreSQL database dump complete
--
