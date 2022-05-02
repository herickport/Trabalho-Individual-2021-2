# Trabalho Individual  2021.2

Os conhecimentos de *Gestão de Configuração de Software* são fundamentais no ciclo de vida de um produto de software. As técnicas para a gestão vão desde o controle de versão, automação de build e de configuração de ambiente, testes automatizados, isolamento do ambiente até o deploy do sistema. Todo este ciclo nos dias de hoje são integrados em um pipeline de DevOps com as etapas de Integração Contínua (CI) e Deploy Contínuo (CD) implementadas e automatizada.

Para exercitar estes conhecimentos, neste trabalho, você deverá aplicar os conceitos estudados ao longo da disciplina no produto de software contido neste repositório.

O sistema se trata de uma aplicação em Ruby on Rails composta por:

- Aplicação de Gerência de Biblioteca;
- Banco de Dados Postgres;

## Resumo da aplicação

A aplicação é um simples sistema de cadastro de livros. Porém, o foco do trabalho é na automação da build, testes, conteinerização e configuração dos pipelines de CI/CD. Está escrita em Ruby on Rails, utiliza o banco de dados Postgres e inclui testes.

## Etapas de trabalho

### 1. Containerização do Banco

A versão inicial do sistema é uma aplicação Ruby on Rails cujo funcionamento requer uma instalação de um banco de dados Postgres. A primeira etapa do trabalho é de configurar um container somente para o banco de dados com as credenciais especificadas na descrição da aplicação e testar o funcionamento do mesmo.

#### Solução

A containerização do Banco de Dados Postgres foi realizada utilizando a imagem oficial do postgres. Para isso, foi criado o service ***db*** no Docker Compose e um arquivo para definir as variáveis de ambiente ([Containerização do Banco](https://github.com/herickport/Trabalho-Individual-2021-2/commit/b1512854fae4a694e831fd5a08dbb98249a06778)). Posteriormente, foi adicionado um [volume](https://github.com/herickport/Trabalho-Individual-2021-2/commit/629f1eaa43629a54b19e7d778887729168e73b3c) ao container do banco de dados com o intuito de persistir os dados.

##### Como Rodar:

- Container do Banco de Dados: 
```
docker-compose up --build
```

- Criação do Banco com seed
```
rails db:setup
```

- Rodar a aplicação
```
rails server
```

### 2. Containerização da Aplicação + Banco

Nesta segunda etapa, tanto a aplicação quanto o banco de dados deverão estar funcionando em containers individuais.

Deverá ser utilizado um orquestrador (Docker Compose) para gerenciar comunicação entre os containers além do uso de credenciais, networks, volumes, entre outras configurações necessárias para a correta execução da aplicação.

#### Solução

Para a containerização da aplicação foi adicionado um novo service ***app*** ao Docker Compose, com build definida a partir de um arquivo Dockerfile que constrói a imagem do ruby, define o que será executado na inicialização do container (ENTRYPOINT + CMD), etc. [Containerização da Aplicação + Banco](https://github.com/herickport/Trabalho-Individual-2021-2/commit/9ef061963a92cd30789a4d26e2571e4278efb173)

##### Como Rodar:

- Build: 
```
docker-compose build
```

- Configuração do banco (Antes da primeira execução)
```
docker-compose run app rails db:setup
```

- Rodar a aplicação (Acessível em http://0.0.0.0:3000)
```
docker-compose up
```

### 3. Adição de um container do Nginx 

A aplicação originalmente está configurada para rodar com um servidor web simples interno na porta 3000. Nesta etapa será necessário adicionar o servidor Nginx para servir a aplicação através da porta 80. O resultado final também estará expresso utilizando o Docker Compose.

#### Solução

Para adicionar o servidor Nginx ao projeto foi utilizado um arquivo de configuração ***nginx.conf*** e um Dockerfile (Dockerfile.nginx), definindo os passos necessários para a criação do container do nginx. Com isso, foi adicionado um novo service ***nginx*** ao Docker Compose do projeto. [Containerização da Aplicação + Banco + Nginx](https://github.com/herickport/Trabalho-Individual-2021-2/commit/09c15ba932a41ca9d90c301f808ff9aef19e4344)

##### Como Rodar:

Os comandos para execução ao fim desta etapa são os mesmo descritos na etapa anterior (2. Containerização da Aplicação + Banco), com exceção de que agora a aplicação também estará disponível no endereço http://localhost:80.

### 4. Integração Contínua (CI)

Para a realização desta etapa, a aplicação já deverá ter seu ambiente completamente containerizado.

Deverá ser utilizada uma ferramenta de Integração Contínua para garantir o build, os testes e os deploy para o [Docker Hub](https://hub.docker.com) dos serviços principais.

Esta etapa do trabalho poderá ser realizada utilizado os ambientes de CI do [GitLab-CI](https://docs.gitlab.com/ee/ci/). ou [Github Actions](https://github.com/features/actions).  

Requisitos da configuração da Integração Contínua (Gitlab ou Github) incluem:
- Build
- Test
- Lint

#### Solução

Para realizar a Integração Contínua da aplicação foi utilizado o Github Actions, criando uma pipeline de CI (definida em [.github/workflows/ci.yml](https://github.com/herickport/Trabalho-Individual-2021-2/blob/main/.github/workflows/ci.yml)) e que é executada sempre que há um push ou pull request à branch main, rodando os jobs de **build**, **test** e **lint** de maneira sequencial.

### 5. Deploy Contínuo (CD)

A etapa final do trabalho deverá ser realizada à partir do deploy automático da aplicação que deve ser realizado à partir após passar sem erros em todas as etapas de CI.

#### Solução

A pipeline de CD da aplicação está definida em [.github/workflows/cd.yml](https://github.com/herickport/Trabalho-Individual-2021-2/blob/main/.github/workflows/cd.yml) e também foi realizada utilizando o Github Actions. Ela é executada após a pipeline de CI finalizar e faz o deploy para o repositório [gces](https://hub.docker.com/repository/docker/herickport/gces) no Docker Hub.
