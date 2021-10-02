/*Creating dummy data*/

--The following script creates a dummy database named BookStore with one table i.e. Books. The Books table has four columns: id, name, category, and price:

CREATE Database BookStore;
GO
USE BookStore;
CREATE TABLE Books
(
id INT,
name VARCHAR(50) NOT NULL,
category VARCHAR(50) NOT NULL,
price INT NOT NULL
)

--Let’s now add some dummy records in the Books table:

USE BookStore
GO
INSERT INTO Books
    
VALUES
(1, 'Book1', 'Cat1', 1600),
(2, 'Book2', 'Cat2', 1200),
(3, 'Book3', 'Cat3', 2000),
(4, 'Book4', 'Cat4', 1300),
(5, 'Book5', 'Cat5', 1900),
(6, 'Book6', 'Cat6', 5000),
(7, 'Book7', 'Cat7', 8000),
(8, 'Book8', 'Cat8', 5000),
(9, 'Book9', 'Cat9', 5100),
(10, 'Book10', 'Cat10', 6200)