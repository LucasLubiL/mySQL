create database banco;

use banco;

drop database banco;

create table banco(

    codigo int auto_increment primary key,
    nome varchar(45)

);
insert into banco (nome) values('Banco do Brasil');
insert into banco (nome) values('CEF');

drop table agencia;

create table agencia(
 
    numero_agencia int not null,
    cod_banco int not null,
    endereco varchar(100),
    primary key (numero_agencia,cod_banco),
    foreign key(cod_banco) references banco(codigo)

);
insert into agencia (numero_agencia , endereco , cod_banco) values(0562 , 'Rua Joaquim Teixeira Alves, 1555' , 1);
insert into agencia (numero_agencia , endereco , cod_banco) values(3153 , 'Av. Marcelino Pires, 1960' , 2);

create table conta(

    num_conta varchar(7) primary key not null,
    saldo float not null,
    tipo_conta int,
    num_agencia int,
    foreign key(num_agencia) references agencia(numero_agencia)

);
insert into conta (num_conta , saldo , tipo_conta , num_agencia) values('86340-2' , 763.05 , '2' , 3153);
insert into conta (num_conta , saldo , tipo_conta , num_agencia) values('23584-7' , 3879.12 , '1' , 0562);

create table cliente(

    cpf varchar(14) primary key not null,
    nome varchar(45) not null,
    endereco varchar(100),
    sexo char(1)

);
insert into cliente (cpf , nome , endereco , sexo ) values('111.222.333-44' , 'Jennifer B Souza' , 'Rua Cuiabá' , 'F');
insert into cliente (cpf , nome , endereco , sexo ) values('666.777.888-99' , 'Caetano K Lima' , 'Rua Ivinhema, 879' , 'M');
insert into cliente (cpf , nome , endereco , sexo ) values('555.444.333-22' , 'Silvia Macedo' , 'Rua Estados Unidos, 735' , 'F');

DELETE FROM `banco`.`cliente` WHERE (`cpf` = '666.777.888.99');

create table historico(

    cpf varchar(14) not null,
    num_conta varchar(7) not null,
    data_inicio date,
    primary key(cpf,num_conta),
    foreign key(cpf) references cliente(cpf),
    foreign key(num_conta) references conta(num_conta)

);
insert into historico (cpf , num_conta , data_inicio) values('111.222.333-44' , '23584-7' , '1997-12-17');
insert into historico (cpf , num_conta , data_inicio) values('666.777.888-99' , '23584-7' , '1997-12-17');
insert into historico (cpf , num_conta , data_inicio) values('555.444.333-22' , '86340-2' , '2010-11-29');

create table telefone_cliente(
    
    cpf_cli varchar(14) not null,
    telefone varchar(20) not null,
    primary key(cpf_cli,telefone),
    foreign key(cpf_cli) references cliente(cpf)
    
);
insert into telefone_cliente (cpf_cli , telefone) values('111.222.333-44' , '(67)3422-7788');
insert into telefone_cliente (cpf_cli , telefone) values('666.777.888-99' , '(67)3423-9900');
insert into telefone_cliente (cpf_cli , telefone) values('555.444.333-22' , '(67)8121-8833');

