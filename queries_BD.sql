#consultas 
#1. ¿Cuántos eventos científicos se han celebrado en el 2024 agrupados por código y nombre de tipo de evento?
SELECT 
    E.TipoE AS CodTipo,
    T.NombreT AS NombreTipo,
    COUNT(*) AS NumEventos
FROM EVENTO E
JOIN Tipo_Evento T ON E.TipoE = T.CodT
WHERE YEAR(E.FechaH_I) = 2024
GROUP BY E.TipoE, T.NombreT;

#2 Título del evento con mayor financiación celebrado durante el año 2024. 
SELECT Título,  Cuantía
FROM EVENTO 
WHERE YEAR(FechaH_I) = 2024
ORDER BY Cuantía DESC
LIMIT 1;

#3  Número de registro, nombre, apellidos del investigador/a de la UC3M que ha organizado más eventos
SELECT I.NRP, P.Nombre, P.Apellidos, COUNT(*) AS NumEventos
 FROM EVENTO E 
JOIN PERSONA P ON E.Organizado_por = P.CodP 
JOIN INTERNO I ON P.CodP = I.CodP 
JOIN ADSCRITO A ON I.CodP = A.Investigador 
WHERE P.TipoP = 'UC3M' 
GROUP BY I.NRP, P.Nombre, P.Apellidos
 ORDER BY NumEventos DESC
 LIMIT 1;
 
#4  Nombre, fecha de inicio y fecha de fin de los eventos del 2024 que no han recibido ninguna ayuda económica
SELECT Título, FechaH_I, FechaH_F
FROM EVENTO
WHERE YEAR(FechaH_I) = 2024
AND (Ayuda IS NULL OR Ayuda = 0);

#5  Nombre de los eventos celebrados durante el 2023 que están descritos por categorías que contengan el término “Inteligencia Artificial”
SELECT E.Título 
FROM EVENTO E
JOIN DESCRITO_POR DP ON E.CodEv = DP.Evento
JOIN CATEGORIA C ON DP.Categoria = C.IdC
WHERE YEAR(E.FechaH_I) = 2023
AND C.NombreC LIKE '%Inteligencia Artificial%';
 
#6 Número de eventos celebrados por código y nombre de centro de la universidad ordenados de mayor a menor 
SELECT C.CodC, C.Nombre_Centro, COUNT(E.CodEv) AS NumEventos
FROM EVENTO E
JOIN CENTRO C ON E.Celebrado_en = C.CodC
GROUP BY C.CodC, C.Nombre_Centro
ORDER BY NumEventos DESC;

#7. Obtener el número de horas de participación de los investigadores de la universidad en los eventos organizados durante los años 2023 y 2024 agrupadas por códigos de departamento. 
SELECT SUM(PA.Num_horas) as 'Horas totales'
FROM PARTICIPA PA
JOIN EVENTO E ON PA.Evento = E.CodEv
JOIN ADSCRITO A ON PA.Participante = A.Investigador
JOIN DEPARTAMENTO D ON A.Departamento = D.Cod_Dpto
WHERE YEAR(E.FechaH_I) BETWEEN 2023 AND 2024
GROUP BY D.Cod_Dpto;

#8 Listar los datos de los eventos organizados en la Escuela Politécnica Superior que contengan en el título los términos “política” e “internacional”.
SELECT *
FROM EVENTO E
INNER JOIN CENTRO C ON E.Celebrado_en = C.CodC
WHERE C.Nombre_Centro LIKE '%Escuela politécnica superior%'
AND E.Título LIKE '%política%'
AND E.Título LIKE '%internacional%';

#9 Listar el nombre, apellidos de los participantes externos así como el nombre de su institución o empresa que han tomado parte en el evento que lleva por título “Las rutas turísticas: El patrimonio monumental en la gestión de itinerarios culturales”.
SELECT P.Nombre, P.Apellidos, EX.NombreE AS Institucion
FROM PARTICIPA PA
JOIN EVENTO EV ON PA.Evento = EV.CodEv
JOIN PERSONA P ON PA.Participante = P.CodP
JOIN EXTERNO EX ON P.CodP = EX.CodP
WHERE EV.Título = 'Las rutas turísticas: El patrimonio monumental en la gestión de itinerarios culturales';

#10
SELECT P.Género, COUNT(*) as 'Número de eventos'
FROM EVENTO E
JOIN PERSONA P ON E.Organizado_por = P.CodP
GROUP BY P.Género;

