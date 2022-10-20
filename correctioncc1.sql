drop database if exists controle1;
create database controle1;
use controle1;
drop table if exists division;

create table division(
		iddivision int auto_increment primary key,
		nomdivision varchar (25));

drop table if exists service;
create table service(
		idservice int auto_increment primary key,
        nomservice varchar (25),
        id_division int,
        foreign key (id_division) REFERENCES division(iddivision) );

drop table if exists employe;
create table employe(
		mle int auto_increment primary key,
        nom varchar(25),prenom varchar(25),
        datere date,salire int ,
        id_service int,foreign key (id_service) references service(idservice));

drop table if exists projet ;
create table projet(idprojet int auto_increment primary key,
					titre_pr varchar (25));

drop table if exists tache;
create table tache(idtache int auto_increment primary key,
					descriptiontache varchar (25),
                    idprojet int,
                    foreign key (idprojet) REFERENCES projet(idprojet) );

drop table if exists realise;
create table realise(idrealise int auto_increment primary key,
					mle int,
                    idtache int,
                    datedb date,
                    datef date,
foreign key (mle) REFERENCES employe(mle),
foreign key (idtache) REFERENCES tache(idtache) 
 );
 insert into division(nomdivision) values('Informatique'),
('Marketing'),('Finanace'),('Comptabilite'),('RH'),('Production');

insert into service(nomservice,id_division) values('developpement front-end',1),
('developpement back-end',1)
,('Vente',2),('stratgie vente',2),
('loi finanace',3),('stratgie finanace',3),
('stratgie Comptabilite',4),('plan Comptabilite',4),
('stratgie RH',5),('plan RH',5),
('stratgie Production',6),('plan Production',6);

insert into employe(nom,prenom,datere,salire,id_service) values("ahmadi","ahmed","2012-03-28",5000,1),
("aymani","ayman","2015-11-02",15000,1),("nassimi","nasim","2019-01-15",4500,1),
("hamazoui","hamza","2001-02-18",20000,2),
("monsify","monseif","2011-11-11",4000,2),("badri","bader","2020-03-12",17000,2),
("hachmi","hachem","2015-07-13",6000,3),
("isammi","isam","2021-01-30",10000,3),("mataoui","matai","2018-05-25",8500,3),
("makaoui","meki","2005-06-25",7500,4),
("rozi","ayman","2013-08-16",6930,4),("rozi","imad","2016-04-12",3000,4),
("makaoui","meki","2006-04-17",4800,5),
("rozi","ayman","2018-09-21",11000,5),("rozi","imad","2019-07-03",5645,5),
("redoni","redone","2014-12-31",8789,6),
("anouari","anouar","2017-02-26",3800,6),("brahimi","barhim","2020-10-17",10000,6),
("jilali","jalal","2022-01-19",3049,7),
("salmi","salem","2010-09-30",12357,7),("soulmi","soulem","2013-02-18",5900,7),
("redoui","reda","2016-09-19",8973,8),
("achrafi","achraf","2003-03-30",9018,8),("yassini","yassin","2006-09-12",14000,8),
("adnani","adnan","2018-08-29",7000,9),
("wadiai","wadia","2007-03-08",6190,9),("fouadi","fouad","2017-05-17",13500,9),
("oussami","ousama","2021-06-19",4548,10),
("alaoui","ali","2009-03-08",10568,10),("soulaimani","souliman","2014-05-17",7602,10),
("tourki","tourk","2002-06-19",6101,11),
("younoussi","youness","2011-03-08",6450,11),("ayoubi","ayoub","2018-05-17",9859,11),
("tahaoui","taha","2014-06-19",4548,12),
("roumani","rouman","2005-03-08",70976,12),("toufahi","toufh","2009-05-17",6095,12);

insert into projet(titre_pr) values('Projet Informatique'),
('Projet Marketing'),('Projet Finanace'),('Projet Comptabilite'),
('Projet RH'),('Projet Production');

insert into tache(descriptiontache,idprojet) values('tache Informatique 1',1),
('tache Informatique 2',1),('tache Marketing 1',2),
('tache Marketing 2',2),
('tache Finanace 1',3),
('tache Finanace 2',3),('tache Comptabilite 1',4),
('tache Comptabilite 2',4),
('tache RH 1',5),
('tache RH 2',5),('tache Production 1',6),
('tache Production 2',6)
;

insert into realise(mle,idtache,datedb,datef) values(1,1,"2009-05-17","2011-05-17");
 -- q1
 drop view if exists employes3;
 create view  employes3 as 
 select mle ,nom ,prenom ,idservice ,iddivision from employe e , service s , division d
 where e.id_service=s.idservice and s.id_division=d.iddivision and s.id_division=3; 
 select * from employes3;
 -- q2
 drop view if exists q2;
create view q2 as 
select nom,prenom ,count(r.idtache) as counter,e.mle  from employe e , realise r , tache t 
where e.mle=r.mle and r.idtache=t.idtache  group by e.mle;
select * from q2