-- MSSV: 20127335
-- TOPIC: 02

-- BƯỚC 1: TẠO CƠ SỞ DỮ LIỆU
USE master -- CHUYỂN CSDL MẶC ĐỊNH VỀ MASTER CỦA HỆ THỐNG
GO  -- KẾT THÚC KHỐI LỆNH Ở TRÊN

IF DB_ID('QLCHUYENBAY') IS NOT NULL -- KIỂM TRA XEM CÓ TỒN TẠI CSDL QLCHUYENBAY HAY KHÔNG 
    DROP DATABASE QLCHUYENBAY -- XOÁ CƠ SỞ DỮ LIỆU
GO

CREATE DATABASE QLCHUYENBAY
GO

USE QLCHUYENBAY
GO

-- BƯỚC 2: TẠO BẢNG VÀ KHOÁ CHÍNH
CREATE TABLE KHACHHANG
(
    -- KHAI BÁO THUỘC TÍNH TRONG BẢNG
    MAKH VARCHAR(15),
    TEN VARCHAR(15),
    DCHI VARCHAR(50),
    DIENTHOAI VARCHAR(12)

    -- TẠO KHOÁ CHÍNH
    CONSTRAINT PK_KHACHHANG -- CÂU LỆNH ĐẶT TÊN KHOÁ
    PRIMARY KEY (MAKH) -- CÂU LỆNH TẠO KHOÁ CHÍNH
)

CREATE TABLE DATCHO
(
    MAKH VARCHAR(15),
    NGAYDI DATE,
    MACB VARCHAR(4)

    CONSTRAINT PK_DATCHO
    PRIMARY KEY (MAKH, NGAYDI, MACB)
)

CREATE TABLE LICHBAY
(
    NGAYDI DATE,
    MACB VARCHAR(4),
    SOHIEU INT,
    MALOAI VARCHAR(15)
    
    CONSTRAINT PK_LICHBAY
    PRIMARY KEY (NGAYDI, MACB)
)

CREATE TABLE CHUYENBAY
(
    MACB VARCHAR(4),
    SBDI VARCHAR(3),
    SBDEN VARCHAR(3),
    GIODI TIME(7),
    GIODEN TIME(7)

    CONSTRAINT PK_CHUYENBAY
    PRIMARY KEY (MACB)
)

CREATE TABLE MAYBAY
(
    SOHIEU INT,
    MALOAI VARCHAR(15)

    CONSTRAINT PK_MAYBAY
    PRIMARY KEY (SOHIEU, MALOAI)
)

CREATE TABLE LOAIMB
(
    HANGSX VARCHAR(15),
    MALOAI VARCHAR(15)

    CONSTRAINT PK_LOAIMB
    PRIMARY KEY (MALOAI)
)

CREATE TABLE KHANANG
(
    MANV VARCHAR(15),
    MALOAI VARCHAR(15)

    CONSTRAINT PK_KHANANG
    PRIMARY KEY (MANV, MALOAI)
)

CREATE TABLE NHANVIEN 
(
    MANV VARCHAR(15),
    TEN VARCHAR(15),
    DCHI VARCHAR(50),
    DTHOAI VARCHAR(12),
    LUONG DECIMAL(10, 2),
    LOAINV BIT

    CONSTRAINT PK_NHANVIEN
    PRIMARY KEY (MANV)
)

CREATE TABLE PHANCONG
(
    MANV VARCHAR(15),
    NGAYDI DATE,
    MACB VARCHAR(4)

    CONSTRAINT PK_PHANCONG
    PRIMARY KEY (MANV, NGAYDI, MACB)
)

-- BƯỚC 3: TẠO KHOÁ NGOẠI (DÃY LIÊN KẾT)
ALTER TABLE DATCHO -- BẢNG ĐẦU Ở VÔ CỰC
ADD
    CONSTRAINT FK_DATCHO_KHACHHANG -- ĐẶT TÊN CHO KHOÁ
    FOREIGN KEY (MAKH) -- THUỘC TÍNH CỦA BẢNG ALTER
    REFERENCES KHACHHANG, -- BẢNG Ở ĐẦU CHÌA KHOÁ

    CONSTRAINT FK_DATCHO_LICHBAY
    FOREIGN KEY (NGAYDI, MACB)
    REFERENCES LICHBAY

