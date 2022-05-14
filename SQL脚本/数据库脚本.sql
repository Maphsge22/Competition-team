# C:\Program Files\MySQL\MySQL Server 8.0\bin
# mysql -uroot -p2053446sx  -Dmysql < C:\Users\59757\Desktop\���ݿ�ű�.sql
create database mycomp;
use mycomp;

create table ѧ��
(
    ����   varchar(10) not null,
    ѧ��   char(10)    primary key,
    ѧԺ���� char(3)    not null,
    �ֻ���  char(11)    not null
);

create table ����
(
    �������   char(5)     primary key,
    ��������   varchar(20) not null,
    �ӳ�ѧ��   char(10)    not null,
    ��������   char(5)     not null,
    ָ����ʦ���� char(10)   not null,
    ����״̬   char(10)    not null
);

create table ���鹹��
(
    ������� char(5)  not null,
    ��Աѧ�� char(10) not null,
    primary key (�������, ��Աѧ��)
);

create table ��������
(
    ������� char(5)  not null,
    ��Աѧ�� char(10) not null,
    primary key (�������, ��Աѧ��)
);


create table ����
(
    �������� char(5) primary key,
    �������� varchar(50) not null,
    ���쵥λ varchar(30),
    ��ʼʱ�� date        not null,
    ����ʱ�� date        not null,
    ��ӹ��� varchar(50) not null
);

create table ָ����ʦ
(
    ����   varchar(10) not null,
    ����   char(10) primary key,
    ѧԺ���� char(3)     not null,
    �ֻ���  char(11)    not null,
    ְ��   varchar(10) not null
);

create table ѧԺ
(
    ѧԺ���� char(3) primary key,
    ѧԺ���� varchar(20) not null
);


create table �û�
(
    �û��� varchar(20) primary key,
    ����  varchar(20) not null,
    ѧ��  char(10),
    ��ɫ  char(1)     not null
);

insert into ѧ�� values
('������','2019210001','001','15600007855'),
('�����','2019210002','001','15600003655'),
('����','2019210003','001','13200006645'),
('��һ��','2019210004','001','18800001254'),
('������','2019210005','001','13300008545'),
('Фս','2019210006','002','15000009845'),
('����ǧ��','2019210007','002','15100005252'),
('����','2019210008','002','18800003508'),
('�ܽ���','2019210009','002','18800009987'),
('�ֿ���','2019210010','002','15600002366'),
('���ٺ�','2019210011','003','15600006624'),
('������','2019210012','003','13200003218'),
('ŷ������','2019210013','003','13200005512'),
('�����Ȱ�','2019210014','003','15600005647'),
('��������','2019210015','003','13200008426'),
('١���','2019210016','004','15600005897'),
('���ӷ�','2019210017','004','15600007451'),
('������','2019210018','004','13200008754'),
('��÷','2019210019','004','13200008740'),
('����','2019210020','004','15600005648'),
('����','2019217890','004','19800003211'),
('kane','2019213890','001','16700008900');


insert into ѧԺ
values ('001', '�����ѧԺ'),
       ('003', '�Զ���ѧԺ'),
       ('002', '����ѧԺ'),
       ('004', '����ѧԺ');


insert into ����
values ('1', '��ҵģ�����', '�����ʵ��ѧ���ù���ѧԺ', '2020-05-14', '2021-01-01', '1-3��'),
       ('2', '����ƻ�', '�����ʵ��ѧҶ���ѧԺ', '2020-09-10', '2021-01-31', '1-5��'),
       ('3', 'Ӣ�ﾺ��', '������', '2020-04-01', '2020-09-01', '1-2��');


insert into ָ����ʦ
values ('���Ͻ�', '1000800001', '001', '13200007454', '����'),
('������','1000800002','001','15600006322','��ʦ'),
('����ǿ','1000800003','002','15600007785','������'),
('�ֳ�Ӣ','1000800004','003','18800006544','������'),
('������','1000800005','004','18800007189','����');


insert into ����
values
    ('1', '��Ů�빤����', '2019210002', '1', '1000800001', '�����'),
    ('2', '�������빤����', '2019210005', '1', '1000800002', '�����'),
    ('3', '����������Ů', '2019210001', '2', '1000800003', '���ͨ��');


insert into ���鹹��
values
    ('1', '2019210002'),
    ('1', '2019210010'),
    ('2', '2019210004'),
    ('2', '2019210005'),
    ('2', '2019210014'),
    ('2', '2019210015'),
    ('3', '2019210001'),
    ('3', '2019210002');

insert into ��������
values
    ('1', '2019213890'),
    ('1', '2019217890'),
    ('2', '2019210020');

alter table ѧ��
    add constraint FK_xs_xydh foreign key (ѧԺ����) references ѧԺ (ѧԺ����) on delete cascade on update cascade;
alter table ����
    add constraint FK_dw_dzxh foreign key (�ӳ�ѧ��) references ѧ�� (ѧ��) on delete cascade on update cascade;
alter table ����
    add constraint FK_dw_jsdh foreign key (��������) references ���� (��������) on delete cascade on update cascade;
alter table ����
    add constraint FK_dw_zdgh foreign key (ָ����ʦ����) references ָ����ʦ (����) on delete cascade on update cascade;
alter table ָ����ʦ
    add constraint FK_zdls_xydh foreign key (ѧԺ����) references ѧԺ (ѧԺ����) on delete cascade on update cascade;
alter table ���鹹��
    add constraint FK_dwgc_dwdh foreign key (�������) references ���� (�������) on delete cascade on update cascade;
alter table ���鹹��
    add constraint FK_dwgc_cyxh foreign key (��Աѧ��) references ѧ�� (ѧ��) on delete cascade on update cascade;


insert into �û�
values ('jrq', '123', '2019210001', '0'),
       ('ksx', '123', '2019210002', '0'),
       ('ly', '123', '2019210003', '1');


