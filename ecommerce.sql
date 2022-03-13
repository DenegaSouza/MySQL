-- https://docs.google.com/document/d/1fQMAzlre3OfNhhtX_ODnflC98Y84l85KJtSngkg_u_A/edit --

create schema ecommerce;

use ecommerce;

-- Inicio Criação das Tabelas --
create table cliente(
id int not null auto_increment,
codigo_cliente varchar(10),
nome varchar(100),
raza_social varchar(100),
data_cadastro date,
cnpj varchar(20),
telefone varchar(20),
primary key (id));

create table fornecedor(
id int not null auto_increment,
codigo_fornecedor varchar(10),
nome varchar(100),
razao_social varchar(100),
telefone varchar(20),
primary key(id));

create table vendedor(
id int not null auto_increment,
codigo_Vendedor varchar(10),
nome varchar(100),
razavende varchar(100),
telefone varchar(20),
n_porcvende float(10,2),
primary key(id));

create table produto(
id int not null auto_increment,
codigo_produto varchar(20),
descricao varchar(100),
valor float(10,2),
situacao varchar(1),
id_fornecedor int,
primary key(id));
   
   
create table venda(
id int not null auto_increment,
codigo_venda varchar(10),
id_cliente int not null,
id_fornecedor int not null,
id_vendedor int not null,
valor float(10,2),
desconto float(10,2),
total float(10,2),
data_venda date,
primary key(id));    
   
   
create table item_venda(
id int not null auto_increment,
codigo_item_venda  int not null,
id_produto  int not null,
valor float(10,2),
qtde int,
desconto float(10,2),
primary key(id));    
-- Fim Criação das Tabelas --    

-- Inicio Alteração das Tabelas --
alter table cliente add column cidade varchar(50);

alter table cliente add column estado varchar(50);

alter table cliente drop column estado;

alter table cliente add column estado varchar(50);

alter table cliente modify column  estado int;

alter table cliente modify column estado varchar(100);
-- Fim Alteração das Tabelas --


-- Inicio de exclusão de tabelas --
-- drop table venda;
-- Fim de exclusão de tabelas --



-- Inicio da criação dos index --
alter table produto add index produto_fornecedor_id (id asc);

alter table venda add index venda_clien (id_cliente asc);

alter table venda add index venda_fornecedor_id (id_fornecedor asc);

alter table item_venda add index venda_produto_id (id_produto asc);

-- Fim da criação dos index --


-- Inicio da criação das constraints de chave estrangeira --

alter table venda add constraint fk_venda_cliente
foreign key(id_cliente)
references cliente(id)
on delete no action
on update no action;

alter table venda add constraint fk_venda_vendedor
foreign key(id_vendedor)
references vendedor(id)
on delete no action
on update no action;

alter table venda add constraint fk_venda_fornecedor
foreign key(id_fornecedor )
references fornecedor(id)
on delete no action
on update no action;

alter table item_venda add constraint fk_item_venda_produto
foreign key(id_produto)
references produto (id)
on delete no action
on update no action;

alter table venda drop constraint fk_produto_fornecedor;

alter table produto add constraint fk_produto_fornecedor
foreign key(id_fornecedor)
references fornecedor(id)
on delete no action
on update no action;

--  Fim da criação das constraints --

-- delete from venda
-- where xxx = 'xxx' --