ALTER TABLE LICHBAY
ADD
    CONSTRAINT FK_LICHBAY_CHUYENBAY
    FOREIGN KEY (MACB)
    REFERENCES CHUYENBAY,

    CONSTRAINT FK_LICHBAY_MAYBAY
    FOREIGN KEY (SOHIEU, MALOAI)
    REFERENCES MAYBAY

ALTER TABLE MAYBAY
ADD
    CONSTRAINT FK_MAYBAY_LOAIMB
    FOREIGN KEY (MALOAI)
    REFERENCES LOAIMB

ALTER TABLE KHANANG
ADD
    CONSTRAINT FK_KHANANG_NHANVIEN
    FOREIGN KEY (MANV)
    REFERENCES NHANVIEN,

    CONSTRAINT FK_KHANANG_LOAIMB
    FOREIGN KEY (MALOAI)
    REFERENCES LOAIMB


ALTER TABLE PHANCONG
ADD
    CONSTRAINT FK_PHANCONG_NHANVIEN
    FOREIGN KEY (MANV)
    REFERENCES NHANVIEN,

    CONSTRAINT FK_PHANCONG_LICHBAY
    FOREIGN KEY (NGAYDI, MACB)
    REFERENCES LICHBAY

INSERT KHACHHANG (MAKH, TEN, DCHI, DIENTHOAI)
VALUES ('0009', 'Nga', '223 Nguyen Trai', '8932320'),
       ('0101', 'Anh', '567 Tran Phu', '8826729'), 
       ('0045', 'Thu', '285 Le Loi', '8932203'),
       ('0012', 'Ha', '435 Quang Trung', '8933232'),
       ('0238', 'Hung', '456 Pasteur', '9812101'),
       ('0397', 'Thanh', '234 Le Van Si', '8952943'),
       ('0582', 'Mai', '789 Nguyen Du', NULL),
       ('0934', 'Minh', '678 Le Lai', NULL),
       ('0091', 'Hai', '345 Hung Vuong', '8893223'),
       ('0314', 'Phuong', '395 Vo Van Tan', '8232320'),
       ('0613', 'Vu', '348 CMT8', '8343232'),
       ('0586', 'Son', '123 Bach Dang', '8556223'),
       ('0422', 'Tien', '75 Nguyen Thong', '8332222')

INSERT CHUYENBAY (MACB, SBDI, SBDEN, GIODI, GIODEN)
VALUES ('100', 'SLC', 'BOS', '08:00', '17:50'),
       ('112', 'DCA', 'DEN', '14:00', '18:07'),
       ('121', 'STL', 'SLC', '07:00', '09:13'),
       ('122', 'STL', 'YYV', '08:30', '10:19'),
       ('206', 'DFW', 'STL', '09:00', '11:40'),
       ('330', 'JFK', 'YYV', '16:00', '18:53'),
       ('334', 'ORD', 'MIA', '12:00', '14:14'),
       ('335', 'MIA', 'ORD', '15:00', '17:14'),
       ('336', 'ORD', 'MIA', '18:00', '20:14'),
       ('337', 'MIA', 'ORD', '20:30', '23:53'),
       ('394', 'DFW', 'MIA', '19:00', '21:30'),
       ('395', 'MIA', 'DFW', '21:00', '23:43'),
       ('449', 'CDG', 'DEN', '10:00', '19:29'),
       ('930', 'YYV', 'DCA', '13:00', '16:10'),
       ('931', 'DCA', 'YYV', '17:00', '18:10'),
       ('932', 'DCA', 'YYV', '18:00', '19:10'),
       ('991', 'BOS', 'ORD', '17:00', '18:22')

INSERT LOAIMB (HANGSX, MALOAI)
VALUES ('Airbus', 'A310'),
       ('Airbus', 'A320'),
       ('Airbus', 'A330'),
       ('Airbus', 'A340'),
       ('Boeing', 'B727'),
       ('Boeing', 'B747'),
       ('Boeing', 'B757'),
       ('MD', 'DC10'),
       ('MD', 'DC9')

