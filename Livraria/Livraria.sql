create database livraria;

use livraria;

create table editora(

cod_editora int auto_increment primary key,
descricao varchar(45) not null,
endereco varchar(45)

);
alter table editora
change column descricao nome varchar(45);

create table livro(

cod_livro int auto_increment primary key,
isbn varchar(45) not null,
titulo varchar(45) not null,
auto varchar(45) not null,
num_edicao int,
preco float not null,
editora_cod_editora int not null,
foreign key(editora_cod_editora) references editora(cod_editora)

);

create table autor(

cod_autor int auto_increment primary key,
nome varchar(45) not null,
sexo char,
data_nascimento date not null

);
alter table autor
change column sexo sexo varchar(1);

create table livro_autor(

id_autor int not null,
id_livro int not null,
foreign key(id_autor) references autor(cod_autor),
foreign key(id_livro) references livro(cod_livro)

);






