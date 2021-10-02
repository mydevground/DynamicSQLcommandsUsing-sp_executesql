/* Dynamic SQL commands using "sp_executesql"
sp_executesql stored procedure is used to execute dynamic SQL queries that are in the form of a string. Let’s see this in action
using BookStore database we created.
*/

USE BookStore
GO

--Senario one:
--In the script below, we will declare a variable @SQL_QUERY_ONE and 
--initialize it with a string query that returns the id, name, and 
--price from the Books table where the price is greater than 5,000.

DECLARE @SQL_QUERY_ONE NVARCHAR(128)
SET @SQL_QUERY_ONE = N'SELECT id, name, price FROM Books WHERE price > 5000 '
EXECUTE sp_executesql @SQL_QUERY_ONE


--Senario two:
--Here, the filter or condition can be passed by a user. For instance, 
--a user may search books within a specific search limit. In that case, the SELECT query remains 
--the same, only the WHERE condition is changed. It is convenient to store the WHERE clause in a separate 
--string variable and then concatenate the SELECT condition with the WHERE clause to create the final query. 
--This is shown in the following example:

DECLARE @CONDITION NVARCHAR(128)
DECLARE @SQL_QUERY_TWO NVARCHAR (MAX)
SET @CONDITION = 'WHERE price > 5000'
SET @SQL_QUERY_TWO =N'SELECT id, name, price FROM Books '+ @CONDITION
EXECUTE sp_executesql @SQL_QUERY_TWO

--Senario three:
--You can also pass parameters to the sp_executesql. 
--This is particularly handy when you don’t know the values used to filter records before runtime. 


DECLARE @CONDITION_TWO NVARCHAR(128)
DECLARE @SQL_QUERY_THREE NVARCHAR (MAX)
DECLARE @PARAMS NVARCHAR (1000)
SET @CONDITION_TWO = 'WHERE price > @LowerPrice AND price < @HigherPrice'
SET @SQL_QUERY_THREE = N'SELECT id, name, price FROM Books '+ @CONDITION_TWO
SET @PARAMS = '@LowerPrice INT, @HigherPrice INT'
EXECUTE sp_executesql @SQL_QUERY_THREE ,@PARAMS, @LowerPrice = 3000, @HigherPrice = 6000



--Senario four:
--Using a stored procedure to execute senario three.
--Firstly, we will check if the store procedure name already exist so we drop and recreate, else we create.

DROP PROCEDURE IF EXISTS  dbo.uspGetBooksByPrice;
GO
CREATE PROCEDURE dbo.uspGetBooksByPrice 
@LowerPrice varchar(75),
@HigherPrice varchar(75)
AS
BEGIN
    DECLARE @CONDITION NVARCHAR(128)
	DECLARE @SQL_QUERY NVARCHAR (MAX)
	DECLARE @PARAMS NVARCHAR (1000)
	SET @CONDITION = 'WHERE price > @LowerPrice AND price < @HigherPrice'
	SET @SQL_QUERY = N'SELECT id, name, price FROM Books '+ @CONDITION
	SET @PARAMS = '@LowerPrice INT, @HigherPrice INT'
	EXECUTE sp_executesql @SQL_QUERY ,@PARAMS, @LowerPrice, @HigherPrice
END
GO

 dbo.uspGetBooksByPrice @LowerPrice = 3000, @HigherPrice = 6000


--Note:
--Senario one and two should provide same result
--Senario three and four should provide same result