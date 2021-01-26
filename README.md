## OM30

Esse projeto foi produzido durante um desafio proposto para a OM30.

## Tecnologias

Tecnologias usadas nesse projeto.

* Ruby version  2.7.1
* Rails version 6.1
* Postgresql 12
* Redis
* elasticsearch

## Serviços
* Gmail
* Twilio

## Ruby Gems
* redis
* sidekiq
* searchkick
* twilio_ruby
* will_paginate

## Setup
Para o funcionamento correto do sistmema é preciso configurar as credencias para os serviços de email e sms.
Primeiramente remova o arquivo de credencieas do repositório
  > rm config/credentials.yml.enc

Depois edite o arquivo com o seguinte comando:
  > EDITOR=nano bundle exec rails credentials:edit 

obs: É precisor ter o editor nano instalado ou usar qualquer um de sua preferência mudando a variável "EDITOR".

No arquivo adicionar as seguintes credenciais
``` bash
twilio_phone_number: +55999999999
twilio_account_sid: xxxxxxxxxxxxxx
twilio_account_token: xxxxxxxx

gmail_user_name: email@gmail.com
gmail_password: xxxxxxxxx
```
obs: substitua os valores atribuídos as credenciais

## Deploy

* Para instalar as gems:
  >    $ bundle install
* Para criar a base de dados e a estrutura do banco de dados:
  >    $ rake db:create db:migrate
* Subindo o projeto:
  >    $ rails s

## Deploy usando Docker e Docker Compose

  > docker-compose run --rm app bundle install

  > docker-compose run --rm app yarn install

  > docker-compose run --rm app bundle exec rake db:create db:migrate

  > docker-compose up -d

## Como Usar
### 1. Lista de Municipes
![siign up](https://github.com/dbnkocao/om30/blob/master/public/readme_images/lista_municipes.png)

### 2. Cadastro Municipe
![siign up](https://github.com/dbnkocao/om30/blob/master/public/readme_images/cadastro_municipes.png)

### 3. Visualizando dados do municipe
![login](https://github.com/dbnkocao/om30/blob/master/public/readme_images/dados_municipe.png)


## Funcionalidades
* Cadastro de municipes com notificações via email e sms.
* Busca otimizada para grande quantidade de dados.

## Links
  * Repository: (https://github.com/dbnkocao/om30)

## Authors
* **Daniel Nascimento**: @dbnkocao (https://github.com/dbnkocao)