/*INCIANDO A MODELAGEM FISICA*/

/*CRIANDO BANCO DE DADOS*/

CREATE DATABASE PROJETO;

USE PROJETO;

CREATE TABLE CLIENTES (
	NOME VARCHAR(30),
	CPF INT(11),
	SEXO CHAR(1),
	EMAIL VARCHAR(30),
	TELEFONE VARCHAR(13)
	);
	
SHOW TABLES;

DESC CLIENTES;

/*INSERINDO TUPLAS NA TABELA */

INSERT INTO CLIENTES VALUES('IAGO', 01458231225, 'M');

/*OU*/

INSERT INTO CLIENTES (NOME,CPF,SEXO) VALUES('SILVIA', 01252321585, 'F');



/*PROJEÇÃO -> SELECT - */

SELECT NOW(); /*MOSTRA A HORA ATUAL DO SISTEMA OPERACIONAL*/

SELECT NOME, CPF, SEXO FROM CLIENTES;
SELECT NOME AS CLIENTE, CPF, SEXO FROM CLIENTES;

/*PROJETANDO DADOS QUE NÃO EXISTEM NA TABELA TRAZENDO A HORA ATUAL COMO DATA_HORA*/
SELECT NOME AS CLIENTE, CPF, NOW() AS DATA_HORA SEXO FROM CLIENTES;

/*NÃO USAR*/

SELECT * FROM CLIENTES;

/*FILTROS - SELEÇÃO - WHERE*/

SELECT NOME, SEXO FROM CLIENTES
WHERE SEXO = 'M';

/*UTILIZANDO O LIKE*/

SELECT NOME, SEXO FROM CLIENTES
WHERE CPF LIKE '125%'; /* COMEÇA COM 125 O CPF*/


/*EXERCICIO*/

CREATE TABLE LIVROS (
	NOME VARCHAR(30),
	EDITAO VARCHAR(30),
	AUTOR VARCHAR(30),
	SEXO CHAR(1),
	UF CHAR(2),
	PAGINAS INT(10),
	VALOR FLOAT (10,2);
);

INSERT INTO LIVROS (NOME, EDITAO, AUTOR, SEXO, UF, PAGINAS) VALUES('LIVRO1', 'PRIMEIRA EDIÇÃO', 'IAGO', 'M', 'MG', 198);
INSERT INTO LIVROS (NOME, EDITAO, AUTOR, SEXO, UF, PAGINAS) VALUES('LIVRO2', 'SEGUNDA EDIÇÃO', 'DUDA', 'M', 'SP', 217);
INSERT INTO LIVROS (NOME, EDITAO, AUTOR, SEXO, UF, PAGINAS) VALUES('LIVRO3', 'TERCEIRA EDIÇÃO', 'SILVIA', 'M', 'RJ', 140);
INSERT INTO LIVROS (NOME, EDITAO, AUTOR, SEXO, UF, PAGINAS) VALUES('LIVRO4', 'QUARTA EDIÇÃO', 'JOAO', 'M', 'RJ', 511);
INSERT INTO LIVROS (NOME, EDITAO, AUTOR, SEXO, UF, PAGINAS) VALUES('LIVRO5', 'QUINTA EDIÇÃO', 'LEANDRO', 'F', 'SP', 298);
INSERT INTO LIVROS (NOME, EDITAO, AUTOR, SEXO, UF, PAGINAS) VALUES('LIVRO3', 'TERCEIRA EDIÇÃO', 'SILVIA', 'F', 'RJ', 140);
INSERT INTO LIVROS (NOME, EDITAO, AUTOR, SEXO, UF, PAGINAS) VALUES('LIVRO4', 'QUARTA EDIÇÃO', 'JOAO', 'M', 'RJ', 511);
INSERT INTO LIVROS (NOME, EDITAO, AUTOR, SEXO, UF, PAGINAS) VALUES('LIVRO5', 'QUINTA EDIÇÃO', 'LEANDRO', 'F', 'SP', 298);

/*NOME DO LICRO E A EDIÇÃO*/

SELECT NOME, EDITAO FROM LIVROS;

/*NOME E UF DE AUTORES DO SEXO MASCULINO*/

SELECT NOME, UF FROM LIVROS
WHERE SEXO = 'M';

/*NOME DO LIVRO E NUMERO DE PÁGINAS DE AUTORAS FEMININAS*/

SELECT NOME, PAGINAS FROM LIVROS
WHERE SEXO = 'F';

