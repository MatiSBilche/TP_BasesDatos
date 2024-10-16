USE TPBaseDeDatos

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
	PRIMARY KEY(IDTemporada, IDPartido)
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
	PRIMARY KEY(IDJugadorEquip, IDEquipoJug)
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
	PRIMARY KEY(IDPartido_Estadistica, IDJugador_Estadistica)
);



