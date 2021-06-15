use Ecommerce

--Consultar de tabelas
select * from Clientes
select * from Produtos
select * from Pedido
select * from PedidoItem
select * from Status
select * from StatusPedidoItem
select * from PedidoItemLog



insert PedidoItemLog (CodigoPedido, CodigoProduto, CodigoStatusPedidoItem, DataMovimento)
select CodigoPedido, CodigoProduto, 1, GETDATE()
from PedidoItem

/* Inner join, Left join, right join

select *
from Clientes cli
Inner join Pedido ped
on cli.Codigo = ped.Codigo

select *
from Clientes cli
Left join Pedido ped
on cli.Codigo = ped.Codigo

select *
from Pedido ped
--Right join Clientes cli
on cli.Codigo = ped.Codigo
*/

/*Condicionais com Inner, left, right
select *
from Pedido ped
Left join Clientes cli
on cli.Codigo = ped.Codigo
where ped.TotalPedido > 10*/

select * 
from Clientes cli
inner join Pedido ped
on cli.Codigo = ped.CodigoCliente 

select cli.Nome, 
	ped.TotalPedido,
	case
	when cli.Pessoa = 'F' then 'Fisica'
	else 'Juridica'
	end TipoPessoa
from Clientes cli
Left join Pedido ped
on cli.Codigo = ped.Codigo

select * 
from PedidoItem t1
inner join PedidoItemLog t2
on t1.CodigoPedido = t2.CodigoPedido
and t1.CodigoProduto = t2.CodigoProduto
inner join StatusPedidoItem t3 
on t3.Codigo = t2.CodigoStatusPedidoItem
where Preco between 1 and 2

-- Função soma dos itens 

select sum(Preco * Quantidade) 
from PedidoItem t1
inner join PedidoItemLog t2
on t1.CodigoPedido = t2.CodigoPedido
and t1.CodigoProduto = t2.CodigoProduto
inner join StatusPedidoItem t3 
on t3.Codigo = t2.CodigoStatusPedidoItem
where Preco between 1 and 2

--Preço médio dos itens 
select avg(Preco * Quantidade) 
from PedidoItem t1
inner join PedidoItemLog t2
on t1.CodigoPedido = t2.CodigoPedido
and t1.CodigoProduto = t2.CodigoProduto
inner join StatusPedidoItem t3 
on t3.Codigo = t2.CodigoStatusPedidoItem
where Preco between 1 and 2

--Descrição de produtos
select	t4.Codigo,
		t4.Descricao,
		sum(t1.Preco * t1.Quantidade) somatoria
from PedidoItem t1
inner join PedidoItemLog t2
on t1.CodigoPedido = t2.CodigoPedido
and t1.CodigoProduto = t2.CodigoProduto
inner join StatusPedidoItem t3 
on t3.Codigo = t2.CodigoStatusPedidoItem
inner join Produtos t4  
on t4.Codigo = t2.CodigoProduto

--Agragação 
 group by	t4.Codigo,
			t4.Descricao
 order by	somatoria desc

-- Se eu quiser filtra pelo resultado final que a função vai nos retornar utilizar o having

--Descrição de produtos
select	t4.Codigo,
		t4.Descricao,
		sum(t1.Preco * t1.Quantidade) somatoria
from PedidoItem t1
inner join PedidoItemLog t2
on t1.CodigoPedido = t2.CodigoPedido
and t1.CodigoProduto = t2.CodigoProduto
inner join StatusPedidoItem t3 
on t3.Codigo = t2.CodigoStatusPedidoItem
inner join Produtos t4  
on t4.Codigo = t2.CodigoProduto

--Agragação 
 group by	t4.Codigo,
			t4.Descricao
having sum (t1.Preco * t1.Quantidade) > 10

-- Agrupar por cliente 
insert Pedido values(1, GETDATE(), 1, 10,10, 1 , 1)

select * 
from Clientes cli
left join Pedido ped
on cli.Codigo = ped.CodigoCliente 

select cli.Codigo,
cli.Nome,
count(ped.codigo)
from Clientes cli
left join Pedido ped
on cli.Codigo = ped.CodigoCliente 
group by cli.Codigo,
cli.nome



-- Clientes que possui pedido
select * 
from Clientes cli
left join Pedido ped 
on cli.Codigo = ped.Codigo
where ped.Codigo is not null  


--Clientes que não possui pedido
select * 
from Clientes cli
left join Pedido ped 
on cli.Codigo = ped.Codigo
where ped.Codigo is null  

