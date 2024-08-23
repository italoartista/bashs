#!/bin/bash

# Criação das pastas principais
mkdir -p pim-project/src/{controllers,services,repositories,models,routes,config,middlewares,utils}
mkdir -p pim-project/tests/{controllers,services,repositories,models,middlewares,utils}

# Criação do arquivo .env
cat > pim-project/.env <<EOL
DB_USER=your_db_user
DB_HOST=your_db_host
DB_NAME=your_db_name
DB_PASS=your_db_pass
DB_PORT=5432
PORT=3000
EOL

# Criação do arquivo .gitignore
cat > pim-project/.gitignore <<EOL
node_modules
.env
EOL

# Criação do arquivo package.json
cat > pim-project/package.json <<EOL
{
  "name": "pim-project",
  "version": "1.0.0",
  "main": "src/config/server.js",
  "scripts": {
    "start": "node src/config/server.js",
    "test": "jest"
  },
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.7.1",
    "dotenv": "^16.0.3"
  },
  "devDependencies": {
    "jest": "^29.0.3",
    "supertest": "^6.3.3"
  }
}
EOL

# Criação do arquivo README.md
cat > pim-project/README.md <<EOL
# PIM Project

Este é um projeto de gerenciamento de informações de produtos (PIM) desenvolvido em Node.js com Express.js.

## Estrutura do Projeto

