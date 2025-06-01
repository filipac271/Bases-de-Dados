DELIMITER $$

CREATE PROCEDURE AddFuncionarioComFuncao(
    IN pNome VARCHAR(75),
    IN pNIF VARCHAR(9),
    IN pSalario DECIMAL(8,2),
    IN pTelefone VARCHAR(20),
    IN pEmail VARCHAR(200),
    IN pFilialId INT,
    IN pFuncaoId INT
)
BEGIN
    -- Inserir funcionário
    INSERT INTO Funcionario (Nome, NIF, Salario, Telefone, Email, FilialId)
    VALUES (pNome, pNIF, pSalario, pTelefone, pEmail, pFilialId);
    
    -- Associar a função ao funcionário
    INSERT INTO Exerce (FuncionarioId, FuncaoId)
    VALUES (LAST_INSERT_ID(), pFuncaoId);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE CriarFilialFuncionarioCarro(
    IN pLocalizacao VARCHAR(75),
    IN pNomeFuncionario VARCHAR(75),
    IN pNIFFuncionario VARCHAR(9),
    IN pSalarioFuncionario DECIMAL(8,2),
    IN pTelefoneFuncionario VARCHAR(20),
    IN pEmailFuncionario VARCHAR(200),
    IN pFuncaoId INT,
    IN pMarca VARCHAR(75),
    IN pKilometragem DECIMAL(8,3),
    IN pAno YEAR,
    IN pEstado VARCHAR(10),
    IN pTipoConsumo VARCHAR(10),
    IN pPrecoDia DECIMAL(8,2)
)
BEGIN
    DECLARE vFilialId INT;

    INSERT INTO Filial (Localizacao) VALUES (pLocalizacao);
    SET vFilialId = LAST_INSERT_ID();

    CALL AddFuncionarioComFuncao(
        pNomeFuncionario,
        pNIFFuncionario,
        pSalarioFuncionario,
        pTelefoneFuncionario,
        pEmailFuncionario,
        vFilialId,
        pFuncaoId
    );

    INSERT INTO Automovel (Marca, Kilometragem, Ano, Estado, TipoConsumo, PrecoDia, FilialId)
    VALUES (pMarca, pKilometragem, pAno, pEstado, pTipoConsumo, pPrecoDia, vFilialId);

END $$

DELIMITER ;

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
        
        SELECT CONCAT('Alguer criado com id ', LAST_INSERT_ID()) AS Mensagem;
		
        COMMIT;
	ELSE
		SELECT 'Aluguer não criado' AS Mensagem;
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
    
	DECLARE filialFuncionario INT; -- Id da filial de um funcionário
    DECLARE filialAutomovel INT; -- Id da filial de um carro
	
    SELECT F.FilialId INTO filialFuncionario
		FROM Funcionario AS F
		WHERE F.Id = FuncionarioId;
        
	SELECT A.FilialId INTO filialAutomovel
		FROM Automovel AS A
		WHERE A.Id = AutomovelId
			AND A.Estado = 'Disponível';
    
	IF filialFuncionario = FilOrigem AND filialAutomovel = FilOrigem
    THEN
		START TRANSACTION;
    
		-- É necessário criar 1º a entrada do Cliente antes do Aluguer
		INSERT INTO Cliente 
		(Nome, NIF, LocalTrabalho, Rua, Localidade, CodigoPostal)
		VALUES (Nome, NIF, LocalTrabalho, Rua, Localidade, CodigoPostal);
		
		SET id = LAST_INSERT_ID(); -- id do último cliente inserido (por causa do auto_increment)
		
		CALL novoAluguer(Inicio, Fim, Preco, Multa, id, FuncionarioId, AutomovelId, FilOrigem, FilDestino);
		
        SELECT CONCAT('Cliente criado com id ', id) AS Mensagem;
        
        COMMIT;
	ELSE
		SELECT 'Cliente não criado pois o aluguer é inválido' AS Mensagem, 
			filialFuncionario AS 'Filial do Funcionário',
            filialAutomovel AS 'Filial do Automóvel';
	END IF;
    
END $$
DELIMITER ;
    
