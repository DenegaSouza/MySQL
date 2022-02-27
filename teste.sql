create schema teste;
use teste;
create table pessoa(
id int not null auto_increment primary key,
nome varchar(100),
idade int,
cpf varchar(20),
email varchar(100),
rg varchar(20)
);

 insert into pessoa(id, nome, idade, cpf, email, rg)
		      values(5,'Alicio',36,'257.908.470-30','alicio@email.com','33.699.184-8');
insert into pessoa(id, nome, idade, cpf, email, rg)
values(15,	'Vinícius', 17 , '069.314.700-86', 'vinicius@email.com','25.871.997-7');
insert into pessoa(id, nome, idade, cpf, email, rg)
values(10,	'Matias', 20 , '210.623.570-43', 'matias@email.com','35.830.471-4');

