
# ################### SQL Cookbook ##########################


# ###################### Create tables ####################
USE sqlcookbook;

CREATE TABLE emp (empno INTEGER, ename VARCHAR(10), job VARCHAR(10), 
				  mgr INTEGER, hiredate DATE, sal INTEGER, comm INTEGER,
                  deptno INTEGER);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);


CREATE TABLE dept (deptno INTEGER, dname VARCHAR(10), loc VARCHAR(10));

INSERT INTO dept (deptno, dname, loc)
VALUES (10, 'ACCOUNTING', 'NEW YORK');

INSERT INTO dept (deptno, dname, loc)
VALUES (20, 'RESEARCH', 'DALLAS');

INSERT INTO dept (deptno, dname, loc)
VALUES (30, 'SALES', 'CHICAGO');

INSERT INTO dept (deptno, dname, loc)
VALUES (40, 'OPERATIONS', 'BOSTON');


CREATE TABLE t1 (id INTEGER);

INSERT INTO t1 (id)
VALUES (1);


CREATE TABLE t10 (id INTEGER);

INSERT INTO t10 (id)
VALUES (1);

INSERT INTO t10 (id)
VALUES (2);

INSERT INTO t10 (id)
VALUES (3);

INSERT INTO t10 (id)
VALUES (4);

INSERT INTO t10 (id)
VALUES (5);

INSERT INTO t10 (id)
VALUES (6);

INSERT INTO t10 (id)
VALUES (7);

INSERT INTO t10 (id)
VALUES (8);

INSERT INTO t10 (id)
VALUES (9);

INSERT INTO t10 (id)
VALUES (10);




# ################################ Chapter 1. Retrieving records 

-- 1.1 Retrieving all rows and columns from a table 

SELECT * 
FROM emp;

-- 1.2 Retrieving a subset of rows from a table 

SELECT * 
FROM emp
WHERE deptno=10;

-- 1.3 Finding rows that satisfy multiple conditions 

SELECT * 
FROM emp
WHERE deptno=10 OR comm is not NULL OR sal <= 2000 AND deptno=20;

SELECT * 
FROM emp
WHERE (deptno=10 OR comm is not NULL OR sal <= 2000) AND deptno=20;

-- 1.4 Retrieving a subset of columns from a table 

SELECT ename, deptno, sal
FROM emp;

-- 1.5 Providing meaningful names for columns 
SELECT sal AS salary, comm AS commission
FROM emp;

-- 1.6 Referencing an aliased column in the where clause 
SELECT *
FROM(
	SELECT sal AS salary, comm AS commission
    FROM emp
    ) x
WHERE salary < 5000


-- 1.7 Concatenating column values 
SELECT CONCAT(ename, 'WORK AS A ', job) AS msg
FROM emp
WHERE deptno=10;

-- 1.8 Using conditional logic in a select statement 
SELECT ename, sal,
	CASE WHEN sal <= 2000 THEN 'UNDERPAID'
		 WHEN sal >= 4000 THEN 'OVERPAID'
         ELSE 'OK'
         END AS status 
FROM emp;

-- 1.9 Limiting the number of rows returned 
SELECT *
FROM emp
LIMIT 5;

-- 1.10 Returning n random records from a table 
SELECT ename, job
FROM emp
ORDER BY RAND()
LIMIT 5;

-- 1.11 Finding null values 
SELECT *
FROM emp
WHERE comm is NULL;

-- 1.12 Transforming nulls into real values 
SELECT COALESCE(comm,0)
FROM emp;

SELECT CASE WHEN comm is not NULL THEN comm
			ELSE 0
            END 
FROM emp;

-- 1.13 Searching for patterns 
SELECT ename, job
FROM emp
WHERE deptno in (10, 20) AND (ename LIKE '%I%' OR job LIKE '%ER');



# ################################### Chapter 2. Sorting query results 

-- 2.1 Returning query results in a specified order
SELECT ename, job, sal
FROM emp
WHERE deptno=10
ORDER BY sal ASC;

SELECT ename, job, sal
FROM emp
WHERE deptno=10
ORDER BY 3 DESC;

-- 2.2 Sorting by multiple fields 

SELECT empno, deptno, sal, ename, job
FROM emp
ORDER BY deptno, sal ASC;

-- 2.3 Sorting by substrings 

SELECT ename, job
FROM emp
ORDER BY SUBSTR(job, LENGTH(job)-1);

-- 2.4 Sorting mixed alphanumeric data 
# The TRANSLATE function is not supported in MySQL

