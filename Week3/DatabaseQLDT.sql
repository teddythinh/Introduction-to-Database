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
	MACD VARCHAR(4), 
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
	PHAI VARCHAR(3),
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
    PHAI VARCHAR(3)

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

ALTER TABLE NGUOITHAN
ADD
	CONSTRAINT FK_NGUOITHAN_GIAOVIEN
	FOREIGN KEY (MAGV, TEN)
	REFERENCES GIAOVIEN

