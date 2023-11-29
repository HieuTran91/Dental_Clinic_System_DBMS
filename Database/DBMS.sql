﻿USE MASTER
GO
IF DB_ID('QLPHONGKHAMNHAKHOA') IS NOT NULL
	DROP DATABASE QLPHONGKHAMNHAKHOA
GO

CREATE DATABASE QLPHONGKHAMNHAKHOA
GO

USE QLPHONGKHAMNHAKHOA
GO

--table ACCOUNT
CREATE TABLE Account
(
	account_id char(5),
	username varchar(10) NOT NULL UNIQUE,
	[password] varchar(15),
	account_status BIT,
	[role] char(2)

	CONSTRAINT PK_Account
	PRIMARY KEY (account_id)
)

--table ADMIN
CREATE TABLE [Admin]
(
	account_id char(5),
	admin_name nvarchar(30)

	CONSTRAINT PK_Admin
	PRIMARY KEY(account_id)
)

--table STAFF
CREATE TABLE Staff
(
	account_id char(5),
	staff_name nvarchar(30)

	CONSTRAINT PK_Staff
	PRIMARY KEY(account_id)
)

--table DENTIST
CREATE TABLE Dentist
(
	account_id char(5),
	dentist_name nvarchar(30)

	CONSTRAINT PK_Dentist
	PRIMARY KEY(account_id)
)

--table personalAppointment
CREATE TABLE personalAppointment
(
	personal_appointment_id char(5),
	personal_appointment_start_time time NOT NULL,
	personal_appointment_end_time time NOT NULL,
	personal_appointment_date date,
	dentist_id char(5)

	CONSTRAINT PK_personalAppointment
	PRIMARY KEY(personal_appointment_id)
)
--table PATIENT
CREATE TABLE Patient
(
	patient_id char(5),
	patient_name nvarchar(30),
	patient_birthday DATE,
	patient_address nvarchar(40),
	patient_phone char(10)

	CONSTRAINT PK_Patient
	PRIMARY KEY(patient_id)
)


--table APPOINTMENT
CREATE TABLE Appointment
(
	patient_id char(5),
	dentist_id char(5),
	appointment_id char(5),
	appointment_start_time time NOT NULL,
	appointment_end_time time NOT NULL,
	appointment_date date

	CONSTRAINT PK_Appointment
	PRIMARY KEY(patient_id, dentist_id, appointment_id)
)

--table MEDICAL_RECORD
CREATE TABLE MedicalRecord
(
	medical_record_id char(5),
	examination_date date,
	pay_status bit,
	patient_id char(5),
	dentist_id char(5),
	appointment_id char(5)

	CONSTRAINT PK_MedicalRecord
	PRIMARY KEY (medical_record_id)
)

--table BILL
CREATE TABLE Bill
(
	bill_id char(5),
	service_cost money,
	appointment_cost money,
	drugs_cost money,
	cost_total money,
	payment_date date,
	patient_id char(5),
	medical_record_id char(5)

	CONSTRAINT PK_Bill
	PRIMARY KEY(bill_id)
)

--table SERVICE
CREATE TABLE [Service]
(
	service_id char(5),
	[service_name] nvarchar(30),
	cost money

	CONSTRAINT PK_Service
	PRIMARY KEY(service_id)
)


--table service_list
CREATE TABLE ServiceList
(
	service_id char(5),
	medical_record_id char(5),
	service_quantity int

	CONSTRAINT PK_SERVICES
	PRIMARY KEY	(medical_record_id, service_id)
)
--table PRESCRIPTION
CREATE TABLE Prescription
(
	drug_id char(5),
	medical_record_id char(5),
	drug_quantity int NOT NULL Check (drug_quantity>=1)

	CONSTRAINT PK_Prescription
	PRIMARY KEY(medical_record_id, drug_id)
)

--table DRUG 
CREATE TABLE Drug
(
	drug_id char(5),
	unit varchar(5),
	drug_name nvarchar(30),
	indication nvarchar(50),
	expiration_date date,
	price money,
	drug_stock_quantity int

	CONSTRAINT PK_Drug
	PRIMARY KEY (drug_id)
)


--rang buoc
ALTER TABLE [Admin]
ADD
	CONSTRAINT FK_Admin_Account
	FOREIGN KEY (account_id)
	REFERENCES Account
ALTER TABLE Staff
ADD
	CONSTRAINT FK_Staff_Account
	FOREIGN KEY (account_id)
	REFERENCES Account
ALTER TABLE Dentist
ADD
	CONSTRAINT FK_Dentist_Account
	FOREIGN KEY (account_id)
	REFERENCES Account
ALTER TABLE Patient
ADD
	CONSTRAINT FK_Patinet_Account
	FOREIGN KEY (patient_id)
	REFERENCES Account
ALTER TABLE personalAppointment
ADD
	CONSTRAINT FK_personalAppointment_Dentist
	FOREIGN KEY (dentist_id)
	REFERENCES Dentist

