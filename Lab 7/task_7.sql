-- Create tables
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY,
    Location VARCHAR(255),
    YearEstablished INT
);

CREATE TABLE Employee (
    NationalID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(255),
    BloodGroup VARCHAR(5),
    BirthDate DATE,
    Type ENUM('Admin', 'Librarian', 'Maintenance'),
    BaseSalary DECIMAL(10, 2),
    HousingAllowance DECIMAL(10, 2),
    CONSTRAINT FK_Employee_Branch FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE Shift (
    ShiftID INT PRIMARY KEY,
    StartDay VARCHAR(10),
    StartTime TIME,
    Duration INT
);

CREATE TABLE Book (
    ISBN VARCHAR(13) PRIMARY KEY,
    Name VARCHAR(255),
    Author VARCHAR(255),
    Genre VARCHAR(255),
    Price DECIMAL(10, 2),
    CONSTRAINT FK_Book_Publisher FOREIGN KEY (PublisherName) REFERENCES Publisher(PublisherName)
);

CREATE TABLE Publisher (
    PublisherName VARCHAR(255) PRIMARY KEY,
    City VARCHAR(255),
    EstablishmentYear INT
);

CREATE TABLE User (
    Username VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255),
    DateOfBirth DATE,
    Hometown VARCHAR(255),
    Occupation VARCHAR(255)
);

CREATE TABLE Copies (
    BranchID INT,
    ISBN VARCHAR(13),
    NumberOfCopies INT,
    PRIMARY KEY (BranchID, ISBN),
    CONSTRAINT FK_Copies_Branch FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
    CONSTRAINT FK_Copies_Book FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);

CREATE TABLE Issues (
    IssueID INT PRIMARY KEY,
    UserID VARCHAR(255),
    ISBN VARCHAR(13),
    EmployeeNationalID VARCHAR(20),
    IssueDate DATE,
    Duration INT,
    CONSTRAINT FK_Issues_User FOREIGN KEY (UserID) REFERENCES User(Username),
    CONSTRAINT FK_Issues_Book FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    CONSTRAINT FK_Issues_Employee FOREIGN KEY (EmployeeNationalID) REFERENCES Employee(NationalID)
);

-- Create many-to-many relationships tables (WorksAt and AssignedTo)
CREATE TABLE WorksAt (
    EmployeeNationalID VARCHAR(20),
    BranchID INT,
    PRIMARY KEY (EmployeeNationalID, BranchID),
    CONSTRAINT FK_WorksAt_Employee FOREIGN KEY (EmployeeNationalID) REFERENCES Employee(NationalID),
    CONSTRAINT FK_WorksAt_Branch FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE AssignedTo (
    EmployeeNationalID VARCHAR(20),
    ShiftID INT,
    PRIMARY KEY (EmployeeNationalID, ShiftID),
    CONSTRAINT FK_AssignedTo_Employee FOREIGN KEY (EmployeeNationalID) REFERENCES Employee(NationalID),
    CONSTRAINT FK_AssignedTo_Shift FOREIGN KEY (ShiftID) REFERENCES Shift(ShiftID)
);

-- Create one-to-one relationships tables (HasAccount)
CREATE TABLE HasAccount (
    Username VARCHAR(255),
    UserID VARCHAR(255) UNIQUE,
    PRIMARY KEY (Username),
    CONSTRAINT FK_HasAccount_User FOREIGN KEY (Username) REFERENCES User(Username)
);