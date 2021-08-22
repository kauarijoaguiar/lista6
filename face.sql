DROP TABLE USUARIO;

DROP TABLE AMIZADE;

DROP TABLE ASSUNTO;

DROP TABLE ASSUNTOPOST;

DROP TABLE CITACAO;

DROP TABLE REACAO;

DROP TABLE COMPARTILHAMENTO;

DROP TABLE POST;

DROP TABLE GRUPO;

DROP TABLE GRUPOUSUARIO;


CREATE TABLE USUARIO(
    EMAIL CHAR (100) NOT NULL,
    NOME CHAR(100) NOT NULL,
    DATACADASTRO DATETIME,
    CIDADE CHAR(100),
    PAIS CHAR(100),
    UF CHAR(100),
    GENERO CHAR (1),
    NASCIMENTO date,
    ATIVO BOOLEAN,
    PRIMARY KEY (EMAIL)
);

CREATE TABLE GRUPO(
    CODIGO INTEGER NOT NULL,
    NOMEGRUPO CHAR(100) NOT NULL, 
    PRIMARY KEY(CODIGO)
);

CREATE TABLE GRUPOUSUARIO(
    CODIGOGRUPO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    PRIMARY KEY (CODIGOGRUPO, EMAIL_USUARIO)
);
CREATE TABLE AMIZADE(
    EMAIL_USUARIO1 CHAR (100) NOT NULL,
    EMAIL_USUARIO2 CHAR (100) NOT NULL,
    DATAAMIZADE DATETIME,
    FOREIGN KEY (EMAIL_USUARIO1) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (EMAIL_USUARIO2) REFERENCES USUARIO(EMAIL),
    PRIMARY KEY (EMAIL_USUARIO1, EMAIL_USUARIO2)
);

CREATE TABLE ASSUNTO(
    CODIGO INTEGER NOT NULL,
    ASSUNTO CHAR(4096),
    PRIMARY KEY (CODIGO)
);

CREATE TABLE ASSUNTOPOST(
    CODIGOASSUNTO INTEGER NOT NULL,
    CODIGOPOST INTEGER NOT NULL,
    FOREIGN KEY (CODIGOASSUNTO) REFERENCES ASSUNTO(CODIGO),
    FOREIGN KEY (CODIGOPOST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGOASSUNTO, CODIGOPOST)
);

CREATE TABLE CITACAO(
    CODIGO INTEGER NOT NULL,
    COD_POST INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (COD_POST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO, COD_POST, EMAIL_USUARIO)
);

CREATE TABLE REACAO(
    CODIGO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    TIPOREACAO CHAR(10) NOT NULL,
    COD_POST INTEGER NOT NULL,
    CIDADE CHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    PAIS CHAR(100) NOT NULL,
    DATAREACAO DATETIME,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (COD_POST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO)
);

CREATE TABLE COMPARTILHAMENTO(
    CODIGO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    COD_POST INTEGER NOT NULL,
    CIDADE CHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    DATACOMPARTILHAMENTO DATETIME,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (COD_POST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO)
);

CREATE TABLE POST(
    CODIGO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    POST CHAR(1000) NOT NULL,
    CIDADE CHAR (100) NOT NULL,
    UF CHAR (100) NOT NULL,
    PAIS CHAR (100) NOT NULL,
    DATAPOST DATETIME,
    CODPOSTREFERENCIA INTEGER,
    QTDCOMENTARIOS INTEGER NOT NULL DEFAULT 0,
    QTDREACOES INTEGER NOT NULL DEFAULT 0,
CODIGOGRUPO INTEGER,
CLASSIFICACAO CHAR (100),
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (CODPOSTREFERENCIA) REFERENCES POST(CODIGO),
    FOREIGN KEY (CODIGOGRUPO) REFERENCES GRUPO(CODIGO),
    PRIMARY KEY (CODIGO)
);

    INSERT INTO 
    GRUPO(
        CODIGO,
        NOMEGRUPO
    )
    VALUES
    (
        1,
        'SQLite'
    ),
    (
        2,
        'Banco de Dados-IFRS-2021'
    ),
    (
        3,
        'IFRS-Campus Rio Grande'
    )
    ;