-- 2.5 Dealing with nulls when sorting 

SELECT ename, sal, comm
FROM emp
ORDER BY 3;

SELECT ename, sal, comm
FROM emp
ORDER BY 3 DESC;

SELECT ename, sal, comm
FROM (
	SELECT ename, sal, comm,
    CASE WHEN comm is NULL THEN 0
    ELSE 1 
    END AS is_null
    FROM emp)
    x
ORDER BY is_null DESC, comm;

-- 2.6 Sorting on a data dependent key 

SELECT ename, sal, job, comm
FROM emp
ORDER BY 
	CASE WHEN job='SALESMAN' THEN comm 
    ELSE sal 
    END;





# ############################### Chapter 3. Working with multiple tables 

-- 3.1 Stacking one rowset atop another 
SELECT ename AS ename_and_dname, deptno
FROM emp
WHERE deptno=10
UNION ALL
SELECT '--------', null
FROM t1
UNION ALL
SELECT dname, deptno
FROM dept;

SELECT DISTINCT deptno
FROM(
	SELECT deptno
    FROM emp
    UNION ALL
    SELECT deptno
    FROM dept
    );


-- 3.2 Combining related rows

SELECT e.ename, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.deptno = 10;

SELECT e.ename, d.loc
FROM emp e
INNER JOIN dept d
ON (e.deptno = d.deptno)
WHERE e.deptno=10;

-- 3.3 Finding rows in common between two tables 
SELECT e.empno, e.ename, e.job, e.sal, e.deptno
FROM emp e, V
WHERE e.ename = v.ename 
	AND e.job = v.job
    AND e.sal = v.sal;

SELECT e.empno, e.ename, e.job, e.sal, e.deptno
FROM emp e
JOIN V
ON (e.ename = v.ename 
	AND e.job = v.job
    AND e.sal = v.sal
    );
# INTERSECT is not supported in MySQL

-- 3.4 Retrieving values from one table that do no exist in another
SELECT deptno
FROM dept
WHERE deptno NOT IN (
	SELECT deptno
    FROM emp
    );

SELECT DISTINCT deptno
FROM dept
WHERE deptno NOT IN (
	SELECT deptno
    FROM emp
    );

CREATE table new_dept(deptno integer)
insert into new_dept values (10)
insert into new_dept values (50)
insert into new_dept values (null);

# in SQL, TRUE or NULL is TRUE, but FALSE or NULL is NULL

SELECT d.deptno
FROM deptno d
WHERE not EXISTS(
	SELECT 1
    FROM emp e
    WHERE d.deptno = e.deptno
    );
# Correlated subquery means rows from the outer query are referenced in the subquery


-- 3.5 Retrieving rows from one table that do not correspond to rows in another

SELECT d.*
FROM dept d 
LEFT OUTER JOIN emp e
ON (d.deptno = e.deptno)
WHERE e.edptno IS NULL;

-- 3.6 Adding joins to a query without interfering with other joins 

SELECT e.ename, d.loc, eb.received
FROM emp e 
JOIN dept d
ON (e.deptno = d.deptno)
LEFT JOIN emp_bonus eb
ON (e.empno = eb.empno)
ORDER BY 2;

-- 3.7 Determining whether two tables have the same data 

SELECT COUNT(*)
FROM emp
UNION
SELECT COUNT(*)
FROM dept;



SELECT *
FROM (
		SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, COUNT(*) AS cnt
        FROM emp e
        GROUP BY empno, ename, job, mgr, hiredate, sal, comm, deptno
	  ) e
WHERE NOT EXISTS (
		SELECT NULL
        FROM (
				SELECT v.empno, v.ename, v.job, v.mgr, v.hiredate, v.sal, v.comm, v.deptno, COUNT(*) AS cnt
                FROM v
                GROUP BY empno, ename, job, mgr, hiredate, sal, comm, deptno
              ) v
		WHERE v.empno = e.empno AND 
			  v.ename = e.ename AND
              v.job = e.job AND
              v.mgr = e.mgr AND 
              v.hiredate = e.hiredate AND
              v.sal = e.sal AND
              v.deptno = e.deptno AND
              v.cnt = e.cnt AND
              COALESCE(v.comm, 0) = COALESCE(e.comm, 0)
                )
UNION ALL
SELECT *
FROM (
		SELECT v.empno, v.ename, v.job, v.mgr, v.hiredate, v.sal, v.comm, v.deptno, COUNT(*) AS cnt
        FROM v
        GROUP BY empno, ename, job, mgr, hiredate, sal, comm, deptno
	  ) v
