CREATE TABLE "student" (
	"num"	VARCHAR2(10)		NOT NULL,
	"user_id"	VARCHAR2(20)		NOT NULL,
	"name"	VARCHAR2(20)		NOT NULL,
	"major"	VARCHAR2(50)		NOT NULL,
	"gender"	CHAR(1)		NOT NULL,
	"email"	VARCHAR2(30)		NULL,
	"tel"	VARCHAR2(15)		NULL,
	"addr"	VARCHAR2(200)		NULL,
	"birthday"	DATE		NOT NULL,
	"password"	VARCHAR2(20)		NULL
);

COMMENT ON COLUMN "student"."num" IS '학번';

COMMENT ON COLUMN "student"."user_id" IS '아이디';

COMMENT ON COLUMN "student"."name" IS '학생이름';

COMMENT ON COLUMN "student"."major" IS '전공명';

COMMENT ON COLUMN "student"."gender" IS '여자는 f
남자는 m로 표시';

COMMENT ON COLUMN "student"."email" IS '이메일';

COMMENT ON COLUMN "student"."tel" IS '전화번호';

COMMENT ON COLUMN "student"."addr" IS '주소';

COMMENT ON COLUMN "student"."birthday" IS '생년월일';

COMMENT ON COLUMN "student"."password" IS '비밀번호';

CREATE TABLE "teacher" (
	"num"	VARCHAR2(10)		NOT NULL,
	"name"	VARCHAR2(20)		NOT NULL,
	"major"	VARCHAR2(50)		NULL,
	"gender"	CHAR(1)		NOT NULL,
	"email"	VARCHAR2(30)		NULL,
	"tel"	VARCHAR2(15)		NULL,
	"addr"	VARCHAR2(200)		NULL,
	"birthday"	DATE		NULL,
	"user_id"	VARCHAR2(20)		NULL,
	"password"	VARCHAR2(20)		NULL
);

COMMENT ON COLUMN "teacher"."num" IS '교직원번호';

COMMENT ON COLUMN "teacher"."name" IS '교직원이름';

COMMENT ON COLUMN "teacher"."major" IS '전공명';

COMMENT ON COLUMN "teacher"."gender" IS '성별';

COMMENT ON COLUMN "teacher"."email" IS '이메일';

COMMENT ON COLUMN "teacher"."tel" IS '전화번호';

COMMENT ON COLUMN "teacher"."addr" IS '주소';

COMMENT ON COLUMN "teacher"."birthday" IS '생년월일';

COMMENT ON COLUMN "teacher"."user_id" IS '아이디';

COMMENT ON COLUMN "teacher"."password" IS '비밀번호';

CREATE TABLE "subject" (
	"subject_id"	VARCHAR2(20)		NOT NULL,
	"staff_id"	NUMBER		NOT NULL,
	"subject_title"	VARCHAR2(50)		NOT NULL,
	"prof_id"	NUMBER		NOT NULL,
	"major"	VARCHAR2(50)		NULL,
	"Field"	VARCHAR(255)		NULL
);

COMMENT ON COLUMN "subject"."subject_id" IS '과목일련번호';

COMMENT ON COLUMN "subject"."staff_id" IS '교직원번호';

COMMENT ON COLUMN "subject"."subject_title" IS '과목명';

COMMENT ON COLUMN "subject"."prof_id" IS '강사번호';

COMMENT ON COLUMN "subject"."major" IS '소속학과';

COMMENT ON COLUMN "subject"."Field" IS '전공/교양';

CREATE TABLE "class_info" (
	"time"	VARCHAR2(20)		NOT NULL,
	"subject_id"	VARCHAR2(20)		NOT NULL,
	"location"	VARCHAR2(30)		NOT NULL,
	"person"	NUMBER		NULL
);

COMMENT ON COLUMN "class_info"."time" IS '강의 시간';

COMMENT ON COLUMN "class_info"."subject_id" IS '과목일련번호';

COMMENT ON COLUMN "class_info"."location" IS '강의실 위치';

COMMENT ON COLUMN "class_info"."person" IS '수강인원';

CREATE TABLE "reg_subject" (
	"student_id"	NUMBER		NOT NULL,
	"subject_id"	VARCHAR2(20)		NOT NULL,
	"score"	NUMBER		NULL
);

COMMENT ON COLUMN "reg_subject"."student_id" IS '학번';

COMMENT ON COLUMN "reg_subject"."subject_id" IS '과목일련번호';

