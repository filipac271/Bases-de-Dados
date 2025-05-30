-- Criar a base de dados
CREATE DATABASE IF NOT EXISTS BelaRentacar;
USE BelaRentacar;

-- Tabela Funcionario
CREATE TABLE Funcionario (
    Id INT PRIMARY KEY NOT NULL,
    Nome VARCHAR(75) NOT NULL,
    NIF INT(9) NOT NULL,
    Salario DECIMAL(5, 2 ) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(200) NULL,
    FilialId INT NOT NULL,
    FOREIGN KEY (FilialId) REFERENCES Filial(Id)
);

-- Tabela Funcao
CREATE TABLE Funcao (
    Id INT PRIMARY KEY NOT NULL,
    Designacao VARCHAR(75) NOT NULL,
    SalarioBase DECIMAL(5,2) NOT NULL
);

-- Tabela de associação Exerce (N:N entre Funcionario e Funcao)
CREATE TABLE Exerce (
    FuncionarioId INT NOT NULL,
    FuncaoId INT NOT NULL,
    PRIMARY KEY (FuncionarioId, FuncaoId),
    FOREIGN KEY (FuncionarioId) REFERENCES Funcionario(Id),
    FOREIGN KEY (FuncaoId) REFERENCES Funcao(Id)
);

-- Tabela Filial
CREATE TABLE Filial (
    Id INT PRIMARY KEY NOT NULL,
    Localizacao VARCHAR(75) NOT NULL
);

-- Tabela Cliente
CREATE TABLE Cliente (
    Id INT PRIMARY KEY NOT NULL,
    Nome VARCHAR(75) NOT NULL,
    NIF INT(9) NOT NULL,
    LocalTrabalho VARCHAR(75) NOT NULL,
    Rua VARCHAR(75) NOT NULL,
    Localidade VARCHAR(75) NOT NULL,
    CodigoPostal VARCHAR(10) NOT NULL
);

-- Tabela de Contactos do Cliente (atributo multivalorado)
CREATE TABLE Cliente_Contacto (
    ClienteId INT NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(200) NULL,
    PRIMARY KEY (ClienteId, Telefone),
    FOREIGN KEY (ClienteId) REFERENCES Cliente(Id)
);

-- Tabela Automovel
CREATE TABLE Automovel (
    Id INT PRIMARY KEY NOT NULL,
    Marca VARCHAR(75) NOT NULL,
    Kilometragem DECIMAL(8,3) NOT NULL,
    Ano YEAR NOT NULL,
    Estado VARCHAR(10) NOT NULL,
    TipoConsumo VARCHAR(10) NOT NULL,
    PrecoDia DECIMAL(8,2) NOT NULL,
    FilialId INT NOT NULL,
    FOREIGN KEY (FilialId) REFERENCES Filial(Id)
);

-- Tabela Aluguer
CREATE TABLE Aluguer (
    Id INT PRIMARY KEY NOT NULL,
    DataInicio DATETIME NOT NULL,
    DataFim DATETIME NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    Multa DECIMAL(5,2) NULL,
    ClienteId INT NOT NULL,
    FuncionarioId INT NOT NULL,
    AutomovelId INT NOT NULL,
    RecolhidoFilialId INT NOT NULL,
    DevolvidoFilialId INT NOT NULL,
    FOREIGN KEY (ClienteId) REFERENCES Cliente(Id),
    FOREIGN KEY (FuncionarioId) REFERENCES Funcionario(Id),
    FOREIGN KEY (AutomovelId) REFERENCES Automovel(Id),
    FOREIGN KEY (RecolhidoFilialId) REFERENCES Filial(Id),
    FOREIGN KEY (DevolvidoFilialId) REFERENCES Filial(Id)
);
