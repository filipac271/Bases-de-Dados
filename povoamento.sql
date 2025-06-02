USE BelaRentaCar;
-- Inserir Filiais
INSERT INTO Filial (Localizacao) VALUES
('Portugal'),
('Bélgica'),
('Mónaco');

SET @ultimoFuncionarioId = (SELECT COALESCE(MAX(Id), 0) FROM Funcionario);
SET @ultimoClienteId = (SELECT COALESCE(MAX(Id), 0) FROM Cliente);
SET @ultimoAutomovelId = (SELECT COALESCE(MAX(Id), 0) FROM Automovel);
SET @ultimoFuncaoId = (SELECT COALESCE(MAX(Id), 0) FROM Funcao);


INSERT INTO Cliente (Nome, Rua, Localidade, CodigoPostal, NIF, LocalTrabalho) VALUES
('Akio Toyoda', 'Rua Toyoda', 'Japao', '1234-234', 111111111, 'Toyota Group'),
('Oliver Blume', 'Rua Porsche', 'Alemanha', '5432-111', 222222222, 'Volkswagen Group'),
('Carlos Tavares', 'Rua Europa', 'Portugal', '1500-000', 333333333, 'Stellantis'),
('Jim Farley', 'Ford Street', 'Estados Unidos', '9021-420', 444444444, 'Ford Motor Company'),
('Luca de Meo', 'Via Milano', 'Itália', '2010-500', 555555555, 'Renault Group'),
('Toshihiro Mibe', 'Rua Honda', 'Japao', '1245-678', 666666666, 'Honda Motor Co.'),
('Makoto Uchida', 'Rua Yokohama', 'Japao', '1267-890', 777777777, 'Nissan Motor Co.'),
('Mary Barra', 'Detroit Ave', 'Estados Unidos', '4822-300', 888888888, 'General Motors'),
('Harald Krüger', 'München Straße', 'Alemanha', '8033-500', 999999999, 'BMW Group'),
('Zhou Xiaoqing', 'Rua Geely', 'China', '1000-888', 101440101, 'Geely Holding Group');


INSERT INTO Cliente_Contacto (ClienteId, Telefone, Email) VALUES
(1 + @ultimoClienteId, '910234567', 'akio.toyoda@toyota.jp'),
(2 + @ultimoClienteId, '920345678', 'oliver.blume@vwgroup.de'),
(3 + @ultimoClienteId, '930456789', 'carlos.tavares@stellantis.com'),
(4 + @ultimoClienteId, '940567890', 'jim.farley@ford.com'),
(5 + @ultimoClienteId, '950678901', 'luca.demeo@renault.it'),
(6 + @ultimoClienteId, '960789012', 'toshihiro.mibe@honda.jp'),
(7 + @ultimoClienteId, '970890123', 'makoto.uchida@nissan.jp'),
(8 + @ultimoClienteId, '980901234', 'mary.barra@gm.com'),
(9 + @ultimoClienteId, '990012345', 'harald.kruger@bmw.de'),
(1 + @ultimoClienteId, '900123456', 'zhou.xiaoqing@geely.cn');



INSERT INTO Automovel (Marca, Kilometragem, Ano, Estado, PrecoDia, TipoConsumo, FilialId) VALUES
('Toyota Corolla', 45000, 2020, 'Disponível', 45.00, 'Gasolina', 1),
('Volkswagen Golf', 30000, 2021, 'Ocupado', 50.00, 'Gasóleo', 2),
('Peugeot 208', 15000, 2022, 'Disponível', 40.00, 'Gasolina', 3),
('Renault Clio', 60000, 2019, 'Disponível', 38.00, 'Gasolina', 1),
('Ford Focus', 50000, 2020, 'Disponível', 42.00, 'Gasóleo', 2),
('BMW Série 1', 25000, 2021, 'Ocupado', 65.00, 'Gasolina', 3),
('Fiat 500', 12000, 2023, 'Disponível', 35.00, 'Elétrico', 1),
('Audi A3', 40000, 2020, 'Disponível', 60.00, 'Gasóleo', 2),
('Mercedes A-Class', 28000, 2022, 'Disponível', 70.00, 'Gasolina', 3),
('Nissan Leaf', 18000, 2021, 'Ocupado', 55.00, 'Elétrico', 1);

