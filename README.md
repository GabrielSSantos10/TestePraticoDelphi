# Funcionalidades e Diferenciais Implementados

## 1. CRUD Completo com Controle Transacional

### Atomicidade (All-or-Nothing)

O processo de salvamento de um novo cadastro envolve a inserção simultânea na tabela `Endereco` e na tabela `Pessoa`. Essa operação foi encapsulada dentro de uma transação explícita (`StartTransaction`, `Commit` e `Rollback`) no Controller, garantindo que, caso ocorra qualquer falha no salvamento da pessoa, o endereço criado seja revertido, evitando dados órfãos.

### Exclusão Cascata Tratada

O sistema remove de forma coordenada os registros correspondentes de `Pessoa` e `Endereco`, sob confirmação explícita do usuário.

---

## 2. Controle de Permissões por Nível de Acesso

O sistema implementa regras de controle de acesso baseadas no perfil do usuário logado:

### Perfil ADM

* Controle total sobre o sistema.
* Permissões:

  * Visualizar
  * Inserir
  * Alterar
  * Excluir
  * Visualizar logs

### Perfil EDITOR

* Pode realizar:

  * Consultas
  * Inserções
  * Alterações
* Restrições:

  * Os botões de exclusão são desabilitados e ocultados dinamicamente.
  * A exclusão também é bloqueada por segurança na camada de Controller.

---

## 3. Otimização de Armazenamento e Validação Real

### Dados Limpos (Best Practices)

Seguindo os padrões ideais de mercado, o sistema exibe máscaras de formatação em tempo de digitação (`CPF`, `CEP`, `Telefone`), mas limpa os dados antes da persistência através de uma unidade utilitária (`uValidador.pas`).

O banco armazena apenas os caracteres numéricos puros, economizando espaço físico e otimizando índices.

### Validação Matemática de CPF

Foi implementada uma rotina algorítmica real para validação dos dois dígitos verificadores do CPF. O sistema impede cadastros fictícios ou inválidos.

### Validação de E-mail

Bloqueio nativo caso o formato estrutural do e-mail não atenda aos requisitos mínimos de integridade, como a presença do caractere `@`.

### Garantia de CPF Único

O sistema realiza uma busca prévia na camada Controller antes de qualquer inserção ou atualização, emitindo um aviso amigável caso o documento já exista, evitando exceções diretamente na interface.

---

## 4. Integração Fluida ViaCEP

### Gatilho `OnExit`

A busca pelo endereço ocorre automaticamente assim que o usuário termina de preencher o campo `CEP` e muda o foco.

O retorno JSON é processado e os campos abaixo são preenchidos automaticamente:

* Logradouro
* Bairro
* Cidade
* Estado

Os campos permanecem editáveis manualmente, caso seja necessário algum ajuste.

---

## 5. Interface Polida e Correção de Bugs do SQLite

### Tratamento de `Memo`/`WideMemo`

Foi corrigido o comportamento padrão do FireDAC de exibir o texto (`WideMemo`) incorretamente nas colunas da Grid quando conectado ao SQLite.

Foi injetada uma regra programática de mapeamento de tipos de dados (`MapRules`) para converter `dtWideMemo` em `dtWideString`, garantindo a leitura textual correta diretamente no `TDBGrid`.

### Resets de Estado

As telas e filtros de pesquisa são limpos corretamente no momento do logout, impedindo vazamento de informações entre sessões de usuários diferentes.

---

# Como Configurar e Executar o Projeto

## 1. Abertura do Projeto

Abra a IDE **Delphi Community Edition** e carregue o arquivo de projeto correspondente (`.dproj` ou `.dpr`).

## 2. Configuração do Banco de Dados

* Certifique-se de que o componente `TFDConnection` esteja apontando para o caminho correto do arquivo `banco.db` local na sua máquina.
* Caso precise recriar a estrutura do zero, utilize o script `testePratico.sql` fornecido na pasta raiz.

## 3. Compilação

* Pressione `Ctrl + F9` para compilar.
* Pressione `F9` para executar a aplicação.

---

# Credenciais Padrão para Testes

O script do banco de dados pré-popula o sistema com dois usuários base:

| Usuário  | Senha      | Perfil de Acesso    | Restrições                 |
| -------- | ---------- | ------------------- | -------------------------- |
| `admin`  | `admin123` | ADM (Administrador) | Acesso total ao sistema    |
| `editor` | `admin123` | EDITOR (Operador)   | Não pode excluir registros |

---

# Justificativas de Decisões Técnicas

## Uso de `TMaskEdit` vs Componentes de Terceiros

Optou-se pela utilização do componente nativo `TMaskEdit` com propriedades `EditMask` dinâmicas para manter o projeto leve, sem dependências externas complexas que pudessem inviabilizar a compilação direta na máquina do avaliador.

## Ausência de Máscara Estrutural no E-mail

Decidiu-se não aplicar uma máscara de caracteres fixa no campo de e-mail, pois os endereços possuem tamanhos e distribuições variáveis.

A validação foi resolvida de forma mais simples através de lógica de código no momento do envio do formulário.

## Trilha de Logs Centralizada no Controller

A gravação de auditoria foi inserida no `PessoaController` logo após as confirmações de `Commit`, garantindo que ações com erro ou tentativas frustradas de gravação não poluam a tabela de logs com dados incorretos, mantendo a fidelidade do histórico do sistema.
