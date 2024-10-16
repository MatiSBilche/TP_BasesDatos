USE TPBaseDeDatos

-- Ejercicio 1 --

SELECT COUNT(Equipo.NombreEquipo) AS CantEquiposCampeonato FROM Equipo;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 2 --

SELECT COUNT(*) AS PartidosDiciembre FROM Partidos WHERE Partidos.FechaPartido LIKE '2022-12-%';

-----------------------------------------------------------------------------------------------------

-- Ejercicio 3 --

SELECT COUNT(Jugadores.NombreJugador) AS JugadoresMesNoviembre FROM Jugadores 
INNER JOIN Partido_Jugador_Estadistica
	ON Jugadores.IDJugador = Partido_Jugador_Estadistica.IDJugador_Estadistica
INNER JOIN Partidos
	ON Partidos.IDPartido = Partido_Jugador_Estadistica.IDPartido_Estadistica
WHERE Partidos.FechaPartido LIKE '2022-11-%';

-----------------------------------------------------------------------------------------------------

-- Ejercicio 4 --

SELECT Partidos.FechaPartido, elocal.NombreEquipo AS Local, Partidos.PuntosLocal, evisitante.NombreEquipo AS Visitante, Partidos.PuntosVisitante 
FROM  Partidos 
INNER JOIN Equipo AS elocal ON Partidos.IDLocal = elocal.IDEquipo
INNER JOIN Equipo AS evisitante ON Partidos.IDVisitante = evisitante.IDEquipo
WHERE Partidos.FechaPartido LIKE '2022-12-%';

-----------------------------------------------------------------------------------------------------

-- Ejercicio 5 --
SELECT COUNT(Partidos.ResultadoPartido) AS CantidadPartidosPerdidosBulls FROM Partidos
INNER JOIN Equipo ON (Equipo.IDEquipo = Partidos.IDLocal) 
OR Partidos.IDVisitante = Equipo.IDEquipo WHERE (Equipo.NombreEquipo = 'Bulls') AND (Partidos.ResultadoPartido = 'Lost');

-----------------------------------------------------------------------------------------------------

-- Ejercicio 6 --
SELECT TOP 1 Jugadores.NombreJugador, Jugadores.ApellidoJugador, Equipo.NombreEquipo, 
Jugador_Equipo.CamisetaJugador, sum(Partido_Jugador_Estadistica.Valor) AS MaxRobos
FROM Jugadores
INNER JOIN Jugador_Equipo ON Jugadores.IDJugador = Jugador_Equipo.IDJugadorEquip
INNER JOIN Equipo ON Equipo.IDEquipo = Jugador_Equipo.IDEquipoJug
INNER JOIN Partido_Jugador_Estadistica ON Jugadores.IDJugador = Partido_Jugador_Estadistica.IDJugador_Estadistica
INNER JOIN Estadistica ON Partido_Jugador_Estadistica.ID_Estadistica = Estadistica.IDEstadistica
WHERE Estadistica.Descripcion = 'Robos'
GROUP BY Jugadores.NombreJugador, Jugadores.ApellidoJugador, Equipo.NombreEquipo, Jugador_Equipo.CamisetaJugador
ORDER BY MaxRobos DESC;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 7 --

SELECT TOP 5 Equipo.NombreEquipo, SUM(jugadores.PesoJugador) /100 AS SumPeso
FROM Equipo
INNER JOIN Jugador_Equipo ON Equipo.IDEquipo = Jugador_Equipo.IDEquipoJug
INNER JOIN Jugadores ON Jugador_Equipo.IDJugadorEquip = Jugadores.IDJugador
GROUP BY  Equipo.NombreEquipo
ORDER BY SumPeso DESC;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 8 --

SELECT COUNT(Partidos.ResultadoPartido) AS DerrotasSuperando100Puntos
FROM Partidos 
INNER JOIN Equipo AS BLocal ON BLocal.IDEquipo = Partidos.IDLocal
INNER JOIN Equipo AS BVisitante ON BVisitante.IDEquipo = Partidos.IDVisitante
INNER JOIN Ciudad AS C ON BLocal.IDCiudadEquipo = C.IDCiudad
INNER JOIN Ciudad AS C2 ON BVisitante.IDCiudadEquipo = C2.IDCiudad
WHERE Partidos.ResultadoPartido = 'Lost' AND C.IDCiudad = 25 AND Partidos.PuntosLocal > 100 AND Partidos.PuntosVisitante > 100;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 9 --

SELECT E.NombreEquipo, C.NombreConferencia, AVG(P.PuntosLocal + P.PuntosVisitante) AS PromedioPuntosPorPartido FROM Equipo E
INNER JOIN Partidos P ON E.IDEquipo = P.IDLocal OR E.IDEquipo = P.IDVisitante
INNER JOIN Division D ON E.IDDivisionEquipo = D.IDDivision
INNER JOIN Conferencia C ON D.IDConferenciaDiv = C.IDConferencia
GROUP BY E.NombreEquipo, C.NombreConferencia;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 10 --

