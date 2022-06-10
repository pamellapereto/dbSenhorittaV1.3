/* OBSERVAÇÃO:
Professor, caso esteja vendo este script para corrigi-lo, acabei de terminá-lo em casa e amanhã (sexta-feira, dia 09/06) irei para o SENAC
e gerarei sua engenharia reversa (Diagrama Entidade Relacionamento) e documentação*/

/*
	Database - Loja Senhoritta
    @author Pamella Pereto
    @version 1.3
*/

create database dbSenhoritta;

show databases;

use dbSenhoritta;

-- Unique (não permitir valores duplicados)
create table usuarios(
	idusu int primary key auto_increment,
    usuario varchar(50) not null,
    login varchar(15) not null unique,
    senha varchar(50) not null,
    perfil varchar(10) not null
);

describe usuarios;

-- Para inserir uma senha com criptografia usa-se md5()
insert into usuarios(usuario,login,senha,perfil)
values('Administrador','admin',md5('admin'),'admin');
insert into usuarios(usuario,login,senha,perfil)
values('Pamella Pereto','pamellapereto',md5('123456'),'user');

select * from usuarios;

-- Acessando o sistema pela tela de login
-- and (função lógica onde todas as condições devem ser verdadeiras)
select * from usuarios where login='admin' and senha=md5('admin');

create table fornecedores(
idfor int primary key auto_increment,
cnpj varchar(18) not null unique,
ie varchar(18) unique,
im varchar(18) unique,
razao varchar(100) not null,
fantasia varchar(100) not null,
site varchar(60),
fone varchar(20) not null,
contato varchar(20),
email varchar(50),
cep varchar(9) not null,
endereco varchar(60) not null,
numero varchar(10) not null,
complemento varchar(50),
bairro varchar(50) not null,
cidade varchar(50) not null,
uf char(2) not null,
obs varchar(255)
);

describe fornecedores;

insert into  fornecedores (cnpj,razao,fantasia,fone,cep,endereco,numero,bairro,cidade,uf)
values ('99.152.736/0001-33','Roberta Campos','Estilo Confecções','(11) 92621-6085','03728-000','Rua São José do Campestre','390','Jardim Danfer','São Paulo','SP');

insert into  fornecedores (cnpj,razao,fantasia,fone,cep,endereco,numero,bairro,cidade,uf)
values ('22.245.615/0001-23','José de Assis','Altamoda','(11) 97854-1243','03348-000','Rua Miguel Leão','190','Vila Silvia','São Paulo','SP');

select * from fornecedores;

create table produtos(
	codigo int primary key auto_increment,
    barcode varchar(45),
    produto varchar(60) not null,
    descricao varchar(100) not null,
    fabricante varchar(100) not null,
    datacad timestamp default current_timestamp,
    estoque int not null,
    estoquemin int not null,
    unidade varchar(30) not null,
    localizacao varchar(100),
    custo decimal(10,2) not null,
    lucro decimal(10,2) not null,
    idfor int not null,
	foreign key (idfor) references fornecedores (idfor)
    );
    
describe produtos;
    
insert into produtos (barcode,produto,descricao,fabricante,estoque,estoquemin,unidade,localizacao,custo,lucro,idfor)
values ('1111111111','blusa','verde','Estilo Confecções',20,5,'UN','Setor Blusas',59.90,65,1);

insert into produtos (barcode,produto,descricao,fabricante,estoque,estoquemin,unidade,localizacao,custo,lucro,idfor)
values ('2222222222','vestido','amarelo','Estilo Confecções',14,9,'UN','Setor Vestidos',39.90,50,1);

insert into produtos (barcode,produto,descricao,fabricante,estoque,estoquemin,unidade,localizacao,custo,lucro,idfor)
values ('3333333333','cropped','azul','Estilo Confecções',19,13,'UN','Setor Blusas',99.90,100,1);

insert into produtos (barcode,produto,descricao,fabricante,estoque,estoquemin,unidade,localizacao,custo,lucro,idfor)
values ('4444444444','calça','branca','Altamoda',7,10,'UN','Setor Calças',33.90,100,2);

insert into produtos (barcode,produto,descricao,fabricante,estoque,estoquemin,unidade,localizacao,custo,lucro,idfor)
values ('5555555555','vestido','listrado','Altamoda',9,12,'UN','Setor Vestidos',49.90,70,2);
    
select * from produtos;

-- Obter o preço de venda de cada produto
select codigo as código, produto, custo,
(custo + ((custo * lucro)/100)) as venda
from produtos;

-- Inventário de estoque (patrimônio)
-- sum() ➙ função de soma no banco de dados
select sum(estoque * custo) as total from produtos;

-- Relatório de reposição de estoque 1
select * from produtos where estoque < estoquemin;

-- Relatório de reposição de estoque 2
select codigo, produto, fabricante,
estoque, estoquemin as estoque_mínimo, custo, lucro
from produtos where estoque < estoquemin;