COMMENT ON COLUMN "reg_subject"."score" IS '학점';

CREATE TABLE board_global (
	bnum	NUMBER		PRIMARY KEY,
	num	VARCHAR2(10)	REFERENCES student(num)	NOT NULL,
	name	VARCHAR2(20)		NULL,
	title	VARCHAR2(100)		NULL,
	content	VARCHAR2(4000)		NULL,
	regdate	DATE	DEFAULT SYSDATE	NULL,
	count	NUMBER	DEFAULT 0	NULL,
	ikes	NUMBER	DEFAULT 0	NULL,
	filename	VARCHAR2(50)		NULL,
	filesize	NUMBER		NULL,
	anon	NUMBER	DEFAULT 1	NULL
);


COMMENT ON COLUMN "board_global"."num" IS '게시물번호';

COMMENT ON COLUMN "board_global"."user_id2" IS '아이디';

COMMENT ON COLUMN "board_global"."name" IS '글쓴이 이름';

COMMENT ON COLUMN "board_global"."title" IS '글제목';

COMMENT ON COLUMN "board_global"."content" IS '글내용';

COMMENT ON COLUMN "board_global"."regdate" IS '등록일';

COMMENT ON COLUMN "board_global"."count" IS '조회수';

COMMENT ON COLUMN "board_global"."likes" IS '공감';

COMMENT ON COLUMN "board_global"."filename" IS '파일이름';

COMMENT ON COLUMN "board_global"."filesize" IS '파일사이즈';

COMMENT ON COLUMN "board_global"."anon" IS '공개1/비공개2';

CREATE TABLE "comment_global" (
	"cnum"	NUMBER		NOT NULL,
	"num"	NUMBER		NOT NULL,
	"name"	VARCHAR2(20)		NULL,
	"user_id"	VARCHAR2(20)		NULL,
	"likes"	NUMBER	DEFAULT 0	NULL,
	"content"	VARCHAR2(2000)		NULL,
	"regdate"	DATE	DEFAULT SYSDATE	NULL,
	"anon"	NUMBER	DEFAULT 1	NULL
);

COMMENT ON COLUMN "comment_global"."cnum" IS '댓글번호';

COMMENT ON COLUMN "comment_global"."num" IS '게시물번호';

COMMENT ON COLUMN "comment_global"."name" IS '이름';

COMMENT ON COLUMN "comment_global"."user_id" IS '아이디';

COMMENT ON COLUMN "comment_global"."likes" IS '공감';

COMMENT ON COLUMN "comment_global"."content" IS '내용';

COMMENT ON COLUMN "comment_global"."regdate" IS '등록일';

COMMENT ON COLUMN "comment_global"."anon" IS '공개1/비공개2';

CREATE TABLE "studygroup" (
	"num"	NUMBER		NOT NULL,
	"gname"	VARCHAR2(60)		NOT NULL,
	"content"	VARCHAR2(4000)		NULL,
	"name"	VARCHAR2(20)		NULL,
	"user_id2"	VARCHAR2(20)		NOT NULL,
	"person"	NUMBER		NULL,
	"regdate"	DATE	DEFAULT SYSDATE	NULL,
	"edate"	DATE		NULL,
	"filename"	VARCHAR2(50)		NULL,
	"filesize"	NUMBER		NULL
);

COMMENT ON COLUMN "studygroup"."num" IS '그룹번호';

COMMENT ON COLUMN "studygroup"."gname" IS '그룹이름';

COMMENT ON COLUMN "studygroup"."content" IS '내용';

COMMENT ON COLUMN "studygroup"."name" IS '모임장이름';

COMMENT ON COLUMN "studygroup"."user_id2" IS '아이디';

COMMENT ON COLUMN "studygroup"."person" IS '모집인원';

COMMENT ON COLUMN "studygroup"."regdate" IS '등록일';

COMMENT ON COLUMN "studygroup"."edate" IS '모집마감일';

COMMENT ON COLUMN "studygroup"."filename" IS '파일이름';

COMMENT ON COLUMN "studygroup"."filesize" IS '파일사이즈';

CREATE TABLE "Untitled" (
	"num"	NUMBER		NOT NULL,
	"student_id"	NUMBER		NOT NULL,
	"user_id"	VARCHAR2(20)		NOT NULL,
	"regdate"	DATE		NULL,
	"tel"	VARCHAR2(15)		NULL
);

