CREATE TYPE CCard AS (
	CardType TEXT,
	CardNumber TEXT,
	ExpMonth TEXT,
	ExpYear TEXT
);

CREATE TYPE 'Name' AS (
  FirstName TEXT,
  LastName TEXT
);

CREATE TYPE Price AS (
  StandardCost REAL,
  ListPrice REAL
);
