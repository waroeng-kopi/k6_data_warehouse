CREATE DATABASE IF NOT EXISTS db_cdm_pos;
USE db_cdm_pos;

-- Tabel Produk
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2),
    StockQuantity INT
);

-- Tabel Kategori
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Tabel Pelanggan
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Address TEXT
);

-- Tabel Karyawan
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Position VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20)
);

-- Tabel Penjualan
CREATE TABLE Sale (
    SaleID INT PRIMARY KEY,
    Date DATE,
    TotalAmount DECIMAL(10, 2),
    PaymentMethod VARCHAR(100),
    CustomerID INT,
    EmployeeID INT,
    DiscountID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (DiscountID) REFERENCES Discount(DiscountID)
);

-- Tabel Detail Penjualan
CREATE TABLE SaleDetail (
    SaleDetailID INT PRIMARY KEY,
    SaleID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (SaleID) REFERENCES Sale(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Tabel Pembayaran
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    SaleID INT,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(100),
    PaymentDate DATE,
    Notes TEXT,
    FOREIGN KEY (SaleID) REFERENCES Sale(SaleID)
);

-- Tabel Diskon
CREATE TABLE Discount (
    DiscountID INT PRIMARY KEY,
    Name VARCHAR(255),
    Amount DECIMAL(10, 2),
    Type VARCHAR(50),
    StartDateTime DATETIME,
    EndDateTime DATETIME,
    Conditions TEXT,
    Status VARCHAR(50)
);

-- Dummy Data

INSERT INTO Product (ProductID, Name, Description, Price, StockQuantity) VALUES
(1, 'Keyboard', 'Mechanical keyboard with RGB lighting', 99.99, 50),
(2, 'Mouse', 'Wireless gaming mouse with adjustable DPI', 49.99, 30),
(3, 'Monitor', '27-inch IPS monitor with 144Hz refresh rate', 299.99, 20),
(4, 'Headset', 'Over-ear gaming headset with noise cancellation', 79.99, 40),
(5, 'Laptop', '15.6-inch gaming laptop with Intel i7 processor', 1299.99, 10),
(6, 'Webcam', '1080p webcam with built-in microphone', 39.99, 25),
(7, 'Speaker', 'Stereo speakers with bass boost', 59.99, 15),
(8, 'Printer', 'Color inkjet printer with wireless connectivity', 149.99, 20),
(9, 'External Hard Drive', '1TB USB 3.0 external hard drive', 79.99, 30),
(10, 'Smartphone', '5.5-inch smartphone with quad-core processor', 399.99, 20),
(11, 'Tablet', '10-inch tablet with retina display', 299.99, 15),
(12, 'Smartwatch', 'Fitness tracker with heart rate monitor', 149.99, 25),
(13, 'Router', 'Dual-band Wi-Fi router with gigabit Ethernet ports', 89.99, 20),
(14, 'Gaming Chair', 'Ergonomic gaming chair with lumbar support', 199.99, 10),
(15, 'USB Flash Drive', '64GB USB 3.0 flash drive', 19.99, 50),
(16, 'Wireless Earbuds', 'Bluetooth wireless earbuds with charging case', 79.99, 35),
(17, 'Desk Lamp', 'LED desk lamp with adjustable brightness', 29.99, 20),
(18, 'HDMI Cable', '6-foot HDMI cable for high-definition video', 9.99, 60),
(19, 'Bluetooth Speaker', 'Portable Bluetooth speaker with built-in battery', 49.99, 25),
(20, 'Power Bank', '10000mAh power bank with fast charging', 29.99, 40),
(21, 'Wireless Keyboard', 'Slim wireless keyboard with numeric keypad', 49.99, 30),
(22, 'Wireless Mouse', 'Optical wireless mouse with ergonomic design', 19.99, 45),
(23, 'USB-C Adapter', 'USB-C to HDMI and USB-A adapter', 24.99, 25),
(24, 'Gaming Headset Stand', 'RGB gaming headset stand with USB hub', 39.99, 20),
(25, 'Wireless Charging Pad', 'Qi-compatible wireless charging pad', 34.99, 30),
(26, 'MicroSD Card', '128GB microSDXC card with adapter', 29.99, 35),
(27, 'Bluetooth Keyboard Case', 'iPad keyboard case with Bluetooth connection', 59.99, 15),
(28, 'Wireless Presenter', 'Wireless presenter with laser pointer', 29.99, 25),
(29, 'Mechanical Gaming Keyboard', 'Tenkeyless mechanical gaming keyboard', 89.99, 20),
(30, 'External SSD', '500GB USB-C external solid-state drive', 149.99, 15),
(31, 'Smart Plug', 'Wi-Fi smart plug with app control', 19.99, 30),
(32, 'Wireless Router', 'Tri-band wireless router with MU-MIMO technology', 199.99, 10),
(33, 'Gaming Mouse Pad', 'Extended gaming mouse pad with RGB lighting', 29.99, 35),
(34, 'Bluetooth Earphones', 'Sweatproof Bluetooth earphones for sports', 39.99, 25),
(35, 'USB-C Charging Cable', 'USB-C to USB-C fast charging cable', 14.99, 50),
(36, 'USB Hub', '7-port USB 3.0 hub with individual switches', 24.99, 20),
(37, 'Wireless Gaming Controller', 'Bluetooth wireless gaming controller', 49.99, 15),
(38, 'Laptop Stand', 'Adjustable laptop stand with cooling fan', 34.99, 25),
(39, 'Portable Monitor', '15.6-inch portable monitor with HDMI input', 199.99, 10),
(40, 'USB Microphone', 'Condenser USB microphone for recording and streaming', 69.99, 20);


INSERT INTO Category (CategoryID, Name) VALUES
(1, 'Keyboard & Mouse'),
(2, 'Monitor & Display'),
(3, 'Audio & Headphones'),
(4, 'Printers & Scanners'),
(5, 'Storage & Drives'),
(6, 'Mobile Devices'),
(7, 'Networking'),
(8, 'Gaming Gear'),
(9, 'Accessories'),
(10, 'Office Essentials');


INSERT INTO Customer (CustomerID, Name, Email, Phone, Address) VALUES
(1, 'John Doe', 'john@example.com', '123-456-7890', '123 Main St, Cityville'),
(2, 'Jane Smith', 'jane@example.com', '987-654-3210', '456 Elm St, Townsville'),
(3, 'Bob Johnson', 'bob@example.com', '555-123-4567', '789 Oak St, Villageton'),
(4, 'Alice Williams', 'alice@example.com', '222-333-4444', '456 Pine St, Countryside'),
(5, 'David Brown', 'david@example.com', '333-444-5555', '789 Cedar St, Riverside'),
(6, 'Emily Jones', 'emily@example.com',l '777-888-9999', '1010 Maple St, Lakeside'),
(7, 'Michael Taylor', 'michael@example.com', '444-555-6666', '1212 Walnut St, Hillside'),
(8, 'Sophia Martinez', 'sophia@example.com', '666-777-8888', '1414 Oak St, Mountainside'),
(9, 'Olivia Garcia', 'olivia@example.com', '888-999-0000', '1616 Elm St, Beachside'),
(10, 'William Rodriguez', 'william@example.com', '999-000-1111', '1818 Pine St, Countryside'),
(11, 'Emma Hernandez', 'emma@example.com', '111-222-3333', '2020 Cedar St, Riverside'),
(12, 'Alexander Lopez', 'alexander@example.com', '222-333-4444', '2121 Maple St, Lakeside'),
(13, 'Daniel Hill', 'daniel@example.com', '333-444-5555', '2323 Walnut St, Hillside'),
(14, 'Ava Scott', 'ava@example.com', '444-555-6666', '2525 Oak St, Mountainside'),
(15, 'Mia Green', 'mia@example.com', '555-666-7777', '2727 Elm St, Beachside'),
(16, 'Benjamin Adams', 'benjamin@example.com', '666-777-8888', '2929 Pine St, Countryside'),
(17, 'Charlotte Baker', 'charlotte@example.com', '777-888-9999', '3030 Cedar St, Riverside'),
(18, 'Lucas Rivera', 'lucas@example.com', '888-999-0000', '3232 Maple St, Lakeside'),
(19, 'Harper Campbell', 'harper@examplel.com', '999-000-1111', '3434 Walnut St, Hillside'),
(20, 'Madison Mitchell', 'madison@example.com', '111-222-3333', '3636 Oak St, Mountainside'),
(21, 'Elijah Carter', 'elijah@example.com', '222-333-4444', '3838 Elm St, Beachside'),
(22, 'Avery Perez', 'avery@example.com', '333-444-5555', '4040 Pine St, Countryside'),
(23, 'Scarlett Collins', 'scarlett@example.com', '444-555-6666', '4242 Cedar St, Riverside'),
(24, 'Aria Turner', 'aria@example.com', '555-666-7777', '4444 Maple St, Lakeside'),
(25, 'Evelyn Parker', 'evelyn@example.com', '666-777-8888', '4646 Walnut St, Hillside'),
(26, 'Dylan Edwards', 'dylan@example.com', '777-888-9999', '4848 Oak St, Mountainside'),
(27, 'Luke Stewart', 'luke@example.com', '888-999-0000', '5050 Elm St, Beachside'),
(28, 'Zoey Sanchez', 'zoey@example.com', '999-000-1111', '5252 Pine St, Countryside'),
(29, 'Levi Morris', 'levi@example.com', '111-222-3333', '5454 Cedar St, Riverside'),
(30, 'Nora Rogers', 'nora@example.com', '222-333-4444', '5656 Maple St, Lakeside'),
(31, 'Liam James', 'liam@example.com', '333-444-5555', '5858 Walnut St, Hillside'),
(32, 'Hannah Watson', 'hannah@example.com', '444-555-6666', '6060 Oak St, Mountainside'),
(33, 'Grayson Brooks', 'grayson@example.com', '555-666-7777', '6262 Elm St, Beachside'),
(34, 'Lillian Cooper', 'lillian@example.com', '666-777-8888', '6464 Pine St, Countryside'),
(35, 'Caleb Richardson', 'caleb@example.com', '777-888-9999', '6666 Cedar St, Riverside'),
(36, 'Isabella Howard', 'isabella@example.com', '888-999-0000', '6868 Maple St, Lakeside'),
(37, 'Ethan Ward', 'ethan@example.com', '999-000-1111', '7070 Walnut St, Hillside'),
(38, 'Addison Evans', 'addison@example.com', '111-222-3333', '7272 Oak St, Mountainside'),
(39, 'Amelia Martinez', 'amelia@example.com', '222-333-4444', '7474 Elm St, Beachside'),
(40, 'Mason Russell', 'mason@example.com', '333-444-5555', '7676 Pine St, Countryside');


INSERT INTO Employee (EmployeeID, Name, Position, Email, Phone) VALUES
(1, 'Alice Johnson', 'Sales Associate', 'alice@example.com', '111-222-3333'),
(2, 'Bob Smith', 'Store Manager', 'bob@example.com', '444-555-6666'),
(3, 'Charlie Brown', 'Cashier', 'charlie@example.com', '777-888-9999'),
(4, 'David Wilson', 'Sales Associate', 'david@example.com', '222-333-4444'),
(5, 'Eva Miller', 'Sales Associate', 'eva@example.com', '555-666-7777'),
(6, 'Frank Davis', 'Store Manager', 'frank@example.com', '888-999-0000'),
(7, 'Grace Martinez', 'Cashier', 'grace@example.com', '333-444-5555'),
(8, 'Henry Anderson', 'Sales Associate', 'henry@example.com', '666-777-8888'),
(9, 'Ivy Thomas', 'Sales Associate', 'ivy@example.com', '999-000-1111'),
(10, 'Jack White', 'Store Manager', 'jack@example.com', '111-222-3333'),
(11, 'Kelly Lee', 'Cashier', 'kelly@example.com', '444-555-6666'),
(12, 'Liam Harris', 'Sales Associate', 'liam@example.com', '777-888-9999'),
(13, 'Mia Garcia', 'Sales Associate', 'mia@example.com', '222-333-4444'),
(14, 'Noah Martin', 'Store Manager', 'noah@example.com', '555-666-7777'),
(15, 'Olivia Brown', 'Cashier', 'olivia@example.com', '888-999-0000'),
(16, 'Parker Wilson', 'Sales Associate', 'parker@example.com', '333-444-5555'),
(17, 'Quinn Taylor', 'Sales Associate', 'quinn@example.com', '666-777-8888'),
(18, 'Riley Thomas', 'Store Manager', 'riley@example.com', '999-000-1111'),
(19, 'Sophia Rodriguez', 'Cashier', 'sophia@example.com', '111-222-3333'),
(20, 'Tyler Martinez', 'Sales Associate', 'tyler@example.com', '444-555-6666'),
(21, 'Uma Scott', 'Sales Associate', 'uma@example.com', '777-888-9999'),
(22, 'Vincent Lopez', 'Store Manager', 'vincent@example.com', '222-333-4444'),
(23, 'Willow Hill', 'Cashier', 'willow@example.com', '555-666-7777'),
(24, 'Xavier Carter', 'Sales Associate', 'xavier@example.com', '888-999-0000'),
(25, 'Yara Garcia', 'Sales Associate', 'yara@example.com', '333-444-5555'),
(26, 'Zachary Allen', 'Store Manager', 'zachary@example.com', '666-777-8888'),
(27, 'Abigail Perez', 'Cashier', 'abigail@example.com', '999-000-1111'),
(28, 'Benjamin Lee', 'Sales Associate', 'benjamin@example.com', '111-222-3333'),
(29, 'Cora Martin', 'Sales Associate', 'cora@example.com', '444-555-6666'),
(30, 'Daniel Adams', 'Store Manager', 'daniel@example.com', '777-888-9999'),
(31, 'Ella Brown', 'Cashier', 'ella@example.com', '222-333-4444'),
(32, 'Finn Wilson', 'Sales Associate', 'finn@example.com', '555-666-7777'),
(33, 'Georgia Taylor', 'Sales Associate', 'georgia@example.com', '888-999-0000'),
(34, 'Henry Martinez', 'Store Manager', 'henry@example.com', '333-444-5555'),
(35, 'Iris Rodriguez', 'Cashier', 'iris@example.com', '666-777-8888'),
(36, 'Jason Scott', 'Sales Associate', 'jason@example.com', '999-000-1111'),
(37, 'Kylie Lopez', 'Sales Associate', 'kylie@example.com', '111-222-3333'),
(38, 'Liam Garcia', 'Store Manager', 'liam@example.com', '444-555-6666'),
(39, 'Mila Hill', 'Cashier', 'mila@example.com', '777-888-9999'),
(40, 'Nolan Perez', 'Sales Associate', 'nolan@example.com', '222-333-4444');


INSERT INTO Sale (SaleID, Date, TotalAmount, PaymentMethod, CustomerID, EmployeeID, DiscountID) VALUES
(1, '2024-04-20', 150.99, 'Credit Card', 1, 2, NULL),
(2, '2024-04-20', 99.99, 'Cash', 2, 1, 1),
(3, '2024-04-21', 229.98, 'Debit Card', 3, 3, 2),
(4, '2024-04-22', 49.99, 'Cash', 4, 2, NULL),
(5, '2024-04-23', 349.99, 'Credit Card', 5, 3, NULL),
(6, '2024-04-24', 199.99, 'Debit Card', 6, 1, 2),
(7, '2024-04-25', 79.99, 'Cash', 7, 2, 1),
(8, '2024-04-26', 149.99, 'Credit Card', 8, 3, NULL),
(9, '2024-04-27', 29.99, 'Cash', 9, 1, NULL),
(10, '2024-04-28', 449.99, 'Debit Card', 10, 2, 2),
(11, '2024-04-29', 199.99, 'Cash', 11, 3, 1),
(12, '2024-04-30', 179.99, 'Credit Card', 12, 1, NULL),
(13, '2024-05-01', 99.99, 'Cash', 13, 2, NULL),
(14, '2024-05-02', 249.99, 'Credit Card', 14, 3, 2),
(15, '2024-05-03', 69.99, 'Debit Card', 15, 1, 1),
(16, '2024-05-04', 189.99, 'Cash', 16, 2, NULL),
(17, '2024-05-05', 319.99, 'Credit Card', 17, 3, 2),
(18, '2024-05-06', 39.99, 'Cash', 18, 1, NULL),
(19, '2024-05-07', 99.99, 'Credit Card', 19, 2, NULL),
(20, '2024-05-08', 59.99, 'Debit Card', 20, 3, 1),
(21, '2024-05-09', 129.99, 'Cash', 21, 1, 2),
(22, '2024-05-10', 79.99, 'Credit Card', 22, 2, NULL),
(23, '2024-05-11', 299.99, 'Debit Card', 23, 3, 1),
(24, '2024-05-12', 199.99, 'Cash', 24, 1, 2),
(25, '2024-05-13', 249.99, 'Credit Card', 25, 2, NULL),
(26, '2024-05-14', 49.99, 'Cash', 26, 3, NULL),
(27, '2024-05-15', 99.99, 'Debit Card', 27, 1, 1),
(28, '2024-05-16', 149.99, 'Cash', 28, 2, NULL),
(29, '2024-05-17', 199.99, 'Credit Card', 29, 3, NULL),
(30, '2024-05-18', 79.99, 'Debit Card', 30, 1, 2),
(31, '2024-05-19', 299.99, 'Cash', 31, 2, 1),
(32, '2024-05-20', 199.99, 'Credit Card', 32, 3, 2),
(33, '2024-05-21', 149.99, 'Debit Card', 33, 1, NULL),
(34, '2024-05-22', 79.99, 'Cash', 34, 2, NULL),
(35, '2024-05-23', 249.99, 'Credit Card', 35, 3, 1),
(36, '2024-05-24', 99.99, 'Debit Card', 36, 1, 2),
(37, '2024-05-25', 199.99, 'Cash', 37, 2, NULL),
(38, '2024-05-26', 299.99, 'Credit Card', 38, 3, 2),
(39, '2024-05-27', 149.99, 'Debit Card', 39, 1, 1),
(40, '2024-05-28', 79.99, 'Cash', 40, 2, NULL);


INSERT INTO SaleDetail (SaleDetailID, SaleID, ProductID, Quantity, UnitPrice, Subtotal) VALUES
(1, 1, 1, 1, 99.99, 99.99),
(2, 2, 2, 1, 49.99, 49.99),
(3, 3, 3, 2, 149.99, 299.98),
(4, 4, 4, 1, 79.99, 79.99),
(5, 5, 5, 1, 1299.99, 1299.99),
(6, 6, 6, 1, 39.99, 39.99),
(7, 7, 7, 1, 59.99, 59.99),
(8, 8, 8, 1, 149.99, 149.99),
(9, 9, 9, 1, 79.99, 79.99),
(10, 10, 10, 1, 399.99, 399.99),
(11, 11, 11, 1, 299.99, 299.99),
(12, 12, 12, 1, 149.99, 149.99),
(13, 13, 13, 1, 89.99, 89.99),
(14, 14, 14, 1, 199.99, 199.99),
(15, 15, 15, 1, 19.99, 19.99),
(16, 16, 16, 1, 79.99, 79.99),
(17, 17, 17, 1, 29.99, 29.99),
(18, 18, 18, 1, 9.99, 9.99),
(19, 19, 19, 1, 49.99, 49.99),
(20, 20, 20, 1, 29.99, 29.99),
(21, 21, 21, 1, 49.99, 49.99),
(22, 22, 22, 1, 19.99, 19.99),
(23, 23, 23, 1, 24.99, 24.99),
(24, 24, 24, 1, 39.99, 39.99),
(25, 25, 25, 1, 34.99, 34.99),
(26, 26, 26, 1, 29.99, 29.99),
(27, 27, 27, 1, 59.99, 59.99),
(28, 28, 28, 1, 29.99, 29.99),
(29, 29, 29, 1, 89.99, 89.99),
(30, 30, 30, 1, 149.99, 149.99),
(31, 31, 31, 1, 19.99, 19.99),
(32, 32, 32, 1, 199.99, 199.99),
(33, 33, 33, 1, 29.99, 29.99),
(34, 34, 34, 1, 39.99, 39.99),
(35, 35, 35, 1, 14.99, 14.99),
(36, 36, 36, 1, 24.99, 24.99),
(37, 37, 37, 1, 49.99, 49.99),
(38, 38, 38, 1, 34.99, 34.99),
(39, 39, 39, 1, 199.99, 199.99),
(40, 40, 40, 1, 69.99, 69.99);


INSERT INTO Payment (PaymentID, SaleID, Amount, PaymentMethod, PaymentDate, Notes) VALUES
(1, 1, 150.99, 'Credit Card', '2024-04-20', 'Payment successful'),
(2, 2, 99.99, 'Cash', '2024-04-20rgetar', 'Exact change provided'),
(3, 3, 229.98, 'Debit Card', '2024-04-21', 'Transaction ID: 123456'),
(4, 4, 49.99, 'Cash', '2024-04-22', 'Exact change provided'),
(5, 5, 349.99, 'Credit Card', '2024-04-23', 'Payment successful'),
(6, 6, 199.99, 'Debit Card', '2024-04-24', 'Transaction ID: 789012'),
(7, 7, 79.99, 'Cash', '2024-04-25', 'Exact change provided'),
(8, 8, 149.99, 'Credit Card', '2024-04-26', 'Payment successful'),
(9, 9, 29.99, 'Cash', '2024-04-27', 'Exact change provided'),
(10, 10, 449.99, 'Debit Card', '2024-04-28', 'Transaction ID: 345678'),
(11, 11, 199.99, 'Cash', '2024-04-29', 'Exact change provided'),
(12, 12, 179.99, 'Credit Card', '2024-04-30', 'Payment successful'),
(13, 13, 99.99, 'Cash', '2024-05-01', 'Exact change provided'),
(14, 14, 249.99, 'Credit Card', '2024-05-02', 'Payment successful'),
(15, 15, 69.99, 'Debit Card', '2024-05-03', 'Transaction ID: 234567'),
(16, 16, 189.99, 'Cash', '2024-05-04', 'Exact change provided'),
(17, 17, 319.99, 'Credit Card', '2024-05-05', 'Payment successful'),
(18, 18, 39.99, 'Cash', '2024-05-06', 'Exact change provided'),
(19, 19, 99.99, 'Credit Card', '2024-05-07', 'Payment successful'),
(20, 20, 59.99, 'Debit Card', '2024-05-08', 'Transaction ID: 456789'),
(21, 21, 129.99, 'Cash', '2024-05-09', 'Exact change provided'),
(22, 22, 79.99, 'Credit Card', '2024-05-10', 'Payment successful'),
(23, 23, 299.99, 'Debit Card', '2024-05-11', 'Transaction ID: 567890'),
(24, 24, 199.99, 'Cash', '2024-05-12', 'Exact change provided'),
(25, 25, 249.99, 'Credit Card', '2024-05-13', 'Payment successful'),
(26, 26, 49.99, 'Cash', '2024-05-14', 'Exact change provided'),
(27, 27, 99.99, 'Debit Card', '2024-05-15', 'Transaction ID: 678901'),
(28, 28, 149.99, 'Cash', '2024-05-16', 'Exact change provided'),
(29, 29, 199.99, 'Credit Card', '2024-05-17', 'Payment successful'),
(30, 30, 79.99, 'Debit Card', '2024-05-18', 'Transaction ID: 789012'),
(31, 31, 299.99, 'Cash', '2024-05-19', 'Exact change provided'),
(32, 32, 199.99, 'Credit Card', '2024-05-20', 'Payment successful'),
(33, 33, 149.99, 'Debit Card', '2024-05-21', 'Transaction ID: 890123'),
(34, 34, 79.99, 'Cash', '2024-05-22', 'Exact change provided'),
(35, 35, 249.99, 'Credit Card', '2024-05-23', 'Payment successful'),
(36, 36, 99.99, 'Debit Card', '2024-05-24', 'Transaction ID: 901234'),
(37, 37, 199.99, 'Cash', '2024-05-25', 'Exact change provided'),
(38, 38, 299.99, 'Credit Card', '2024-05-26', 'Payment successful'),
(39, 39, 149.99, 'Debit Card', '2024-05-27', 'Transaction ID: 012345'),
(40, 40, 79.99, 'Cash', '2024-05-28', 'Exact change provided');


INSERT INTO Discount (DiscountID, SaleID, Amount, Percentage) VALUES
(1, 2, 5.00, NULL),
(2, 3, 15.00, NULL),
(3, 6, NULL, 10.00),
(4, 7, 10.00, NULL),
(5, 10, NULL, 5.00),
(6, 11, 5.00, NULL),
(7, 14, 20.00, NULL),
(8, 15, NULL, 5.00),
(9, 20, 10.00, NULL),
(10, 21, NULL, 10.00),
(11, 23, 15.00, NULL),
(12, 24, 5.00, NULL),
(13, 27, NULL, 5.00),
(14, 30, 10.00, NULL),
(15, 31, 15.00, NULL),
(16, 35, NULL, 5.00),
(17, 36, 5.00, NULL),
(18, 39, 10.00, NULL);


-- Tabel Dimensi

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
