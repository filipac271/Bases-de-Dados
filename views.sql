CREATE VIEW CarrosDisponiveis AS
    SELECT * FROM Automovel a 
        WHERE a.Estado = "Disponível";


CREATE VIEW OrigemUsers AS
    SELECT c.Localidade, count(*) AS UsersPorOrigem FROM Cliente c
        GROUP BY c.Localidade;


CREATE VIEW MediaPrecosMaisAlugadas AS
    SELECT AVG(au.PrecoDia) as MediaPrecoDiario, f.Localizacao FROM Aluguer a 
        INNER JOIN Automovel au ON a.AutomovelId = au.Id
            INNER JOIN Filial f ON a.RecolhidoFilialId = f.Id
                GROUP BY f.Localizacao;