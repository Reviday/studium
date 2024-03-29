drop sequence FBOARD_SEQ;
drop sequence TA_SIDEMENU_SEQ;
drop sequence STM_LIKE_SEQ;
drop sequence STMADANG_CMT_SEQ;
drop sequence FMADANG_CMT_SEQ;
drop sequence SMADANG_SEQ;
drop sequence MLL_SEQ;
drop sequence SMADANG_CMT_SEQ;
drop sequence STMADANG_QUESTION_SEQ;
drop sequence BMADANG_SEQ;
drop sequence STMADANG_SEQ;
drop sequence BMADANG_CMT_SEQ;
drop sequence MEM_SEQ;
drop sequence FMADANG_SEQ;
drop table TA_MEMBER_LOGIN_LOG;
drop table TA_SIDEMENU_ELEMENTS;
drop table TA_STMADANG_CMT;
drop table TA_FMADANG_CMT;
drop table TA_FREE_MADANG;
drop table TA_STUDY_MADANG_QUESTION;
drop table TA_STUDY_MADANG;
drop table TA_STMADANG_LIKE;
drop table TA_FMADANG_REP;
drop table TA_SMADANG_REP;
drop table TA_BOAST_MADANG CASCADE CONSTRAINT;
drop table TA_SHARE_MADANG;
drop table TA_BMADANG_CMT;
drop table TA_SMADANG_CMT;
drop table TA_MEMBER;


select *
from (select case when object_type = 'VIEW' then 'view'
         when object_type = 'PROCEDURE' then 'procedure'
         when object_type = 'PROCEDURE' then 'function'
         when object_type = 'SEQUENCE' then 'sequence'
         when object_type = 'TYPE' then 'type'
         when object_type = 'TABLE' then 'table'
       end AS object_group
      , case when object_type = 'VIEW' then 'drop view '||object_name||';'
          when object_type = 'PROCEDURE' then 'drop procedure '||object_name||';'
          when object_type = 'PROCEDURE' then 'drop function '||object_name||';'
          when object_type = 'SEQUENCE' then 'drop sequence '||object_name||';'
          when object_type = 'TYPE' then 'drop type '||object_name||';'
          when object_type = 'TABLE' then 'drop table '||object_name||';'
       end AS object_drop_sql
   from user_objects
   order by decode(object_type, 'VIEW', 0, 
                  'PROCEDURE', 1, 
                  'FUNCTION', 2, 
                  'SEQUENCE', 3,
                  'TYPE', 4,
                  'TABLE', 5)
)
where object_drop_sql is not null;


-- 날짜 포맷형식을 다음으로 바꾼다. ex) 2019.01.01 13:00:00
-- 아래를 적용하지 않으면 Studium 프로젝트에서 사용되는 날짜 포맷형식을 사용할 수 없다.
alter session set nls_date_format = 'YYYY.MM.DD HH24:MI:SS'; 

/*해당 정보는 멤버 테이블에 필요한 정보들 */
create table ta_member ( -- 회원정보 테이블(비고: 必은 첫 회원가입시 반드시 입력받을 정보)
    mem_no number constraint mem_no_pk primary key, -- 회원넘버(시퀀스넘버로 부여)
--  mem_userid varchar2(20) constraint mem_userid_nn not null constraint mem_userid_uq unique, -- 회원 ID(必) 
    mem_email varchar2(30) not null, -- 회원 이메일(추가정보 or 첫 가입시)
    mem_password varchar2(300) constraint mem_password_nn not null , -- 회원 psssword(必)
    mem_name varchar2(50) constraint mem_name_nn not null, -- 회원 이름(必)
    mem_code char(1) constraint mem_code_ck check (mem_code in ('M','T','R','A')), -- 회원등급(Manager, Teacher, Regular, Associate)
    mem_birth date, -- 회원 생년월일(必)
    mem_phone varchar2(11), -- 회원 전화번호(없을 경우 집전화/ '-' 없이 입력받는다.),
    mem_gender char(1) default 'U' constraint mem_gender_ck check (mem_gender in ('M','F','U')), -- 회원 성별(必)(U-Undefined)
    mem_point number default 0, -- 회원 포인트
    mem_category1 varchar2(30), -- 회원 선호 카테고리(최대 3개)
    mem_category2 varchar2(30), 
    mem_category3 varchar2(30), 
    
    -- 집주소 입력 API 사용시, 2~3개 // 없으면 1개만 
    mem_zipcode varchar2(10), -- 우편번호 (자릿수가 가물해서 10)
    mem_address1 varchar2(100), -- 회원 주소 앞부분
    mem_address2 varchar2(100), -- 회원 상세주소
    -----------------------------
    
    -- 이하는 부가정보
    mem_receive_email char(1) default 'N' constraint mem_receive_email_ck check (mem_receive_email in ('Y','N')), -- 이메일 수신여부(기본값 N)
    mem_use_note char(1) default 'N' constraint mem_use_note_ck check (mem_use_note in ('Y','N')), -- 쪽지 사용여부(기본값 N)
    mem_receive_sms char(1) default 'N' constraint mem_receive_sms_ck check (mem_receive_sms in ('Y','N')), -- 문자 수신 여부(기본값 N)
    mem_open_profile char(1) default 'N' constraint mem_open_profile_ck check (mem_open_profile in ('Y','N')), -- 프로필 공개 여부(기본값 N)
    mem_denied char(1) default 'N' constraint mem_denied_ck check (mem_denied in ('Y','N','P')), -- 해당 회원 차단 여부(기본값 N/ 영구정지 P) 
    mem_email_cert char(1) default 'N' constraint mem_email_cert_ck check (mem_email_cert in ('Y','N')), -- 이메일 인증 여부(기본값 N)
    mem_enroll_datetime date , -- 회원 가입일(시간 포함)
    mem_enroll_ip varchar2(20), -- 회원 가입 ip(ip 받아오는게 가능하면 넣을까 싶음)
    mem_lastlogin_datetime date , -- 마지막 접속일 
    mem_lastlogin_ip varchar2(20), -- 마지막 접속 ip
    mem_profile_content varchar2(300), -- 자기소개(프로필용, 100자)
    mem_adminmemo varchar2(1000),   -- 회원에 대한 관리자용 메모
--  mem_following number default 0, -- 친구수
--  mem_followed number default 0, -- 회원을 친구로 등록한 회원 수 => 이건 따로 테이블 만들어서 하는게 좋을듯 하다.
    mem_icon varchar2(1000), -- 회원 아이콘 경로(댓글 사용할때 이미지 정도?, 경로를 어느 정도 범위로 주어야할지 몰라서 1000)
    mem_photo varchar2(1000), -- 회원 프로필 사진 경로
    mem_status char(1) default 'Y' constraint mem_status_ck check (mem_status in ('Y','N')), -- 회원 계정 상태
    mem_withdrawal_date date default null, -- 회원 탈퇴 일시
    mem_denied_date date default null -- 회원 차단 일시
);

