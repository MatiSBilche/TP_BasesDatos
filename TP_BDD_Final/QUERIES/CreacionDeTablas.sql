USE TPBaseDeDatos

-- Creación de Tablas Normalizadas --

CREATE TABLE Temporada(
	IDTemporada INT NOT NULL PRIMARY KEY,
	Descripcion VARCHAR(20) NOT NULL
);

CREATE TABLE Partidos(
	IDPartido INT NOT NULL PRIMARY KEY,
	FechaPartido DATE NOT NULL,
	IDLocal INT NOT NULL,
	IDVisitante INT NOT NULL,
	PuntosLocal INT NOT NULL,
	PuntosVisitante INT NOT NULL,
	ResultadoPartido varchar(10) NOT NULL
);

CREATE TABLE Temporada_Partido(
	IDTemporada INT NOT NULL,
	IDPartido INT NOT NULL
);

CREATE TABLE Equipo(
	IDEquipo INT NOT NULL PRIMARY KEY,
	CodigoEquipo VARCHAR(30) NOT NULL,
	NombreEquipo VARCHAR(30) NOT NULL,
	SiglaEquipo VARCHAR(5) NOT NULL,
	IDCiudadEquipo INT NOT NULL,
	IDDivisionEquipo INT NOT NULL
);

CREATE TABLE Ciudad(
	IDCiudad INT NOT NULL PRIMARY KEY,
	NombreCiudad VARCHAR(30)
);

CREATE TABLE Division(
	IDDivision INT NOT NULL PRIMARY KEY,
	NombreDivision VARCHAR(20) NOT NULL,
	IDConferenciaDiv INT NOT NULL
);

CREATE TABLE Conferencia(
	IDConferencia INT NOT NULL PRIMARY KEY,
	NombreConferencia VARCHAR(20) NOT NULL
);

CREATE TABLE Jugadores(
	IDJugador INT NOT NULL PRIMARY KEY,
	CodigoJugador VARCHAR(40) NOT NULL,
	NombreJugador VARCHAR(30) NOT NULL,
	ApellidoJugador VARCHAR(30) NOT NULL,
	AlturaJugador decimal(5,2) NOT NULL,
	PesoJugador decimal(5,2) NOT NULL,
	IDPaisJugador INT NOT NULL,
	PosicionJugador VARCHAR(5) NOT NULL,
	AñoReclutadoJugador INT NOT NULL
);

CREATE TABLE Pais(
	IDPais INT NOT NULL PRIMARY KEY,
	NombrePais VARCHAR(50) NOT NULL
);

CREATE TABLE Jugador_Equipo(
	IDJugadorEquip INT NOT NULL,
	IDEquipoJug INT NOT NULL,
	CamisetaJugador INT
);

