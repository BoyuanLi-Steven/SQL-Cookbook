# ################### SQL Cookbook - mac ###################################


# ###################### Create tables #################################
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





#################################### Chapter 1. Retrieving Records ###################################

-- 1.6 Referencing an aliased column in the where clause 
SELECT *
FROM (
			SELECT sal AS salary, comm AS commision
            FROM emp
            ) x
WHERE salary < 5000;

-- 1.7 Concatenating column values 
SELECT CONCAT(ename, 'WORKS AS A', job) AS msg
FROM emp
WHERE deptno = 10;

-- 1.8 Using conditional logic in a select statement 
SELECT ename, sal, 
				CASE WHEN sal <= 2000 THEN 'UNDERPAID'
							WHEN sal >= 4000 THEN 'OVERPAID'
                            ELSE 'OK'
                            END AS status
FROM emp;

-- 1.10 Returning n random records from a table 
SELECT ename, job
FROM emp
ORDER BY RAND()
LIMIT 5;

-- 1.11 Finding null values 
SELECT * 
FROM emp
WHERE comm IS NULL;

-- 1.12 Transforming nulls into real values 
SELECT COALESCE(comm,0)
FROM emp;

SELECT CASE WHEN comm IS NOT NULL THEN comm
						  ELSE 0
                          END 
FROM emp;

-- 1.13 Searching for patterns 
SELECT ename, job 
FROM emp
WHERE deptno IN(10,20)
			  AND (ename LIKE '%I%' OR job LIKE '%ER');
              


################################ Chapter 2 Sorting query results ##################################

-- 2.3 Sorting by substrings 
SELECT ename, job
FROM emp
ORDER BY SUBSTR(job, LENGTH(job)-1);

-- 2.4 Sorting mixed alphanumeric data 
-- Not available 

-- 2.5 Dealing with nulls when sorting 
SELECT ename, sal, comm
FROM emp
ORDER BY 3;

SELECT ename, sal, comm
FROM (
			SELECT ename, sal, comm,
						   CASE WHEN comm IS NULL THEN 0 
                           ELSE 1 
                           END AS is_null
			FROM emp
            ) x
ORDER BY is_null DESC, comm;

SELECT ename, sal, comm
FROM (
			SELECT ename, sal, comm,
						   CASE WHEN comm IS NULL THEN 0 
                           ELSE 1 
                           END AS is_null
			FROM emp
            ) x
ORDER BY is_null DESC, comm DESC;

SELECT ename, sal, comm
FROM (
			SELECT ename, sal, comm,
						   CASE WHEN comm IS NULL THEN 0 
                           ELSE 1 
                           END AS is_null
			FROM emp
            ) x
ORDER BY is_null, comm;

SELECT ename, sal, comm
FROM (
			SELECT ename, sal, comm,
						   CASE WHEN comm IS NULL THEN 0 
                           ELSE 1 
                           END AS is_null
			FROM emp
            ) x
ORDER BY is_null, comm DESC;

-- 2.6 Sorting on a data dependent key

SELECT ename, sal, job, comm
FROM emp
ORDER BY CASE WHEN job = 'SALESMAN' THEN comm 
					ELSE sal
                    END;




#################################### Chapter 3 Working with multiple tables ##################################

-- 3.1 Stacking one rowset atop another 
SELECT ename AS ename_and_dname, deptno
FROM emp
WHERE deptno = 10
UNION ALL 
SELECT '---------------------', NULL 
FROM t1
UNION ALL
SELECT dname, deptno
FROM dept;

-- 3.2 Combining related rows 
SELECT e.ename, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno 
			  AND e.deptno = 10;

SELECT e.ename, d.loc,
			   e.deptno AS emp_deptno,
               d.deptno AS dept_deptno
FROM emp e, dept d
WHERE e.deptno = 10;

SELECT e.ename, d.loc,
			   e.deptno AS emp_deptno,
               d.deptno AS dept_deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno
			  AND e.deptno = 10;

SELECT e.ename, d.loc
FROM emp e
INNER JOIN dept d 
ON e.deptno = d.deptno
WHERE e.deptno = 10;

-- 3.3 Finding rows in common between two tables 
CREATE VIEW V AS 
SELECT ename, job, sal
FROM emp
WHERE job = 'CLERK';

SELECT * 
FROM V;

SELECT e.empno, e.ename, e.job, e.sal, e.deptno
FROM emp e, V 
WHERE e.ename = V.ename
			  AND e.job = V.job 
              AND e.sal = V.sal;

SELECT e.empno, e.ename, e.job, e.sal, e.deptno
FROM emp e
JOIN V 
ON e.ename = V.ename 
	  AND e.job= V.job 
      AND e.sal = V.sal;

-- 3.4 Retrieving values from one table that do not exist in another 












