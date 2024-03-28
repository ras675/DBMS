create user C_210041255 indentified by cse4308;
grant all priviledges to C_210041255;
connect C_210041255;


create product_info
(
	P_ID varchar2(5) not null,
	Model varchar2(20) not null,
	Manufacturer varchar(20) not null,
	Price int,
	constraint key_id primary key(P_ID),
);

insert into product_info values('10203','X515EA','ASUS','51900');
insert into product_info values('20301' ,'Latitude 14 3420','DELL','82500');
insert into product_info values('20311' ,'Inspiron 15 3525','DELL','58900');
insert into product_info values( '20114' ,'P2451FA','ASUS','58500');
insert into product_info values( '20122' ,'X415EA','ASUS','57000');
insert into product_info values( '30301' ,'Vostro 14 3400','DELL','83000');
insert into product_info values( '00788','15s-eq3619AU','HP','73200');
insert into product_info values( '30583','P1412CEA','ASUS','63000');
insert into product_info values( '3054'3,'15s-fq5486TU','HP','58500');
insert into product_info values( '10766','IdeaPad Slim 3i','Lenovo','56900');
insert into product_info values( '00821','K14','Lenovo','66500');
insert into product_info values( '30345','SModern 15 B11M','MSI','74000');

select * from product_info;
select Model , Manufacturer from product_info;
select Model , Manufacturer from product_info where price < 70000;
select Model , Manufacturer from product_info where price < 75000 and
select P_ID, Model from product_info where Manufacturer = 'ASUS';
select Model,price from product_info where Manufacturer ='DELL';
select P_ID, Model from product_info where Manufacturer price > 55000 and Manufacturer
select Manufacturer from product_info;


DROP TABLE product_info CASCADE CONSTRAINTS;

