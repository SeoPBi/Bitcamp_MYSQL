-- 영어로 된 사람을 추가해보겠습니다.
SELECT * FROM user_tbl;

INSERT INTO user_tbl VALUES
	(null, 'alex', 1986, 'NY', 173, '2020-11-01'),
    (null, 'Smith', 1992, 'Texax', 181, '2020-11-05'),
    (null, 'Emma', 1995, 'Tampa', 168, '2020-12-13'),
    (null, 'Jane', 1996, 'LA', 157, '2020-12-15');
    
-- 문자열 함수를 활용해서, 하나의 컬럼을 여러 형식으로 조회해보겠습니다. 
SELECT 
	user_name,
    UPPER(user_name) AS 대문자유저명,
    LOWER(user_name) AS 소문자유저명,
    LENGTH(user_name) AS 문자길이,
    SUBSTR(user_name, 1, 2) AS 첫글자두번째글자,
    CONCAT(user_name, '회원이 존재합니다.') AS 회원목록
FROM user_tbl;

-- 이름이 글씨가 4글자 이상인 유저만 출력해주세요.
-- LENGTH는 byte 길이 이므로 한글은 한 글자에 3바이트로 간주합니다.
-- 따라서 CHAR_LENGTH()를 이용하면 그냥 글자 숫자로 처리됩니다.
SELECT * FROM user_tbl WHERE CHAR_LENGTH(user_name) > 3;

-- 함수 도움 없이 4글자만 뽑는 방법
SELECT * FROM user_tbl WHERE user_name LIKE "____";

-- 함수 도움 없이 4글자 이상을 뽑는 방법
SELECT * FROM user_tbl WHERE user_name LIKE "____%";