ALTER TABLE Bill
ADD
	CONSTRAINT FK_Bill_Patient
	FOREIGN KEY (patient_id)
	REFERENCES Patient,

	CONSTRAINT FK_Bill_MedicalRecord
	FOREIGN KEY (medical_record_id)
	REFERENCES MedicalRecord

ALTER TABLE MedicalRecord
ADD
	CONSTRAINT FK_MedicalRecord_Patient
	FOREIGN KEY (patient_id)
	REFERENCES Patient,

	CONSTRAINT FK_MedicalRecord_Dentist
	FOREIGN KEY (dentist_id)
	REFERENCES Dentist,
	
	CONSTRAINT FK_MedicalRecord_Appointment
	FOREIGN KEY (patient_id, dentist_id, appointment_id)
	REFERENCES Appointment


ALTER TABLE Appointment
ADD
	CONSTRAINT FK_Appointment_Patient
	FOREIGN KEY (patient_id)
	REFERENCES Patient,

	CONSTRAINT FK_Appointment_Dentist
	FOREIGN KEY (dentist_id)
	REFERENCES Dentist

ALTER TABLE Prescription
ADD
	CONSTRAINT FK_Prescription_Drug
	FOREIGN KEY (drug_id)
	REFERENCES Drug,

	CONSTRAINT FK_Prescription_MedicalRecord
	FOREIGN KEY (medical_record_id)
	REFERENCES MedicalRecord

ALTER TABLE ServiceList
ADD
	CONSTRAINT FK_ServiceList_Service
	FOREIGN KEY (service_id)
	REFERENCES [Service],

	CONSTRAINT FK_ServiceList_MedicalRecord
	FOREIGN KEY (medical_record_id)
	REFERENCES MedicalRecord

INSERT INTO Account (account_id, username, password, role)
VALUES
('PA001', 'patient1', '123456', 'PA'),
('PA002', 'patient2', '123456', 'PA'),
('PA003', 'patient3', '123456', 'PA'),
('PA004', 'patient4', '123456', 'PA'),
('PA005', 'patient5', '123456', 'PA'),
('AD001', 'admin1', '123456', 'AD'),
('AD002', 'admin2', '123456', 'AD'),
('ST001', 'staff1', '123456', 'ST'),
('ST002', 'staff2', '123456', 'ST'),
('ST003', 'staff3', '123456', 'ST'),
('DE001', 'dentist1', '123456', 'DE'),
('DE002', 'dentist2', '123456', 'DE'),
('PA006', 'patient6', '123456', 'PA'),
('PA007', 'patient7', '123456', 'PA'),
('PA008', 'patient8', '123456', 'PA'),
('PA009', 'patient9', '123456', 'PA'),
('PA010', 'patient10', '123456', 'PA'),
('AD003', 'admin3', '123456', 'AD'),
('ST004', 'staff4', '123456', 'ST'),
('ST005', 'staff5', '123456', 'ST'),
('DE003', 'dentist3', '123456', 'DE'),
('DE004', 'dentist4', '123456', 'DE'),
('PA011', 'patient11', '123456', 'PA'),
('PA012', 'patient12', '123456', 'PA'),
('PA013', 'patient13', '123456', 'PA'),
('PA014', 'patient14', '123456', 'PA'),
('PA015', 'patient15', '123456', 'PA'),
('AD004', 'admin4', '123456', 'AD'),
('ST006', 'staff6', '123456', 'ST'),
('ST007', 'staff7', '123456', 'ST'),
('DE005', 'dentist5', '123456', 'DE'),
('DE006', 'dentist6', '123456', 'DE'),
('PA016', 'patient16', '123456', 'PA'),
('PA017', 'patient17', '123456', 'PA'),
('PA018', 'patient18', '123456', 'PA'),
('PA019', 'patient19', '123456', 'PA'),
('PA020', 'patient20', '123456', 'PA');

INSERT INTO Staff (account_id, staff_name)
VALUES
('ST001', 'Staff 1'),
('ST002', 'Staff 2'),
('ST003', 'Staff 3'),
('ST004', 'Staff 4'),
('ST005', 'Staff 5'),
('ST006', 'Staff 6'),
('ST007', 'Staff 7');

INSERT INTO Admin (account_id, admin_name)
VALUES
('AD001', 'Admin 1'),
('AD002', 'Admin 2'),
('AD003', 'Admin 3'),
('AD004', 'Admin 4');

INSERT INTO Dentist (account_id, dentist_name)
VALUES
('DE001', 'Dentist 1'),
('DE002', 'Dentist 2'),
('DE003', 'Dentist 3'),
('DE004', 'Dentist 4'),
('DE005', 'Dentist 5'),
('DE006', 'Dentist 6');

