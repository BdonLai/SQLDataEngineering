--Question 2 (6 Marks)
CREATE TABLE Warehouse(
    WID VARCHAR (6),
    PHONE VARCHAR (11),
    ADDRESS VARCHAR (40),
    STATECODE VARCHAR (6),
    STATENAME VARCHAR (20),
    PRIMARY KEY (WID)
);

CREATE TABLE Customer(
    CUSTID VARCHAR (5),
    CUSTNAME VARCHAR (25),
    EMAIL VARCHAR (25),
    STATECODE VARCHAR (6),
    STATENAME VARCHAR (25),
    PRIMARY KEY (CUSTID)
);

CREATE TABLE Magazine(
    MAGAZINEID VARCHAR (6),
    MAGTITLE VARCHAR (25),
    YEAR NUMERIC(5),
    PRICE NUMERIC (3),
    WID VARCHAR (6),
    AUTHORNAME VARCHAR (45),
    PRIMARY KEY(MAGAZINEID),
    FOREIGN KEY(WID) REFERENCES Warehouse
);

CREATE TABLE ShoppingBasket(
    BASKETID VARCHAR (5),
    MAGAZINEID VARCHAR (6),
    CUSTID VARCHAR (5),
    QUANTITY NUMERIC (2),
    SELLINGPRICE NUMERIC(4),
    PURCHASEDATE DATE,
    PRIMARY KEY (BASKETID),
    FOREIGN KEY (MAGAZINEID) REFERENCES Magazine,
    FOREIGN KEY (CUSTID) REFERENCES Customer
);

--Question 3 (4 Marks)

INSERT INTO Warehouse VALUES('w_001', '082-991246','Jalan Astana, 93050','MY_13','SARAWAK');
INSERT INTO Warehouse VALUES('w_002','03-27206611','Damansara Heights, 52200','MY_14','W.P. KUALA LUMPUR');
INSERT INTO Warehouse VALUES('w_003','088-521916','Jalan Tuaran Batu, 88450','MY_12','SABAH');
INSERT INTO Warehouse VALUES('w_004','03-4210886','Taman Mestika, 56100', 'MY_14','W.P. KUALA LUMPUR');
INSERT INTO Warehouse VALUES('w_005','082-421433','Jalan Pending, 93450','MY_13','SARAWAK');

INSERT INTO Customer VALUES('c_01','John Tan', 'john@gmail.com', 'MY_14', 'W.P. KUALA LUMPUR');
INSERT INTO Customer VALUES('c_02','Mary Lai', 'mlai@gmail.com', 'MY_12','SABAH');
INSERT INTO Customer VALUES('c_03', 'Jane Bennette', 'janeb@gmail.com','MY_13','SARAWAK');
INSERT INTO Customer VALUES('c_04','Mohd Nazim', 'mdm@gmail.com','MY_14','W.P. KUALA LUMPUR');
INSERT INTO Customer VALUES('c_05','Serena Choo', 'schoo@gmail.com','MY_13','SARAWAK');

INSERT INTO Magazine VALUES('B011','Business Insight',2021,33,'w_001','Paul Bennette, Johnson Tay');
INSERT INTO Magazine VALUES('N022','Nature Guide',2017, 57,'w_003','Nazim Karim');
INSERT INTO Magazine VALUES('C059', 'IT Gallery',2020, 25,'w_005','Terry Peri, Mark Tay, Terrence Tim');
INSERT INTO Magazine VALUES('F124','Food Arts', 2021, 19, 'w_003', 'Natasya Kim');
INSERT INTO Magazine VALUES('AP866','Animal Planet', 2018, 50, 'w_004', 'Jason Cordon');
INSERT INTO Magazine VALUES('H557', 'Home Plant',2021, 72, 'w_002', 'Tan Chee Hung');

