# Assets-Manager
Implementação de uma aplicação mobile para gestão de ativos industriais utilizando Flutter.

## Projects

O Assets Manager é composto por quatro projetos principais, cada um desempenhando um papel específico na arquitetura do sistema:

- [**assets-manager-app**](https://github.com/erickerate/Assets-Manager/tree/main/src/application): Um aplicativo móvel construído com Flutter.
- [**assets-manager-domain**](https://github.com/erickerate/Assets-Manager/tree/main/src/domain): O pacote de domínio, abrangendo abstrações para ativos, locais, componentes, modelos, abstração de repositórios e muito mais.
- [**assets-manager-data**](https://github.com/erickerate/Assets-Manager/tree/main/src/data): O pacote para gerir acesso a dados, contendo implementações dos repositórios.
- [**assets-manager-service**](https://github.com/erickerate/Assets-Manager/tree/main/src/service): O pacote de serviços, responsável por conectar as regras de negócio com a camada de dados.

## Arquitetura

A aplicação enfatiza a separação de responsabilidades, aderindo aos princípios SOLID, Clean Architecture/Code e Domain-Driven Design (DDD).

1. **Camada de apresentação**: Inclui uma aplicação utilizando o MobX como padrão de gerenciamento de estado.
2. **Camada de serviço**: Consiste em manipuladores de comandos, modelos, resultados e serviços.
3. **Camada de domínio**: Inclui entidades, comandos, validações e abstrações de repositório.
4. **Camada de dados**: Implementa os repositórios de acesso a dados.

## Visão geral do aplicativo

Abaixo você encontra screenshots das principais telas do sistema.

#### Aplicação
![Aplicação](https://github.com/erickerate/Assets-Manager/blob/main/assets/overview.png)
  
## Requisitos
* Dart SDK '>=3.4.0 <4.0.0'
* Flutter '3.22.0'

## Executar
As etapas a serem executadas são:
1. Clonar este repositório: `gh repo clone erickerate/Assets-Manager`.
2. Abrir o workspace em `src/assets-manager`.
3. Correr `flutter pub get` e `flutter run`.

## Demonstração
https://github.com/user-attachments/assets/dae2f135-b721-4010-ad4c-9b6a9cc35e65