WHERE NOT EXISTS (
		SELECT NULL
        FROM (
				SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, COUNT(*) AS cnt
                FROM emp e
                GROUP BY empno, ename, job, mgr, hiredate, sal, comm, deptno
              ) v
		WHERE v.empno = e.empno AND 
			  v.ename = e.ename AND
              v.job = e.job AND
              v.mgr = e.mgr AND 
              v.hiredate = e.hiredate AND
              v.sal = e.sal AND
              v.deptno = e.deptno AND
              v.cnt = e.cnt AND
              COALESCE(v.comm, 0) = COALESCE(e.comm, 0)
                );

-- 3.8 Identifying and avoiding cartesian products 

SELECT e.ename, d.loc
FROM empe e, dept d
WHERE e.deptno = 10 AND d.deptno = e.deptno;


-- 3.9 Performing joins when using aggregates

SELECT deptno, 
	   SUM(DISTINCT sal) AS total_sal,
	   SUM(bonus) AS total_bonus
FROM (
		SELECT e.empno, e.ename, e.sal, e.deptno, e.sal*CASE WHEN eb.type = 1 THEN .1 
															 WHEN eb.type = 2 THEN .2
															 ELSE .3
														END AS bonus
		FROM emp e, emp_bonus eb
		WHERE e.empno = eb.empno AND
			  e.deptno = 10
      ) x
GROUP BY deptno;




SELECT d.deptno,
	   d.total_sal,
       SUM(e.sal*CASE WHEN eb.type = 1 THEN .1
					  WHEN eb.type = 2 THEN .2
                      ELSE .3 END ) AS total_bonus 
FROM emp e, 
	 emp_bonus eb,
	(	SELECT deptno, SUM(sal) AS total_sal
		FROM emp
		WHERE deptno = 10
		GROUP BY deptno
	) d 
WHERE e.deptno = d.deptno AND
	  e.empno = eb.empno
GROUP BY d.deptno, d.total_sal;


-- 3.10 Performing outer joins when using aggregates


SELECT deptno,
	   SUM(DISTINCT sal) AS total_sal,
       SUM(bonus) AS total_bonus
FROM (
		SELECT e.empno,
			   e.ename,
			   e.sal,
			   e.deptno,
			   e.sal*CASE WHEN eb.type IS NULL THEN 0
						  WHEN eb.type = 1 THEN .1
						  WHEN eb.type = 2 THEN .2
						  ELSE .3
					 END AS bonus
		FROM emp e 
		LEFT OUTER JOIN emp_bonus 
		ON (e.empno = eb.empno)
        WHERE e.deptno = 10
	  )
GROUP BY deptno;


SELECT DISTINCT deptno, total_sal, total_bonus
FROM (
		SELECT e.empno,
			   e.ename,
			   SUM(DISTINCT e.sal) OVER (PARTITION BY e.deptno) AS total_sal,
			   e.deptno,
			   SUM(e.sal*CASE WHEN eb.type IS NULL THEN  0
							  WHEN eb.type = 1 THEN .1
							  WHEN eb.type = 2 THEN .2
							  ELSE .3
						 END) OVER (PARTITION BY deptno) AS total_bonus
		FROM emp e 
		LEFT OUTER JOIN emp_bonus eb 
		ON (e.empno = eb.empno)
		WHERE e.deptno = 10
	  ) x;



SELECT d.deptno,
	   d.total_sal,
       SUM(e.sal*CASE WHEN eb.type = 1 THEN .1
					  WHEN eb.type = 2 THEN .2
                      ELSE .3
                      END) AS total_bonus
FROM emp e, 
	 emp_bonus eb,
     (
		SELECT deptno, SUM(sal) AS total_sal
		FROM emp
		WHERE deptno = 10
		GROUP BY deptno
	  ) d
WHERE e.deptno = d.deptno AND
	  e.empno = eb.empno
GROUP BY d.deptno, d.total_sal;


-- 3.11 Returning missing data from multiple tables 

SELECT d.deptno, d.dname, e.ename
FROM dept d 
RIGHT OUTER JOIN emp e
ON(d.deptno = e.deptno)
UNION 
SELECT d.deptno, d.dname, e.ename
FROM dept d 
LEFT OUTER JOIN emp e
ON(d.deptno = e.deptno);


-- 3.12 Using NULLs in operations and comparisons

