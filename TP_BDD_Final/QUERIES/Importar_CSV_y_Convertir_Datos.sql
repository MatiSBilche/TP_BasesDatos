USE TPBaseDeDatos
BULK INSERT datos_staging
FROM 'C:\Users\Damian\Desktop\TP Base de Datos\datos2023.csv'
WITH
(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FORMAT = 'CSV',
CODEPAGE = '65001'
);


--SACAR ESPACIOS--
UPDATE datos_staging
SET [equipo_nombre] = replace(replace(replace([equipo_nombre],' ','<>'),'><',''),'<>',' ')

UPDATE datos_staging
SET [equipo_nombre] = LTRIM(RTRIM([equipo_nombre]))

UPDATE datos_staging
SET [equipo_ciudad] = replace(replace(replace([equipo_ciudad],' ','<>'),'><',''),'<>',' ')

UPDATE datos_staging
SET [equipo_ciudad] = LTRIM(RTRIM([equipo_ciudad]))

UPDATE datos_staging
SET equipoOP_ciudad = replace(replace(replace(equipoOP_ciudad,' ','<>'),'><',''),'<>',' ')

UPDATE datos_staging
SET equipoOP_ciudad = LTRIM(RTRIM(equipoOP_ciudad))

UPDATE datos_staging
SET equipoOP_nombre = replace(replace(replace(equipoOP_nombre,' ','<>'),'><',''),'<>',' ')

UPDATE datos_staging
SET equipoOP_nombre = LTRIM(RTRIM(equipoOP_nombre))

UPDATE datos_staging
SET [nombre] = replace(replace(replace([nombre],' ','<>'),'><',''),'<>',' ')

UPDATE datos_staging
SET [nombre] = LTRIM(RTRIM([nombre]))

UPDATE datos_staging
SET [pais] = replace(replace(replace([pais],' ','<>'),'><',''),'<>',' ')

UPDATE datos_staging
SET [pais] = LTRIM(RTRIM([pais]))

UPDATE datos_staging
SET [apellido] = replace(replace(replace([apellido],' ','<>'),'><',''),'<>',' ')

UPDATE datos_staging
SET [apellido] = LTRIM(RTRIM([apellido]))

UPDATE datos_staging
SET nombre_completo = replace(replace(replace(nombre_completo,' ','<>'),'><',''),'<>',' ')

UPDATE datos_staging
SET nombre_completo = LTRIM(RTRIM(nombre_completo))

UPDATE datos_staging
SET peso = replace(replace(replace(peso,' ','<>'),'><',''),'<>',' ')

UPDATE datos_staging
SET peso = LTRIM(RTRIM(peso))


UPDATE datos_staging
SET stat_rebotes_defensivos_nombre = replace(stat_rebotes_defensivos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_rebotes_defensivos_nombre = LTRIM(RTRIM(stat_rebotes_defensivos_nombre))

UPDATE datos_staging
SET stat_tiros_intentos_nombre = replace(stat_tiros_intentos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_tiros_intentos_nombre = LTRIM(RTRIM(stat_tiros_intentos_nombre))

UPDATE datos_staging
SET stat_tiros_convertidos_nombre = replace(stat_tiros_convertidos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_tiros_convertidos_nombre = LTRIM(RTRIM(stat_tiros_convertidos_nombre))

UPDATE datos_staging
SET stat_faltas_nombre = replace(stat_faltas_nombre,'  ',' ')

UPDATE datos_staging
SET stat_faltas_nombre = LTRIM(RTRIM(stat_faltas_nombre))

UPDATE datos_staging
SET stat_tiros_libres_intentos_nombre = replace(stat_tiros_libres_intentos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_tiros_libres_intentos_nombre = LTRIM(RTRIM(stat_tiros_libres_intentos_nombre))

UPDATE datos_staging
SET stat_tiros_libres_convertidos_nombre = replace(stat_tiros_libres_convertidos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_tiros_libres_convertidos_nombre = LTRIM(RTRIM(stat_tiros_libres_convertidos_nombre))

UPDATE datos_staging
SET stat_minutos_nombre = replace(stat_minutos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_minutos_nombre = LTRIM(RTRIM(stat_minutos_nombre))

UPDATE datos_staging
SET stat_rebotes_ofensivos_nombre = replace(stat_rebotes_ofensivos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_rebotes_ofensivos_nombre = LTRIM(RTRIM(stat_rebotes_ofensivos_nombre))

UPDATE datos_staging
SET stat_puntos_nombre = replace(stat_puntos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_puntos_nombre = LTRIM(RTRIM(stat_puntos_nombre))

UPDATE datos_staging
SET stat_segundos_nombre = replace(stat_segundos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_segundos_nombre = LTRIM(RTRIM(stat_segundos_nombre))

UPDATE datos_staging
SET stat_robos_nombre = replace(stat_robos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_robos_nombre = LTRIM(RTRIM(stat_robos_nombre))

UPDATE datos_staging
SET stat_tiros_triples_intentos_nombre = replace(stat_tiros_triples_intentos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_tiros_triples_intentos_nombre = LTRIM(RTRIM(stat_tiros_triples_intentos_nombre))

UPDATE datos_staging
SET stat_tiros_triples_convertidos_nombre = replace(stat_tiros_triples_convertidos_nombre,'  ',' ')

UPDATE datos_staging
SET stat_tiros_triples_convertidos_nombre = LTRIM(RTRIM(stat_tiros_triples_convertidos_nombre))

UPDATE datos_staging
SET stat_perdidas_nombre = replace(stat_perdidas_nombre,'  ',' ')

UPDATE datos_staging
SET stat_perdidas_nombre = LTRIM(RTRIM(stat_perdidas_nombre))



-- Actualiza las alturas en pies a metros
UPDATE datos_staging
SET altura = CAST(REPLACE(altura, '-', '.') * 0.3048 AS FLOAT)
WHERE CHARINDEX('-', altura) > 0;

BEGIN TRANSACTION
UPDATE datos_staging
SET altura = 
    CASE 
        WHEN CHARINDEX('-', altura) > 0 THEN
            -- Convierte de pies a metros
            CAST(REPLACE(altura, '-', '.') AS DECIMAL(5, 2)) * 0.3048
        ELSE
            -- Ya está en metros; redondea al formato DECIMAL(5,2)
            CAST(altura AS DECIMAL(5, 2))
    END;
COMMIT


-- Actualiza el peso
BEGIN TRANSACTION
UPDATE datos_staging
SET peso = 
    CASE 
        WHEN CHARINDEX('libras', peso) > 0 THEN
            CAST(REPLACE(peso, ' libras', '') AS DECIMAL(5, 2)) / 2.205
        ELSE
            CAST(REPLACE(peso, ' kilogramos', '') AS DECIMAL(5, 2))
    END;
COMMIT

