DROP DATABASE belarentacarmonaco;

CREATE DATABASE BelaRentaCarMonaco;

\c belarentacarmonaco;

-- Tabela Funcionario
CREATE TABLE IF NOT EXISTS Funcionario (
    Id SERIAL PRIMARY KEY,
    Nome VARCHAR(75) NOT NULL,
    NIF VARCHAR(9) NOT NULL UNIQUE CHECK (char_length(NIF) = 9),
    Salario DECIMAL(8,2) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(200),
    FilialId INT NOT NULL CHECK (FilialId = 3)
);

-- Tabela Funcao
CREATE TABLE IF NOT EXISTS Funcao (
    Id SERIAL PRIMARY KEY,
    Designacao VARCHAR(75) UNIQUE NOT NULL,
    SalarioBase DECIMAL(8,2) NOT NULL
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
    Id SERIAL PRIMARY KEY,
    Nome VARCHAR(75) NOT NULL,
    NIF VARCHAR(9) NOT NULL UNIQUE CHECK (char_length(NIF) = 9),
    LocalTrabalho VARCHAR(75) NOT NULL,
    Rua VARCHAR(75) NOT NULL,
    Localidade VARCHAR(75) NOT NULL,
    CodigoPostal VARCHAR(10) NOT NULL
);

-- Tabela de Contactos do Cliente (atributo multivalorado)
CREATE TABLE IF NOT EXISTS Cliente_Contacto (
    ClienteId INT NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(200),
    PRIMARY KEY (ClienteId, Telefone),
    FOREIGN KEY (ClienteId) REFERENCES Cliente(Id)
);

-- Tabela Automovel
CREATE TABLE IF NOT EXISTS Automovel (
    Id SERIAL PRIMARY KEY,
    Marca VARCHAR(75) NOT NULL,
    Kilometragem DECIMAL(8,3) NOT NULL,
    Ano INT NOT NULL CHECK (Ano >= 1886 AND Ano <= EXTRACT(YEAR FROM CURRENT_DATE)),
    Estado VARCHAR(10) NOT NULL,
    TipoConsumo VARCHAR(10) NOT NULL,
    PrecoDia DECIMAL(8,2) NOT NULL,
    FilialId INT NOT NULL CHECK (FilialId = 3)
);

-- Tabela Aluguer
CREATE TABLE IF NOT EXISTS Aluguer (
    Id SERIAL PRIMARY KEY,
    DataInicio TIMESTAMP NOT NULL,
    DataFim TIMESTAMP NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    Multa DECIMAL(5,2),
    ClienteId INT NOT NULL,
    FuncionarioId INT NOT NULL,
    AutomovelId INT NOT NULL,
    RecolhidoFilialId INT NOT NULL CHECK (RecolhidoFilialId = 3),
    DevolvidoFilialId INT NOT NULL CHECK (DevolvidoFilialId in (1,2,3)),
    FOREIGN KEY (ClienteId) REFERENCES Cliente(Id),
    FOREIGN KEY (FuncionarioId) REFERENCES Funcionario(Id),
    FOREIGN KEY (AutomovelId) REFERENCES Automovel(Id)
);
