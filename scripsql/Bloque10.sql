--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8
-- Dumped by pg_dump version 12.8

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
-- Name: Administradores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Administradores" (
    "identificaciónUsuario" integer NOT NULL,
    "idDependencia" integer NOT NULL,
    "idCargo" integer NOT NULL
);


ALTER TABLE public."Administradores" OWNER TO postgres;

--
-- Name: ArchivosPublicaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ArchivosPublicaciones" (
    "idArchivo" integer NOT NULL,
    nombre character varying(50) NOT NULL,
    "fechaDeSubida" date NOT NULL,
    url text NOT NULL,
    "idPublicación" integer NOT NULL
);


ALTER TABLE public."ArchivosPublicaciones" OWNER TO postgres;

--
-- Name: Cargos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cargos" (
    "idCargo" integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public."Cargos" OWNER TO postgres;

--
-- Name: CategoríasCursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CategoríasCursos" (
    "idCategoríaCurso" integer NOT NULL,
    "nombreCategoríaCurso" character varying(50) NOT NULL
);


ALTER TABLE public."CategoríasCursos" OWNER TO postgres;

--
-- Name: Comentarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comentarios" (
    "IdentificaciónUsuario" integer NOT NULL,
    "idPublicación" integer NOT NULL,
    fecha date NOT NULL,
    comentario text NOT NULL
);


ALTER TABLE public."Comentarios" OWNER TO postgres;

--
-- Name: Conexiones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Conexiones" (
    "identificaciónUsuario1" integer NOT NULL,
    "identificaciónUsuario2" integer NOT NULL,
    "fechaDeCreación" date NOT NULL
);


ALTER TABLE public."Conexiones" OWNER TO postgres;

--
-- Name: Cursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cursos" (
    "idCurso" integer NOT NULL,
    nombre character varying(50) NOT NULL,
    "descripción" text NOT NULL,
    costo integer NOT NULL,
    certificado bit(1) NOT NULL,
    "idCategoríaCurso" integer NOT NULL
);


ALTER TABLE public."Cursos" OWNER TO postgres;

--
-- Name: Dependencias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dependencias" (
    "idDependencia" integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public."Dependencias" OWNER TO postgres;

--
-- Name: EstadosDeInscripción; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EstadosDeInscripción" (
    "idEstadoInscripción" integer NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE public."EstadosDeInscripción" OWNER TO postgres;

--
-- Name: Estudiantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Estudiantes" (
    "identificaciónUsuario" integer NOT NULL,
    "idPrograma" integer NOT NULL
);


ALTER TABLE public."Estudiantes" OWNER TO postgres;

--
-- Name: Facultades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Facultades" (
    "idFacultad" integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public."Facultades" OWNER TO postgres;

--
-- Name: FotosPublicaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FotosPublicaciones" (
    "idArchivo" integer NOT NULL,
    "idÁlbum" integer
);


ALTER TABLE public."FotosPublicaciones" OWNER TO postgres;

--
-- Name: Grupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Grupos" (
    "idGrupo" integer NOT NULL,
    "nombreGrupo" character varying(50) NOT NULL,
    "descripción" text,
    "idPrivacidad" integer NOT NULL
);


ALTER TABLE public."Grupos" OWNER TO postgres;

--
-- Name: InscripcionesEnCursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InscripcionesEnCursos" (
    "idCurso" integer NOT NULL,
    "identificaciónUsuario" integer NOT NULL,
    "fechaDeIngreso" date NOT NULL,
    "idEstadoDeInscripción" integer NOT NULL
);


ALTER TABLE public."InscripcionesEnCursos" OWNER TO postgres;

--
-- Name: InscripcionesEnGrupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InscripcionesEnGrupos" (
    "idGrupo" integer NOT NULL,
    "identificaciónUsuario" integer NOT NULL
);


ALTER TABLE public."InscripcionesEnGrupos" OWNER TO postgres;

--
-- Name: Likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Likes" (
    "idPublicación" integer NOT NULL,
    "identificaciónUsuario" integer NOT NULL,
    fecha date NOT NULL,
    "idTipoDeLike" integer NOT NULL
);


