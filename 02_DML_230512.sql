/* 좌측의 SCHEMAS의 DATABASE는 더블클릭이나 우클릭으로도 호출할 수 있지만
usb DB명;을 수행해 호출할 수도 있습니다. */

-- Workbench(윈도우)에서 수행 가능한 구문은 거의 모두 CLI 환경에서 수행 가능합니다.
-- DATABASE 변경 구문;
use sys; -- usebitcamp06;

/* DATABASE 정보 조회 */
show DATABASES;

-- 테이블 생성
CREATE TABLE user_tbl (
	user_num int(5) PRIMARY KEY AUTO_INCREMENT, -- INSERT시 숫자 자동배정
    user_name varchar(10) NOT NULL,
    user_birth_year int NOT NULL,
    user_address char(5) NOT NULL,
    user_height int, -- 자리수 제한 없음
    entry_date date -- 회원가입일
);

/* 특정 테이블은 원래 조회할 떄
SELECT * FROM 데이터베이스명.테이블명;
형식으로 조회해야 합니다.
그러나 use 구문 등을 이용해 데이터베이스를 지정한 경우는 데이터베이스를 생략할 수 있습니다. */
SELECT * FROM bitcamp06.user_tbl;
use bitcamp06;

-- pk가 걸린 컬럼은 NULL을 주면 알아서 숫자 배정
INSERT INTO user_tbl VALUES(null, '김자바', 1987, '서울', 180, '2020-05-03');
INSERT INTO user_tbl VALUES(null, '이연희', 1992, '경기', 164, '2020-05-12');
INSERT INTO user_tbl VALUES(null, '박종현', 1990, '부산', 177, '2020-06-01');
INSERT INTO user_tbl
	(user_name, user_birth_year, user_address, user_height, entry_date)
	VALUE('신영웅', 1995, '광주', 172, '2020-07-15');
    
-- WHERE 조건절을 이용해서 조회 해보겠습니다.
-- 90년대 이후 출생자만 조회하기		user_birth_year가 1989보다 큰 유저만
SELECT * FROM user_tbl WHERE user_birth_year > 1989;

-- 키 175 미만만 조회하는 SELECT 구문을 만들어서 보내주세요.
SELECT * FROM user_tbl WHERE user_height < 175;

-- AND 혹은 OR을 이용해 조건을 두 개 이상 걸수도 있습니다.
SELECT * FROM user_tbl WHERE user_num > 2 OR user_height < 178;

-- UPDATE 테이블명 set 컬럼명1=대입값1, 컬럼명2=대입값2....;
-- 주의! WHERE를 걸지 않으면 해당 컬럼의 모든 값을 다 통일 시켜버립니다.
UPDATE user_tbl SET user_address = '서울'; 

-- WHERE절 없는 UPDATE 구문 실행 방지, 0 대입 시 해제, 1 대입 시 실행
SET SQL_SAFE_UPDATES = 1;     
SELECT * FROM user_tbl;    

-- 테이블이 존재하지 않다면 삭제 구문을 실행하지 않아 에러를 발생시키지 않음
DROP TABLE IF EXISTS user_tbl;

-- 테이블 삭제
DROP TABLE user_tbl;

-- 김자바가 이사를 강원으로 갔습니다. 지역을 서울 -> 강원으로 바꿔보겠습니다.
UPDATE user_tbl SET user_address = '강원' WHERE user_num = 1;
SELECT * FROM user_tbl;

-- 삭제는 특정 컬럼만 떼서 삭제할 일이 없으므로 SELECT와는 달리 * 등을 쓰지 않습니다.
-- 박종현이 DB에서 삭제되는 상황, safety 모드를 우회하거나 CLI에서 실행해주세요.
DELETE FROM user_tbl WHERE user_name = '박종현';

-- 만약 WHERE 없이 삭제 시 truncate와 비슷하게 작동합니다.

-- 다중 INSERT 구문을 사용 해보겠습니다.
/* INSERT INTO 테이블명 (컬럼1, 컬럼2, 컬럼3....)
	VALUES (값1, 값2, 값3 ...),
			(값4, 값5, 값6 ...),
            (값7, 값8, 값9 ...),
            ...;
		컬럼명을 모든 컬럼에 값을 집어넣을 시 생략 가능합니다. */
