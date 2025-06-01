INSERT INTO Funcao (Designacao, SalarioBase) VALUES
('Gestor de Frota de Veículos de Luxo', 5500.00),
('Especialista em Atendimento VIP', 4800.00),
('Chauffeur Privado', 5000.00),
('Técnico de Manutenção de Veículos de Luxo', 4500.00),
('Consultor de Aluguer Premium', 4700.00),
('Responsável de Logística', 4300.00),
('Rececionista VIP', 3500.00);




INSERT INTO Funcionario (Nome, NIF, Salario, Telefone, Email, FilialId) VALUES
('Jean Morel', '123456789', 4600.00, '+37761234567', 'jean.m@belarent.mc', 3),
('Sophie Laurent', '987654321', 3200.00, '+37769876543', 'sophie.l@belarent.mc', 3),
('Antoine Dubois', '192837465', 3000.00, '+37764572839', 'antoine.d@belarent.mc', 3),
('Isabelle Blanc', '564738291', 2500.00, '+37761234987', 'isabelle.b@belarent.mc', 3);



INSERT INTO Exerce (FuncionarioId, FuncaoId) VALUES
(2, 4),  
(1, 3),  
(3, 5),  
(4, 6);  




INSERT INTO Cliente (Nome, NIF, LocalTrabalho, Rua, Localidade, CodigoPostal) VALUES
('Charlotte Grimaldi', '111222333', 'Casino de Monte-Carlo', 'Avenue de Monte-Carlo', 'Monte Carlo', '98000'),
('Louis Martinet', '444555666', 'Banque de Monaco', 'Boulevard des Moulins', 'Monaco-Ville', '98000'),
('Camille Duval', '777888999', 'Hôtel Hermitage', 'Rue du Portier', 'Monte Carlo', '98000');



INSERT INTO Cliente_Contacto (ClienteId, Telefone, Email) VALUES
(1, '+37760000001', 'charlotte.g@email.mc'),
(2, '+37760000002', 'louis.m@email.mc'),
(3, '+37760000003', 'camille.d@email.mc');




INSERT INTO Automovel (Marca, Kilometragem, Ano, Estado, TipoConsumo, PrecoDia, FilialId) VALUES
('Ferrari Roma', 12000.500, 2022, 'Disponível', 'Gasolina', 850.00, 3),
('Bentley Continental', 9000.000, 2021, 'Disponível', 'Gasolina', 950.00,3),
('Tesla Model S', 3000.250, 2023, 'Disponível', 'Elétrico', 600.00, 3),
('Porsche Taycan', 5000.000, 2022, 'Disponível', 'Elétrico', 700.00, 3);



INSERT INTO Aluguer (DataInicio, DataFim, Preco, Multa, ClienteId, FuncionarioId, AutomovelId, RecolhidoFilialId, DevolvidoFilialId) VALUES
('2025-05-01 10:00:00', '2025-05-05 10:00:00', 3400.00, 0.00, 1, 2, 1, 3, 1),
('2025-06-10 09:00:00', '2025-06-15 09:00:00', 4750.00, 100.00, 2, 4, 2, 3, 2),
('2025-07-20 12:00:00', '2025-07-25 12:00:00', 3000.00, 0.00, 3, 2, 3, 3, 3);
