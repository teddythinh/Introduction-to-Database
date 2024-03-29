USE master
GO

IF DB_ID('QLDETAI') IS NOT NULL 
    DROP DATABASE QLDETAI
GO

CREATE DATABASE QLDETAI
GO

USE QLDETAI
GO

CREATE TABLE THAMGIADT
(
	MAGV VARCHAR(3),
	MADT VARCHAR(3),
	STT INT,
	PHUCAP FLOAT,
	KETQUA NVARCHAR(3)

	CONSTRAINT PK_THAMGIADT
	PRIMARY KEY (MAGV, MADT, STT)
)

CREATE TABLE CONGVIEC
(
	MADT VARCHAR(3),
	SOTT INT,
	TENCV NVARCHAR(50),
	NGAYBD DATE,
	NGAYKT DATE

	CONSTRAINT PK_CONGVIEC
	PRIMARY KEY (MADT, SOTT)
)

CREATE TABLE DETAI
(
	MADT VARCHAR(3),
	TENDT NVARCHAR(50),
	CAPQL NVARCHAR(10),
	KINHPHI DECIMAL(10, 1),
	NGAYBD DATE,
	NGAYKT DATE, 
	MACD NVARCHAR(4), 
	GVCNDT VARCHAR(3)

	CONSTRAINT PK_DETAI
	PRIMARY KEY (MADT)
)

CREATE TABLE CHUDE
(
	MACD NVARCHAR(4),
	TENCD NVARCHAR(50)

	CONSTRAINT PK_CHUDE
	PRIMARY KEY (MACD)
)

CREATE TABLE KHOA
(
    MAKHOA VARCHAR(4),
    TENKHOA NVARCHAR(20),
    NAMTL DATE,
    PHONG VARCHAR(3),
    DIENTHOAI VARCHAR(10), 
    TRUONGKHOA VARCHAR(3),
    NGAYNHANCHUC DATE

    CONSTRAINT PK_KHOA
    PRIMARY KEY (MAKHOA)
)

CREATE TABLE GIAOVIEN
(
	MAGV VARCHAR(3),
	HOTEN NVARCHAR(20),
	LUONG DECIMAL(10, 1),
	PHAI NVARCHAR(3),
	NGAYSINH DATE,
	DIACHI NVARCHAR(50),
	GVQLBM VARCHAR(3), 
	MABM NVARCHAR(4)

	CONSTRAINT PK_GIAOVIEN
	PRIMARY KEY (MAGV)
)

CREATE TABLE NGUOITHAN
(
    MAGV VARCHAR(3), 
    TEN NVARCHAR(20), 
    NGSINH DATE,
    PHAI NVARCHAR(3)

    CONSTRAINT PK_NGUOITHAN
    PRIMARY KEY (MAGV, TEN)
)

CREATE TABLE BOMON
(
    MABM NVARCHAR(4), 
    TENBM NVARCHAR(20),
    PHONG VARCHAR(3), 
    DIENTHOAI VARCHAR(10), 
    TRUONGBM VARCHAR(3),
    MAKHOA VARCHAR(4),
    NGAYNHANCHUC DATE

    CONSTRAINT PK_BOMON
    PRIMARY KEY (MABM)
)

CREATE TABLE GV_DT
(
	MAGV VARCHAR(3), 
	DIENTHOAI VARCHAR(10)

	CONSTRAINT PK_GV_DT
	PRIMARY KEY (MAGV, DIENTHOAI)
)

ALTER TABLE THAMGIADT 
ADD 
	CONSTRAINT FK_THAMGIADT_GIAOVIEN
	FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN,

	CONSTRAINT FK_THAMGIADT_CONGVIEC
	FOREIGN KEY (MADT, STT)
	REFERENCES CONGVIEC

ALTER TABLE CONGVIEC
ADD
	CONSTRAINT FK_CONGVIEC_DETAI
	FOREIGN KEY (MADT)
	REFERENCES DETAI

ALTER TABLE DETAI
ADD
	CONSTRAINT FK_DETAI_CHUDE
	FOREIGN KEY (MACD)
	REFERENCES CHUDE,

	CONSTRAINT FK_DETAI_GIAOVIEN
	FOREIGN KEY (GVCNDT)
	REFERENCES GIAOVIEN

ALTER TABLE KHOA
ADD
	CONSTRAINT FK_KHOA_GIAOVIEN
	FOREIGN KEY (TRUONGKHOA)
	REFERENCES GIAOVIEN

ALTER TABLE BOMON
ADD
	CONSTRAINT FK_BOMON_KHOA
	FOREIGN KEY (MAKHOA)
	REFERENCES KHOA,

	CONSTRAINT FK_BOMON_GIAOVIEN
	FOREIGN KEY (TRUONGBM)
	REFERENCES GIAOVIEN

