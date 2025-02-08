# 🚀 Tech Interview Backend - Entry Level

Este é um projeto backend desenvolvido em **Ruby on Rails** com **PostgreSQL** e **Redis**, rodando em contêineres Docker.

---

## 🛠️ **Pré-requisitos**
Antes de executar o projeto, certifique-se de ter os seguintes requisitos instalados:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

---

## 📦 **Instalação e Configuração**
1. **Clone este repositório**:
   ```sh
   git clone https://github.com/seu-usuario/seu-repositorio.git
   cd seu-repositorio
2. **Copie o arquivo de variáveis de ambiente (se necessário)**:
   ```sh
   cp .env.example .env

3. **Suba os contêineres do projeto:**:
   ```sh
   docker-compose up --build

4. **Verifique se os serviços estão rodando**:
   ```sh
   docker ps

## 🗺️ **Para ver as Rotas Criadas**
 ```sh
   rails routes | grep cart
  ```

## 🧪 **Rodando os Testes**
  Pelo Rails:
  ```sh
   rails test test/controllers/cart_controller_test.rb
   rails test test/controllers/products_controller_test.rb
  ```

## 🔮 Futuras Melhorias

### 🛠️ **Correções nos Testes de Carts**
- Resolver falhas intermitentes nos testes de integração do **CartsController**.
- Garantir que a sessão ou cookies sejam corretamente simulados nos testes.
- Ajustar os testes para melhor refletirem a lógica de recuperação e criação do carrinho.

### 🐳 **Ajustes no Docker**
- Corrigir erro de permissão no script `docker-entrypoint`.
- Ajustar a instalação das gems para garantir que o comando `rails` seja corretamente encontrado dentro do contêiner.
- Melhorar a estabilidade do banco de dados **PostgreSQL** e do **Redis** no ambiente Docker.
- Revisar configurações de variáveis de ambiente para melhor compatibilidade em diferentes sistemas.


Caso queira contribuir, sinta-se à vontade para abrir uma **issue** ou um **pull request**! 😊

👨‍💻 Desenvolvido por [Erin Vasconcelos]
