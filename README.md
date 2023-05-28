
# PSET - Trabalho de Banco de Dados

**Professor**: Abrantes Araújo Silva Filho  
**Aluno**: Lucas Xavier
**Matrícula**: 202307196
**Email**: lucassxxavier@gmail.com

## Descrição do Projeto

O objetivo deste projeto é criar um banco de dados simulando uma loja. O sistema de banco de dados permitirá o gerenciamento de produtos, clientes, pedidos e fornecedores.

## Modelo Conceitual

A seguir, apresentamos o modelo conceitual do banco de dados:

## Tabela: produtos

-   produto_id (NUMERIC(38) NOT NULL)
-   nome (VARCHAR(255) NOT NULL)
-   preco_unitario (NUMERIC(10, 2))
-   detalhes (BYTEA)
-   imagem (BYTEA)
-   imagem_mime_type (VARCHAR(512))
-   imagem_arquivo (VARCHAR(512))
-   imagem_charset (VARCHAR(512))
-   imagem_ultima_atualizacao (DATE)

## Tabela: lojas

-   loja_id (NUMERIC(38) NOT NULL)
-   nome (VARCHAR(255) NOT NULL)
-   endereco_web (VARCHAR(100))
-   endereco_fisico (VARCHAR(512))
-   latitude (NUMERIC)
-   longitude (NUMERIC)
-   logo (BYTEA)
-   logo_mime_type (VARCHAR(512))
-   logo_arquivo (VARCHAR(512))
-   logo_charset (VARCHAR(512))
-   logo_ultima_atualizacao (DATE)

## Tabela: clientes

-   cliente_id (NUMERIC(38) NOT NULL)
-   email (VARCHAR(255) NOT NULL)
-   nome (VARCHAR(255) NOT NULL)
-   telefone1 (VARCHAR(20))
-   telefone2 (VARCHAR(20))
-   telefone3 (VARCHAR(20))

## Tabela: estoques

-   estoque_id (NUMERIC(38) NOT NULL)
-   loja_id (NUMERIC(38) NOT NULL)
-   produto_id (NUMERIC(38) NOT NULL)
-   quantidade (NUMERIC(38) NOT NULL)

## Tabela: envios

-   envio_id (NUMERIC(38) NOT NULL)
-   status (VARCHAR(15) NOT NULL)
-   loja_id (NUMERIC(38) NOT NULL)
-   cliente_id (NUMERIC(38) NOT NULL)
-   endereco_entrega (VARCHAR(512) NOT NULL)

## Tabela: pedidos

-   pedido_id (NUMERIC(38) NOT NULL)
-   data_hora (TIMESTAMP NOT NULL)
-   cliente_id (NUMERIC(38) NOT NULL)
-   status (VARCHAR(15) NOT NULL)
-   loja_id (NUMERIC(38) NOT NULL)

## Tabela: pedidos_itens

-   produto_id (NUMERIC(38) NOT NULL)
-   pedido_id (NUMERIC(38) NOT NULL)
-   quantidade (NUMERIC(38) NOT NULL)
-   numero_da_linha (NUMERIC(38) NOT NULL)
-   preco_unitario (NUMERIC(10, 2) NOT NULL)
-   envio_id (NUMERIC(38) NOT NULL)

## Conclusão

Este projeto permitiu a criação de um banco de dados simulando uma loja, proporcionando a capacidade de gerenciar produtos, clientes, pedidos e fornecedores. O modelo conceitual apresentado e o script SQL fornecido estabelecem uma base sólida para a implementação do sistema de banco de dados. Com essa estrutura, será possível realizar operações como inserção, consulta, atualização e exclusão de dados, atendendo às necessidades do negócio da loja.

Foi uma experiência valiosa desenvolver esse projeto, aplicando conceitos e práticas de banco de dados.