/* 회원넘버용 시퀀스 */
create sequence mem_seq 
start with 10000
increment by 1
maxvalue 999999;

insert into ta_member values(mem_seq.NEXTVAL,'admin@studium.com','x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==','관리자','M','1990/01/01','','M',99999999,'','','','','','',default,default,default,default,default,'Y',sysdate,'',sysdate,'','','','','studium_logo.png',default,default,default);
insert into ta_member values(mem_seq.NEXTVAL, 'asd@naver.com', 'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==', '아무개','A','','',default, 0,null,null,null,'','','',default,default,default,default,default,'Y',sysdate,'',sysdate,'','','','','',default,default,default);


/*
테이블이름 (tb_board)
1. 고유번호(b_idx) : 자동증가로 만들어 지는 회원의 고유번호
2. 글순서번호(b_num) : 글 순서를 표시하기 위한 번호
3. 답글순서및 단계(b_reply) : 답글들의 순서 및 단계를 위한 문자, 3단계까지 가능하게 함, (A-Z)까지 26개까지 답글 가능
4. 글쓴이 아이디(m_id) : 글쓴이의 아이디를 기록합니다.
5. 글쓴이 이름(m_name) : 글쓴이의 이름을 기록합니다.
6. 글제제목(b_title) : 글제목입니다.(255자까지 가능)
7. 글내용(b_contents)
8. 작성일시(b_regdate)

*/

/*
- 게시판(공부마당(문제내는게시판), 공유마당(포크), 자유마당(자유게시판))

  게시물 번호(primary key), 카테고리, 제목, 내용, 작성자, 조회수, 

  작성날짜, (추천), 댓글내용, 삭제여부
*/


/* 게시글용 테이블*/
/*
 답글 있는 게시판 형식으로? 
 게시판마다 한 개씩 테이블을 부여?
 
 Q) 게시글에 이미지를 삽입할 경우, 어떻게 처리해야하는지?
*/

-- 공부마당
create table ta_study_madang(
    madang_no number constraint stmadang_no_pk primary key, -- 글번호
    madang_writer_uid number, -- 글쓴이 uid
    madang_writer_email varchar2(20), -- 글쓴이 이메일
    madang_writer_name varchar2(20), -- 글쓴이 이름(이름으로 표기)
    madang_title varchar2(100) constraint stmadang_title_nn not null, -- 글 제목
    madang_level number, -- 문제 난이도(Level 1~5)
    madang_content clob constraint stmadang_content_nn not null, -- 글 내용
    madang_main_category varchar2(100), -- 대분류(관리자 고정)
    madang_category varchar2(100), -- 중분류(관리자 고정)
    madang_sub_category varchar2(100), -- 소분류(사용자 지정)
    madang_register_datetime date, -- 글 작성 일시
    madang_register_ip varchar2(20), -- 글 작성 ip 주소
    madang_updated_datetime date default null, -- 글 수정 일시
    madang_updated_ip varchar2(20), -- 글 수정 ip 주소
    madang_rec_count number default 0, -- 글 추천 수(recommand)
    madang_rep_count number default 0, -- 글 댓글 수
    madang_read_count number default 0, -- 조회수
    madang_fork_count number default 0, -- 글 포크 수
    madang_answer_count number default 0, -- 글 답변(풀이) 수 
    madang_status char(1) default 'Y' constraint stmadang_status_ck check(madang_status in ('Y','N')) -- 삭제 여부
);

-- 공부마당
create sequence stmadang_seq 
start with 1
increment by 1
maxvalue 999999;

insert into ta_study_madang values(stmadang_seq.nextval, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.1', 1, '테스트 글 입니다.1',
    '프로그래밍', '고급언어','java',sysdate, null, default, null, default, default, default, default,  default, default);
insert into ta_study_madang values(stmadang_seq.nextval, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.1', 1, '테스트 글 입니다.<br>테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.테스트 글 입니다.',
    '프로그래밍', '고급언어','java',sysdate, null, default, null, default, default, default, default,  default, default);
insert into ta_study_madang values(stmadang_seq.nextval, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.2', 1, '테스트 글 입니다.2',
    '프로그래밍', '고급언어','java',sysdate, null, default, null, default, default, default, default,  1, default);
select * from ta_study_madang;
commit;

drop table ta_study_madang_question;
select * from ta_study_madang_question;
-- 공부마당 풀이
create table ta_study_madang_question(
    question_no number primary key,-- 시퀀스 pk
    madang_no number references ta_study_madang(madang_no), -- 해당 글번호
    question_writer_uid number, -- 글쓴이 uid
    question_writer_email varchar2(20), -- 글쓴이 이메일
    question_writer_name varchar2(20), -- 글쓴이 이름(이름으로 표기)
    question_content clob, -- 글 내용
    question_main_category varchar2(100), -- 대분류(관리자 고정) => 통계용
    question_category varchar2(100), -- 중분류(관리자 고정)
    question_sub_category varchar2(100), -- 소분류(사용자 지정)
    question_register_datetime date, -- 글 작성 일시
    question_register_ip varchar2(20), -- 글 작성 ip 주소
    question_updated_datetime date default null, -- 글 수정 일시
    question_updated_ip varchar2(20), -- 글 수정 ip 주소
    question_rec_count number default 0, -- 글 추천 수(recommand)
    question_rep_count number default 0, -- 글 댓글 수
    question_status char(1) default 'Y' check(question_status in ('Y','N')) -- 삭제 여부
);

-- 공부마당 풀이 시퀀스

create sequence stmadang_question_seq 
start with 1
increment by 1
maxvalue 999999;



