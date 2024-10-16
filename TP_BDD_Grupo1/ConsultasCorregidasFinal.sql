USE TPBaseDeDatos
-- Ejercicio 2 --
-- CORREGIDA--

SELECT COUNT(*) AS PartidosDiciembre FROM Partidos WHERE MONTH(Partidos.FechaPartido) = 12;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 3 --
-- CORREGIDA--

SELECT COUNT(DISTINCT Jugadores.NombreJugador) AS JugadoresMesNoviembre FROM Jugadores 
INNER JOIN Partido_Jugador_Estadistica
	ON Jugadores.IDJugador = Partido_Jugador_Estadistica.IDJugador_Estadistica
INNER JOIN Partidos
	ON Partidos.IDPartido = Partido_Jugador_Estadistica.IDPartido_Estadistica
WHERE MONTH(Partidos.FechaPartido) = 11;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 4 --
-- CORREGIDA--

SELECT Partidos.FechaPartido, elocal.NombreEquipo AS Local, Partidos.PuntosLocal, evisitante.NombreEquipo AS Visitante, Partidos.PuntosVisitante 
FROM  Partidos 
INNER JOIN Equipo AS elocal ON Partidos.IDLocal = elocal.IDEquipo
INNER JOIN Equipo AS evisitante ON Partidos.IDVisitante = evisitante.IDEquipo
WHERE MONTH(Partidos.FechaPartido) = 12;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 5 --
-- CORREGIDA--

SELECT COUNT(Partidos.ResultadoPartido) AS CantidadPartidosPerdidosBulls FROM Partidos
INNER JOIN Equipo EL ON (EL.IDEquipo = Partidos.IDLocal)
INNER JOIN Equipo EV ON (EV.IDEquipo = Partidos.IDVisitante)
WHERE ((EL.NombreEquipo = 'Bulls') AND (Partidos.ResultadoPartido = 'Lost')) OR
		((EV.NombreEquipo = 'Bulls') AND (Partidos.ResultadoPartido = 'Won'));

-----------------------------------------------------------------------------------------------------

-- Ejercicio 6 --
-- CORREGIDA--

SELECT TOP 1 Jugadores.NombreJugador, Jugadores.ApellidoJugador, Equipo.NombreEquipo, 
Jugador_Equipo.CamisetaJugador, CONVERT(DECIMAL(10,2), AVG(Partido_Jugador_Estadistica.Valor*1.0)) AS MaxRobos
FROM Jugadores
INNER JOIN Jugador_Equipo ON Jugadores.IDJugador = Jugador_Equipo.IDJugadorEquip
INNER JOIN Equipo ON Equipo.IDEquipo = Jugador_Equipo.IDEquipoJug
INNER JOIN Partido_Jugador_Estadistica ON Jugadores.IDJugador = Partido_Jugador_Estadistica.IDJugador_Estadistica
INNER JOIN Estadistica ON Partido_Jugador_Estadistica.ID_Estadistica = Estadistica.IDEstadistica
WHERE Estadistica.Descripcion = 'Robos'
GROUP BY Jugadores.NombreJugador, Jugadores.ApellidoJugador, Equipo.NombreEquipo, Jugador_Equipo.CamisetaJugador
ORDER BY AVG(Partido_Jugador_Estadistica.Valor) DESC;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 7 --
-- CORREGIDA--

SELECT TOP 5 Equipo.NombreEquipo, AVG(jugadores.PesoJugador) AS PromPeso
FROM Equipo
INNER JOIN Jugador_Equipo ON Equipo.IDEquipo = Jugador_Equipo.IDEquipoJug
INNER JOIN Jugadores ON Jugador_Equipo.IDJugadorEquip = Jugadores.IDJugador
GROUP BY  Equipo.NombreEquipo
ORDER BY PromPeso DESC;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 8 --
-- CORREGIDA--