COMMENT ON COLUMN "Untitled"."num" IS '그룹번호';

COMMENT ON COLUMN "Untitled"."student_id" IS '학번';

COMMENT ON COLUMN "Untitled"."user_id" IS '아이디';

COMMENT ON COLUMN "Untitled"."regdate" IS '신청일';

COMMENT ON COLUMN "Untitled"."tel" IS '전화번호';

CREATE TABLE "worklist" (
	"num"	NUMBER		NOT NULL,
	"subject_id"	VARCHAR2(20)		NOT NULL,
	"title"	VARCHAR2(100)		NULL,
	"regdate"	DATE		NULL,
	"deadline"	DATE		NULL,
	"content"	VARCHAR2(4000)		NULL,
	"filename"	VARCHAR2(50)		NULL,
	"filesize"	NUMBER		NULL
);

COMMENT ON COLUMN "worklist"."num" IS '과제번호';

COMMENT ON COLUMN "worklist"."subject_id" IS '과목일련번호';

COMMENT ON COLUMN "worklist"."title" IS '과제번호';

COMMENT ON COLUMN "worklist"."regdate" IS '등록일';

COMMENT ON COLUMN "worklist"."deadline" IS '제출기한';

COMMENT ON COLUMN "worklist"."content" IS '내용';

COMMENT ON COLUMN "worklist"."filename" IS '파일명';

COMMENT ON COLUMN "worklist"."filesize" IS '파일사이즈';

CREATE TABLE "work_submit" (
	"num"	NUMBER		NOT NULL,
	"student_id"	NUMBER		NOT NULL,
	"user_id"	VARCHAR2(20)		NOT NULL,
	"regdate"	DATE		NULL,
	"title"	VARCHAR2(100)		NULL,
	"content"	VARCHAR2(4000)		NULL,
	"filename"	VARCHAR2(50)		NULL,
	"filesize"	NUMBER		NULL
);

COMMENT ON COLUMN "work_submit"."num" IS '과제번호';

COMMENT ON COLUMN "work_submit"."student_id" IS '학번';

COMMENT ON COLUMN "work_submit"."user_id" IS '아이디';

COMMENT ON COLUMN "work_submit"."regdate" IS '등록일';

COMMENT ON COLUMN "work_submit"."title" IS '제목';

COMMENT ON COLUMN "work_submit"."content" IS '내용';

COMMENT ON COLUMN "work_submit"."filename" IS '파일명';

COMMENT ON COLUMN "work_submit"."filesize" IS '파일사이즈';

CREATE TABLE "polllist" (
	"num"	NUMBER		NOT NULL,
	"subject_id"	VARCHAR2(20)		NOT NULL,
	"question"	VARCHAR2(2000)		NULL,
	"regdate"	DATE		NULL,
	"edate"	DATE		NULL,
	"type"	NUMBER		NULL
);

COMMENT ON COLUMN "polllist"."num" IS '투표번호';

COMMENT ON COLUMN "polllist"."subject_id" IS '과목일련번호';

COMMENT ON COLUMN "polllist"."question" IS '질문';

COMMENT ON COLUMN "polllist"."regdate" IS '등록일';

COMMENT ON COLUMN "polllist"."edate" IS '마감일';

COMMENT ON COLUMN "polllist"."type" IS '답변타입';

CREATE TABLE "pollitem" (
	"itemnum"	NUMBER		NOT NULL,
	"num"	NUMBER		NOT NULL,
	"item"	VARCHAR2(1000)		NULL,
	"count"	NUMBER		NULL
);

COMMENT ON COLUMN "pollitem"."itemnum" IS '선택지번호';

COMMENT ON COLUMN "pollitem"."num" IS '투표번호';

COMMENT ON COLUMN "pollitem"."item" IS '선택지내용';

COMMENT ON COLUMN "pollitem"."count" IS '카운트';

CREATE TABLE "board_class" (
	"num"	NUMBER		NOT NULL,
	"subject_id"	VARCHAR2(20)		NOT NULL,
	"student_id"	NUMBER		NOT NULL,
	"user_id"	VARCHAR2(20)		NOT NULL,
	"title"	VARCHAR2(1000)		NULL,
	"content"	VARCHAR2(4000)		NULL,
	"regdate"	DATE		NULL,
	"count"	NUMBER		NULL,
	"filename"	VARCHAR2(50)		NULL,
	"filesize"	NUMBER		NULL
);

COMMENT ON COLUMN "board_class"."num" IS '게시물번호';

