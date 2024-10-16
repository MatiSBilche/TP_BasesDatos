USE TPBD

CREATE TABLE PesoTemp(
	Peso VARCHAR(50)
);

INSERT INTO PesoTemp (Peso)
SELECT Peso FROM datos_staging;

SELECT * From PesoTemp

UPDATE PesoTemp
SET Peso = CASE
		WHEN CHARINDEX('libras', peso) > 0 AND ISNUMERIC(SUBSTRING(peso, 1, CHARINDEX(' libras', peso) - 1)) = 1 THEN
      CAST(SUBSTRING(peso, 1, CHARINDEX(' libras', peso) - 1) AS DECIMAL(10, 2)) * 0.45359237 
      + ' kg'
    ELSE 
      peso 
	END
WHERE CHARINDEX('libras', peso) > 0  AND ISNUMERIC(SUBSTRING(peso, 1, CHARINDEX(' libras', peso) - 1)) = 1;