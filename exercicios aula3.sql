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
VALUES (1, 'Zézinho', 2, 1);

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
VALUES (11, 'Leônidas', 3, 3);

select * from pai;
select * from mae;
select * from filho;

/* ----------------------------- 
1 - Mostrar os nomes dos filhos e se possuir mãe, mostrar possui mãe, 
--caso contrário mostrar não tem mãe, se possui pai, mostrar possui pai, 
--caso contrário mostrar não tem pai.
	--Resultado esperado:
	--	Zézinho | Tem mãe 	  | Tem pai
		--Tuca 	| Não tem mãe | Não tem pai*/
		
		
select f.NOME as 'Nome Filho',
case when f.MAE_CODIGO is null then 'Não tem Mãe' else 'Têm Mãe' end as 'Nome Mãe' ,
case when f.PAI_CODIGO is null then 'Não tem Pai' else 'Têm Pai' end as 'Nome Pai'
from filho f;


/* ----------------------------- 
 2 - Mostrar os nomes dos filhos e o nome da mãe. Trazer todos os filhos 
 independente se possui mãe ou não. 
 Se não possuir mãe, mostrar no lugar do nome da mãe, não tem mãe.*/

select f.NOME as 'Nome Filho',
case when f.MAE_CODIGO is null then 'Não tem Mãe' else m.NOME end as 'Nome Mãe'
from filho f
left join mae m on f.MAE_CODIGO = m.CODIGO ;

select * from filho f 
left join mae m on f.MAE_CODIGO = m.CODIGO ;


-- 3 - Mostrar os nomes dos filhos, nome da mãe e nome do pai. Trazer apenas filhos que tenham mãe. 
-- Se não possui pai, mostrar no lugar do nome da pai, não tem pai. 

select f.NOME as 'Nome Filho',
m.NOME as 'Mães',
case when f.PAI_CODIGO is null then 'Não tem Pai' else p.NOME end as 'Nome Pai'
from filho f
inner join mae m on f.MAE_CODIGO = m.CODIGO
left join pai p on f.PAI_CODIGO = p.CODIGO
;

-- 4 - Mostrar a quantidade de filhos que não possuem mãe ou não possuem pai.*/
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

-- 6 - Mostrar o nome do filho e nome da mãe, ordenando pelo nome da mãe.

select f.NOME as 'Nome Filho',
m.NOME as 'Mãe'
from filho f
inner join mae m on f.MAE_CODIGO = m.CODIGO 
order by m.CODIGO desc ;

-- 7- Mostrar o nome dos filhos que tenham a mãe como Gabriela, Juliana (utilizando OR)
select f.nome
from filho f
inner join mae m on f.MAE_CODIGO = m.CODIGO 
where m.NOME = 'Gabriela' or m.NOME = 'Juliana';

-- 8- Mostrar o nome dos filhos que não tenham o pai como Juca, Juliano (utilizando NOT IN)
select f.nome
from filho f
inner join pai p on f.PAI_CODIGO = p.CODIGO 
where p.NOME not in ('Juca','Juliano');

-- exemplo de uso do UPPER e lower 
select upper('silvia'),  lower('SILVIA');


-- 9 - Mostrar os nomes dos pais que possuem mais de 1 filho.
select p.nome as 'Pai',
count(f.CODIGO) as 'Qtd Filhos'
from filho f
inner join pai p on f.PAI_CODIGO = p.CODIGO
group by p.CODIGO
having count(f.CODIGO) > 1;

-- 10 - Mostrar os nomes dos pais e mães que possuem mais de 1 filho.
select p.nome as 'Pai',
m.NOME as 'Mae',
count(f.CODIGO) as 'Qtd Filhos'
from filho f
inner join pai p on f.PAI_CODIGO = p.CODIGO
inner join mae m on f.MAE_CODIGO = m.CODIGO
group by m.NOME, p.NOME 
having count(f.CODIGO) > 1;

-- 11 - Mostrar o nome do pai e da mãe, mostrando a quantidade de filhos que tem juntos, 
-- ordenando a consulta para trazer os que possuem mais filhos juntos.

select p.nome as 'Pai',
m.NOME as 'Mae',
count(f.CODIGO) as 'Qtd Filhos'
from filho f
inner join pai p on f.PAI_CODIGO = p.CODIGO
inner join mae m on f.MAE_CODIGO = m.CODIGO
group by m.NOME, p.NOME
order by count(f.CODIGO) desc ;

-- 12 - Trazer apenas as mães que não tenham filhos
insert into mae (codigo, nome ) values (6, 'Regina');

select m.nome as 'Mae',
count(*) as 'Qtd Filhos'
from mae m 
where not exists (select 1 from filho f where f.MAE_CODIGO = m.CODIGO)
group by m.CODIGO 
;

-- 13 - Trazer os nomes dos pais, e outra coluna com a quantidade de caracteres que o nome do pai possui 
--(Exemplo: SELECT LENGTH('aluno');

select p.nome as 'Pai',
length (p.nome) as 'Qtd Caracateres'
from pai p;

-- 14 - Executar o  abaixo e verificar o resultado. Tente entender o que a função UNION faz:
SELECT FIL.NOME, 'Filho sem pai' AS PAI
FROM FILHO FIL
WHERE FIL.PAI_CODIGO IS null
union
SELECT FIL.NOME, 'Filho com pai' AS PAI
FROM FILHO FIL
WHERE FIL.PAI_CODIGO IS NOT null
ORDER BY PAI;
