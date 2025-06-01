-- ========================
-- GESTORES
-- ========================

DROP ROLE IF EXISTS 'gestorFilial';
CREATE ROLE 'gestorFilial';


-- RC9
GRANT INSERT ON BelaRentaCar.Funcao TO 'gestorFilial';

-- RC10
GRANT DELETE, UPDATE ON BelaRentaCar.Funcionario TO 'gestorFilial';
GRANT EXECUTE ON PROCEDURE BelaRentaCar.AddFuncionarioComFuncao TO 'gestorFilial'; 

 
-- RC11
GRANT INSERT, DELETE, UPDATE ON BelaRentaCar.Automovel TO 'gestorFilial';

-- RC13 
GRANT DELETE, UPDATE ON BelaRentaCar.Cliente TO 'gestorFilial';
GRANT EXECUTE ON PROCEDURE BelaRentaCar.novoCliente TO 'gestorFilial'; 


GRANT INSERT, DELETE ON BelaRentaCar.Cliente_Contacto TO 'gestorFilial';

GRANT UPDATE (DataFim) ON BelaRentaCar.Aluguer TO 'gestorFilial';



DROP USER IF EXISTS 'octavio'@'localhost';
CREATE USER 'octavio'@'localhost' IDENTIFIED BY 'Octavio#2025';
GRANT DELETE, UPDATE ON BelaRentaCar.Filial to 'octavio'@'localhost';



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
GRANT EXECUTE ON PROCEDURE BelaRentaCar.novoAluguer TO 'Funcionario';

-- RC5 
GRANT UPDATE (Multa) ON BelaRentaCar.Aluguer TO 'Funcionario';


DROP USER IF EXISTS 'josemartins'@'localhost';
CREATE USER 'josemartins'@'localhost' IDENTIFIED BY 'JoseMartins#2025';

DROP USER IF EXISTS 'evarocha'@'localhost';
CREATE USER 'evarocha'@'localhost' IDENTIFIED BY 'EvaRocha#2025';


GRANT SELECT ON BelaRentaCar.* TO 'gestorFilial';
GRANT SELECT ON BelaRentaCar.* TO 'Funcionario';



GRANT 'Funcionario' TO 'josemartins'@'localhost';
GRANT 'Funcionario' TO 'evarocha'@'localhost';

GRANT 'Funcionario' TO 'octavio'@'localhost';
GRANT 'Funcionario' TO 'leonidas'@'localhost';
GRANT 'Funcionario' TO 'alberto'@'localhost';

SET DEFAULT ROLE 'gestorFilial', 'Funcionario' TO 'octavio'@'localhost';
GRANT EXECUTE ON PROCEDURE BelaRentaCar.CriarFilialFuncionarioCarro TO 'octavio'@'localhost'; 
SET DEFAULT ROLE 'gestorFilial', 'Funcionario' TO 'leonidas'@'localhost';
SET DEFAULT ROLE 'gestorFilial', 'Funcionario' TO 'alberto'@'localhost';

SET DEFAULT ROLE 'Funcionario' TO 'josemartins'@'localhost';
SET DEFAULT ROLE 'Funcionario' TO 'evarocha'@'localhost';


GRANT USAGE ON BelaRentaCar.* TO 'octavio'@'localhost';
GRANT USAGE ON BelaRentaCar.* TO 'leonidas'@'localhost';
GRANT USAGE ON BelaRentaCar.* TO 'alberto'@'localhost';

GRANT USAGE ON BelaRentaCar.* TO 'josemartins'@'localhost';
GRANT USAGE ON BelaRentaCar.* TO 'evarocha'@'localhost';