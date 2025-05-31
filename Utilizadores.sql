-- ========================
-- GESTORES
-- ========================

DROP ROLE IF EXISTS 'gestorFilial';
CREATE ROLE 'gestorFilial';

-- RC5 e RC12
GRANT INSERT, DELETE, UPDATE ON BelaRentaCar.Automovel TO 'gestorFilial';

-- RC10
GRANT INSERT ON BelaRentaCar.Funcao TO 'gestorFilial';

-- RC11
GRANT INSERT, DELETE, UPDATE ON BelaRentaCar.Funcionario TO 'gestorFilial';



DROP USER IF EXISTS 'octavio'@'localhost';
CREATE USER 'octavio'@'localhost' IDENTIFIED BY 'Octavio#2025';

DROP USER IF EXISTS 'leonidas'@'localhost';
CREATE USER 'leonidas'@'localhost' IDENTIFIED BY 'Leonidas#2025';

DROP USER IF EXISTS 'alberto'@'localhost';
CREATE USER 'alberto'@'localhost' IDENTIFIED BY 'Alberto#2025';


GRANT 'gestorFilial' TO 'octavio'@'localhost';
GRANT 'gestorFilial' TO 'leonidas'@'localhost';
GRANT 'gestorFilial' TO 'alberto'@'localhost';


-- ========================
-- FUNCIONÁRIOS
-- ========================

DROP ROLE IF EXISTS 'Funcionario';
CREATE ROLE 'Funcionario';

-- RC4
GRANT INSERT ON BelaRentaCar.Aluguer TO 'Funcionario';

-- RC6 
GRANT UPDATE (Multa) ON BelaRentaCar.Aluguer TO 'Funcionario';


DROP USER IF EXISTS 'josemartins'@'localhost';
CREATE USER 'josemartins'@'localhost' IDENTIFIED BY 'JoseMartins#2025';

DROP USER IF EXISTS 'evarocha'@'localhost';
CREATE USER 'evarocha'@'localhost' IDENTIFIED BY 'EvaRocha#2025';


GRANT 'Funcionario' TO 'josemartins'@'localhost';
GRANT 'Funcionario' TO 'evarocha'@'localhost';