-- 공유마당
create table ta_share_madang(
    madang_no number constraint smadang_no_pk primary key, -- 글번호
    madang_parent number default null, -- 답글을 달았을 시, 원글의 글번호를 저장
    madang_order number default 0, -- 답글이 달렸을 시, 해당 게시글의 순서를 정해주기 위한 순서번호
    madang_writer_uid number, -- 글쓴이 uid
    madang_writer_email varchar2(20), -- 글쓴이 이메일
    madang_writer_name varchar2(20), -- 글쓴이 이름(이름으로 표기)
    madang_title varchar2(100) constraint smadang_title_nn not null, -- 글 제목
    madang_content clob constraint smadang_content_nn not null, -- 글 내용
    madang_register_datetime date, -- 글 작성 일시
    madang_register_ip varchar2(20), -- 글 작성 ip 주소
    madang_updated_datetime date default null, -- 글 수정 일시
    madang_updated_ip varchar2(20), -- 글 수정 ip 주소
    madang_rec_count number default 0, -- 글 추천 수(recommand)
    madang_rep_count number default 0, -- 글 댓글 수
    madang_read_count number default 0, -- 조회수
    madang_fork_count number default 0, -- 글 포크 수    
    madang_file_presence char(1) default 'N' constraint smadang_file_presence_ck check(madang_file_presence in ('Y','N')), -- 파일이 있는지 없는지(List화면에서 표시용으로 사용)
    madang_img_presence char(1) default 'N' constraint smadang_img_presence_ck check(madang_img_presence in ('Y','N')), -- 이미지가 있는지 없는지(List화면에서 표시용으로 사용)
    madang_status char(1) default 'Y' constraint smadang_status_ck check(madang_status in ('Y','N')) -- 삭제 여부
);

-- 공유마당
create sequence smadang_seq 
start with 1
increment by 1
maxvalue 999999;


-- 자유마당
create table ta_free_madang(
    madang_no number constraint fmadang_no_pk primary key, -- 글번호
    madang_parent number default null, -- 답글을 달았을 시, 원글의 글번호를 저장
    madang_order number default 0, -- 답글이 달렸을 시, 해당 게시글의 순서를 정해주기 위한 순서번호
    madang_writer_uid number, -- 글쓴이 uid
    madang_writer_email varchar2(20), -- 글쓴이 이메일
    madang_writer_name varchar2(20), -- 글쓴이 이름(이름으로 표기)
    madang_title varchar2(100) constraint fmadang_title_nn not null, -- 글 제목
    madang_content clob constraint fmadang_content_nn not null, -- 글 내용
    madang_register_datetime date, -- 글 작성 일시
    madang_register_ip varchar2(20), -- 글 작성 ip 주소
    madang_updated_datetime date default null, -- 글 수정 일시
    madang_updated_ip varchar2(20), -- 글 수정 ip 주소
    madang_rec_count number default 0, -- 글 추천 수(recommand)
    madang_rep_count number default 0, -- 글 댓글 수
    madang_read_count number default 0, -- 조회수
    madang_file_presence char(1) default 'N' constraint fmadang_file_presence_ck check(madang_file_presence in ('Y','N')), -- 파일이 있는지 없는지(List화면에서 표시용으로 사용)
    madang_img_presence char(1) default 'N' constraint fmadang_img_presence_ck check(madang_img_presence in ('Y','N')), -- 이미지가 있는지 없는지(List화면에서 표시용으로 사용)
    madang_status char(1) default 'Y' constraint fmadang_status_ck check(madang_status in ('Y','N')) -- 삭제 여부
);

-- 자유마당
create sequence fmadang_seq 
start with 1
increment by 1
maxvalue 999999;

-- 자랑마당
create table ta_boast_madang(
    madang_no number constraint bmadang_no_pk primary key, -- 글번호
    madang_parent number default null, -- 답글을 달았을 시, 원글의 글번호를 저장
    madang_order number default 0, -- 답글이 달렸을 시, 해당 게시글의 순서를 정해주기 위한 순서번호
    madang_writer_uid number, -- 글쓴이 uid
    madang_writer_email varchar2(20), -- 글쓴이 이메일
    madang_writer_name varchar2(20), -- 글쓴이 이름(이름으로 표기)
    madang_title varchar2(100) constraint bmadang_title_nn not null, -- 글 제목
    madang_content clob constraint bmadang_content_nn not null, -- 글 내용
    madang_register_datetime date, -- 글 작성 일시
    madang_register_ip varchar2(20), -- 글 작성 ip 주소
    madang_updated_datetime date default null, -- 글 수정 일시
    madang_updated_ip varchar2(20), -- 글 수정 ip 주소
    madang_rec_count number default 0, -- 글 추천 수(recommand)
    madang_rep_count number default 0, -- 글 댓글 수
    madang_read_count number default 0, -- 조회수
    madang_file_presence char(1) default 'N' constraint bmadang_file_presence_ck check(madang_file_presence in ('Y','N')), -- 파일이 있는지 없는지(List화면에서 표시용으로 사용)
    madang_img_presence char(1) default 'N' constraint bmadang_img_presence_ck check(madang_img_presence in ('Y','N')), -- 이미지가 있는지 없는지(List화면에서 표시용으로 사용)
    madang_status char(1) default 'Y' constraint bmadang_status_ck check(madang_status in ('Y','N')) -- 삭제 여부
);

-- 자랑마당
create sequence bmadang_seq 
start with 1
increment by 1
maxvalue 999999;

