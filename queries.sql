SHOW TABLES;

DESC Aluguer;
DESC Automovel;
DESC Cliente;
DESC Cliente_Contacto;
DESC Exerce;
DESC Filial;
DESC Funcao;
DESC Funcionario;

-- RM8
-- Listar todos os automoveis que já foram alugados e os respetivos clientes que os alugaram
-- (id, Nome, id do automovel, Marca, Ano, Estado, PrecoDia, TipoConsumo)
SELECT CL.Id AS Cliente, CL.Nome, AU.Id AS Automovel, AU.Marca, AU.Ano, AU.Estado, AU.PrecoDia, AU.TipoConsumo
	FROM Cliente AS CL
    INNER JOIN Aluguer AL
		ON CL.Id = AL.ClienteId
	INNER JOIN Automovel AS AU
		ON AL.AutomovelId = AU.Id
	ORDER BY AU.Id ASC; -- Como pedia para listar carros, pareceu-me bem ordenar pelo id deles

-- RM9
-- Listar todo o tipo e função que existe associado a pelo menos um funcionario
-- (Id, Nome, Designacao, salarioBase)
-- uma função só existe se estiver associada a pelo menos um funcionário né tho?
-- e não contém Nome, mas o requesito pede-lhe por tal
SELECT DISTINCT FU.Id, FU.Designacao, FU.SalarioBase
	FROM Funcao AS FU
    INNER JOIN Exerce AS EX
		ON FU.Id = EX.FuncaoId;

-- RM10
-- Listar todos os automóveis que nunca foram alugados
-- Só Id e Marca para seguir o esquema da algebra relacional
SELECT AU.Id AS Automovel, AU.Marca
	FROM Automovel AS AU
    WHERE NOT EXISTS (
		SELECT * -- O que colocamos neste SELECT importa? é que ñ me parece mas ñ sei, se calhar é melhor reduzir-lhe o nr de cols?
			FROM Aluguer AS AL
			WHERE AU.Id = AL.AutomovelId);

-- RM11
-- Listar todos os clientes que não têm carros alugados no momento.
SELECT CL.Id AS Cliente, CL.Nome
	FROM Cliente AS CL
    WHERE NOT EXISTS(
		SELECT AL.DataInicio, AL.DataFim
			FROM Aluguer AS AL
			WHERE AL.ClienteId = CL.Id
				AND now() BETWEEN AL.DataInicio AND AL.DataFim);

-- RM12
-- Listar todos os alugueres que estão a acontecer atualmente
-- (id, automovel, cliente, preco, dataInicio, dataFim, filialInicio, filialFim)
SELECT AL.Id, AL.AutomovelId, AL.Preco, AL.DataInicio, AL.DataFim, AL.RecolhidoFilialId, AL.DevolvidoFilialId
	FROM Aluguer AS AL
		WHERE now() BETWEEN AL.DataInicio AND AL.DataFim;

-- RM13
-- Gerar uma lista do número de alugueres das diferentes marcas de automóveis já alugados
SELECT DISTINCT AU.Marca, count(AL.Id)
	FROM Automovel AS AU
    LEFT OUTER JOIN Aluguer AS AL
		ON AU.Id = AL.AutomovelId
    GROUP BY AU.Marca; -- A marca conter o modelo(?) do trabalho faz com que a mm marca tenha múltiplos valores 

-- RM14
-- Gerar uma lista ordenada por ordem decrescente de rendimento
-- todas as filiais (Id, Localização)
SELECT DISTINCT FI.Id AS Filial, FI.Localizacao, sum(AL.Preco) AS Receita
	FROM Filial AS FI
    LEFT OUTER JOIN Aluguer as AL
		ON FI.Id = AL.RecolhidoFilialId
    GROUP BY FI.Id
    ORDER BY (Rendimento) DESC;

-- RM15
-- Listar todos os clientes assim como as filiais onde fizeram alugueres
-- (Id cliente, Nome cliente, Id filial, Localizacao)
SELECT DISTINCT CL.Id, CL.Nome, FI.Id, FI.Localizacao
	FROM Cliente AS CL
    INNER JOIN Aluguer AS AL
		ON CL.Id = AL.ClienteId
    INNER JOIN Filial AS FI
		ON AL.RecolhidoFilialId = FI.Id
	ORDER BY (CL.Id) ASC; -- Só para ficar + facil de ler, mas se calhar retirar já que não é pedido?

-- RM16
-- Verificar a Filial com um maior número de automóveis
-- Sinto que fiz de forma diferente do que está na algebra relacional, ñ sei se está td bem com isso 
SELECT FI.Id AS Filial, FI.Localizacao, count(*) AS NrCarros
	FROM Automovel AS AU
    INNER JOIN Filial AS FI
		ON AU.FilialId = FI.Id
	GROUP BY (FI.Id)
	ORDER BY (NrCarros) DESC
    LIMIT 1;

-- RM17
-- Listar todos os alugueres associados a um cliente com base no seu identificador
-- Incompleto
SELECT AL.*
	FROM Aluguer AS AL
    WHERE AL.ClienteId = 1;