INSERT NHANVIEN (MANV, TEN, DCHI, DTHOAI, LUONG, LOAINV)
VALUES ('1006', 'Chi', '12/6 Nguyen Kiem', '8120012', 150000, 0),
       ('1005', 'Giao', '65 Nguyen Thai Son', '8324467', 500000, 0),
       ('1001', 'Huong', '8 Dien Bien Phu', '8330733', 500000, 1),
       ('1002', 'Phong', '1 Ly Thuong Kiet', '8308117', 450000, 1),
       ('1004', 'Phuong', '351 Lac Long Quan', '8308155', 250000, 0),
       ('1003', 'Quang', '78 Truong Dinh', '8324461', 150000, 1),
       ('1007', 'Tam', '36 Nguyen Van Cu', '8458188', 500000, 0)

INSERT KHANANG (MANV, MALOAI)
VALUES ('1001', 'B727'),
       ('1001', 'B747'),
       ('1001', 'DC10'),
       ('1001', 'DC9'),
       ('1002', 'A320'),
       ('1002', 'A340'),
       ('1002', 'B757'),
       ('1002', 'DC9'),
       ('1003', 'A310'),
       ('1003', 'DC9')

INSERT MAYBAY (SOHIEU, MALOAI)
VALUES (10, 'B747'),
       (11, 'B727'),
       (13, 'B727'),
       (13, 'B747'),
       (21, 'DC10'),
       (21, 'DC9'),
       (22, 'B757'),
       (22, 'DC9'),
       (23, 'DC9'),
       (24, 'DC9'),
       (70, 'A310'),
       (80, 'A310'),
       (93, 'B757')

INSERT LICHBAY (NGAYDI, MACB, SOHIEU, MALOAI)
VALUES ('2000/01/11', '100', 80, 'A310'),
       ('2000/01/11', '112', 21, 'DC10'),
       ('2000/01/11', '206', 22, 'DC9'),
       ('2000/01/11', '334', 10, 'B747'),
       ('2000/01/11', '395', 23, 'DC9'),
       ('2000/01/11', '991', 22, 'B757'),
       ('2000/01/11', '337', 10, 'B747'),
       ('2000/01/31', '100', 11, 'B727'),
       ('2000/01/31', '112', 11, 'B727'),
       ('2000/01/31', '206', 13, 'B727'),
       ('2000/01/31', '334', 10, 'B747'),
       ('2000/01/31', '335', 10, 'B747'),
       ('2000/01/31', '337', 24, 'DC9'),
       ('2000/01/31', '449', 70, 'A310')

INSERT PHANCONG (MANV, NGAYDI, MACB)
VALUES ('1001', '2000/01/11', '100'),
       ('1001', '2000/10/31', '100'),
       ('1002', '2000/01/11', '100'), 
       ('1002', '2000/10/31', '100'),
       ('1003', '2000/10/31', '100'),
       ('1003', '2000/10/31', '337'),
       ('1004', '2000/10/31', '100'),
       ('1004', '2000/10/31', '337'),
       ('1005', '2000/10/31', '337'),
       ('1006', '2000/01/11', '991'),
       ('1006', '2000/10/31', '337'),
       ('1007', '2000/01/11', '112'),
       ('1007', '2000/01/11', '991'),
       ('1007', '2000/10/31', '206')

INSERT DATCHO (MAKH, NGAYDI, MACB)
VALUES ('0009', '2000/11/01', '100'),
       ('0009', '2000/10/31', '449'),
       ('0045', '2000/01/11', '991'),
       ('0012', '2000/10/31', '206'),
       ('0238', '2000/10/31', '334'),
       ('0582', '2000/01/11', '991'),
       ('0091', '2000/01/11', '100'),
       ('0314', '2000/10/31', '449'),
       ('0613', '2000/01/11', '100'),
       ('0586', '2000/01/11', '991'), 
       ('0586', '2000/10/31', '100')


SELECT * FROM KHACHHANG
SELECT * FROM CHUYENBAY
SELECT * FROM LOAIMB
SELECT * FROM NHANVIEN
SELECT * FROM KHANANG
SELECT * FROM MAYBAY
SELECT * FROM LICHBAY
SELECT * FROM DATCHO
SELECT * FROM PHANCONG