/*TRAZER OS DADOS DOS AUTORES MASCULINOS QUE TIVERAM LIVROS PUBLICADOS POR SP E RJ*/

SELECT AUTOR, SEXO, NOME, UF FROM LIVROS
WHERE UF = 'RJ' OR UF = 'SP';

/*OPERADORES LÓGICOS - TABELA VERDADE*/

SELECT AUTOR, SEXO, UF FROM LIVROS
WHERE SEXO = 'F'
AND (UF = 'SP' OR UF = 'RJ');


/*FILTRANDO VALORES NULOS*/

SELECT NOME, SEXO, ENDERECO FROM CLIENTES
WHERE EMAIL IS NOT NULL;

SELECT NOME, SEXO, ENDERECO FROM CLIENTES
WHERE EMAIL IS NOT NULL;

/*CLAUSULA UPDATE NÃO FAZER UPDATE SEM WHERE*/
/*SE FIZER ALGO ERRADO DA PRA VOLTAR COM COMMIT E ROLBACK*/

SELECT NOME, CPF FROM CLIENTES;

UPDATE CLIENTES
SET CPF = '01242424242'
WHERE NOME = 'IAGO';


/*CLAUSULA DELETE - TAMBÉM USAR COM WHERE*/

SELECT * FROM CLIENTES WHERE NOME = 'IAGO';

SELECT COUNT(*) FROM CLIENTES; -- TOTAL DE 3

DELETE FROM CLIENTES
WHERE NOME = 'IAGO';

SELECT COUNT(*) FROM CLIENTES; -- TOTAL DE 2


/*TRABALHANDO CARDINALIDADE*/

CREATE DATABASE COMERCIO;

USE COMERCIO;
/*NOT NULL DIZ QUE É OBRIGATORIO PREENCHER*/
/*UNIQUE - NÃO É OBRIGATORIO, MAS SÓ PODE SER USADO UMA VEZ*/

CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL
);

CREATE TABLE TELEFONE (
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES', 'COM', 'CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL
);

/*ENDEREÇO OBG SOMENTE 1*/
/*TELEFONE NAO OBG PODE MAIS DE UM*/

/*FK - CHAVE PRIMARIA DE UMA TABELA QUE VAI ATE A OUTRA TABELA PARA FAZER REFERENCIA ENTRE REGISTROS*/

--FK DEPENDE DA CARDINALIDADE -- NECESSÁRIO ANALISAR A REGRA DE NEGOCIO PARA SABER A TABELA MAIS FRACA
-- EM RELACIONAMENTOS 1, 1 A FK FICA NA TABELA MAIS FRACA
-- RELACIONAMENTOS 1, N A FK FICA SEMPRE NO LADO N

DROP TABLE CLIENTE;
DROP TABLE ENDERECO;
DROP TABLE TELEFONE;

--CRIANDO CONSTRAINT

CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE,
	FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE TELEFONE (
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES', 'COM', 'CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,
	FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE)
);

INSERT INTO CLIENTE VALUES(NULL, 'IAGO', 'M', 'IAGO@HOTMAIL.COM', '01212365484');
INSERT INTO CLIENTE VALUES(NULL, 'IAGO', 'M', 'JOAO@HOTMAIL.COM', '01212365484');
INSERT INTO CLIENTE VALUES(NULL, 'IAGO', 'F', 'CLARA@HOTMAIL.COM', '14595231201');
INSERT INTO CLIENTE VALUES(NULL, 'IAGO', 'M', 'PEDRO@HOTMAIL.COM', '01212365484');
INSERT INTO CLIENTE VALUES(NULL, 'IAGO', 'F', NULL, '01247365484');

INSERT INTO ENDERECO VALUES(NULL, 'RUA A', 'CENTRO', 'BH', 'MG', 1);
INSERT INTO ENDERECO VALUES(NULL, 'RUA B', 'LAPA', 'RJ', 'RJ', 6);
INSERT INTO ENDERECO VALUES(NULL, 'RUA C', 'FUNDOS', 'SP', 'SP', 3);

INSERT INTO TELEFONE VALUES(NULL, 'RES', '998286325', 6);
INSERT INTO TELEFONE VALUES(NULL, 'COM', '999715132', 6);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '997526231', 3);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '992523121', 1);

--JUNÇÕES SELEÇÃO, PROJEÇÃO E JUNÇÃO

--PROJEÇÃO - TUDO QUE QUER VER NA TELA (SELECT) SELECT * FROM TELEFONE;