ALTER TABLE NGUOITHAN
ADD
	CONSTRAINT FK_NGUOITHAN_GIAOVIEN
	FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN

ALTER TABLE GV_DT
ADD
	CONSTRAINT FK_GV_DT_GIAOVIEN
	FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN

ALTER TABLE GIAOVIEN
ADD
	CONSTRAINT FK_GIAOVIEN_BOMON
	FOREIGN KEY (MABM)
	REFERENCES BOMON,

	CONSTRAINT FK_GIAOVIEN_GIAOVIEN
	FOREIGN KEY (GVQLBM)
	REFERENCES GIAOVIEN

INSERT CHUDE
VALUES (N'NCPT', N'Nghiên cứu phát triển'),
	   (N'QLGD', N'Quản lý giáo dục'),
	   (N'ƯDCN', N'Ứng dụng công nghệ')

INSERT GIAOVIEN
VALUES ('001',N'Nguyễn Hoài An','2000.0',N'Nam','1973/02/15',N'25/3 Lạc Long Quân, Q.10, TPHCM',NULL,NULL),
	   ('002',N'Trần Trà Hương','2500.0',N'Nữ','1960/06/20',N'125 Trần Hưng Đạo, Q.1, TPHCM',NULL,NULL),
	   ('003',N'Nguyễn Ngọc Ánh','2200.0',N'Nữ','1975/05/11',N'12/21 Võ Văn Ngân, Thủ Đức, TPHCM','002',NULL),
	   ('004',N'Trương Nam Sơn','2300.0',N'Nam','1959/06/20',N'215 Lý Thường Kiệt, TP Biên Hoà',NULL,NULL),
	   ('005',N'Lý Hoàng Hà','2500.0',N'Nam','1954/10/23',N'22/5 Nguyễn Xí, Q.Bình Thạnh, TPHCM',NULL,NULL),
	   ('006',N'Trần Bạch Tuyết','1500.0',N'Nữ','1980/05/20',N'127 Hùng Vương, TP Mỹ Tho','004',NULL),
	   ('007',N'Nguyễn An Trung','2100.0',N'Nam','1976/06/05',N'234 3/2, TP Biên Hoà',NULL,NULL),
	   ('008',N'Trần Trung Hiếu','1800.0',N'Nam','1977/08/06',N'22/11 Lý Thường Kiệt, TP Mỹ Tho','007',NULL),
	   ('009',N'Trần Hoàng Nam','2000.0',N'Nam','1975/11/22',N'234 Trấn Não, An Phú, TPHCM','001',NULL),
	   ('010',N'Phạm Nam Thanh','1500.0',N'Nam','1980/12/12',N'221 Hùng Vương, Q.5, TPHCM','007',NULL)

INSERT NGUOITHAN
VALUES ('001', N'Hùng', '1990/01/14', N'Nam'),
	   ('001', N'Thuỷ', '1994/12/08', N'Nữ'),
	   ('003', N'Hà', '1998/09/03', N'Nữ'),
	   ('003', N'Thu', '1998/09/03', N'Nữ'),
	   ('007', N'Mai', '2004/03/26', N'Nữ'),
	   ('007', N'Vy', '2000/02/14', N'Nữ'),
	   ('008', N'Nam', '1991/08/19', N'Nam'),
	   ('009', N'An', '1996/08/19', N'Nam'),
	   ('010', N'Nguyệt', '2006/01/14', N'Nữ')

INSERT KHOA
VALUES ('CNTT',N'Công nghệ thông tin','1995','B11','0838123456','002','2005/02/20'),
	   ('HH',N'Hoá học','1980','B41','0838456456','007','2001/10/15'),
	   ('SH',N'Sinh học','1980','B31','0838454545','004','2000/10/11'),
	   ('VL',N'Vật lý','1976','B21','0838223223','005','2003/09/18')

INSERT BOMON(MABM, TENBM, PHONG, DIENTHOAI, TRUONGBM, MAKHOA, NGAYNHANCHUC)
VALUES ('CNTT',N'Công nghệ tri thức','B15','0838126126',NULL,'CNTT',NULL),
	   ('HHC',N'Hoá hữu cơ','B44','0838222222',NULL,'HH',NULL),
	   ('HL',N'Hoá lý','B42','0838878787',NULL,'HH',NULL),
	   ('HPT',N'Hoá phân tích','B43','0838777777','007','HH','2007/10/15'),
	   ('HTTT',N'Hệ thống thông tin','B13','0838125125','002','CNTT','2004/09/20'),
	   ('MMT',N'Mạng máy tính','B16','0838676767','001','CNTT','2005/05/15'),
	   ('SH',N'Sinh hoá','B33','0838898989',NULL,'SH',NULL),
	   ('VLĐT',N'Vật lý điện tử','B23','0838234234',NULL,'VL',NULL),
	   ('VLUD',N'Vật lý ứng dụng','B24','0838454545','005','VL','2006/02/18'),
	   ('VS',N'Vi sinh','B32','0838909090','004','SH','2007-01-01')

