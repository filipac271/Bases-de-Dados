USE BelaRentaCar;

DELIMITER //

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

DROP PROCEDURE IF EXISTS novoAluguer;
CREATE PROCEDURE novoAluguer(
    IN Inicio DATETIME, IN Fim DATETIME, IN ClienteId INT,
    IN FuncionarioId INT, IN AutomovelId INT, IN FilOrigem INT, IN FilDestino INT
)
BEGIN
    DECLARE filialFuncionario INT;
    DECLARE filialAutomovel INT;
    DECLARE precoDia DECIMAL(8,2);
    DECLARE precoTotal DECIMAL(10,2);

    SELECT A.precoDia INTO precoDia FROM Automovel A WHERE A.Id = AutomovelId;

    SELECT calculaPreco(precoDia, Inicio, Fim) INTO precoTotal;

    SELECT F.FilialId INTO filialFuncionario FROM Funcionario F WHERE F.Id = FuncionarioId;

    SELECT A.FilialId INTO filialAutomovel FROM Automovel A WHERE A.Id = AutomovelId AND A.Estado = 'Disponível';

    IF filialFuncionario = FilOrigem AND filialAutomovel = FilOrigem THEN
        START TRANSACTION;
        INSERT INTO Aluguer (DataInicio, DataFim, Preco, ClienteId, FuncionarioId, AutomovelId, RecolhidoFilialId, DevolvidoFilialId)
        VALUES (Inicio, Fim, precoTotal, ClienteId, FuncionarioId, AutomovelId, FilOrigem, FilDestino);

        UPDATE Automovel SET Estado = 'Ocupado', FilialId = FilDestino WHERE Id = AutomovelId;

        COMMIT;
    ELSE
        SELECT 'Aluguer não criado' AS Mensagem;
    END IF;
END;
//

DROP PROCEDURE IF EXISTS novoCliente;
CREATE PROCEDURE novoCliente(
    IN Nome VARCHAR(75),
    IN NIF VARCHAR(9),
    IN LocalTrabalho VARCHAR(75),
    IN Rua VARCHAR(75),
    IN Localidade VARCHAR(75),
    IN CodigoPostal VARCHAR(10),
    IN Telefone VARCHAR(20),
    IN Inicio DATETIME,
    IN Fim DATETIME,
    IN FuncionarioId INT,
    IN AutomovelId INT,
    IN FilOrigem INT,
    IN FilDestino INT
)
BEGIN
    DECLARE id INT;
    DECLARE filialFuncionario INT;
    DECLARE filialAutomovel INT;

    SELECT F.FilialId INTO filialFuncionario FROM Funcionario F WHERE F.Id = FuncionarioId;

    SELECT A.FilialId INTO filialAutomovel FROM Automovel A WHERE A.Id = AutomovelId AND A.Estado = 'Disponível';

    IF filialFuncionario = FilOrigem AND filialAutomovel = FilOrigem THEN
        START TRANSACTION;

        INSERT INTO Cliente (Nome, NIF, LocalTrabalho, Rua, Localidade, CodigoPostal)
        VALUES (Nome, NIF, LocalTrabalho, Rua, Localidade, CodigoPostal);

        SET id = LAST_INSERT_ID();

        CALL novoAluguer(Inicio, Fim, id, FuncionarioId, AutomovelId, FilOrigem, FilDestino);

        COMMIT;
    ELSE
        SELECT 'Cliente não criado pois o aluguer é inválido' AS Mensagem,
               filialFuncionario AS 'Filial do Funcionário',
               filialAutomovel AS 'Filial do Automóvel';
    END IF;
END;
//

DELIMITER ;