COMMENT ON COLUMN "board_class"."subject_id" IS '과목일련번호';

COMMENT ON COLUMN "board_class"."student_id" IS '학번';

COMMENT ON COLUMN "board_class"."user_id" IS '아이디';

COMMENT ON COLUMN "board_class"."title" IS '제목';

COMMENT ON COLUMN "board_class"."content" IS '내용';

COMMENT ON COLUMN "board_class"."regdate" IS '등록일';

COMMENT ON COLUMN "board_class"."count" IS '조회수';

COMMENT ON COLUMN "board_class"."filename" IS '파일명';

COMMENT ON COLUMN "board_class"."filesize" IS '파일사이즈';

CREATE TABLE "comment_class" (
	"cnum"	NUMBER		NOT NULL,
	"num2"	NUMBER		NOT NULL,
	"name"	VARCHAR2(20)		NULL,
	"user_id"	VARCHAR2(20)		NULL,
	"likes"	NUMBER	DEFAULT 0	NULL,
	"content"	VARCHAR2(2000)		NULL,
	"regdate"	DATE	DEFAULT SYSDATE	NULL
);

COMMENT ON COLUMN "comment_class"."cnum" IS '댓글번호';

COMMENT ON COLUMN "comment_class"."num2" IS '게시물번호';

COMMENT ON COLUMN "comment_class"."name" IS '이름';

COMMENT ON COLUMN "comment_class"."user_id" IS '아이디';

COMMENT ON COLUMN "comment_class"."likes" IS '공감';

COMMENT ON COLUMN "comment_class"."content" IS '내용';

COMMENT ON COLUMN "comment_class"."regdate" IS '등록일';

CREATE TABLE "discussion" (
	"num"	NUMBER		NOT NULL,
	"subject_id"	VARCHAR2(20)		NOT NULL,
	"name"	VARCHAR2(15)		NULL,
	"regdate"	DATE		NULL,
	"title"	VARCHAR2(1000)		NULL,
	"content"	VARCHAR2(4000)		NULL
);

COMMENT ON COLUMN "discussion"."num" IS '번호';

COMMENT ON COLUMN "discussion"."subject_id" IS '과목일련번호';

COMMENT ON COLUMN "discussion"."name" IS '글쓴이';

COMMENT ON COLUMN "discussion"."regdate" IS '등록일';

COMMENT ON COLUMN "discussion"."title" IS '주제';

COMMENT ON COLUMN "discussion"."content" IS '내용';

CREATE TABLE "comment_discussion" (
	"cnum"	NUMBER		NOT NULL,
	"num"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "comment_discussion"."cnum" IS '댓글번호';

COMMENT ON COLUMN "comment_discussion"."num" IS '번호';

CREATE TABLE "question" (
	"num"	NUMBER		NOT NULL,
	"subject_id"	VARCHAR2(20)		NOT NULL,
	"title"	VARCHAR2(1000)		NULL,
	"content"	VARCHAR2(4000)		NULL,
	"student_id"	NUMBER		NOT NULL,
	"user_id"	VARCHAR2(20)		NOT NULL,
	"answer"	NUMBER	DEFAULT 0	NULL,
	"regdate"	DATE	DEFAULT SYSDATE	NULL
);

COMMENT ON COLUMN "question"."num" IS '질문번호';

COMMENT ON COLUMN "question"."subject_id" IS '과목일련번호';

COMMENT ON COLUMN "question"."title" IS '제목';

COMMENT ON COLUMN "question"."content" IS '내용';

COMMENT ON COLUMN "question"."student_id" IS '학번';

COMMENT ON COLUMN "question"."user_id" IS '아이디';

COMMENT ON COLUMN "question"."answer" IS '해결/미해결';

COMMENT ON COLUMN "question"."regdate" IS '등록일';

CREATE TABLE "answer" (
	"num"	NUMBER		NOT NULL,
	"title"	VARCHAR2(1000)		NULL,
	"content"	VARCHAR2(4000)		NULL,
	"regdate"	DATE	DEFAULT SYSDATE	NULL,
	"staff_id"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "answer"."num" IS '질문번호';

COMMENT ON COLUMN "answer"."title" IS '제목';

COMMENT ON COLUMN "answer"."content" IS '내용';

COMMENT ON COLUMN "answer"."regdate" IS '등록일';

COMMENT ON COLUMN "answer"."staff_id" IS '교직원번호';