INSERT INTO Drug (drug_id, unit, drug_name, indication, expiration_date, price, drug_stock_quantity)
VALUES
('DR001', 'viên', 'Paracetamol', 'Giảm đau, hạ sốt', '2024-07-20', 10000, 100),
('DR002', 'viên', 'Ibuprofen', 'Giảm đau, viêm', '2024-08-20', 20000, 200),
('DR003', 'viên', 'Amoxicillin', 'Điều trị nhiễm trùng răng miệng', '2024-09-20', 30000, 300),
('DR004', 'viên', 'Metronidazole', 'Điều trị nhiễm trùng răng miệng do vi khuẩn kỵ khí', '2024-10-20', 40000, 400),
('DR005', 'viên', 'Fluconazole', 'Điều trị nhiễm trùng răng miệng do nấm', '2024-11-20', 50000, 500),
('DR006', 'ml', 'Benzocaine', 'Gây tê tại chỗ', '2024-12-20', 60000, 600),
('DR007', 'ml', 'Lidocain', 'Gây tê tại chỗ', '2025-01-20', 70000, 700),
('DR008', 'ml', 'Xylocain', 'Gây tê tại chỗ', '2025-02-20', 80000, 800),
('DR009', 'ml', 'Hyaluronic Acid', 'Dưỡng ẩm nướu răng', '2025-03-20', 90000, 900),
('DR010', 'ml', 'Fluoride', 'Chống sâu răng', '2025-04-20', 100000, 1000),
('DR011', 'ml', 'Canxi', 'Củng cố men răng', '2025-05-20', 110000, 1100),
('DR012', 'ml', 'Vitamin D3', 'Hỗ trợ hấp thụ canxi', '2025-06-20', 120000, 1200),
('DR013', 'viên', 'Thuốc xịt chống sâu răng', 'Chống sâu răng', '2025-07-20', 130000, 1300),
('DR014', 'viên', 'Thuốc súc miệng', 'Vệ sinh răng miệng', '2025-08-20', 140000, 1400),
('DR015', 'viên', 'Thuốc đánh răng', 'Vệ sinh răng miệng', '2025-09-20', 150000, 1500),
('DR016', 'viên', 'Dây thun nha khoa', 'Loại bỏ mảng bám', '2025-10-20', 160000, 1600);

INSERT INTO Service (service_id, service_name, cost)
VALUES
('SV001', 'Khám răng tổng quát', 100000),
('SV002', 'Lấy cao răng', 50000),
('SV003', 'Điều trị tủy răng', 200000),
('SV004', 'Nhổ răng', 100000),
('SV005', 'Gắn cầu răng sứ', 5000000),
('SV006', 'Bọc răng sứ', 2000000),
('SV007', 'Veneer răng sứ', 1000000),
('SV008', 'Tẩy trắng răng', 500000),
('SV009', 'Niềng răng mắc cài kim loại', 20000000),
('SV010', 'Niềng răng mắc cài sứ', 30000000),
('SV011', 'Niềng răng trong suốt', 40000000),
('SV012', 'Trồng răng implant', 10000000),
('SV013', 'Chỉnh nha trẻ em', 15000000),
('SV014', 'Chăm sóc răng miệng định kỳ', 50000),
('SV015', 'X-quang răng', 100000),
('SV016', 'Chụp phim răng kỹ thuật số', 200000),
('SV017', 'Chụp phim CT Cone Beam', 1000000),
('SV018', 'Làm răng giả tháo lắp', 1000000),
('SV019', 'Làm răng giả cố định', 2000000);

