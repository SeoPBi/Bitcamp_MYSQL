-- 트랜잭션은 2개 이상의 각종 쿼리문의 실행을 되돌리거나 영구히 반영할때 사용합니다.
-- 연습 테이블 생성 
CREATE TABLE bank_account(
	act_num int(5) AUTO_INCREMENT PRIMARY KEY,
    act_owner varchar(10) NOT NULL,
    balance int(10) NOT NULL
);

-- 테이블 조회
SELECT * FROM bank_account;

-- 계좌 데이터 2개를 집어넣어보겠습니다.
INSERT INTO bank_account (balance, act_owner) VALUES 
	(50000, '나구매'),
	(0, '가판매');

-- 트랜잭션 시작(시작점, ROLLBACK;수행 시 이 지점 이후의 내용을 전부 취소합니다.)
-- ctrl + enter로 실행해줘야함
START TRANSACTION;

-- 나구매와 돈 30000원 차감
UPDATE bank_account SET balance = (balance - 30000) WHERE act_owner = '나구매';

-- 가판매의 돈 30000원 증가 
UPDATE bank_account SET balance = (balance + 30000) WHERE act_owner = '가판매';

-- 차감 및 증가 할 경우 세이프 모드 해제 해야됨
set sql_safe_updates = 0; -- 세이프 모드 해제 : 0

-- 알고보니 25000원이어서 되돌리기
ROLLBACK;

-- 테이블 조회
SELECT * FROM bank_account;

-- 25000원으로 다시 차감 및 증가하는 코드를 작성해주시고, 커밋도 해주세요.
START TRANSACTION; -- 이 코드를 먼저 실행하고 요청드린 쿼리문을 작성해서 실행해주세요.
UPDATE bank_account SET balance = (balance - 25000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 25000) WHERE act_owner = '가판매';
COMMIT; -- 커밋을 하면 롤백이 안된다

-- SAVEPOINT는 ROLLBACK 해당 지점 전까지는 반영, 해당 지점 이후는 반영 안하는 경우 사용합니다.
START TRANSACTION;

-- 나구매의 돈 3000원 차감, 가판매의 돈 3000원 증가
UPDATE bank_account SET balance = (balance - 3000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 3000) WHERE act_owner = '가판매';

SAVEPOINT first_tx; -- first_tx라는 저장지점 생성

-- 나구매의 돈 5000원 차감, 가판매의 돈 5000원 증가
UPDATE bank_account SET balance = (balance - 5000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 5000) WHERE act_owner = '가판매';

ROLLBACK to first_tx;


