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