ALTER TABLE public."Likes" OWNER TO postgres;

--
-- Name: NivelesB10; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."NivelesB10" (
    "idNivel" integer NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE public."NivelesB10" OWNER TO postgres;

--
-- Name: Paises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Paises" (
    "idPaís" integer NOT NULL,
    nombre character varying(45) NOT NULL
);


ALTER TABLE public."Paises" OWNER TO postgres;

--
-- Name: Programas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Programas" (
    "idPrograma" integer NOT NULL,
    nombre character varying(50) NOT NULL,
    "idFacultad" integer NOT NULL
);


ALTER TABLE public."Programas" OWNER TO postgres;

--
-- Name: Publicaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Publicaciones" (
    "idPublicación" integer NOT NULL,
    "descripción" text,
    "fechaDePublicación" date NOT NULL,
    "identificaciónUsuario" integer NOT NULL,
    "idTipoDePrivacidad" integer NOT NULL
);


ALTER TABLE public."Publicaciones" OWNER TO postgres;

--
-- Name: PublicacionesGrupales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PublicacionesGrupales" (
    "idGrupo" integer NOT NULL,
    "idPublicación" integer NOT NULL
);


ALTER TABLE public."PublicacionesGrupales" OWNER TO postgres;

--
-- Name: SeccionesCursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SeccionesCursos" (
    "idSecciónCurso" integer NOT NULL,
    "nombreSecciónCurso" character varying(50) NOT NULL,
    "idCurso" integer NOT NULL
);


ALTER TABLE public."SeccionesCursos" OWNER TO postgres;

--
-- Name: Seguidores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Seguidores" (
    "identificaciónSeguidor" integer NOT NULL,
    "identificaciónSeguido" integer NOT NULL
);


ALTER TABLE public."Seguidores" OWNER TO postgres;

--
-- Name: TemasCursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TemasCursos" (
    "idTema" integer NOT NULL,
    "nombreTemaCurso" character varying NOT NULL,
    "idSección" integer NOT NULL,
    "descripción" text,
    url text NOT NULL
);


ALTER TABLE public."TemasCursos" OWNER TO postgres;

--
-- Name: TiposDeLike; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TiposDeLike" (
    "idTipoDeLike" integer NOT NULL,
    "nombreTipoDeLike" character varying(50) NOT NULL
);


ALTER TABLE public."TiposDeLike" OWNER TO postgres;

--
-- Name: TiposDePrivacidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TiposDePrivacidad" (
    "idTipoDePrivacidad" integer NOT NULL,
    privacidad character varying(40) NOT NULL
);


ALTER TABLE public."TiposDePrivacidad" OWNER TO postgres;

--
-- Name: TiposDeUsuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TiposDeUsuarios" (
    "idTipoDeUsuario" integer NOT NULL,
    "nombreTipoDeUsuario" character varying(45) NOT NULL
);


ALTER TABLE public."TiposDeUsuarios" OWNER TO postgres;

--
-- Name: Usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Usuarios" (
    "identificación" integer NOT NULL,
    "primerNombre" character varying(45) NOT NULL,
    "segundoNombre" character varying(45),
    "primerApellido" character varying(45) NOT NULL,
    "segundoApellido" character varying(45),
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    "biografía" text,
    "fechaDeRegistro" date NOT NULL,
    "idPaís" integer NOT NULL,
    "idTipoDeUsuario" integer NOT NULL,
    "idNivel" integer NOT NULL,
    "idFotoDePerfil" integer,
    "idFotoDePortada" integer
);


ALTER TABLE public."Usuarios" OWNER TO postgres;

--
-- Name: Álbumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Álbumes" (
    "idÁlbum" integer NOT NULL,
    "identificaciónUsuario" integer NOT NULL,
    nombre character varying(50) NOT NULL,
    "fechaDeCreación" date NOT NULL
);


ALTER TABLE public."Álbumes" OWNER TO postgres;