-- 테스트용 더미 데이터(자유마당)
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.1', '테스트 글 입니다.1',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.2', '테스트 글 입니다.2',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.3', '테스트 글 입니다.3',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.4', '테스트 글 입니다.3',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.5', '테스트 글 입니다.4',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.6', '테스트 글 입니다.5',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.7', '테스트 글 입니다.6',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8', '테스트 글 입니다.7',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.9', '테스트 글 입니다.8',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.10', '테스트 글 입니다.10',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.11', '테스트 글 입니다.11',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.12', '테스트 글 입니다.12',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.13', '테스트 글 입니다.13',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.14', '테스트 글 입니다.14',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.15', '테스트 글 입니다.15',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.16', '테스트 글 입니다.16',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.17', '테스트 글 입니다.17',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.18', '테스트 글 입니다.18',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.19', '테스트 글 입니다.19',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.20', '테스트 글 입니다.20',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.21', '테스트 글 입니다.21',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.22', '테스트 글 입니다.22',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.23', '테스트 글 입니다.23',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.24', '테스트 글 입니다.24',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.25', '테스트 글 입니다.25',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.26', '테스트 글 입니다.26',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.27', '테스트 글 입니다.27',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.28', '테스트 글 입니다.28',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.29', '테스트 글 입니다.29',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.30', '테스트 글 입니다.39',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.1', '삭제된 글입니다. 출력되면 안됩니다.1',sysdate, null, default,default, null, null, default, default, default, 'N');
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.2', '삭제된 글입니다. 출력되면 안됩니다.2',sysdate, null, default,default, null, null, default, default, default, 'N');
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.3', '삭제된 글입니다. 출력되면 안됩니다.3',sysdate, null, default,default, null, null, default, default, default, 'N');
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.4', '삭제된 글입니다. 출력되면 안됩니다.4',sysdate, null, default,default, null, null, default, default, default, 'N');
insert into ta_free_madang values(fmadang_seq.nextval, 8, 1, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글1', '테스트 글 입니다.8-답글1',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, 8, 2, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글2', '테스트 글 입니다.8-답글2',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, 8, 3, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글3', '테스트 글 입니다.8-답글3',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, 8, 4, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글4', '테스트 글 입니다.8-답글4',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, 10, 1, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.10-답글1', '테스트 글 입니다.10-답글1',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, 10, 2, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.10-답글2', '테스트 글 입니다.10-답글2',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.31', '테스트 글 입니다.31',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.32', '테스트 글 입니다.32',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.33', '테스트 글 입니다.33',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.34', '테스트 글 입니다.34',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.35', '테스트 글 입니다.35',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.36', '테스트 글 입니다.36',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.37', '테스트 글 입니다.37',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.38', '테스트 글 입니다.38',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.39', '테스트 글 입니다.39',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.40', '테스트 글 입니다.40',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.41', '테스트 글 입니다.41',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.42', '테스트 글 입니다.42',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.43', '테스트 글 입니다.43',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.44', '테스트 글 입니다.44',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.45', '테스트 글 입니다.45',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.46', '테스트 글 입니다.46',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.47', '테스트 글 입니다.47',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.48', '테스트 글 입니다.48',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.49', '테스트 글 입니다.49',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.50', '테스트 글 입니다.50',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.51', '테스트 글 입니다.51',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.52', '테스트 글 입니다.52',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.53', '테스트 글 입니다.53',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.54', '테스트 글 입니다.54',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.55', '테스트 글 입니다.55',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.56', '테스트 글 입니다.56',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.57', '테스트 글 입니다.57',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.58', '테스트 글 입니다.58',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.59', '테스트 글 입니다.59',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.60', '테스트 글 입니다.60',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.61', '테스트 글 입니다.61',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.62', '테스트 글 입니다.62',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.63', '테스트 글 입니다.63',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.64', '테스트 글 입니다.64',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.65', '테스트 글 입니다.65',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.66', '테스트 글 입니다.66',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.67', '테스트 글 입니다.67',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.68', '테스트 글 입니다.68',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.69', '테스트 글 입니다.69',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.70', '테스트 글 입니다.70',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.71', '테스트 글 입니다.71',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.72', '테스트 글 입니다.72',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.73', '테스트 글 입니다.73',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.74', '테스트 글 입니다.74',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.75', '테스트 글 입니다.75',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.76', '테스트 글 입니다.76',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.77', '테스트 글 입니다.77',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.78', '테스트 글 입니다.78',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.79', '테스트 글 입니다.79',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.80', '테스트 글 입니다.80',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.81', '테스트 글 입니다.81',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.82', '테스트 글 입니다.82',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.83', '테스트 글 입니다.83',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.84', '테스트 글 입니다.84',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.85', '테스트 글 입니다.85',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.86', '테스트 글 입니다.86',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.87', '테스트 글 입니다.87',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.88', '테스트 글 입니다.88',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.89', '테스트 글 입니다.89',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.90', '테스트 글 입니다.90',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.91', '테스트 글 입니다.91',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.92', '테스트 글 입니다.92',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.93', '테스트 글 입니다.93',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.94', '테스트 글 입니다.94',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.95', '테스트 글 입니다.95',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.96', '테스트 글 입니다.96',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.97', '테스트 글 입니다.97',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.98', '테스트 글 입니다.98',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.99', '테스트 글 입니다.99',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_free_madang values(fmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.100', '테스트 글 입니다.100',sysdate, null, default,default, null, null, default, default, default, default);
commit;

