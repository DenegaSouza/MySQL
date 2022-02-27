create schema escola;

use escola;

 create table pessoa(
	id int not null auto_increment primary key,
    nome varchar(100),
    idade int,
    cpf varchar(20),
    email varchar(100),
    rg varchar(20)
 );

create table aluno(
	id int not null auto_increment primary key,
    matricula int,
    turma varchar(50),
    curso varchar(50),
    id_pessoa int
);


ALTER TABLE aluno ADD FOREIGN KEY (id_pessoa) REFERENCES pessoa(ID);

create table curso(
	id int not null auto_increment primary key,
	nome varchar(100) not null 
);

create table turno(
	id int not null auto_increment primary key,
	descricao varchar(100) not null  
);

create table turma(
	id int not null auto_increment primary key,
	descricao  varchar(100),
	professor  varchar(100),
	periodo  varchar(100),
	id_turno int ,
	id_curso int ,
	FOREIGN KEY (id_turno) REFERENCES turno(id),
	FOREIGN KEY (id_curso) references curso(id)
);
alter table turma add column id_aluno int not null;
ALTER TABLE turma ADD FOREIGN KEY (id_aluno) REFERENCES aluno(id);

insert into curso (nome) values ('html5');
insert into curso (nome) values ('Mysql');

insert into turno (descricao) values ('manha');
insert into turno (descricao) values ('tarde');
insert into turno (descricao) values ('noite');

--inserir pessoa, depois aluno, depois turma

insert into pessoa (nome,idade,cpf,email,rg)
values('everton',36,06146657956,'everton@teste.com',4880),
('Aluno 2',18,06157985135,'aluno2@teste.com',1587),
('Aluno 3',25,03514785265,'aluno3@teste.com',8514),
('Aluno 4',41,05478421589,'aluno4@teste.com',9862),
('Aluno 5',33,03748156985,'aluno5@teste.com',2458);

select * from aluno;


alter table aluno drop column curso;
alter table aluno drop column turma;

insert into aluno(matricula,id_pessoa)
values(100,1);

insert into aluno (matricula,id_pessoa)
values(110,2);

insert into aluno (matricula,id_pessoa)
values(120,3);

insert into aluno (matricula,id_pessoa)
values(130,4);

insert into aluno (matricula,id_pessoa)
values(140,1,5);

select * from pessoa;
select * from turma;
select * from turno;
select * from curso;
select * from aluno;
select * from turma;

insert into turma(descricao, professor, periodo, id_turno, id_curso, id_aluno)
values ('A1','Prof.','Domingos',1,1,9);

insert into turma(descricao, professor, periodo, id_turno, id_curso, id_aluno)
values ('S1','Prof.','Sabados',2,2,10);

insert into turma(descricao, professor, periodo, id_turno, id_curso, id_aluno)
values ('S1','Prof.','Sabados',2,1,11);

SELECT Orders.OrderID, Customers.CustomerName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

select t.descricao as 'Turma', 
t.professor as 'Nome Prof', 
tr.descricao as Turno , 
c.nome as 'Curso' , 
p.nome as 'Aluno'
from turma t
inner join turno tr on t.id_turno = tr.id 
inner join curso c ON t.id_curso = c.id 
inner join aluno a on t.id_aluno = a.id
inner join pessoa p on a.id_pessoa = p.id 


