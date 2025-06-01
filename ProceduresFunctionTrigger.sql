USE BelaRentaCar;

DELIMITER //

-- Função que calcula o custo do aluguer de um automóvel
DROP FUNCTION IF EXISTS calculaPreco;
CREATE FUNCTION calculaPreco(
    precoDia DECIMAL(8,2),
    inicio DATETIME,
    fim DATETIME
)
	RETURNS DECIMAL(10,2)
	DETERMINISTIC
BEGIN
    DECLARE precoTotal DECIMAL(10,2);
    DECLARE nrDias INT;

    SET nrDias = DATEDIFF(fim, inicio) + 1;
    SET precoTotal = precoDia * nrDias;

    RETURN precoTotal;
END;
//


-- Função que calcula se um aluguer pode ser criado
DROP FUNCTION IF EXISTS podeCriarAluguer;
CREATE FUNCTION podeCriarAluguer
	(Inicio DATETIME
    ,Fim DATETIME
    ,AutomovelId INT
    ,FuncionarioId INT
    ,FilOrigem INT)
    RETURNS BOOLEAN
    NOT DETERMINISTIC
	READS SQL DATA
    SQL SECURITY DEFINER
BEGIN
	DECLARE filialFuncionario INT; -- Id da filial de um funcionário
    DECLARE filialAutomovel INT; -- Id da filial de um carro
    DECLARE validade BOOLEAN;
    
    SET validade = FALSE;
    
    SELECT F.FilialId INTO filialFuncionario
		FROM Funcionario AS F
		WHERE F.Id = FuncionarioId;
        
	SELECT A.FilialId INTO filialAutomovel
		FROM Automovel AS A
		WHERE A.Id = AutomovelId;

    IF filialFuncionario = FilOrigem -- Garante que o funcionario trabalha na filial correta
		AND filialAutomovel = FilOrigem -- Garante que o automovel está na filial correta e está disponível
        AND NOT EXISTS( -- Garante que não há Alugueres em conflito com este
			SELECT 'conflito'
			FROM Aluguer AS A
			WHERE A.AutomovelId = AutomovelId
				AND A.DataInicio <= Fim
				AND Inicio <= A.DataFim
		)
	THEN
		SET validade = TRUE;
    END IF;
    RETURN validade;
END;
//

DROP PROCEDURE IF EXISTS AddFuncionarioComFuncao;
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
    INSERT INTO Funcionario (Nome, NIF, Salario, Telefone, Email, FilialId)
    VALUES (pNome, pNIF, pSalario, pTelefone, pEmail, pFilialId);
    
    INSERT INTO Exerce (FuncionarioId, FuncaoId)
    VALUES (LAST_INSERT_ID(), pFuncaoId);
END;
//

DROP PROCEDURE IF EXISTS CriarFilialFuncionarioCarro;
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
END;
//

-- Procedimento para criar um aluguer
DROP PROCEDURE IF EXISTS novoAluguer;
CREATE PROCEDURE novoAluguer
	(IN Inicio DATETIME, IN Fim DATETIME, IN ClienteId INT
    	, IN FuncionarioId INT, IN AutomovelId INT, IN FilOrigem INT, IN FilDestino INT)
BEGIN
    -- Cálculo do preço do aluguer
	DECLARE precoDia DECIMAL (8,2);
    DECLARE precoTotal DECIMAL (10,2);
	
    -- SELECT precoDia, Inicio, Fim;
    
	SELECT A.precoDia INTO precoDia
		FROM Automovel AS A
        WHERE  A.Id = AutomovelId;
    
    SELECT calculaPreco (precoDia, Inicio, Fim) INTO precoTotal;
    
    IF podeCriarAluguer(Inicio, Fim, AutomovelId, FuncionarioId, FilOrigem)
    THEN 
		START TRANSACTION;
		INSERT INTO Aluguer
		(DataInicio, DataFim, Preco, ClienteId, FuncionarioId, AutomovelId, RecolhidoFilialId, DevolvidoFilialId)
		VALUES (Inicio, Fim, precoTotal, ClienteId, FuncionarioId, AutomovelId, FilOrigem, FilDestino);
        
        SELECT CONCAT('Aluguer criado com id ', LAST_INSERT_ID()) AS Mensagem;
		
        COMMIT;
	ELSE
		SELECT 'Aluguer não criado' AS Mensagem,
			(SELECT FilialId FROM Funcionario WHERE Id = FuncionarioId) AS 'Filial do Funcionário',
			(SELECT FilialId FROM Automovel WHERE Id = AutomovelId) AS 'Filial do Automóvel',
            FilOrigem AS 'Filial de Origem';
	END IF;
END;
//

-- Procedimento para criar um cliente
DROP PROCEDURE IF EXISTS novoCliente;
CREATE PROCEDURE novoCliente
	(IN Nome VARCHAR(75),
     IN NIF VARCHAR(9),
	 IN LocalTrabalho VARCHAR(75),
     IN Rua VARCHAR(75),
     IN Localidade VARCHAR(75),
     IN CodigoPostal VARCHAR(10),
     IN Telefone VARCHAR(20),
     IN Inicio DATETIME, IN Fim DATETIME, IN FuncionarioId INT,
     IN AutomovelId INT, IN FilOrigem INT, IN FilDestino INT)
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
		
		INSERT INTO Cliente_Contacto -- Um cliente tem de ter obrigatóriamente um número de telefone
			(ClienteId, Telefone)
            VALUES (id, Telefone); 
        
		CALL novoAluguer(Inicio, Fim, id, FuncionarioId, AutomovelId, FilOrigem, FilDestino);
        
        SELECT CONCAT('Cliente criado com id ', id) AS Mensagem;
        
        COMMIT;
	ELSE
		SELECT 'Cliente não criado pois o aluguer é inválido' AS Mensagem, 
			filialFuncionario AS 'Filial do Funcionário',
            filialAutomovel AS 'Filial do Automóvel';
	END IF;
    
END;
//

-- Procedure que garante que tudo o que depende de um Cliente também é apagado com ele.
DROP PROCEDURE IF EXISTS deleteCliente;
CREATE PROCEDURE deleteCliente
	(IN id INT)
BEGIN
	DELETE FROM Cliente_Contacto 
		WHERE ClienteId = id;
	DELETE FROM Aluguer
		WHERE ClienteId = id;
	DELETE FROM Cliente
		WHERE Id = id;
END;
//

-- Trigger que garante que após um automóvel ser alugado, passa a estar Ocupado e a pertencer à filial de entrega
DROP TRIGGER IF EXISTS tgOcupaAutomovel;
CREATE TRIGGER tgOcupaAutomovel
	AFTER INSERT ON Aluguer
    FOR EACH ROW
BEGIN
	UPDATE Automovel AS A
		SET A.Estado = 'Ocupado'
        , FilialId = NEW.DevolvidoFilialId
            WHERE A.Id = NEW.AutomovelId;
END;
//

DELIMITER ;