UPDATE GIAOVIEN SET MABM ='MMT'WHERE MAGV='001'
UPDATE GIAOVIEN SET MABM ='HTTT'WHERE MAGV='002'
UPDATE GIAOVIEN SET MABM ='HTTT'WHERE MAGV='003'
UPDATE GIAOVIEN SET MABM ='VS'WHERE MAGV='004'
UPDATE GIAOVIEN SET MABM ='VLĐT'WHERE MAGV='005'
UPDATE GIAOVIEN SET MABM ='VS'WHERE MAGV='006'
UPDATE GIAOVIEN SET MABM ='HPT'WHERE MAGV='007'
UPDATE GIAOVIEN SET MABM ='HPT'WHERE MAGV='008'
UPDATE GIAOVIEN SET MABM ='MMT'WHERE MAGV='009'
UPDATE GIAOVIEN SET MABM ='HPT'WHERE MAGV='010'

INSERT GV_DT(MAGV, DIENTHOAI)
VALUES ('001','0838912112'),
	   ('001','0903123123'),
	   ('002','0913454545'),
	   ('003','0838121212'),
	   ('003','0903656565'),
	   ('003','0937125125'),
	   ('006','0937888888'),
	   ('008','0653717171'),
	   ('008','0913232323')

INSERT DETAI
VALUES ('001',N'HTTT quản lý các trường ĐH',N'ĐHQG','20.0','2007/10/20','2008/10/20',N'QLGD','002'),
       ('002',N'HTTT quản lý giáo vụ cho một Khoa',N'Trường','20.0','2000/10/12','2001/10/12',N'QLGD','002'),
       ('003',N'Nghiên cứu chế tạo sợi Nano Platin',N'ĐHQG','300.0','2008/05/15','2010/05/15',N'NCPT','005'),
	   ('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước','100.0','2007/01/01','2009/12/31',N'NCPT','004'),
	   ('005',N'Ứng dụng hoá học xanh',N'Trường','200.0','2003/10/10','2004/12/10',N'ƯDCN','007'),
	   ('006',N'Nghiên cứu tế bào gốc',N'Nhà nước','4000.0','2006/10/20','2009/10/20',N'NCPT','004'),
	   ('007',N'HTTT quản lý thư viện ở các trường ĐH',N'Trường','20.0','2009/05/10','2010/05/10',N'QLGD','001')

INSERT CONGVIEC
VALUES ('001',1,N'Khởi tạo và Lập kế hoạch','2007/10/20','2008/12/20'),
	   ('001',2,N'Xác định yêu cầu','2008/12/21','2008/03/21'),
	   ('001',3,N'Phân tích hệ thống','2008/03/22','2008/05/22'),
	   ('001',4,N'Thiết kế hệ thống','2008/05/23','2008/06/23'),
	   ('001',5,N'Cài đặt thử nghiệm','2007/06/24','2008/10/20'),
	   ('002',1,N'Khởi tạo và Lập kế hoạch','2009/05/10','2009/07/10'),
	   ('002',2,N'Xác định yêu cầu','2009/07/11','2009/10/11'),
	   ('002',3,N'Phân tích hệ thống','2009/10/12','2009/12/20'),
	   ('002',4,N'Thiết kế hệ thống','2009/12/21','2010/03/22'),
	   ('002',5,N'Cài đặt thử nghiệm','2010/03/23','2010/05/10'),
	   ('006',1,N'Lấy mẫu','2006/10/20','2007/02/20'),
       ('006',2,N'Nuôi cấy','2007/02/21','2008/08/21')

INSERT THAMGIADT
VALUES ('001','002',1,'0.0',NULL), 
	   ('001','002',2,'2.0',NULL),
	   ('002','001',4,'2.0',N'Đạt'),
	   ('003','001',1,'1.0',N'Đạt'),
	   ('003','001',2,'0.0',N'Đạt'),
	   ('003','001',4,'1.0',N'Đạt'),
	   ('003','002',2,'0.0',NULL),
	   ('004','006',1,'0.0',N'Đạt'),
	   ('004','006',2,'1.0',N'Đạt'),
	   ('006','006',2,'1.5',N'Đạt'),
	   ('009','002',3,'0.5',NULL),
	   ('009','002',4,'1.5',NULL)

SELECT * FROM CHUDE
SELECT * FROM GIAOVIEN
SELECT * FROM NGUOITHAN
SELECT * FROM KHOA
SELECT * FROM BOMON
SELECT * FROM GV_DT
SELECT * FROM DETAI
SELECT * FROM CONGVIEC
SELECT * FROM THAMGIADT