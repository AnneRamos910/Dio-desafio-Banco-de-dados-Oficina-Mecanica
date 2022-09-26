-- Banco de dados 
use oficina_mecanica;

-- tabela clientes
create table clientes(
idCliente int primary key,
Nome varchar(20) not null,
Endereco varchar(255) not null, 
Contato char(12) not null, 
CNH varchar(30),
constraint fk_cliente_veiculos foreign key(idCliente) references ordem_de_servicos (idOrdemdeServicos)
);

-- tabela ordem de seviços
create table OrdemdeServicos(
idOrdemdeServicos int primary key,
Data_de_emissao date,
numero_de_identificacao int not null, 
Valor int not null, 
Status_ordem enum('encaminhado','em processamento','entregue') default 'em processamento',
DatadeEntrega date,
revisão varchar(45) not null
);

-- tabela pagamento
create table formadePagamento (
idFormadePagamento int primary key, 
tipo_de_pagamento Enum('pix','cartao','boleto') default 'pix',
limite_disponivel float,
constraint fk_formadePagamento_clientes foreign key(idFormadePagamento) references clientes(idcliente)
);

-- tabela veiculos 
create table veiculos (
idVeiculos int primary key,
modelo varchar(45) not null, 
cor varchar(45) not null, 
Ano year not null,
Documentacao enum('em dia','atrasado') default 'em dia',
placa varchar(8)
);

-- tabela mecanico
create table mecanico (
idMecanico int primary key, 
nome varchar (45) not null, 
Endereco varchar(45) not null, 
Especialidade varchar(45),
constraint fk_mecanico_equipe foreign key(idMecanico) references equipe(idEquipe)
);

-- tabela equipe 
create table equipe(
idEquipe int primary key, 
numero_de_funcionarios int,
especializacao varchar(45), 
constraint fk_equipe_ordemdeServicos foreign key(idEquipe) references ordemdeServicos(idOrdemdeServicos)
);

-- tabela peças 
create table pecas(
idPecas int primary key, 
nome varchar(45) not null, 
Marca varchar(45) not null, 
Descricao varchar(45) not null, 
constraint fk_pecas_estoque foreign key(idPecas) references estoque(idEstoque)
);

-- tabela estoque 
create table estoque (
 idEstoque int primary key, 
 Quantidade_min int, 
 Quantidade_max int,
 Endereco varchar(255) not null
);


-- tabela ordem de servicos_peças
create table OrdemdeServicos_pecas (
idPecas int, 
idOrdemdeServicos int, 
Quantidade int not null, 
primary key (idPecas, idOrdemdeServicos),
constraint fk_ordemdeServicos_pecas_pecas foreign key(idPecas) references pecas (idPecas),
constraint fk_ordemdeServicos_pecas_ordemdeServicos foreign key(idOrdemdeServicos) references pecas (idOrdemdeServicos)
);

-- tabela mao de obra
create table mao_de_obra (
idVeiculos int, 
idMecanico int,
valor int not null, 
primary key(idVeiculos, idMecanico),
constraint fk_mecanico_veiculos_veiculos foreign key(idVeiculos) references veiculos (idVeiculos),
constraint fk_mecanico_veiculos_mecanico foreign key(idMecanico) references mecanico (idMecanico)
);

-- table clientes que autoriza a ordem de serviços.
create table clientes_autoriza_ordemdeServicos (
idCliente int, 
idOrdemdeServicos int, 
primary key(idCliente, idOrdemdeServicos),
constraint fk_cliente_veiculos_cliente foreign key(idCliente) references clientes (idCliente),
constraint fk_cliente_ordemdeServicos_ordemdeServicos foreign key(idOrdemdeServicos) references ordemdeservicos (idOrdemdeServicos)
);