SELECT ename, comm, COALESCE(comm, 0)
FROM emp
WHERE COALESCE(comm, 0) < (SELECT comm
						   FROM emp
						   WHERE ename = 'WARD');





# ############################## Chapter 4. Inserting, Updating, Deleting


-- 4.1 Inserting a new record 

INSERT INTO dept ( deptno, dname, loc)
VALUES (50, 'PROGRAMMING', 'BALTIMORE');

INSERT INTO dept (deptno, dname, loc)
VALUES (1, 'A', 'B'),
	   (2, 'B', 'C');
       
-- 4.2 Inserting default values 

CREATE TABLE D (id INTEGER DEFAULT 0);

INSERT INTO D (id)
VALUES (DEFAULT);

INSERT INTO D 
VALUES();

CREATE TABLE D (id INTEGER DEFAULT 0, foo VARCHAR(10));

INSERT INTO D (name) 
VALUES ('Bar');


-- 4.3 Overriding a default value with NULL
CREATE TABLE D (id INTEGER DEFAULT 0, foo VARCHAR(10));

INSERT INTO D (id, foo) 
VALUES (NULL, 'Brighten');

-- 4.4 Copying rows from one table into another 
INSERT INTO dept_east (deptno, dname, loc)
SELECT deptno, dname, loc
FROM dept 
WHERE loc IN ('NEW YORK', 'BOSTON');

-- 4.5 Copying a table definition
CREATE TABLE dept_2
AS
SELECT * 
FROM dept
WHERE 1 = 0;

-- 4.6 Inserting into multiple tables at onece
# not supported in MySQL

-- 4.7 Blocking inserts to certain columns 
CREATE VIEW new_emps 
AS
SELECT empno, ename, job
FROM emp;

-- 4.8 Modifying records in a table 
SELECT deptno, ename, sal
FROM emp
WHERE deptno = 20
ORDER BY 1,3;

UPDATE emp
SET sal = sal * 1.10
WHERE deptno = 20;

SELECT deptno,
	   ename, 
       sal AS orig_sal,
       sal * .10 AS amt_to_add,
       sal * 1.10 AS new_sal
FROM emp
WHERE deptno = 20
ORDER BY 1,5;

-- 4.9 Updating when corresponding rows exist
UPDATE emp
SET sal = sal * 1.20
WHERE empno IN (SELECT empno
				FROM emp_bonus);
                
UPDATE emp
SET sal = sal * 1.20
WHERE EXISTS( SELECT NULL
			  FROM emp_bonus
              WHERE emp.empno = emp_bonus.empno);


-- 4.10 Updating with values from another table
UPDATE emp e, new_sal ns 
SET e.sal = ns.sal,
	e.comm = ns.sal / 2
WHERE e.deptno = ns.deptno;

-- 4.11 Merging records 
# MERGE is not supported in MySQL

-- 4.12 Deleting all records from a table 
DELETE 
FROM emp;

-- 4.13 Deleting specific records 
DELETE 
FROM emp
WHERE deptno = 10;

-- 4.14 Deleting a single record
DELETE 
FROM emp
WHERE empno = 7782;

-- 4.15 Deleting referential integrity violations
DELETE 
FROM emp
WHERE NOT EXISTS (  SELECT * 
                    FROM dept
                    WHERE dept.deptno = emp.deptno);
                    
DELETE 
FROM emp
WHERE deptno NOT IN (SELECT deptno 
					 FROM dept);

-- 4.16 Deleting duplicate records 
DELETE 
FROM dupes 
WHERE id NOT IN (SELECT MIN(id)
				 FROM(SELECT id, name
					  FROM dupes) tmp
				 GROUP BY name);

-- 4.17 Deleting records referenced from another table 
DELETE 
FROM emp
WHERE deptno IN (SELECT deptno 
				 FROM dept_accidents
                 GROUP BY deptno
                 HAVING COUNT(*) >= 3);





# ################################## Chapter 5. Metadata Queries 


-- 5.1 Listing tables in a Schema
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'SMEAGOL';

-- 5.2 Listing a table's columns 
SELECT column_name, data_type, ordinal_position
FROM information_schema.columns
WHERE table_schema = 'SMEAGOL' AND
	  table_name = 'EMP';

-- 5.3 Listing indexed columns for a table
SHOW INDEX FROM emp;

-- 5.4 Listing constraints on a table 
SELECT a.table_name,
	   a.constraint_name,
       b.column_name,
       a.constraint_type
FROM information_schema.table_constraints a,
	 information_schema.key_column_usage b