--
-- Data for Name: Administradores; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Administradores" ("identificaciónUsuario", "idDependencia", "idCargo") VALUES (2, 1, 3);
INSERT INTO public."Administradores" ("identificaciónUsuario", "idDependencia", "idCargo") VALUES (3, 1, 1);


--
-- Data for Name: ArchivosPublicaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Cargos" ("idCargo", nombre) VALUES (1, 'Director centro de universidad');
INSERT INTO public."Cargos" ("idCargo", nombre) VALUES (2, 'Docente tiempo completo');
INSERT INTO public."Cargos" ("idCargo", nombre) VALUES (3, 'Docente ocasional');


--
-- Data for Name: CategoríasCursos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Comentarios; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Conexiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Conexiones" ("identificaciónUsuario1", "identificaciónUsuario2", "fechaDeCreación") VALUES (1, 1, '2021-12-06');


--
-- Data for Name: Cursos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Dependencias; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Dependencias" ("idDependencia", nombre) VALUES (1, 'VAC');


--
-- Data for Name: EstadosDeInscripción; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Estudiantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Estudiantes" ("identificaciónUsuario", "idPrograma") VALUES (1, 2);


--
-- Data for Name: Facultades; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Facultades" ("idFacultad", nombre) VALUES (1, 'Ciencias empresariales y económicas');
INSERT INTO public."Facultades" ("idFacultad", nombre) VALUES (2, 'Ingeniería');
INSERT INTO public."Facultades" ("idFacultad", nombre) VALUES (3, 'Facultad de ciencias básicas');
INSERT INTO public."Facultades" ("idFacultad", nombre) VALUES (4, 'Humanidades');
INSERT INTO public."Facultades" ("idFacultad", nombre) VALUES (5, 'Ciencias de la salud');
INSERT INTO public."Facultades" ("idFacultad", nombre) VALUES (6, 'Ciencias de la educación');


--
-- Data for Name: FotosPublicaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Grupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Grupos" ("idGrupo", "nombreGrupo", "descripción", "idPrivacidad") VALUES (1, 'Hablemos de calculo', 'si sabes cuanto es 1+1 entra', 1);
INSERT INTO public."Grupos" ("idGrupo", "nombreGrupo", "descripción", "idPrivacidad") VALUES (2, 'Hablemos de salud', 'No vengan a decir cosas que no tienen que ver con ciencia', 2);
INSERT INTO public."Grupos" ("idGrupo", "nombreGrupo", "descripción", "idPrivacidad") VALUES (3, 'Hablemos de naturaleza', 'somos los que somos y estamos los que estamos', 1);
INSERT INTO public."Grupos" ("idGrupo", "nombreGrupo", "descripción", "idPrivacidad") VALUES (4, 'Hablemos de ciencia', NULL, 2);


--
-- Data for Name: InscripcionesEnCursos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: InscripcionesEnGrupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."InscripcionesEnGrupos" ("idGrupo", "identificaciónUsuario") VALUES (1, 1);
INSERT INTO public."InscripcionesEnGrupos" ("idGrupo", "identificaciónUsuario") VALUES (2, 1);
INSERT INTO public."InscripcionesEnGrupos" ("idGrupo", "identificaciónUsuario") VALUES (1, 2);
INSERT INTO public."InscripcionesEnGrupos" ("idGrupo", "identificaciónUsuario") VALUES (4, 2);


--
-- Data for Name: Likes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: NivelesB10; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."NivelesB10" ("idNivel", nombre) VALUES (1, 'Tutor B10');
INSERT INTO public."NivelesB10" ("idNivel", nombre) VALUES (2, 'Innovador');
INSERT INTO public."NivelesB10" ("idNivel", nombre) VALUES (3, 'Integrador');
INSERT INTO public."NivelesB10" ("idNivel", nombre) VALUES (4, 'Explorador');


--
-- Data for Name: Paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Paises" ("idPaís", nombre) VALUES (1, 'Colombia');
INSERT INTO public."Paises" ("idPaís", nombre) VALUES (2, 'Venezuela');
INSERT INTO public."Paises" ("idPaís", nombre) VALUES (3, 'Ecuador');
INSERT INTO public."Paises" ("idPaís", nombre) VALUES (4, 'Bolivia');


