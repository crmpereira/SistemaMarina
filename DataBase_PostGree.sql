-- Database: nkmarina

-- DROP DATABASE IF EXISTS nkmarina;

CREATE DATABASE nkmarina
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE nkmarina
    IS 'Banco de dados do projeto da marina';




-- Table: public.agenda

-- DROP TABLE IF EXISTS public.agenda;

CREATE TABLE IF NOT EXISTS public.agenda
(
    id_agenda integer NOT NULL DEFAULT nextval('agenda_id_agenda_seq'::regclass),
    dh_cadastro_agenda timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dh_solicit_agenda timestamp(6) without time zone NOT NULL,
    cliente_id integer,
    situacao_agenda integer,
    embarc_id integer,
    CONSTRAINT agenda_pkey PRIMARY KEY (id_agenda),
    CONSTRAINT fkcq2l1egxrqs2f07s8xnhpg2fg FOREIGN KEY (cliente_id)
        REFERENCES public.cliente (id_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkf0poltg6g8jd6a9uelx0iuq5j FOREIGN KEY (embarc_id)
        REFERENCES public.embarcacao (id_embarc) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.agenda
    OWNER to postgres;

-- Trigger: insert_check

-- DROP TRIGGER IF EXISTS insert_check ON public.agenda;

CREATE TRIGGER insert_check
    BEFORE INSERT
    ON public.agenda
    FOR EACH ROW
    EXECUTE FUNCTION public.inserir_checklist();






-- Table: public.checklist

-- DROP TABLE IF EXISTS public.checklist;

CREATE TABLE IF NOT EXISTS public.checklist
(
    id_check integer NOT NULL DEFAULT nextval('check_id_check_seq'::regclass),
    embarcacao_id integer NOT NULL,
    situacao_check character varying(1) COLLATE pg_catalog."default",
    tipo_check integer,
    CONSTRAINT checklist_embarcacao_pkey PRIMARY KEY (id_check),
    CONSTRAINT fkhrelom6sb3g8hn9jyj416c1gu FOREIGN KEY (embarcacao_id)
        REFERENCES public.embarcacao (id_embarc) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.checklist
    OWNER to postgres;




-- Table: public.cliente

-- DROP TABLE IF EXISTS public.cliente;

CREATE TABLE IF NOT EXISTS public.cliente
(
    id_cliente integer NOT NULL DEFAULT nextval('cliente_id_cliente_seq'::regclass),
    nm_cliente character varying(100) COLLATE pg_catalog."default" NOT NULL,
    end_cliente character varying(100) COLLATE pg_catalog."default",
    tel_cliente character varying(50) COLLATE pg_catalog."default" NOT NULL,
    email_cliente character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cliente
    OWNER to postgres;





-- Table: public.embarcacao

-- DROP TABLE IF EXISTS public.embarcacao;

CREATE TABLE IF NOT EXISTS public.embarcacao
(
    nm_embarc character varying(255) COLLATE pg_catalog."default" NOT NULL,
    id_embarc integer NOT NULL DEFAULT nextval('embarc_id_embarc_seq'::regclass),
    nrmarinha_embarc character varying COLLATE pg_catalog."default",
    cliente_id integer NOT NULL,
    tipo_embarc integer,
    CONSTRAINT embarcacao_pkey PRIMARY KEY (id_embarc),
    CONSTRAINT fkosm0t321l0jsh64gshocks734 FOREIGN KEY (cliente_id)
        REFERENCES public.cliente (id_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.embarcacao
    OWNER to postgres;



-- Table: public.usuario

-- DROP TABLE IF EXISTS public.usuario;

CREATE TABLE IF NOT EXISTS public.usuario
(
    id_user bigint NOT NULL DEFAULT nextval('usuario_id_seq'::regclass),
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    password character varying(255) COLLATE pg_catalog."default" NOT NULL,
    enabled boolean NOT NULL,
    CONSTRAINT usuario_pkey PRIMARY KEY (id_user),
    CONSTRAINT usuario_username_key UNIQUE (username)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.usuario
    OWNER to postgres;



-- FUNCTION: public.inserir_checklist()

-- DROP FUNCTION IF EXISTS public.inserir_checklist();

CREATE OR REPLACE FUNCTION public.inserir_checklist()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  INSERT INTO CheckList (embarcacao_id, situacao_check, tipo_check)
  VALUES (NEW.embarc_id, NEW.situacao_agenda, 1); 
  
  INSERT INTO CheckList (embarcacao_id, situacao_check, tipo_check)
  VALUES (NEW.embarc_id, NEW.situacao_agenda, 2); 

  INSERT INTO CheckList (embarcacao_id, situacao_check, tipo_check)
  VALUES (NEW.embarc_id, NEW.situacao_agenda, 3); 
  
  INSERT INTO CheckList (embarcacao_id, situacao_check, tipo_check)
  VALUES (NEW.embarc_id, NEW.situacao_agenda, 4); 
  
  INSERT INTO CheckList (embarcacao_id, situacao_check, tipo_check)
  VALUES (NEW.embarc_id, NEW.situacao_agenda, 5); 
  
  INSERT INTO CheckList (embarcacao_id, situacao_check, tipo_check)
  VALUES (NEW.embarc_id, NEW.situacao_agenda, 6); 

  RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.inserir_checklist()
    OWNER TO postgres;






