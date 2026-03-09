# Proposta do Projeto Integrador — Grupo B

## Nome do Aplicativo

**QuickShop** — Catalogo e pedidos online

## Problema que Resolve

Pequenos comerciantes locais nao possuem uma plataforma simples para expor
seus produtos e receber pedidos pelo celular. Clientes precisam entrar em
contato por WhatsApp ou telefone, sem rastreamento do status do pedido.
O QuickShop resolve isso com um app Flutter que conecta lojistas e clientes
de forma direta, com catalogo digital e acompanhamento de pedidos em tempo real.

## Publico-Alvo

- Lojistas de pequeno porte (mercadinhos, lojas de roupas, livrarias locais)
- Clientes que preferem comprar pelo celular com entrega ou retirada na loja

## Funcionalidades Principais

1. Cadastro e autenticacao de usuarios (cliente e lojista)
2. Catalogo de produtos com categorias, fotos e preco
3. Carrinho de compras e criacao de pedidos
4. Acompanhamento de status do pedido (pendente, confirmado, preparando, entregue)
5. Historico de pedidos por usuario
6. Painel do lojista para gerenciar produtos e pedidos

## Recursos Tecnicos

- Autenticacao via AWS Cognito
- API REST hospedada na AWS (Lambda + API Gateway)
- Armazenamento de imagens no S3
- Banco de dados DynamoDB
- Notificacoes de status via polling

## Estrutura de Features

| Feature        | Descricao                                          |
|----------------|----------------------------------------------------|
| autenticacao   | Login, cadastro e gerenciamento de sessao          |
| catalogo       | Listagem, busca e detalhes de produtos             |
| pedidos        | Criacao, acompanhamento e historico de pedidos     |