CREATE TABLE Estadistica(
	IDEstadistica INT NOT NULL PRIMARY KEY,
	Descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE Partido_Jugador_Estadistica(
	IDPartido_Estadistica INT NOT NULL,
	IDJugador_Estadistica INT NOT NULL,
	ID_Estadistica INT NOT NULL,
	Valor INT NOT NULL
);

-----------------------------------------------------------------------------------------------------

-- Temporadas --

INSERT INTO Temporada
SELECT DISTINCT [temporada_id], [temporada_descripcion]
FROM [datos_staging]

-----------------------------------------------------------------------------------------------------

-- Partidos --

INSERT INTO Partidos
SELECT DISTINCT
	[partido_id],
	[fecha],
	[equipo_id],
	[equipoOP_id],
	[equipo_puntos],
	[equipoOP_puntos],
	resultado
FROM datos_staging
WHERE datos_staging.esLocal = 'True'

-----------------------------------------------------------------------------------------------------

-- Conferencias --

INSERT INTO Conferencia VALUES(1, 'Este'), (2, 'Oeste')

-----------------------------------------------------------------------------------------------------

-- Divisiones --

INSERT INTO Division VALUES
	(1, 'Noroeste', 2),
	(2, 'Pacífico', 2),
	(3, 'Sudeste', 1),
	(4, 'Atlántico', 1),
	(5, 'Sudoeste', 2),
	(6, 'Central', 1)

-----------------------------------------------------------------------------------------------------

-- Equipòs --

INSERT INTO Equipo
SELECT DISTINCT
	[equipo_id],
	[equipo_codigo],
	[equipo_nombre],
	[equipo_sigla],
	[equipo_idCiudad],
	CASE
		WHEN [equipo_division] = 'Noroeste' THEN 1
		WHEN [equipo_division] = 'Pacífico' THEN 2
		WHEN [equipo_division] = 'Sudeste' THEN 3
		WHEN [equipo_division] = 'Atlántico' THEN 4
		WHEN [equipo_division] = 'Sudoeste' THEN 5
		WHEN [equipo_division] = 'Central' THEN 6
	END
FROM datos_staging

-----------------------------------------------------------------------------------------------------

-- Ciudades --

INSERT INTO Ciudad
SELECT DISTINCT
	[equipo_idCiudad],
	[equipo_ciudad]
FROM datos_staging

-----------------------------------------------------------------------------------------------------

-- Paises --

INSERT INTO Pais
SELECT DISTINCT
	CASE
		WHEN [pais] = 'Angola' THEN 0 
		WHEN [pais] = 'Democratic Republic of Congo' THEN 2
		WHEN [pais] = 'Jamaica' THEN 5
		WHEN [pais] = 'Israel' THEN 6
		WHEN [pais] = 'Guinea' THEN 14
		WHEN [pais] = 'Polonia' THEN 18
		WHEN [pais] = 'Georgia' THEN 24
		WHEN [pais] = 'Saint Lucia' THEN 29
		WHEN [pais] = 'Portugal' THEN 38
		ELSE [idPais]
	END,
	[pais]
FROM datos_staging

-----------------------------------------------------------------------------------------------------

-- Jugadores --

INSERT INTO Jugadores
SELECT DISTINCT
	[jugador_id],
	[jugador_codigo],
	[nombre],
	[apellido],
	[altura],
	[peso],
	CASE
		WHEN [pais] = 'Angola' THEN 0 
		WHEN [pais] = 'Democratic Republic of Congo' THEN 2
		WHEN [pais] = 'Jamaica' THEN 5
		WHEN [pais] = 'Israel' THEN 6
		WHEN [pais] = 'Guinea' THEN 14
		WHEN [pais] = 'Polonia' THEN 18
		WHEN [pais] = 'Georgia' THEN 24
		WHEN [pais] = 'Saint Lucia' THEN 29
		WHEN [pais] = 'Portugal' THEN 38
		ELSE [idPais]
	END,
	[posicion],
	[draft_year]
FROM datos_staging

-----------------------------------------------------------------------------------------------------

-- Estadisticas --

INSERT INTO Estadistica
SELECT DISTINCT
	[stat_asistencias_id], [stat_asistencias_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_bloqueos_id], [stat_bloqueos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_rebotes_defensivos_id], [stat_rebotes_defensivos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_tiros_intentos_id], [stat_tiros_intentos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_tiros_convertidos_id], [stat_tiros_convertidos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_faltas_id], [stat_faltas_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_tiros_libres_intentos_id], [stat_tiros_libres_intentos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_tiros_libres_convertidos_id], [stat_tiros_libres_convertidos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_minutos_id], [stat_minutos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_rebotes_ofensivos_id], [stat_rebotes_ofensivos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_puntos_id], [stat_puntos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_segundos_id], [stat_segundos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_robos_id], [stat_robos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_tiros_triples_intentos_id], [stat_tiros_triples_intentos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_tiros_triples_convertidos_id], [stat_tiros_triples_convertidos_nombre]
FROM datos_staging
UNION
SELECT DISTINCT
	[stat_perdidas_id], [stat_perdidas_nombre]
FROM datos_staging

-----------------------------------------------------------------------------------------------------

-- Estadisticas Relacional --

INSERT INTO Partido_Jugador_Estadistica
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_asistencias_id], [stat_asistencias_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_bloqueos_id], [stat_bloqueos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_rebotes_defensivos_id], [stat_rebotes_defensivos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_tiros_intentos_id], [stat_tiros_intentos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_tiros_convertidos_id], [stat_tiros_convertidos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_faltas_id], [stat_faltas_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_tiros_libres_intentos_id], [stat_tiros_libres_intentos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_tiros_libres_convertidos_id], [stat_tiros_libres_convertidos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_minutos_id], [stat_minutos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_rebotes_ofensivos_id], [stat_rebotes_ofensivos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_puntos_id], [stat_puntos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_segundos_id], [stat_segundos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_robos_id], [stat_robos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_tiros_triples_intentos_id], [stat_tiros_triples_intentos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_tiros_triples_convertidos_id], [stat_tiros_triples_convertidos_valor]
FROM datos_staging
UNION
SELECT DISTINCT
	[partido_id], [jugador_id], [stat_perdidas_id], [stat_perdidas_valor]
