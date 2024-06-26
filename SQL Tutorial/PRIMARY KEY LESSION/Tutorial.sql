USE [lecongtp_studySQL];  -- SET NƠI TABLE ĐƯỢC TẠO
GO

-- TẠO
CREATE TABLE client (
    UserId VARCHAR(20),
    UserName NVARCHAR(20),
    UserEmail VARCHAR(50),
    UserPassword VARCHAR(50)

    PRIMARY KEY (UserId)
);
GO

CREATE TABLE admin (
    AdminId VARCHAR(20),
    AdminName NVARCHAR(20),
    AdminEmail VARCHAR(50),
    AdminPassword VARCHAR(50)

    PRIMARY KEY (AdminId)
);
GO
-- SỬA
ALTER TABLE client ADD SignInDate date

CREATE TABLE annony (
    annonyId INT NOT NULL,
    annonyName NVARCHAR(20) DEFAULT 'ANNONY CLIENT',
    annonyEmail VARCHAR(50),
    annonyPassword VARCHAR(50)
	
    -- CONSTRAINT PK_annonyId -- XÓA KEY CHO DỄ
);

--XÓA DATA
TRUNCATE TABLE annony

--XÓA TABLE
DROP TABLE annony

CREATE TABLE ticketDetail
(
    Name NVARCHAR(20),
    Detail TEXT,
    UsingDate DATE,
    Quantity INT
)
GO

-- INSERT DATA
INSERT INTO ticketDetail (Name, Detail, UsingDate, Quantity)
VALUES (N'lazada','this is the best selling place','20200223',9);

-- SỬA CỘT
ALTER TABLE ticketDetail ADD Discount INT
ALTER TABLE ticketDetail
ALTER COLUMN Name NVARCHAR(50)
GO

-- DELETE DATA
DELETE ticketDetail WHERE Name = 'pizza hut' --CONDITION

DELETE ticketDetail WHERE Name = 'cgv' AND Quantity = 1

-- UPDATE DATA ALL
UPDATE ticketDetail SET Discount = 40

-- UPDATE DATA SINGLE FIELD 
UPDATE ticketDetail SET Discount = 60 WHERE Name = 'cgv'
UPDATE ticketDetail SET Discount = 20 WHERE Name = 'lazada' AND Quantity = 5

-- CREATE PRIMARY KEY OUTSIDE TABLE
ALTER TABLE annony ADD PRIMARY KEY (annonyId)
ALTER TABLE annony ADD CONSTRAINT PK_2 PRIMARY KEY (annonyName)