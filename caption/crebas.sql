/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2014/7/20 23:03:07                           */
/*==============================================================*/


drop table if exists admin;

drop table if exists collect;

drop table if exists comment;

drop table if exists follw;

drop table if exists news;

drop table if exists news_pic;

drop table if exists notic_pic;

drop table if exists notice;

drop table if exists user;

/*==============================================================*/
/* Table: admin                                                 */
/*==============================================================*/
create table admin
(
   id                   int not null auto_increment,
   name                 char(8) not null,
   password             char(32) not null,
   email                char(20),
   login_ip             char(15) comment '��½��ip',
   primary key (id)
);

alter table admin comment '����Ա';

/*==============================================================*/
/* Table: collect                                               */
/*==============================================================*/
create table collect
(
   news_id              int not null comment '��Ϣid',
   id                   char(12) comment '���Ż���ѧ��',
   user_id              char(12) comment '�ղ��ߵ�id'
);

/*==============================================================*/
/* Table: comment                                               */
/*==============================================================*/
create table comment
(
   id                   int not null auto_increment comment '����',
   news_id              int not null comment '��Ϣ��id',
   author_id            char(12) not null comment '�����˵�id',
   author_name          varchar(12) not null comment '�����˵�����',
   reply_id             int not null comment '���ظ����˵�id',
   reply_name           varchar(8) not null comment '���ظ����˵�����    �������һ������  ���ֶ�Ϊ��  ����Ƕ�B��A ���۵Ļظ��� ���ֶμ�¼����A������',
   content              varchar(30) not null comment '����',
   post_time            datetime not null,
   primary key (id)
);

alter table comment comment '���۱� (����    �����۵Ļظ�  �ŵ�һ�ű�)';

/*==============================================================*/
/* Table: follw                                                 */
/*==============================================================*/
create table follw
(
   follow_id            char(12) not null comment ' ����ע�˵�id',
   followme_id          char(12) not null comment '׷���� ��˿id'
);

alter table follw comment '��ע��';

/*==============================================================*/
/* Table: news                                                  */
/*==============================================================*/
create table news
(
   id                   int not null auto_increment comment '����',
   author_id            char(12) not null comment '���ߵ�id',
   author_name          varchar(12) not null comment '���� ���� ',
   title                varchar(20) not null comment '����',
   content              varchar(200) not null comment '����',
   post_time            datetime not null comment 'ʱ��',
   isdraft              bool not null comment '�Ƿ��ǲݸ�  true ����ݸ�',
   comment_num          int comment '������',
   primary key (id)
);

alter table news comment '��Ϣ(�����ִ������棬�����ռ任ȡʱ��)';

/*==============================================================*/
/* Table: news_pic                                              */
/*==============================================================*/
create table news_pic
(
   pic_url              varchar(50) not null comment 'ͼƬ��ַ',
   news_id              int not null comment '��Ϣ��id',
   primary key (pic_url)
);

/*==============================================================*/
/* Table: notic_pic                                             */
/*==============================================================*/
create table notic_pic
(
   pic_url              varchar(50) not null comment 'ͼƬ��ַ',
   notice_id            int not null comment '֪ͨ��id',
   primary key (pic_url)
);

/*==============================================================*/
/* Table: notice                                                */
/*==============================================================*/
create table notice
(
   id                   int not null comment '����',
   author_name          varchar(12) not null comment '���� ��������ǹ���Ա������     ����ί���˵����֣�',
   admin_id             int not null comment '�ĸ�  ����Ա���ģ������ж����',
   title                varchar(20) not null comment '����',
   content              varchar(500) not null comment '����',
   post_time            datetime not null comment '����',
   primary key (id)
);

alter table notice comment '֪ͨ';

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   id                   char(12) not null comment '���Ż���ѧ��',
   name                 varchar(12) not null comment '����',
   password             char(32) not null comment '����(md5  ���ܺ�32λ)',
   eamil                char(20) comment '����',
   follow_num           int not null default 0 comment '��ע������',
   followme_num         int not null default 0 comment '��˿����',
   intro                char(30) not null comment '���',
   head_url             varchar(50) not null comment 'ͼ��url',
   status               smallint not null comment 'status��ʾ��          ����Ա���ǹ��ںŻ���ѧ��     0��ʾ����Ա 1��ʾѧ�� 2��ʾ���ں�',
   news_num             int not null default 0 comment '������Ϣ����',
   new_reply            int not null default 0 comment '�յ����»ظ�����',
   primary key (id)
);

alter table user comment '����Ա ���߹��ںŻ�ѧ��';

alter table collect add constraint FK_news_be_collectt foreign key (news_id)
      references news (id) on delete cascade;

alter table collect add constraint FK_user_has_collectt foreign key (id)
      references user (id) on delete cascade;

alter table comment add constraint FK_news_include_comment foreign key (news_id)
      references news (id) on delete cascade;

alter table comment add constraint FK_user_has_comment foreign key (author_id)
      references user (id) on delete restrict on update restrict;

alter table follw add constraint FK_user_follew_user foreign key (follow_id)
      references user (id) on delete cascade;

alter table news add constraint FK_user_send_news foreign key (author_id)
      references user (id) on delete cascade;

alter table news_pic add constraint FK_news_include_news_pic foreign key (news_id)
      references news (id) on delete cascade;

alter table notic_pic add constraint FK_notice_include_notice_pic foreign key (notice_id)
      references notice (id) on delete cascade;

alter table notice add constraint FK_admin_send_notice foreign key (admin_id)
      references admin (id) on delete restrict;