SELECT Count(Partidos.IDPartido) AS CantPartidosBostonMas100P FROM Partidos 
INNER JOIN Equipo AS BLocal ON BLocal.IDEquipo = Partidos.IDLocal
INNER JOIN Equipo AS BVisitante ON BVisitante.IDEquipo = Partidos.IDVisitante
INNER JOIN Ciudad AS C ON BLocal.IDCiudadEquipo = C.IDCiudad
INNER JOIN Ciudad AS C2 ON BVisitante.IDCiudadEquipo = C2.IDCiudad
WHERE Partidos.ResultadoPartido = 'Lost' AND C.IDCiudad = 25 AND Partidos.PuntosLocal > 100 OR
	Partidos.ResultadoPartido = 'Won' AND C2.IDCiudad = 25 AND Partidos.PuntosVisitante > 100

-----------------------------------------------------------------------------------------------------

-- Ejercicio 9 --
-- CORREGIDA--

SELECT C.NombreConferencia, AVG(P.PuntosLocal + P.PuntosVisitante) AS PromedioPuntosPorPartido FROM Equipo E
INNER JOIN Partidos P ON E.IDEquipo = P.IDLocal OR E.IDEquipo = P.IDVisitante
INNER JOIN Division D ON E.IDDivisionEquipo = D.IDDivision
INNER JOIN Conferencia C ON D.IDConferenciaDiv = C.IDConferencia
GROUP BY C.NombreConferencia;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 12 --
-- CORREGIDA--

SELECT CONCAT(J.NombreJugador, ' ', J.ApellidoJugador) AS NombreCompleto, E.NombreEquipo AS EquipoJug, JE.CamisetaJugador AS NumeroCamiseta FROM Jugadores J
INNER JOIN Jugador_Equipo JE ON J.IDJugador = JE.IDJugadorEquip
INNER JOIN Equipo E ON JE.IDEquipoJug = E.IDEquipo
INNER JOIN (SELECT IDJugadorEquip FROM Jugador_Equipo GROUP BY IDJugadorEquip HAVING COUNT(DISTINCT IDEquipoJug) > 1 ) AS JugadoresMultiples ON J.IDJugador = JugadoresMultiples.IDJugadorEquip
ORDER BY NombreCompleto ASC;

-----------------------------------------------------------------------------------------------------

-- Ejercicio 13 --
-- CORREGIDA--

SELECT COUNT(DISTINCT Partidos.IDPartido) AS CantLakersJugadorMas20P FROM Partido_Jugador_Estadistica
INNER JOIN Jugadores ON Jugadores.IDJugador = Partido_Jugador_Estadistica.IDJugador_Estadistica
INNER JOIN Partidos ON Partidos.IDPartido = Partido_Jugador_Estadistica.IDPartido_Estadistica
INNER JOIN Estadistica ON Estadistica.IDEstadistica = Partido_Jugador_Estadistica.ID_Estadistica
INNER JOIN Jugador_Equipo ON Jugadores.IDJugador = Jugador_Equipo.IDJugadorEquip
INNER JOIN Equipo ON Equipo.IDEquipo = Jugador_Equipo.IDEquipoJug and (equipo.idequipo=partidos.IDLocal or equipo.idequipo=partidos.IDvisitante)
WHERE Equipo.NombreEquipo = 'Lakers' AND Estadistica.Descripcion = 'Puntos' AND Partido_Jugador_Estadistica.Valor > 20

-----------------------------------------------------------------------------------------------------

-- Ejercicio 14 --
-- CORREGIDA--

SELECT COUNT(DISTINCT Partidos.IDPartido) AS CantCelticsJugadorMas25P FROM Partido_Jugador_Estadistica
INNER JOIN Jugadores ON Jugadores.IDJugador = Partido_Jugador_Estadistica.IDJugador_Estadistica
INNER JOIN Partidos ON Partidos.IDPartido = Partido_Jugador_Estadistica.IDPartido_Estadistica
INNER JOIN Estadistica ON Estadistica.IDEstadistica = Partido_Jugador_Estadistica.ID_Estadistica
INNER JOIN Jugador_Equipo ON Jugadores.IDJugador = Jugador_Equipo.IDJugadorEquip
INNER JOIN Equipo ON Equipo.IDEquipo = Jugador_Equipo.IDEquipoJug
WHERE Equipo.NombreEquipo = 'Celtics' AND Estadistica.Descripcion = 'Puntos' AND Partido_Jugador_Estadistica.Valor > 25

-----------------------------------------------------------------------------------------------------