INSERT INTO user_tbl
	VALUES (null, '강개발', 1994, '경남', 178, '2020-08-02'),
			(null, '최지선', 1998, '전북', 170, '2020-08-03'),
            (null, '류가연', 2000, '전남', 158, '2020-08-20');
SELECT * FROM user_tbl;

-- INSERT~SELECT를 이용한 데이터 삽입을 위해 user_tbl과 동일한 테이블을 하나 더 만듭니다.
CREATE TABLE user_tbl2 (
	user_num int(5) PRIMARY KEY AUTO_INCREMENT, -- INSERT시 숫자 자동배정
    user_name varchar(10) NOT NULL,
    user_birth_year int NOT NULL,
    user_address char(5) NOT NULL,
    user_height int, -- 자리수 제한 없음
    entry_date date -- 회원가입일
);
SELECT * FROM user_tbl2;

-- user_tbl2에 user_tbl의 자료 중 생년 1995년 이후인 사람의 자료만 복사해서 삽입하기
INSERT INTO user_tbl2
	SELECT * FROM user_tbl
    WHERE user_birth_year > 1995;
SELECT * FROM user_tbl2;

-- 두번째 테이블인 구매 내역을 나타내는 buy_tbl을 생성 해보겠습니다.
-- 어떤 유저가 무엇을 샀는지 저장하는 테이블입니다.
-- 어떤 유저는 반드시 user_tbl에 존재하는 유저만 추가할 수 있습니다.
CREATE TABLE buy_tbl (
	buy_num INT AUTO_INCREMENT PRIMARY KEY,
    user_num int(5) NOT NULL,
    prod_name varchar(10) NOT NULL,
    prod_cate varchar(10) NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL
);
SELECT * FROM user_tbl;

-- 외래키 설정 없이 추가해보겠습니다.
INSERT INTO buy_tbl VALUES(null, 4,'아이패드', '전자기기', 100, 1);
INSERT INTO buy_tbl VALUES(null, 4,'애플펜슬', '전자기기', 15, 1);
INSERT INTO buy_tbl VALUES 
	(null, 6,'트레이닝복', '의류', 10, 2),
    (null, 5,'안마의자', '의료기기', 400, 1),
    (null, 2,'SQL책', '도서', 2, 1);

-- 있지도 않은 99번 유저의 구매 내역을 넣어보겠습니다.alter
INSERT INTO buy_tbl values(null, 99, '핵미사일', '전략무기', 100000, 5);
DELETE FROM buy_tbl WHERE buy_num = 12;

-- 이제 외래키 설정을 통해서, 있지 않은 유저는 등록될 수 없도록 처리하겠습니다.
-- buy_tbl이 user_tbl을 참조하는 관계임.
		-- 참조하는											-- 참조자의 어떤 컬럼
ALTER TABLE buy_tbl ADD CONSTRAINT FK_buy_tbl FOREIGN KEY (user_num)
			-- 참조 당하는 테이블과 컬럼명
	REFERENCES user_tbl(user_num);
SET foreign_key_checks = 1; 

-- 참조가 끝난 상태에서 있지도 않은 99번 유저의 구매내역을 넣어보겠습니다.    
INSERT INTO buy_tbl values(null, 99, '오픈카', '승용차', 10000, 5);

SELECT * FROM buy_tbl;
SELECT * FROM user_tbl;
-- 만약 user_num_tbl에 있는 요소를 삭제 시, buy_tbl에 구매내역이 남은 user_num을 삭제한다면
-- 특별히 on_delete를 걸지 않은 경우는 참조 무결성 원칙에 위배되어 삭제가 되지 않습니다.
DELETE FROM user_tbl WHERE user_num = 5;

-- 만약 추가적인 설정 없이 user_tbl의 4번 유저를 삭제하고 싶다면 
-- 먼저 buy_tbl의 4번 유저가 남긴 구매내역을 모두 삭제해야 합니다.
DELETE FROM buy_tbl WHERE buy_num = 1;
DELETE FROM buy_tbl WHERE buy_num = 4;