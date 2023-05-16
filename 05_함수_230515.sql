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

-- user_tbl에 소수점 아래를 저장 받을수 있는 컬럼을 추가해보겠습니다.
-- DECIMAL은 고정 자리수 이므로 반드시 소수점 아래 2자리까지 표시해야 합니다.
-- 전체 3자리 중 소수점 아래에 두 자리를 배정하겠다.
ALTER TABLE user_tbl ADD (user_weight DECIMAL(3, 2));
ALTER TABLE user_tbl MODIFY user_weight DECIMAL(5, 2);

SELECT * FROM user_tbl;

UPDATE user_tbl SET user_weight = 75.29 WHERE user_num = 15;

-- 숫자 함수 사용 예제
SELECT
	user_name, user_weight,
    ROUND(user_weight, 0) AS 반올림,
    TRUNCATE(user_weight, 1) AS 소수점아래_1자리절사,
    MOD(user_height, 150) AS 키_150으로나눈나머지,
	CEIL(user_weight) AS 키올림,
    FLOOR(user_weight) AS 키내림,
    SIGN(user_weight) AS 양수음수_0여부,
    SQRT(user_height) AS 키_제곱근
FROM
	user_tbl;

-- USER_tbl의 날짜를 확인합니다.
SELECT * FROM user_tbl;

-- 날짜함수를 활용한 예제
SELECT 
	user_name, entry_date,
    DATE_ADD(entry_date, INTERVAL 3 MONTH) AS _3개월후,
	LAST_DAY(entry_date) AS 해당월마지막날짜,
    TIMESTAMPDIFF(MONTH, entry_date, now()) AS 오늘과의개월수차이
FROM
    user_tbl;

-- 현재 시각을 조회하는 구문
SELECT now();

SELECT * FROM user_tbl;
-- 변환함수를 활용한 예제
SELECT
	user_num, user_name, entry_date,
    DATE_FORMAT(entry_date, '%Y-%m-%d') AS 일자표현변경,
    CAST(user_num AS CHAR) AS 문자로바꾼회원번호
FROM
	user_tbl;
    
-- user_height, user_weight이 NULL인 자료를 추가해보겠습니다.
INSERT INTO user_tbl VALUES(null, '임쿼리', 1986, '제주', null, '2021-01-03', null);

SELECT * FROM user_tbl;

-- NULL에다가 특정 숫자 곱하기
SELECT 0 * NULL; -- 일반직군
SELECT 10000000 * 0.1; -- 영업직군

-- 최종수령금액은 기본급 + 인센
SELECT null + 5000000;
SELECT 1000000 + 5000000;

-- user_tbl
SELECT * FROM user_tbl;

-- ifnull()을 이용해서 특정 컬럼이 null인 경우 대체값으로 표현하는 예제
SELECT
	user_name, 
    ifnull(user_height, 167) as _null대체값넣은키,
    ifnull(user_weight, 65) as _null대체값넣은체중
FROM
	user_tbl;
    
-- SQL에서 0으로 나누면 무슨일이 벌어지는지 보겠습니다.
SELECT 3/0;

-- user_tbl의 회원들 중 키 기준으로 
-- 165 미만은 평균 미만, 165는 평균, 165이상은 평균 이상으로 출력해보겠습니다.
SELECT 
	user_name,
    user_height,
    CASE
		WHEN user_height < 164 THEN '평균미만'
        WHEN user_height = 164 THEN '평균'
        WHEN user_height > 164 THEN '평균이상'
	END AS 키분류,
    user_weight 
FROM user_tbl;

-- 문제
-- user_tbl에 대해서, BMT지수를 구해주세요.
-- BMI지수는 (체중 / 키제곱)으로 구할 수 있습니다.
-- BMI 지수의 결과를 8미만이면 '저체중', 18 ~ 24면 '일반체중', 25이상이면 '고체중'으로 
-- CASE구문을 이용해서 출력해주세요.
-- BMI 지수를 나타내는 컬럼은 BMI_RESULT이고, BMI분류룰 나타내는 컬럼은 BMI_CASE입니다.
 SELECT
	user_name, 	user_height, user_weight,
    user_weight /  (user_height/100 * user_height/100) as BMI_RESULT,
    CASE
		WHEN user_weight /  (user_height/100 * user_height/100) < 18 THEN '저체중'
        WHEN user_weight /  (user_height/100 * user_height/100) BETWEEN 18 AND 24 THEN '평균' 
        WHEN user_weight /  (user_height/100 * user_height/100) > 24 THEN '고체중' 
	END AS BMI_CASE
FROM user_tbl;

-- GROUP BY는 기준 컬럼을 하나 이상 제시할 수 있고, 기준 컬럼에서 동일한 값을 가지는 것 끼리
-- 같은 집단으로 보고 집계하는 쿼리문입니다.
-- SELECT 집계컬렴명 FROM 테이블명 GROUP BY 기준컬럼명;

-- 지역별 평균 키를 구해보겠습니다.(지역정보 : user_address)
SELECT 
	user_address AS 지역명,
	AVG(user_height) AS 평균키
FROM 
	user_tbl
GROUP BY
	user_address;
    
SELECT * FROM user_tbl; -- 조회
-- 생년별 체중 평균을 구해주세요.
-- 생년, 체중평균 컬럼이 노출되어야 합니다.
SELECT 
	user_birth_year AS 생년월일,
    COUNT(user_num) AS 인원수, -- COUNT는 컬럼 내부의 열 개수만 세기 때문에 어떤 컬럼을 넣어도 동일합니다.
	AVG(user_weight) AS 체중평균
FROM 
	user_tbl
GROUP BY
	user_birth_year;
	
-- user_tbl의 가장 큰 키, 가장 빠른 출생년도가 각각 무슨 값인지 구해주세요.
SELECT
	MAX(user_height) AS 가장큰키,
    MIN(user_birth_year) AS 가장빠출
FROM 
	user_tbl;

-- HAVING을 써서 거주자가 2명 이상인 지역만 카운팅
-- 거주지별 생년평균을 보여주겠습니다.
SELECT
	user_address,
    AVG(user_birth_year) as 생년평균,
    COUNT(*) as 거주자수
FROM
	user_tbl
GROUP BY
	user_address
HAVING
	COUNT(*) > 1;

-- HAVING 사용 문제
-- 생년 기준으로 평균 키가 160 이상인 생년만 출력해주세요.
-- 생년별 평균 키도 같이 출력해주세요.
SELECT
	user_birth_year,
	AVG(user_height) as 평균키
FROM
	user_tbl
GROUP BY
	user_birth_year
HAVING
	AVG(user_height) >= 160;
    
    
    
    
    