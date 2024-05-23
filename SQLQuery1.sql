CREATE DATABASE ONLINEAUCTION;

--creation of Bank table--
CREATE TABLE Bank(
Bank_No char(5),
BankName varchar(20) NOT NULL,
branchName varchar(20),
CONSTRAINT pk_Bank PRIMARY KEY (Bank_No)
);

--creation of Member table--
CREATE TABLE Member(
 MemberID varchar(10),
 Name varchar(10),
 Home_Address varchar(50),
 phone_No nchar(10),
 Email varchar(50),
 Password varchar(10),
 CONSTRAINT pk_Member PRIMARY KEY (MemberID),
 CONSTRAINT me_chk1 check(Email like '%@%'),
 CONSTRAINT me_chk2 check(Password like '%[0-9]%' and Password like '%[A-Z]%' and 
 Password like '%[!@#$%a^&*()-_+=.,;:"`~]%' )
);

--creation of Account table--
CREATE TABLE Account(
 AccID varchar(18),
 MemberID varchar(10),
 Bank_No char(5),
 AccName varchar(10),
 AccBalance real,
 CONSTRAINT ac_pk PRIMARY KEY(MemberID,AccID),
 CONSTRAINT ac_fk1 FOREIGN KEY(MemberID) references Member(MemberID),
 CONSTRAINT ac_fk2 FOREIGN KEY(Bank_No) references Bank(Bank_No)
);

--creation of Buyer table--
CREATE TABLE Buyer(
 B_MemberID varchar(10),
 Shipping_Address varchar(50),
 CONSTRAINT buy_pk PRIMARY KEY(B_MemberID),
 CONSTRAINT buy_fk FOREIGN KEY(B_MemberID) references Member(MemberID)
);

--creation of Seller table--
CREATE TABLE Seller(
 S_MemberID varchar(10),
 Routine_No varchar(50),
 CONSTRAINT sell_pk PRIMARY KEY(S_MemberID),
 CONSTRAINT sell_fk FOREIGN KEY(S_MemberID) references Member(MemberID)
);

--creation of Category table--
CREATE TABLE Category(
 Category_ID varchar(10),
 Description varchar(50),
 CONSTRAINT cat_pk PRIMARY KEY(Category_ID)
);

--creation of Item table--
CREATE TABLE Item(
 ItemNo varchar (10),
 Item_title varchar(10),
 Description varchar(50),
 start_bidprice real,
 start_date date,
 end_date date,
 Bidding_increasement real,
 Category_ID varchar(10),
  CONSTRAINT it_pk PRIMARY KEY(ItemNo),
 CONSTRAINT it_fk FOREIGN KEY(Category_ID) references Category(Category_ID)
);

--creation of Lists table--
CREATE TABLE Lists(
 ItemNo varchar(10),
 S_MemberID varchar(10),
 CONSTRAINT li_pk PRIMARY KEY(ItemNo,S_MemberID),
 CONSTRAINT li_fk FOREIGN KEY(S_MemberID) references Seller(S_MemberID)
);

--creation of Bids_on table--
CREATE TABLE Bids_On(
 ItemNo varchar(10),
 S_MemberID varchar(10),
 B_MemberID varchar(10),
 Bid_Price real,
 Bid_Time datetime DEFAULT(getdate()),
 constraint bid_pk primary key(ItemNo,S_MemberID,B_MemberID),
 constraint bid_fk1 foreign key(ItemNo) references Item(ItemNo),
 constraint bid_fk2 foreign key(B_MemberID) references Buyer(B_MemberID),
 constraint bid_fk3 foreign key(ItemNo,S_MemberID) references Lists(ItemNo,S_MemberID)
);

--creation of Transations table--
CREATE TABLE Transactions(
 TransID varchar(10),
 Credit varchar(10),
 Debit varchar(10),
 S_MemberID varchar(10),
 B_MemberID varchar(10),
 Win_bid_price real,
 Win_bid_time datetime DEFAULT(getdate()),
 constraint tr_fk1 foreign key(B_MemberID) references Buyer(B_MemberID),
 constraint tr_fk2 foreign key(S_MemberID) references Seller(S_MemberID)
);


--Data insertion of Bank table--
INSERT INTO Bank VALUES ('1','Sampath Bank','colombo'); 
INSERT INTO Bank VALUES ('2','Bank of Ceylon','kurunegala');
INSERT INTO Bank VALUES ('3','Peoples Bank','negambo');
INSERT INTO Bank VALUES ('4','NDB bank','galle');
INSERT INTO Bank VALUES ('5','Commercial Bank','malabe');


