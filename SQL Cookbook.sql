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


-- 6.1 

-- 6.2 

-- 6.3 

-- 6.4 

-- 6.5 

-- 6.6 

-- 6.7 

-- 6.8 

-- 6.9

-- 6.10 

-- 6.11 

-- 6.12

-- 6.13 

-- 6.14 

-- 6.15


























 