--SELEÇÃO - FILTRAR UM SUBCONJUNTO DE UM CONJUNTO TOTAL DE REGISTROS (WHERE)

--JUNÇÃO - (JOIN) JUNTAR TABELAS

SELECT NOME, SEXO, BAIRRO, CIDADE
FROM CLIENTE
	INNER JOIN ENDERECO
	ON IDCLIENTE = ID_CLIENTE;
	
SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

-- DDL
-- DQL
-- DML
-- DCL
-- DTL OU TCL

--DDL ALTER TABLE, CHANGE, MODIFY

-- ALTERAR PRECO POR VALOR_UNITARIO
ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;

--ALTERAR O TIPO DE COLUNA
ALTER TABLE PRODUTO
MODIFY VALOR_UNITARIO VARCHAR(30) NOT NULL;

--ADCIONANDO UMA COLUNA A UMA TABELA

ALTER TABLE PRODUTO
ADD PESO FLOAT(10,2) NOT NULL;

--APAGANDO UMA COLUNA
ALTER TABLE PRODUTO
DROP COLUMN PESO;

--ADD UMA COLUNA EM ORDEM ESPECIFICA
ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NOT NULL
AFTER NOME_PRODUTO;

ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NO NULL
FIRST;


-- FUNÇÕES IFNULL 
-- FUNÇÕES COM PARAMETROS E SEM PARAMETROS



SELECT 	C.NOME, 
		IFNULL(C.EMAIL, 'NAO TEM EMAIL') AS EMAIL, 
		E.ESTADO, 
		T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;



--VIEWS FUNCIONA COMO UM PONTEIRO PARA UMA QUERY



SELECT 	C.NOME, 
		C.SEXO, 
		IFNULL(C.EMAIL, 'NAO POSSUI EMAIL') AS EMAIL, 
		T.TIPO, 
		T.NUMERO, 
		E.BAIRRO, 
		E.CIDADE, 
		E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

--CRIANDO UMA VIEW

CREATE VIEW RELATORIO AS 
SELECT C.NOME, 
C.SEXO, 
IFNULL(C.EMAIL, 'NAO POSSUI EMAIL') AS EMAIL, 
T.TIPO, 
T.NUMERO, 
E.BAIRRO, 
E.CIDADE, 
E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

--LOCALIZANDO UMA VIEW NO BD

SHOW TABLES;

-- APAGANDO UMA VIEW
DROP VIEW RELATORIO;

-- INSERINDO UM PREFIXO

CREATE VIEW V_RELATORIO AS 
SELECT C.NOME, 
C.SEXO, 
IFNULL(C.EMAIL, 'NAO POSSUI EMAIL') AS EMAIL, 
T.TIPO, 
T.NUMERO, 
E.BAIRRO, 
E.CIDADE, 
E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;


--DML COM VIEWS (UPDATE, INSERT E DELETE) SÓ É PERMITIDO
--FAZER UPDATE COM JOIN É PERMITIDO, INSERT E DELETE NÃO 


SELECT * FROM V_RELATORIO WHERE SEXO = 'F';


--ORDER BY

CREATE TABLE ALUNOS (
NUMERO INT,
NOME VARCHAR(30)
);


INSERT INTO ALUNOS VALUES(10, 'IAGO');
INSERT INTO ALUNOS VALUES(20, 'JOAO');
INSERT INTO ALUNOS VALUES(30, 'ANDRE');
INSERT INTO ALUNOS VALUES(100, 'ANA');
INSERT INTO ALUNOS VALUES(01, 'PEDRO');

CREATE VIEW V_ALUNO AS 
SELECT NOME
FROM ALUNOS;

SELECT * FROM ALUNOS
ORDER BY NUMERO;

-- ORDENANDO POR MAIS DE UMA COLUNA

SELECT * FROM ALUNOS
ORDER BY NUMERO, NOME;

SELECT * FROM ALUNOS
ORDER BY NUMERO DESC, NOME DESC;

--DELIMITER ;
--ALTERANDO O DELIMITER

DELIMITER $

--STORED PROCEDURES - PROCEDIMENTOS ARMAZENADOS (ANONIMOS E NOMEADOS)

DELIMITER $

CREATE PROCEDURE NOME_EMPRESA()
BEGIN
	SELECT "UNIVERSIDADE DOS DADOS" AS EMPRESA;

END$

--CHAMANDO UMA PROCEDURE
DELIMITER ;
CALL NOME_EMPRESA();

