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

-- Tabel ProductDiscounts
CREATE TABLE ProductDiscounts (
    ProductDiscountID INT PRIMARY KEY,
    ProductID INT,
    DiscountID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (DiscountID) REFERENCES Discounts(DiscountID)
);

-- Tabel OrderDiscounts
CREATE TABLE OrderDiscounts (
    OrderDiscountID INT PRIMARY KEY,
    OrderID INT,
    DiscountID INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (DiscountID) REFERENCES Discounts(DiscountID)
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

-- Relationship

-- Tambahkan relasi antara Orders dan FactSales
ALTER TABLE FactSales
ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

-- Tambahkan relasi antara OrderDetails dan Orders
ALTER TABLE FactOrderDetails
ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

-- Tambahkan relasi untuk OrderDiscounts
ALTER TABLE OrderDiscounts
ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

-- ###################################
-- Data
-- ###################################

-- Tabel ProductCategories
INSERT INTO ProductCategories (CategoryID, CategoryName, Description) VALUES
(1, 'Monitor', 'Various types of computer monitors'),
(2, 'Keyboard', 'Mechanical and membrane keyboards'),
(3, 'Mouse', 'Optical and laser mice'),
(4, 'Power Supply', 'Different wattages of power supplies'),
(5, 'CPU', 'Central processing units'),
(6, 'RAM', 'Memory modules'),
(7, 'Motherboard', 'Various motherboards for different CPUs'),
(8, 'Storage', 'HDD and SSD storage devices'),
(9, 'Cables', 'Various types of computer cables'),
(10, 'Headset', 'Gaming and office headsets');

-- Tabel Suppliers
INSERT INTO Suppliers (SupplierID, SupplierName, ContactNumber, Email, Address) VALUES
(1, 'Supplier A', '123-456-7890', 'supplierA@example.com', '123 Supplier St, City, Country'),
(2, 'Supplier B', '123-456-7891', 'supplierB@example.com', '124 Supplier St, City, Country'),
(3, 'Supplier C', '123-456-7892', 'supplierC@example.com', '125 Supplier St, City, Country'),
(4, 'Supplier D', '123-456-7893', 'supplierD@example.com', '126 Supplier St, City, Country'),
(5, 'Supplier E', '123-456-7894', 'supplierE@example.com', '127 Supplier St, City, Country'),
(6, 'Supplier F', '123-456-7895', 'supplierF@example.com', '128 Supplier St, City, Country'),
(7, 'Supplier G', '123-456-7896', 'supplierG@example.com', '129 Supplier St, City, Country'),
(8, 'Supplier H', '123-456-7897', 'supplierH@example.com', '130 Supplier St, City, Country'),
(9, 'Supplier I', '123-456-7898', 'supplierI@example.com', '131 Supplier St, City, Country'),
(10, 'Supplier J', '123-456-7899', 'supplierJ@example.com', '132 Supplier St, City, Country');

-- Tabel ProductTypes
INSERT INTO ProductTypes (TypeID, TypeName, Description) VALUES
(1, 'High-end', 'High performance products'),
(2, 'Medium-level', 'Mid-range performance products'),
(3, 'Low-end', 'Entry-level performance products'),
(4, 'Gaming', 'Products designed for gaming'),
(5, 'Office', 'Products designed for office use'),
(6, 'Portable', 'Portable and lightweight products'),
(7, 'Ergonomic', 'Ergonomically designed products'),
(8, 'Wireless', 'Wireless connectivity products'),
(9, 'Wired', 'Wired connectivity products'),
(10, 'Budget', 'Budget-friendly products');

-- Tabel Products
INSERT INTO Products (ProductID, ProductName, CategoryID, SupplierID, UnitPrice, Stock, TypeID) VALUES
(1, 'Monitor A', 1, 1, 199.99, 50, 1),
(2, 'Keyboard B', 2, 2, 49.99, 100, 2),
(3, 'Mouse C', 3, 3, 29.99, 200, 3),
(4, 'Power Supply D', 4, 4, 99.99, 30, 4),
(5, 'CPU E', 5, 5, 299.99, 20, 5),
(6, 'RAM F', 6, 6, 79.99, 70, 6),
(7, 'Motherboard G', 7, 7, 149.99, 40, 7),
(8, 'HDD H', 8, 8, 59.99, 90, 8),
(9, 'Cable I', 9, 9, 9.99, 300, 9),
(10, 'Headset J', 10, 10, 39.99, 60, 10);

-- Tabel Customers
INSERT INTO Customers (CustomerID, CustomerName, ContactNumber, Email, Address) VALUES
(1, 'Customer A', '123-456-7890', 'customerA@example.com', '123 Customer St, City, Country'),
(2, 'Customer B', '123-456-7891', 'customerB@example.com', '124 Customer St, City, Country'),
(3, 'Customer C', '123-456-7892', 'customerC@example.com', '125 Customer St, City, Country'),
(4, 'Customer D', '123-456-7893', 'customerD@example.com', '126 Customer St, City, Country'),
(5, 'Customer E', '123-456-7894', 'customerE@example.com', '127 Customer St, City, Country'),
(6, 'Customer F', '123-456-7895', 'customerF@example.com', '128 Customer St, City, Country'),
(7, 'Customer G', '123-456-7896', 'customerG@example.com', '129 Customer St, City, Country'),
(8, 'Customer H', '123-456-7897', 'customerH@example.com', '130 Customer St, City, Country'),
(9, 'Customer I', '123-456-7898', 'customerI@example.com', '131 Customer St, City, Country'),
(10, 'Customer J', '123-456-7899', 'customerJ@example.com', '132 Customer St, City, Country');

-- Tabel Employees
INSERT INTO Employees (EmployeeID, EmployeeName, ContactNumber, Email, Position) VALUES
(1, 'Employee A', '123-456-7890', 'employeeA@example.com', 'Sales'),
(2, 'Employee B', '123-456-7891', 'employeeB@example.com', 'Sales'),
(3, 'Employee C', '123-456-7892', 'employeeC@example.com', 'Manager'),
(4, 'Employee D', '123-456-7893', 'employeeD@example.com', 'Support'),
(5, 'Employee E', '123-456-7894', 'employeeE@example.com', 'Sales'),
(6, 'Employee F', '123-456-7895', 'employeeF@example.com', 'Support'),
(7, 'Employee G', '123-456-7896', 'employeeG@example.com', 'Sales'),
(8, 'Employee H', '123-456-7897', 'employeeH@example.com', 'Manager'),
(9, 'Employee I', '123-456-7898', 'employeeI@example.com', 'Support'),
(10, 'Employee J', '123-456-7899', 'employeeJ@example.com', 'Sales');

-- Tabel Orders
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, TotalAmount) VALUES
(1, 1, 1, '2024-01-01', 200.00),
(2, 2, 2, '2024-01-02', 150.00),
(3, 3, 3, '2024-01-03', 300.00),
(4, 4, 4, '2024-01-04', 400.00),
(5, 5, 5, '2024-01-05', 250.00),
(6, 6, 6, '2024-01-06', 350.00),
(7, 7, 7, '2024-01-07', 450.00),
(8, 8, 8, '2024-01-08', 500.00),
(9, 9, 9, '2024-01-09', 550.00),
(10, 10, 10, '2024-01-10', 600.00);

