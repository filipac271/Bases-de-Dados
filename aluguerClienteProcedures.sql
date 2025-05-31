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

-- Procedimento para criar um cliente :)