INSERT INTO
    USUARIO(
        EMAIL,
        NOME,
        DATACADASTRO,
        CIDADE,
        PAIS,
        UF,
        GENERO,
        NASCIMENTO,
        ATIVO
    )
VALUES
    (
        'joaosbras@mymail.com',
        'João Silva Brasil',
        '2020-01-01 13:00:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'M',
        '1998-02-02',
        true
    ),
    (
        'pmartinssilva90@mymail.com',
        'Paulo Martins Silva',
        null,
        null,
        null,
        null,
        'M',
        '2003-05-23',
        true
    ),
    (
        'mcalbuq@mymail.com',
        'Maria Cruz Albuquerque',
        '2020-01-01 13:10:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'F',
        '2002-11-04',
        true
    ),
    (
        'jorosamed@mymail.com',
        'Joana Rosa Medeiros',
        '2020-01-01 13:15:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'N',
        '1974-02-05',
        true
    ),
    (
        'pxramos@mymail.com',
        'Paulo Xavier Ramos',
        '2020-01-01 13:20:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'N',
        '1966-03-30',
        true
    ),
    (
        'pele@cbf.com.br',
        'Edson Arantes do Nascimento',
        null,
        'Três Corações',
        'Brasil',
        'MG',
        'M',
        '1940-10-23',
        true
    ),
    (
        'alice@mail.com.br',
        'Alice Da Cunha',
        null,
        'Três Corações',
        'Brasil',
        'MG',
        'F',
        '2001-07-04',
        true
    );

INSERT INTO
    AMIZADE(EMAIL_USUARIO1, EMAIL_USUARIO2, DATAAMIZADE)
VALUES
    ('pxramos@mymail.com','jorosamed@mymail.com', '2021-05-17 10:15:00'),
    ('jorosamed@mymail.com', 'pele@cbf.com.br', '2021-05-17 10:15:00'),
    ('mcalbuq@mymail.com', 'pele@cbf.com.br', '2021-05-17 10:20:00' ),
    ( 'jorosamed@mymail.com','mcalbuq@mymail.com','2021-05-17 10:20:00' ),
    ('joaosbras@mymail.com', 'pele@cbf.com.br', '2021-05-20 20:27:00' );
INSERT INTO
    POST(
        CODIGO,
        EMAIL_USUARIO,
        POST,
        CIDADE,
        UF,
        PAIS,
        DATAPOST,
        CODPOSTREFERENCIA,
        QTDREACOES,
        QTDCOMENTARIOS,
        CODIGOGRUPO,
        CLASSIFICACAO
    )