--
-- Data for Name: Programas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Programas" ("idPrograma", nombre, "idFacultad") VALUES (1, 'Administración de empresas', 1);
INSERT INTO public."Programas" ("idPrograma", nombre, "idFacultad") VALUES (2, 'Ingeniería de sistemas', 2);
INSERT INTO public."Programas" ("idPrograma", nombre, "idFacultad") VALUES (3, 'Biología', 3);
INSERT INTO public."Programas" ("idPrograma", nombre, "idFacultad") VALUES (4, 'Antropología', 4);
INSERT INTO public."Programas" ("idPrograma", nombre, "idFacultad") VALUES (5, 'Enfermería', 5);
INSERT INTO public."Programas" ("idPrograma", nombre, "idFacultad") VALUES (6, 'Licenciatura en artes', 6);


--
-- Data for Name: Publicaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: PublicacionesGrupales; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: SeccionesCursos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Seguidores; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: TemasCursos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: TiposDeLike; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TiposDeLike" ("idTipoDeLike", "nombreTipoDeLike") VALUES (1, 'Me gusta');
INSERT INTO public."TiposDeLike" ("idTipoDeLike", "nombreTipoDeLike") VALUES (2, 'Me divierte');
INSERT INTO public."TiposDeLike" ("idTipoDeLike", "nombreTipoDeLike") VALUES (3, 'Me enoja');


--
-- Data for Name: TiposDePrivacidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TiposDePrivacidad" ("idTipoDePrivacidad", privacidad) VALUES (1, 'Público');
INSERT INTO public."TiposDePrivacidad" ("idTipoDePrivacidad", privacidad) VALUES (2, 'Privado');


--
-- Data for Name: TiposDeUsuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TiposDeUsuarios" ("idTipoDeUsuario", "nombreTipoDeUsuario") VALUES (1, 'Estudiante');
INSERT INTO public."TiposDeUsuarios" ("idTipoDeUsuario", "nombreTipoDeUsuario") VALUES (2, 'Docente');
INSERT INTO public."TiposDeUsuarios" ("idTipoDeUsuario", "nombreTipoDeUsuario") VALUES (3, 'Directivo');


