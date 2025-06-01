-- Criar a base de dados
DROP DATABASE IF EXISTS BelaRentaCar;
CREATE DATABASE IF NOT EXISTS BelaRentaCar
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE BelaRentaCar;

-- Tabela Filial
CREATE TABLE IF NOT EXISTS Filial (
    Id INT NOT NULL AUTO_INCREMENT,
    Localizacao VARCHAR(75) UNIQUE NOT NULL,
    PRIMARY KEY(Id)
);

-- Tabela Funcionario
CREATE TABLE IF NOT EXISTS Funcionario (
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(75) NOT NULL,
    NIF VARCHAR(9) NOT NULL UNIQUE CHECK (LENGTH(NIF) = 9),
    Salario DECIMAL(8,2) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(200) NULL,
    FilialId INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY (FilialId) REFERENCES Filial(Id)
);

-- Tabela Funcao
CREATE TABLE IF NOT EXISTS Funcao (
    Id INT NOT NULL AUTO_INCREMENT,
    Designacao VARCHAR(75) UNIQUE NOT NULL,
    SalarioBase DECIMAL(8,2) NOT NULL,
    PRIMARY KEY(Id)
);

-- Tabela de associação Exerce (N:N entre Funcionario e Funcao)
CREATE TABLE IF NOT EXISTS Exerce (
    FuncionarioId INT NOT NULL,
    FuncaoId INT NOT NULL,
    PRIMARY KEY (FuncionarioId, FuncaoId),
    FOREIGN KEY (FuncionarioId) REFERENCES Funcionario(Id),
    FOREIGN KEY (FuncaoId) REFERENCES Funcao(Id)
);

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(75) NOT NULL,
    NIF VARCHAR(9) NOT NULL UNIQUE CHECK (LENGTH(NIF) = 9),
    LocalTrabalho VARCHAR(75) NOT NULL,
    Rua VARCHAR(75) NOT NULL,
    Localidade VARCHAR(75) NOT NULL,
    CodigoPostal VARCHAR(10) NOT NULL,
    PRIMARY KEY(Id)
);

-- Tabela de Contactos do Cliente (atributo multivalorado)
CREATE TABLE IF NOT EXISTS Cliente_Contacto (
    ClienteId INT NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(200) NULL,
    PRIMARY KEY (ClienteId, Telefone),
    FOREIGN KEY (ClienteId) REFERENCES Cliente(Id)
);

-- Tabela Automovel
CREATE TABLE IF NOT EXISTS Automovel (
    Id INT NOT NULL AUTO_INCREMENT,
    Marca VARCHAR(75) NOT NULL,
    Kilometragem DECIMAL(8,3) NOT NULL,
    Ano YEAR NOT NULL,
    Estado VARCHAR(10) NOT NULL,
    TipoConsumo VARCHAR(10) NOT NULL,
    PrecoDia DECIMAL(8,2) NOT NULL,
    FilialId INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (FilialId) REFERENCES Filial(Id)
);

-- Tabela Aluguer
CREATE TABLE IF NOT EXISTS Aluguer (
    Id INT NOT NULL AUTO_INCREMENT,
    DataInicio DATETIME NOT NULL,
    DataFim DATETIME NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    Multa DECIMAL(5,2) NULL,
    ClienteId INT NOT NULL,
    FuncionarioId INT NOT NULL,
    AutomovelId INT NOT NULL,
    RecolhidoFilialId INT NOT NULL,
    DevolvidoFilialId INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY (ClienteId) REFERENCES Cliente(Id),
    FOREIGN KEY (FuncionarioId) REFERENCES Funcionario(Id),
    FOREIGN KEY (AutomovelId) REFERENCES Automovel(Id),
    FOREIGN KEY (RecolhidoFilialId) REFERENCES Filial(Id),
    FOREIGN KEY (DevolvidoFilialId) REFERENCES Filial(Id)
);