--PASSANDO PARAMETROS PARA PROCEDURES
DELIMITER $
CREATE PROCEDURE CONTA()
BEGIN
	SELECT 10 + 10 AS CONTA;

END$

DELIMITER ;
CALL CONTA();

--DELETANDO UMA PROCEDURE
DROP PROCEDURE CONTA;
DELIMITER $

CREATE PROCEDURE CONTA(NUMERO1 INT, NUMERO2 INT)
BEGIN
	SELECT NUMERO1 + NUMERO2 AS CONTA;

END$

DELIMITER ;

CALL CONTA(10,20);

--PROCEDURES NO MUNDO REAL EM TABELAS
-- VIEW - FRONTEND  CONTROLE(REGRA DE NEGÓCIOS - SERVIDOR DE APLICAÇÃO) - C# PHP JAVA RUBY JAVASCRIPT  MODEL(SERVIDOR DE DADOS) - TABELAS EM BD

--COLOCAR A REGRA DE NEGÓCIOS NO BANCO DE DADOS UTILIZAR PROCEDURES

--PROCEDURE DE SELECT É FEITA PARA EVITAR SQL INJECTION 

CREATE DATABASE PROJETO;

USE PROJETO;

CREATE TABLE CURSOS (
	IDCURSO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	HORAS INT(3) NOT NULL,
	VALOR FLOAT(10,2) NOT NULL
);

INSERT INTO CURSOS VALUES(NULL, 'JAVA', 30, 500.00);
INSERT INTO CURSOS VALUES(NULL, 'FUNDAMENTOS DE BANCOS DE DADOS', 40, 700.00);

DELETE FROM CURSOS
WHERE IDCURSO = 2;

--1 PROCEDURE PARA CADASTRAR

DELIMITER $

CREATE PROCEDURE CAD_CURSOS(P_NOME VARCHAR(30), 
							P_HORAS INT(30), 
							P_PRECO FLOAT(10,2))
BEGIN
	INSERT INTO CURSOS VALUES(NULL, P_NOME, P_HORAS, P_PRECO);

END
$

DELIMITER ;
CALL CAD_CURSOS('BI SQL SERVER', 35, 3.000.00);
CALL CAD_CURSOS('POWER BI', 35, 3000.00);
CALL CAD_CURSOS('TABLEAU', 35, 3.000);

SELECT * FROM CAD_CURSOS;



DELETE FROM CURSOS
WHERE IDCURSO = '6';


UPDATE CURSOS
SET VALOR = '3000.00'
WHERE IDCURSO = '11';

CREATE TABLE CURSOS(
	IDCURSOS INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	HORAS INT(3) NOT NULL,
	VALOR FLOAT(10,2) NOT NULL
);

DELIMITER $

CREATE PROCEDURE CAD_CURSO(P_NOME VARCHAR(30), P_HORAS INT(3), P_VALOR FLOAT(10,2))
BEGIN
	INSERT INTO CURSOS VALUES(NULL, P_NOME, P_HORAS, P_VALOR);
END
$

DELIMITER ;

CALL CAD_CURSOS('POWER BI', 30, 500.00);
CALL CAD_CURSOS('SQL', 45, 700.00);
CALL CAD_CURSOS('PYTHON', 60, 1200.00);

--1 PROCEDURE PARA LER OS DADOS

DELIMITER $

CREATE PROCEDURE SEL_CURSO()
BEGIN
	SELECT IDCURSOS, NOME, HORAS, VALOR
	FROM CURSOS;

END
$

DELIMITER ;

CALL SEL_CURSOS();

-- TRIGGERS - GATILHO

DELIMITER $

CREATE TRIGGER NOME
BEFORE/AFTER INSERT/DELETE/UPDATE ON TABELA
FOR EACH ROW 
BEGIN

END
$

CREATE DATABASE AULA;

USE AULA;

CREATE TABLE USUARIO (
	IDUSUARIO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30),
	SENHA VARCHAR(100)
);

CREATE TABLE BKP_USUARIO (
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDUSUARIO INT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30)
);

DELIMITER $

CREATE TRIGGER BACKUP_USER BEFORE DELETE
ON USUARIO 
FOR EACH ROW
BEGIN	
	INSERT INTO BKP_USUARIO VALUES
	(NULL, OLD.IDUSUARIO, OLD.NOME, OLD.LOGIN);
END
$	

INSERT INTO USUARIO VALUES(NULL, 'IAGO', 'CAMPIDELI', '1234');


