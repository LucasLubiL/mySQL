-- 1
Create USER 'my_user1'@'localhost' identified by 'user123';

-- 2
Create USER 'my_admin'@'localhost' identified by 'admin123';

-- 3
use bd_empresa;
use auladml;

-- 4
GRANT ALL ON bd_empresa.* TO my_admin;

-- 5
GRANT select, insert, delete, update ON bd_empresa.*TO my_user1;

-- 6
SHOW GRANTS FOR my_user1;
SHOW GRANTS FOR my_admin;

-- 7
REVOKE ALL ON bd_empresa.* from 'my_user1';

-- 8
-- Esse códgio foi feito no usuário my_user1 após eu conceder permissão novamente ao bd_empresa
use bd_empresa;
show tables;

-- 9
-- Teste de update feito no usuário my_user1
update projeto
   set id_depto = 2
   where id_depto = 3;

-- 10
CREATE ROLE papelAdmin;
CREATE ROLE papelDev;

-- 11
GRANT ALL ON universidade.* TO papelAdmin;
GRANT select, insert, update, delete ON universidade.* TO papelDev;

-- 12
CREATE USER 'adm' identified by 'adm123';
CREATE USER 'dev' identified by 'dev123';

GRANT papelAdmin TO 'adm';
GRANT papelDev TO 'dev';

set default role papelAdmin to adm;
set default role papelDev to dev;

show grants for papelAdmin;
show grants for papelDev;
