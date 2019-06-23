CREATE TABLE REPUBLICA ( 
    TELEFONE VARCHAR(11) NOT NULL, 
    NOME VARCHAR(200) NOT NULL, 
    ESTADO VARCHAR(50), 
    NUMERO VARCHAR(20), 
    LOGRADOURO VARCHAR(200),  
    BAIRRO VARCHAR(200),  
    CIDADE VARCHAR(50),  
    CEP VARCHAR(8),  
    COMPLEMENTO VARCHAR(100),  
    DATA_CRIACAO DATE,  
    CONSTRAINT PK_REPUBLICA PRIMARY KEY (TELEFONE)
);

CREATE TABLE USUARIO (    
    CELULAR VARCHAR(11) NOT NULL,    
    NICKNAME VARCHAR(30),    
    DATA_CRIACAO_CONTA DATE,    
    HASH VARCHAR(32) NOT NULL,    
    ANIVERSARIO DATE,    
    EMAIL VARCHAR(200),    
    NOME VARCHAR(200) NOT NULL,    
    DATA_INGRESSO DATE,    
    TELEFONE_REPUBLICA VARCHAR(11) NOT NULL,    
    CONSTRAINT PK_USUARIO PRIMARY KEY  (CELULAR),    
    CONSTRAINT FK_USUARIO FOREIGN KEY (TELEFONE_REPUBLICA)    
    REFERENCES REPUBLICA(TELEFONE)    
    ON DELETE CASCADE ON UPDATE CASCADE
);

 CREATE TABLE MORADOR (    
    ESTA_EM_CASA INT,    
    CELULAR_USUARIO VARCHAR(11) NOT NULL,    
    CONSTRAINT PK_MORADOR PRIMARY KEY (CELULAR_USUARIO),    
    CONSTRAINT FK_MORADOR FOREIGN KEY (CELULAR_USUARIO)    
    REFERENCES USUARIO(CELULAR)    
    ON DELETE CASCADE ON UPDATE CASCADE
);


 CREATE TABLE EX_MORADOR (    
    DATA_SAIU DATE,    
    CELULAR_USUARIO VARCHAR(11) NOT NULL,    
    CONSTRAINT PK_EX_MORADOR PRIMARY KEY (CELULAR_USUARIO),    
    CONSTRAINT FK_EX_MORADOR FOREIGN KEY (CELULAR_USUARIO)    
    REFERENCES USUARIO(CELULAR)    
    ON DELETE CASCADE ON UPDATE CASCADE
);

 CREATE TABLE FORMADO (    
    DATA_FORMACAO DATE,    
    CELULAR_USUARIO VARCHAR(11) NOT NULL,    
    CONSTRAINT PK_FORMADO PRIMARY KEY (CELULAR_USUARIO),    
    CONSTRAINT FK_FORMADO FOREIGN KEY (CELULAR_USUARIO)    
    REFERENCES USUARIO(CELULAR)    
    ON DELETE CASCADE ON UPDATE CASCADE
);

 CREATE TABLE CAIXINHA (    
    ID_CAIXINHA VARCHAR(32) NOT NULL,    
    DATA_CRIACAO DATE,    
    DESCRICAO VARCHAR(500),    
    VALOR_TOTAL DOUBLE PRECISION,    
    CELULAR_USUARIO VARCHAR(11),    
    CONSTRAINT PK_CAIXINHA PRIMARY KEY (ID_CAIXINHA),    
    CONSTRAINT FK_CAIXINHA FOREIGN KEY (CELULAR_USUARIO)    
    REFERENCES USUARIO(CELULAR)    
    ON DELETE SET NULL ON UPDATE CASCADE
);


 CREATE TABLE USUARIO_PAGA_CAIXINHA (    
    ID_CAIXINHA VARCHAR(32) NOT NULL,    
    CELULAR_USUARIO VARCHAR(11) NOT NULL,    
    VALOR_POR_MORADOR DOUBLE PRECISION,    
    CONSTRAINT PK_USUARIO_PAGA_CAIXINHA PRIMARY KEY (CELULAR_USUARIO,ID_CAIXINHA),    
    CONSTRAINT FK_USUARIO_PAGA_CAIXINHA_1 FOREIGN KEY (CELULAR_USUARIO)    
    REFERENCES USUARIO(CELULAR)    
    ON DELETE CASCADE ON UPDATE CASCADE,    
    CONSTRAINT FK_USUARIO_PAGA_CAIXINHA_2 FOREIGN KEY (ID_CAIXINHA)    
    REFERENCES CAIXINHA(ID_CAIXINHA)    
    ON DELETE CASCADE ON UPDATE CASCADE
);

 CREATE TABLE CONTA (    
    ID_CONTA VARCHAR(32) NOT NULL,    
    DATA_ATUALIZACAO DATE,    
    DATA_CRIACAO DATE,    
    DATA_EXPIRACAO DATE NOT NULL,    
    DESCRICAO VARCHAR(500),    
    STATUS VARCHAR(50),    
    VALOR DOUBLE PRECISION NOT NULL,    
    ID_CAIXINHA VARCHAR(32) NOT NULL,    
    CONSTRAINT PK_CONTA PRIMARY KEY (ID_CONTA),    
    CONSTRAINT FK_CONTA FOREIGN KEY (ID_CAIXINHA)    
    REFERENCES CAIXINHA(ID_CAIXINHA)    
    ON DELETE CASCADE ON UPDATE CASCADE
);

 CREATE TABLE PRODUTO (    
    ID_PRODUTO VARCHAR(32) NOT NULL,    
    NOME VARCHAR(200) NOT NULL,
    CONSTRAINT PK_PRODUTO PRIMARY KEY (ID_PRODUTO));

 CREATE TABLE COMPRA (    
    ID_COMPRA VARCHAR(32) NOT NULL,    
    DATA_COMPRA DATE,    
    DATA_CRIACAO DATE,    
    DESCRICAO VARCHAR(500),    
    VALOR_TOTAL_COMPRA DOUBLE PRECISION,    
    USUARIO_RESPONSAVEL VARCHAR(11) NOT NULL,    
    CONSTRAINT PK_COMPRA PRIMARY KEY (ID_COMPRA),    
    CONSTRAINT FK_COMPRA FOREIGN KEY (USUARIO_RESPONSAVEL)    
    REFERENCES USUARIO(CELULAR)
);


 CREATE TABLE COMPRA_POSSUI_PRODUTO (    
    ID_PRODUTO VARCHAR(32) NOT NULL,    
    ID_COMPRA VARCHAR(32) NOT NULL,    
    CONSTRAINT PK_COMPRA_POSSUI_PRODUTO PRIMARY KEY (ID_PRODUTO,ID_COMPRA),       
    CONSTRAINT FK_COMPRA_POSSUI_PORDUTO1 FOREIGN KEY (ID_PRODUTO)    
    REFERENCES PRODUTO(ID_PRODUTO)    
    ON DELETE CASCADE ON UPDATE CASCADE,    
    CONSTRAINT FK_COMPRA_POSSUI_PORDUTO2 FOREIGN KEY (ID_COMPRA)    
    REFERENCES COMPRA(ID_COMPRA)    
    ON DELETE CASCADE ON UPDATE CASCADE
);

 CREATE TABLE AFAZER (    
    ID_AFAZER VARCHAR(32) NOT NULL,    
    DESCRICAO VARCHAR(500),    
    NOME VARCHAR(200) NOT NULL,    
    CELULAR_USUARIO VARCHAR(11) NOT NULL,    
    CONSTRAINT PK_AFAZER PRIMARY KEY (ID_AFAZER),    
    CONSTRAINT FK_AFAZER FOREIGN KEY (CELULAR_USUARIO)    
    REFERENCES USUARIO(CELULAR)
);

  CREATE TABLE TAREFA (    
    ID_AFAZER VARCHAR(32) NOT NULL,    
    CICLO  VARCHAR(25) NOT NULL,    
    CONSTRAINT PK_TAREFA PRIMARY KEY (ID_AFAZER),    
    CONSTRAINT FK_TAREFA FOREIGN KEY (ID_AFAZER)    
    REFERENCES AFAZER(ID_AFAZER)   
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PROBLEMA (    
    ID_AFAZER VARCHAR(32) NOT NULL,    
    STATUS  VARCHAR(50) NOT NULL,    
    DATA_IDENTIFICACAO DATE,    
    DATA_SOLUCAO DATE,    
    CELULAR_USUARIO VARCHAR(11),     
    CONSTRAINT PK_PROBLEMA PRIMARY KEY (ID_AFAZER),    
    CONSTRAINT FK_PROBLEMA1 FOREIGN KEY (ID_AFAZER)    
    REFERENCES AFAZER(ID_AFAZER)    
    ON DELETE CASCADE ON UPDATE CASCADE,    
    CONSTRAINT FK_PROBLEMA2 FOREIGN KEY (CELULAR_USUARIO)    
    REFERENCES USUARIO(CELULAR)    
    ON DELETE SET NULL ON UPDATE CASCADE
);