--Data insertion of Member table--
INSERT INTO Member VALUES ('001', 'Saman','No 432, Colombo','0715224578',
'saman@gmail.com','aaA46@&$');
INSERT INTO Member VALUES ('002', 'perera','No 22, kurunegala','0725224568',
'perera@gmail.com.com','aBrg44$$');
INSERT INTO Member VALUES ('003', 'supun','No 35, negombo','0765234578', 
'supun@gmail.com','mMlL33@$');
INSERT INTO Member VALUES ('004', 'namal','No 75, fort','0755233578',
'namal@gmail.com','aaAA44$$');
INSERT INTO Member VALUES ('005', 'Yasas','No 865, malabe town','0755233578', 
'Yasas@gmail.com.com','gdAB55@@');


--Data insertion of Account table--
INSERT INTO Account VALUES ('11111','001','1','Saving', 100000.00); 
INSERT INTO Account VALUES ('22222','002','2','Saving', 60000.00);
INSERT INTO Account VALUES ('33333','003','3','Current', 30000.00);
INSERT INTO Account VALUES ('44444','004','4','Saving', 21000.00);
INSERT INTO Account VALUES ('55555','005','5','Current', 110000.00);


--Data insertion of Buyer table--
INSERT INTO Buyer VALUES ('001','No 432, Colombo');
INSERT INTO Buyer VALUES ('002','No 22, kurunegala');
INSERT INTO Buyer VALUES ('003','No 35, negombo');


--Data insertion of Seller table--
INSERT INTO Seller VALUES ('004','No 75, fort');
INSERT INTO Seller VALUES ('005','No 865, malabe town');


--Data insertion of Category table--
INSERT INTO Category VALUES('0001', 'Electronic');
INSERT INTO Category VALUES('0002', 'vehicle');
INSERT INTO Category VALUES('0003', 'antics');
INSERT INTO Category VALUES('0004', 'dress');
INSERT INTO Category VALUES('0005', 'household');


--Data insertion of Item table--
INSERT INTO Item VALUES ('01','Laptop', 'Laptop Description', 100000.00, '2023/10/26', 
'2023/11/10',101000.00,'0001');
INSERT INTO Item VALUES ('02','picture', 'picture Description', 50000.00, '2023/09/28', 
'2023/10/05',52000.00, '0003');
INSERT INTO Item VALUES ('03','cab', 'Cab Description', 5000000.00, '2023/10/06', 
'2023/11/20',5025000.00, '0002');
INSERT INTO Item VALUES ('04','Table', 'Table Description', 10000.00, '2023/10/17', 
'2023/10/30',11000.00, '0005');
INSERT INTO Item VALUES ('05','T-shirt', 'T-shirt Description', 4000.00, '2023/10/21', 
'2023/10/28',4500.00, '0004');


--Data insertion of Lists table--
INSERT INTO Lists VALUES ('01', '004');
INSERT INTO Lists VALUES ('02', '005');
INSERT INTO Lists VALUES ('03', '004');
INSERT INTO Lists VALUES ('04', '004');
INSERT INTO Lists VALUES ('05', '005');


--Data insertion of Bids_on table--
INSERT INTO Bids_On VALUES ('01', '004', '001', 140000.00, '2023/10/28 07:45:10');
INSERT INTO Bids_On VALUES ('01', '004', '002', 160000.00, '2023/10/28 15:50:10');
INSERT INTO Bids_On VALUES ('02', '005', '001', 130000.00, '2023/09/30 02:45:10');
INSERT INTO Bids_On VALUES ('02', '005', '003', 140000.00, '2023/10/01 04:45:10');
INSERT INTO Bids_On VALUES ('04', '004', '002', 15500.00, '2023/10/18 08:45:10');
INSERT INTO Bids_On VALUES ('04', '004', '001', 16000.00, '2023/10/19 11:45:10');



--Data insertion of Transation table--
INSERT INTO Transactions VALUES ('T1','222222', '444444', 
'004', '002', 160000.00, '2023/10/28 15:50:10');
INSERT INTO Transactions VALUES ('T2','333333', '555555', 
'005', '003', 140000.00, '2023/10/01 04:45:10');
INSERT INTO Transactions VALUES ('T3','111111', '444444', 
'004', '001', 16000.00, '2023/10/19 11:45:10');




--Triggers--

--01)--
CREATE TRIGGER Account_Balance_Check
ON Account
AFTER INSERT
AS
BEGIN
 IF EXISTS(SELECT 1 FROM inserted WHERE AccBalance<=25000.00)
BEGIN
 RAISERROR ('Bank Balance cannot be less than 25000 Rupees',16,1);
 ROLLBACK
 RETURN
END
END


--02)--

