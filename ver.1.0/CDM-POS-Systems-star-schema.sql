CREATE DATABASE IF NOT EXISTS data_warehouse ;
USE data_warehouse;

-- Tabel fakta (fact table)
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Date DATE,
    TotalAmount DECIMAL(10, 2),
    PaymentMethodID INT,
    CustomerID INT,
    EmployeeID INT,
    DiscountID INT,
    FOREIGN KEY (PaymentMethodID) REFERENCES DimPaymentMethod(MethodID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES DimEmployee(EmployeeID),
    FOREIGN KEY (DiscountID) REFERENCES DimDiscount(DiscountID)
);

-- Tabel dimensi (dimension tables)
CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

CREATE TABLE DimEmployee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Position VARCHAR(100),
    Email VARCHAR(255),
    Phone VARCHAR(20)
);

CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(255),
    CategoryID INT,
    Brand VARCHAR(100),
    Price DECIMAL(10, 2),
    Description TEXT
);

CREATE TABLE DimDiscount (
    DiscountID INT PRIMARY KEY,
    Amount DECIMAL(10, 2),
    Percentage DECIMAL(5, 2)
);

CREATE TABLE DimPaymentMethod (
    MethodID INT PRIMARY KEY,
    MethodName VARCHAR(100)
);