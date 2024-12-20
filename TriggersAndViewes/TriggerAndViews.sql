create database auladml;
use auladml;

CREATE TABLE banco (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE agencia (
    numero_agencia INT NOT NULL,
    cod_banco INT NOT NULL,
    endereco VARCHAR(100),
    CONSTRAINT PRIMARY KEY (numero_agencia , cod_banco),
    CONSTRAINT fk_banco FOREIGN KEY (cod_banco)
        REFERENCES banco (codigo)
);

CREATE TABLE cliente (
    cpf VARCHAR(14) NOT NULL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    endereco VARCHAR(100),
    sexo CHAR(1)
);

CREATE TABLE conta (
    num_conta VARCHAR(7) PRIMARY KEY,
    saldo FLOAT NOT NULL DEFAULT 0,
    tipo_conta INT,
    num_agencia INT,
    CONSTRAINT fk_agencia FOREIGN KEY (num_agencia)
        REFERENCES agencia (numero_agencia)
);

CREATE TABLE historico (
    cpf VARCHAR(14) NOT NULL,
    num_conta VARCHAR(7),
    data_inicio DATE,
    CONSTRAINT PRIMARY KEY (cpf , num_conta),
    CONSTRAINT fk_cpf FOREIGN KEY (cpf)
        REFERENCES cliente (cpf),
    CONSTRAINT fk_numconta FOREIGN KEY (num_conta)
        REFERENCES conta (num_conta)
);

CREATE TABLE telefone_cliente (
    cpf_cli VARCHAR(14) NOT NULL,
    telefone VARCHAR(20),
    CONSTRAINT PRIMARY KEY (cpf_cli , telefone),
    CONSTRAINT fk_cpf_cliente FOREIGN KEY (cpf_cli)
        REFERENCES cliente (cpf)
);

insert into banco values (1, "Banco do Brasil");
insert into banco values (4, "CEF");
insert into banco values (null, "Bradesco");

insert into agencia values (0582, 4, "Rua Joaquim Teixeira, 1555");
insert into agencia values (3153, 1, "Av Marcelino Pires, 1960");

insert into cliente values ("111.222.333-44", "Jennifer B Souza", "Rua Cuiabá, 1050", "F");
insert into cliente values ("666.777.888-99", "Caetano K lima", "Rua Invinhema, 879", "M");
insert into cliente values ("555.444.777-33", "Silva Macedo", "Rua Estados Unidos, 735", "F");

insert into conta values("86340-2", 763.05, 2, 3153);
insert into conta values("23584-7", 3879.12, 1, 0582);

insert into historico values ("111.222.333-44", "23584-7", str_to_date("17-12-1997", "%d-%m-%Y"));
insert into historico values ("666.777.888-99", "23584-7", str_to_date("17-12-1997", "%d-%m-%Y"));
insert into historico values ("555.444.777-33", "86340-2", str_to_date("29-11-2010", "%d-%m-%Y"));
 
insert into telefone_cliente values ("111.222.333-44", "(67)3422-7788" );
insert into telefone_cliente values ("666.777.888-99", "(67)3423-9900" );

insert into telefone_cliente values ("666.777.888-99", "(67)8121-8833" );

-- 1
DELIMITER //
Create Trigger insert_Telefone
After Insert ON cliente
  for each row
  BEGIN
     INSERT INTO telefone_cliente (cpf_cli, telefone)
     values (NEW.cpf, '(00)0000-0000'); 
  END //
DELIMITER ;

INSERT INTO cliente (cpf, nome, endereco, sexo)
values ('123.456.789-10', 'Robertinho do Pneu', 'Rua José Azevedo, 231', 'M');

-- 2
DELIMITER //
Create Trigger delete_Cliente
Before DELETE ON cliente
  For each row
  BEGIN
      DELETE FROM telefone_cliente
      Where cpf_cli = OLD.cpf;
  END //
DELIMITER ;

drop trigger delete_Cliente;

DELETE FROM cliente
Where cpf like '123.456.789-10';

-- 3
create table log_registro(
    saldo_new FLOAT NOT NULL DEFAULT 0,
    tipo_conta_new INT,
    num_agencia_new INT,
    saldo_old FLOAT NOT NULL DEFAULT 0,
    tipo_conta_old INT,
    num_agencia_old INT
);
Alter table log_registro ADD column id int auto_increment primary key;

DELIMITER //
   Create Trigger update_conta
   After UPDATE ON conta
      For each row
      BEGIN
          INSERT INTO log_registro (saldo_new, tipo_conta_new, num_agencia_new, saldo_old, tipo_conta_old ,num_agencia_old)
          values(
             NEW.saldo,
             NEW.tipo_conta,
	     NEW.num_agencia,
             OLD.saldo,
             OLD.tipo_conta,
             OLD.num_agencia
          );
      END //
DELIMITER ;

-- 4
CREATE VIEW Registros AS
   select c.nome AS nome_cli, b.nome AS nome_ban, a.endereco, co.num_conta from cliente c
   JOIN historico h ON h.cpf = c.cpf
   JOIN conta co ON h.num_conta = co.num_conta
   JOIN agencia a ON a.numero_agencia = co.num_agencia
   JOIN banco b ON b.codigo = a.cod_banco;