-- 공유마당 더미데이터
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.1', '테스트 글 입니다.1',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.2', '테스트 글 입니다.2',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.3', '테스트 글 입니다.3',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.4', '테스트 글 입니다.3',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.5', '테스트 글 입니다.4',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.6', '테스트 글 입니다.5',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.7', '테스트 글 입니다.6',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8', '테스트 글 입니다.7',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.9', '테스트 글 입니다.8',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.10', '테스트 글 입니다.10',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.11', '테스트 글 입니다.11',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.12', '테스트 글 입니다.12',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.13', '테스트 글 입니다.13',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.14', '테스트 글 입니다.14',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.15', '테스트 글 입니다.15',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.16', '테스트 글 입니다.16',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.17', '테스트 글 입니다.17',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.18', '테스트 글 입니다.18',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.19', '테스트 글 입니다.19',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.20', '테스트 글 입니다.20',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.21', '테스트 글 입니다.21',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.22', '테스트 글 입니다.22',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.23', '테스트 글 입니다.23',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.24', '테스트 글 입니다.24',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.25', '테스트 글 입니다.25',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.26', '테스트 글 입니다.26',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.27', '테스트 글 입니다.27',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.28', '테스트 글 입니다.28',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.29', '테스트 글 입니다.29',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.30', '테스트 글 입니다.39',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.1', '삭제된 글입니다. 출력되면 안됩니다.1',sysdate, null, default,default, null, null, default, default, default, default, 'N');
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.2', '삭제된 글입니다. 출력되면 안됩니다.2',sysdate, null, default,default, null, null, default, default, default, default, 'N');
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.3', '삭제된 글입니다. 출력되면 안됩니다.3',sysdate, null, default,default, null, null, default, default, default, default, 'N');
insert into ta_share_madang values(smadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.4', '삭제된 글입니다. 출력되면 안됩니다.4',sysdate, null, default,default, null, null, default, default, default, default, 'N');
insert into ta_share_madang values(smadang_seq.nextval, 8, 1, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글1', '테스트 글 입니다.8-답글1',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, 8, 2, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글2', '테스트 글 입니다.8-답글2',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, 8, 3, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글3', '테스트 글 입니다.8-답글3',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, 8, 4, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글4', '테스트 글 입니다.8-답글4',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, 10, 1, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.10-답글1', '테스트 글 입니다.10-답글1',sysdate, null, default,default, null, null, default, default, default, default, default);
insert into ta_share_madang values(smadang_seq.nextval, 10, 2, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.10-답글2', '테스트 글 입니다.10-답글2',sysdate, null, default,default, null, null, default, default, default, default, default);
commit;

-- 자랑마당 더미데이터
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.1', '테스트 글 입니다.1',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.2', '테스트 글 입니다.2',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.3', '테스트 글 입니다.3',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.4', '테스트 글 입니다.3',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.5', '테스트 글 입니다.4',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.6', '테스트 글 입니다.5',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.7', '테스트 글 입니다.6',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8', '테스트 글 입니다.7',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.9', '테스트 글 입니다.8',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.10', '테스트 글 입니다.10',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.11', '테스트 글 입니다.11',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.12', '테스트 글 입니다.12',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.13', '테스트 글 입니다.13',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.14', '테스트 글 입니다.14',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.15', '테스트 글 입니다.15',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.16', '테스트 글 입니다.16',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.17', '테스트 글 입니다.17',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.18', '테스트 글 입니다.18',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.19', '테스트 글 입니다.19',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.20', '테스트 글 입니다.20',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.21', '테스트 글 입니다.21',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.22', '테스트 글 입니다.22',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.23', '테스트 글 입니다.23',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.24', '테스트 글 입니다.24',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.25', '테스트 글 입니다.25',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.26', '테스트 글 입니다.26',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.27', '테스트 글 입니다.27',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.28', '테스트 글 입니다.28',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.29', '테스트 글 입니다.29',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.30', '테스트 글 입니다.39',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.1', '삭제된 글입니다. 출력되면 안됩니다.1',sysdate, null, default,default, null, null, default, default, default, 'N');
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.2', '삭제된 글입니다. 출력되면 안됩니다.2',sysdate, null, default,default, null, null, default, default, default, 'N');
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.3', '삭제된 글입니다. 출력되면 안됩니다.3',sysdate, null, default,default, null, null, default, default, default, 'N');
insert into ta_boast_madang values(bmadang_seq.nextval, default, default, 10000, 'admin@studium.com', '관리자', '삭제된 글입니다. 출력되면 안됩니다.4', '삭제된 글입니다. 출력되면 안됩니다.4',sysdate, null, default,default, null, null, default, default, default, 'N');
insert into ta_boast_madang values(bmadang_seq.nextval, 8, 1, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글1', '테스트 글 입니다.8-답글1',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, 8, 2, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글2', '테스트 글 입니다.8-답글2',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, 8, 3, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글3', '테스트 글 입니다.8-답글3',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, 8, 4, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.8-답글4', '테스트 글 입니다.8-답글4',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, 10, 1, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.10-답글1', '테스트 글 입니다.10-답글1',sysdate, null, default,default, null, null, default, default, default, default);
insert into ta_boast_madang values(bmadang_seq.nextval, 10, 2, 10000, 'admin@studium.com', '관리자', '테스트 글 입니다.10-답글2', '테스트 글 입니다.10-답글2',sysdate, null, default,default, null, null, default, default, default, default);
commit;


-- 댓글 테이블

-- 공부마당 댓글 테이블
-- 댓글 번호도 시퀀스로 필요할듯. 
-- 게시글 생성 될 때, 시퀀스도 생성?
/*
    댓글/대댓글, 순서 적용 방법
    1. parent가 null일 경우, cmt_no로 정렬을 한다.
    2. parent가 null이 아닐 경우, parent로 정렬한다.
    3. 첫번째 정렬 조건에서 값이 같을 경우 cmt_seq로 정렬한다.
*/



-- 댓글 테이블 => 각 게시판당 한 개의 테이블 생성 => 댓글 테이블은 계층형으로 도전!
create table ta_fmadang_cmt (
    cmt_no number primary key, -- 댓글 시퀀스 넘버
    cmt_parent number, -- 부모 댓글의 번호를 가짐. 부모는 null
    cmt_sort number default 0, -- 댓글 정렬 (기본값 0으로, 대댓글 순서대로 1씩 증가)
    cmt_madang_no number references ta_free_madang(madang_no), -- 게시글 번호(왜래키)
    cmt_content clob, -- 댓글 내용
    cmt_reply char(1) default 'N' check (cmt_reply in ('Y','N')), -- 대댓글 존재 여부
--  cmt_secret char(1) default 'N' check (cmt_secret in ('Y','N')), -- 비밀 댓글 여부 // 일단 현재 사용하지 않을 예정
    cmt_writer_uid number not null references ta_member(mem_no), -- 댓글 작성자 uid(고유넘버)
    cmt_writer varchar2(30) not null, -- 댓글 작성자 이메일 (기본적으로 댓글에 정보를 띄워주기 위함)
    cmt_writer_name varchar2(30) not null, -- 댓글 작성자 이름 (기본적으로 댓글에 정보를 띄워주기 위함)
    cmt_register_datetime date, -- 댓글 작성 일시
    cmt_updated_datetime date, -- 댓글 최근 수정 일시
    cmt_register_ip varchar2(20), -- 댓글 작성 ip 주소
    cmt_updated_ip varchar2(20), -- 댓글 최근 수정 ip 주소
    cmt_status char(1) default 'Y' check (cmt_status in ('Y','N')), -- 댓글 삭제 여부(부모 댓글이 삭제 처리될 시, 대댓글도 모두 N으로 처리)
    cmt_blame number default 0, -- 신고 횟수
    cmt_blame_admin char(1) default 'N' check (cmt_blame_admin in ('Y','N')) -- 신고 접수로인해 관리자 판단 하에 삭제조치된 경우. ("관리자에의 의해 삭제처리된 댓글입니다." 표기//일단 그냥 삭제처리와 동일하게)
);

-- 자유마당 댓글 시퀀스
create sequence fmadang_cmt_seq 
start with 1
increment by 1
maxvalue 9999999;

insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, null, default, 110, '테스트 댓글입니다.', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, null, default,110, '테스트 댓글입니다.2', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, null, default,110, '테스트 댓글입니다.3', 'Y', 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, 3, 2, 110, '테스트 대댓글입니다.3-1', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, null, default, 110, '테스트 댓글입니다.4', 'Y', 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, 3, 1, 110, '테스트 대댓글입니다.3-2', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, 5, 1, 110, '테스트 대댓글입니다.4-1', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, null, default, 110, '테스트 댓글입니다.5', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, null, default, 110, '출력되면 안되는 댓글입니다.', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, 'N', default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, null, default, 110, '출력되면 안되는 댓글입니다.', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, 'N', default, default);
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, null, default, 110, '신고접수로 삭제된 댓글.', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, 'Y');
insert into ta_fmadang_cmt values(fmadang_cmt_seq.nextval, null, default, 110, '신고접수로 삭제된 댓글.', default, 10000, 'admin@studium.com', '관리자', sysdate, null, null, null, default, default, 'Y');
--SELECT * FROM TA_FMADANG_CMT;
--SELECT * FROM (SELECT ROWNUM AS RNUM, A.* FROM (SELECT * FROM TA_FMADANG_CMT WHERE CMT_MADANG_NO=110 AND CMT_STATUS='Y' AND CMT_BLAME_ADMIN='N' START WITH CMT_PARENT IS NULL CONNECT BY PRIOR CMT_NO=CMT_PARENT) A) WHERE RNUM BETWEEN 1 AND 50;
--SELECT COUNT(*) FROM TA_FMADANG_CMT WHERE CMT_MADANG_NO=110 AND CMT_STATUS='Y' AND CMT_BLAME_ADMIN='N';
--SELECT NVL(MAX(CMT_SORT),0) FROM TA_FMADANG_CMT WHERE  CMT_GROUP = '3';
--UPDATE TA_FMADANG_CMT SET CMT_SORT = CMT_SORT + 1 WHERE CMT_GROUP =  3  AND CMT_SORT >= 0;
-- 댓글의 경우
INSERT INTO TA_FMADANG_CMT VALUES(FMADANG_CMT_SEQ.NEXTVAL, NULL, DEFAULT, 110, '새로 추가된 댓글입니다.', DEFAULT, 10000, 'admin@studium.com', '관리자', SYSDATE, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
-- 대댓글의 경우 
INSERT INTO TA_FMADANG_CMT VALUES(FMADANG_CMT_SEQ.NEXTVAL, 13, (SELECT NVL(MAX(CMT_SORT),0) FROM TA_FMADANG_CMT WHERE  CMT_GROUP = '13')+1, 110, '새로 추가된 대댓글입니다.', DEFAULT, 10000, 'admin@studium.com', '관리자', SYSDATE, SYSDATE, NULL, NULL, DEFAULT, DEFAULT, DEFAULT);
UPDATE TA_FMADANG_CMT SET CMT_SORT = CMT_SORT + 1 WHERE CMT_PARENT =  3  AND CMT_SORT >= 1;
INSERT INTO TA_FMADANG_CMT VALUES(FMADANG_CMT_SEQ.NEXTVAL, 3, 1, 110, '새로 추가된 대댓글입니다.', DEFAULT, 10000, 'admin@studium.com', '관리자', SYSDATE, SYSDATE, NULL, NULL, DEFAULT, DEFAULT, DEFAULT);
commit;



-- 공부마당 댓글 테이블 
create table ta_stmadang_cmt (
    cmt_no number primary key, -- 댓글 시퀀스 넘버
    cmt_parent number, -- 부모 댓글의 번호를 가짐. 부모는 null
    cmt_sort number default 0, -- 댓글 정렬 (기본값 0으로, 대댓글 순서대로 1씩 증가)
    cmt_madang_no number references ta_study_madang(madang_no), -- 게시글 번호(왜래키)
    cmt_content clob, -- 댓글 내용
    cmt_reply char(1) default 'N' check (cmt_reply in ('Y','N')), -- 대댓글 존재 여부
--  cmt_secret char(1) default 'N' check (cmt_secret in ('Y','N')), -- 비밀 댓글 여부 // 일단 현재 사용하지 않을 예정
    cmt_writer_uid number not null references ta_member(mem_no), -- 댓글 작성자 uid(고유넘버)
    cmt_writer varchar2(30) not null, -- 댓글 작성자 이메일 (기본적으로 댓글에 정보를 띄워주기 위함)
    cmt_writer_name varchar2(30) not null, -- 댓글 작성자 이름 (기본적으로 댓글에 정보를 띄워주기 위함)
    cmt_register_datetime date, -- 댓글 작성 일시
    cmt_updated_datetime date, -- 댓글 최근 수정 일시
    cmt_register_ip varchar2(20), -- 댓글 작성 ip 주소
    cmt_updated_ip varchar2(20), -- 댓글 최근 수정 ip 주소
    cmt_status char(1) default 'Y' check (cmt_status in ('Y','N')), -- 댓글 삭제 여부(부모 댓글이 삭제 처리될 시, 대댓글도 모두 N으로 처리)
    cmt_blame number default 0, -- 신고 횟수
    cmt_blame_admin char(1) default 'N' check (cmt_blame_admin in ('Y','N')) -- 신고 접수로인해 관리자 판단 하에 삭제조치된 경우. ("관리자에의 의해 삭제처리된 댓글입니다." 표기//일단 그냥 삭제처리와 동일하게)
);

-- 공부마당 댓글 시퀀스
create sequence stmadang_cmt_seq 
start with 1
increment by 1
maxvalue 9999999;



-- 공유마당 댓글 테이블 
create table ta_smadang_cmt (
    cmt_no number primary key, -- 댓글 시퀀스 넘버
    cmt_parent number, -- 부모 댓글의 번호를 가짐. 부모는 null
    cmt_sort number default 0, -- 댓글 정렬 (기본값 0으로, 대댓글 순서대로 1씩 증가)
    cmt_madang_no number references ta_share_madang(madang_no), -- 게시글 번호(왜래키)
    cmt_content clob, -- 댓글 내용
    cmt_reply char(1) default 'N' check (cmt_reply in ('Y','N')), -- 대댓글 존재 여부
--  cmt_secret char(1) default 'N' check (cmt_secret in ('Y','N')), -- 비밀 댓글 여부 // 일단 현재 사용하지 않을 예정
    cmt_writer_uid number not null references ta_member(mem_no), -- 댓글 작성자 uid(고유넘버)
    cmt_writer varchar2(30) not null, -- 댓글 작성자 이메일 (기본적으로 댓글에 정보를 띄워주기 위함)
    cmt_writer_name varchar2(30) not null, -- 댓글 작성자 이름 (기본적으로 댓글에 정보를 띄워주기 위함)
    cmt_register_datetime date, -- 댓글 작성 일시
    cmt_updated_datetime date, -- 댓글 최근 수정 일시
    cmt_register_ip varchar2(20), -- 댓글 작성 ip 주소
    cmt_updated_ip varchar2(20), -- 댓글 최근 수정 ip 주소
    cmt_status char(1) default 'Y' check (cmt_status in ('Y','N')), -- 댓글 삭제 여부(부모 댓글이 삭제 처리될 시, 대댓글도 모두 N으로 처리)
    cmt_blame number default 0, -- 신고 횟수
    cmt_blame_admin char(1) default 'N' check (cmt_blame_admin in ('Y','N')) -- 신고 접수로인해 관리자 판단 하에 삭제조치된 경우. ("관리자에의 의해 삭제처리된 댓글입니다." 표기//일단 그냥 삭제처리와 동일하게)
);

-- 공유마당 댓글 시퀀스
create sequence smadang_cmt_seq 
start with 1
increment by 1
maxvalue 9999999;


-- 자랑마당 댓글 테이블 
create table ta_bmadang_cmt (
    cmt_no number primary key, -- 댓글 시퀀스 넘버
    cmt_parent number, -- 부모 댓글의 번호를 가짐. 부모는 null
    cmt_sort number default 0, -- 댓글 정렬 (기본값 0으로, 대댓글 순서대로 1씩 증가)
    cmt_madang_no number references ta_boast_madang(madang_no), -- 게시글 번호(왜래키)
    cmt_content clob, -- 댓글 내용
    cmt_reply char(1) default 'N' check (cmt_reply in ('Y','N')), -- 대댓글 존재 여부
--  cmt_secret char(1) default 'N' check (cmt_secret in ('Y','N')), -- 비밀 댓글 여부 // 일단 현재 사용하지 않을 예정
    cmt_writer_uid number not null references ta_member(mem_no), -- 댓글 작성자 uid(고유넘버)
    cmt_writer varchar2(30) not null, -- 댓글 작성자 이메일 (기본적으로 댓글에 정보를 띄워주기 위함)
    cmt_writer_name varchar2(30) not null, -- 댓글 작성자 이름 (기본적으로 댓글에 정보를 띄워주기 위함)
    cmt_register_datetime date, -- 댓글 작성 일시
    cmt_updated_datetime date, -- 댓글 최근 수정 일시
    cmt_register_ip varchar2(20), -- 댓글 작성 ip 주소
    cmt_updated_ip varchar2(20), -- 댓글 최근 수정 ip 주소
    cmt_status char(1) default 'Y' check (cmt_status in ('Y','N')), -- 댓글 삭제 여부(부모 댓글이 삭제 처리될 시, 대댓글도 모두 N으로 처리)
    cmt_blame number default 0, -- 신고 횟수
    cmt_blame_admin char(1) default 'N' check (cmt_blame_admin in ('Y','N')) -- 신고 접수로인해 관리자 판단 하에 삭제조치된 경우. ("관리자에의 의해 삭제처리된 댓글입니다." 표기//일단 그냥 삭제처리와 동일하게)
);

-- 자랑마당 댓글 시퀀스
create sequence bmadang_cmt_seq 
start with 1
increment by 1
maxvalue 9999999;







-- 사이드 메뉴 바 요소를 위한 테이블
create table ta_sidemenu_elements (
    menu_id number constraint menu_id_pk primary key, -- 기본키
    menu_category varchar2(30) not null, -- 메뉴가 사용될 위치
    menu_name varchar2(30) not null, -- 메뉴 이름
    menu_url varchar2(30) not null, -- 이동시킬 경로
    menu_class varchar2(50) default null, -- 메뉴에 설정할 class (아이콘 설정용//하위메뉴는 null)
    use_down char(1) default 'N' constraint use_down_ck check(use_down in ('Y','N')), -- 하위 메뉴 사용 여부
    sort_no number not null, -- 정렬 순서
    parent_id number default null -- 부모 메뉴의 id
);

create sequence ta_sidemenu_seq 
start with 1
increment by 1
maxvalue 9999;

SELECT * FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' START WITH PARENT_ID IS NULL CONNECT BY PRIOR MENU_ID=PARENT_ID;
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang', '마당소개', '/madang/introMadang', 'fas fa-tachometer-alt fa-lg', default, 1, default);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','공부마당', '/madang/studyMadangList', 'fab fa-studiovinari fa-lg', 'Y', 2, default);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','자유마당', '/madang/freeMadangList', 'fab fa-fort-awesome-alt fa-lg', default, 3, default);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','공유마당', '/madang/shareMadangList', 'fab fa-pagelines fa-lg', 'Y', 4, default);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','자랑마당', '/madang/boastMadangList', 'fas fa-user-tie fa-lg', 'Y', 5, default);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','질문마당', '/madang/questionMadang', 'fa fa-users fa-lg', 'Y', 6, default);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','외국어', '/madang/studyMadangList?mCategory=외국어', default, default, 1, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공부마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','프로그래밍', '/madang/studyMadangList?mCategory=프로그래밍', default, default, 2, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공부마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','공무원', '/madang/studyMadangList?mCategory=공무원', default, default, 3, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공부마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','자격증', '/madang/studyMadangList?mCategory=자격증', default, default, 4, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공부마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','취업준비', '/madang/studyMadangList?mCategory=취업준비', default, default, 5, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공부마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','일반', '/madang/studyMadangList?mCategory=일반, default, default, 6, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공부마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','외국어', '/madang/studyMadangList?mCategory=외국어', default, default, 1, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공유마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','프로그래밍', '/madang/studyMadangList?mCategory=프로그래밍', default, default, 2, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공유마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','공무원', '/madang/studyMadangList?mCategory=공무원', default, default, 3, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공유마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','자격증', '/madang/studyMadangList?mCategory=자격증', default, default, 4, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공부마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','취업준비', '/madang/studyMadangList?mCategory=취업준비', default, default, 5, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공유마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','일반', '/madang/studyMadangList?mCategory=일반, default, default, 6, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='공유마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','외국어', '/madang/studyMadangList?mCategory=외국어', default, default, 1, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='자랑마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','프로그래밍', '/madang/studyMadangList?mCategory=프로그래밍', default, default, 2, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='자랑마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','공무원', '/madang/studyMadangList?mCategory=공무원', default, default, 3, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='자랑마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','자격증', '/madang/studyMadangList?mCategory=자격증', default, default, 4, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='자랑마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','취업준비', '/madang/studyMadangList?mCategory=취업준비', default, default, 5, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='자랑마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','일반', '/madang/studyMadangList?mCategory=일반, default, default, 6, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='자랑마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','외국어', '/madang/studyMadangList?mCategory=외국어', default, default, 1, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='질문마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','프로그래밍', '/madang/studyMadangList?mCategory=프로그래밍', default, default, 2, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='질문마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','공무원', '/madang/studyMadangList?mCategory=공무원', default, default, 3, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='질문마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','자격증', '/madang/studyMadangList?mCategory=자격증', default, default, 4, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='질문마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','취업준비', '/madang/studyMadangList?mCategory=취업준비', default, default, 5, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='질문마당');
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'madang','일반', '/madang/studyMadangList?mCategory=일반, default, default, 6, SELECT MENU_ID FROM TA_SIDEMENU_ELEMENTS WHERE MENU_CATEGORY='madang' AND MENU_NAME='질문마당');
commit;


insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'admin','인쿼리', '/AdminInqueryList', default, default, 1, default);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'admin','포인트 관리', '/AdminPointManage', default, default, 2, default); 
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'admin','1:1문의 관리', '/AdminQandAList', default, default, 3, default);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'admin','결제 관리', '/AdminPayManage', default, default, 4, default);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'admin','강사 신청 관리', '/AdminPSManage', default, default, 5, default);
update ta_sidemenu_elements set use_down='Y' where menu_name='결제 관리';
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'admin','결제 내역', '/AdminPayManageList', default, default, 6, 22);
insert into ta_sidemenu_elements values(ta_sidemenu_seq.nextval, 'admin','취소 내역', '/AdminPayManageCancleList', default, default, 7, 22);
commit;