INSERT INTO PersonalAppointment(personal_appointment_id, personal_appointment_start_time, personal_appointment_end_time, personal_appointment_date, dentist_id)
VALUES
('PA001', '08:00:00', '20:00:00', '2023-11-28', 'DE001'),
('PA002', '08:00:00', '20:00:00', '2023-11-29', 'DE001'),
('PA003', '08:00:00', '20:00:00', '2023-11-30', 'DE001'),
('PA004', '08:00:00', '20:00:00', '2023-12-01', 'DE001'),
('PA005', '08:00:00', '20:00:00', '2023-12-02', 'DE001'),
('PA006', '08:00:00', '20:00:00', '2023-12-03', 'DE001'),
('PA007', '08:00:00', '20:00:00', '2023-12-04', 'DE001'),
('PA008', '08:00:00', '20:00:00', '2023-12-05', 'DE001'),
('PA009', '08:00:00', '20:00:00', '2023-12-06', 'DE001'),
('PA010', '08:00:00', '20:00:00', '2023-12-07', 'DE001'),
('PA011', '08:00:00', '20:00:00', '2023-12-08', 'DE001'),
('PA012', '08:00:00', '20:00:00', '2023-12-09', 'DE001'),
('PA013', '08:00:00', '20:00:00', '2023-12-10', 'DE001'),
('PA014', '08:00:00', '20:00:00', '2023-12-11', 'DE001'),
('PA015', '08:00:00', '20:00:00', '2023-12-12', 'DE001'),
('PA016', '08:00:00', '20:00:00', '2023-12-13', 'DE001'),
('PA017', '08:00:00', '20:00:00', '2023-12-14', 'DE001'),
('PA018', '08:00:00', '20:00:00', '2023-12-15', 'DE001'),
('PA019', '08:00:00', '20:00:00', '2023-12-16', 'DE001'),
('PA020', '08:00:00', '20:00:00', '2023-12-17', 'DE001'),
('PA021', '08:00:00', '20:00:00', '2023-12-18', 'DE001'),
('PA022', '08:00:00', '20:00:00', '2023-12-19', 'DE001'),
('PA023', '08:00:00', '20:00:00', '2023-12-20', 'DE001'),
('PA024', '08:00:00', '20:00:00', '2023-12-21', 'DE001'),
('PA025', '08:00:00', '20:00:00', '2023-12-22', 'DE001'),
('PA026', '08:00:00', '20:00:00', '2023-12-23', 'DE001'),
('PA027', '08:00:00', '20:00:00', '2023-12-24', 'DE001'),
('PA028', '08:00:00', '20:00:00', '2023-12-25', 'DE001'),
('PA029', '08:00:00', '20:00:00', '2023-12-26', 'DE001'),
('PA030', '08:00:00', '20:00:00', '2023-12-27', 'DE001'),
('PA031', '08:00:00', '20:00:00', '2023-12-28', 'DE001'),
('PA032', '08:00:00', '20:00:00', '2023-12-29', 'DE001'),
('PA033', '08:00:00', '20:00:00', '2023-12-30', 'DE001'),
('PA034', '08:00:00', '20:00:00', '2023-12-31', 'DE001'),
('PA035', '08:00:00', '20:00:00', '2024-01-01', 'DE001'),
('PA036', '08:00:00', '20:00:00', '2024-01-02', 'DE001'),
('PA037', '08:00:00', '20:00:00', '2024-01-03', 'DE001'),
('PA038', '08:00:00', '20:00:00', '2024-01-04', 'DE001'),
('PA039', '08:00:00', '20:00:00', '2024-01-05', 'DE001'),
('PA040', '08:00:00', '20:00:00', '2024-01-06', 'DE001'),
('PA041', '08:00:00', '20:00:00', '2024-01-07', 'DE001'),
('PA042', '08:00:00', '20:00:00', '2024-01-08', 'DE001'),
('PA043', '08:00:00', '20:00:00', '2024-01-09', 'DE001'),
('PA044', '08:00:00', '20:00:00', '2024-01-10', 'DE001'),
('PA045', '08:00:00', '20:00:00', '2024-01-11', 'DE001'),
('PA046', '08:00:00', '20:00:00', '2023-11-28', 'DE002'),
('PA047', '08:00:00', '20:00:00', '2023-11-29', 'DE002'),
('PA048', '08:00:00', '20:00:00', '2023-11-30', 'DE002'),
('PA049', '08:00:00', '20:00:00', '2023-12-01', 'DE002'),
('PA050', '08:00:00', '20:00:00', '2023-12-02', 'DE002'),
('PA051', '08:00:00', '20:00:00', '2023-12-03', 'DE002'),
('PA052', '08:00:00', '20:00:00', '2023-12-04', 'DE002'),
('PA053', '08:00:00', '20:00:00', '2023-12-05', 'DE002'),
('PA054', '08:00:00', '20:00:00', '2023-12-06', 'DE002'),
('PA055', '08:00:00', '20:00:00', '2023-12-07', 'DE002'),
('PA056', '08:00:00', '20:00:00', '2023-12-08', 'DE002'),
('PA057', '08:00:00', '20:00:00', '2023-12-09', 'DE002'),
('PA058', '08:00:00', '20:00:00', '2023-12-10', 'DE002'),
('PA059', '08:00:00', '20:00:00', '2023-12-11', 'DE002'),
('PA060', '08:00:00', '20:00:00', '2023-12-12', 'DE002'),
('PA061', '08:00:00', '20:00:00', '2023-12-13', 'DE002'),
('PA062', '08:00:00', '20:00:00', '2023-12-14', 'DE002'),
('PA063', '08:00:00', '20:00:00', '2023-12-15', 'DE002'),
('PA064', '08:00:00', '20:00:00', '2023-12-16', 'DE002'),
('PA065', '08:00:00', '20:00:00', '2023-12-17', 'DE002'),
('PA066', '08:00:00', '20:00:00', '2023-12-18', 'DE002'),
('PA067', '08:00:00', '20:00:00', '2023-12-19', 'DE002'),
('PA068', '08:00:00', '20:00:00', '2023-12-20', 'DE002'),
('PA069', '08:00:00', '20:00:00', '2023-12-21', 'DE002'),
('PA070', '08:00:00', '20:00:00', '2023-12-22', 'DE002'),
('PA071', '08:00:00', '20:00:00', '2023-12-23', 'DE002'),
('PA072', '08:00:00', '20:00:00', '2023-12-24', 'DE002'),
('PA073', '08:00:00', '20:00:00', '2023-12-25', 'DE002'),
('PA074', '08:00:00', '20:00:00', '2023-12-26', 'DE002'),
('PA075', '08:00:00', '20:00:00', '2023-12-27', 'DE002'),
('PA076', '08:00:00', '20:00:00', '2023-12-28', 'DE002'),
('PA077', '08:00:00', '20:00:00', '2023-12-29', 'DE002'),
('PA078', '08:00:00', '20:00:00', '2023-12-30', 'DE002'),
('PA079', '08:00:00', '20:00:00', '2023-12-31', 'DE002'),
('PA080', '08:00:00', '20:00:00', '2024-01-01', 'DE002'),
('PA081', '08:00:00', '20:00:00', '2024-01-02', 'DE002'),
('PA082', '08:00:00', '20:00:00', '2024-01-03', 'DE002'),
('PA083', '08:00:00', '20:00:00', '2024-01-04', 'DE002'),
('PA084', '08:00:00', '20:00:00', '2024-01-05', 'DE002'),
('PA085', '08:00:00', '20:00:00', '2024-01-06', 'DE002'),
('PA086', '08:00:00', '20:00:00', '2024-01-07', 'DE002'),
('PA087', '08:00:00', '20:00:00', '2024-01-08', 'DE002'),
('PA088', '08:00:00', '20:00:00', '2024-01-09', 'DE002'),
('PA089', '08:00:00', '20:00:00', '2024-01-10', 'DE002'),
('PA090', '08:00:00', '20:00:00', '2024-01-11', 'DE002'),
('PA091', '08:00:00', '20:00:00', '2023-11-28', 'DE003'),
('PA092', '08:00:00', '20:00:00', '2023-11-29', 'DE003'),
('PA093', '08:00:00', '20:00:00', '2023-11-30', 'DE003'),
('PA094', '08:00:00', '20:00:00', '2023-12-01', 'DE003'),
('PA095', '08:00:00', '20:00:00', '2023-12-02', 'DE003'),
('PA096', '08:00:00', '20:00:00', '2023-12-03', 'DE003'),
('PA097', '08:00:00', '20:00:00', '2023-12-04', 'DE003'),
('PA098', '08:00:00', '20:00:00', '2023-12-05', 'DE003'),
('PA099', '08:00:00', '20:00:00', '2023-12-06', 'DE003'),
('PA100', '08:00:00', '20:00:00', '2023-12-07', 'DE003'),
('PA101', '08:00:00', '20:00:00', '2023-12-08', 'DE003'),
('PA102', '08:00:00', '20:00:00', '2023-12-09', 'DE003'),
('PA103', '08:00:00', '20:00:00', '2023-12-10', 'DE003'),
('PA104', '08:00:00', '20:00:00', '2023-12-11', 'DE003'),
('PA105', '08:00:00', '20:00:00', '2023-12-12', 'DE003'),
('PA106', '08:00:00', '20:00:00', '2023-12-13', 'DE003'),
('PA107', '08:00:00', '20:00:00', '2023-12-14', 'DE003'),
('PA108', '08:00:00', '20:00:00', '2023-12-15', 'DE003'),
('PA109', '08:00:00', '20:00:00', '2023-12-16', 'DE003'),
('PA110', '08:00:00', '20:00:00', '2023-12-17', 'DE003'),
('PA111', '08:00:00', '20:00:00', '2023-12-18', 'DE003'),
('PA112', '08:00:00', '20:00:00', '2023-12-19', 'DE003'),
('PA113', '08:00:00', '20:00:00', '2023-12-20', 'DE003'),
('PA114', '08:00:00', '20:00:00', '2023-12-21', 'DE003'),
('PA115', '08:00:00', '20:00:00', '2023-12-22', 'DE003'),
('PA116', '08:00:00', '20:00:00', '2023-12-23', 'DE003'),
('PA117', '08:00:00', '20:00:00', '2023-12-24', 'DE003'),
('PA118', '08:00:00', '20:00:00', '2023-12-25', 'DE003'),
('PA119', '08:00:00', '20:00:00', '2023-12-26', 'DE003'),
('PA120', '08:00:00', '20:00:00', '2023-12-27', 'DE003'),
('PA121', '08:00:00', '20:00:00', '2023-12-28', 'DE003'),
('PA122', '08:00:00', '20:00:00', '2023-12-29', 'DE003'),
('PA123', '08:00:00', '20:00:00', '2023-12-30', 'DE003'),
('PA124', '08:00:00', '20:00:00', '2023-12-31', 'DE003'),
('PA125', '08:00:00', '20:00:00', '2024-01-01', 'DE003'),
('PA126', '08:00:00', '20:00:00', '2024-01-02', 'DE003'),
('PA127', '08:00:00', '20:00:00', '2024-01-03', 'DE003'),
('PA128', '08:00:00', '20:00:00', '2024-01-04', 'DE003'),
('PA129', '08:00:00', '20:00:00', '2024-01-05', 'DE003'),
('PA130', '08:00:00', '20:00:00', '2024-01-06', 'DE003'),
('PA131', '08:00:00', '20:00:00', '2024-01-07', 'DE003'),
('PA132', '08:00:00', '20:00:00', '2024-01-08', 'DE003'),
('PA133', '08:00:00', '20:00:00', '2024-01-09', 'DE003'),
('PA134', '08:00:00', '20:00:00', '2024-01-10', 'DE003'),
('PA135', '08:00:00', '20:00:00', '2024-01-11', 'DE003'),
('PA136', '08:00:00', '20:00:00', '2023-11-28', 'DE004'),
('PA137', '08:00:00', '20:00:00', '2023-11-29', 'DE004'),
('PA138', '08:00:00', '20:00:00', '2023-11-30', 'DE004'),
('PA139', '08:00:00', '20:00:00', '2023-12-01', 'DE004'),
('PA140', '08:00:00', '20:00:00', '2023-12-02', 'DE004'),
('PA141', '08:00:00', '20:00:00', '2023-12-03', 'DE004'),
('PA142', '08:00:00', '20:00:00', '2023-12-04', 'DE004'),
('PA143', '08:00:00', '20:00:00', '2023-12-05', 'DE004'),
('PA144', '08:00:00', '20:00:00', '2023-12-06', 'DE004'),
('PA145', '08:00:00', '20:00:00', '2023-12-07', 'DE004'),
('PA146', '08:00:00', '20:00:00', '2023-12-08', 'DE004'),
('PA147', '08:00:00', '20:00:00', '2023-12-09', 'DE004'),
('PA148', '08:00:00', '20:00:00', '2023-12-10', 'DE004'),
('PA149', '08:00:00', '20:00:00', '2023-12-11', 'DE004'),
('PA150', '08:00:00', '20:00:00', '2023-12-12', 'DE004'),
('PA151', '08:00:00', '20:00:00', '2023-12-13', 'DE004'),
('PA152', '08:00:00', '20:00:00', '2023-12-14', 'DE004'),
('PA153', '08:00:00', '20:00:00', '2023-12-15', 'DE004'),
('PA154', '08:00:00', '20:00:00', '2023-12-16', 'DE004'),
('PA155', '08:00:00', '20:00:00', '2023-12-17', 'DE004'),
('PA156', '08:00:00', '20:00:00', '2023-12-18', 'DE004'),
('PA157', '08:00:00', '20:00:00', '2023-12-19', 'DE004'),
('PA158', '08:00:00', '20:00:00', '2023-12-20', 'DE004'),
('PA159', '08:00:00', '20:00:00', '2023-12-21', 'DE004'),
('PA160', '08:00:00', '20:00:00', '2023-12-22', 'DE004'),
('PA161', '08:00:00', '20:00:00', '2023-12-23', 'DE004'),
('PA162', '08:00:00', '20:00:00', '2023-12-24', 'DE004'),
('PA163', '08:00:00', '20:00:00', '2023-12-25', 'DE004'),
('PA164', '08:00:00', '20:00:00', '2023-12-26', 'DE004'),
('PA165', '08:00:00', '20:00:00', '2023-12-27', 'DE004'),
('PA166', '08:00:00', '20:00:00', '2023-12-28', 'DE004'),
('PA167', '08:00:00', '20:00:00', '2023-12-29', 'DE004'),
('PA168', '08:00:00', '20:00:00', '2023-12-30', 'DE004'),
('PA169', '08:00:00', '20:00:00', '2023-12-31', 'DE004'),
('PA170', '08:00:00', '20:00:00', '2024-01-01', 'DE004'),
('PA171', '08:00:00', '20:00:00', '2024-01-02', 'DE004'),
('PA172', '08:00:00', '20:00:00', '2024-01-03', 'DE004'),
('PA173', '08:00:00', '20:00:00', '2024-01-04', 'DE004'),
('PA174', '08:00:00', '20:00:00', '2024-01-05', 'DE004'),
('PA175', '08:00:00', '20:00:00', '2024-01-06', 'DE004'),
('PA176', '08:00:00', '20:00:00', '2024-01-07', 'DE004'),
('PA177', '08:00:00', '20:00:00', '2024-01-08', 'DE004'),
('PA178', '08:00:00', '20:00:00', '2024-01-09', 'DE004'),
('PA179', '08:00:00', '20:00:00', '2024-01-10', 'DE004'),
('PA180', '08:00:00', '20:00:00', '2024-01-11', 'DE004'),
('PA181', '08:00:00', '20:00:00', '2023-11-28', 'DE005'),
('PA182', '08:00:00', '20:00:00', '2023-11-29', 'DE005'),
('PA183', '08:00:00', '20:00:00', '2023-11-30', 'DE005'),
('PA184', '08:00:00', '20:00:00', '2023-12-01', 'DE005'),
('PA185', '08:00:00', '20:00:00', '2023-12-02', 'DE005'),
('PA186', '08:00:00', '20:00:00', '2023-12-03', 'DE005'),
('PA187', '08:00:00', '20:00:00', '2023-12-04', 'DE005'),
('PA188', '08:00:00', '20:00:00', '2023-12-05', 'DE005'),
('PA189', '08:00:00', '20:00:00', '2023-12-06', 'DE005'),
('PA190', '08:00:00', '20:00:00', '2023-12-07', 'DE005'),
('PA191', '08:00:00', '20:00:00', '2023-12-08', 'DE005'),
('PA192', '08:00:00', '20:00:00', '2023-12-09', 'DE005'),
('PA193', '08:00:00', '20:00:00', '2023-12-10', 'DE005'),
('PA194', '08:00:00', '20:00:00', '2023-12-11', 'DE005'),
('PA195', '08:00:00', '20:00:00', '2023-12-12', 'DE005'),
('PA196', '08:00:00', '20:00:00', '2023-12-13', 'DE005'),
('PA197', '08:00:00', '20:00:00', '2023-12-14', 'DE005'),
('PA198', '08:00:00', '20:00:00', '2023-12-15', 'DE005'),
('PA199', '08:00:00', '20:00:00', '2023-12-16', 'DE005'),
('PA200', '08:00:00', '20:00:00', '2023-12-17', 'DE005'),
('PA201', '08:00:00', '20:00:00', '2023-12-18', 'DE005'),
('PA202', '08:00:00', '20:00:00', '2023-12-19', 'DE005'),
('PA203', '08:00:00', '20:00:00', '2023-12-20', 'DE005'),
('PA204', '08:00:00', '20:00:00', '2023-12-21', 'DE005'),
('PA205', '08:00:00', '20:00:00', '2023-12-22', 'DE005'),
('PA206', '08:00:00', '20:00:00', '2023-12-23', 'DE005'),
('PA207', '08:00:00', '20:00:00', '2023-12-24', 'DE005'),
('PA208', '08:00:00', '20:00:00', '2023-12-25', 'DE005'),
('PA209', '08:00:00', '20:00:00', '2023-12-26', 'DE005'),
('PA210', '08:00:00', '20:00:00', '2023-12-27', 'DE005'),
('PA211', '08:00:00', '20:00:00', '2023-12-28', 'DE005'),
('PA212', '08:00:00', '20:00:00', '2023-12-29', 'DE005'),
('PA213', '08:00:00', '20:00:00', '2023-12-30', 'DE005'),
('PA214', '08:00:00', '20:00:00', '2023-12-31', 'DE005'),
('PA215', '08:00:00', '20:00:00', '2024-01-01', 'DE005'),
('PA216', '08:00:00', '20:00:00', '2024-01-02', 'DE005'),
('PA217', '08:00:00', '20:00:00', '2024-01-03', 'DE005'),
('PA218', '08:00:00', '20:00:00', '2024-01-04', 'DE005'),
('PA219', '08:00:00', '20:00:00', '2024-01-05', 'DE005'),
('PA220', '08:00:00', '20:00:00', '2024-01-06', 'DE005'),
('PA221', '08:00:00', '20:00:00', '2024-01-07', 'DE005'),
('PA222', '08:00:00', '20:00:00', '2024-01-08', 'DE005'),
('PA223', '08:00:00', '20:00:00', '2024-01-09', 'DE005'),
('PA224', '08:00:00', '20:00:00', '2024-01-10', 'DE005'),
('PA225', '08:00:00', '20:00:00', '2024-01-11', 'DE005'),
('PA226', '08:00:00', '20:00:00', '2023-11-28', 'DE006'),
('PA227', '08:00:00', '20:00:00', '2023-11-29', 'DE006'),
('PA228', '08:00:00', '20:00:00', '2023-11-30', 'DE006'),
('PA229', '08:00:00', '20:00:00', '2023-12-01', 'DE006'),
('PA230', '08:00:00', '20:00:00', '2023-12-02', 'DE006'),
('PA231', '08:00:00', '20:00:00', '2023-12-03', 'DE006'),
('PA232', '08:00:00', '20:00:00', '2023-12-04', 'DE006'),
('PA233', '08:00:00', '20:00:00', '2023-12-05', 'DE006'),
('PA234', '08:00:00', '20:00:00', '2023-12-06', 'DE006'),
('PA235', '08:00:00', '20:00:00', '2023-12-07', 'DE006'),
('PA236', '08:00:00', '20:00:00', '2023-12-08', 'DE006'),
('PA237', '08:00:00', '20:00:00', '2023-12-09', 'DE006'),
('PA238', '08:00:00', '20:00:00', '2023-12-10', 'DE006'),
('PA239', '08:00:00', '20:00:00', '2023-12-11', 'DE006'),
('PA240', '08:00:00', '20:00:00', '2023-12-12', 'DE006'),
('PA241', '08:00:00', '20:00:00', '2023-12-13', 'DE006'),
('PA242', '08:00:00', '20:00:00', '2023-12-14', 'DE006'),
('PA243', '08:00:00', '20:00:00', '2023-12-15', 'DE006'),
('PA244', '08:00:00', '20:00:00', '2023-12-16', 'DE006'),
('PA245', '08:00:00', '20:00:00', '2023-12-17', 'DE006'),
('PA246', '08:00:00', '20:00:00', '2023-12-18', 'DE006'),
('PA247', '08:00:00', '20:00:00', '2023-12-19', 'DE006'),
('PA248', '08:00:00', '20:00:00', '2023-12-20', 'DE006'),
('PA249', '08:00:00', '20:00:00', '2023-12-21', 'DE006'),
('PA250', '08:00:00', '20:00:00', '2023-12-22', 'DE006'),
('PA251', '08:00:00', '20:00:00', '2023-12-23', 'DE006'),
('PA252', '08:00:00', '20:00:00', '2023-12-24', 'DE006'),
('PA253', '08:00:00', '20:00:00', '2023-12-25', 'DE006'),
('PA254', '08:00:00', '20:00:00', '2023-12-26', 'DE006'),
('PA255', '08:00:00', '20:00:00', '2023-12-27', 'DE006'),
('PA256', '08:00:00', '20:00:00', '2023-12-28', 'DE006'),
('PA257', '08:00:00', '20:00:00', '2023-12-29', 'DE006'),
('PA258', '08:00:00', '20:00:00', '2023-12-30', 'DE006'),
('PA259', '08:00:00', '20:00:00', '2023-12-31', 'DE006'),
('PA260', '08:00:00', '20:00:00', '2024-01-01', 'DE006'),
('PA261', '08:00:00', '20:00:00', '2024-01-02', 'DE006'),
('PA262', '08:00:00', '20:00:00', '2024-01-03', 'DE006'),
('PA263', '08:00:00', '20:00:00', '2024-01-04', 'DE006'),
('PA264', '08:00:00', '20:00:00', '2024-01-05', 'DE006'),
('PA265', '08:00:00', '20:00:00', '2024-01-06', 'DE006'),
('PA266', '08:00:00', '20:00:00', '2024-01-07', 'DE006'),
('PA267', '08:00:00', '20:00:00', '2024-01-08', 'DE006'),
('PA268', '08:00:00', '20:00:00', '2024-01-09', 'DE006'),
('PA269', '08:00:00', '20:00:00', '2024-01-10', 'DE006'),
('PA270', '08:00:00', '20:00:00', '2024-01-11', 'DE006');

