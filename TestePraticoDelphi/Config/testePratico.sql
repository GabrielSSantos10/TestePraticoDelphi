-- Tabela TipoPessoa
CREATE TABLE TipoPessoa (
    tipo_pessoa_id INTEGER PRIMARY KEY AUTOINCREMENT,
    descricao TEXT NOT NULL UNIQUE
);

-- Tabela Endereco
CREATE TABLE Endereco (
    endereco_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cep TEXT NOT NULL,
    logradouro TEXT NOT NULL,
    complemento TEXT,
    bairro TEXT,
    cidade TEXT NOT NULL,
    estado TEXT NOT NULL
);

-- Tabela Pessoa
CREATE TABLE Pessoa (
    pessoa_id INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo_pessoa_id INTEGER NOT NULL,
    nome TEXT NOT NULL,
    data_nascimento DATE,
    cpf TEXT NOT NULL UNIQUE,
    rg TEXT,
    email TEXT NOT NULL,
    telefone TEXT,
    endereco_id INTEGER,
    FOREIGN KEY(tipo_pessoa_id) REFERENCES TipoPessoa(tipo_pessoa_id),
    FOREIGN KEY(endereco_id) REFERENCES Endereco(endereco_id)
);

-- Alguns tipos padrão inicial
INSERT INTO TipoPessoa (descricao) VALUES 
    ('Cliente'), 
    ('Fornecedor'),
    ('Funcionário');

-- Tabela Usuario
CREATE TABLE Usuario (
    usuario_id INTEGER PRIMARY KEY AUTOINCREMENT,
    login TEXT NOT NULL UNIQUE,
    senha_hash TEXT NOT NULL,
    perfil TEXT NOT NULL CHECK (perfil IN ('ADM', 'EDITOR'))
);

-- Tabela Log
CREATE TABLE Log (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL,
    acao TEXT NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT (datetime('now','localtime')),
    detalhes TEXT,
    FOREIGN KEY(usuario_id) REFERENCES Usuario(usuario_id)
);

-- Usuário ADM: login: admin, senha: admin123
-- Usuário Editor: login: editor, senha: TEST

INSERT INTO Usuario (login, senha_hash, perfil) VALUES 
  ('admin',  '0192023a7bbd73250516f069df18b500', 'ADM'),
  ('editor', '033bd94b1168d7e4f0d644c3c95e35bf', 'EDITOR');