-- 로그인 로그 db
create table ta_member_login_log (
    mll_no number primary key, -- 시퀀스 PK 
    mll_success char(1) check (mll_success in ('Y','N')), -- 로그인 성공 여부
    mll_mem_no number, -- 로그인 한 회원 PK (찾아오지 못할 때, null(0값)을 넣을 생각인데, 외래키는 부모키를 찾을 수 없다고 에러나기 때문에 없앴음.) references ta_member(mem_no) 
    mll_user_email varchar2(30), -- 로그인 시도할 때에 입력한 이메일
    mll_datetime date, -- 로그인 일시
    mll_ip varchar2(20), -- 로그인 한 IP
    mll_reason varchar2(500), -- 로그인 성공/실패시 이유
    mll_useragent varchar2(500), -- 로그인한 브라우저의 user agent
    mll_url varchar2(500), -- 로그인한 페이지 주소
    mll_referer varchar2(500) -- 이전 페이지 주소
);

-- 로그인 로그 시퀀스
create sequence mll_seq 
start with 1
increment by 1
maxvalue 999999999;

-- 이 위 까지만 전체 실하면 됩니다.

-----------------------------------------------<이 아래는 아직 테스트 중입니다. :>
-- 좋아요(추천 테이블)
-- 한 테이블로 처리하고 싶었는데, 외래키 지정때문에 마당마다 만들어야할 듯 싶다..
create table ta_stmadang_like (
    like_no number primary key, -- 시퀀스 pk
    madang_no number references ta_study_madang(madang_no), -- 마당 번호 fk
    mem_no number references ta_member(mem_no), -- 회원 번호 fk
    like_datetime date default sysdate, -- 좋아요(추천) 일시
    like_ip varchar2(20), -- 좋아요(추천) ip
    unique (madang_no, mem_no)
);

