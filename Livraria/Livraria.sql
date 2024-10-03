create database livraria;

use livraria;

create table editora(

cod_editora int auto_increment primary key,
descricao varchar(45) not null,
endereco varchar(45)

);

alter table editora /*rename column descricao to nome*/
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

alter table livro
change column isbn isbn varchar(45) unique not null; /*add constraint unique (isbn),*/
alter table livro
modify column preco float default 10;  /*alter preco set default 10.0,*/
alter table livro 
drop column num_edicao;
alter table livro
add column edicao int;

create table autor(

cod_autor int auto_increment primary key,
nome varchar(45) not null,
sexo char,
data_nascimento date not null

);
alter table autor /*change troca o nome e o tipo, o rename troca o nome, e o modify troca o tipo*/
change column sexo sexo varchar(1);

create table livro_autor(

id_autor int not null,
id_livro int not null,
primary key (id_autor,id_livro),
foreign key(id_autor) references autor(cod_autor),
foreign key(id_livro) references livro(cod_livro)

);

create table grupo(

id_grupo int auto_increment primary key,
nome varchar(45)

); 

alter table editora
add column id_grupo int, add constraint foreign key(id_grupo) references grupo(id_grupo) on delete set null on update cascade;













