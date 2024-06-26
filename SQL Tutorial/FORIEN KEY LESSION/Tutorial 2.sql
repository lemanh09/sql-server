-- Create Khoa table and insert data
CREATE TABLE Khoa
(
    makhoa CHAR(10) PRIMARY KEY,
    tenkhoa CHAR(30),
    dienthoai CHAR(10)
);

INSERT INTO Khoa (makhoa, tenkhoa, dienthoai)
VALUES
    ('CNTT-CQ', 'CNTT', '092373287'),
    ('KHMT-CQ', 'KHMT', '092372232'),
    ('TMDT-CQ', 'TMDT', '092379990'),
    ('ATTT-CQ', 'ATTT', '091233280'),
    ('KTMT-CQ', 'KTMT', '092373287');

-- Create GiangVien table and insert data
CREATE TABLE GiangVien
(
    magv INT PRIMARY KEY,
    hotengv CHAR(30),
    luong DECIMAL(5,2),
    makhoa CHAR(10),
    FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa)
);

INSERT INTO GiangVien (magv, hotengv, luong, makhoa)
VALUES
	(01, 'BUI XUAN HUAN', 120.00, 'CNTT-CQ'),
	(02, 'BUI BACH DAI', 220.00, 'KHMT-CQ'),
	(03, 'TRINH XUAN QUYEN', 120.00, 'TMDT-CQ'),
	(04, 'HOANG VAN TOAN', 320.00, 'ATTT-CQ'),
	(05, 'NGUYEN TRAN KHAI', 220.00, 'KTMT-CQ');

CREATE TABLE SinhVien
(
    masv INT PRIMARY KEY,
    hotensv CHAR(30),
    makhoa CHAR(10),
    namsinh INT,
    quequan CHAR(10)
);
INSERT INTO SinhVien (masv, hotensv, makhoa, namsinh, quequan)
VALUES
	(111, 'CAO THE HOANG', 'CNTT-CQ', 2006, 'HaNoi'),
	(112, 'LUONG XUAN TRUONG', 'KTMT-CQ', 2006, 'ThaiBinh'),
	(113, 'HOANG BA DAT', 'CNTT-CQ', 2006, 'TP.HCM'),
	(114, 'LE QUOC HUY', 'KHMT-CQ', 2006, 'HaiPhong'),
	(115, 'TRUONG VAN DUAN', 'KHMT-CQ', 2006, 'Hue'),
	(116, 'DAO ANH TUAN', 'KHMT-CQ', 2006, 'HungYen'),
	(117, 'HUYNH THAI HUNG', 'CNTT-CQ', 2006, 'GiaLai'),
	(118, 'NGO ANH MINH', 'TMDT-CQ', 2006, 'BinhDinh'),
	(119, 'THAI GIA BAO', 'ATTT-CQ', 2006, 'QuangNam'),
	(120, 'DANG THANH AN', 'TMDT-CQ', 2006, 'DongNai');

CREATE TABLE DeTai 
(
    madt CHAR(10) PRIMARY KEY,
    tendt CHAR(30),
    kinhphi INT,
    NoiThucTap CHAR(30)
);
INSERT INTO DeTai (madt, tendt, kinhphi, NoiThucTap)
VALUES
	('111', 'XU LY TAC VU AI', 2000000, 'HaNoi'),
	('112', 'PHAT TRIEN WEB', 1500000, 'HoChiMinh'),
    ('113', 'NGHIEN CUU IOT', 2500000, 'DaNang'),
    ('114', 'PHAN TICH DU LIEU', 1800000, 'HaNoi'),
    ('115', 'AN NINH MANG', 2200000, 'HaiPhong'),
    ('116', 'THIET KE DATABASE', 2000000, 'CanTho'),
    ('117', 'UNG DUNG MOBILE', 2300000, 'Hue'),
    ('118', 'PHAT TRIEN GAME', 2100000, 'DaLat'),
    ('119', 'HE THONG PHAN MEM', 2400000, 'QuyNhon'),
    ('120', 'TU DONG HOA', 2600000, 'HaNoi');

CREATE TABLE HuongDan 
(
    masv CHAR(10) PRIMARY KEY,
    madt CHAR(10),
    magv INT,
    ketqua DECIMAL(5,2)
);
INSERT INTO HuongDan (masv, madt, magv, ketqua)
VALUES
    ('111', '111', 01, 85.50),
    ('112', '112', 01, 90.00),
    ('113', '113', 02, 75.75),
    ('114', '114', 02, 88.20),
    ('115', '115', 03, 92.00),
    ('116', '116', 03, 80.00),
    ('117', '117', 04, 78.50),
    ('118', '118', 04, 85.00),
    ('119', '119', 05, 89.75),
    ('120', '120', 05, 94.00);

-- Add foreign key constraints
ALTER TABLE HuongDan
ADD CONSTRAINT FK_HuongDan_DeTai FOREIGN KEY (madt) REFERENCES DeTai(madt);

ALTER TABLE SinhVien
ADD CONSTRAINT FK_SinhVien_Khoa FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa);

ALTER TABLE HuongDan
ADD CONSTRAINT FK_HuongDan_GiangVien FOREIGN KEY (magv) REFERENCES GiangVien(magv);

-- Drop constraints and tables
ALTER TABLE SinhVien DROP CONSTRAINT FK_SinhVien_Khoa;

ALTER TABLE GiangVien DROP CONSTRAINT FK_GiangVien_Khoa;

DROP TABLE Khoa;

DROP TABLE GiangVien;
DROP TABLE SinhVien;
DROP TABLE DeTai;
DROP TABLE HuongDan;