create sequence stm_like_seq  
start with 1
increment by 1
maxvalue 999999999;

drop table ta_stmadang_like CASCADE CONSTRAINT;
drop sequence stm_like_seq;
drop table ta_member_login_log;
drop sequence mll_seq;
select * from ta_member_login_log;

SELECT COUNT(*) FROM TA_STMADANG_LIKE WHERE MEM_NO = 10000;
select * from ta_stmadang_like ;
drop table ta_study_madang ;
drop sequence sboard_seq;

-- 공부마당(or 풀이마당)
/* 글쓴이가 계정을 탈퇴한다고 게시글이 삭제되는 경우도 드물기에 외래키 지정 안 함 */
create table ta_study_madang(
    board_no number constraint board_no_pk primary key, -- 글번호
    board_order number default 0, -- 답글이 달렸을 시, 해당 게시글의 순서를 정해주기 위한 순서번호
    /* 0번부터 순차적으로 부여, board_no을 오름차순으로 정렬해놓은 상태면,
    board_order을 내림차순으로 2차 정렬하면 원하는 글 순서가 출력된다.
    board_order가 0이 아닌 글은 답글로 판단하면 될 듯.*/
    board_writer_id varchar2(20), -- 글쓴이 아이디
    board_writer_name varchar2(20), -- 글쓴이 이름(이름으로 표기)
    board_title varchar2(100) constraint board_title_nn not null, -- 글 제목
    board_content clob constraint board_content_nn not null, -- 글 내용
    board_register_datetime date, -- 글 작성 일시
--  board_register_ip varchar2(20) -- 글 작성 ip 주소
    board_rec_count number default 0, -- 글 추천 수(recommand)
    board_fork_count number default 0, -- 글 포크 수 
    board_que_count number default 0 -- 글 풀이 수
);

