CREATE DATABASE Scrollatravelnew;
USE Scrollatravelnew;
CREATE TABLE IF NOT EXISTS Hotel (
	Hotel_ID INT NOT NULL,
	HotelName VARCHAR(100) NOT NULL,
	Address VARCHAR(200) NOT NULL,
	HotelDesc VARCHAR(100) NOT NULL,
	City VARCHAR(100) NOT NULL,
	Country VARCHAR(30) NOT NULL,
	Rating DOUBLE NOT NULL,
	PRIMARY KEY (Hotel_ID),
	CONSTRAINT Rating_ck check (Rating >= 0 or Rating <=5 )
	);	

CREATE TABLE IF NOT EXISTS roomtype (
	Roomtype_id INT NOT NULL,
	Roomtype VARCHAR(45) NOT NULL,
	RoomPrice DOUBLE NOT NULL,
	PRIMARY KEY (Roomtype_id));
    
CREATE TABLE IF NOT EXISTS hotelroom (
	RoomNo VARCHAR(10) NOT NULL,
	RoomStatus VARCHAR(45) NOT NULL,
	Hotel_Hotel_id INT NOT NULL,
	roomtype_Roomtype_id INT NOT NULL,
	PRIMARY KEY (RoomNo),
	INDEX fk_Hotelroom_Hotel1_idx (Hotel_Hotel_id ASC) VISIBLE,
	INDEX fk_hotelroom_roomtype1_idx (roomtype_Roomtype_id ASC) VISIBLE,
	CONSTRAINT fk_Hotelroom_Hotel1
	FOREIGN KEY (Hotel_Hotel_id)
	REFERENCES hotel (Hotel_ID),
	CONSTRAINT fk_hotelroom_roomtype1
	FOREIGN KEY (roomtype_Roomtype_id)
	REFERENCES roomtype (Roomtype_id),
	CONSTRAINT RoomStatus_ck check (RoomStatus = 'Available' or RoomStatus =
	'Unavailable'));

CREATE TABLE IF NOT EXISTS Resort (
	Resort_ID INT NOT NULL,
	ResortPrice DOUBLE NOT NULL,
	ResortDesc VARCHAR(25) NOT NULL,
	ResortName VARCHAR(45) NOT NULL,
	Address VARCHAR(200) NOT NULL,
	Country VARCHAR(30) NOT NULL,
	Rating DOUBLE NOT NULL,
	City VARCHAR(100) NOT NULL,
	PRIMARY KEY (Resort_ID),
	CONSTRAINT RatingResort_ck check (Rating >= 0 or Rating <=5 )
	);

CREATE TABLE IF NOT EXISTS customer (
	Customer_ID INT NOT NULL,
	Fname VARCHAR(50) NOT NULL,
	Lname VARCHAR(50) NOT NULL,
	Gender CHAR(1) NULL DEFAULT NULL,
	Tel CHAR(10) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	CRank VARCHAR(25) NOT NULL,
	Address VARCHAR(50) NOT NULL,
	Postcode VARCHAR(30) NOT NULL,
	City VARCHAR(35) NOT NULL,
	Country VARCHAR(35) NOT NULL,
	PRIMARY KEY (Customer_ID),
	constraint CRank_ck check (CRank = 'Gold' or CRank = 'silver' or CRank = 'bronze'or
	CRank = 'platinum'),
	constraint Gender_ck check (Gender = 'M' or Gender = 'F')
	);

CREATE TABLE IF NOT EXISTS promotion (
	Promotion_ID INT NOT NULL,
	Promotion_name VARCHAR(50) NOT NULL,
	PromotionStartDate DATE NOT NULL,
	PromotionEndDate DATE NOT NULL,
	PromotionCondition VARCHAR(100) NOT NULL,
	PromotionDetails VARCHAR(150) NOT NULL,
	PRIMARY KEY (Promotion_ID)
	);

