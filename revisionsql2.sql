drop database if exists devsoft;
create database devsoft;
use devsoft;
drop table if exists informaticien;
create table informaticien(
numinfo int auto_increment primary key,
nominfo varchar(20) not null,		
prenominfo varchar(20) not null,
datenaissinfo date not null,
villeinfo varchar(30) not null,
fonction varchar(30) not null,
Salaire float  not null
);
drop table if exists theme ;
create table theme(
numtheme varchar(20) primary key,
nomtheme varchar(30) not null
);
drop table if exists projet;
create table projet (
codeprojet  varchar(20) primary key,
nomprojet varchar(30) not null,
numtheme varchar(20) ,
foreign key (numtheme) references theme(numtheme),
datedebut date not null,
datefin date not null
);
drop table if exists travaille;
create table travaille (
numinfo int ,
foreign key (numinfo) references informaticien(numinfo),
codeprojet varchar(20) ,
foreign key (codeprojet) references projet(codeprojet),
constraint  primary key (numinfo,codeprojet)
); 
insert into informaticien (nominfo ,prenominfo ,datenaissinfo ,
villeinfo,fonction ,Salaire ) values 
("achach","salma","2003/08/18","tetouan","developpeur",8500),
("benzerga","khadija","1999/12/06","fnideq","developpeur",8000),
("houchi","chaimae","2004/03/06","martil","developpeur",7500),
("ahmadi","ahmad","1998/07/13","tetouan","analyste",9500),
("fatemi","fatema","2002/03/19","agadir","technicien reseau",3500),
("alaoui","ali","2000/03/21","marrakech","infographiste",5500);
insert into theme(numtheme,nomtheme)values("a1","big data"),
("a2","data sciences"),
("a3","intelligence artificiel"),
("a4","iot");
insert into projet(codeprojet  ,nomprojet ,numtheme,datedebut ,datefin)values
("pr1","gestion client","a1","2020/09/22","2021/10/11"),
("pr2","gestion etablissement","a2","2022/01/01","2022/12/31"),
("pr3","gestion banque","a1","2021/11/22","2022/12/19"),
("pr4","gestion marchandises","a3","2020/11/21","2021/09/08");
insert into travaille(numinfo,codeprojet) values 
(1,"pr1"),
(3,"pr2"),
(5,"pr3");
select * from informaticien where villeinfo in ("agadir","marrakech","tetouan");
select * from informaticien order by datenaissinfo desc;
select * from informaticien where salaire between 5000 and 8000;
select * from informaticien where villeinfo ="tetouan" order by fonction desc ,salaire asc ;
select * from informaticien where nominfo like "a%"  and prenominfo like "%m_"  ;
select avg(salaire) from informaticien;
select avg(salaire) from informaticien where fonction="infographiste";
select max(salaire),min(salaire) from informaticien;
select count(*) from informaticien where fonction="developpeur";
select fonction,count(*) from informaticien group by fonction;
select fonction,count(*),avg(salaire) from informaticien group by fonction;
select * from informaticien where salaire> (select avg(salaire) from informaticien);
select fonction,min(salaire),max(salaire) from informaticien group by fonction;
select * from informaticien where fonction="analyste" and salaire>(select avg(salaire) from informaticien);
select nominfo,salaire,fonction from informaticien where salaire> (select salaire from informaticien where nominfo="achach");
select nomprojet,datedebut,datefin,nomtheme from projet,theme where projet.numtheme=theme.numtheme;
select count(*) as nb,nomtheme from projet,theme where projet.numtheme=theme.numtheme group by nomtheme;
select nomprojet from projet,theme where  projet.numtheme=theme.numtheme and nomtheme in ("big data","data sciences") ;
select nominfo,count(t.numinfo) from informaticien i, travaille t where i.numinfo= t.numinfo  group by i.nominfo ;
select p.nomprojet,count(t.codeprojet) from projet p, travaille t where t.codeprojet=p.codeprojet group by p.nomprojet having count(t.codeprojet)>3;
select nominfo,nomprojet from informaticien i , travaille t ,projet p where  i.numinfo=t.numinfo and p.codeprojet=t.codeprojet group by nomprojet;
select sum(salaire) ,nomprojet from informaticien i , travaille t, projet  p where i.numinfo=t.numinfo and p.codeprojet=t.codeprojet and nomprojet="gestion banque";
select sum(salaire) ,nomprojet from informaticien i , travaille t, theme th ,projet p where i.numinfo=t.numinfo and p.codeprojet=t.codeprojet and p.numtheme=th.numtheme and nomtheme="big data";
select * from informaticien where numinfo not in (select  numinfo from travaille); 
select * from informaticien
 where numinfo not in 
 (select distinct  t.numinfo from   informaticien i , travaille t, projet  p 
 where i.numinfo=t.numinfo and p.codeprojet=t.codeprojet
 and p.datedebut="2020/01/01" and p.datefin="2020/05/30");
create view  INFO
as select * from informaticien
 where numinfo not in 
 (select distinct  t.numinfo from   informaticien i , travaille t, projet  p 
 where i.numinfo=t.numinfo and p.codeprojet=t.codeprojet
 and p.datedebut="2020/01/01" and p.datefin="2020/05/30");
 select * from INFO