DELETE FROM USUARIO
WHERE IDUSUARIO = '1';

SELECT * FROM BKP_USUARIO;

--TRIGGERS PARA BANCOS DE BACKUP
--COMO UM BANCO SE COMUNICA COM O OUTRO

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO (
IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR(30),
VALOR FLOAT(10,2)
);

STATUS

CREATE DATABASE BKP_LOJA;

USE BKP_LOJA;

CREATE TABLE BKP_PRODUTO (
IDBKP INT PRIMARY KEY AUTO_INCREMENT,
IDPRODUTO INT,
NOME VARCHAR(30),
VALOR FLOAT(10,2)
);

USE LOJA;

STATUS

INSERT INTO BKP_LOJA.BKP_PRODUTO VALUES(NULL, 1000, 'TESTE', 0.0);

SELECT * FROM BKP_LOJA.BKP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUT 
BEFORE INSERT ON PRODUTO 
FOR EACH ROW
BEGIN	
	INSERT INTO BKP_LOJA.BKP_PRODUTO VALUES
	(NULL, NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);
END
$

INSERT INTO PRODUTO VALUES(NULL, 'LIVRO MODELAGEM', 50.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO BI', 80.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO ORACLE', 70.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO SQL SERVER', 100.00);


CREATE TRIGGER PRODUCT BEFORE INSERT
ON PRODUO 
FOR EACH ROW
BEGIN	
	INSERT INTO BKP_LOJA.BKP_PRODUTO VALUES
	(NULL, NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);
END
$
DELIMITER ;
DELIMITER $

CREATE TRIGGER BACKUP_PRODUT0_DEL 
BEFORE DELETE ON PRODUTO 
FOR EACH ROW
BEGIN	
	INSERT INTO BKP_LOJA.BKP_PRODUTO VALUES
	(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR);
END
$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL, 'TESTE DOIDO', 70.00);
INSERT INTO PRODUTO VALUES(NULL, 'TESTE DE SQL SERVER', 100.00);

SELECT * FROM BKP_LOJA.BKP_PRODUTO;

DELETE FROM PRODUTO
WHERE IDPRODUTO = '6';

SELECT * FROM BKP_LOJA.BKP_PRODUTO;

SELECT * FROM PRODUTO;

DROP TRIGGER BACKUP_PRODUT;

CREATE TRIGGER BACKUP_PRODUTO 
AFTER INSERT ON PRODUTO 
FOR EACH ROW
BEGIN	
	INSERT INTO BKP_LOJA.BKP_PRODUTO VALUES
	(NULL, NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);
END
$

ALTER TABLE BKP_LOJA.BKP_PRODUTO
ADD EVENTO CHAR(1);

DELIMITER $

DROP TRIGGER BACKUP_PRODUT0_DEL;

CREATE TRIGGER BACKUP_PRODUT0_DEL 
BEFORE DELETE ON PRODUTO 
FOR EACH ROW
BEGIN	
	INSERT INTO BKP_LOJA.BKP_PRODUTO VALUES
	(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR, 'D');
END
$

DELIMITER ;

DELETE FROM PRODUTO
WHERE IDPRODUTO = '4';

SELECT * FROM BKP_LOJA.BKP_PRODUTO;

--TRIGGER DE AUDITORIA

DELIMITER ;

DROP DATABASE LOJA;

DROP DATABASE BKP_LOJA;

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO (
IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR(30),
VALOR FLOAT(10,2)
);

INSERT INTO PRODUTO VALUES(NULL, 'LIVRO MODELAGEM', 50.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO BI', 80.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO ORACLE', 70.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO SQL SERVER', 100.00);

CREATE DATABASE BACKUP;

USE BACKUP;

CREATE TABLE BKP_PRODUTO (
IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
IDPRODUTO INT,
NOME VARCHAR(30),
VALOR_ORIGINAL FLOAT(10,2),
VALOR_ALTERADO FLOAT (10,2),
DATA DATETIME,
USUARIO VARCHAR(30),
EVENTO CHAR(1)
);

/*QUANDO*/
SELECT NOW();

/*QUEM*/
SELECT CURRENT_USER();


DELIMITER $

CREATE TRIGGER AUDIT_PROD
AFTER UPDATE ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR, NEW.VALOR, NOW(), CURRENT_USER(), 'U');
END$

DELIMITER ;


UPDATE PRODUTO
SET VALOR = 111.00
WHERE IDPRODUTO = '4';