SELECT TOP 1 Pais.NombrePais, COUNT(Jugadores.IDPaisJugador) AS CantidadDeJugadores FROM Jugadores
INNER JOIN Pais ON Jugadores.IDPaisJugador = Pais.IDPais
WHERE Pais.NombrePais != 'Estados Unidos'
GROUP BY Pais.NombrePais
ORDER BY CantidadDeJugadores DESC;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 11 --

SELECT
    (SELECT COUNT(*) FROM Jugadores WHERE Jugadores.AñoReclutadoJugador < 2007) AS MasDe15Años,
    (SELECT COUNT(*) FROM Jugadores WHERE Jugadores.AñoReclutadoJugador >= 2007 AND Jugadores.AñoReclutadoJugador < 2012) AS Entre15y10,
    (SELECT COUNT(*) FROM Jugadores WHERE Jugadores.AñoReclutadoJugador >= 2012 AND Jugadores.AñoReclutadoJugador < 2023) AS MenosDe10;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 12 --

SELECT
    CONCAT(J.NombreJugador, ' ', J.ApellidoJugador) AS NombreCompleto,
    E.NombreEquipo AS EquipoJug,
    JE.CamisetaJugador AS NumeroCamiseta
FROM
    Jugadores J
JOIN
    jugador_equipo JE ON J.IDJugador = JE.IDJugadorEquip
JOIN
    Equipo E ON JE.IDEquipoJug = E.IDEquipo
WHERE
    J.IDJugador IN (
        SELECT
            IDJugadorEquip
        FROM
            jugador_equipo
        GROUP BY
            IDJugadorEquip
        HAVING
            COUNT(DISTINCT IDEquipoJug) > 1
    )
ORDER BY NombreCompleto ASC

-----------------------------------------------------------------------------------------------------

-- Ejercicio 13 --

SELECT COUNT(Partidos.IDPartido) AS MasDe20P FROM Partido_Jugador_Estadistica
INNER JOIN Jugadores ON Jugadores.IDJugador = Partido_Jugador_Estadistica.IDJugador_Estadistica
INNER JOIN Partidos ON Partidos.IDPartido = Partido_Jugador_Estadistica.IDPartido_Estadistica
INNER JOIN Estadistica ON Estadistica.IDEstadistica = Partido_Jugador_Estadistica.ID_Estadistica
INNER JOIN Jugador_Equipo ON Jugadores.IDJugador = Jugador_Equipo.IDJugadorEquip
INNER JOIN Equipo ON Equipo.IDEquipo = Jugador_Equipo.IDEquipoJug
WHERE Equipo.NombreEquipo = 'Lakers' AND Estadistica.Descripcion = 'Puntos' AND Partido_Jugador_Estadistica.Valor > 20

-----------------------------------------------------------------------------------------------------

-- Ejercicio 14 --

SELECT COUNT(Partidos.IDPartido) AS MasDe25P FROM Partido_Jugador_Estadistica
INNER JOIN Jugadores ON Jugadores.IDJugador = Partido_Jugador_Estadistica.IDJugador_Estadistica
INNER JOIN Partidos ON Partidos.IDPartido = Partido_Jugador_Estadistica.IDPartido_Estadistica
INNER JOIN Estadistica ON Estadistica.IDEstadistica = Partido_Jugador_Estadistica.ID_Estadistica
INNER JOIN Jugador_Equipo ON Jugadores.IDJugador = Jugador_Equipo.IDJugadorEquip
INNER JOIN Equipo ON Equipo.IDEquipo = Jugador_Equipo.IDEquipoJug
WHERE Equipo.NombreEquipo = 'Celtics' AND Estadistica.Descripcion = 'Puntos' AND Partido_Jugador_Estadistica.Valor > 25

-----------------------------------------------------------------------------------------------------

-- Ejercicio 15 --

SELECT TOP 1
        P.IDPartido AS PartidoID,
        P.FechaPartido,
        E.SiglaEquipo AS EquipoSigla,
        P.PuntosLocal,
		Eq.SiglaEquipo AS EquipoVisitanteSigla,
        P.PuntosVisitante,
		ABS(P.PuntosLocal - P.PuntosVisitante) AS DiferenciaPuntos
    FROM
        Partidos P
    INNER JOIN Equipo E ON P.IDLocal = E.IDEquipo
	INNER JOIN Equipo Eq ON P.IDVisitante = Eq.IDEquipo
    INNER JOIN Jugador_Equipo JE ON E.IDEquipo = JE.IDEquipoJug
    INNER JOIN Jugadores J ON JE.IDJugadorEquip = J.IDJugador
    WHERE
        J.NombreJugador = 'Keegan'
	GROUP BY
		P.IDPartido,
        P.FechaPartido,
        E.SiglaEquipo,
        P.PuntosLocal,
		Eq.SiglaEquipo,
        P.PuntosVisitante
	ORDER BY DiferenciaPuntos DESC