VALUES
    (
        1,
        'joaosbras@mymail.com',
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'Rio Grande',
        'RS',
        'Brasil',
        '2015-06-02 15:00:00',
        null,
        1,
        2,
        null,
        null
    ),
    (
        2,
        'joaosbras@mymail.com',
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-07-15 15:00:00',
        null,
        1,
        2,
        3,
        'odio'
    ),
    (
        3,
        'jorosamed@mymail.com',
        'Alguém mais ficou com dúvida no comando INSERT?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:15:00',
        1,
        1,
        0,
        1,
        null
    ),
    (
        4,
        'pxramos@mymail.com',
        'Eu também',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:20:00',
        3,
        0,
        0,
        null,
        null
    ),
    (
        5,
        'joaosbras@mymail.com',
        'Já agendaste horário de atendimento com o professor?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:30:00',
        4,
        0,
        0,
        null,
        null
    ),
    (
        6,
        'pmartinssilva90@mymail.com',
        'Ontem aprendi sobre joins no SQLite na disciplina de banco de dados do IFRS.',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-08 18:30:00',
        null,
        0,
        0,
        2,
        null
    ),
    (
        7,
        'pele@cbf.com.br',
        'Show!',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-08 20:34:02',
        6,
        0,
        0,
        2,
        null
    ),
     (
        8,
        'joaosbras@mymail.com',
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:00:00',
        null,
        1,
        2,
        null,
        null
    ),
     (
        9,
        'joaosbras@mymail.com',
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'a',
        'b',
        'EUA',
        '2021-06-02 15:00:00',
        null,
        1,
        2,
        null, 
        null
    ),
     (
        10,
        'joaosbras@mymail.com',
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'a',
        'b',
        'EUA',
        '2021-06-02 15:00:00',
        null,
        1,
        2,
        null,
        null
    ),
     (
        11,
        'joaosbras@mymail.com',
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'c',
        'd',
        'Cuba',
        '2021-06-02 15:00:00',
        null,
        1,
        2,
        null,
        null
    ),
     (
        12,
        'pele@cbf.com.br',
        'SHOW!',
        'Rio de Janeiro',
        'RJ',
        'Brasil',
        '2021-06-02 15:00:00',
        10,
        1,
        2,
        null,
        null
    ),
    (
        13,
        'pele@cbf.com.br',
        'Brasil: 20 medalhas nas Olimpíadas 2020/2021 em Tóquio',
        'Rio de Janeiro',
        'RJ',
        'Brasil',
        '2021-08-05 15:00:00',
        null,
        0, 
        0, 
        null,
        null
    );

INSERT INTO
    ASSUNTO(CODIGO, ASSUNTO)
VALUES
    (1, 'BD'),
    (2, 'SQLite'),
    (3, 'INSERT'),
    (4, 'atendimento'),
    (5, 'SELECT');

INSERT INTO
    ASSUNTOPOST (CODIGOPOST, CODIGOASSUNTO)
VALUES
    (1, 1),
    (1, 2),
    (3, 1),
    (3, 2),
    (3, 3),
    (5, 4),
    (5, 1),
    (6, 1),
    (6, 2),
    (8, 5),
    (9, 1),
    (10, 2),
    (11, 1);

INSERT INTO
    REACAO(
        CODIGO,
        TIPOREACAO,
        EMAIL_USUARIO,
        CIDADE,
        UF,
        PAIS,
        COD_POST,
        DATAREACAO
    )
values
    (
        2,
        'Amei',
        'mcalbuq@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        1,
        '2021-06-02 15:10:00'
    ),
    (
        3,
        'Curtida',
        'pxramos@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        3,
        '2021-06-02 15:20:00'
    ),
        (
        4,
        'Curtida',
        'pxramos@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        3,
        '2021-06-03 15:21:00'
    ),
    (
        5,
        'Triste',
        'joaosbras@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        3,
        '2021-06-02 15:50:00'
    );


INSERT INTO
    GRUPOUSUARIO(
        CODIGOGRUPO,
        EMAIL_USUARIO
    )
values
    (2,
    'pxramos@mymail.com'),
    (2,
    'mcalbuq@mymail.com'),
    (1, 
    'joaosbras@mymail.com'), 
    (1, 
    'pxramos@mymail.com');
    

INSERT INTO COMPARTILHAMENTO(
    CODIGO,
    EMAIL_USUARIO,
    COD_POST,
    CIDADE,
    UF,
    DATACOMPARTILHAMENTO
) VALUES
(
    1, 
    'joaosbras@mymail.com',
    6,
    'Rio Grande',
    'RS', 
    '2021-06-10 13:00:00'
);


--A) 
UPDATE POST
SET POST = 'Brasil: 21 medalhas nas Olimpíadas 2020/2021 em Tóquio'
WHERE EMAIL_USUARIO='pele@cbf.com.br'
AND POST LIKE '%Brasil: 20 medalhas nas Olimpíadas 2020/2021 em Tóquio%'
AND DATAPOST = (SELECT MAX(DATAPOST) FROM POST WHERE EMAIL_USUARIO='pele@cbf.com.br');

--B)

