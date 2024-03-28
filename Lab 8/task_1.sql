-- Create Division table
CREATE TABLE Division (
    DivisionID INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Create District table
CREATE TABLE District (
    DistrictID INT PRIMARY KEY,
    Name VARCHAR(255),
    DivisionID INT,
    FOREIGN KEY (DivisionID) REFERENCES Division(DivisionID)
);

-- Create Branch table
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY,
    Name VARCHAR(255),
    DistrictID INT,
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID)
);

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    DOB DATE,
    ContactNo VARCHAR(20),
    BranchID INT,
    DepartmentID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DeptID)
);

-- Create Department table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactNo VARCHAR(20),
    Address VARCHAR(255)
);

-- Create Item table
CREATE TABLE Item (
    ItemID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    UnitPrice DECIMAL(10, 2)
);

-- Create ItemRental table
CREATE TABLE ItemRental (
    ItemID INT,
    CustomerID INT,
    RentalDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create RentalDuration table
CREATE TABLE RentalDuration (
    DurationID INT PRIMARY KEY,
    Duration INT
);

-- Create EmployeeItem table (for tracking rentals by employees)
CREATE TABLE EmployeeItem (
    EmployeeID INT,
    ItemID INT,
    RentalDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);