create table clientes (
 idcli int primary key auto_increment,
 nome varchar (100) not null,
 fone varchar(20) not null,
 cpf varchar(14) unique,
email varchar(50),
marketing char(1) not null,
cep varchar(9),
endereco varchar(60),
bairro varchar(50),
numero varchar(10),
complemento varchar(50),
cidade varchar(50),
uf char(2)
);

alter table clientes add column nascimento date after cpf;

describe clientes;

insert into clientes (nome, fone, cpf, nascimento, email, marketing)
values ('Pamella Pereto', '1196455-6220', '383.036.508-07', 19970714, 'pamellapereto@gmail.com', 's');

insert into clientes (nome, fone, cpf, nascimento, email, marketing)
values ('Henrique Neto', '1196182-4236', '377.314.998-04', 19911004, 'henriquens4@gmail.com', 's');

insert into clientes (nome, fone, email, marketing)
values ('Pedro Pereira', '2194292-7163', 'pedropereira@gmail.com', 's');

insert into clientes (nome, fone, marketing)
values ('Roberto Macedo', '2191237-3765', 'n');

insert into clientes (nome, fone, marketing, cep, endereco, bairro, numero, complemento, cidade, uf)
values ('Rosangela Aparecida', '1194123-7766', 'n', '03728-000', 'Rua São José do Campestre', 'Jardim Danfer', '390', 'Casa 2', 'São Paulo', 'SP');

insert into clientes (nome, fone, marketing, cep, endereco, bairro, numero, cidade, uf)
values ('Ana Dutra', '1193695-2312', 'n', '03324-100', 'Rua Miguel Leão', 'Vila Silvia', '150', 'São Paulo', 'SP');

select * from clientes;

update clientes set fone = '1197231-5819' where idcli=6;

-- Relatório personalizado de clientes 1 (focando em contato)
select nome, fone as contato, email
from clientes;

-- Relatório personalizado de clientes 2 (focando em aniversário)
select nome,
date_format(nascimento, '%d/%m/%Y') as data_nascimento
from clientes;

-- Relatório personalizado de clientes 3 (focando em e-mail marketing)
select nome, email from clientes where marketing = 's';


-- foreign key(FK): chave estrangeira que cria o relacionamento
-- FK(pedidos)______________PK(clientes)
-- Observação: Usar o mesmo nome e tipo de dados nas chaves (PK e FK)

create table pedidos (
pedido int primary key auto_increment,
dataped timestamp default current_timestamp,
total decimal(10,2),
idcli int not null,
foreign key (idcli) references clientes(idcli)
);

-- Abertura de pedidos
insert into pedidos (idcli) values(3);

insert into pedidos (idcli) values(4);

-- Verificar pedidos
select * from pedidos where pedido = 1;

select * from pedidos where pedido = 2;

-- Verificar pedidos junto com o nome do cliente
-- inner join (unir informações de 2 ou mais tabelas)
-- IMPORTANTE! Indicar as chaves FK e PK
select * from pedidos inner join clientes
on pedidos.idcli = clientes.idcli;

-- Verificar pedidos junto com o nome do cliente (relatório simplificado)
-- %H:%i ➙ exibir também o horario formatado
select
pedidos.pedido,
date_format(pedidos.dataped, '%d%m%Y - %H:%i') as data_ped,
clientes.nome as cliente,
clientes.fone as contato
from pedidos inner join clientes
on pedidos.idcli = clientes.idcli;


-- ====== Linha de tabela de carrinho ======
-- Tabela de apoio para criar um relacionamento de tipo M-M
-- (Muitos para Muitos), neste caso não cria-se a chave primária


create table carrinho (
	pedido int not null,
    codigo int not null,
    quantidade int not null,
    foreign key(pedido) references pedidos(pedido),
    foreign key(codigo) references produtos(codigo)
);

insert into carrinho values (1,1,3);
insert into carrinho values (1,2,1);
insert into carrinho values (1,3,2);

insert into carrinho values (2,1,2);
insert into carrinho values (2,2,1);
insert into carrinho values (2,3,4);


select * from carrinho;

-- Exibir o carrinho
select pedidos.pedido,
carrinho.codigo as código,
produtos.produto,
carrinho.quantidade,
(produtos.custo + ((produtos.custo * produtos.lucro)/100)) as venda,
((produtos.custo + ((produtos.custo * produtos.lucro)/100)) * carrinho.quantidade)  as subtotal
from (carrinho inner join pedidos on carrinho.pedido = pedidos.pedido)
inner join produtos on carrinho.codigo = produtos.codigo;

-- Total do pedido (encontrado em carrinho) ➙ Fechamento
select sum((produtos.custo + ((produtos.custo * produtos.lucro)/100)) * carrinho.quantidade) as total
from carrinho inner join produtos on carrinho.codigo = produtos.codigo;

-- Atualização do estoque
update carrinho
inner join produtos
on carrinho.codigo = produtos.codigo
set produtos.estoque = produtos.estoque - carrinho.quantidade
where carrinho.quantidade > 0;