--Foreng key 
alter table PedidoItem add constraint fk_pedido foreign key (CodigoPedido) references Pedido (Codigo)

-- Chave primária/primary key
alter table Status add constraint pk_Codigostatus primary key (Condigo)
alter table Clientes  add constraint pk_cliente primary key (Codigo) 
alter table Pedido add constraint pk_pedido primary key (Codigo)
alter table Produtos add constraint pk_produto primary key (Codigo)
alter table PedidoItem add constraint pk_codigopedido primary key (CodigoPedido)
alter table PedidoItem add constraint pk_codigoproduto primary key (CodigoProduto)
 

--Estrutura de descisão
select *,
	case 
		when Pessoa = 'J' then 'Juridica'
		when Pessoa = 'F' then 'Fisica'
		else 'Pessoa Indefinida'
	end + Convert(varchar, GETDATE(), 103)
from Clientes

-- Função, caso a coluna for null me retorne o valor atual.
select isnull(DataCriacao, GETDATE()), *
from Clientes


-- Inserindo colunas 
alter table Pedido add CodigoStatus int
alter table Pedido add DecStatus varchar(50)

--Inserindo dados na tabela pedido
insert Pedido values(1,GETDATE(), 0, 22.40, 7)
insert Pedido values(GETDATE(), 0, 2.0, 5)
insert PedidoItem values(1,1,1.5,1)
insert PedidoItem values(2,1,1.5,1)
insert PedidoItem values(2,1,20.99,2)

--Inserindo dados na tabela Produto
insert Produtos values (1, 'Caneta', 'Caneta Azul', 1.5)
insert Produtos values (1,'Caderno', 'Caderno 10 Matérias', 20.99)


--Inserindo dados na tabela cliente
insert  Clientes (Codigo, Nome, Pessoa, DataCriacao) values (1, 'Allan', 'F', GETDATE());
insert  Clientes (Codigo, Nome, Pessoa, DataCriacao) values (2, 'João', 'F',  GETDATE());
insert  Clientes (Codigo, Nome, Pessoa, DataCriacao) values (3, 'Lucas', 'F', GETDATE());
insert  Clientes (Codigo, Nome, Pessoa, DataCriacao) values (4, 'Claudio','J',GETDATE());
insert  Clientes (Codigo, Nome, Pessoa, DataCriacao) values (5, 'Dayana','F', GETDATE());
insert  Clientes (Codigo, Nome, Pessoa, DataCriacao) values (6, 'Luiz','J', GETDATE());
insert  Clientes (Codigo, Nome, Pessoa, DataCriacao) values (7, 'Caique','f', GETDATE());
insert  Clientes (Codigo, Nome, Pessoa, DataCriacao) values (9, 'Fabio','f', GETDATE());
insert  Clientes (Codigo, Nome, Pessoa, DataCriacao) values (8, 'Elizeu','f', GETDATE());


--Delete/ Quero excluir todos registros cujo o cogigo seja 5,4,3,2
delete
from Pedido
where Codigo in(2)

-- Os clientes que atende minha condição vão me retornar um ou 2 registros ou mais
select * 
from Clientes
where Codigo = 7
OR Nome = 'J'

-- Os clientes que estão como pessoa J vão mudar o nome para José
select Codigo, Nome 
from Clientes
where pessoa = 'J'

--  Criação de tabelas 

create table Pedido
(
	Codigo int not null
	,DataSolicitacao DateTime not null 
	,FlagPago bit not null
	,TotalPedido float not null
	,CodigoCliente int not null
)

create table PedidoItem
(
	CodigoPedido int not null
	,CodigoProduto int not null
	,Preco float not null
	,Quantidade int not null
)


create table Clientes
(
Codigo int not null
, Nome varchar(200) not null
,Pessoa char(1) not null
,DataCriacao DateTime not null
)

create table Produtos
(
Codigo int not null
,Nome varchar(100) not null
,Descricao varchar(200) not null
,Preco float not null
) 

create table Status
(
	Condigo int not null
,	Descricao varchar(50) not null 
)

--Criar o banco de dados
--create database Ecommerce 
--use Ecommerce Incdicca que devemos utilizar esse banco de dados

-- Criar tabelas 
--create table Teste(
--Desricao varchar(50) null
--, Complemento char(10) not null)

--Apagar uma tabela 
--drop database Ecommerce

--Inserir dados 
--insert Teste values ('a','b') Inserir dados 

--Consulta dados
--select * from Teste Consultar dados