CREATE TABLE IF NOT EXISTS booking (
	Booking_ID INT NOT NULL,
	BookingDate DATE NOT NULL,
	BookingStatus VARCHAR(50) NOT NULL,
	ArriveDate DATE NOT NULL,
	DepartDate DATE NOT NULL,
	NumOfChild INT NOT NULL,
	NumOfAdult INT NOT NULL,
	Hotelroom_RoomNo VARCHAR(10) NULL,
	Resort_Resort_ID INT NULL,
	PRIMARY KEY (Booking_ID),
	INDEX fk_booking_Hotelroom1_idx (Hotelroom_RoomNo ASC) VISIBLE,
	INDEX fk_booking_Resort1_idx (Resort_Resort_ID ASC) VISIBLE,
	CONSTRAINT fk_booking_Hotelroom1
	FOREIGN KEY (Hotelroom_RoomNo)
	REFERENCES Hotelroom (RoomNo),
	CONSTRAINT fk_booking_Resort1
	FOREIGN KEY (Resort_Resort_ID)
	REFERENCES Resort (Resort_ID),
	constraint BookingStatus_ck check (BookingStatus = 'Book unsucceeded' or
	BookingStatus = 'Book succeeded'));

CREATE TABLE IF NOT EXISTS receipt (
	Receipt_ID INT NOT NULL,
	PaymentDate DATETIME NOT NULL,
	ReceiptStatus VARCHAR(25) NOT NULL,
	Price DOUBLE NOT NULL,
	Promotion_ID INT NULL DEFAULT NULL,
	booking_Booking_ID INT NOT NULL,
	customer_Customer_ID INT NOT NULL,
	PRIMARY KEY (Receipt_ID),
	INDEX FKPromotion_ID (Promotion_ID ASC) VISIBLE,
	INDEX fk_receipt_booking1_idx (booking_Booking_ID ASC) VISIBLE,
	INDEX fk_receipt_customer1_idx (customer_Customer_ID ASC) VISIBLE,
	CONSTRAINT FKPromotion_ID
	FOREIGN KEY (Promotion_ID)
	REFERENCES promotion (Promotion_ID),
	CONSTRAINT fk_receipt_booking1
	FOREIGN KEY (booking_Booking_ID)
	REFERENCES booking (Booking_ID),
	CONSTRAINT fk_receipt_customer1
	FOREIGN KEY (customer_Customer_ID)
	REFERENCES customer (Customer_ID),
	constraint ReceiptStatus_ck check (ReceiptStatus = 'not paided' or
	ReceiptStatus = 'paided' or ReceiptStatus = 'cancel'));
    
-- customer --
INSERT INTO customer
(Customer_ID,Fname,Lname,Gender,Tel,Email,CRank,Address,Postcode,City,Country )
VALUES (1111, 'Inwza', 'Aekwa','M','0123456789','inwza@gmail.com','Gold','123/157','10451','Bangkok','Thailand' );
INSERT INTO customer
(Customer_ID,Fname,Lname,Gender,Tel,Email,CRank,Address,Postcode,City,Country )
VALUES (1112, 'Siripong', 'phiwkhaw','M','45456464','inwza55@gmail.com','silver','44/157','44400','Bangkok','Thailand' );
INSERT INTO customer
(Customer_ID,Fname,Lname,Gender,Tel,Email,CRank,Address,Postcode,City,Country )
VALUES (1113, 'Anuwat', 'Pattanajan','M','54645464','inwza44@gmail.com','Gold','113/157','54460','Bangkok','Thailand' );
INSERT INTO customer
(Customer_ID,Fname,Lname,Gender,Tel,Email,CRank,Address,Postcode,City,Country )
VALUES (1114, 'Aritach', 'krudminburee','F','04544644','inwza33@gmail.com','bronze','123/00','23232','Bangkok','Thailand' );
INSERT INTO customer
(Customer_ID,Fname,Lname,Gender,Tel,Email,CRank,Address,Postcode,City,Country )
VALUES (1115, 'Kittayod', 'wongwuttinun','F','1315416161','inwza12@gmail.com','silver','12/57','77777','Bangkok','Thailand' );

-- hotel --
INSERT INTO Hotel (Hotel_ID,HotelName,Address,HotelDesc,City,Country, Rating)
VALUES (2000,'Diamond Hotel','952/142','7 floors','Bangkok','Thailand',3.6);

-- roomtype --
INSERT INTO roomtype (Roomtype_id,Roomtype,RoomPrice )
VALUES (2001, 'Duo Room', 3000);
INSERT INTO roomtype (Roomtype_id,Roomtype,RoomPrice )
VALUES (2002, 'Single Room', 3000);

