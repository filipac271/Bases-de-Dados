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