UPDATE REACAO
SET TIPOREACAO = 'AMEI'
FROM GRUPO, POST
WHERE
REACAO.COD_POST = POST.CODIGO AND
POST.CODIGOGRUPO=GRUPO.CODIGO
AND 
UPPER(GRUPO.NOMEGRUPO) = 'SQLITE'
AND
REACAO.EMAIL_USUARIO = 'pxramos@mymail.com'
AND 
UPPER(TIPOREACAO) = 'CURTIDA'
AND 
DATAREACAO = (SELECT MAX(DATAREACAO) FROM REACAO INNER JOIN POST ON REACAO.COD_POST = POST.CODIGO
INNER JOIN GRUPO ON POST.CODIGOGRUPO = GRUPO.CODIGO
WHERE GRUPO.NOMEGRUPO LIKE '%SQLite%' 
AND REACAO.EMAIL_USUARIO='pxramos@mymail.com');

--C)
UPDATE USUARIO
SET ATIVO = false
FROM (SELECT CASE WHEN MAX(DATAPOST) IS NULL THEN DATETIME('1900-01-01') ELSE MAX(DATAPOST) END AS DATAMAXIMA, EMAIL FROM USUARIO LEFT JOIN POST ON POST.EMAIL_USUARIO = USUARIO.EMAIL GROUP BY EMAIL) AS POST, 
(SELECT CASE WHEN MAX(DATACOMPARTILHAMENTO) IS NULL THEN DATETIME('1900-01-01') ELSE MAX(DATACOMPARTILHAMENTO) END AS DATAMAXIMA, EMAIL FROM USUARIO LEFT JOIN COMPARTILHAMENTO ON COMPARTILHAMENTO.EMAIL_USUARIO = USUARIO.EMAIL GROUP BY EMAIL) AS COMPARTILHAMENTO,
(SELECT CASE WHEN MAX(DATAREACAO) IS NULL THEN DATETIME('1900-01-01') ELSE MAX(DATAREACAO) END AS DATAMAXIMA, EMAIL FROM USUARIO LEFT JOIN REACAO ON REACAO.EMAIL_USUARIO = USUARIO.EMAIL GROUP BY EMAIL) AS REACAO
WHERE 
(USUARIO.EMAIL = POST.EMAIL AND POST.DATAMAXIMA < DATE('now', '-5 years'))
AND 
(USUARIO.EMAIL = COMPARTILHAMENTO.EMAIL AND COMPARTILHAMENTO.DATAMAXIMA < DATE('now', '-5 years'))
AND 
(USUARIO.EMAIL = REACAO.EMAIL AND REACAO.DATAMAXIMA < DATE('now', '-5 years'))
AND USUARIO.PAIS='Brasil';


--D) 
DELETE 
FROM POST
WHERE UPPER(POST.CLASSIFICACAO) = 'ODIO'
AND CODIGOGRUPO = (SELECT CODIGO FROM GRUPO WHERE NOMEGRUPO = 'IFRS-Campus Rio Grande')
AND DATAPOST = (SELECT MAX(DATAPOST) FROM POST, GRUPO WHERE POST.CODIGOGRUPO=GRUPO.CODIGO AND GRUPO.NOMEGRUPO='IFRS-Campus Rio Grande');

--E)

-- 2)

-- 3) Através do controle de concorrência é possível haver segurança de que a compra
-- lugares numerados em um show será feito por uma única pessoa. O método armazena a informação
-- em formato datetime do momento da prospecção de um lugar, de forma a comparar o exato momento
-- de acesso com a data da última modificação armazenada no banco de dados, de forma que o primeiro
-- usuário à acessar a página para compra, ao clicar no botão de compra, terá seu lugar reservado pois
-- a data da última modificação retirada do banco de dados e armazenada em uma variável no fonte é exata
-- mente o mesmo do registro no banco de dados, diferente do usuário que acessar a página um segundo depois,
-- que no momento de procurar o registro na tabela para reservar o lugar não será encontrado, pois a data já foi
-- alterada para o exato instante do usuário que efetivou a compra primeiro.
