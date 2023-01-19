DROP SCHEMA IF EXISTS DomoDealership;

CREATE SCHEMA IF NOT EXISTS DomoDealership;

USE DomoDealership;
drop table if exists Branch;
drop table if exists Customer;
drop table if exists Car;
drop table if exists CustomerPhoneNumber;
drop table if exists Staff;
drop table if exists StaffPhoneNumber;
drop table if exists BranchClient;
drop table if exists Invoice;
drop table if exists ProducedInvoice;

create table Branch (
    BranchNumber varchar(4) not null,
    BranchName varchar(50),
    Inventory int,
    primary key (BranchNumber)
);

create table Customer (
    CustomerID varchar(10) not null,
    fName varchar(20) not null,
    lName varchar(20) not null,
    Street varchar(30) not null,
    Town varchar(30),
    County varchar(30) not null,
    EmailAddress varchar(30),
    primary key (CustomerID)
);

create table CustomerPhoneNumber (
    PhoneNumber varchar(16) not null,
    CustomerID varchar(10) not null,
    primary key (PhoneNumber),
    foreign key (CustomerID) references Customer(CustomerID) on update cascade on delete cascade
);

create table Car (
    VIN varchar(20) not null,
    Manufacturer varchar(20) not null,
    Model varchar(20) not null,
    Color varchar(20) not null,
    Price decimal(10, 2) not null,
    Used boolean,
    Mileage int,
    BranchNumber varchar(4) not null,
    CustomerID varchar(10),
    primary key (VIN),
    foreign Key (BranchNumber) references Branch(BranchNumber) on update cascade on delete cascade,
    foreign Key (CustomerID) references Customer(CustomerID) on update cascade on delete cascade
);

create table Staff (
    EmployeeID varchar(8) not null,
    fName varchar(20) not null,
    lName varchar(20) not null,
    Street varchar(20) not null,
    Town varchar(20),
    County varchar(15) not null,
    sRole varchar(20) not null,
    Salary int,
    EmailAddress varchar(50),
    Supervisor varchar(8),
    BranchNumber varchar(4) not null,
    primary key (EmployeeID),
    foreign key (BranchNumber) references Branch(BranchNumber) on update cascade on delete cascade,
    foreign key (Supervisor) references Staff(EmployeeID) on update cascade on delete cascade
);

create table StaffPhoneNumber (
    EmployeeID varchar(8) not null,
    PhoneNumber varchar(16) not null,
    primary key (EmployeeID),
    foreign key (EmployeeID) references Staff(EmployeeID) on update cascade on delete cascade
);

create table BranchClient (
    TransactionID varchar(5) not null,
    EmployeeID varchar(8) not null,
    CustomerID varchar(10) not null,
    primary key (TransactionID),
    foreign key (EmployeeID) references Staff(EmployeeID) on update cascade on delete cascade,
    foreign Key (CustomerID) references Customer(CustomerID) on update cascade on delete cascade
);

create table Invoice (
    InvoiceID varchar (5) not null,
    PaymentType varchar(15),
    Amount decimal(10,2),
    EmployeeID varchar(8) not null,
    primary key (InvoiceID),
    foreign key (EmployeeID) references Staff(EmployeeID) on update cascade on delete cascade
);

-- create table ProducedInvoice (
--     EmployeeID varchar(8) not null,
--     InvoiceID varchar (5) not null,
--     primary key (EmployeeID, InvoiceID),
--     foreign key (EmployeeID) references Staff(EmployeeID) on update cascade on delete cascade,
--     foreign key (InvoiceID) references Invoice(InvoiceID) on update cascade on delete cascade
-- );

insert into Branch values 
(3542, 'Waterford', 7),
(5832, 'Wexford', 4),
(2631, 'Kilkenny', 3);

insert into Customer values
('7006600537', 'Davie', 'Franklyn', 'Ballyellis', 'Waterford City', 'Co. Waterford', 'fdavie@outlook.com'),
('4443095233', 'Polly', 'Yu', '38 Bridge Street', 'Tramore', 'Co. Waterford', 'yupo1177@yahoo.com'),
('5481407381', 'Finn', 'Badcock', '2 Hartstonge', 'Waterford City', 'Co. Waterford', 'badcockf@gmail.com'),
('9560946448', 'Houssam', 'Penner', '9 Castletroy', 'Waterford City', 'Co. Waterford', 'pphou342@gmail.com'),
('0421752754', 'Michal', 'Andrysiak', '46 Elm Court', 'Dunmore East', 'Co. Waterford', 'partyboi123@gmail.com'),
('0784490885', 'Siva', 'Wilcox', '65 Heatherview', 'Portlaw', 'Co. Waterford', 'willsi23@outlook.com'),
('6585600033', 'Sebastian', 'McGowan', '37 The Village', 'Tramore', 'Co. Waterford', 'lovesmecounty@gmail.com'),
('8253285497', 'Eamon', 'El-Hashem', 'Ballybunion', 'Waterford City', 'Co. Waterford', 'eamonel@gmail.com'),
('1092314981', 'Cathleen', 'Bennington', 'Newbridge', 'Dunmore East', 'Co. Waterford', 'bennington873@gmail.com');