WHERE a.table_name = 'EMP' AND 
	  a.table_schema = 'SMEAGOL' AND
      a.table_name = b.table_name AND 
      a.table_schema = b.table_schema AND 
      a.constraint_name = b.constraint_name;

-- 5.5 Listing foreign keys without corresponding indexes
SHOW INDEX FROM emp;

-- 5.6 Using SQL to generate SQL

-- 5.7 Describing the data dictionary views in an oracle database 
 




# ################################# Chapter 6. Working with Strings 


-- 6.1 Walking a string 

SELECT SUBSTR(e.ename, iter.pos,1) AS C
FROM 
		(SELECT ename 
		 FROM emp
		 WHERE ename = 'KING') e,
		(SELECT id AS pos
         FROM t10) iter
WHERE iter.pos <= length(e.ename);


SELECT SUBSTR(e.ename, iter.pos) a,
	   SUBSTR(e.ename, LENGTH(e.ename) - iter.pos + 1) b
FROM (
		SELECT ename
        FROM emp
        WHERE ename = 'KING') e,
	 ( SELECT id pos
	   FROM t10) iter
WHERE iter.pos <= LENGTH(e.ename);

-- 6.2 Embedding quotes within string literals 
SELECT 'g''day mate' qmarks 
FROM t1 
UNION ALL
SELECT 'beavers''teeth' 
FROM t1 
UNION ALL 
SELECT ''''
FROM t1;

SELECT 'apple core','apple''s core', CASE WHEN '' is NULL THEN 0 ELSE 1 END
FROM t1;

SELECT '''' AS quote 
FROM t1;

-- 6.3 Counting the occurrences of a character in a string 

SELECT (LENGTH('10, CLARK, MANAGER') - 
		LENGTH(REPLACE('10,CLARK,MANAGER',',','')))/LENGTH(',') AS cnt
FROM t1;

SELECT 
		(LENGTH('HELLO HELLO') - 
		 LENGTH(REPLACE('HELLO HELLO','LL','')))/LENGTH('LL')
         AS correct_cnt,
		(LENGTH('HELLO HELLO') - 
         LENGTH(REPLACE('HELLO HELLO','LL',''))) 
         AS incorrect_cnt;

-- 6.4 Removing unwanted characters from a string 
SELECT ename, 
	   REPLACE(
       REPLACE(
       REPLACE(
       REPLACE(
       REPLACE(ename, 'A',''),'E',''),'I',''),'O',''),'U','')
       AS stripped1,
       sal,
       REPLACE(sal,0,'') AS stripped2
FROM emp;

-- 6.5 Separating numeric and character data
# TRANSLATE is not supported in MySQL

-- 6.6 Determining whether a string is alphanumeric
CREATE VIEW V AS
SELECT ename AS data
FROM emp
WHERE deptno = 10
UNION ALL
SELECT CONCAT(ename, ',$',sal,'.00') AS data
FROM emp
WHERE deptno = 20
UNION ALL
SELECT CONCAT(ename, deptno) AS data
FROM emp
WHERE deptno = 30;

SELECT data 
FROM V
WHERE data REGEXP '[^0-9a-zA-Z]' = 0;


-- 6.7 Extracting initials from a name 