-- 공부마당(풀이마당)
create sequence sboard_seq 
start with 1
increment by 1
maxvalue 999999;



create table free_madang_file (
    fmf_no number fmf_id_pk primary key,-- 파일 번호 
    madang_no number constraint madang_no_fk references ta_free_madang(madang_no), -- 마당글 번호
    member_no number constraint member_no_fk references ta_member(mem_no), -- 회원 번호
    fmf_original_filename varchar2(100), -- 파일 업로드시 원래 파일명
    fmf_rename_filename varchar2(100), -- 파일 업로드시 서버에 저장된 파일명
    fmf_download_count number, -- 다운로드 회수
    fmf_filesize number, -- 파일 크기
    fmf_is_image char(1) default 'N' constraint fmf_is_image_ck check(fmf_is_image in ('Y','N')), -- 이미지인지 여부
    fmf_width number default null, -- 이미지일 경우 이미지 가로값
    fmf_height number default null, -- 이미지일 경우 이미지 세로값
    fmf_type varchar2(20), -- 파일 확장자
    fmf_datetime date, -- 등록일자
    fmf_ip varchar2(20) -- 등록 ip
);



create table ta_qboard_rep (
    board_no number constraint board_no_fk references ta_qborad(board_no), -- 게시글 번호(외래키)
    cmt_no number constraint cmt_no_pk primary key, -- 댓글 번호(시퀀스)
    cmt varchar2(1000), -- 댓글 내용(최대 300자까지 받을 예정)
    parent number default null, -- 대댓글의 경우 사용되는 열로, null이면 기본댓글, 값이 있으면 대댓글 parent의 값이 부모 댓글의 cmt_no
    cmt_seq number default 0 --부모댓글이 seq값이 기본적으로 0이 부여, 대댓글 순서대로 1,2,3 ... 부여
);

-- 공유마당 댓글 테이블
create table ta_sboard_rep (
    board_no number constraint board_no_fk references ta_qborad(board_no), -- 게시글 번호(외래키)
    cmt_no number constraint cmt_no_pk primary key, -- 댓글 번호(시퀀스)
    cmt varchar2(1000), -- 댓글 내용(최대 300자까지 받을 예정)
    parent number default null, -- 대댓글의 경우 사용되는 열로, null이면 기본댓글, 값이 있으면 대댓글 parent의 값이 부모 댓글의 cmt_no
    cmt_seq number default 0 --부모댓글이 seq값이 기본적으로 0이 부여, 대댓글 순서대로 1,2,3 ... 부여
);