INSERT INTO ShoppingBasket VALUES('sb11', 'B011','c_02', 3, 52, TO_DATE('2/5/2021', 'DD/MM/YYYY'));
INSERT INTO ShoppingBasket VALUES('sb22','C059','c_03', 2, 36, TO_DATE('1/1/2021','DD/MM/YYYY'));
INSERT INTO ShoppingBasket VALUES('sb33','AP866','c_04', 1, 85, TO_DATE('7/2/2021', 'DD/MM/YYYY'));
INSERT INTO ShoppingBasket VALUES('sb44','F124','c_02', 2, 25, TO_DATE('3/7/2021','DD/MM/YYYY'));
INSERT INTO ShoppingBasket VALUES('sb55','H557', 'c_05', 4, 105, TO_DATE('23/4/2021','DD/MM/YYYY'));
INSERT INTO ShoppingBasket VALUES('sb66','C059','c_01', 3, 36, TO_DATE('2/3/2021','DD/MM/YYYY'));
INSERT INTO ShoppingBasket VALUES('sb77','F124','c_01', 1, 25, TO_DATE('2/3/2021','DD/MM/YYYY'));
INSERT INTO ShoppingBasket VALUES('sb88','C059','c_04', 2, 36, TO_DATE('24/4/2021','DD/MM/YYYY'));
INSERT INTO ShoppingBasket VALUES('sb99','B011','c_01', 4, 52, TO_DATE('30/6/2021', 'DD/MM/YYYY'));


-- Insert into Test Values (TO_DATE('2/5/2021', 'DD/MM/YYYY'));

--Question 4--
SELECT * FROM Magazine WHERE YEAR > 2018
ORDER BY YEAR ASC;

--Question 5--
SELECT STATENAME FROM Warehouse WHERE WID = 'w_001';

--Question 6--
SELECT MAGAZINEID AS "Magazine ID", PURCHASEDATE AS "Purchase Date", (SELLINGPRICE * QUANTITY) AS "Total Sales" FROM ShoppingBasket ORDER BY PURCHASEDATE DESC;


--Question 7--
SELECT MAGAZINEID AS "Magazine ID", REGEXP_COUNT(AUTHORNAME, ',') + 1 AS "Number of Authors" FROM Magazine ORDER BY "Number of Authors" DESC;

--Question 8--
SELECT W.STATENAME,
    COUNT(DISTINCT W.WID) AS "Number of Warehouse", 
    COUNT(DISTINCT C.CUSTID) AS "Number of Customer"
FROM WAREHOUSE W
LEFT JOIN CUSTOMER C ON W.STATENAME = C.STATENAME
GROUP BY W.STATENAME
ORDER BY W.STATENAME;

--Question 9--
SELECT 
    M.MAGAZINEID AS "MAGTITLE",
    SUM(S.SELLINGPRICE * S.QUANTITY - M.PRICE * S.QUANTITY) AS "Total Profit (RM)",
    ROUND((SUM(S.QUANTITY*(S.SELLINGPRICE -M.PRICE))/SUM(M.PRICE * S.QUANTITY)) * 100,2) AS "Profit Percentage"
FROM 
    ShoppingBasket S
JOIN 
    Magazine M ON S.MAGAZINEID = M.MAGAZINEID
GROUP BY 
    M.MAGAZINEID

--Question 10--
SELECT 
    C.STATENAME AS "State Name",
    M.MAGTITLE AS "Magazine Name",
    SUM(S.SELLINGPRICE * S.QUANTITY) AS "TOTALSALE"
FROM 
    ShoppingBasket S
JOIN 
    Magazine M ON S.MAGAZINEID = M.MAGAZINEID
JOIN 
    Customer C ON S.CUSTID = C.CUSTID
GROUP BY 
    M.MAGTITLE, C.STATENAME
ORDER BY 
    C.STATENAME, "TOTALSALE" DESC ;

--Question 11--
SELECT 
    NVL(M.MAGTITLE, 'All magazines') AS "Magazine",
    SUM(S.QUANTITY) AS "Total Quantity Sold"
FROM 
    ShoppingBasket S
JOIN 
    Magazine M ON S.MAGAZINEID = M.MAGAZINEID
GROUP BY 
    ROLLUP(M.MAGTITLE) 
ORDER BY 
    "MAGTITLE" NULLS LAST  

--Question 12--
CREATE TABLE Employee (
    EMPLOYEE_ID INT,
    EMPLOYEE_NAME VARCHAR2(100),
    PRIMARY KEY (EMPLOYEE_ID)  
);
INSERT INTO Employee (EMPLOYEE_ID, EMPLOYEE_NAME) VALUES (1, 'John Doe');
INSERT INTO Employee (EMPLOYEE_ID, EMPLOYEE_NAME) VALUES (2, 'Jane Smith');

INSERT INTO Employee (EMPLOYEE_ID, EMPLOYEE_NAME) VALUES (1, 'Alice Johnson');

--Question 13--
ALTER TABLE ShoppingBasket
MODIFY (SELLINGPRICE NUMBER NOT NULL);