SELECT CASE 
	   WHEN cnt = 2
       THEN TRIM(TRAILING '.' 
				 FROM CONCAT_WS('.',
								SUBSTR(SUBSTRNG_INDEX(name,'',1),1,1),
                                SUBSTR(name, 
									   LENGTH(SUNSTRING_INDEX(name, '',-1),1,1),'.'))
		ELSE TRIM(TRAILING '.'
				  FROM CONCAT_WS('.',
								 SUBSTR(SUBSTRING_INDEX(name, '',1),1,1),
                                 SUBSTR(SUBSTRING_INDEX(name, '',-1),1,1)))
		END AS initials
FROM (
		SELECT name, LENGTH(name)-LENGTH(REPLACE(name, '','')) AS cnt
        FROM (SELECT REPLACE('Stewie Griffin','.','') AS name
			  FROM t1) y
	  ) x;

-- 6.8 Ordering by parts of a string 

SELECT ename
FROM emp
ORDER BY SUBSTR(ename, LENGTH(ename)-1);

-- 6.9 Ordering by a number in s string 
# TRANSLATE is not supported in MySQL

-- 6.10 Creating a delimited list from table rows
SELECT deptno,
	   GROUP_CONCAT(ename ORDER BY empno SEPARATOR ',') AS emps
FROM emp
GROUP BY deptno;

-- 6.11 Converting delimited data into a multi-valued IN-list
SELECT ename, sal, deptno
FROM emp
WHERE empno IN ('7654, 7698, 7782, 7788');

SELECT empno, ename, sal, deptno
FROM emp
WHERE emp IN(
			  SELECT SUBSTRING_INDEX(
					 SUBSTRING_INDEX(list.vals, ',', iter.pos),',',-1) empno
			  FROM(SELECT id pos 
				   FROM t10) AS iter,
				  (SELECT '7654, 7698, 7782, 7788' AS vals
                   FROM t1) list
			  WHERE iter.pos <= (LENGTH(list.vals) - LENGTH(REPLACE(list.vals,',','')))+1
		     );


-- 6.12 Alphabetizing a string 
SELECT ename, 
	   GROUP_CONCAT(c ORDER BY c SEPARATOR '')
FROM( SELECT ename, 
			 SUBSTR(a.ename, iter.pos, 1) c
	  FROM emp a,
           (SELECT id pos 
            FROM t10) iter
	  WHERE iter.pos <= LENGTH(a.ename)
      ) x
GROUP BY ename;

-- 6.13 Identifying strings that can be treated as numbers 
CREATE view V as
SELECT CONCAT(SUBSTR(ename, 1, 2), 
			  REPLACE(CAST(deptno AS CHAR(4)), '',''),
              SUBSTR(ename, 3,2)
              ) AS mixed
FROM emp
WHERE deptno = 10
UNION ALL
SELECT REPLACE(CAST(empno AS CHAR(4)),'','')
FROM emp
WHERE deptno = 20
UNION ALL
SELECT ename
FROM emp
WHERE deptno = 30;

# MySQL does not support the TRANSLATE function

SELECT CAST(GROUP_CONCAT(c ORDER BY pos SEPARATOR '') AS unsigned) AS MIXED1
FROM (
		SELECT v.mixed, iter.pos, SUBSTR(v.mixed, iter.pos, 1) AS c
        FROM V,
			(SELECT id pos 
             FROM t10) iter
		WHERE iter.pos <= LENGTH(v.mixed) AND
			  ASCII(SUBSTR(v.mixed, iter.pos,1)) BETWEEN 48 AND 57
		) y
GROUP BY mixed
ORDER BY 1;

-- 6.14 Extracting the nth delimited substring 
SELECT name
FROM (
		SELECT iter.pos,
			   SUBSTRING_INDEX(
								SUBSTRING_INDEX(src.name, ',', iter.pos),','-1) name
		FROM V src,
			 (SELECT id pos
			  FROM t10) iter
		WHERE iter.pos <= LENGTH(scr.name) - LENGTH(REPLACE(scr.name,',',''))
	 ) x
WHERE pos = 2;

-- 6.15 Parsing an IP address
SELECT  SUBSTRING_INDEX(SUBSTRING_INDEX(y.ip,'.',1),'.',-1) a,
		SUBSTRING_INDEX(SUBSTRING_INDEX(y.ip,'.',2),'.',-1) b,
		SUBSTRING_INDEX(SUBSTRING_INDEX(y.ip,'.',3),'.',-1) c,
		SUBSTRING_INDEX(SUBSTRING_INDEX(y.ip,'.',4),'.',-1) d
FROM (SELECT '92.111.0.2' AS ip
	  FROM t1) y;





# ########################### Chapter 7. Working with Numbers 

-- 7.1 Computing an average
SELECT AVG(sal) AS avg_sal
FROM emp;

SELECT deptno, AVG(sal) AS avg_sal
FROM emp
GROUP BY deptno;

SELECT AVG(sal)
FROM emp
GROUP BY deptno;

-- 7.2 Finding the Min/Max value in a column
SELECT MIN(sal) AS min_sal, MAX(sal) AS max_sal
FROM emp;

SELECT deptno, MIN(sal) AS min_sal, MAX(sal) AS max_sal
FROM emp
GROUP BY deptno;

SELECT deptno, comm
FROM emp
WHERE deptno IN(10,30)
ORDER BY 1;

SELECT MIN(comm), MAX(comm)
FROM emp;

SELECT deptno, MIN(comm), MAX(comm)
FROM emp
GROUP BY deptno;

-- 7.3 Summing the values in a column
SELECT SUM(sal)
FROM emp;

SELECT deptno, SUM(sal) AS total_for_dept
FROM emp
GROUP BY deptno;

SELECT deptno, comm
FROM emp
WHERE deptno IN(10,30)
ORDER BY 1;

SELECT SUM(comm)
FROM emp;

SELECT deptno, SUM(comm)
FROM emp
WHERE deptno IN(10,30)
GROUP BY deptno;


-- 7.4 Counting rows in a table
SELECT COUNT(*)
FROM emp;

SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

SELECT deptno, comm
FROM emp;

SELECT COUNT(*), COUNT(deptno), COUNT(comm), COUNT('hello')
FROM emp;

SELECT deptno, COUNT(*), COUNT(comm), COUNT('hello')
FROM emp
GROUP BY deptno;

SELECT COUNT(*) 
FROM emp
GROUP BY deptno;

-- 7.5 Counting values in a column 
SELECT COUNT(comm)
FROM emp;

-- 7.6 Generating a running total
SELECT e.ename, e.sal,
	   (SELECT SUM(d.sal) 
        FROM emp d
        WHERE d.empno <= e.empno) AS running_total
FROM emp e 
ORDER BY 3;

SELECT ename, sal, SUM(sal) OVER
FROM emp
ORDER BY 2;

SELECT empno, sal,
	   SUM(sal) OVER(ORDER BY sal, empno) AS running_total1,
       SUM(sal) OVER(ORDER BY sal) AS running_total2
FROM emp
ORDER BY 2;

-- 7.7 Generating a running product

SELECT e.empno, e.ename, e.sal,
		(SELECT EXP(SUM(LN(d.sal)))
         FROM emp d
         WHERE d.empno <= e.empno AND 
               e.deptno = d.deptno) AS running_prod
FROM emp e 
WHERE e.deptno = 10;

-- 7.8 Calculating a running difference 
SELECT a.empno, a.ename, a.sal,
		(SELECT CASE WHEN a.empno = MIN(b.empno) THEN SUM(b.sal) 
				ELSE SUM(-b.sal)
                END
		 FROM emp b
         WHERE b.empno <= a.empno AND 
			   b.deptno = a.deptno) AS rnk
FROM emp a 
WHERE a.deptno = 10;

-- 7.9 Calculating a mode
SELECT sal
FROM emp
WHERE deptno = 20
GROUP BY sal
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM emp
                       WHERE deptno = 20
                       GROUP BY sal);