-- Tabel OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice, TotalPrice) VALUES
(1, 1, 1, 1, 199.99, 199.99),
(2, 2, 2, 3, 49.99, 149.97),
(3, 3, 3, 10, 29.99, 299.90),
(4, 4, 4, 2, 99.99, 199.98),
(5, 5, 5, 4, 59.99, 239.96),
(6, 6, 6, 5, 79.99, 399.95),
(7, 7, 7, 1, 149.99, 149.99),
(8, 8, 8, 6, 59.99, 359.94),
(9, 9, 9, 7, 9.99, 69.93),
(10, 10, 10, 2, 39.99, 79.98);

-- Tabel Inventory
INSERT INTO Inventory (ProductID, QuantityInStock) VALUES
(1, 50),
(2, 100),
(3, 200),
(4, 30),
(5, 20),
(6, 70),
(7, 40),
(8, 90),
(9, 300),
(10, 60);

-- Tabel Consignments
INSERT INTO Consignments (ConsignmentID, SupplierID, ProductID, ConsignmentDate, Quantity, Status) VALUES
(1, 1, 1, '2024-01-01', 50, 'Pending'),
(2, 2, 2, '2024-01-02', 100, 'Delivered'),
(3, 3, 3, '2024-01-03', 200, 'In Transit'),
(4, 4, 4, '2024-01-04', 30, 'Delivered'),
(5, 5, 5, '2024-01-05', 20, 'Pending'),
(6, 6, 6, '2024-01-06', 70, 'In Transit'),
(7, 7, 7, '2024-01-07', 40, 'Delivered'),
(8, 8, 8, '2024-01-08', 90, 'Pending'),
(9, 9, 9, '2024-01-09', 300, 'In Transit'),
(10, 10, 10, '2024-01-10', 60, 'Delivered');

-- Tabel Procurement
INSERT INTO Procurement (ProcurementID, ProductID, SupplierID, OrderDate, DeliveryDate, Quantity, Status) VALUES
(1, 1, 1, '2024-01-01', '2024-01-10', 50, 'Delivered'),
(2, 2, 2, '2024-01-02', '2024-01-11', 100, 'In Transit'),
(3, 3, 3, '2024-01-03', '2024-01-12', 200, 'Pending'),
(4, 4, 4, '2024-01-04', '2024-01-13', 30, 'Delivered'),
(5, 5, 5, '2024-01-05', '2024-01-14', 20, 'In Transit'),
(6, 6, 6, '2024-01-06', '2024-01-15', 70, 'Pending'),
(7, 7, 7, '2024-01-07', '2024-01-16', 40, 'Delivered'),
(8, 8, 8, '2024-01-08', '2024-01-17', 90, 'In Transit'),
(9, 9, 9, '2024-01-09', '2024-01-18', 300, 'Pending'),
(10, 10, 10, '2024-01-10', '2024-01-19', 60, 'Delivered');

