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
   login_ip             char(15) comment '登陆的ip',
   primary key (id)
);

alter table admin comment '管理员';

/*==============================================================*/
/* Table: collect                                               */
/*==============================================================*/
create table collect
(
   news_id              int not null comment '消息id',
   id                   char(12) comment '工号或者学号',
   user_id              char(12) comment '收藏者的id'
);

/*==============================================================*/
/* Table: comment                                               */
/*==============================================================*/
create table comment
(
   id                   int not null auto_increment comment '主键',
   news_id              int not null comment '消息的id',
   author_id            char(12) not null comment '评论人的id',
   author_name          varchar(12) not null comment '评论人的名字',
   reply_id             int not null comment '被回复的人的id',
   reply_name           varchar(8) not null comment '被回复的人的姓名    如果这是一条评论  该字段为空  如果是对B对A 评论的回复， 该字段记录的是A的名字',
   content              varchar(30) not null comment '内容',
   post_time            datetime not null,
   primary key (id)
);

alter table comment comment '评论表 (评论    对评论的回复  放到一张表)';

/*==============================================================*/
/* Table: follw                                                 */
/*==============================================================*/
create table follw
(
   follow_id            char(12) not null comment ' 被关注人的id',
   followme_id          char(12) not null comment '追随者 粉丝id'
);

alter table follw comment '关注表';

/*==============================================================*/
/* Table: news                                                  */
/*==============================================================*/
create table news
(
   id                   int not null auto_increment comment '主键',
   author_id            char(12) not null comment '作者的id',
   author_name          varchar(12) not null comment '作者 名字 ',
   title                varchar(20) not null comment '标题',
   content              varchar(200) not null comment '详情',
   post_time            datetime not null comment '时间',
   isdraft              bool not null comment '是否是草稿  true 代表草稿',
   comment_num          int comment '跟帖数',
   primary key (id)
);

alter table news comment '消息(把名字存里里面，牺牲空间换取时间)';

/*==============================================================*/
/* Table: news_pic                                              */
/*==============================================================*/
create table news_pic
(
   pic_url              varchar(50) not null comment '图片地址',
   news_id              int not null comment '消息的id',
   primary key (pic_url)
);

/*==============================================================*/
/* Table: notic_pic                                             */
/*==============================================================*/
create table notic_pic
(
   pic_url              varchar(50) not null comment '图片地址',
   notice_id            int not null comment '通知的id',
   primary key (pic_url)
);

/*==============================================================*/
/* Table: notice                                                */
/*==============================================================*/
create table notice
(
   id                   int not null comment '主键',
   author_name          varchar(12) not null comment '作者 （这个不是管理员的名字     而是委托人的名字）',
   admin_id             int not null comment '哪个  管理员发的（可能有多个）',
   title                varchar(20) not null comment '标题',
   content              varchar(500) not null comment '内容',
   post_time            datetime not null comment '日期',
   primary key (id)
);

alter table notice comment '通知';

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   id                   char(12) not null comment '工号或者学号',
   name                 varchar(12) not null comment '姓名',
   password             char(32) not null comment '密码(md5  加密后32位)',
   eamil                char(20) comment '邮箱',
   follow_num           int not null default 0 comment '关注的人数',
   followme_num         int not null default 0 comment '粉丝人数',
   intro                char(30) not null comment '简介',
   head_url             varchar(50) not null comment '图像url',
   status               smallint not null comment 'status表示是          辅导员还是公众号还是学生     0表示辅导员 1表示学生 2表示公众号',
   news_num             int not null default 0 comment '发的消息次数',
   new_reply            int not null default 0 comment '收到的新回复条数',
   primary key (id)
);

alter table user comment '辅导员 或者公众号或学生';

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

