--1
--a
SET SERVEROUTPUT ON SIZE 1000000
BEGIN
DBMS_OUTPUT.PUT_LINE('Rashikh Ahmad');
END ;
/

--b
DECLARE
ID VARCHAR2 (20) := '210041255';
BEGIN
DBMS_OUTPUT . PUT_LINE ( ' Length of ID is ' || LENGTH (ID));
END ;
/

--c
SET VERIFY OFF
DECLARE
num1 number;
num2 number;
product number;
BEGIN
num1 := '&num1';
num2 := '&num2';
product := num1*num2;
DBMS_OUTPUT.PUT_LINE('The product of ' || num1 || ' and ' || num2 || ' is ' || product);
END ;
/

--d
DECLARE
  D DATE := SYSDATE;
BEGIN
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(D, 'HH12:MI:SS AM'));
END;
/

--e
SET VERIFY OFF
DECLARE
  num NUMBER;
BEGIN
  num:=&num;
  IF TRUNC(num) = num THEN
    DBMS_OUTPUT.PUT_LINE('The number is a whole number (integer).');
  ELSE
    DBMS_OUTPUT.PUT_LINE('The number is a fraction.');
  END IF;
END;
/

--f
CREATE OR REPLACE
PROCEDURE isComposite(num in number, flag out number)
AS
i number :=3;
remainder NUMBER;
BEGIN
if num<=3 
	then flag:=0;
elsif num MOD 2 = 0  
	then flag:=1;
else 
	flag:=0;
	WHILE i * i <= num LOOP
          remainder := num - (num / i) * i;
          IF remainder = 0 
	  THEN flag := 1;
          EXIT;
          END IF;
        i := i + 2; 
       END LOOP;
END IF;
END ;
/
SET SERVEROUTPUT ON
DECLARE
num number;
flag number:=0;
BEGIN
num:=&num;
isComposite(num,flag);
if flag=1 then DBMS_OUTPUT.PUT_LINE('The number is a composite number.');
else DBMS_OUTPUT.PUT_LINE('The number is not a composite number.');
end if;
END;
/


--2
--a
CREATE OR REPLACE PROCEDURE FindTopRatedMovies(N IN NUMBER) IS
movie_count NUMBER;
BEGIN
  IF N <= 0 THEN
    DBMS_OUTPUT.PUT_LINE('error');
    RETURN;
  END IF;

SELECT COUNT(DISTINCT MOV_ID) into movie_count FROM RATING;

IF N>movie_count THEN
    DBMS_OUTPUT.PUT_LINE('error');
    RETURN;
  END IF;

  FOR x IN (
    SELECT *
    FROM (
      SELECT m.mov_id, m.mov_title, m.mov_year, m.mov_language, m.mov_releasedate, m.mov_country, AVG(r.rev_stars) AS avg_rating
      FROM movie m
      JOIN rating r ON m.mov_id = r.mov_id
      GROUP BY m.mov_id, m.mov_title, m.mov_year, m.mov_language, m.mov_releasedate, m.mov_country
      ORDER BY avg(r.rev_stars) DESC
    )
    WHERE ROWNUM <= N
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE('Movie ID: ' || x.mov_id);
    DBMS_OUTPUT.PUT_LINE('Title: ' || x.mov_title);
    DBMS_OUTPUT.PUT_LINE('Year: ' || x.mov_year);
    DBMS_OUTPUT.PUT_LINE('Language: ' || x.mov_language);
    DBMS_OUTPUT.PUT_LINE('Release Date: ' || TO_CHAR(x.mov_releasedate, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Country: ' || x.mov_country);
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
  END LOOP;
END;
/

DECLARE 
N number;
BEGIN
  N:=&N;
  DBMS_OUTPUT.PUT_LINE(N || ' Top rated movie details: ');
  FindTopRatedMovies(N); 
END;
/


--b
CREATE OR REPLACE FUNCTION CheckStatus(title varchar2)
RETURN varchar2
IS
status varchar2(10);
act_count number;
BEGIN
select count(c.act_id) into act_count
from movie m, casts c
where m.mov_id = c.mov_id and m.mov_title = title
group by m.mov_id;
if act_count = 1 then status := 'Solo';
else status := 'Ensemble';
end if;
return status;
END;
/
DECLARE
title varchar2(50);
BEGIN
title:=&title;
DBMS_OUTPUT.PUT_LINE(CheckStatus(title));
END;
/


--c
CREATE OR REPLACE PROCEDURE FindOscarNominees IS
BEGIN
  FOR x IN (
    SELECT d.dir_firstname, d.dir_lastname, r.mov_id, AVG(r.REV_STARS) AS AVG_RATING, COUNT(r.rev_stars) AS reviews
    FROM director d
    JOIN direction dd ON d.dir_id = dd.dir_id
    JOIN rating r ON dd.mov_id = r.mov_id
    GROUP BY d.dir_firstname, d.dir_lastname, r.mov_id
  )
  LOOP
    IF x.AVG_RATING >= 7 AND x.reviews > 10 THEN
      DBMS_OUTPUT.PUT_LINE(x.dir_firstname || ' ' || x.dir_lastname);
    END IF;
  END LOOP;
END;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE('Oscar Nominees: ');
  FindOscarNominees;
END;
/

--d
CREATE OR REPLACE FUNCTION FindMovieCategory(title IN VARCHAR2) 
RETURN VARCHAR2 
IS
  category VARCHAR2(30);
  avg_rating NUMBER := 0;
  year NUMBER := 0;
BEGIN
  SELECT AVG(r.rev_stars), MAX(m.mov_year)
  INTO avg_rating, year
  FROM movie m
  JOIN rating r ON m.mov_id = r.mov_id
  WHERE m.mov_title = title
  GROUP BY m.mov_title;

  IF avg_rating > 6.5 AND year BETWEEN 1950 AND 1959 THEN category := 'Fantastic Fifties';
  ELSIF avg_rating > 6.7 AND year BETWEEN 1960 AND 1969 THEN category := 'Sweet Sixties';
  ELSIF avg_rating > 6.9 AND year BETWEEN 1970 AND 1979 THEN category := 'Super Seventies';
  ELSIF avg_rating > 7.1 AND year BETWEEN 1980 AND 1989 THEN category := 'Ecstatic Eighties';
  ELSIF avg_rating > 7.3 AND year BETWEEN 1990 AND 1999 THEN category := 'Neat Nineties';
  ELSE category := 'Garbage';
  END IF;
  RETURN category;
END;
/

DECLARE
title varchar2(50);
BEGIN
title:=&title;
DBMS_OUTPUT.PUT_LINE('Movie Category: ' || FindMovieCategory(title));
END;
/