-- Tabel Dates (dimensi waktu untuk tabel fakta)
INSERT INTO Dates (DateID, Year, Month, Day, Week, Quarter) VALUES
('2024-01-01', 2024, 1, 1, 1, 1),
('2024-01-02', 2024, 1, 2, 1, 1),
('2024-01-03', 2024, 1, 3, 1, 1),
('2024-01-04', 2024, 1, 4, 1, 1),
('2024-01-05', 2024, 1, 5, 1, 1),
('2024-01-06', 2024, 1, 6, 1, 1),
('2024-01-07', 2024, 1, 7, 1, 1),
('2024-01-08', 2024, 1, 8, 2, 1),
('2024-01-09', 2024, 1, 9, 2, 1),
('2024-01-10', 2024, 1, 10, 2, 1);

-- Tabel Fakta Penjualan
INSERT INTO FactSales (SaleID, OrderID, ProductID, CustomerID, EmployeeID, DateID, Amount, Quantity) VALUES
(1, 1, 1, 1, 1, '2024-01-01', 199.99, 1),
(2, 2, 2, 2, 2, '2024-01-02', 149.97, 3),
(3, 3, 3, 3, 3, '2024-01-03', 299.90, 10),
(4, 4, 4, 4, 4, '2024-01-04', 199.98, 2),
(5, 5, 5, 5, 5, '2024-01-05', 239.96, 4),
(6, 6, 6, 6, 6, '2024-01-06', 399.95, 5),
(7, 7, 7, 7, 7, '2024-01-07', 149.99, 1),
(8, 8, 8, 8, 8, '2024-01-08', 359.94, 6),
(9, 9, 9, 9, 9, '2024-01-09', 69.93, 7),
(10, 10, 10, 10, 10, '2024-01-10', 79.98, 2);

-- Tabel Fakta Detail Penjualan
INSERT INTO FactOrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice, TotalPrice) VALUES
(1, 1, 1, 1, 199.99, 199.99),
(2, 2, 2, 3, 49.99, 149.97),
(3, 3, 3, 10, 29.99, 299.90),
(4, 4, 4, 2, 99.99, 199.98),
(5, 5, 5, 4, 59.99, 239.96),
(6, 6, 6, 5, 79.99, 399.95),
(7, 7, 7, 1, 149.99, 149.99),
(8, 8, 8, 6, 59.99, 359.94),
(9, 9, 9, 7, 9.99, 69.93),
(10, 10, 10, 2, 39.99, 79.98);

-- Tabel Fakta Pengadaan
INSERT INTO FactProcurement (ProcurementID, ProductID, SupplierID, DateID, Quantity, Cost) VALUES
(1, 1, 1, '2024-01-01', 50, 5000.00),
(2, 2, 2, '2024-01-02', 100, 5000.00),
(3, 3, 3, '2024-01-03', 200, 5000.00),
(4, 4, 4, '2024-01-04', 30, 5000.00),
(5, 5, 5, '2024-01-05', 20, 5000.00),
(6, 6, 6, '2024-01-06', 70, 5000.00),
(7, 7, 7, '2024-01-07', 40, 5000.00),
(8, 8, 8, '2024-01-08', 90, 5000.00),
(9, 9, 9, '2024-01-09', 300, 5000.00),
(10, 10, 10, '2024-01-10', 60, 5000.00);

-- Tabel Fakta Konsinyasi
INSERT INTO FactConsignment (ConsignmentID, ProductID, SupplierID, DateID, Quantity, Status) VALUES
(1, 1, 1, '2024-01-01', 50, 'Pending'),
(2, 2, 2, '2024-01-02', 100, 'Delivered'),
(3, 3, 3, '2024-01-03', 200, 'In Transit'),
(4, 4, 4, '2024-01-04', 30, 'Delivered'),
(5, 5, 5, '2024-01-05', 20, 'Pending'),
(6, 6, 6, '2024-01-06', 70, 'In Transit'),
(7, 7, 7, '2024-01-07', 40, 'Delivered'),
(8, 8, 8, '2024-01-08', 90, 'Pending'),
(9, 9, 9, '2024-01-09', 300, 'In Transit'),
(10, 10, 10, '2024-01-10', 60, 'Delivered');

-- Tabel Fakta Inventaris
INSERT INTO FactInventory (InventoryID, ProductID, DateID, StockLevel, StockChange) VALUES
(1, 1, '2024-01-01', 50, 0),
(2, 2, '2024-01-02', 100, 0),
(3, 3, '2024-01-03', 200, 0),
(4, 4, '2024-01-04', 30, 0),
(5, 5, '2024-01-05', 20, 0),
(6, 6, '2024-01-06', 70, 0),
(7, 7, '2024-01-07', 40, 0),
(8, 8, '2024-01-08', 90, 0),
(9, 9, '2024-01-09', 300, 0),
(10, 10, '2024-01-10', 60, 0);
