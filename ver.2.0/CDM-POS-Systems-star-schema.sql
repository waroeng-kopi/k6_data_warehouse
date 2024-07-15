CREATE DATABASE IF NOT EXISTS db_cdm_pos;
USE db_cdm_pos;

-- Tabel Dimensi

-- Tabel ProductCategories
CREATE TABLE ProductCategories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255),
    Description TEXT
);

-- Tabel Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(255),
    ContactNumber VARCHAR(50),
    Email VARCHAR(255),
    Address TEXT
);

-- Tabel ProductTypes
CREATE TABLE ProductTypes (
    TypeID INT PRIMARY KEY,
    TypeName VARCHAR(255),
    Description TEXT
);

-- Tabel Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    CategoryID INT,
    SupplierID INT,
    UnitPrice DECIMAL(10, 2),
    Stock INT,
    TypeID INT,
    FOREIGN KEY (CategoryID) REFERENCES ProductCategories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (TypeID) REFERENCES ProductTypes(TypeID)
);

-- Tabel Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ContactNumber VARCHAR(50),
    Email VARCHAR(255),
    Address TEXT
);

-- Tabel Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(255),
    ContactNumber VARCHAR(50),
    Email VARCHAR(255),
    Position VARCHAR(255)
);

-- Tabel Dates (dimensi waktu untuk tabel fakta)
CREATE TABLE Dates (
    DateID DATE PRIMARY KEY,
    Year INT,
    Month INT,
    Day INT,
    Week INT,
    Quarter INT
);

-- Tabel Discounts
CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY,
    DiscountName VARCHAR(255),
    DiscountType VARCHAR(50), -- e.g., 'Percentage', 'Flat Amount'
    DiscountValue DECIMAL(10, 2),
    StartDate DATE,
    EndDate DATE
);

-- Tabel Orders (dimensi untuk menghubungkan dengan fakta penjualan)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Tabel Fakta

-- Tabel Fakta Penjualan
CREATE TABLE FactSales (
    SaleID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    CustomerID INT,
    EmployeeID INT,
    DateID DATE,
    Amount DECIMAL(10, 2),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DateID) REFERENCES Dates(DateID)
);

-- Tabel Fakta Detail Penjualan
CREATE TABLE FactOrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tabel Fakta Pengadaan
CREATE TABLE FactProcurement (
    ProcurementID INT PRIMARY KEY,
    ProductID INT,
    SupplierID INT,
    DateID DATE,
    Quantity INT,
    Cost DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (DateID) REFERENCES Dates(DateID)
);

-- Tabel Fakta Konsinyasi
CREATE TABLE FactConsignment (
    ConsignmentID INT PRIMARY KEY,
    ProductID INT,
    SupplierID INT,
    DateID DATE,
    Quantity INT,
    Status VARCHAR(50),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (DateID) REFERENCES Dates(DateID)
);

-- Tabel Fakta Inventaris
CREATE TABLE FactInventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    DateID DATE,
    StockLevel INT,
    StockChange INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (DateID) REFERENCES Dates(DateID)
);

-- #############################
-- Data
-- #############################

INSERT INTO ProductCategories (CategoryID, CategoryName, Description) VALUES
(1, 'Monitor', 'Various sizes and types of monitors'),
(2, 'Keyboard', 'Different types of keyboards'),
(3, 'Mouse', 'Various models of computer mice'),
(4, 'Power Supply', 'Power supply units for computers'),
(5, 'CPU', 'Central Processing Units'),
(6, 'RAM', 'Random Access Memory modules'),
(7, 'Motherboard', 'Motherboards for PCs'),
(8, 'HDD & SSD', 'Hard Disk Drives and Solid State Drives'),
(9, 'Cables', 'Various types of computer cables'),
(10, 'Headset', 'Headphones with microphone for computers');

INSERT INTO Suppliers (SupplierID, SupplierName, ContactNumber, Email, Address) VALUES
(1, 'Supplier A', '123456789', 'supplierA@example.com', '123 Supplier St, Supplier City'),
(2, 'Supplier B', '987654321', 'supplierB@example.com', '456 Supplier Ave, Supplier Town'),
(3, 'Supplier C', '555123456', 'supplierC@example.com', '789 Supplier Blvd, Supplier Village');