- **src/**: Código fonte da aplicação.
  - **controllers/**: Controladores da aplicação.
  - **services/**: Serviços de lógica de negócios.
  - **repositories/**: Repositórios de acesso a dados.
  - **models/**: Modelos de dados.
  - **routes/**: Rotas da API.
  - **config/**: Configurações da aplicação.
  - **middlewares/**: Middlewares da aplicação.
  - **utils/**: Utilitários e funções auxiliares.

- **tests/**: Testes da aplicação.
- **.env**: Variáveis de ambiente.
- **.gitignore**: Arquivos e pastas a serem ignorados pelo Git.
- **package.json**: Dependências e scripts do projeto.
- **README.md**: Documentação do projeto.

## Instruções de Instalação

1. Clone o repositório.
2. Instale as dependências: \`npm install\`.
3. Crie um arquivo \`.env\` com as configurações do banco de dados.
4. Inicie o servidor: \`npm start\`.

## Requisitos

Veja o arquivo [REQUIREMENTS.md](REQUIREMENTS.md) para detalhes sobre os requisitos do projeto.
EOL

# Criação do arquivo REQUIREMENTS.md
cat > pim-project/REQUIREMENTS.md <<EOL
# Documento de Requisitos

## 1. Visão Geral
Este projeto consiste em um PIM (Product Information Management) desenvolvido em Node.js com Express.js, utilizando os princípios de MVC, SOLID, e Injeção de Dependências (ID). A aplicação se conectará ao PostgreSQL sem utilizar ORM, utilizando template strings para a camada de acesso a dados. O objetivo é gerenciar informações de produtos de forma eficiente e segura.

## 2. Funcionalidades Principais
A aplicação PIM deve fornecer as seguintes funcionalidades principais:

- **Gestão de Produtos:** Criar, Ler, Atualizar e Excluir (CRUD) produtos.
- **Gestão de Categorias:** CRUD de categorias de produtos.
- **Gestão de Atributos:** CRUD de atributos customizados de produtos.
- **Gestão de Fornecedores:** CRUD de fornecedores.
- **Gestão de Estoque:** CRUD de informações de estoque.
- **Gestão de Preços:** CRUD de tabelas de preços.
- **Gestão de Imagens:** Upload e associação de imagens a produtos.

## 3. Requisitos Funcionais

### 3.1 Operações CRUD

**Produtos**
- Criar um produto
- Ler informações de um produto
- Atualizar informações de um produto
- Excluir um produto

**Categorias**
- Criar uma categoria
- Ler informações de uma categoria
- Atualizar uma categoria
- Excluir uma categoria

**Atributos**
- Criar um atributo
- Ler informações de um atributo
- Atualizar um atributo
- Excluir um atributo

**Fornecedores**
- Criar um fornecedor
- Ler informações de um fornecedor
- Atualizar informações de um fornecedor
- Excluir um fornecedor

**Estoque**
- Criar um registro de estoque
- Ler informações de estoque
- Atualizar informações de estoque
- Excluir um registro de estoque

**Preços**
- Criar uma tabela de preços
- Ler informações de uma tabela de preços
- Atualizar uma tabela de preços
- Excluir uma tabela de preços

**Imagens**
- Upload de imagem
- Associações de imagens a produtos
- Excluir imagem

### 3.2 Regras de Negócio

1. **Validação de SKU:** Cada produto deve possuir um SKU (Stock Keeping Unit) único.
2. **Obrigatoriedade de Categoria:** Todo produto deve estar associado a uma categoria.
3. **Validação de Preço:** O preço de um produto não pode ser negativo.
4. **Validação de Estoque:** Não permitir que a quantidade em estoque de um produto seja negativa.
5. **Data de Criação e Atualização:** Registrar automaticamente a data de criação e atualização de um produto.
6. **Controle de Versão de Produto:** Manter histórico de versões de um produto.
7. **Obrigatoriedade de Fornecedor:** Um produto deve ter pelo menos um fornecedor associado.
8. **Validação de Atributos:** Os atributos de produtos devem seguir regras específicas, como tipo de dado e valores permitidos.
9. **Limite de Imagens por Produto:** Um produto pode ter no máximo 10 imagens associadas.
10. **Obrigatoriedade de Preço:** Todo produto deve ter um preço associado.
11. **Desconto Máximo:** Limitar o desconto máximo permitido para um produto a 50%.
12. **Validação de Nome de Categoria:** O nome de uma categoria deve ser único.
13. **Obrigatoriedade de Descrição:** Todo produto deve ter uma descrição detalhada.
14. **Controle de Estoque Mínimo:** Avisar quando o estoque de um produto estiver abaixo do mínimo estabelecido.
15. **Validação de Dados de Fornecedor:** Verificar a validade dos dados fornecidos pelo fornecedor (ex: CNPJ).
16. **Validação de Imagens:** Verificar o formato e tamanho das imagens carregadas.
17. **Associação de Atributos a Categorias:** Certos atributos devem ser aplicáveis apenas a determinadas categorias.
18. **Controle de Acesso:** Apenas usuários autenticados e autorizados podem modificar as informações de produtos.
19. **Histórico de Preços:** Manter um histórico das alterações de preços dos produtos.
20. **Regras de Promocionais:** Permitir a criação de regras promocionais baseadas em categorias, fornecedores, etc.
EOL

# Criação de arquivos principais

# Configuração do Banco de Dados
cat > pim-project/src/config/database.js <<EOL
const { Pool } = require('pg');
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASS,
  port: process.env.DB_PORT,
});

module.exports = {
  query: (text, params) => pool.query(text, params),
};
EOL

# Servidor Express
cat > pim-project/src/config/server.js <<EOL
const express = require('express');
const app = express();
const productRoutes = require('../routes/productRoutes');
require('dotenv').config();

// Middlewares
app.use(express.json());
app.use('/products', productRoutes);

// Error handling
const errorHandler = require('../middlewares/errorHandler');
app.use(errorHandler);

// Start the server
const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
EOL

# Modelo de Produto
cat > pim-project/src/models/product.js <<EOL
const db = require('../config/database');

// Exemplo de função para obter produtos
const getAllProducts = async () => {
  const result = await db.query('SELECT * FROM products');
  return result.rows;
};

module.exports = {
  getAllProducts,
  // Adicione outras funções de CRUD aqui
};
EOL

# Controlador de Produto
cat > pim-project/src/controllers/productController.js <<EOL
const productService = require('../services/productService');

const getAllProducts = async (req, res) => {
  try {
    const products = await productService.getAllProducts();
    res.json(products);
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

// Adicione outras funções de CRUD aqui

module.exports = {
  getAllProducts,
  // Adicione outras funções de CRUD aqui
};
EOL

# Serviço de Produto
cat > pim-project/src/services/productService.js <<EOL
const productRepository = require('../repositories/productRepository');

const getAllProducts = async () => {
  return await productRepository.getAllProducts();
};

// Adicione outras funções de CRUD aqui

module.exports = {
  getAllProducts,
  // Adicione outras funções de CRUD aqui
};
EOL

# Repositório de Produto
cat > pim-project/src/repositories/productRepository.js <<EOL
const db = require('../config/database');

const getAllProducts = async () => {
  const result = await db.query('SELECT * FROM products');
  return result.rows;
};

// Adicione outras funções de CRUD aqui

module.exports = {
  getAllProducts,
  // Adicione outras funções de CRUD aqui
};
EOL

# Testes com Jest para Controllers
cat > pim-project/tests/controllers/productController.test.js <<EOL
const request = require('supertest');
const app = require('../../src/config/server');
const productService = require('../../src/services/productService');

jest.mock('../../src/services/productService');

describe('GET /products', () => {
  it('should return all products', async () => {
    const products = [{ id: 1, name: 'Product 1' }];
    productService.getAllProducts.mockResolvedValue(products);

    const response = await request(app).get('/products');
    expect(response.status).toBe(200);
    expect(response.body).toEqual(products);
  });

  // Adicione outros testes de controlador aqui
});
EOL

# Testes com Jest para Services
cat > pim-project/tests/services/productService.test.js <<EOL
const productRepository = require('../../src/repositories/productRepository');
const productService = require('../../src/services/productService');

jest.mock('../../src/repositories/productRepository');

describe('Product Service', () => {
  it('should get all products', async () => {
    const products = [{ id: 1, name: 'Product 1' }];
    productRepository.getAllProducts.mockResolvedValue(products);

    const result = await productService.getAllProducts();
    expect(result).toEqual(products);
  });

  // Adicione outros testes de serviço aqui
});
EOL

# Testes com Jest para Repositories
cat > pim-project/tests/repositories/productRepository.test.js <<EOL
const db = require('../../src/config/database');
const productRepository = require('../../src/repositories/productRepository');

jest.mock('../../src/config/database');

describe('Product Repository', () => {
  it('should get all products', async () => {
    const products = [{ id: 1, name: 'Product 1' }];
    db.query.mockResolvedValue({ rows: products });

    const result = await productRepository.getAllProducts();
    expect(result).toEqual(products);
  });

  // Adicione outros testes de repositório aqui
});
EOL

# Testes com Jest para Models
cat > pim-project/tests/models/product.test.js <<EOL
// Testes para o modelo de produto (se necessário)
EOL

# Testes com Jest para Middlewares
cat > pim-project/tests/middlewares/errorHandler.test.js <<EOL
const errorHandler = require('../../src/middlewares/errorHandler');

describe('Error Handler Middleware', () => {
  it('should handle errors', () => {
    const req = {};
    const res = { status: jest.fn().mockReturnThis(), send: jest.fn() };
    const next = jest.fn();

    errorHandler(new Error('Test error'), req, res, next);

    expect(res.status).toHaveBeenCalledWith(500);
    expect(res.send).toHaveBeenCalledWith('Something broke!');
  });
});
EOL

# Testes com Jest para Utils
cat > pim-project/tests/utils/validators.test.js <<EOL
// Testes para utilitários de validação
EOL

cat > pim-project/tests/utils/helpers.test.js <<EOL
// Testes para utilitários auxiliares
EOL

# Adicionar configuração do Jest
cat > pim-project/jest.config.js <<EOL
module.exports = {
  testEnvironment: 'node',
  coverageDirectory: 'coverage',
  testMatch: ['**/tests/**/*.test.js'],
};
EOL

# Instalar dependências
npm install

# Instalar dependências de desenvolvimento
npm install --save-dev jest supertest

# Torne o script executável
chmod +x create-project.sh

echo "Projeto criado com sucesso!"