--
-- Data for Name: Usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Usuarios" ("identificación", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido", email, password, "biografía", "fechaDeRegistro", "idPaís", "idTipoDeUsuario", "idNivel", "idFotoDePerfil", "idFotoDePortada") VALUES (1, 'José', 'Alberto', 'Fontalvo', 'Anaya', 'correo', '123', NULL, '2021-12-06', 1, 1, 4, NULL, NULL);
INSERT INTO public."Usuarios" ("identificación", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido", email, password, "biografía", "fechaDeRegistro", "idPaís", "idTipoDeUsuario", "idNivel", "idFotoDePerfil", "idFotoDePortada") VALUES (2, 'Alexander', 'Armando', 'Bustamante', 'Martínez', 'correo2', '123', NULL, '2020-01-01', 1, 2, 2, NULL, NULL);
INSERT INTO public."Usuarios" ("identificación", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido", email, password, "biografía", "fechaDeRegistro", "idPaís", "idTipoDeUsuario", "idNivel", "idFotoDePerfil", "idFotoDePortada") VALUES (3, 'directivo', NULL, 'Pérez', NULL, 'correo3', '123', 'Hola, soy un administrador de prueba', '2019-11-03', 2, 3, 1, NULL, NULL);
INSERT INTO public."Usuarios" ("identificación", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido", email, password, "biografía", "fechaDeRegistro", "idPaís", "idTipoDeUsuario", "idNivel", "idFotoDePerfil", "idFotoDePortada") VALUES (1001, 'juan', 'jose', 'ortiz', 'polo', 'juanpolo@gmail.com', '123456', NULL, '2021-08-12', 1, 3, 4, NULL, NULL);
INSERT INTO public."Usuarios" ("identificación", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido", email, password, "biografía", "fechaDeRegistro", "idPaís", "idTipoDeUsuario", "idNivel", "idFotoDePerfil", "idFotoDePortada") VALUES (1002, 'camilo', 'andres', 'alvares', 'venera', 'camiloalvares@gmail.com', '78920', NULL, '2021-05-12', 1, 1, 3, NULL, NULL);
INSERT INTO public."Usuarios" ("identificación", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido", email, password, "biografía", "fechaDeRegistro", "idPaís", "idTipoDeUsuario", "idNivel", "idFotoDePerfil", "idFotoDePortada") VALUES (1003, 'andres', 'emiro', 'mendoza', 'barcelona', 'endresemiromendozagmail.com', '122334', NULL, '2020-01-12', 2, 2, 2, NULL, NULL);
INSERT INTO public."Usuarios" ("identificación", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido", email, password, "biografía", "fechaDeRegistro", "idPaís", "idTipoDeUsuario", "idNivel", "idFotoDePerfil", "idFotoDePortada") VALUES (1004, 'martin', 'elias', 'perez', 'contreras', 'martineliasmendoza@gmail.com', '14151617', NULL, '2019-08-15', 3, 1, 2, NULL, NULL);
INSERT INTO public."Usuarios" ("identificación", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido", email, password, "biografía", "fechaDeRegistro", "idPaís", "idTipoDeUsuario", "idNivel", "idFotoDePerfil", "idFotoDePortada") VALUES (1005, 'yurleidis', 'judith', 'palacio', 'carrillo', 'yurlepalacio@gmail.com', '1181920', NULL, '2020-08-12', 1, 3, 4, NULL, NULL);


--
-- Data for Name: Álbumes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: Administradores Administradores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Administradores"
    ADD CONSTRAINT "Administradores_pkey" PRIMARY KEY ("identificaciónUsuario");


--
-- Name: ArchivosPublicaciones ArchivosPublicaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ArchivosPublicaciones"
    ADD CONSTRAINT "ArchivosPublicaciones_pkey" PRIMARY KEY ("idArchivo");


--
-- Name: Cargos Cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cargos"
    ADD CONSTRAINT "Cargos_pkey" PRIMARY KEY ("idCargo");


--
-- Name: CategoríasCursos CategoríasCursos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CategoríasCursos"
    ADD CONSTRAINT "CategoríasCursos_pkey" PRIMARY KEY ("idCategoríaCurso");


--
-- Name: Comentarios Comentarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comentarios"
    ADD CONSTRAINT "Comentarios_pkey" PRIMARY KEY ("IdentificaciónUsuario", "idPublicación");


--
-- Name: Conexiones Conexiones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Conexiones"
    ADD CONSTRAINT "Conexiones_pkey" PRIMARY KEY ("identificaciónUsuario1", "identificaciónUsuario2");


--
-- Name: Cursos Cursos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cursos"
    ADD CONSTRAINT "Cursos_pkey" PRIMARY KEY ("idCurso");


--
-- Name: Dependencias Dependencias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dependencias"
    ADD CONSTRAINT "Dependencias_pkey" PRIMARY KEY ("idDependencia");


--
-- Name: EstadosDeInscripción EstadosDeInscripción_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EstadosDeInscripción"
    ADD CONSTRAINT "EstadosDeInscripción_pkey" PRIMARY KEY ("idEstadoInscripción");


--
-- Name: Estudiantes Estudiantes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Estudiantes"
    ADD CONSTRAINT "Estudiantes_pkey" PRIMARY KEY ("identificaciónUsuario");


--
-- Name: Facultades Facultades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Facultades"
    ADD CONSTRAINT "Facultades_pkey" PRIMARY KEY ("idFacultad");


--
-- Name: FotosPublicaciones FotosPublicaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FotosPublicaciones"
    ADD CONSTRAINT "FotosPublicaciones_pkey" PRIMARY KEY ("idArchivo");


--
-- Name: Grupos Grupos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupos"
    ADD CONSTRAINT "Grupos_pkey" PRIMARY KEY ("idGrupo");


--
-- Name: InscripcionesEnCursos InscripcionesEnCursos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnCursos"
    ADD CONSTRAINT "InscripcionesEnCursos_pkey" PRIMARY KEY ("idCurso", "identificaciónUsuario");


--
-- Name: InscripcionesEnGrupos InscripcionesEnGrupos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnGrupos"
    ADD CONSTRAINT "InscripcionesEnGrupos_pkey" PRIMARY KEY ("idGrupo", "identificaciónUsuario");


--
-- Name: Likes Likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Likes"
    ADD CONSTRAINT "Likes_pkey" PRIMARY KEY ("idPublicación", "identificaciónUsuario");


--
-- Name: NivelesB10 NivelesB10_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."NivelesB10"
    ADD CONSTRAINT "NivelesB10_pkey" PRIMARY KEY ("idNivel");


--
-- Name: Paises Paises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Paises"
    ADD CONSTRAINT "Paises_pkey" PRIMARY KEY ("idPaís");


--
-- Name: Programas Programas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Programas"
    ADD CONSTRAINT "Programas_pkey" PRIMARY KEY ("idPrograma");


--
-- Name: PublicacionesGrupales PublicacionesGrupales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PublicacionesGrupales"
    ADD CONSTRAINT "PublicacionesGrupales_pkey" PRIMARY KEY ("idGrupo", "idPublicación");


--
-- Name: Publicaciones Publicaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Publicaciones"
    ADD CONSTRAINT "Publicaciones_pkey" PRIMARY KEY ("idPublicación");


--
-- Name: SeccionesCursos SeccionesCursos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SeccionesCursos"
    ADD CONSTRAINT "SeccionesCursos_pkey" PRIMARY KEY ("idSecciónCurso");


--
-- Name: Seguidores Seguidores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seguidores"
    ADD CONSTRAINT "Seguidores_pkey" PRIMARY KEY ("identificaciónSeguidor", "identificaciónSeguido");


--
-- Name: TemasCursos TemasCursos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TemasCursos"
    ADD CONSTRAINT "TemasCursos_pkey" PRIMARY KEY ("idTema");


--
-- Name: TiposDeLike TiposDeLike_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TiposDeLike"
    ADD CONSTRAINT "TiposDeLike_pkey" PRIMARY KEY ("idTipoDeLike");


--
-- Name: TiposDePrivacidad TiposDePrivacidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TiposDePrivacidad"
    ADD CONSTRAINT "TiposDePrivacidad_pkey" PRIMARY KEY ("idTipoDePrivacidad");


--
-- Name: TiposDeUsuarios TiposDeUsuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TiposDeUsuarios"
    ADD CONSTRAINT "TiposDeUsuarios_pkey" PRIMARY KEY ("idTipoDeUsuario");


--
-- Name: Usuarios Usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT "Usuarios_pkey" PRIMARY KEY ("identificación");


--
-- Name: Álbumes Álbumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Álbumes"
    ADD CONSTRAINT "Álbumes_pkey" PRIMARY KEY ("idÁlbum");


--
-- Name: Administradores Administradores_idCargo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Administradores"
    ADD CONSTRAINT "Administradores_idCargo_fkey" FOREIGN KEY ("idCargo") REFERENCES public."Cargos"("idCargo") NOT VALID;


--
-- Name: Administradores Administradores_idDependencia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Administradores"
    ADD CONSTRAINT "Administradores_idDependencia_fkey" FOREIGN KEY ("idDependencia") REFERENCES public."Dependencias"("idDependencia") NOT VALID;


--
-- Name: Administradores Administradores_identificaciónUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Administradores"
    ADD CONSTRAINT "Administradores_identificaciónUsuario_fkey" FOREIGN KEY ("identificaciónUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: ArchivosPublicaciones ArchivosPublicaciones_idPublicación_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ArchivosPublicaciones"
    ADD CONSTRAINT "ArchivosPublicaciones_idPublicación_fkey" FOREIGN KEY ("idPublicación") REFERENCES public."Publicaciones"("idPublicación") NOT VALID;


--
-- Name: Comentarios Comentarios_IdentificaciónUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comentarios"
    ADD CONSTRAINT "Comentarios_IdentificaciónUsuario_fkey" FOREIGN KEY ("IdentificaciónUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: Comentarios Comentarios_idPublicación_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comentarios"
    ADD CONSTRAINT "Comentarios_idPublicación_fkey" FOREIGN KEY ("idPublicación") REFERENCES public."Publicaciones"("idPublicación") NOT VALID;


--
-- Name: Conexiones Conexiones_identificaciónUsuario1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Conexiones"
    ADD CONSTRAINT "Conexiones_identificaciónUsuario1_fkey" FOREIGN KEY ("identificaciónUsuario1") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: Conexiones Conexiones_identificaciónUsuario2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Conexiones"
    ADD CONSTRAINT "Conexiones_identificaciónUsuario2_fkey" FOREIGN KEY ("identificaciónUsuario2") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: Cursos Cursos_idCategoríaCurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cursos"
    ADD CONSTRAINT "Cursos_idCategoríaCurso_fkey" FOREIGN KEY ("idCategoríaCurso") REFERENCES public."CategoríasCursos"("idCategoríaCurso") NOT VALID;


--
-- Name: Estudiantes Estudiantes_idPrograma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Estudiantes"
    ADD CONSTRAINT "Estudiantes_idPrograma_fkey" FOREIGN KEY ("idPrograma") REFERENCES public."Programas"("idPrograma") NOT VALID;


--
-- Name: Estudiantes Estudiantes_identificaciónUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Estudiantes"
    ADD CONSTRAINT "Estudiantes_identificaciónUsuario_fkey" FOREIGN KEY ("identificaciónUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: FotosPublicaciones FotosPublicaciones_idArchivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FotosPublicaciones"
    ADD CONSTRAINT "FotosPublicaciones_idArchivo_fkey" FOREIGN KEY ("idArchivo") REFERENCES public."ArchivosPublicaciones"("idArchivo") NOT VALID;


--
-- Name: FotosPublicaciones FotosPublicaciones_idÁlbum_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FotosPublicaciones"
    ADD CONSTRAINT "FotosPublicaciones_idÁlbum_fkey" FOREIGN KEY ("idÁlbum") REFERENCES public."Álbumes"("idÁlbum") NOT VALID;


--
-- Name: Grupos Grupos_idPrivacidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupos"
    ADD CONSTRAINT "Grupos_idPrivacidad_fkey" FOREIGN KEY ("idPrivacidad") REFERENCES public."TiposDePrivacidad"("idTipoDePrivacidad") NOT VALID;


--
-- Name: InscripcionesEnCursos InscripcionesEnCursos_idCurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnCursos"
    ADD CONSTRAINT "InscripcionesEnCursos_idCurso_fkey" FOREIGN KEY ("idCurso") REFERENCES public."Cursos"("idCurso") NOT VALID;


--
-- Name: InscripcionesEnCursos InscripcionesEnCursos_idEstadoDeInscripción_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnCursos"
    ADD CONSTRAINT "InscripcionesEnCursos_idEstadoDeInscripción_fkey" FOREIGN KEY ("idEstadoDeInscripción") REFERENCES public."EstadosDeInscripción"("idEstadoInscripción") NOT VALID;


--
-- Name: InscripcionesEnCursos InscripcionesEnCursos_identificaciónUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnCursos"
    ADD CONSTRAINT "InscripcionesEnCursos_identificaciónUsuario_fkey" FOREIGN KEY ("identificaciónUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: InscripcionesEnGrupos InscripcionesEnGrupos_idGrupo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnGrupos"
    ADD CONSTRAINT "InscripcionesEnGrupos_idGrupo_fkey" FOREIGN KEY ("idGrupo") REFERENCES public."Grupos"("idGrupo") NOT VALID;


--
-- Name: InscripcionesEnGrupos InscripcionesEnGrupos_identificaciónUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnGrupos"
    ADD CONSTRAINT "InscripcionesEnGrupos_identificaciónUsuario_fkey" FOREIGN KEY ("identificaciónUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: Likes Likes_idPublicación_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Likes"
    ADD CONSTRAINT "Likes_idPublicación_fkey" FOREIGN KEY ("idPublicación") REFERENCES public."Publicaciones"("idPublicación") NOT VALID;


--
-- Name: Likes Likes_idTipoDeLike_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Likes"
    ADD CONSTRAINT "Likes_idTipoDeLike_fkey" FOREIGN KEY ("idTipoDeLike") REFERENCES public."TiposDeLike"("idTipoDeLike") NOT VALID;


--
-- Name: Likes Likes_identificaciónUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Likes"
    ADD CONSTRAINT "Likes_identificaciónUsuario_fkey" FOREIGN KEY ("identificaciónUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: Programas Programas_idFacultad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Programas"
    ADD CONSTRAINT "Programas_idFacultad_fkey" FOREIGN KEY ("idFacultad") REFERENCES public."Facultades"("idFacultad") NOT VALID;


--
-- Name: PublicacionesGrupales PublicacionesGrupales_idGrupo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PublicacionesGrupales"
    ADD CONSTRAINT "PublicacionesGrupales_idGrupo_fkey" FOREIGN KEY ("idGrupo") REFERENCES public."Grupos"("idGrupo") NOT VALID;


--
-- Name: PublicacionesGrupales PublicacionesGrupales_idPublicación_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PublicacionesGrupales"
    ADD CONSTRAINT "PublicacionesGrupales_idPublicación_fkey" FOREIGN KEY ("idPublicación") REFERENCES public."Publicaciones"("idPublicación") NOT VALID;


--
-- Name: Publicaciones Publicaciones_idTipoDePrivacidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Publicaciones"
    ADD CONSTRAINT "Publicaciones_idTipoDePrivacidad_fkey" FOREIGN KEY ("idTipoDePrivacidad") REFERENCES public."TiposDePrivacidad"("idTipoDePrivacidad") NOT VALID;


--
-- Name: Publicaciones Publicaciones_identificaciónUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Publicaciones"
    ADD CONSTRAINT "Publicaciones_identificaciónUsuario_fkey" FOREIGN KEY ("identificaciónUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: SeccionesCursos SeccionesCursos_idCurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SeccionesCursos"
    ADD CONSTRAINT "SeccionesCursos_idCurso_fkey" FOREIGN KEY ("idCurso") REFERENCES public."Cursos"("idCurso") NOT VALID;


--
-- Name: Seguidores Seguidores_identificaciónSeguido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seguidores"
    ADD CONSTRAINT "Seguidores_identificaciónSeguido_fkey" FOREIGN KEY ("identificaciónSeguido") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: Seguidores Seguidores_identificaciónSeguidor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seguidores"
    ADD CONSTRAINT "Seguidores_identificaciónSeguidor_fkey" FOREIGN KEY ("identificaciónSeguidor") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: TemasCursos TemasCursos_idSección_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TemasCursos"
    ADD CONSTRAINT "TemasCursos_idSección_fkey" FOREIGN KEY ("idSección") REFERENCES public."SeccionesCursos"("idSecciónCurso") NOT VALID;


--
-- Name: Usuarios Usuarios_idNivel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT "Usuarios_idNivel_fkey" FOREIGN KEY ("idNivel") REFERENCES public."NivelesB10"("idNivel") NOT VALID;


--
-- Name: Usuarios Usuarios_idPaís_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT "Usuarios_idPaís_fkey" FOREIGN KEY ("idPaís") REFERENCES public."Paises"("idPaís") NOT VALID;


--
-- Name: Usuarios Usuarios_idTipoDeUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT "Usuarios_idTipoDeUsuario_fkey" FOREIGN KEY ("idTipoDeUsuario") REFERENCES public."TiposDeUsuarios"("idTipoDeUsuario") NOT VALID;


--
-- Name: Álbumes Álbumes_identificaciónUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Álbumes"
    ADD CONSTRAINT "Álbumes_identificaciónUsuario_fkey" FOREIGN KEY ("identificaciónUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- PostgreSQL database dump complete
--