-- hotelroom --
INSERT INTO hotelroom (RoomNo,Roomstatus,Hotel_Hotel_id,roomtype_Roomtype_id)
VALUES ('2201', 'Available', 2000,2001);
INSERT INTO hotelroom (RoomNo,Roomstatus,Hotel_Hotel_id,roomtype_Roomtype_id)
VALUES ('2202', 'Unavailable', 2000,2002);

-- resort --
INSERT INTO Resort
(Resort_ID,ResortPrice,ResortDesc,ResortName,Address,Country,Rating,City)
VALUES (3001,2700,'4 bedroom 3 bathroom','Ruby Resort','875/5452','Thailand',3.6,'Bangkok');
INSERT INTO Resort
(Resort_ID,ResortPrice,ResortDesc,ResortName,Address,Country,Rating,City)
VALUES (3002,2800,'3 bedroom 2 bathroom','Sapphire Resort','625/5415','Thailand',3.5,'Bangkok');
INSERT INTO Resort
(Resort_ID,ResortPrice,ResortDesc,ResortName,Address,Country,Rating,City)
VALUES (3003,2500,'2 bedroom 1 bathroom','Emerald Resort','455/5461','Thailand',3.5,'Bangkok');

-- promotion --
INSERT INTO
promotion(Promotion_ID,Promotion_name,PromotionStartDate,PromotionEndDate,PromotionCondition,PromotionDetails)
VALUES (9000, '2.6%', '2021-09-15', '2021-12-27','Rank Silver or above','discount 2.6%');

-- booking --
INSERT INTO booking
(Booking_ID,BookingDate,BookingStatus,ArriveDate,DepartDate,NumOfChild,NumOfAdult,Hotelroom_RoomNo,Resort_Resort_ID )
VALUES (4001,'2021-09-30','Book succeeded','2021-10-01','2021-10-03',1,2,'2201',null);
INSERT INTO booking
(Booking_ID,BookingDate,BookingStatus,ArriveDate,DepartDate,NumOfChild,NumOfAdult,Hotelroom_RoomNo,Resort_Resort_ID )
VALUES (4002,'2021-09-28','Book succeeded','2021-10-02','2021-10-06',1,0,'2202',null);
INSERT INTO booking
(Booking_ID,BookingDate,BookingStatus,ArriveDate,DepartDate,NumOfChild,NumOfAdult,Hotelroom_RoomNo,Resort_Resort_ID )
VALUES (4003,'2021-09-20','Book unsucceeded','2021-10-01','2021-10-04',4,3,null,3001);
INSERT INTO booking
(Booking_ID,BookingDate,BookingStatus,ArriveDate,DepartDate,NumOfChild,NumOfAdult,Hotelroom_RoomNo,Resort_Resort_ID )
VALUES (4004,'2021-09-24','Book unsucceeded','2021-10-01','2021-10-03',5,0,null,3002);
INSERT INTO booking
(Booking_ID,BookingDate,BookingStatus,ArriveDate,DepartDate,NumOfChild,NumOfAdult,Hotelroom_RoomNo,Resort_Resort_ID )
VALUES (4005,'2021-09-21','Book succeeded','2021-09-29','2021-10-01',2,1,null,3003);

-- receipt --
INSERT INTO receipt
(Receipt_ID,PaymentDate,ReceiptStatus,Price,Promotion_ID,booking_Booking_ID,customer_Customer_ID)
VALUES (7001, '2021-10-20', 'paided',2985,9000,4001,1111);
INSERT INTO receipt
(Receipt_ID,PaymentDate,ReceiptStatus,Price,Promotion_ID,booking_Booking_ID,customer_Customer_ID)
VALUES (7002, '2021-10-21', 'paided',2700,null,4002,1112);
INSERT INTO receipt
(Receipt_ID,PaymentDate,ReceiptStatus,Price,Promotion_ID,booking_Booking_ID,customer_Customer_ID)
VALUES (7003, '2021-10-22', 'not paided',2800,null,4003,1113);
INSERT INTO receipt
(Receipt_ID,PaymentDate,ReceiptStatus,Price,Promotion_ID,booking_Booking_ID,customer_Customer_ID)
VALUES (7004, '2021-10-23', 'paided',2700,null,4004,1114);
INSERT INTO receipt
(Receipt_ID,PaymentDate,ReceiptStatus,Price,Promotion_ID,booking_Booking_ID,customer_Customer_ID)
VALUES (7005, '2021-10-24', 'cancel',2500,null,4005,1115);

