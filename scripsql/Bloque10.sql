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

--
-- Name: busquedacomentario(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.busquedacomentario(fecha1 date) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
coment varchar(100);
BEGIN
coment:= (SELECT "comentario" FROM "comentarios"
WHERE "fecha" = "fecha1");
return coment;
END;
$$;


ALTER FUNCTION public.busquedacomentario(fecha1 date) OWNER TO postgres;

--
-- Name: conexionesusuarios(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.conexionesusuarios(idusuario integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
numConexiones bigint;
BEGIN
numConexiones:= (SELECT  COUNT(*)  
				 FROM "Conexiones"
				 WHERE "identificaciónUsuario1" = idUsuario
				 GROUP BY "identificaciónUsuario1"); 
return numConexiones;
END;
$$;


ALTER FUNCTION public.conexionesusuarios(idusuario integer) OWNER TO postgres;

--
-- Name: eliminarestudiante(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.eliminarestudiante(identificacion integer)
    LANGUAGE plpgsql
    AS $$



BEGIN
RAISE NOTICE 'eliminando usuario';
DELETE FROM "Usuarios" WHERE "identificación" = identificación;
RAISE NOTICE 'eliminando estudiante';
DELETE FROM "Estudiantes" WHERE "identificaciónUsuario" = identificación;



END
$$;


ALTER PROCEDURE public.eliminarestudiante(identificacion integer) OWNER TO postgres;

--
-- Name: eliminarpost(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.eliminarpost(idpost integer)
    LANGUAGE plpgsql
    AS $$



BEGIN
RAISE NOTICE 'eliminando Post';
DELETE FROM "Post" WHERE "idPost" = idPost;
RAISE NOTICE 'eliminando EtiquetasAsignadas';
DELETE FROM "EtiquetasAsignadas" WHERE "idPost" = idPost;



END
$$;


ALTER PROCEDURE public.eliminarpost(idpost integer) OWNER TO postgres;

--
-- Name: facultad(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.facultad(idestudiante integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
nombreFacultad varchar(100);
BEGIN
nombreFacultad:= (SELECT "nombre" FROM 
					 "Facultades"
					 WHERE "idFacultad" = (SELECT "idFacultad" FROM 
											 "Programas" WHERE "idPrograma" =  (select "idPrograma" from "Estudiantes"
																				WHERE "identificaciónUsuario" = idEstudiante))); 
return nombreFacultad;
END;
$$;


ALTER FUNCTION public.facultad(idestudiante integer) OWNER TO postgres;

--
-- Name: insertarcurso(integer, character varying, character varying, integer, character varying, integer, integer, character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insertarcurso("idCurso" integer, nombre character varying, "descripción" character varying, costo integer, certificado character varying, "idCategoríaCurso" integer, "identificaciónUsuario" integer, "fechaDeIngreso" character varying, "idEstadoDeInscripción" integer)
    LANGUAGE plpgsql
    AS $$



BEGIN
RAISE NOTICE 'Insertando cursos';
INSERT INTO "Cursos" values ("idCurso",nombre ,"descripción",costo,certificado,"idCategoríaCurso" );
insert into "InscripcionesEnCursos" values ("identificaciónUsuario" ,"fechaDeIngreso","idEstadoDeInscripción") ;

END
$$;


ALTER PROCEDURE public.insertarcurso("idCurso" integer, nombre character varying, "descripción" character varying, costo integer, certificado character varying, "idCategoríaCurso" integer, "identificaciónUsuario" integer, "fechaDeIngreso" character varying, "idEstadoDeInscripción" integer) OWNER TO postgres;

--
-- Name: insertarcursocompleto(integer, character varying, character varying, integer, character varying, integer, integer, character varying, integer, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insertarcursocompleto("idCurso" integer, nombre character varying, "descripción" character varying, costo integer, certificado character varying, "idCategoríaCurso" integer, "idSecciónCurso" integer, "nombreSecciónCurso" character varying, "idTema" integer, "nombreTemaCurso" character varying, url character varying)
    LANGUAGE plpgsql
    AS $$



BEGIN
RAISE NOTICE 'Insertando curso';
INSERT INTO "Cursos" values ("idCurso",nombre ,"descripción",costo,certificado,"idCategoríaCurso");
RAISE NOTICE 'Insertando secion ';
INSERT INTO "Cursos" values ("idSecciónCurso" ,"nombreSecciónCurso");
RAISE NOTICE 'Insertando tema ';
INSERT INTO "TemasCursos" values ("idTema","nombreTemaCurso","descripción" ,url);
END
$$;


ALTER PROCEDURE public.insertarcursocompleto("idCurso" integer, nombre character varying, "descripción" character varying, costo integer, certificado character varying, "idCategoríaCurso" integer, "idSecciónCurso" integer, "nombreSecciónCurso" character varying, "idTema" integer, "nombreTemaCurso" character varying, url character varying) OWNER TO postgres;

--
-- Name: insertarestudiante(integer, character varying, character varying, character varying, character varying, character varying, character varying, text, date, integer, integer, integer, integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insertarestudiante(identificacion integer, primernombre character varying, segundonombre character varying, primerapellido character varying, segundoapellido character varying, email character varying, contra character varying, biografia text, fechaderegistro date, idpais integer, idtipodeusuario integer, idnivel integer, idfotodeperfil integer, idfotodeportada integer, idprograma integer)
    LANGUAGE plpgsql
    AS $$

BEGIN
RAISE NOTICE 'Insertando usuario';
INSERT INTO "Usuarios" VALUES(identificacion,primerNombre,segundoNombre,primerApellido,
segundoApellido, email ,contra, biografia, fechaDeRegistro ,
idPais , idTipoDeUsuario , idNivel ,idFotoDePerfil ,idFotoDePortada);
RAISE NOTICE 'Insertando estudiante';
INSERT INTO "Estudiantes" VALUES(identificacion,idPrograma);
RAISE NOTICE 'Estudiante insertado con éxito';
END
$$;


ALTER PROCEDURE public.insertarestudiante(identificacion integer, primernombre character varying, segundonombre character varying, primerapellido character varying, segundoapellido character varying, email character varying, contra character varying, biografia text, fechaderegistro date, idpais integer, idtipodeusuario integer, idnivel integer, idfotodeperfil integer, idfotodeportada integer, idprograma integer) OWNER TO postgres;

--
-- Name: insertargrupo(integer, character varying, text, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insertargrupo(idgrupo integer, nombregrupo character varying, "descripción" text, idprivacidad integer, idusuariocreador integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
privacidad "TiposDePrivacidad"%rowType;
creador "Usuarios"%rowType;
BEGIN
	RAISE NOTICE 'Verficando la existencia del creador del grupo';
	SELECT * INTO creador
	FROM "Usuarios"
	WHERE "identificación" = idUsuarioCreador;
	
	IF creador."identificación" IS NOT NULL THEN	
			RAISE NOTICE 'Asignando la privacidad al grupo';
			SELECT * INTO privacidad
			FROM "TiposDePrivacidad"
			WHERE "idTipoDePrivacidad" = idPrivacidad;
			IF privacidad."idTipoDePrivacidad" IS NOT NULL THEN		
					INSERT INTO "Grupos"
					VALUES(idGrupo,nombreGrupo,descripción,idPrivacidad,idUsuarioCreador);
					INSERT INTO "InscripcionesEnGrupos"
					VALUES(idGrupo,idUsuarioCreador);
					RAISE NOTICE 'El grupo se ha insertado correctamente';	
			ELSE
				RAISE NOTICE 'La privacidad que ha elegido no está disponible en la base de datos';	
		    END IF;
	ELSE
		RAISE NOTICE 'El usuario que ha indicado como creador no se encuentra registrado en la base de datos';
	END IF;
END
$$;


ALTER PROCEDURE public.insertargrupo(idgrupo integer, nombregrupo character varying, "descripción" text, idprivacidad integer, idusuariocreador integer) OWNER TO postgres;

--
-- Name: insertarpost(integer, character varying, character varying, date, text, integer, integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insertarpost(idpost integer, titulo character varying, contenido character varying, fechacreacion date, imgdest text, idusuario integer, idetiqueta integer, nombreetiqueta character varying)
    LANGUAGE plpgsql
    AS $$



BEGIN
RAISE NOTICE 'Creando Post';

INSERT INTO Post values(idPost, titulo, contenido, fechaCreacion, imgDest,idUsuario);



RAISE NOTICE 'Insertando Etiqueta';

INSERT INTO Etiquetas values(idEtiqueta, nombreEtiqueta,idUsuario);

INSERT INTO etiquetasignadas values(idPost, idEtiqueta);



END
$$;


ALTER PROCEDURE public.insertarpost(idpost integer, titulo character varying, contenido character varying, fechacreacion date, imgdest text, idusuario integer, idetiqueta integer, nombreetiqueta character varying) OWNER TO postgres;

--
-- Name: likespublicaciones(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.likespublicaciones(idpublicacion1 integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
numLikes bigint;
BEGIN
numLikes:= (SELECT COUNT(*)
FROM "Likes"
WHERE "idPublicación" = idPublicacion1
GROUP BY "idPublicación");
return numLikes;
END;
$$;


ALTER FUNCTION public.likespublicaciones(idpublicacion1 integer) OWNER TO postgres;

--
-- Name: seccionc(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.seccionc(idtema integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
secciontem varchar(100);
BEGIN
secciontem:= (SELECT "nombreSecciónCurso" FROM
"SeccionesCursos"
WHERE "idSecciónCurso" = (SELECT "idSección" FROM "TemasCursos" WHERE "idTema" = idTema));

return secciontem;
END;
$$;


ALTER FUNCTION public.seccionc(idtema integer) OWNER TO postgres;

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
    "idCategoríaCurso" integer NOT NULL,
    "fechaDePublicacion" date
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
-- Name: categoriasignadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoriasignadas (
    "idPost" integer NOT NULL,
    "idCategoria" integer NOT NULL
);


ALTER TABLE public.categoriasignadas OWNER TO postgres;

--
-- Name: Estadisticas de las Categorias.; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Estadisticas de las Categorias." AS
 SELECT categoriasignadas."idCategoria" AS "Número de Identificación de las Categorias",
    count(categoriasignadas."idCategoria") AS "cantidad de usos de las Categorias"
   FROM public.categoriasignadas
  GROUP BY categoriasignadas."idCategoria"
  ORDER BY categoriasignadas."idCategoria";


ALTER TABLE public."Estadisticas de las Categorias." OWNER TO postgres;

--
-- Name: VisitasPost; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VisitasPost" (
    "idPost" integer NOT NULL,
    "idUsuario" integer NOT NULL,
    "idVisitaPost" integer NOT NULL
);


ALTER TABLE public."VisitasPost" OWNER TO postgres;

--
-- Name: Estadisticas del Post.; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Estadisticas del Post." AS
 SELECT "VisitasPost"."idPost" AS "Número de Identificación de los Post",
    count("VisitasPost"."idPost") AS "cantidad de Visitas al Post"
   FROM public."VisitasPost"
  GROUP BY "VisitasPost"."idPost"
  ORDER BY (count("VisitasPost"."idPost")) DESC;


ALTER TABLE public."Estadisticas del Post." OWNER TO postgres;

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
    "idPrivacidad" integer NOT NULL,
    "idUsuarioCreador" integer
);


ALTER TABLE public."Grupos" OWNER TO postgres;

--
-- Name: InscripcionesEnGrupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InscripcionesEnGrupos" (
    "idGrupo" integer NOT NULL,
    "identificaciónUsuario" integer NOT NULL
);


ALTER TABLE public."InscripcionesEnGrupos" OWNER TO postgres;

--
-- Name: Grupos Populares; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Grupos Populares" AS
 SELECT "Grupos"."idGrupo" AS "Identificación del grupo",
    "Grupos"."nombreGrupo" AS "Nombre del grupo",
    count(*) AS "Número de inscritos",
    dense_rank() OVER (ORDER BY (count("Grupos"."idGrupo")) DESC) AS "Puesto"
   FROM (public."Grupos"
     LEFT JOIN public."InscripcionesEnGrupos" ON (("Grupos"."idGrupo" = "InscripcionesEnGrupos"."idGrupo")))
  GROUP BY "Grupos"."idGrupo", "Grupos"."nombreGrupo"
  ORDER BY "Grupos"."idGrupo";


ALTER TABLE public."Grupos Populares" OWNER TO postgres;

--
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    "idPost" integer NOT NULL,
    titulo character varying(200) NOT NULL,
    contenido text NOT NULL,
    "fechaCreacion" date NOT NULL,
    "imgDest" text NOT NULL,
    "idUsuario" integer NOT NULL
);


ALTER TABLE public.post OWNER TO postgres;

--
-- Name: Información de los Post.; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Información de los Post." AS
 SELECT post."fechaCreacion" AS "Fecha de creación",
    post.titulo AS "Título del Post",
    post.contenido AS "Contenido del Post"
   FROM public.post;


ALTER TABLE public."Información de los Post." OWNER TO postgres;

--
-- Name: InscripcionesEnCursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InscripcionesEnCursos" (
    "identificaciónUsuario" integer NOT NULL,
    "idCurso" integer NOT NULL,
    "fechaDeIngreso" date NOT NULL,
    "idEstadoDeInscripción" integer NOT NULL
);


ALTER TABLE public."InscripcionesEnCursos" OWNER TO postgres;

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
-- Name: PublicacionesMarzoJulioPorAntropologos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."PublicacionesMarzoJulioPorAntropologos" AS
 SELECT "Publicaciones"."idPublicación" AS "Identificador",
    "Publicaciones"."fechaDePublicación"
   FROM public."Publicaciones"
  WHERE ((date_part('month'::text, "Publicaciones"."fechaDePublicación") = ANY (ARRAY['3'::double precision, '4'::double precision, '5'::double precision, '6'::double precision, '7'::double precision])) AND ("Publicaciones"."identificaciónUsuario" IN ( SELECT "Usuarios"."identificación"
           FROM (public."Estudiantes"
             JOIN public."Usuarios" ON (("Estudiantes"."identificaciónUsuario" = "Usuarios"."identificación")))
          WHERE (("Usuarios"."idNivel" = ( SELECT "NivelesB10"."idNivel"
                   FROM public."NivelesB10"
                  WHERE (("NivelesB10".nombre)::text = 'Integrador'::text))) AND ("Estudiantes"."idPrograma" = 4)))));


ALTER TABLE public."PublicacionesMarzoJulioPorAntropologos" OWNER TO postgres;

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
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    "idCategoria" integer NOT NULL,
    "nombreCategoria" character varying NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- Name: comentarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentarios (
    "idComentario" integer NOT NULL,
    "identificaciónUsuario" integer NOT NULL,
    "idPublicación" integer NOT NULL,
    fecha date NOT NULL,
    comentario text NOT NULL
);


ALTER TABLE public.comentarios OWNER TO postgres;

--
-- Name: cursosdeingenieria; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.cursosdeingenieria AS
 SELECT "Cursos".nombre AS "Curso",
    "Cursos"."descripción" AS "Descripción",
    "Cursos".costo,
    "Cursos".certificado,
    "CategoríasCursos"."nombreCategoríaCurso" AS "Categoría",
    "Cursos"."fechaDePublicacion" AS "Fecha de publicación"
   FROM (public."Cursos"
     JOIN public."CategoríasCursos" ON (("Cursos"."idCategoríaCurso" = "CategoríasCursos"."idCategoríaCurso")))
  WHERE (("CategoríasCursos"."nombreCategoríaCurso")::text = 'ingenieria'::text);


ALTER TABLE public.cursosdeingenieria OWNER TO postgres;

--
-- Name: cursosfinalizados; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.cursosfinalizados AS
 SELECT count(*) AS "cantidad de estudiantes que termiaron un curso"
   FROM (public."InscripcionesEnCursos"
     JOIN public."EstadosDeInscripción" ON (("EstadosDeInscripción"."idEstadoInscripción" = "InscripcionesEnCursos"."idEstadoDeInscripción")))
  WHERE ("EstadosDeInscripción"."idEstadoInscripción" = 13);


ALTER TABLE public.cursosfinalizados OWNER TO postgres;

--
-- Name: datos_calculodiferencial; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.datos_calculodiferencial AS
 SELECT "Usuarios"."primerNombre",
    "Usuarios"."primerApellido"
   FROM public."Usuarios"
  WHERE ("Usuarios"."identificación" = ( SELECT "InscripcionesEnCursos"."identificaciónUsuario"
           FROM public."InscripcionesEnCursos"
          WHERE ("InscripcionesEnCursos"."idCurso" = ( SELECT "Cursos"."idCurso"
                   FROM public."Cursos"
                  WHERE ("Cursos"."idCurso" = 50)))));


ALTER TABLE public.datos_calculodiferencial OWNER TO postgres;

--
-- Name: datosinscripcion; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.datosinscripcion AS
 SELECT "Cursos".nombre,
    "InscripcionesEnCursos"."fechaDeIngreso",
    "Usuarios"."primerNombre",
    "Usuarios"."primerApellido"
   FROM ((public."InscripcionesEnCursos"
     JOIN public."Usuarios" ON (("InscripcionesEnCursos"."identificaciónUsuario" = "Usuarios"."identificación")))
     JOIN public."Cursos" ON (("Cursos"."idCurso" = "InscripcionesEnCursos"."idCurso")))
  ORDER BY "InscripcionesEnCursos"."fechaDeIngreso";


ALTER TABLE public.datosinscripcion OWNER TO postgres;

--
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado (
    "idEstado" integer NOT NULL,
    "idPost" integer NOT NULL,
    "situación" text NOT NULL
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- Name: etiquetas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etiquetas (
    "idEtiqueta" integer NOT NULL,
    "nombreEtiqueta" character varying NOT NULL,
    "idUsuario" integer NOT NULL
);


ALTER TABLE public.etiquetas OWNER TO postgres;

--
-- Name: etiquetasignadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etiquetasignadas (
    "idPost" integer NOT NULL,
    "idEtiqueta" integer NOT NULL
);


ALTER TABLE public.etiquetasignadas OWNER TO postgres;

--
-- Name: innovadores; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.innovadores AS
 SELECT "Usuarios"."identificación",
    concat("Usuarios"."primerNombre", ' ', "Usuarios"."primerApellido") AS "Nombre y apellido",
    "Usuarios".email
   FROM (public."Usuarios"
     JOIN public."NivelesB10" ON (("Usuarios"."idNivel" = "NivelesB10"."idNivel")))
  WHERE ((("NivelesB10".nombre)::text = 'Explorador'::text) AND (date_part('year'::text, "Usuarios"."fechaDeRegistro") < date_part('year'::text, now())));


ALTER TABLE public.innovadores OWNER TO postgres;

--
-- Name: publicacionerecientes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.publicacionerecientes AS
 SELECT "Cursos"."idCurso",
    "Cursos".nombre,
    "Cursos"."descripción",
    "Cursos".costo,
    "Cursos".certificado,
    "Cursos"."idCategoríaCurso",
    "Cursos"."fechaDePublicacion"
   FROM public."Cursos"
  WHERE (("Cursos"."fechaDePublicacion" >= ((to_char(now(), 'YYYY-MM-DD'::text))::date - 7)) AND ("Cursos"."fechaDePublicacion" <= (to_char(now(), 'YYYY-MM-DD'::text))::date));


ALTER TABLE public.publicacionerecientes OWNER TO postgres;

--
-- Name: publicacionesPost; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."publicacionesPost" (
    "idPost" integer NOT NULL,
    "idPublicación" integer NOT NULL
);


ALTER TABLE public."publicacionesPost" OWNER TO postgres;

--
-- Name: tipodelikemasusado; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.tipodelikemasusado AS
 SELECT "TiposDeLike"."nombreTipoDeLike" AS "Tipo de like",
    "CantidadTipoDeLike"."Cantidad de usos"
   FROM (( SELECT "Likes"."idTipoDeLike" AS "id tipo de like",
            count(*) AS "Cantidad de usos",
            dense_rank() OVER (ORDER BY (count(*)) DESC) AS "Puesto"
           FROM public."Likes"
          GROUP BY "Likes"."idTipoDeLike"
          ORDER BY (count(*)) DESC) "CantidadTipoDeLike"
     JOIN public."TiposDeLike" ON (("CantidadTipoDeLike"."id tipo de like" = "TiposDeLike"."idTipoDeLike")))
  WHERE ("CantidadTipoDeLike"."Puesto" = 1);


ALTER TABLE public.tipodelikemasusado OWNER TO postgres;

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

INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (1, 'nombre del archivo número 1', 'URL número 1', 1);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (2, 'nombre del archivo número 2', 'URL número 2', 2);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (3, 'nombre del archivo número 3', 'URL número 3', 3);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (4, 'nombre del archivo número 4', 'URL número 4', 4);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (5, 'nombre del archivo número 5', 'URL número 5', 5);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (6, 'nombre del archivo número 6', 'URL número 6', 6);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (7, 'nombre del archivo número 7', 'URL número 7', 7);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (8, 'nombre del archivo número 8', 'URL número 8', 8);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (9, 'nombre del archivo número 9', 'URL número 9', 9);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (10, 'nombre del archivo número 10', 'URL número 10', 10);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (11, 'nombre del archivo número 11', 'URL número 11', 11);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (12, 'nombre del archivo número 12', 'URL número 12', 12);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (13, 'nombre del archivo número 13', 'URL número 13', 13);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (14, 'nombre del archivo número 14', 'URL número 14', 14);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (15, 'nombre del archivo número 15', 'URL número 15', 15);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (16, 'nombre del archivo número 16', 'URL número 16', 16);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (17, 'nombre del archivo número 17', 'URL número 17', 17);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (18, 'nombre del archivo número 18', 'URL número 18', 18);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (19, 'nombre del archivo número 19', 'URL número 19', 19);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (20, 'nombre del archivo número 20', 'URL número 20', 20);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (21, 'nombre del archivo número 21', 'URL número 21', 21);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (22, 'nombre del archivo número 22', 'URL número 22', 22);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (23, 'nombre del archivo número 23', 'URL número 23', 23);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (24, 'nombre del archivo número 24', 'URL número 24', 24);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (25, 'nombre del archivo número 25', 'URL número 25', 25);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (26, 'nombre del archivo número 26', 'URL número 26', 26);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (27, 'nombre del archivo número 27', 'URL número 27', 27);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (28, 'nombre del archivo número 28', 'URL número 28', 28);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (29, 'nombre del archivo número 29', 'URL número 29', 29);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (30, 'nombre del archivo número 30', 'URL número 30', 30);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (31, 'nombre del archivo número 31', 'URL número 31', 31);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (32, 'nombre del archivo número 32', 'URL número 32', 32);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (33, 'nombre del archivo número 33', 'URL número 33', 33);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (34, 'nombre del archivo número 34', 'URL número 34', 34);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (35, 'nombre del archivo número 35', 'URL número 35', 35);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (36, 'nombre del archivo número 36', 'URL número 36', 36);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (37, 'nombre del archivo número 37', 'URL número 37', 37);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (38, 'nombre del archivo número 38', 'URL número 38', 38);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (39, 'nombre del archivo número 39', 'URL número 39', 39);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (40, 'nombre del archivo número 40', 'URL número 40', 40);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (41, 'nombre del archivo número 41', 'URL número 41', 41);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (42, 'nombre del archivo número 42', 'URL número 42', 42);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (43, 'nombre del archivo número 43', 'URL número 43', 43);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (44, 'nombre del archivo número 44', 'URL número 44', 44);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (45, 'nombre del archivo número 45', 'URL número 45', 45);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (46, 'nombre del archivo número 46', 'URL número 46', 46);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (47, 'nombre del archivo número 47', 'URL número 47', 47);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (48, 'nombre del archivo número 48', 'URL número 48', 48);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (49, 'nombre del archivo número 49', 'URL número 49', 49);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (50, 'nombre del archivo número 50', 'URL número 50', 50);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (51, 'nombre del archivo número 51', 'URL número 51', 51);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (52, 'nombre del archivo número 52', 'URL número 52', 52);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (53, 'nombre del archivo número 53', 'URL número 53', 53);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (54, 'nombre del archivo número 54', 'URL número 54', 54);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (55, 'nombre del archivo número 55', 'URL número 55', 55);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (56, 'nombre del archivo número 56', 'URL número 56', 56);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (57, 'nombre del archivo número 57', 'URL número 57', 57);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (58, 'nombre del archivo número 58', 'URL número 58', 58);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (59, 'nombre del archivo número 59', 'URL número 59', 59);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (60, 'nombre del archivo número 60', 'URL número 60', 60);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (61, 'nombre del archivo número 61', 'URL número 61', 61);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (62, 'nombre del archivo número 62', 'URL número 62', 62);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (63, 'nombre del archivo número 63', 'URL número 63', 63);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (64, 'nombre del archivo número 64', 'URL número 64', 64);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (65, 'nombre del archivo número 65', 'URL número 65', 65);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (66, 'nombre del archivo número 66', 'URL número 66', 66);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (67, 'nombre del archivo número 67', 'URL número 67', 67);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (68, 'nombre del archivo número 68', 'URL número 68', 68);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (69, 'nombre del archivo número 69', 'URL número 69', 69);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (70, 'nombre del archivo número 70', 'URL número 70', 70);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (71, 'nombre del archivo número 71', 'URL número 71', 71);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (72, 'nombre del archivo número 72', 'URL número 72', 72);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (73, 'nombre del archivo número 73', 'URL número 73', 73);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (74, 'nombre del archivo número 74', 'URL número 74', 74);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (75, 'nombre del archivo número 75', 'URL número 75', 75);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (76, 'nombre del archivo número 76', 'URL número 76', 76);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (77, 'nombre del archivo número 77', 'URL número 77', 77);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (78, 'nombre del archivo número 78', 'URL número 78', 78);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (79, 'nombre del archivo número 79', 'URL número 79', 79);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (80, 'nombre del archivo número 80', 'URL número 80', 80);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (81, 'nombre del archivo número 81', 'URL número 81', 81);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (82, 'nombre del archivo número 82', 'URL número 82', 82);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (83, 'nombre del archivo número 83', 'URL número 83', 83);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (84, 'nombre del archivo número 84', 'URL número 84', 84);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (85, 'nombre del archivo número 85', 'URL número 85', 85);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (86, 'nombre del archivo número 86', 'URL número 86', 86);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (87, 'nombre del archivo número 87', 'URL número 87', 87);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (88, 'nombre del archivo número 88', 'URL número 88', 88);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (89, 'nombre del archivo número 89', 'URL número 89', 89);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (90, 'nombre del archivo número 90', 'URL número 90', 90);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (91, 'nombre del archivo número 91', 'URL número 91', 91);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (92, 'nombre del archivo número 92', 'URL número 92', 92);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (93, 'nombre del archivo número 93', 'URL número 93', 93);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (94, 'nombre del archivo número 94', 'URL número 94', 94);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (95, 'nombre del archivo número 95', 'URL número 95', 95);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (96, 'nombre del archivo número 96', 'URL número 96', 96);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (97, 'nombre del archivo número 97', 'URL número 97', 97);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (98, 'nombre del archivo número 98', 'URL número 98', 98);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (99, 'nombre del archivo número 99', 'URL número 99', 99);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (100, 'nombre del archivo número 100', 'URL número 100', 100);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (101, 'nombre del archivo número 101', 'URL número 101', 101);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (102, 'nombre del archivo número 102', 'URL número 102', 102);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (103, 'nombre del archivo número 103', 'URL número 103', 103);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (104, 'nombre del archivo número 104', 'URL número 104', 104);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (105, 'nombre del archivo número 105', 'URL número 105', 105);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (106, 'nombre del archivo número 106', 'URL número 106', 106);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (107, 'nombre del archivo número 107', 'URL número 107', 107);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (108, 'nombre del archivo número 108', 'URL número 108', 108);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (109, 'nombre del archivo número 109', 'URL número 109', 109);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (110, 'nombre del archivo número 110', 'URL número 110', 110);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (111, 'nombre del archivo número 111', 'URL número 111', 111);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (112, 'nombre del archivo número 112', 'URL número 112', 112);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (113, 'nombre del archivo número 113', 'URL número 113', 113);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (114, 'nombre del archivo número 114', 'URL número 114', 114);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (115, 'nombre del archivo número 115', 'URL número 115', 115);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (116, 'nombre del archivo número 116', 'URL número 116', 116);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (117, 'nombre del archivo número 117', 'URL número 117', 117);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (118, 'nombre del archivo número 118', 'URL número 118', 118);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (119, 'nombre del archivo número 119', 'URL número 119', 119);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (120, 'nombre del archivo número 120', 'URL número 120', 120);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (121, 'nombre del archivo número 121', 'URL número 121', 121);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (122, 'nombre del archivo número 122', 'URL número 122', 122);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (123, 'nombre del archivo número 123', 'URL número 123', 123);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (124, 'nombre del archivo número 124', 'URL número 124', 124);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (125, 'nombre del archivo número 125', 'URL número 125', 125);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (126, 'nombre del archivo número 126', 'URL número 126', 126);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (127, 'nombre del archivo número 127', 'URL número 127', 127);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (128, 'nombre del archivo número 128', 'URL número 128', 128);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (129, 'nombre del archivo número 129', 'URL número 129', 129);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (130, 'nombre del archivo número 130', 'URL número 130', 130);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (131, 'nombre del archivo número 131', 'URL número 131', 131);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (132, 'nombre del archivo número 132', 'URL número 132', 132);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (133, 'nombre del archivo número 133', 'URL número 133', 133);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (134, 'nombre del archivo número 134', 'URL número 134', 134);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (135, 'nombre del archivo número 135', 'URL número 135', 135);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (136, 'nombre del archivo número 136', 'URL número 136', 136);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (137, 'nombre del archivo número 137', 'URL número 137', 137);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (138, 'nombre del archivo número 138', 'URL número 138', 138);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (139, 'nombre del archivo número 139', 'URL número 139', 139);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (140, 'nombre del archivo número 140', 'URL número 140', 140);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (141, 'nombre del archivo número 141', 'URL número 141', 141);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (142, 'nombre del archivo número 142', 'URL número 142', 142);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (143, 'nombre del archivo número 143', 'URL número 143', 143);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (144, 'nombre del archivo número 144', 'URL número 144', 144);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (145, 'nombre del archivo número 145', 'URL número 145', 145);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (146, 'nombre del archivo número 146', 'URL número 146', 146);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (147, 'nombre del archivo número 147', 'URL número 147', 147);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (148, 'nombre del archivo número 148', 'URL número 148', 148);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (149, 'nombre del archivo número 149', 'URL número 149', 149);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (150, 'nombre del archivo número 150', 'URL número 150', 150);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (151, 'nombre del archivo número 151', 'URL número 151', 151);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (152, 'nombre del archivo número 152', 'URL número 152', 152);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (153, 'nombre del archivo número 153', 'URL número 153', 153);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (154, 'nombre del archivo número 154', 'URL número 154', 154);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (155, 'nombre del archivo número 155', 'URL número 155', 155);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (156, 'nombre del archivo número 156', 'URL número 156', 156);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (157, 'nombre del archivo número 157', 'URL número 157', 157);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (158, 'nombre del archivo número 158', 'URL número 158', 158);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (159, 'nombre del archivo número 159', 'URL número 159', 159);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (160, 'nombre del archivo número 160', 'URL número 160', 160);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (161, 'nombre del archivo número 161', 'URL número 161', 161);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (162, 'nombre del archivo número 162', 'URL número 162', 162);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (163, 'nombre del archivo número 163', 'URL número 163', 163);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (164, 'nombre del archivo número 164', 'URL número 164', 164);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (165, 'nombre del archivo número 165', 'URL número 165', 165);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (166, 'nombre del archivo número 166', 'URL número 166', 166);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (167, 'nombre del archivo número 167', 'URL número 167', 167);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (168, 'nombre del archivo número 168', 'URL número 168', 168);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (169, 'nombre del archivo número 169', 'URL número 169', 169);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (170, 'nombre del archivo número 170', 'URL número 170', 170);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (171, 'nombre del archivo número 171', 'URL número 171', 171);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (172, 'nombre del archivo número 172', 'URL número 172', 172);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (173, 'nombre del archivo número 173', 'URL número 173', 173);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (174, 'nombre del archivo número 174', 'URL número 174', 174);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (175, 'nombre del archivo número 175', 'URL número 175', 175);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (176, 'nombre del archivo número 176', 'URL número 176', 176);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (177, 'nombre del archivo número 177', 'URL número 177', 177);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (178, 'nombre del archivo número 178', 'URL número 178', 178);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (179, 'nombre del archivo número 179', 'URL número 179', 179);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (180, 'nombre del archivo número 180', 'URL número 180', 180);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (181, 'nombre del archivo número 181', 'URL número 181', 181);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (182, 'nombre del archivo número 182', 'URL número 182', 182);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (183, 'nombre del archivo número 183', 'URL número 183', 183);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (184, 'nombre del archivo número 184', 'URL número 184', 184);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (185, 'nombre del archivo número 185', 'URL número 185', 185);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (186, 'nombre del archivo número 186', 'URL número 186', 186);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (187, 'nombre del archivo número 187', 'URL número 187', 187);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (188, 'nombre del archivo número 188', 'URL número 188', 188);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (189, 'nombre del archivo número 189', 'URL número 189', 189);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (190, 'nombre del archivo número 190', 'URL número 190', 190);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (191, 'nombre del archivo número 191', 'URL número 191', 191);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (192, 'nombre del archivo número 192', 'URL número 192', 192);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (193, 'nombre del archivo número 193', 'URL número 193', 193);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (194, 'nombre del archivo número 194', 'URL número 194', 194);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (195, 'nombre del archivo número 195', 'URL número 195', 195);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (196, 'nombre del archivo número 196', 'URL número 196', 196);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (197, 'nombre del archivo número 197', 'URL número 197', 197);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (198, 'nombre del archivo número 198', 'URL número 198', 198);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (199, 'nombre del archivo número 199', 'URL número 199', 199);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (200, 'nombre del archivo número 200', 'URL número 200', 200);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (201, 'nombre del archivo número 201', 'URL número 201', 201);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (202, 'nombre del archivo número 202', 'URL número 202', 202);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (203, 'nombre del archivo número 203', 'URL número 203', 203);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (204, 'nombre del archivo número 204', 'URL número 204', 204);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (205, 'nombre del archivo número 205', 'URL número 205', 205);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (206, 'nombre del archivo número 206', 'URL número 206', 206);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (207, 'nombre del archivo número 207', 'URL número 207', 207);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (208, 'nombre del archivo número 208', 'URL número 208', 208);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (209, 'nombre del archivo número 209', 'URL número 209', 209);
INSERT INTO public."ArchivosPublicaciones" ("idArchivo", nombre, url, "idPublicación") VALUES (210, 'nombre del archivo número 210', 'URL número 210', 210);


--
-- Data for Name: Cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Cargos" ("idCargo", nombre) VALUES (1, 'Director centro de universidad');
INSERT INTO public."Cargos" ("idCargo", nombre) VALUES (2, 'Docente tiempo completo');
INSERT INTO public."Cargos" ("idCargo", nombre) VALUES (3, 'Docente ocasional');


--
-- Data for Name: CategoríasCursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."CategoríasCursos" ("idCategoríaCurso", "nombreCategoríaCurso") VALUES (40, 'ingenieria');
INSERT INTO public."CategoríasCursos" ("idCategoríaCurso", "nombreCategoríaCurso") VALUES (41, 'psicologia');
INSERT INTO public."CategoríasCursos" ("idCategoríaCurso", "nombreCategoríaCurso") VALUES (42, 'anatomia
');
INSERT INTO public."CategoríasCursos" ("idCategoríaCurso", "nombreCategoríaCurso") VALUES (43, 'programacion');


--
-- Data for Name: Conexiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Conexiones" ("identificaciónUsuario1", "identificaciónUsuario2", "fechaDeCreación") VALUES (1, 1, '2021-12-06');


--
-- Data for Name: Cursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (50, 'calculo diferencial', 'Es una parte del cálculo infinitesimal y del análisis matemático.', 200000, B'0', 40, '2021-06-06');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (51, 'calculo integral', 'Una integral es una generalización de la suma de infinitos sumandos, infinitesimalmente pequeños', 250000, B'1', 40, '2021-09-09');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (52, 'mecancia', 'Us la rama de la física que estudia y analiza el movimiento y reposo de los cuerpos', 0, B'1', 41, '2021-04-17');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (53, 'electricidad y magnetismo', 'Son dos caras de una simple fuerza fundamental. ', 100000, B'0', 41, '2021-04-17');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (54, 'futbol', 'Es un deporte de equipo jugado entre dos conjuntos de once jugadores cada uno y algunos árbitros que se ocupan de que las normas ', 0, B'0', 42, '2021-02-12');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (55, 'Baloncesto', 'Es un deporte de equipo, jugado entre dos conjuntos de cinco jugadores cada uno durante cuatro períodos o cuartos de diez minutos cada uno​ ', 150000, B'1', 42, '2021-10-06');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (56, 'Algoritmos y programacion ', 'Un algoritmo informático es un conjunto de instrucciones definidas, ordenadas y acotadas para resolver un problema', 0, B'0', 43, '2021-12-12');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (57, 'Estructura I', 'La programación estructurada es un paradigma de programación orientado a mejorar la claridad, calidad y tiempo de desarrollo de un programa de computadora recurriendo únicamente a subrutinas y tres estructuras básica', 0, B'1', 43, '2021-02-26');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (58, 'Calculo vectorial', 'Análisis vectorial o cálculo multivariable es un campo de las matemáticas referidas al análisis real multivariable de vectores en 2 o más dimensiones.', 0, B'1', 40, '2021-10-12');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (59, 'atletismo', 'Es considerado el deporte organizado más antiguo del mundo. Abarca numerosas disciplinas agrupadas en carreras, saltos, lanzamientos y pruebas variadas.', 200000, B'0', 42, '2021-09-09');
INSERT INTO public."Cursos" ("idCurso", nombre, "descripción", costo, certificado, "idCategoríaCurso", "fechaDePublicacion") VALUES (60, 'estructura  II', 'es un paradigma de programación orientado a mejorar la claridad, calidad y tiempo de desarrollo de un programa utilizando únicamente subrutinas o funciones y tres estructuras', 250000, B'1', 41, '2021-09-15');


--
-- Data for Name: Dependencias; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Dependencias" ("idDependencia", nombre) VALUES (1, 'VAC');


--
-- Data for Name: EstadosDeInscripción; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."EstadosDeInscripción" ("idEstadoInscripción", nombre) VALUES (123, 'inscrito');
INSERT INTO public."EstadosDeInscripción" ("idEstadoInscripción", nombre) VALUES (456, 'proceso');
INSERT INTO public."EstadosDeInscripción" ("idEstadoInscripción", nombre) VALUES (101, 'finalizado');
INSERT INTO public."EstadosDeInscripción" ("idEstadoInscripción", nombre) VALUES (11, 'inscrito');
INSERT INTO public."EstadosDeInscripción" ("idEstadoInscripción", nombre) VALUES (13, 'finalizado');


--
-- Data for Name: Estudiantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Estudiantes" ("identificaciónUsuario", "idPrograma") VALUES (1, 2);
INSERT INTO public."Estudiantes" ("identificaciónUsuario", "idPrograma") VALUES (1001, 3);
INSERT INTO public."Estudiantes" ("identificaciónUsuario", "idPrograma") VALUES (1002, 4);
INSERT INTO public."Estudiantes" ("identificaciónUsuario", "idPrograma") VALUES (1003, 5);
INSERT INTO public."Estudiantes" ("identificaciónUsuario", "idPrograma") VALUES (1004, 3);
INSERT INTO public."Estudiantes" ("identificaciónUsuario", "idPrograma") VALUES (1005, 6);


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

INSERT INTO public."FotosPublicaciones" ("idArchivo", "idÁlbum") VALUES (1, 721);
INSERT INTO public."FotosPublicaciones" ("idArchivo", "idÁlbum") VALUES (2, 821);
INSERT INTO public."FotosPublicaciones" ("idArchivo", "idÁlbum") VALUES (3, 721);
INSERT INTO public."FotosPublicaciones" ("idArchivo", "idÁlbum") VALUES (4, 921);
INSERT INTO public."FotosPublicaciones" ("idArchivo", "idÁlbum") VALUES (5, 1021);


--
-- Data for Name: Grupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Grupos" ("idGrupo", "nombreGrupo", "descripción", "idPrivacidad", "idUsuarioCreador") VALUES (1, 'Hablemos de calculo', 'si sabes cuanto es 1+1 entra', 1, 1);
INSERT INTO public."Grupos" ("idGrupo", "nombreGrupo", "descripción", "idPrivacidad", "idUsuarioCreador") VALUES (2, 'Hablemos de salud', 'No vengan a decir cosas que no tienen que ver con ciencia', 2, 1);
INSERT INTO public."Grupos" ("idGrupo", "nombreGrupo", "descripción", "idPrivacidad", "idUsuarioCreador") VALUES (3, 'Hablemos de naturaleza', 'somos los que somos y estamos los que estamos', 1, 1001);
INSERT INTO public."Grupos" ("idGrupo", "nombreGrupo", "descripción", "idPrivacidad", "idUsuarioCreador") VALUES (4, 'Hablemos de ciencia', NULL, 2, 2);


--
-- Data for Name: InscripcionesEnCursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1, 50, '2021-06-06', 13);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1, 60, '2021-09-15', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (2, 54, '2021-02-12', 13);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (2, 55, '2021-10-06', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (2, 59, '2021-09-09', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (3, 59, '2021-10-06', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1001, 51, '2021-09-09', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1001, 56, '2021-12-12', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1001, 52, '2021-04-17', 13);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1001, 54, '2021-05-25', 13);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1002, 53, '2021-04-17', 13);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1002, 57, '2021-08-20', 13);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1003, 58, '2021-10-12', 13);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1004, 60, '2021-10-14', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1004, 58, '2021-10-14', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1005, 51, '2021-11-05', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1005, 52, '2021-11-05', 11);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1005, 57, '2021-02-26', 13);
INSERT INTO public."InscripcionesEnCursos" ("identificaciónUsuario", "idCurso", "fechaDeIngreso", "idEstadoDeInscripción") VALUES (1005, 59, '2021-09-25', 11);


--
-- Data for Name: InscripcionesEnGrupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."InscripcionesEnGrupos" ("idGrupo", "identificaciónUsuario") VALUES (1, 1);
INSERT INTO public."InscripcionesEnGrupos" ("idGrupo", "identificaciónUsuario") VALUES (2, 1);
INSERT INTO public."InscripcionesEnGrupos" ("idGrupo", "identificaciónUsuario") VALUES (1, 2);
INSERT INTO public."InscripcionesEnGrupos" ("idGrupo", "identificaciónUsuario") VALUES (4, 2);
INSERT INTO public."InscripcionesEnGrupos" ("idGrupo", "identificaciónUsuario") VALUES (3, 1001);


--
-- Data for Name: Likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Likes" ("idPublicación", "identificaciónUsuario", fecha, "idTipoDeLike") VALUES (1, 3, '2020-12-04', 1);
INSERT INTO public."Likes" ("idPublicación", "identificaciónUsuario", fecha, "idTipoDeLike") VALUES (2, 2, '2021-07-08', 1);
INSERT INTO public."Likes" ("idPublicación", "identificaciónUsuario", fecha, "idTipoDeLike") VALUES (3, 2, '2021-11-09', 2);
INSERT INTO public."Likes" ("idPublicación", "identificaciónUsuario", fecha, "idTipoDeLike") VALUES (4, 1, '2020-03-14', 1);
INSERT INTO public."Likes" ("idPublicación", "identificaciónUsuario", fecha, "idTipoDeLike") VALUES (5, 3, '2020-01-30', 3);


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

INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (1, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, 
				ut labore et dolore magnam aliquam quaerat voluptatem', '2021-01-10', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (2, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-01-13', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (3, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-06-09', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (4, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-01-06', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (5, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-05-13', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (6, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-03-13', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (7, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-06-13', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (8, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-12-13', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (9, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-09-26', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (10, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-11-16', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (11, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-07-08', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (12, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-11-28', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (13, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-11-17', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (14, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-01-28', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (15, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-01-06', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (16, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-10-20', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (17, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-11-10', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (18, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-03-22', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (19, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-04-16', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (20, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-12-17', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (21, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-02-01', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (22, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-11-24', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (23, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-09-10', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (24, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-06-13', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (25, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-02-26', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (26, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-03-24', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (27, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-06-10', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (28, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-08-25', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (29, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-10-14', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (30, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-11-02', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (31, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-02-28', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (32, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-06-19', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (33, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-03-20', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (34, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-23', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (35, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-02-05', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (36, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-09-12', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (37, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-12-22', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (38, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-09-27', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (39, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-08-24', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (40, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-07-17', 1, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (41, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-01-15', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (42, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-03-10', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (43, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-01-08', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (44, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-05-14', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (45, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-09-11', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (46, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-12-01', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (47, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-10-30', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (48, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-02-26', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (49, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-01-26', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (50, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-12-01', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (51, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-07-03', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (52, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-12-13', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (53, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-08-28', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (54, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-11-14', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (55, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-03-19', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (56, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-02-15', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (57, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-13', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (58, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-11-08', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (59, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-01-11', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (60, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-05-01', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (61, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-03-22', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (62, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-09-02', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (63, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-02-22', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (64, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-04-25', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (65, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-05-09', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (66, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-08-22', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (67, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-11-04', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (68, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-03-07', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (69, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-09-18', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (70, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-12-07', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (71, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-01-14', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (72, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-05-10', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (73, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-10-16', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (74, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-01-27', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (75, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-03-05', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (76, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-12-30', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (77, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-07-14', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (78, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-03-02', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (79, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-15', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (80, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-10-07', 2, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (81, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-10-01', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (82, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-02-01', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (83, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-11-19', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (84, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-08-26', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (85, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-02-10', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (86, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-06-24', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (87, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-11-16', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (88, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-07-21', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (89, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-05-06', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (90, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-02-25', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (91, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-11-25', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (92, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-12-19', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (93, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-05-16', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (94, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-04-15', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (95, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-07-19', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (96, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-20', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (97, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-02-15', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (98, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2019-12-23', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (99, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-09-11', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (100, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-05-09', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (101, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-03-14', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (102, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-12-12', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (103, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-08', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (104, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-08-04', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (105, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-09-27', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (106, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-06-26', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (107, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-11-26', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (108, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-09-16', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (109, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-31', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (110, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-08-14', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (111, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-01-13', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (112, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-07-26', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (113, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-10-04', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (114, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2020-04-09', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (115, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-10-13', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (116, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-04-11', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (117, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-10-27', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (118, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-11-11', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (119, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-07-24', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (120, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-08-29', 3, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (121, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2024-12-23', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (122, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2024-12-13', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (123, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-11-21', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (124, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-01-17', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (125, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-10-19', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (126, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-07-25', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (127, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2024-12-18', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (128, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-03-23', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (129, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2024-01-10', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (130, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-10-22', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (131, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-02-28', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (132, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-10-15', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (133, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-12-14', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (134, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-04-13', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (135, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-08-16', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (136, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-01-14', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (137, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-05-29', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (138, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-09-29', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (139, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-10-24', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (140, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2024-07-12', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (141, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-05-03', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (142, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-11-21', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (143, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2024-07-22', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (144, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-31', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (145, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-21', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (146, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-10-15', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (147, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-07-11', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (148, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-08-28', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (149, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-07-16', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (150, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-05-19', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (151, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-01-06', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (152, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-03', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (153, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-01-02', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (154, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-07-18', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (155, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-10-13', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (156, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-10-20', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (157, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2022-04-09', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (158, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2024-06-02', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (159, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2023-10-22', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (160, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2024-09-25', 1001, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (161, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-05-13', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (162, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-27', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (163, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-25', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (164, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-26', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (165, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-06-16', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (166, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-10-12', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (167, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-06-26', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (168, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-05-18', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (169, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-05', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (170, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-29', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (171, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-06-21', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (172, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-08-03', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (173, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-08-25', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (174, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-06-15', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (175, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-22', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (176, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-08-24', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (177, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-10-16', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (178, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-07-08', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (179, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-07-26', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (180, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-08-18', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (181, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-20', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (182, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-08-03', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (183, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-20', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (184, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-28', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (185, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-11-22', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (186, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-09-23', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (187, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-07-11', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (188, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-10-20', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (189, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-10-22', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (190, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-06-09', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (191, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-05-29', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (192, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-06-29', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (193, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-11-05', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (194, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-11-24', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (195, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-12', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (196, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-12-12', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (197, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-11-16', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (198, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-08-22', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (199, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-08-15', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (200, 'qui dolorem ipsum, quia dolor sit amet consectetur adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem', '2021-05-20', 1002, 1);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (201, NULL, '2020-03-30', 1003, 2);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (202, NULL, '2020-02-14', 1003, 2);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (203, NULL, '2020-06-05', 1003, 2);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (204, NULL, '2020-01-21', 1003, 2);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (205, NULL, '2020-08-23', 1003, 2);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (206, NULL, '2020-11-09', 1003, 2);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (207, NULL, '2020-06-10', 1003, 2);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (208, NULL, '2020-10-16', 1003, 2);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (209, NULL, '2020-04-07', 1003, 2);
INSERT INTO public."Publicaciones" ("idPublicación", "descripción", "fechaDePublicación", "identificaciónUsuario", "idTipoDePrivacidad") VALUES (210, NULL, '2020-12-15', 1003, 2);


--
-- Data for Name: PublicacionesGrupales; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: SeccionesCursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (501, 'funsiones', 50);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (502, 'limites
', 50);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (503, 'derivadas', 50);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (511, 'integrales', 51);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (512, 'integrales simples', 51);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (513, 'integrales por partes', 51);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (514, 'integrales trigonometricas', 51);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (515, 'aplicacion', 51);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (521, 'herramientas matematicas y vectores', 52);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (522, 'cinematica', 52);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (523, 'dinamica', 52);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (524, 'trabajo y energia', 52);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (532, 'fuerzas electricas y campos magneticos', 53);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (533, 'potencial electrico', 53);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (541, 'historia', 54);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (542, 'tacticas', 54);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (543, 'entrenamientos', 54);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (544, 'arbitros', 54);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (551, 'historia', 55);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (553, 'mejores entrenadores', 55);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (562, 'notacion de implementacion de algoritmos', 56);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (563, 'lenguaje de programacion', 56);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (564, 'condicionales', 56);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (565, 'ciclos', 56);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (566, 'vectores', 56);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (567, 'matriz', 56);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (571, 'funsiones
', 57);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (572, 'punteros', 57);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (573, 'pilas
', 57);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (574, 'colas
', 57);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (575, 'listas
', 57);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (581, 'curvas', 58);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (582, 'campos vectoriales', 58);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (584, 'derivadas parciales', 58);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (585, 'integrales multiples', 58);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (591, 'historia', 59);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (592, 'disciplinas', 59);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (601, 'arboles', 60);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (602, 'grafos', 60);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (552, 'reglamentos', 55);
INSERT INTO public."SeccionesCursos" ("idSecciónCurso", "nombreSecciónCurso", "idCurso") VALUES (561, 'definicion de conceptos basicos', 56);


--
-- Data for Name: Seguidores; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Seguidores" ("identificaciónSeguidor", "identificaciónSeguido") VALUES (1, 1);
INSERT INTO public."Seguidores" ("identificaciónSeguidor", "identificaciónSeguido") VALUES (2, 2);
INSERT INTO public."Seguidores" ("identificaciónSeguidor", "identificaciónSeguido") VALUES (3, 3);


--
-- Data for Name: TemasCursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5011, 'funcion polinomial', 501, 'es una relación que para cada valor de la entrada proporciona un valor que se calcula con un polinomio', 'url1');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5012, 'funcion inversa', 501, 'Es una función que asigna elementos de I en elementos de J', 'url2');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5013, 'funcion exponencial', 501, 'es un adjetivo que califica al tipo de crecimiento cuyo ritmo se incrementa cada vez más rápido', 'url3');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5014, 'funcion logaritmica', 501, 'es aquella que genéricamente se expresa como f (x) == logax', 'url4');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5015, 'funcion relacional', 501, 'está orientada al canal de comunicación entre el emisor y el receptor', 'url5');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5016, 'funcion trigonometrica', 501, 'las funciones trigonométricas son las funciones determinadas con el objetivo de extender la definición de las razones trigonométricas a todos los números reales y complejos', 'url6');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5021, 'definicion ', 502, 'el concepto de límite es la clave de toque que formaliza la noción intuitiva de aproximación hacia un punto concreto de una sucesión ', 'url7');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5022, 'limites laterales
', 502, 'se refiere a uno de los dos límites de una función', 'url8');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5023, 'limites infinitos', 502, 'cuando la función f(x) llega a valores que crecen continuamente', 'url9');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5024, 'limites indeterminados', 502, 'Los límites indeterminados (o indeterminaciones) no indican que el límite no exista, sino que no se puede anticipar el resultado. ', 'url10');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5031, 'definicion y reglas blasicas', 503, 'definicion y reglas basicas para entender el tema.', 'url12');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5032, 'notacion', 503, 'lengueje simbolico de las dervadas', 'url13');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5033, 'calculo de la derivada', 503, 'implementacion de la derivada', 'url14');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5034, 'aplicaciones', 503, 'campo donde se puede aplicar', 'url15');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5111, 'historia', 511, 'conocer la historia del calculo integral.', 'url16');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5112, 'definicion', 511, 'entender el cocnepto del tema.', 'url17');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5121, 'contenido', 512, 'entender la introduccion de este metodo de integracion.', 'url18');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5131, 'introduccion y contenido', 513, 'aprender este metodo de integracion', 'url20');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5141, 'introduccion y contenido ', 514, 'conocer la definicion y todo lo relacionado con este tema', 'url22');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5142, 'ejemplos
', 514, 'aplicar lo aprendido', 'url23');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5151, 'fisica', 515, 'Muchas leyes de la Física se expresan en forma de ecuaciones diferenciales.', 'url24');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5152, 'valor medio en una funcion', 515, 'Para calcular el valor medio m de una función f en un intervalo', 'url25');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5211, 'conceptos fundamentales
', 521, 'comprender los conpetos fundamentales de la materia.', 'url26');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5212, 'operaciones con vectores', 521, 'Se expone el concepto de vector y las operaciones básicas entre dos vectores', 'url27');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5221, 'historia', 522, 'leer la interesante historia de esta materia', 'url29');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5222, 'terminologia', 522, 'entender la terminologia del tema', 'url30');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5223, 'elementos basicos
', 522, 'entender los elementos basicos del tema', 'url31');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5224, 'registro de movimientos', 522, 'se entiende por movimiento al cambio de posición que experimenta un cuerpo en el espacio en un determinado período de tiempo', 'url32
');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5225, 'tipos de movimientos', 522, 'diferencial los diferentes tipos de movimientos.', 'url33');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5231, 'historia', 523, 'entender la historias y como nace esta materia', 'url35');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5232, 'calculo en la dinamica', 523, 'se basa en el planteamiento de ecuaciones del movimiento y su integración', 'url36');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5233, 'dinamica sistemas
', 523, 'en física existen dos tipos importantes de sistemas físicos: los sistemas finitos de partículas y los campos.', 'url37');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5412, 'origenes', 541, 'conocer el orirgen del deporte', 'url42');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5241, 'conceptos
', 524, 'enetender los conceptos fundamentales.', 'url39');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5413, 'expancion internacional', 541, 'El auge del fútbol a nivel mundial motivó la creación de la FIFA el 21 de mayo de 1904. Las', 'url43');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5242, 'termodinamica', 524, 'enetender como funciona el trabajo y la energia.', 'url40');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5243, 'unidades de trabajo
', 524, 'enetdner las unidades de trabajo con la que se trabajara en esta materia.', 'url41');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5321, 'historia', 532, 'comprender la historia del tema.', 'urle42');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5322, 'relacion entre H y B', 532, 'Para caracterizar H y B se ha recurrido a varias distinciones', 'url43');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5323, 'fuentes del campo', 532, 'Un campo magnético tiene dos fuentes que lo originan. Una de ellas es una corriente eléctrica de conducción, que da lugar a un campo magnético estático, si es constante.', 'url44');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5324, 'determinacion del campo', 532, 'Existen básicamente dos formas de determinar el valor del campo eléctrico.', 'url45');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5331, 'diferencial de potencial', 533, 'es una magnitud física que cuantifica la diferencia de potencial eléctrico entre dos puntos.', 'url46');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5411, 'historia', 541, 'La historia del fútbol se considera a partir de 1863, año de fundación de la Asociación Inglesa de Fútbol, aunque en sus orígenes eran, al igual que los demás códigos de fútbol, se remontan varios siglos en el pasado, particularmente en las islas británicas durante la Edad Media.​​', 'url41');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5421, 'lineas tacticas', 542, 'entender cuales son as lineas tacticas utilizadas en el futbol', 'url25');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5422, 'tacticas individuales', 542, 'son todas aquellas acciones que realiza y desarrolla un jugador de fútbol dominando el balón con todas las superficies de contacto que le permite el reglamento.', 'url45');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5423, 'tacticas defensivas', 542, 'Son los movimientos de retroceso que realizan los jugadores de un equipo que perdió la posesión del balón en su acción atacante', 'url46');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5424, 'tacticas ofensivas', 542, 'Las tácticas de fútbol ofensivo tienen como objetivo llevar el balón cerca de la portería contraria y lograr el mejor ángulo posible para marcar.', 'url47');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5431, 'entrenamiento', 543, 'El entrenamiento es cualquier preparación o adiestramiento con el propósito de mejorar el rendimiento físico o intelectual', 'ur48');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5432, 'tipos de entrenamientos', 543, 'saber  cuales son los entrenamientos nescesarios para el rendimiento adecuando de un futbolista profesional', 'url49');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5511, 'comienzos', 551, 'un profesor canadiense de educación física, inventó el baloncesto en 1891 en la YMCA de Springfield, Massachusetts, Estados Unidos', 'url50');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5512, 'primeras ligas', 551, 'conocer las primeras ligas de este deporte.', 'url51');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5521, 'manual de juego', 552, 'comprender como funciona este deporte', 'url52');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5531, 'estrategias de los mejores tecnicos', 553, 'saber cuales son las mejores estrategias de este deporte.', 'url53');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5611, 'definicion', 561, 'un algoritmo ​ es un conjunto de instrucciones', 'url54');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5612, 'conceptos basicos', 561, 'entender los conceptos basicos para entender el tema', 'url55');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5621, 'pseudocodigos', 562, 'En ciencias de la computación, y análisis numérico, el pseudocódigo​ es una descripción de alto nivel compacta e informal​ del principio operativo de un programa informático u otro algoritmo', 'url56');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5631, 'hstoria', 563, 'los tres primeros lenguajes de programación modernos, cuyos descendientes aún continúan siendo utilizados', 'url57');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5632, 'ranking', 563, 'los lenguajes de programacion con mejor calificacion y un poco de su historia', 'url58');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5633, 'definicion', 563, 'entende rla definicion de este concepto', 'url59');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5641, 'introduccion y definicion', 564, 'una sentencia condicional es una instrucción o grupo de instrucciones que se pueden ejecutar o no en función del valor de una condición', 'url60');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5651, 'introduccion y definicion', 565, 'es una secuencia de instrucciones de código que se ejecuta repetidas veces', 'url61');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5652, 'tipos de ciclos', 565, 'conocer cuales son los ciclos que se utilizan a la hora de programar y como usarlos', 'url62');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5923, 'carreras en vallas', 592, 'conocer las disciplinas del atletismo.', 'url84');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (2661, 'definicion y aplicacion practica', 566, 'una zona de almacenamiento contiguo que contiene una serie de elementos del mismo tipo', 'url63
');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (2671, 'definicion y aplicacion practica', 567, 'una zona de almacenamiento contiguo que contiene una serie de elementos del mismo tipo', 'url64');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5711, 'definicion y aplicacion practica', 571, 'una función es una sección de un programa que calcula un valor de manera independiente al resto del programa', 'url65');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5721, 'definicion y aplicion practica', 572, 'un puntero es un objeto del lenguaje de programación, cuyo valor se refiere a otro valor almacenado en otra parte de la memoria del ordenador utilizando su dirección.', 'url66');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5722, 'listas viculadas', 572, 'es un tipo de dato autorreferenciado porque contienen un puntero ', 'url67');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5731, 'definicion y aplicacion practica', 573, 'es una lista ordenada o estructura de datos que permite almacenar y recuperar dato', 'url68');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5732, 'ventajas y desventajas', 573, 'comprender cuando es el mejor momento para usar las pilas', 'url69');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5741, 'definicion y aplicacion practica', 574, 'es una estructura de datos, caracterizada por ser una secuencia de elementos en la que la operación de inserción push se realiza por un extremo y la operación de extracción pull por el otro.', 'url70');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5742, 'ventajas y desventajas', 574, 'aprender a utilizar las colas en el momento indicado', 'url71');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5751, 'aplicacion practica y definicion', 575, 'es una estructura dinámica de datos que contiene una colección de elementos homogéneos (del mismo tipo) de manera que se establece entre ellos un orden.', 'url72');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5752, 'tipos de listas', 575, 'aprender cuantas y cuales son las listas que podemos utilizar.', 'url73');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5811, 'curvas en el espacio', 581, 'Se define como curvas planas a aquel conjunto de coordenadas (x,y)', 'url74');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5812, 'aplicaciones', 581, 'saber cuales son las aplicaciones del tema', 'url75');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5821, 'definicion y aplicacion practica', 582, 'es una función que asocia a cada punto del plano o del espacio un vector', 'url76');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5841, 'definicion y aplicacion practica', 584, 'la derivada parcial de una función de varias variables es la derivada con respecto a cada una de esas variables manteniendo las otras como constantes.', 'url77
');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5842, 'derivadas parciales de orden superior', 584, 'En matemáticas, la derivada parcial de una función de varias variables es la derivada con respecto a cada una de esas variables manteniendo las otras como constantes.', 'url78');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5851, 'definicion y aplicacion practica', 585, 'La integración múltiple es el proceso de encontrar las primitivas de una función de varias variables respecto a todas las variables independientes que dicha función posea', 'url79');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5852, 'propiedades y metodos', 585, 'Existen seis órdenes posibles de integración para las integrales iteradas, dando todos el mismo resultado.', 'url80');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5911, 'historia del atletismo
', 591, 'conocer la historia del atletismo', 'url81');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5921, 'carreras de velocidad de fondo', 592, 'conocer las disciplinas del atletismo.', 'url82');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (5922, 'carreras de media distancia y  en rutas', 592, 'conocer las disciplinas del atletismo.', 'url83');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (6011, 'definicion y terminologia', 601, 'En ciencias de la computación, un árbol binario es una estructura de datos en la cual cada nodo puede tener un hijo izquierdo y un hijo derecho.', 'url85');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (6012, 'dibujo y metodos', 601, 'conocer los metodos y la forma grafica de este tipo de estructuras', 'url86');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (6013, 'operaciones y aplicacion practica', 601, 'Como en toda estructura de datos hay dos operaciones básicas, inserción y eliminación. Inserción', 'url87');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (6021, 'definicion y aplicacion', 602, 'en el ámbito de las ciencias de la computación es un tipo abstracto de datos (TAD), que consiste en un conjunto de nodos (también llamados vértices) y un conjunto de arcos (aristas) que establecen relaciones entre los nodos.', 'url88');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (6022, 'enlaces', 602, 'la red de enlaces ferroviarios o aéreos o la red eléctrica de una ciudad', 'url89');
INSERT INTO public."TemasCursos" ("idTema", "nombreTemaCurso", "idSección", "descripción", url) VALUES (6023, 'forma de representacion ', 602, 'conocer la forma en que se representan los grafos', 'url90');


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
-- Data for Name: VisitasPost; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (1, 2, 1);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (1, 3, 2);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (1, 1001, 3);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (1, 1002, 4);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (1, 1003, 5);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (1, 1004, 6);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (1, 1005, 7);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (4, 1, 8);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (4, 2, 9);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (4, 3, 10);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (4, 1001, 11);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (4, 1002, 12);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (2, 1002, 13);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (2, 1004, 14);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (2, 3, 15);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (2, 1001, 16);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (3, 1, 17);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (3, 2, 18);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (3, 1001, 19);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (5, 3, 20);
INSERT INTO public."VisitasPost" ("idPost", "idUsuario", "idVisitaPost") VALUES (5, 2, 21);


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categorias ("idCategoria", "nombreCategoria") VALUES (1, 'Derecho');
INSERT INTO public.categorias ("idCategoria", "nombreCategoria") VALUES (2, 'Educación');
INSERT INTO public.categorias ("idCategoria", "nombreCategoria") VALUES (3, 'Ingeniería');
INSERT INTO public.categorias ("idCategoria", "nombreCategoria") VALUES (4, 'Matemáticas');
INSERT INTO public.categorias ("idCategoria", "nombreCategoria") VALUES (5, 'Papers');
INSERT INTO public.categorias ("idCategoria", "nombreCategoria") VALUES (6, 'Desarrollo personal');
INSERT INTO public.categorias ("idCategoria", "nombreCategoria") VALUES (7, 'Salud');


--
-- Data for Name: categoriasignadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (1, 1);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (1, 5);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (3, 2);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (3, 4);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (3, 5);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (3, 1);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (4, 7);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (4, 5);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (4, 6);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (5, 2);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (2, 4);
INSERT INTO public.categoriasignadas ("idPost", "idCategoria") VALUES (2, 5);


--
-- Data for Name: comentarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.comentarios ("idComentario", "identificaciónUsuario", "idPublicación", fecha, comentario) VALUES (11, 2, 100, '2021-05-04', 'Un comentario es una apreciación o escrito sobre cualquier cosa puesta en análisis');
INSERT INTO public.comentarios ("idComentario", "identificaciónUsuario", "idPublicación", fecha, comentario) VALUES (12, 1, 50, '2021-06-03', 'n comentario es una opinión, parecer, juicio o consideración que alguien hace acerca de otra persona o de algo. Dicha mención puede desarrollarse por vía');
INSERT INTO public.comentarios ("idComentario", "identificaciónUsuario", "idPublicación", fecha, comentario) VALUES (13, 1, 51, '2020-12-20', 'Un comentario es una apreciación realizada por vía oral o escrita de algún objeto analizado, emitiendo en ello un juicio valorativo, lo que no es igual a una');
INSERT INTO public.comentarios ("idComentario", "identificaciónUsuario", "idPublicación", fecha, comentario) VALUES (14, 3, 1, '2019-11-11', 'El comentario es un texto que tiene el propósito de presentar el texto comentado y explicarlo. En este sentido, el comentario de texto deb');
INSERT INTO public.comentarios ("idComentario", "identificaciónUsuario", "idPublicación", fecha, comentario) VALUES (15, 1, 80, '2020-05-06', 'sinónimos de ''comentario'' en un diccionario de 200.000 sinónimos');


--
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.estado ("idEstado", "idPost", "situación") VALUES (1, 1, 'Published');
INSERT INTO public.estado ("idEstado", "idPost", "situación") VALUES (2, 2, 'en revisión');
INSERT INTO public.estado ("idEstado", "idPost", "situación") VALUES (3, 3, 'Published');
INSERT INTO public.estado ("idEstado", "idPost", "situación") VALUES (4, 4, 'Published');
INSERT INTO public.estado ("idEstado", "idPost", "situación") VALUES (5, 5, 'en revisión');


--
-- Data for Name: etiquetas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.etiquetas ("idEtiqueta", "nombreEtiqueta", "idUsuario") VALUES (1, 'diapositivas', 1);
INSERT INTO public.etiquetas ("idEtiqueta", "nombreEtiqueta", "idUsuario") VALUES (2, 'Innovafest B10', 3);
INSERT INTO public.etiquetas ("idEtiqueta", "nombreEtiqueta", "idUsuario") VALUES (3, 'Adultez', 2);
INSERT INTO public.etiquetas ("idEtiqueta", "nombreEtiqueta", "idUsuario") VALUES (4, 'Matemáticas', 1004);
INSERT INTO public.etiquetas ("idEtiqueta", "nombreEtiqueta", "idUsuario") VALUES (5, 'Teams', 1);
INSERT INTO public.etiquetas ("idEtiqueta", "nombreEtiqueta", "idUsuario") VALUES (6, 'Covid-19', 1);
INSERT INTO public.etiquetas ("idEtiqueta", "nombreEtiqueta", "idUsuario") VALUES (7, 'Maternidad', 1);


--
-- Data for Name: etiquetasignadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (1, 6);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (2, 5);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (1, 7);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (3, 6);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (3, 5);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (3, 2);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (3, 1);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (4, 7);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (4, 6);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (4, 3);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (5, 3);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (2, 4);
INSERT INTO public.etiquetasignadas ("idPost", "idEtiqueta") VALUES (2, 2);


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post ("idPost", titulo, contenido, "fechaCreacion", "imgDest", "idUsuario") VALUES (2, 'Matemáticas para todos', 'https://www.youtube.com/channel/UCzTOSkrYaaHNYtGSYScqv9g', '2021-10-01', 'fgrt', 1);
INSERT INTO public.post ("idPost", titulo, contenido, "fechaCreacion", "imgDest", "idUsuario") VALUES (3, 'Derechos durante la virtualidad', 'La pandemia a afectado a todos los sectores de la sociedad
llevando a muchos a desarrollar sus actividades normales desde casa. pero hasta que punto pueden las empresas exiguir a los trabajadores desde el hogar?', '2021-05-02', 'por', 3);
INSERT INTO public.post ("idPost", titulo, contenido, "fechaCreacion", "imgDest", "idUsuario") VALUES (4, 'Importancia del lavado de manos', 'Durante el retorno a la normalidad despues de la pandemia es importante seguir
practicando los buenos habitos que dejo la misma uno de estos es el lavado de manos que permite evitar la propagacion de enfermedades', '2021-11-04', 'ewq', 1004);
INSERT INTO public.post ("idPost", titulo, contenido, "fechaCreacion", "imgDest", "idUsuario") VALUES (5, 'Ideas ingenuas que tienen los adultos en relación a la adolescencia', 'La adolescencia es una etapa de la 
vida llena de muchas dudas sobre el funcionamiento del mundo y el por qué de las cosas, lo que causa que se cuestionen muchas ordenes de los 
adultos y que no se hacían en la niñez, añadiendo también el cambio físico que se produce en esta etapa y lo que trae consigo, ocasiona que 
se estereotipe o se tengan ideas ingenuas en relación a la adolescencia por parte de la población adulta y que serán tocadas más adelante, 
además de verificar cuál sería la verdad detrás de esas ideas.', '2020-06-09', 'jjjj', 1);
INSERT INTO public.post ("idPost", titulo, contenido, "fechaCreacion", "imgDest", "idUsuario") VALUES (1, 'Dignidad humana de las personas privadas de la libertad.Derecho sin torturas. Parte II.', 'Los accionantes son personas que se encuentran privadas de la libertad y recluidas en la Cárcel de alta
 y mediana seguridad de Valledupar ubicada en el departamento del Cesar. Relataron: “que dicho establecimiento penitenciario
fue construido con una falla estructural que les impide contar con un suministro mínimo de agua para satisfacer 
sus necesidades vitales. Solo reciben el líquido en periodos de 10 a 15 minutos diarios y, únicamente llega a los primeros pisos
de las torres, entonces, para poder tener agua en las celdas de los pisos superiores, deben almacenarla en recipientes 
improvisados y subirla, arriesgando muchas veces su integridad física.”', '2021-08-02', 'jjjj', 1);


--
-- Data for Name: publicacionesPost; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Álbumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Álbumes" ("idÁlbum", "identificaciónUsuario", nombre, "fechaDeCreación") VALUES (721, 1, 'A1', '2020-12-08');
INSERT INTO public."Álbumes" ("idÁlbum", "identificaciónUsuario", nombre, "fechaDeCreación") VALUES (821, 1, 'A2', '2021-05-25');
INSERT INTO public."Álbumes" ("idÁlbum", "identificaciónUsuario", nombre, "fechaDeCreación") VALUES (921, 3, 'A3', '2021-01-01');
INSERT INTO public."Álbumes" ("idÁlbum", "identificaciónUsuario", nombre, "fechaDeCreación") VALUES (9212, 2, 'A4', '2021-02-19');
INSERT INTO public."Álbumes" ("idÁlbum", "identificaciónUsuario", nombre, "fechaDeCreación") VALUES (1021, 1, 'A4', '2020-12-12');


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
    ADD CONSTRAINT "InscripcionesEnCursos_pkey" PRIMARY KEY ("identificaciónUsuario", "idCurso");


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
-- Name: VisitasPost VisitasPost_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VisitasPost"
    ADD CONSTRAINT "VisitasPost_pkey" PRIMARY KEY ("idVisitaPost");


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY ("idCategoria", "nombreCategoria");


--
-- Name: categoriasignadas categoriasasignadas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriasignadas
    ADD CONSTRAINT categoriasasignadas_pkey PRIMARY KEY ("idPost", "idCategoria");


--
-- Name: comentarios comentarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT comentarios_pkey PRIMARY KEY ("idComentario");


--
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY ("idEstado");


--
-- Name: etiquetas etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetas
    ADD CONSTRAINT etiquetas_pkey PRIMARY KEY ("idEtiqueta");


--
-- Name: etiquetasignadas etiquetasignadas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetasignadas
    ADD CONSTRAINT etiquetasignadas_pkey PRIMARY KEY ("idPost", "idEtiqueta");


--
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY ("idPost");


--
-- Name: publicacionesPost publicacionesPost_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."publicacionesPost"
    ADD CONSTRAINT "publicacionesPost_pkey" PRIMARY KEY ("idPost", "idPublicación");


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
-- Name: Grupos Grupos_idUsuarios_fKey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupos"
    ADD CONSTRAINT "Grupos_idUsuarios_fKey" FOREIGN KEY ("idUsuarioCreador") REFERENCES public."Usuarios"("identificación") NOT VALID;


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
-- Name: InscripcionesEnCursos fkCurso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnCursos"
    ADD CONSTRAINT "fkCurso" FOREIGN KEY ("idCurso") REFERENCES public."Cursos"("idCurso");


--
-- Name: InscripcionesEnCursos fkEstadoDeInscripcion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnCursos"
    ADD CONSTRAINT "fkEstadoDeInscripcion" FOREIGN KEY ("idEstadoDeInscripción") REFERENCES public."EstadosDeInscripción"("idEstadoInscripción");


--
-- Name: comentarios fkUsuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT "fkUsuario" FOREIGN KEY ("identificaciónUsuario") REFERENCES public."Usuarios"("identificación");


--
-- Name: post fkUsuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT "fkUsuario" FOREIGN KEY ("idUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: etiquetas fkUsuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetas
    ADD CONSTRAINT "fkUsuario" FOREIGN KEY ("idUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: InscripcionesEnCursos fkestado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InscripcionesEnCursos"
    ADD CONSTRAINT fkestado FOREIGN KEY ("idEstadoDeInscripción") REFERENCES public."EstadosDeInscripción"("idEstadoInscripción") NOT VALID;


--
-- Name: etiquetasignadas fketiqueta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetasignadas
    ADD CONSTRAINT fketiqueta FOREIGN KEY ("idEtiqueta") REFERENCES public.etiquetas("idEtiqueta");


--
-- Name: estado fkpost; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT fkpost FOREIGN KEY ("idPost") REFERENCES public.post("idPost") NOT VALID;


--
-- Name: categoriasignadas fkpost; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriasignadas
    ADD CONSTRAINT fkpost FOREIGN KEY ("idPost") REFERENCES public.post("idPost") NOT VALID;


--
-- Name: VisitasPost fkpost; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VisitasPost"
    ADD CONSTRAINT fkpost FOREIGN KEY ("idPost") REFERENCES public.post("idPost") NOT VALID;


--
-- Name: etiquetasignadas fkpost; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetasignadas
    ADD CONSTRAINT fkpost FOREIGN KEY ("idPost") REFERENCES public.post("idPost");


--
-- Name: VisitasPost fkusuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VisitasPost"
    ADD CONSTRAINT fkusuario FOREIGN KEY ("idUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- Name: comentarios publicacionfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT publicacionfk FOREIGN KEY ("idPublicación") REFERENCES public."Publicaciones"("idPublicación");


--
-- Name: Álbumes Álbumes_identificaciónUsuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Álbumes"
    ADD CONSTRAINT "Álbumes_identificaciónUsuario_fkey" FOREIGN KEY ("identificaciónUsuario") REFERENCES public."Usuarios"("identificación") NOT VALID;


--
-- PostgreSQL database dump complete
--

