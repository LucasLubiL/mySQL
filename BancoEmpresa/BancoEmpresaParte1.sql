CREATE DATABASE IF NOT EXISTS bd_empresa;
USE bd_empresa;


CREATE TABLE departamento (
    id_depto    Integer    NOT NULL auto_increment PRIMARY KEY,
    nome_depto   VARCHAR(30)   NOT NULL,
    id_gerente  Integer      NOT NULL,
    CONSTRAINT uk_nome UNIQUE (nome_depto)
);

CREATE TABLE funcionario (
    id_func     Integer     NOT NULL PRIMARY KEY auto_increment,
    nome_func    VARCHAR(30)  NOT NULL,
    endereco    VARCHAR(50)  NOT NULL,
    data_nasc    DATE          NOT NULL,
    sexo        CHAR(1)       NOT NULL,
    salario     NUMERIC(8,2)   NOT NULL,
    id_superv   Integer         NULL,
    id_depto    Integer     NOT NULL,
    CONSTRAINT ck_sexo CHECK (sexo='M' or sexo='F')
);

CREATE TABLE projeto (
    id_proj       Integer     NOT NULL PRIMARY KEY auto_increment,
    nome_proj      VARCHAR(30)  NOT NULL,
    localizacao   VARCHAR(30)      NULL,
    id_depto      Integer     NOT NULL,
    CONSTRAINT uk_nome_proj UNIQUE (nome_proj)
);

CREATE TABLE dependente (
    id_dep       Integer     NOT NULL,
    id_func      Integer     NOT NULL,
    nome_dep      VARCHAR(30)  NOT NULL,
    data_nasc     DATE          NOT NULL,
    sexo         CHAR(1)       NOT NULL,
    parentesco   CHAR(15)          NULL,
    CONSTRAINT pk_depend PRIMARY KEY (id_dep, id_func),
    CONSTRAINT ck_sexo_dep CHECK (sexo='M' or sexo='F')
);

CREATE TABLE trabalha (
    id_func    Integer    NOT NULL,
    id_proj    Integer     NOT NULL,
    num_horas   NUMERIC(6,1)       NULL,
    CONSTRAINT pk_trab PRIMARY KEY (id_func,id_proj)
);

INSERT INTO funcionario
VALUES (1,'Joao Silva','R. Guaicui, 175', str_to_date('01/02/1955',"%d/%m/%Y"),'M',500,2,1);
INSERT INTO funcionario
VALUES (2,'Frank Santos','R. Gentios, 22',str_to_date('02/02/1966',"%d/%m/%Y"),'M',1000,8,1);
INSERT INTO funcionario
VALUES (3,'Alice Pereira','R. Curitiba, 11',str_to_date('15/05/1970',"%d/%m/%Y"),'F',700,4,3);
INSERT INTO funcionario
VALUES (4,'Junia Mendes','R. Espirito Santos, 123',str_to_date('06/07/1976',"%d/%m/%Y"),'F',1200,8,3);
INSERT INTO funcionario
VALUES (5,'Jose Tavares','R. Irai, 153',str_to_date('07/10/1975',"%d/%m/%Y"),'M',1500,2,1);
INSERT INTO funcionario
VALUES (6,'Luciana Santos','R. Irai, 175',str_to_date('07/10/1960',"%d/%m/%Y"),'F',600,2,1);
INSERT INTO funcionario
VALUES (7,'Maria Ramos','R. C. Linhares, 10',str_to_date('01/11/1965',"%d/%m/%Y"),'F',1000,4,3);
INSERT INTO funcionario
VALUES (8,'Jaime Mendes','R. Bahia, 111',str_to_date('25/11/1960',"%d/%m/%Y"),'M',2000,NULL,2);

INSERT INTO departamento
VALUES (1,'Pesquisa',2);
INSERT INTO departamento
VALUES (2,'Administracao',8);
INSERT INTO departamento
VALUES (3,'Construcao',4);

INSERT INTO dependente
VALUES (1,2,'Luciana',str_to_date('05/11/1990',"%d/%m/%Y"),'F','Filha');
INSERT INTO dependente
VALUES (2,2,'Paulo',str_to_date('11/11/1992',"%d/%m/%Y"),'M','Filho');
INSERT INTO dependente
VALUES (3,2,'Sandra',str_to_date('05/12/1996',"%d/%m/%Y"),'F','Filha');
INSERT INTO dependente
VALUES (4,4,'Mike',str_to_date('05/11/1997',"%d/%m/%Y"),'M','Filho');
INSERT INTO dependente
VALUES (5,1,'Max',str_to_date('11/05/1979',"%d/%m/%Y"),'M','Filho');
INSERT INTO dependente
VALUES (6,1,'Rita',str_to_date('07/11/1985',"%d/%m/%Y"),'F','Filha');
INSERT INTO dependente
VALUES (7,1,'Bety',str_to_date('15/12/1960',"%d/%m/%Y"),'F','Esposa');

INSERT INTO projeto
VALUES (1,'ProdX','Savassi',1);
INSERT INTO projeto
VALUES (2,'ProdY','Luxemburgo',1);
INSERT INTO projeto
VALUES (3,'ProdZ','Centro',1);
INSERT INTO projeto
VALUES (10,'Computacao','C. Nova',3);
INSERT INTO projeto
VALUES (20,'Organizacao','Luxemburgo',2);
INSERT INTO projeto
VALUES (30,'N. Beneficios','C. Nova',1);

