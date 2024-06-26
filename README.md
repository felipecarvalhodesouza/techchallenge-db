﻿# Repositório referente a base de dados do TechChallenge - Fase 3

Um dos requisitos da entrega, baseado na disciplina de Engenharia de Dados, era reavaliar a solução de repositório de dados de acordo com os novos conhecimentos, principalmente de banco de dados não relacionais.

De acordo com os estudos, as soluções possíveis seriam:
* Manter o banco de dados relacional (MySQL)
* Utilização de banco de dados NoSQL Documental, como MongoDB
* Utilização de banco de dados NoSQL de chave-valor, como Redis
* Utilização de banco de dados NoSQL colunar, como Cassandra
* Utilização de banco de dados NoSQL de grafos, como Neo4J
* Um conjunto das soluções

Ao analisar *o problema atual*, ainda não vejo necessidade de mudar a solução de repositório de dados.
A lanchonete que utilizará o sistema de pedidos, como descrito no problema, é uma lanchonete de **bairro**.
Isso significa que o número de pedidos e clientes se limitam ao espaço físico das instalações.
Mesmo considerando que a lanchonete está em expansão, é completamente diferente de uma lanchonete como McDonalds, que posui mais de 41 mil restaurantes, e completamente diferente de soluções da internet, como marketplaces.

Dessa forma, acredito que a solução de banco de dados relacional com MySQL é o melhor custo-benecífio para o projeto, **acelerando o time to market**.

A estrutura do banco de dados é extremamente simples, pois se trata de algumas entidades e o relacionamento entre elas.

![UML good_burguer](https://github.com/felipecarvalhodesouza/techchallenge-db/assets/36648569/3dccb41b-3cc9-40a8-bf01-f228e93daf51)

Dificilmente o dado que precisa ser registrado viria em um formato diferente do que já foi modelado (no caso do McDonalds, talvez uma solução documental ajudaria, para facilitar o controle de tantos restaurantes diferentes, espalhados pelo mundo).

A questão de performance, atualmente, não será um problema, pois demorará décadas para que o tamanho do banco de dados torne-se um gargalo, e até lá o próprio sistema já terá sido depreciado por uma solução melhor.

Os únicos requisitos que poderiam ser considerados problemáticos são as *views* de gerenciamento, caso seja necessário trazer todos os dados, porém com a devida indexação, banco relacionais conseguem suportar essa utilização.

Nas atuais soluções de DBaS, como Aurora da AWS, podemos criar replicas de leitura que podem ser escaladas horizontalmente, para diminuir o processamento do banco principal, que foca na inserção de dados.