INSERT INTO ProductTypes (TypeID, TypeName, Description) VALUES
(1, 'High-End', 'Top-tier products with premium features'),
(2, 'Medium-Level', 'Mid-range products suitable for general use'),
(3, 'Low-End', 'Entry-level products with basic features');

INSERT INTO Products (ProductID, ProductName, CategoryID, SupplierID, UnitPrice, Stock, TypeID) VALUES
(1, 'Monitor A', 1, 1, 200.00, 50, 1),
(2, 'Keyboard B', 2, 2, 30.00, 100, 2),
(3, 'Mouse C', 3, 3, 15.00, 200, 3),
(4, 'Power Supply D', 4, 1, 50.00, 80, 2),
(5, 'CPU E', 5, 2, 300.00, 30, 1),
(6, 'RAM F', 6, 3, 80.00, 150, 2),
(7, 'Motherboard G', 7, 1, 150.00, 70, 2),
(8, 'HDD H', 8, 2, 100.00, 90, 3),
(9, 'SSD I', 8, 3, 120.00, 60, 1),
(10, 'Cable J', 9, 1, 5.00, 300, 3),
(11, 'Headset K', 10, 2, 25.00, 120, 2);

INSERT INTO Customers (CustomerID, CustomerName, ContactNumber, Email, Address) VALUES
(1, 'Customer X', '111222333', 'customerX@example.com', '123 Customer St, Customer City'),
(2, 'Customer Y', '444555666', 'customerY@example.com', '456 Customer Ave, Customer Town'),
(3, 'Customer Z', '777888999', 'customerZ@example.com', '789 Customer Blvd, Customer Village');

INSERT INTO Employees (EmployeeID, EmployeeName, ContactNumber, Email, Position) VALUES
(1, 'Employee John', '555666777', 'john@example.com', 'Sales Representative'),
(2, 'Employee Jane', '888999000', 'jane@example.com', 'Store Manager'),
(3, 'Employee Jack', '111222333', 'jack@example.com', 'Customer Service');

INSERT INTO Dates (DateID, Year, Month, Day, Week, Quarter) VALUES
('2024-07-16', 2024, 7, 16, 29, 3),
('2024-07-15', 2024, 7, 15, 29, 3),
('2024-07-14', 2024, 7, 14, 29, 3),
('2024-07-13', 2024, 7, 13, 28, 3),
('2024-07-12', 2024, 7, 12, 28, 3),
('2024-07-11', 2024, 7, 11, 28, 3),
('2024-07-10', 2024, 7, 10, 28, 3),
('2024-07-09', 2024, 7, 9, 28, 3),
('2024-07-08', 2024, 7, 8, 27, 3),
('2024-07-07', 2024, 7, 7, 27, 3);

INSERT INTO Discounts (DiscountID, DiscountName, DiscountType, DiscountValue, StartDate, EndDate) VALUES
(1, 'Summer Sale', 'Percentage', 10.00, '2024-07-01', '2024-07-31'),
(2, 'Back to School', 'Flat Amount', 5.00, '2024-08-15', '2024-09-15');

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, TotalAmount) VALUES
(1, 1, 2, '2024-07-15', 400.00),
(2, 2, 1, '2024-07-14', 150.00),
(3, 3, 3, '2024-07-13', 800.00),
(4, 1, 2, '2024-07-12', 600.00),
(5, 2, 1, '2024-07-11', 200.00);

INSERT INTO FactSales (SaleID, OrderID, ProductID, CustomerID, EmployeeID, DateID, Amount, Quantity) VALUES
(1, 1, 1, 1, 2, '2024-07-15', 200.00, 1),
(2, 1, 2, 1, 2, '2024-07-15', 60.00, 2),
(3, 2, 3, 2, 1, '2024-07-14', 30.00, 2),
(4, 3, 4, 3, 3, '2024-07-13', 50.00, 1),
(5, 3, 5, 3, 3, '2024-07-13', 300.00, 1),
(6, 4, 6, 1, 2, '2024-07-12', 160.00, 2),
(7, 4, 7, 1, 2, '2024-07-12', 300.00, 2),
(8, 5, 8, 2, 1, '2024-07-11', 100.00, 1),
(9, 5, 9, 2, 1, '2024-07-11', 240.00, 2),
(10, 5, 10, 2, 1, '2024-07-11', 50.00, 2);