CREATE TRIGGER CheckTransaction
ON Transactions
FOR INSERT
AS
BEGIN
 DECLARE @bidPrice real, @bAccNo varchar(18), @sAccNo varchar(18)
 SELECT @bidPrice=Win_bid_price, @bAccNo=Credit, @sAccNo=Debit
 FROM Transactions;
 DECLARE @bAccBal real, @sAccBal real
 SELECT @bAccBal=AccBalance
 FROM Account
 WHERE AccID = @bAccNo;
 SELECT @sAccBal=AccBalance
 FROM Account
 WHERE AccID = @sAccNo;
 IF @bAccBal < @bidPrice
 ROLLBACK TRANSACTION
 ELSE

  BEGIN
   UPDATE Account
   SET AccBalance = @bAccBal - @bidPrice
   WHERE AccID = @bAccNo;
   UPDATE Account
   SET AccBalance = @sAccBal + @bidPrice
   WHERE AccID = @sAccNo;
END
END


select * from Account


--Views--
--01--
CREATE VIEW [Member Details] 
AS
SELECT 
M.MemberID,M.Name,M.Email,M.Home_Address,M.phone_No,B.BankName,B.branchName,A.AccID 
AS [Account No],A.AccBalance AS [Account Blance]
FROM Account A, Member M, Bank B
WHERE M.MemberID=A.MemberID AND A.Bank_No=B.Bank_No;

Select * from [Member Details]

--02--
CREATE VIEW showItem
AS
SELECT mem.Name, itm.Item_title, itm.Description AS [Item Description], cat.Description AS 
[Category]
FROM Item itm, Lists lst, Member mem, Category cat
WHERE itm.ItemNo = lst.ItemNo AND lst.S_MemberID = mem.MemberID AND itm.Category_ID = cat.Category_ID;

select * from showItem



--Indexes--
--implement an index on Accbalance column in Account table--

CREATE INDEX INX_Acc_Balance
ON Account (AccBalance);

--implement an index on Bid_Price column in Bids_on--

CREATE INDEX INX_Bid_on
ON Bids_On (Bid_Price);



--Procededures--
--question 01--
CREATE PROCEDURE Member_Bank
AS
BEGIN
SELECT M.Name,M.Home_Address
FROM Member M, Account A, Bank B
WHERE M.MemberID=A.MemberID AND A.Bank_No=B.Bank_No AND B.BankName= 'Sampath Bank'
END
EXEC Member_Bank
 

--question 02--
CREATE PROCEDURE Member_Bid
AS
BEGIN
SELECT M.Name,M.Email,BN.Bid_Price
FROM Member M, Bids_On BN, Buyer Bu, Lists L, Item I
WHERE BN.B_MemberID=Bu.B_MemberID AND Bu.B_MemberID = M.MemberID AND 
BN.ItemNo=L.ItemNo AND L.ItemNo = I.ItemNo AND I.Item_title='Laptop'
ORDER BY BN.Bid_Price
END

EXEC Member_Bid


--question 03--
CREATE PROCEDURE Seller_Sum
AS
BEGIN
SELECT M.Name,SUM(I.start_bidprice)
FROM Item I, Lists L, Seller S, Member M
WHERE I.ItemNo=L.ItemNo AND S.S_MemberID=L.S_MemberID AND 
S.S_MemberID=M.MemberID
GROUP BY M.Name
HAVING SUM(I.start_bidprice)>30000
END

EXEC Seller_Sum

--question 04--
CREATE PROCEDURE bidIncrease
AS
BEGIN
DECLARE @currentBid real, @ItmNo varchar(10), @sMemNo varchar(10), 
@bMemNo varchar(10), @bidCount int, @i int
SET @i = 0
SELECT @bidCount=COUNT(BN.B_MemberID)
FROM Bids_On BN,Buyer Bu, Member M
WHERE BN.B_MemberID=Bu.B_MemberID AND Bu.B_MemberID=M.MemberID AND 
M.Name='Saman'
WHILE @i < @bidCount
BEGIN
SELECT @currentBid = BN.Bid_Price, @ItmNo = BN.ItemNo, 
@sMemNo = BN.S_MemberID, @bMemNo =BN.B_MemberID
FROM Bids_On BN,Buyer Bu, Member M
WHERE BN.B_MemberID=Bu.B_MemberID AND 
Bu.B_MemberID=M.MemberID AND M.Name='Saman'
ORDER BY Bid_Time DESC
OFFSET @i ROWS FETCH FIRST 1 ROWS ONLY
DECLARE @increaseBy real
SET @increaseBy = (@currentBid * 15) / 100
UPDATE Bids_On
SET Bid_Price = Bid_Price + @increaseBy
WHERE ItemNo = @ItmNo AND S_MemberID = @sMemNo AND 
B_MemberID = @bMemNo;
SET @i = @i + 1
END
END

EXEC bidIncrease



