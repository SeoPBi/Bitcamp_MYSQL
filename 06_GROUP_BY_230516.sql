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



    
    
    