INSERT INTO Patient (patient_id, patient_name, patient_birthday, patient_address, patient_phone)
VALUES
('PA001', 'Nguyễn Văn An', '1995-01-01', 'Số 1, đường Nguyễn Văn Linh, quận 7, TP.HCM', '0901234567'),
('PA002', 'Trần Thị Bích', '1996-02-02', 'Số 2, đường Nguyễn Thị Minh Khai, quận 3, TP.HCM', '0912345678'),
('PA003', 'Lê Văn Chi', '1997-03-03', 'Số 3, đường Lê Hồng Phong, quận 10, TP.HCM', '0923456789'),
('PA004', 'Đỗ Thị Dũng', '1998-04-04', 'Số 4, đường Trần Quang Khải, quận 1, TP.HCM', '0934567890'),
('PA005', 'Nguyễn Thị Dung', '1999-05-05', 'Số 5, đường Nguyễn Huệ, quận 2, TP.HCM', '0945678901'),
('PA006', 'Trần Văn Duy', '2000-06-06', 'Số 6, đường Lê Đại Hành, quận 11, TP.HCM', '0956789012'),
('PA007', 'Lê Thị Em', '2001-07-07', 'Số 7, đường Nguyễn Đình Chiểu, quận 8, TP.HCM', '0967890123'),
('PA008', 'Đỗ Văn Giang', '2002-08-08', 'Số 8, đường Phạm Ngũ Lao, quận 5, TP.HCM', '0978901234'),
('PA009', 'Nguyễn Thị Hằng', '2003-09-09', 'Số 9, đường Nguyễn Văn Cừ, quận 5, TP.HCM', '0989012345'),
('PA010', 'Trần Văn Hiệp', '2004-10-10', 'Số 10, đường Nguyễn Trãi, quận 7, TP.HCM', '0990123456'),
('PA011', 'Huỳnh Thị Mến', '2010-11-11', '2425 Nguyen Hue Street, Ho Chi Minh City', '0987654331'),
('PA012', 'Phạm Văn Nam', '2011-12-12', '2627 Le Lai Street, Ho Chi Minh City', '0987654332'),
('PA013', 'Nguyễn Thị Ngọc', '2012-01-13', '2829 Nguyen Van Linh Street, Ho Chi Minh City', '0987654333'),
('PA014', 'Trần Thị Oanh', '2012-02-14', '3031 Pham Ngu Lao Street, Ho Chi Minh City', '0987654334'),
('PA015', 'Lê Thị Phương', '2013-03-15', '3233 Dong Khoi Street, Ho Chi Minh City', '0987654335'),
('PA016', 'Dương Văn Quốc', '2013-04-16', '3435 Nguyen Dinh Chieu Street, Ho Chi Minh City', '0987654336'),
('PA017', 'Nguyễn Văn An', '2000-01-01', '123 Nguyen Hue Street, Ho Chi Minh City', '0987654321'),
('PA018', 'Trần Thị Bích', '2001-02-02', '456 Le Lai Street, Ho Chi Minh City', '0987654322'),
('PA019', 'Lê Văn Cường', '2002-03-03', '789 Nguyen Van Linh Street, Ho Chi Minh City', '0987654323'),
('PA020', 'Dương Thị Dũng', '2003-04-04', '1011 Pham Ngu Lao Street, Ho Chi Minh City', '0987654324');