FROM datos_staging

-----------------------------------------------------------------------------------------------------

-- Jugador Equipo Relacional --

INSERT INTO Jugador_Equipo
SELECT DISTINCT
	[jugador_id],
	[equipo_id],
	CAST(ROUND([caminseta], 0) AS int)
FROM datos_staging

-----------------------------------------------------------------------------------------------------

-- Temporada Partido Relacional --

INSERT INTO Temporada_Partido
SELECT DISTINCT
	[temporada_id],
	[partido_id]
FROM datos_staging

-----------------------------------------------------------------------------------------------------


-- CLAVES FORANEAS --

ALTER TABLE Partidos
ADD CONSTRAINT FK_Partidos_IDLocal
FOREIGN KEY (IDLocal)
REFERENCES Equipo(IDEquipo);

ALTER TABLE Partidos
ADD CONSTRAINT FK_Partidos_IDVisitante
FOREIGN KEY (IDVisitante)
REFERENCES Equipo(IDEquipo);

ALTER TABLE Temporada_Partido
ADD CONSTRAINT FK_Temporada_ID
FOREIGN KEY (IDTemporada)
REFERENCES Temporada(IDTemporada)

ALTER TABLE Temporada_Partido
ADD CONSTRAINT FK_PartidoTemporada_ID
FOREIGN KEY (IDPartido)
REFERENCES Partidos(IDPartido)

ALTER TABLE Equipo
ADD CONSTRAINT FK_CiudadEquipo
FOREIGN KEY (IDCiudadEquipo)
REFERENCES Ciudad(IDCiudad)

ALTER TABLE Equipo
ADD CONSTRAINT FK_DivisionEquipo
FOREIGN KEY (IDDivisionEquipo)
REFERENCES Division(IDDivision)

ALTER TABLE Division
ADD CONSTRAINT FK_DivisionConf
FOREIGN KEY (IDConferenciaDiv)
REFERENCES Conferencia(IDConferencia)

ALTER TABLE Jugadores
ADD CONSTRAINT FK_PaisJugador
FOREIGN KEY (IDPaisJugador)
REFERENCES Pais(IDPais)

ALTER TABLE Jugador_Equipo
ADD CONSTRAINT FK_JugadorID
FOREIGN KEY (IDJugadorEquip)
REFERENCES Jugadores(IDJugador)

ALTER TABLE Jugador_Equipo
ADD CONSTRAINT FK_EquipoID
FOREIGN KEY (IDEquipoJug)
REFERENCES Equipo(IDEquipo)

ALTER TABLE Partido_Jugador_Estadistica
ADD CONSTRAINT FK_StatPartidoID
FOREIGN KEY (IDPartido_Estadistica)
REFERENCES Partidos(IDPartido)

ALTER TABLE Partido_Jugador_Estadistica
ADD CONSTRAINT FK_StatJugadorID
FOREIGN KEY (IDJugador_Estadistica)
REFERENCES Jugadores(IDJugador)

ALTER TABLE Partido_Jugador_Estadistica
ADD CONSTRAINT FK_StatID
FOREIGN KEY (ID_Estadistica)
REFERENCES Estadistica(IDEstadistica)