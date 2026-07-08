CREATE DATABASE IF NOT EXISTS trabajo_final_fundamentos_bases_de_datos;
use trabajo_final_fundamentos_bases_de_datos;

-- CREACIÓN DE TABLAS

-- TABLA CATEGORÍA
CREATE TABLE categoria(
  IdC CHAR(4) PRIMARY KEY,
  NombreC VARCHAR(100) NOT NULL
 );
 
 -- TABLA CENTRO
 CREATE TABLE centro(
   CodC CHAR(2) primary KEY,
   Nombre_Centro VARCHAR(100) NOT NULL,
   Campus ENUM ('Getafe', 'Leganés', 'Colmenarejo', 'PT')
 );

-- TABLA DEPARTAMENTO
 CREATE TABLE departamento(
   Cod_Dpto CHAR(2) PRIMARY KEY, 
   Nombre VARCHAR(200) NOT NULL
 );

 
 -- TABLA TIPO EVENTO
 CREATE TABLE tipo_evento(
 CodT CHAR(2) PRIMARY KEY,
 NombreT VARCHAR(100) NOT NULL
);

 -- TABLA PERSONA
  CREATE TABLE persona(
   CodP CHAR(10) PRIMARY KEY,
   Nombre VARCHAR(100) NOT NULL,
   Apellidos CHAR(5) NOT NULL,
   Género ENUM ('H', 'M', 'O', 'N') NOT NULL DEFAULT 'N',
   TipoP ENUM ('UC3M', 'Otro')
 );
 
   -- TABLA INTERNO (preguntar luego ns si hace falta doctor)
  CREATE TABLE interno(
   CodP CHAR(10) PRIMARY KEY,
   NRP VARCHAR(10) NOT NULL,
   CategoriaP ENUM('CU', 'TU', 'AD', 'Otro') NOT NULL,
   
   
   CONSTRAINT fk_interno_persona FOREIGN KEY (CodP)
      REFERENCES persona (CodP)
      ON UPDATE CASCADE
      ON DELETE CASCADE
 );
 
    -- TABLA EXTERNO
  CREATE TABLE externo(
   CodP CHAR(10) PRIMARY KEY,
   Procedencia ENUM ('Empresa', 'Universidad', 'Centro investigación', 'Otro') NOT NULL,
   NombreE VARCHAR(100) NOT NULL,
   
    CONSTRAINT fk_externo_persona FOREIGN KEY (CodP)
      REFERENCES persona (CodP)
      ON UPDATE CASCADE
      ON DELETE CASCADE
 );
 
  -- TABLA ADSCRITO
 CREATE TABLE adscrito(
   Investigador CHAR(10) PRIMARY KEY,
   Departamento CHAR(2) NOT NULL,
   Fecha_I DATE NOT NULL,
   
   CONSTRAINT fk_adscrito_interno FOREIGN KEY (Investigador)
      REFERENCES interno (CodP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT
   
 );
 
   -- TABLA CONVOCATORIA (tengo una fk ns pq loooool)
 CREATE TABLE convocatoria(
   CodConv CHAR(10) PRIMARY KEY,
   NombreConv VARCHAR(200) NOT NULL,
   Año DATE NOT NULL,
   TipoC ENUM('Externa', 'Interna')
  
   
 );
 
 
  -- TABLA GRUPOS
 CREATE TABLE grupos(
   CodG CHAR(3) PRIMARY KEY,
   NombreG VARCHAR(200) NOT NULL,
   Acrónimo  VARCHAR(10) NOT NULL,
   URL VARCHAR(100) NOT NULL,
   Dirigido_por  CHAR(10) NOT NULL,
   
   CONSTRAINT fk_pertenece_interno FOREIGN KEY (Dirigido_por)
      REFERENCES interno (CodP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT
 );
 
  -- TABLA PERTENECE
 CREATE TABLE pertenece(
 Grupo CHAR(3),
 Investigador CHAR(10),
 Fecha_I DATE,
 
 PRIMARY KEY (Grupo, Investigador),
   CONSTRAINT fk_pertenece_grupos FOREIGN KEY (Grupo)
      REFERENCES grupos (CodG)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT,
      
      CONSTRAINT fk_pertenece_interno1 FOREIGN KEY (Investigador)
      REFERENCES interno (CodP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT
      
 );

 
 
-- Tabla Evento
CREATE TABLE evento(
 CodEv INT PRIMARY KEY,
 Título  VARCHAR(200) NOT NULL,
 FechaH_I DATETIME NOT NULL,
 FechaH_F DATETIME NOT NULL,
 Streaming ENUM('si', 'no') NOT NULL,
 URL VARCHAR(100) NOT NULL,
 Idioma ENUM('español', 'inglés') NOT NULL,
 Ayuda  CHAR(10), 
 Cuantía  DECIMAL, 
 Organizado_por CHAR(10) NOT NULL,
 Presupuesto DECIMAL NOT NULL,
 TipoE CHAR(2) NOT NULL,
 Celebrado_en CHAR(2) NOT NULL,
 Sala VARCHAR(20) NOT NULL,
 
 
  CONSTRAINT fk_evento_convocatoria FOREIGN KEY (Ayuda)
      REFERENCES convocatoria (CodConv)
      ON UPDATE SET NULL
      ON DELETE SET NULL,

 CONSTRAINT fk_evento_interno FOREIGN KEY (Organizado_por)
      REFERENCES interno (CodP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT,
      
CONSTRAINT fk_evento_tipo FOREIGN KEY (TipoE)
      REFERENCES tipo_evento (CodT)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT,
      
CONSTRAINT fk_evento_centro FOREIGN KEY (Celebrado_en)
      REFERENCES centro (CodC)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT
 
);

 -- TABLA PARTICIPA
CREATE TABLE participa (
Participante CHAR(10),
Evento INT  NOT NULL,
PRIMARY KEY (Participante, Evento),
Num_horas INT NOT NULL,
CONSTRAINT fk_participa_persona FOREIGN KEY (Participante)
references persona (CodP)
ON UPDATE CASCADE 
ON DELETE CASCADE,
CONSTRAINT fk_participa_evento FOREIGN KEY (Evento)
references evento (CodEv)
ON UPDATE RESTRICT 
ON DELETE RESTRICT
);


-- TABLA DESCRITO POR
 CREATE TABLE descrito_por(
   Evento INT NOT NULL,
   Categoria CHAR(4) NOT NULL,
   PRIMARY KEY (Evento, Categoria),
   CONSTRAINT fk_descrito_categoria FOREIGN KEY (Categoria)
      REFERENCES categoria (IdC)
      ON UPDATE CASCADE
      ON DELETE CASCADE,
      
   CONSTRAINT fk_descrito_evento FOREIGN KEY (Evento)
      REFERENCES evento (CodEv)
      ON UPDATE CASCADE
      ON DELETE CASCADE
 );
 