# Assets-Manager
Implementação de uma aplicação mobile para gestão de ativos industriais utilizando Flutter.

## Visão geral do aplicativo

Abaixo você encontra screenshots das principais telas do aplicativo.

#### Aplicação (v.13.11.2024)
![Aplicação](https://github.com/erickerate/Assets-Manager/blob/main/assets/app-overview.png)

## Algoritmos de Construção e Filtragem da Árvore

#### Construção da Árvore 

Para construir a árvore de forma eficiente, utilizou-se a estrutura de dados Map baseada em pares chave/valor. O Map permite uma construção direta da árvore, associando cada item da lista a um nó específico através de um par id -> TreeItem. Dessa forma, pode-se acessar rapidamente qualquer nó dentro da estrutura em árvore sem precisar iterar sobre os itens repetidamente.

- Passo 1: Inicializar um Map, onde cada chave é o id do item e o valor é o item correspondente (TreeItem).
- Passo 2: Iterar sobre a lista de itens, e para cada item, busca-se seu pai diretamente no Map utilizando treeItem.parentId.
- Passo 3: Se o item não possui parentId, ele é definido como a raiz da árvore. Caso contrário, é adicionado como filho do nó pai correspondente.

Este método reduz a complexidade do algoritmo para O(n), já que acessamos cada nó diretamente e o conectamos ao pai de forma eficiente.


#### Filtragem da Árvore

Para aplicar os filtros, foi adotada uma abordagem que exibe os itens que atendem aos critérios dos filtros, juntamente com seus elementos ascendentes até a raiz, de modo a exibir toda a hierarquia dos itens. O algoritmo de filtragem é implementado da seguinte forma:

- Passo 1: Os filtros são aplicados para obter apenas os itens correspondentes. Define-se cada item desta coleção como “visível”.
- Passo 2: Cada item possui a coleção consolidada de itens descendentes e filhos. Neste caso, percorre-se a coleção de itens descendentes marcando-os como "visíveis".

Como a árvore representa os ativos industriais e, neste contexto, a árvore não necessarimente estará balanceada, a complexidade deste algoritmo se aproxima de O(n). 


#### Processamento com Isolates

Para evitar travamentos durante a aplicação de filtros em árvores muito grandes, utilizou-se Isolates para que a operação de filtragem seja processada em uma thread separada, liberando a UI principal e garantindo uma navegação fluida. O uso desta técnica permite que o app mantenha uma performance estável, mesmo em cenários onde a quantidade de ativos é elevada.

#### Construção UI da listagem em árvore com ListView.builder

Para evitar problemas de desempenho, especialmente ao lidar com listas de ativos grandes, ListView.builder foi implementado em todos os níveis da árvore para renderiza-la de forma eficiente. Esse componente carrega apenas os itens visíveis no momento, diferentemente de ListView simples, que renderiza todos os itens de uma vez. Essa abordagem ajuda a manter o uso de memória e o tempo de renderização baixos, proporcionando uma experiência de navegação mais fluida.


## Trabalhos futuros

1. **Autenticação e Controle de Acesso**: Implementar a autenticação do usuário e controle de acesso para limitar quais recursos podem ser visualizados ou editados. Isso seria útil para ambientes com diferentes níveis hierárquicos de segurança e controle.
2. **Notificações em Tempo Real**: Implementar um sistema de notificações para alertar o usuário sobre mudanças críticas nos ativos. Esse recurso poderia ser integrado via push notifications ou WebSocket, garantindo que o usuário sempre receba as informações mais recentes, mesmo estando fora do aplicativo.
3. **Inspecionar ativos**: Possibilitar a visualização dos ativos em mais detalhes, possibilitando agendar manutenções automáticas ou gerar checklists de inspeção. Isso garante que a aplicação não só auxilie no monitoramento, mas também facilite a manutenção preventiva.
4. **Cadastro de serviços**: Possibilitar a criação de serviços para um ativo ou grupo de ativos. Cada serviço pode conter informações como o tipo de manutenção (preventiva, corretiva, preditiva), data de realização, registros fotográficos e outros. Com base no conhecimento da estrutura do ativo, a aplicação permitiria a seleção dos componentes ou materiais necessários para realizar o serviço. Cada material pode ser associado ao seu respectivo código ERP, facilitando o planejamento logístico e a requisição de peças junto ao sistema de inventário. Pode-se também haver a possibilidade de exportar um Relatório Récnico de Serviço, contendo os itens acima mencionados. Neste módulo adicional, pode-se manter um histórico de serviços realizados nos ativos, contento os materiais usados, tempo de execução e os profissionais envolvidos. Esse histórico pode ser utilizado para análise preditiva, ajudando a identificar padrões de falhas e melhorar a previsibilidade de problemas. Além disso tudo, conhecendo a lista de materiais e programação de manutenção dos ativos, a aplicação pode automaticamente gerar e agendar ordens de serviços, economizando tempo e reduzindo riscos de erros e atrasos.  
5. **Melhorias na interface de visualização dos ativos em árvore**: Aprimorar a experiência do usuário ao visualizar a árvore de ativos, com animações suaves ao expandir/fechar níveis da árvore, assim como aperfeiçoar o desempenho ao exibir uma árvore com uma quantidade generosa de ativos.
6. **Mapeamento Geospacial**: Incorporar um mapa geospacial que exiba a localização de cada unidade e seus ativos, permitindo a navegação rápida e possibilitando uma visão a nível macro.
   
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
