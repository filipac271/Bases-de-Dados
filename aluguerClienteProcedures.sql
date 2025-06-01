-- Procedimento para criar um aluguer
DROP PROCEDURE IF EXISTS novoAluguer;

DELIMITER $$
CREATE PROCEDURE novoAluguer
	(IN Inicio DATETIME, IN Fim DATETIME, IN Preco INT, IN Multa INT, IN ClienteId INT
    , IN FuncionarioId INT, IN AutomovelId INT, IN FilOrigem INT, IN FilDestino INT)
BEGIN
	DECLARE filialFuncionario INT; -- Id da filial de um funcionário
    DECLARE filialAutomovel INT; -- Id da filial de um carro
	
    SELECT F.FilialId INTO filialFuncionario
		FROM Funcionario AS F
		WHERE F.Id = FuncionarioId;
        
	SELECT A.FilialId INTO filialAutomovel
		FROM Automovel AS A
		WHERE A.Id = AutomovelId
			AND A.Estado = 'Disponível';

    SELECT filialFuncionario AS 'Filial do Funcionário', filialAutomovel AS 'Filial do Automóvel';

    IF filialFuncionario = FilOrigem -- Garante que o funcionario trabalha na filial correta
		AND filialAutomovel = FilOrigem -- Garante que o automovel está na filial correta e está disponível
    THEN 
		START TRANSACTION;
		INSERT INTO Aluguer
		(DataInicio, DataFim, Preco, Multa, ClienteId, FuncionarioId, AutomovelId, RecolhidoFilialId, DevolvidoFilialId)
		VALUES (Inicio, Fim, Preco, Multa, ClienteId, FuncionarioId, AutomovelId, FilOrigem, FilDestino);
        
        UPDATE Automovel
		SET Estado = 'Ocupado', FilialId = FilDestino 
		WHERE Id = AutomovelId;
		
        COMMIT;
	ELSE
		SELECT 'Não se fez nada' AS Mensagem;
	END IF;
END $$
DELIMITER ;

-- Procedimento para criar um cliente
DROP PROCEDURE IF EXISTS novoCliente;

DELIMITER $$
CREATE PROCEDURE novoCliente
	(IN Nome VARCHAR(75),
     IN NIF VARCHAR(9),
	 IN LocalTrabalho VARCHAR(75),
     IN Rua VARCHAR(75),
     IN Localidade VARCHAR(75),
     IN CodigoPostal VARCHAR(10),
     IN Telefone VARCHAR(20),
     IN Inicio DATETIME, IN Fim DATETIME, IN Preco INT, IN Multa INT,
	 IN FuncionarioId INT, IN AutomovelId INT, IN FilOrigem INT, IN FilDestino INT)
BEGIN
	DECLARE id INT;
    DECLARE nrAlugueres INT;
    
    START TRANSACTION;
    
    INSERT INTO Cliente -- Base para poder criar o aluguer
    (Nome, NIF, LocalTrabalho, Rua, Localidade, CodigoPostal)
    VALUES (Nome, NIF, LocalTrabalho, Rua, Localidade, CodigoPostal);
    
    SET id = LAST_INSERT_ID(); -- id do último cliente inserido (com auto_increment)
    
    CALL novoAluguer(Inicio, Fim, Preco, Multa, id, FuncionarioId, AutomovelId, FilOrigem, FilDestino);
    
	SELECT COUNT(*) INTO nrAlugueres
	FROM Aluguer
	WHERE ClienteId = id;
    
    SELECT nrAlugueres AS 'Número de alugueres';
    
    IF nrAlugueres = 0
    THEN
        -- Aluguer não criado, apagar cliente e abortar
        DELETE FROM Cliente WHERE Id = id;
        ROLLBACK;
    ELSE
	INSERT INTO Cliente_Contacto
		(ClienteId, Telefone)
		VALUES (id, Telefone);    
		
        COMMIT;
	END IF;
    
END $$
DELIMITER ;
    