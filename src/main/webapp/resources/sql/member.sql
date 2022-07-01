-- 테이블 초기화
DROP TABLE MEMBER_LOG;
DROP TABLE SIGN_OUT_MEMBER;
DROP TABLE MEMBER;


-- 관리자(나중에 1번으로 insert하기)/ 탈퇴막기



CREATE TABLE MEMBER_LOG (
    MEMBER_LOG_NO	NUMBER	NOT NULL,        -- PK
	MEMBER_ID	    VARCHAR2(32 BYTE)	NOT NULL,	-- FK
	SIGN_UP     	DATE   -- 로그인 일시
);

CREATE TABLE SIGN_OUT_MEMBER (
	SIGN_OUT_NO	NUMBER	NOT NULL,           -- PK
	MEMBER_NO	NUMBER	NOT NULL,           
	ID	        VARCHAR2(32 BYTE) NOT NULL UNIQUE,
	NAME	    VARCHAR2(80 BYTE),
	EMAIL	    VARCHAR2(100 BYTE),
    AGREE_STATE	NUMBER,              	    -- 동의여부
    SIGN_IN	    DATE,     		-- 가입일
	SIGN_OUT	DATE    DEFAULT SYSDATE    -- 탈퇴일
	);


CREATE TABLE MEMBER (
	MEMBER_NO	        NUMBER	NOT NULL,               -- PK
	MEMBER_NAME 	    VARCHAR2(80 BYTE)	NOT NULL,
	MEMBER_EMAIL	    VARCHAR2(100 BYTE)	NOT NULL UNIQUE,
	MEMBER_ID	        VARCHAR2(32 BYTE)	NOT NULL UNIQUE,
	MEMBER_PW	        VARCHAR2(64 BYTE)	NOT NULL,
	MEMBER_PHONE	    VARCHAR2(30 BYTE),
	MEMBER_BIRTH	    VARCHAR2(20 BYTE),
    MEMBER_GENDER       VARCHAR2(20 BYTE),
    MEMBER_PROMO_ADD    VARCHAR2(20 BYTE),  -- 광고수신여부 
    MEMBER_POST_CODE    VARCHAR2(20 BYTE),  -- 우편번호
    MEMBER_ROAD_ADDR    VARCHAR2(300 BYTE), -- 주소
	AGREE_STATE	        NUMBER,
	SIGN_IN	    		DATE,	 -- 가입일
	RESER_NO			NUMBER,  -- 예약내역
	QNA_NO				NUMBER   -- qna내역
);


-- 시퀀스
DROP SEQUENCE MEMBER_LOG_SEQ;
DROP SEQUENCE SIGN_OUT_MEMBER_SEQ;
DROP SEQUENCE MEMBER_SEQ;

CREATE SEQUENCE MEMBER_LOG_SEQ NOCACHE;
CREATE SEQUENCE SIGN_OUT_MEMBER_SEQ NOCACHE;
CREATE SEQUENCE MEMBER_SEQ NOCACHE;


-- 기본키
ALTER TABLE MEMBER_LOG ADD CONSTRAINT MEMBER_LOG_PK PRIMARY KEY ( MEMBER_LOG_NO );
ALTER TABLE SIGN_OUT_MEMBER ADD CONSTRAINT SIGN_OUT_MEMBER_PK PRIMARY KEY ( SIGN_OUT_NO );
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_PK PRIMARY KEY ( MEMBER_NO );


-- 외래키
-- 로그인
-- 로그인기록(FK)&회원
ALTER TABLE MEMBER_LOG ADD CONSTRAINT MEMBER_LOG_MEMBER_FK
    FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) 
          ON DELETE CASCADE;
          
-- 예약내역
-- 예약(FK)&회원
ALTER TABLE RESERVATION ADD CONSTRAINT RESERVATION_MEMBER_FK
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO); 

-- qna내역
-- qna(FK)&회원
ALTER TABLE QNA ADD CONSTRAINT QNA_MEMBER_FK
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO); 
      
        
-- 트리거 구성
-- MEMBER 테이블의 정보가 삭제되면 SIGN_OUT_MEMBER 테이블로 해당 정보가 저장되는 트리거
CREATE OR REPLACE TRIGGER SIGN_OUT_TRIGGER
    AFTER DELETE
    ON MEMBER
    FOR EACH ROW
BEGIN
    INSERT INTO SIGN_OUT_MEMBER
        (SIGN_OUT_NO, MEMBER_NO, ID, NAME, EMAIL, AGREE_STATE, SIGN_IN)
    VALUES
        (SIGN_OUT_MEMBER_SEQ.NEXTVAL, :OLD.MEMBER_NO, :OLD.MEMBER_ID, :OLD.MEMBER_NAME, :OLD.MEMBER_EMAIL, :OLD.AGREE_STATE, :OLD.SIGN_IN);
END SIGN_OUT_TRIGGER;

