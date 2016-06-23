CREATE TABLE address (
	addressid BIGSERIAL NOT NULL,
	addressline1 text NOT NULL,
	addressline2 text,
	City text NOT NULL,
	PostalCode text NOT NULL,
	PRIMARY KEY (addressid)
);

CREATE TABLE creditcard (
	CreditCardID BIGSERIAL NOT NULL,
	CardType text NOT NULL,
	CardNumber text NOT NULL,
	ExpMonth TEXT NOT NULL,
	ExpYear TEXT NOT NULL,
	PRIMARY KEY (CreditCardID)
);

CREATE TABLE person (
	PersonID BIGSERIAL NOT NULL,
	Title TEXT,
	FirstName TEXT NOT NULL,
	LastName TEXT NOT NULL,
	PRIMARY KEY (PersonID)
);

CREATE TABLE Customer (
	CustomerID BIGSERIAL NOT NULL,
	PersonID BIGINT REFERENCES person(personid),
	PRIMARY KEY (CustomerID)
);

CREATE TABLE PersonAddress (
	PersonID BIGINT REFERENCES Person(personid) NOT NULL,
	AddressID BIGINT REFERENCES Address(addressid) NOT NULL,
	PRIMARY KEY (AddressID)
);

CREATE TABLE ProductCategory (
	ProductCategoryID SERIAL NOT NULL,
	"Name" TEXT NOT NULL,
	PRIMARY KEY (ProductCategoryID)
);

CREATE TABLE Product (
	 ProductID SERIAL NOT NULL,
	 "Name" TEXT NOT NULL,
	 SafetyStockLevel INT NOT NULL,
	 ReorderPoint INT NOT NULL,
	 StandardCost REAL NOT NULL DEFAULT 0.00,
	 ListPrice REAL NOT NULL DEFAULT 0.00,
	 ProductCategoryID INT REFERENCES ProductCategory(ProductCategoryID),
	 PRIMARY KEY (ProductID)
);

CREATE TABLE SalesOrderHeader (
	 SalesOrderID BIGSERIAL NOT NULL,
	 OrderDate DATE NOT NULL,
	 DueDate DATE NOT NULL,
	 ShipDate DATE NOT NULL,
	 OnlineOrderFlag SMALLINT NOT NULL DEFAULT 0,
	 CustomerID BIGINT REFERENCES Customer(CustomerID) NOT NULL,
	 CreditCardID BIGINT REFERENCES CreditCard(CreditCardID) NOT NULL,
	 SubTotal DOUBLE PRECISION NOT NULL,
	 TaxAmt REAL NOT NULL,
	 Freight REAL NOT NULL,
	 TotalDue DOUBLE PRECISION NOT NULL,
	 PRIMARY KEY (SalesOrderID)
);

CREATE TABLE SalesOrderDetail (
	 SalesOrderID BIGINT REFERENCES SalesOrderHeader(SalesOrderID) NOT NULL,
	 SalesOrderDetailID BIGSERIAL NOT NULL,
	 OrderQty INT NOT NULL,
	 ProductID BIGINT REFERENCES Product(productid) NOT NULL,
	 UnitPrice REAL NOT NULL,
	 UnitPriceDiscount REAL NOT NULL DEFAULT 0.00,
	 LineTotal DOUBLE PRECISION NOT NULL,
	 PRIMARY KEY (SalesOrderDetailID)
);
