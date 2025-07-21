# 🚗 Bela Rent-a-Car

Sistema completo de base de dados para uma empresa de Rent-a-Car, desenvolvido principalmente em **MySQL**, com foco em **organização modular**, **automatização** e **segurança dos dados**.

## 🏆 **Nota Final: 18 valores**

---

## 📦 Estrutura do Projeto

### 🏗️ Scripts de Criação e Povoamento

- **`Creation.sql`**  
  Define toda a estrutura da base de dados, incluindo:
  - Tabelas: `Clientes`, `Automoveis`, `Alugueres`, `Funcionarios`, `Filiais`, etc.
  - Restrições: chaves primárias, estrangeiras, unicidade, `CHECK`, `NOT NULL`, entre outras.

- **`povoamento.sql`**  
  Insere dados realistas e variados para testar o comportamento e integridade da base de dados.

---

### ⚙️ Procedures, Funções, Triggers e Eventos

**Arquivo:** `ProceduresFunctionTrigger.sql`

- **Procedures:** Automatizam operações como:
  - Criação de alugueres
  - Registo de novos clientes
  - Abertura de novas filiais

- **Funções:** Realizam cálculos reutilizáveis (ex: custo total de aluguer).

- **Triggers:** Asseguram integridade ao reagirem automaticamente a eventos (ex: inserções ou alterações).

- **Eventos:** Agendam ações periódicas (ex: atualização automática do estado dos automóveis).

---

### 💾 Script de Backup Automático

**Arquivo:** `backup.sh`

- Utiliza `mysqldump` para criar cópias de segurança da base de dados MySQL.
- Pode ser agendado via `cron` para execução periódica.
- Guarda os ficheiros no diretório `backups/`, com **timestamps** para fácil organização.

---

### 👥 Gestão de Utilizadores e Permissões

**Arquivo:** `Utilizadores.sql`

- Cria utilizadores com diferentes perfis:
  - **Gestores:** permissões administrativas.
  - **Funcionários:** permissões restritas.

- Aplica princípios de **segurança** como o do **menor privilégio**, usando `GRANT` e `REVOKE`.

---

### 🔄 Migração de Dados (PostgreSQL, CSV, JSON)

- **`migration.py`**  
  Script em Python que migra dados de:
  - **PostgreSQL**
  - **CSV**
  - **JSON**  
  → para a base de dados central em **MySQL**.

- **`Dados/createPostgresBD.sql` & `Dados/populateMonacoBD.sql`**  
  Criam e populam uma base de dados em PostgreSQL com estrutura semelhante à usada em MySQL.

- **Ficheiros de dados externos:**
  - `Dados/BelgaBD.csv`
  - `Dados/PortugalBD.json`

> ⚠️ **Nota:** A migração não é genérica — foi desenhada especificamente para os dados presentes na pasta `Dados/`.