-- 7.10 Calculating a median
SELECT AVG(sal)
FROM ( SELECT e.sal
	   FROM emp e, emp d
       WHERE e.deptno = d.deptno AND
       e.deptno = 20
       GROUP BY e.sal
       HAVING SUM(CASE WHEN e.sal = d.sal 
				  THEN 1 ELSE 0 END) >= ABS(SUM(SIGN(e.sal - d.sal)))
	 );

-- 7.11 Determining the percentage of a total
SELECT (
		SUM(CASE WHEN deptno = 10 THEN sal END)/SUM(sal)
        ) * 100 AS pct
FROM emp;

-- 7.12 Aggregating nullable columns 
SELECT AVG(COALESCE(comm, 0)) AS avg_comm
FROM emp
WHERE deptno = 30;

-- 7.13 Computing averages without high and low values
SELECT AVG(sal)
FROM emp
WHERE sal NOT IN(
					SELECT MIN(sal) FROM emp,
                    SELECT MAX(sal) FROM emp
				);

SELECT (SUM(sal) - MIN(sal) - MAX(sal)) / (COUNT(*)-2)
FROM emp;

-- 7.14 Converting alphanumeric strings into numbers
# TRANSLATE function is not supported in MySQL

-- 7.15 Changing values in a running total
SELECT CASE WHEN v1.trx = 'PY'
			THEN 'PAYMENT'
            ELSE 'PURCHASE'
            END AS trx_type,
		v1.amt, 
        (SELECT SUM(CASE WHEN v2.trx = 'PY'
						 THEN -v2.amt 
                         ELSE v2.amt
                         END)
		 FROM V v2
         WHERE v2.id <= v1.id) AS balance 
FROM V v1;




# ######################## Chapter 8. Date Arithmetic

-- 8.1 Adding and subtracting days, months, and years
SELECT hiredate - INTERVAL 5 DAY AS hd_minus_5D,
	   hiredate + INTERVAL 5 DAY AS hd_plus_5D,
       hiredate - INTERVAL 5 MONTH AS hd_minus_5M,
       hiredate + INTERVAL 5 MONTH AS hd_plus_5M,
       hiredate - INTERVAL 5 YEAR AS hd_minus_5Y,
       hiredate + INTERVAL 5 YEAR AS hd_plus_5Y
