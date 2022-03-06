--workbench

create schema exercicio;

use exercicio;

CREATE TABLE PAI(
    CODIGO int NOT NULL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL
);

CREATE TABLE MAE(
    CODIGO int NOT NULL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL
);

CREATE TABLE FILHO(
    CODIGO int NOT NULL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    PAI_CODIGO int,
    MAE_CODIGO int,
    FOREIGN KEY (PAI_CODIGO) REFERENCES PAI (CODIGO),
    FOREIGN KEY (MAE_CODIGO) REFERENCES MAE (CODIGO)
);

INSERT INTO MAE (CODIGO, NOME)
VALUES (1, 'Maria');

INSERT INTO MAE (CODIGO, NOME)
VALUES (2, 'Joana');

INSERT INTO MAE (CODIGO, NOME)
VALUES (3, 'Gabriela');

INSERT INTO MAE (CODIGO, NOME)
VALUES (4, 'Juliana');

INSERT INTO MAE (CODIGO, NOME)
VALUES (5, 'Marina');

INSERT INTO PAI (CODIGO, NOME)
VALUES (1, 'Alfredo');

INSERT INTO PAI (CODIGO, NOME)
VALUES (2, 'Joaquim');

INSERT INTO PAI (CODIGO, NOME)
VALUES (3, 'Juca');

INSERT INTO PAI (CODIGO, NOME)
VALUES (4, 'Juliano');

INSERT INTO PAI (CODIGO, NOME)
VALUES (5, 'Moacir');

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (1, 'Z�zinho', 2, 1);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (2, 'Tuca', null, 1);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (3, 'Jucelino', 3, 1);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (4, 'Marcelo', 4, 3);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (5, 'Chiquinha', 1, 4);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (6, 'Margarida', null, null);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (7, 'Rosa', 5, 5);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (8, 'Murilo', 1, 4);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (9, 'Rodrigo', 2, 2);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (10, 'Gustavo', 1, 2);

INSERT INTO FILHO (CODIGO, NOME, PAI_CODIGO, MAE_CODIGO)
VALUES (11, 'Le�nidas', 3, 3);

select * from pai;
select * from mae;
select * from filho;

select f.NOME as 'Nome Filho',
case when f.MAE_CODIGO is null then 'N�o tem M�e' else 'T�m M�e' end as 'Nome M�e' ,
case when f.PAI_CODIGO is null then 'N�o tem Pai' else 'T�m Pai' end as 'Nome Pai'
from filho f;


/* ----------------------------- 
 2 - Mostrar os nomes dos filhos e o nome da m�e. Trazer todos os filhos 
 independente se possui m�e ou n�o. 
 Se n�o possuir m�e, mostrar no lugar do nome da m�e, n�o tem m�e.*/

select f.NOME as 'Nome Filho',
case when f.MAE_CODIGO is null then 'N�o tem M�e' else m.NOME end as 'Nome M�e'
from filho f
left join mae m on f.MAE_CODIGO = m.CODIGO ;

select * from filho f 
left join mae m on f.MAE_CODIGO = m.CODIGO ;


-- 3 - Mostrar os nomes dos filhos, nome da m�e e nome do pai. Trazer apenas filhos que tenham m�e. 
-- Se n�o possui pai, mostrar no lugar do nome da pai, n�o tem pai. 

select f.NOME as 'Nome Filho',
m.NOME as 'M�es',
case when f.PAI_CODIGO is null then 'N�o tem Pai' else p.NOME end as 'Nome Pai'
from filho f
inner join mae m on f.MAE_CODIGO = m.CODIGO
left join pai p on f.PAI_CODIGO = p.CODIGO
;

/*4 - Mostrar a quantidade de filhos que n�o possuem m�e ou n�o possuem pai.*/
select count(*)
from filho f
where f.MAE_CODIGO is null or f.PAI_CODIGO is null
;

-- 5 - Mostrar o nome do pai e a quantidade de filhos que o pai possui. 

select p.nome as 'Pai',
count(*) as 'Qtd Filhos'
from filho f
inner join pai p on f.PAI_CODIGO = p.CODIGO
group by p.CODIGO 
;

-- 6 - Mostrar o nome do filho e nome da m�e, ordenando pelo nome da m�e.

select f.NOME as 'Nome Filho',
m.NOME as 'M�e'
from filho f
inner join mae m on f.MAE_CODIGO = m.CODIGO 
order by m.CODIGO desc ;