insert into CustomerPhoneNumber VALUES
('+353 20 912 0886', '7006600537'),
('+353 20 916 2220', '4443095233'),
('+353 20 911 5112', '5481407381'),
('+353 20 914 4641', '9560946448'),
('+353 20 916 6010', '0421752754'),
('+353 20 912 5059', '0784490885'),
('+353 20 916 8618', '6585600033'),
('+353 20 913 1399', '8253285497'),
('+353 20 916 3220', '1092314981');

insert into Car VALUES
('3GCPKTE79DG321682', 'Toyota', 'Yaris', 'White', 16000.00, true, 68328, 3542, null),
('1FDKF37G7VEB91210', 'Honda', 'Accord', 'Blue', 12000.00, true, 89836, 3542, null),
('3GTU2VEC5EG543181', 'Toyota', 'Avensis', 'Blue', 8000.00, true, 124935, 3542, '7006600537'),
('1G4CU541214116484', 'Suzuki', 'Jimney', 'Red', 7400.00, true, 93054, 3542, '4443095233'),
('1GNSCBE01BR111893', 'Mazda', 'MX-5', 'Soul Red', 24000.00, false, 13, 3542, null),
('1FMDK02107GA04631', 'Nissan', 'Micra', 'White', 18000.00, false, 8, 3542, '5481407381'),
('1XKAD49X79J253652', 'BMW', '320i', 'Silver', 37000.00, false, 0, 5832, null),
('WBAAM3337YCA11927', 'BMW', '520d', 'Navy', 12000.00, true, 54000, 3542, '9560946448'),
('5N1AA0NE6FN666972', 'Nissan', '370z', 'White', 10000.00, true, 85328, 5832, '0421752754'),
('1FDKF37G5TEB67050', 'Honda', 'CRV', 'White', 14000.00, true, 64234, 5832, null),
('1HGCR2F33EA122838', 'Toyota', 'Supra', 'Crimson Red', 37000.00, false, 25, 5832, null),
('2T2BK1BA3CC169403', 'Alfa Romeo', 'Gulia', 'Red', 23000.00, true, 114325, 2631, '0784490885'),
('WMWRE33586TJ74839', 'Ford', 'Fiesta', 'Red', 5200.00, true, 119435, 2631, null),
('1N6AD0EV4CC469329', 'Volkswagen', 'Passat', 'White', 25700.00, true, 189232,  2631, null);

insert into Staff VALUES
('18665792', 'Ozzy', 'Domo', '43 Ballygunner', 'Dunmore East', 'Waterford', 'Owner', null, 'odomo5322@gmail.com', null, 3542),
('47354164', 'James', 'Irish', '317 Ballygunner', 'Waterford', 'Co. Waterford', 'Supervisor', 48000, 'jirish@outlook.com', '18665792', 3542),
('19435114', 'Darragh', 'Murphy', '86 Ballinamona Woods', 'Waterford', 'Co. Waterford', 'Accounts', 67000, 'creativeaccounting@gmail.com', '18665792', 3542),
('81608220', 'Shane', 'Power', 'Tiranee', 'Tramore', 'Co. Waterford', 'Sales', 39000, 'popos32@gmail.com', '47354164', 3542),
('69137945', 'Joanne', 'McNulty', '32 The Glen', 'Ferrybank', 'Co. Kilkenny', 'Sales', 3900, 'mcjo52@gmail.com', '47354164', 3542);

insert into StaffPhoneNumber VALUES
('18665792', '+353 20 912 2592'),
('47354164', '+353 20 919 1794'),
('19435114', '+353 20 911 0561'),
('81608220', '+353 20 910 9355'),
('69137945', '+353 20 918 6700');

INSERT INTO BranchClient VALUES
('84390', '81608220', '7006600537'),
('85634', '81608220', '4443095233'),
('22473', '69137945', '5481407381'),
('59127', '81608220', '9560946448'),
('67949', '69137945', '0421752754'),
('48019', '69137945', '0784490885'),
('41807', '69137945', '6585600033'),
('80303', '81608220', '8253285497'),
('69537', '81608220', '1092314981');

INSERT INTO Invoice VALUES
('33092', 'Visa', 8000.00, '19435114'),
('81038', 'Visa', 7400.00, '19435114'),
('26590', 'Master Card', 18000.00, '19435114'),
('47098', 'Visa', 12000.00, '19435114'),
('52940', 'Cash', 10000.00, '19435114');