FROM emp
WHERE deptno = 10;


SELECT DATE_ADD(hiredate, INTERVAL -5 DAY) AS hd_minus_5D,
	   DATE_ADD(hiredate, INTERVAL 5 DAY) AS hd_plus_5D, 
       DATE_ADD(hiredate, INTERVAL -5 MONTH) AS hd_minus_5M,
       DATE_ADD(hiredate, INTERVAL 5 MONTH) AS hd_plus_5M,
       DATE_ADD(hiredate, INTERVAL -5 YEAR) AS hd_minus_5Y,
       DATE_ADD(hiredate, INTERVAL 5 YEAR) AS hd_plus_5Y
FROM emp
WHERE deptno = 10;


-- 8.2 Determining the number of days between two dates 
SELECT DATEDIFF(ward_hd, allen_hd)
FROM (
		SELECT hiredate AS ward_hd
        FROM emp
        WHERE ename = 'WARD'
	  ) x,
      (	SELECT hiredate AS allen_hd
		FROM emp
        WHERE ename = 'ALLEN'
	   ) y;

-- 8.3 Determining the number of business days between two dates 
SELECT SUM(CASE WHEN DATE_FORMAT(DATE_ADD(jones_hd, INTERVAL t500.id - 1 DAY), '%a') 
				IN ('Sat', 'Sun')
                THEN 0 ELSE 1
                END) AS days
FROM ( SELECT MAX(CASE WHEN ename = 'BLAKE'
					   THEN hiredate
                       END) AS blake_hd,
			  MAX(CASE WHEN ename = 'JONES'
					   THEN hiredate
                       END) AS jones_hd
		FROM emp
        WHERE ename IN ('BLAKE' , 'JONES') ) x,
		t500
WHERE t500.id <= DATEDIFF(black_hd, jones_hd) + 1;


-- 8.4 Determining the number of months or years between two dates
SELECT mnth, mnth/12
FROM ( SELECT (YEAR(max_hd) - YEAR(min_hd)) * 12 + 
			  (MONTH(max_hd) - MONTH(min_hd)) AS mnth
	   FROM ( SELECT MIN(hiredate) AS min_hd,
					 MAX(hiredate) As max_hd
			  FROM emp
			 ) x
	  ) y;
      
-- 8.5 Determining the number of seconds, minutes, or hours between two dates

SELECT DATEDIFF(ward_hd, allen_hd) * 24 hr,
	   DATEDIFF(ward_hd, allen_hd) * 24 * 60 min,
       DATEDIFF(ward_hd, allen_hd) * 24 * 60 * 60 sec
FROM (
		SELECT MAX(CASE WHEN ename = 'WARD' 
						THEN hiredate
                        END ) AS ward_hd,
			   MAX(CASE WHEN ename = 'ALLEN'
						THEN hiredate
                        END ) AS allen_hd
		 FROM emp) x;

-- 8.6 Counting the occurrences of weekdays in a year

SELECT DATE_FORMAT(
	   DATE_ADD(
       CAST(CONCAT(YEAR(current_date),'-01-01' ) AS date), 
													INTERVAL t500.id-1 DAY), 
                                                    '%W') DAY,
       COUNT(*)
FROM t500
WHERE t500.id <= DATEDIFF(
							CAST(
                            CONCAT(YEAR(current_date) + 1, '-01-01') AS date),
							CAST(
                            CONCAT(YEAR(current_date), '-01-01') AS date))
GROUP BY DATE_FORMAT(
		 DATE_ADD(
         CAST(
         CONCAT(YEAR(current_date),'-01-01') AS date), INTERVAL t500.id-1 DAY),'%W');


-- 8.7 Determining the date difference between the current record and the next record 

SELECT x.*,
	   DATEDIFF(x.next_hd, x.hiredate) diff
FROM (
		SELECT e.deptno, e.ename, e.hiredate,
			   (SELECT MIN(d.hiredate) 
                FROM emp d 
                WHERE d.hiredate > e.hiredate) next_hd
		FROM emp e
        WHERE e.deptno = 10) x;
        




# #################### Chapter 9. Date Manipulation 

-- 9.1 

-- 9.2 

-- 9.3 

-- 9.4 

-- 9.5 

-- 9.6 

-- 9.7 

-- 9.8 

-- 9.9

-- 9.10

-- 9.11

-- 9.12

-- 9.13























 













