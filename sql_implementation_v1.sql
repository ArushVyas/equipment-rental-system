CREATE DATABASE EquipmentRentalDB;
USE EquipmentRentalDB;

CREATE TABLE AddressTable (
	Address_ID 		INT PRIMARY KEY,
	Pincode 		VARCHAR(6) NOT NULL CHECK(LENGTH(Pincode) = 6),
        CONSTRAINT check_pincode_digits CHECK(Pincode REGEXP '^[0-9]+$'), -- only digits
    State 			VARCHAR(50) NOT NULL,
    City 			VARCHAR(50) NOT NULL,
    Locality 		VARCHAR(50),
    Plot 			VARCHAR(50),
    Building_Name 	VARCHAR(50) NOT NULL,
    Flat_No 		VARCHAR(10) NOT NULL
);

CREATE TABLE RentalOwner(
    Owner_ID        	INT PRIMARY KEY,
    Owner_Name      	VARCHAR(200) NOT NULL,
    Owner_Phone_No  	VARCHAR(15) NOT NULL,
        CONSTRAINT check_owner_phone_digits CHECK(Owner_Phone_No REGEXP '^[0-9]+$'), -- only digits
    Owner_Email     	VARCHAR(200),
    Owner_Address		INT NOT NULL,
		FOREIGN KEY (Owner_Address) REFERENCES AddressTable(Address_ID)
);

CREATE TABLE RentalUser (
	User_ID 		INT PRIMARY KEY,
    User_Name 		VARCHAR(50) NOT NULL,
    User_Phone_No 	VARCHAR(12) UNIQUE NOT NULL CHECK(LENGTH(User_Phone_No) = 12),
        CONSTRAINT check_user_phone_digits CHECK(User_Phone_No REGEXP '^[0-9]+$'), -- only digits
    User_Email 		VARCHAR(254) UNIQUE NOT NULL,
    User_Address			INT NOT NULL,
		FOREIGN KEY (User_Address) REFERENCES AddressTable(Address_ID)
);

CREATE TABLE Product(
	Product_ID			INT PRIMARY KEY,
	Category			VARCHAR(30) NOT NULL,
	Rent_Per_Day		DECIMAL(8,2) NOT NULL CHECK(Rent_Per_Day >= 0),
	No_Of_Bookings		INT NOT NULL DEFAULT 0 CHECK(No_Of_Bookings >= 0),
    Product_Name        VARCHAR(30) NOT NULL,
	Product_Description	VARCHAR(200),
	Owner_ID INT NOT NULL,
		 FOREIGN KEY (Owner_ID) REFERENCES RentalOwner(Owner_ID),
    -- currently rented by...
	Rented_By_User_ID INT,
		 FOREIGN KEY (Rented_By_User_ID) REFERENCES RentalUser(User_ID)
    -- TODO: image of product
);


CREATE TABLE Transport (
	Transport_ID	 	INT PRIMARY KEY,
    from_address	 	INT NOT NULL,
		FOREIGN	KEY (from_address) REFERENCES AddressTable(Address_ID),
	to_address	 		INT NOT NULL,
		FOREIGN	KEY (to_address) REFERENCES AddressTable(Address_ID),
	Product_ID	 		INT NOT NULL,
		FOREIGN	KEY (Product_ID) REFERENCES Product(Product_ID),
	Transport_Cost		DECIMAL(7, 2) NOT NULL,
    Mode_Of_Transport	VARCHAR(50) NOT NULL
    -- porter_id
);

CREATE TABLE RentalLog(
    Rented_Time   DATETIME,
    Rent_Duration_Days INT NOT NULL,
    Owner_ID INT NOT NULL,
		CONSTRAINT fk_owner_id FOREIGN KEY (Owner_ID) REFERENCES RentalOwner(Owner_ID),
	User_ID INT NOT NULL,
		CONSTRAINT fk_user_id FOREIGN KEY (User_ID) REFERENCES RentalUser(User_ID),
	Product_ID INT NOT NULL,
		CONSTRAINT fk_product_id FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Review(
	Review_ID 	INT PRIMARY KEY,
    Product_ID  INT NOT NULL,
         FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
	User_ID 	INT NOT NULL,
		FOREIGN KEY (User_ID) REFERENCES RentalUser(User_ID),
	rating 		INT NOT NULL CHECK(rating>=0 AND rating <= 10),
	comments 	VARCHAR(300)
);

INSERT INTO AddressTable VALUES (1, 400069, "MAH", "Mum", "Andheri", "5001", "SPIT", "606");
INSERT INTO RentalOwner VALUES (1, "test1", "987654321", "test@example.com", 1);
INSERT INTO Product VALUES (1, "Elec", 500, 0, "Product Name", "Desc.", 1, NULL);

SELECT * FROM Product;

SHOW TABLES;
