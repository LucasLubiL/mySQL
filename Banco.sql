create database banco;

use banco;

create table banco(

    codigo int auto_increment primary key,
    nome varchar(45)

);
insert into banco (nome) values('Banco do Brasil');
insert into banco (nome) values('CEF');

create table agencia(
 
    numero_agencia int not null,
    cod_banco int not null,
    endereco varchar(100),
    primary key (numero_agencia,cod_banco),
    foreign key(cod_banco) references banco(codigo)

);
insert into agencia (numero_agencia , endereco , cod_banco) values(0562 , 'Rua Joaquim Teixeira Alves, 1555' , 1);
insert into agencia (numero_agencia , endereco , cod_banco) values(3153 , 'Av. Marcelino Pires, 1960' , 2);

/*3*/ ALTER TABLE conta DROP FOREIGN KEY conta_ibfk_1;
      ALTER TABLE conta ADD CONSTRAINT conta_ibfk_1 FOREIGN KEY (num_agencia) REFERENCES agencia (numero_agencia) ON UPDATE CASCADE;
      update agencia
      	set numero_agencia = 6342
    	where numero_agencia = 0562 and cod_banco = 1;

/*6*/ insert into agencia (numero_agencia , endereco , cod_banco) values(1333 , 'Rua João José da Silva, 486' , 1);

/*7*/ select numero_agencia, endereco
		from agencia
		where cod_banco = 1;
    
create table conta(

    num_conta varchar(7) primary key not null,
    saldo float not null,
    tipo_conta int,
    num_agencia int,
    foreign key(num_agencia) references agencia(numero_agencia)

);
insert into conta (num_conta , saldo , tipo_conta , num_agencia) values('86340-2' , 763.05 , '2' , 3153);
insert into conta (num_conta , saldo , tipo_conta , num_agencia) values('23584-7' , 3879.12 , '1' , 0562);
/*5*/ update conta
	    set saldo = saldo * 0.10
	    where num_conta = '23584-7';

/*9*/   DELETE FROM conta WHERE num_conta = '86340-2';

create table cliente(

    cpf varchar(14) primary key not null,
    nome varchar(45) not null,
    endereco varchar(100),
    sexo char(1)

);
insert into cliente (cpf , nome , endereco , sexo ) values('111.222.333-44' , 'Jennifer B Souza' , 'Rua Cuiabá, 1050' , 'F');
insert into cliente (cpf , nome , endereco , sexo ) values('666.777.888-99' , 'Caetano K Lima' , 'Rua Ivinhema, 879' , 'M');
insert into cliente (cpf , nome , endereco , sexo ) values('555.444.777-33' , 'Silvia Macedo' , 'Rua Estados Unidos, 735' , 'F');
/*1*/ alter table cliente add column email varchar(200);
/*2*/ select cpf, endereco
         from cliente
         where nome like 'C%';
                 
/*4*/ update cliente
      	set email = 'caetanolima@gmail.com'
    	where cpf = '666.777.888-99';

/*8*/ select *
		from cliente
		where sexo = 'M';

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
insert into historico (cpf , num_conta , data_inicio) values('555.444.777-33' , '86340-2' , '2010-11-29');


/*9*/ ALTER TABLE historico DROP FOREIGN KEY historico_ibfk_2;
      ALTER TABLE historico
	     ADD CONSTRAINT historico_ibfk_2 FOREIGN KEY (num_conta) 
         REFERENCES conta(num_conta) ON DELETE CASCADE;


create table telefone_cliente(
    
    cpf_cli varchar(14) not null,
    telefone varchar(20) not null,
    primary key(cpf_cli,telefone),
    foreign key(cpf_cli) references cliente(cpf)
    
);
insert into telefone_cliente (cpf_cli , telefone) values('111.222.333-44' , '(67)3422-7788');
insert into telefone_cliente (cpf_cli , telefone) values('666.777.888-99' , '(67)3423-9900');
insert into telefone_cliente (cpf_cli , telefone) values('666.777.888-99' , '(67)8121-8833');