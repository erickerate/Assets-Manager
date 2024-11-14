# Assets-Manager
Implementação de uma aplicação mobile para gestão de ativos industriais utilizando Flutter.

## Visão geral do aplicativo

Abaixo você encontra screenshots das principais telas do aplicativo.

#### Aplicação (v.14.11.2024)
![Aplicação](https://github.com/erickerate/Assets-Manager/blob/main/assets/app-overview.png)

## Algoritmos de Construção e Filtragem da Árvore

#### Construção da Árvore 

Para construir a árvore de forma eficiente, utilizou-se uma estrutura de dados Mapa baseada em pares chave/valor, permitindo uma construção direta da árvore ao associar cada ativo da lista a um nó específico por meio de um par id -> TreeItem. Cada item armazena referências diretas tanto aos seus filhos de primeiro nível quanto a seus ascendentes até a raiz da árvore. Isso permite o acesso rápido a qualquer nó da estrutura, sem a necessidade de iterações repetidas, além de facilitar o acesso direto aos filhos e ascendentes de cada item, otimizando as operações de construção e filtragem da árvore. Esse algoritmo pode ser chamado de **Algoritmo de Construção de árvore hierárquica com mapeamento direto baseada em hash e compressão de caminhos**, sendo definido como a seguir: 

1. **Inicialização dos Nós e do Mapa**: Crie um Mapa dos itens, onde cada chave representa o id do item e o valor é o item correspondente (TreeItem). Para cada ativo na lista, instancie um TreeItem e adicione-o ao mapa, utilizando o id do item como chave.
2. **Construção da Hierarquia da Árvore**: Para cada item, casso possua um pai, obtenha-o diretamente através do mapa e adicione o item à coleção de filhos desse pai. Se o item não tiver pai, adicione-o à coleção de raízes da árvore.
3. **Consolidação dos Ascendentes**: Caminhando da raiz até as extremidades da árvore, defina a coleção de ascendentes de cada item como sendo a coleção de ascendentes do item pai, acrescida do próprio item.

Sendo assim, se há n itens para processar, e cada operação é feita em tempo constante O(1), a **complexidade assintótica geral da construção da árvore será O(n)**. 



#### Filtragem da Árvore

Para aplicar os filtros, foi adotada uma abordagem que exibe os itens que atendem aos critérios dos filtros, juntamente com seus elementos ascendentes até a raiz, de modo a exibir toda a hierarquia dos itens. O algoritmo de filtragem é implementado da seguinte forma:

1. **Definição dos itens que atendem aos filtros**: Aplique os filtros para obter apenas os itens correspondentes. Defina cada item desta coleção como visível.
2. **Tornando visível os ascendentes**: Para cada item que atender aos filtros, percorra a coleção dos ascendentes marcando-os como visíveis.

Como o acesso aos itens e seus ascendentes é feita de forma direta, **a complexidade assintótica deste algoritmo aproxima-se de O(n)**.


#### Processamento de filtros com Isolates

Para evitar travamentos durante a aplicação de filtros em árvores muito grandes, utilizou-se Isolates para que a operação de filtragem seja processada em uma thread separada, liberando a UI principal e garantindo uma navegação fluida. O uso desta técnica permite que o app mantenha uma performance estável, mesmo em cenários onde a quantidade de ativos é elevada.

#### Virtualização da listagem de ativos com ListView.builder

Para evitar problemas de desempenho, especialmente com listas extensas de ativos, o ListView.builder foi implementado em todos os níveis da árvore para renderiza-la de forma virtual. Esse componente carrega apenas os itens visíveis no momento, diferentemente de uma ListView simples, que renderiza todos os itens de uma vez. Essa abordagem aumenta a eficiência da aplicação mantendo o uso de memória e o tempo de renderização baixos, proporcionando uma experiência de navegação mais fluida.


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