-- Inserir Funcionários
INSERT INTO Funcionario (Nome, NIF,Salario, Email, Telefone, FilialId) VALUES
('Cláudia Neves', '874512369', 3100.00, 'claudia.neves@belarentacar.com', '963112233', 1),
('Rui Martins', '951753456', 2750.00, 'rui.martins@belarentacar.com', '964223344', 2),
('Joana Ferreira', '782364159', 2900.00, 'joana.ferreira@belarentacar.com', '965334455', 3),
('José Martins', '444556666',2000.00, 'jose.martins@belarentacar.com', '963456789', 1),
('Eva Rocha', '555667777',2000.00, 'eva.rocha@belarentacar.com', '964567890', 2);


INSERT INTO Aluguer (DataInicio, DataFim, Preco, Multa, ClienteId, FuncionarioId, AutomovelId, RecolhidoFilialId, DevolvidoFilialId) VALUES
('2025-04-01 00:00:00', '2025-04-05 00:00:00', 180.00, 0.00, 1 + @ultimoClienteId, 2 + @ultimoFuncionarioId, 1 + @ultimoAutomovelId, 1, 1),
('2025-03-15 00:00:00', '2025-03-17 00:00:00', 100.00, 10.00, 2 + @ultimoClienteId, 1 + @ultimoFuncionarioId, 2 + @ultimoAutomovelId, 2, 2),
('2025-04-10 00:00:00', '2025-04-13 00:00:00', 120.00, 0.00, 3 + @ultimoClienteId, 3 + @ultimoFuncionarioId, 3 + @ultimoAutomovelId, 3, 3),
('2025-02-05 00:00:00', '2025-02-07 00:00:00', 76.00, 5.00, 4 + @ultimoClienteId, 5 + @ultimoFuncionarioId, 4 + @ultimoAutomovelId, 1, 2),
('2025-01-20 00:00:00', '2025-01-24 00:00:00', 168.00, 0.00, 5 + @ultimoClienteId, 4 + @ultimoFuncionarioId, 5 + @ultimoAutomovelId, 2, 2),
('2025-03-01 00:00:00', '2025-03-04 00:00:00', 195.00, 15.00, 1 + @ultimoClienteId, 2 + @ultimoFuncionarioId, 6 + @ultimoAutomovelId, 3, 3),
('2025-04-05 00:00:00', '2025-04-07 00:00:00', 105.00, 0.00, 2 + @ultimoClienteId, 1 + @ultimoFuncionarioId, 7 + @ultimoAutomovelId, 1, 1),
('2025-03-22 00:00:00', '2025-03-26 00:00:00', 240.00, 0.00, 3 + @ultimoClienteId, 5 + @ultimoFuncionarioId, 8 + @ultimoAutomovelId, 2, 1),
('2025-02-18 00:00:00', '2025-02-22 00:00:00', 280.00, 20.00, 4 + @ultimoClienteId, 3 + @ultimoFuncionarioId, 9 + @ultimoAutomovelId, 3, 3),
('2025-04-01 00:00:00', '2025-04-03 00:00:00', 110.00, 0.00, 5 + @ultimoClienteId, 4 + @ultimoFuncionarioId, 1 + @ultimoAutomovelId, 1, 1);



-- Inserir Funções
INSERT INTO Funcao (Designacao, SalarioBase) VALUES
('Gestor de Filial', 2000),
('Assistente de Atendimento', 1100),
('Técnico de Manutenção', 1300),
('Operador de Reservas', 1200),
('Gestor Comercial', 1800);

-- Inserir associação Funcionario-Funcao (Exerce) com offset dinâmico
INSERT INTO Exerce (FuncionarioId, FuncaoId) VALUES
(@ultimoFuncionarioId + 1, @ultimoFuncaoId + 2),
(@ultimoFuncionarioId + 2, @ultimoFuncaoId + 2),
(@ultimoFuncionarioId + 3, @ultimoFuncaoId + 4),
(@ultimoFuncionarioId + 4, @ultimoFuncaoId + 1),
(@ultimoFuncionarioId + 5, @ultimoFuncaoId + 5);