INSERT INTO trabalha
VALUES (1,1,32.5);
INSERT INTO trabalha
VALUES (1,2,7.5);
INSERT INTO trabalha
VALUES (5,3,40.0);
INSERT INTO trabalha
VALUES (6,1,20.0);
INSERT INTO trabalha
VALUES (6,2,20.0);
INSERT INTO trabalha
VALUES (2,2,10.0);
INSERT INTO trabalha
VALUES (2,3,10.0);
INSERT INTO trabalha
VALUES (2,10,10.0);
INSERT INTO trabalha
VALUES (2,20,10.0);
INSERT INTO trabalha
VALUES (3,30,30.0);
INSERT INTO trabalha
VALUES (3,10,10.0);
INSERT INTO trabalha
VALUES (7,10,35.0);
INSERT INTO trabalha
VALUES (7,30,5.0);
INSERT INTO trabalha
VALUES (4,20,15.0);
INSERT INTO trabalha
VALUES (8,20,NULL);

ALTER TABLE funcionario
ADD CONSTRAINT fk_func_depto FOREIGN KEY (id_depto) REFERENCES departamento (id_depto);

ALTER TABLE funcionario
ADD CONSTRAINT fk_func_superv FOREIGN KEY (id_superv) REFERENCES funcionario (id_func);

ALTER TABLE departamento
ADD CONSTRAINT fk_depto_func FOREIGN KEY (id_gerente) REFERENCES funcionario (id_func);

ALTER TABLE projeto
ADD CONSTRAINT fk_proj_depto FOREIGN KEY (id_depto) REFERENCES departamento (id_depto);

ALTER TABLE dependente
ADD CONSTRAINT fk_dep_func FOREIGN KEY (id_func) REFERENCES funcionario (id_func) ON DELETE CASCADE;

ALTER TABLE trabalha
ADD CONSTRAINT fk_trab_func FOREIGN KEY (id_func) REFERENCES funcionario (id_func) ON DELETE CASCADE;

ALTER TABLE trabalha
ADD CONSTRAINT fk_trab_proj FOREIGN KEY (id_proj) REFERENCES projeto (id_proj) ON DELETE CASCADE;

-- 1
insert into projeto (nome_proj,localizacao,id_depto)
values ('Novo Projeto','Buritis',1);

select * from projeto;

-- 2
insert into funcionario (nome_func,endereco,data_nasc,sexo,salario,id_depto)
values('Edgar Marinho', 'R.Alameda,111', str_to_date('13/11/1959',"%d/%m/%Y"),'M',2000.00,2);

select * from funcionario;

-- 3
update funcionario
   set salario = 1000.00
   where nome_func like '%Joao Silva%';
   
select * from funcionario;

-- 4
select nome_func from funcionario
where (id_depto = 2 or id_depto = 3) and salario between 800.00 and 1200.00;

-- 5
select funcionario.nome_func , funcionario.endereco from funcionario
join departamento ON funcionario.id_depto = departamento.id_depto
where nome_depto like '%Pesquisa%';

-- 6
select nome_func, date_format(data_nasc, '%d/%m/%Y') as data_nasc from funcionario
where nome_func like '%Joao Silva';

-- 7
select nome_func from funcionario 
where id_superv is NULL;

-- 8
select funcionario.nome_func , departamento.nome_depto , projeto.nome_proj from funcionario
-- join trabalha ON trabalha.id_func = funcionario.id_func
join departamento ON funcionario.id_depto = departamento.id_depto
join projeto ON departamento.id_depto = projeto.id_depto
order by departamento.nome_depto , projeto.nome_proj;

-- 9
select SUM(salario) as soma_salario , AVG(salario) as media , MAX(salario) as maior_salario , MIN(salario) from funcionario;

-- 10
select SUM(salario) as soma_salario , AVG(salario) as media , MAX(salario) as maior_salario , MIN(salario) from funcionario
JOIN departamento ON funcionario.id_depto = departamento.id_depto
where departamento.nome_depto like '%Pesquisa%';

-- 11
select f.nome_func from funcionario f
left join dependente d ON f.id_func = d.id_func
where d.id_func is NULL;

-- 12
select p.id_proj, d.id_depto, d.nome_depto, f.nome_func, f.endereco, f.data_nasc from projeto p
join departamento d ON p.id_depto = d.id_depto
join funcionario f ON d.id_gerente = f.id_func
where p.localizacao like "%Luxemburgo%";

-- 13
select p.nome_proj, p.localizacao from projeto p
left join trabalha t ON p.id_proj = t.id_proj
left join funcionario f ON t.id_func = f.id_func
where t.id_func is null;

-- 14
select f.nome_func from trabalha t
right join funcionario f ON f.id_func = t.id_func
left join dependente d ON d.id_func = f.id_func
where d.id_func is NULL and t.id_func is NULL;

-- 15
select empregado.nome_func AS Nome_Empregado, supervisor.nome_func AS Nome_Supervisor from funcionario AS Empregado
join Funcionario supervisor ON empregado.id_superv = supervisor.id_func;


DELIMITER //
   CREATE PROCEDURE apli_taxa(IN taxa INT , IN id INT)
