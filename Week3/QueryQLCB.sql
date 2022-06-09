USE QLCHUYENBAY GO 

-- CÂU 1: Cho biết mã số, tên phi công, địa chỉ, điện thoại của các phi công đã từng lái máy bay loại B747.
SELECT
    KN.MANV,
    TEN,
    DCHI,
    DTHOAI
FROM
    NHANVIEN NV,
    KHANANG KN
WHERE
    MALOAI = 'B747'
    AND KN.MANV = NV.MANV
    AND NV.LOAINV = 1 
    
-- CÂU 2: Cho biết mã số và ngày đi của các chuyến bay xuất phát từ sân bay DCA 
-- trong khoảng thời gian từ 14 giờ đến 18 giờ.
SELECT
    LB.MACB,
    NGAYDI
FROM
    LICHBAY LB,
    CHUYENBAY CB
WHERE
    CB.SBDI = 'DCA'
    AND GIODI BETWEEN '14:00'
    AND '18:00'
    AND LB.MACB = CB.MACB 

-- CÂU 3: Cho biết tên những nhân viên được phân công trên chuyến bay có mã số 100 xuất phát tại sân bay SLC.
-- Các dòng dữ liệu xuất ra không được phép trùng lắp.
SELECT
    DISTINCT TEN
FROM
    NHANVIEN NV,
    PHANCONG PC,
    LICHBAY LB,
    CHUYENBAY CB
WHERE
    CB.MACB = '100'
    AND CB.SBDI = 'SLC'
    AND NV.MANV = PC.MANV
    AND PC.MACB = CB.MACB
    AND PC.NGAYDI = LB.NGAYDI
    AND LB.MACB = CB.MACB 

-- CÂU 4: Cho biết mã loại và số hiệu máy bay đã từng xuất phát tại sân bay MIA.
-- Các dòng dữ liệu xuất ra không được phép trùng lắp.
SELECT
    DISTINCT MB.MALOAI,
    MB.SOHIEU
FROM
    MAYBAY MB,
    CHUYENBAY CB,
    LICHBAY LB
WHERE
    CB.MACB = LB.MACB
    AND LB.MALOAI = MB.MALOAI
    AND LB.SOHIEU = MB.SOHIEU
    AND CB.SBDI = 'MIA' 

-- CÂU 5: Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả
-- các hành khách đi trên chuyến bay đó.
-- Sắp xếp theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần.
SELECT
    MACB,
    NGAYDI,
    TEN,
    DCHI,
    DIENTHOAI
FROM
    KHACHHANG KH,
    DATCHO DC
WHERE
    KH.MAKH = DC.MAKH
ORDER BY
    MACB ASC,
    NGAYDI DESC 

-- CÂU 6: Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả 
-- những nhân viên được phân công trong chuyến bay đó.
-- Sắp xếp theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần.
SELECT
    MACB,
    NGAYDI,
    TEN,
    DCHI,
    DTHOAI
FROM
    NHANVIEN NV,
    PHANCONG PC
WHERE
    NV.MANV = PC.MANV
ORDER BY
    MACB ASC,
    NGAYDI DESC 
    
-- CÂU 7: Cho biết mã chuyến bay, ngày đi, mã số và tên của những phi công
-- được phân công vào chuyến bay hạ cánh xuống sân bay ORD.
SELECT
    PC.MACB,
    PC.NGAYDI,
    NV.MANV,
    TEN
FROM
    NHANVIEN NV,
    PHANCONG PC,
    LICHBAY LB,
    CHUYENBAY CB
WHERE
    NV.MANV = PC.MANV
    AND PC.NGAYDI = LB.NGAYDI
    AND PC.MACB = LB.MACB
    AND LB.MACB = CB.MACB
    AND CB.SBDEN = 'ORD'
    AND NV.LOAINV = 1 
    
-- CÂU 8: Cho biết các chuyến bay (mã số chuyến bay, ngày đi và tên của phi công)
-- trong đó phi công có mã 1001 được phân công lái.
SELECT
    MACB,
    NGAYDI,
    TEN
FROM
    NHANVIEN NV,
    PHANCONG PC
WHERE
    NV.MANV = PC.MANV
    AND NV.MANV = '1001' 
    
-- CÂU 9: Cho biết thông tin (mã chuyến bay, sân bay đi, giờ đi, giờ đến, ngày đi)
-- của những chuyến bay hạ cánh xuống DEN. Các chuyến bay được liệt kê theo
-- ngày đi giảm dần và sân bay xuất phát (SBDI) tăng dần.
SELECT
    LB.MACB,
    SBDI,
    GIODI,
    GIODEN,
    NGAYDI
FROM
    LICHBAY LB,
    CHUYENBAY CB
WHERE
    LB.MACB = CB.MACB
    AND SBDEN = 'DEN'
ORDER BY
    NGAYDI DESC,
    SBDI ASC 
    
-- CÂU 10: Với mỗi phi công, cho biết hãng sản xuất và mã loại máy bay mà phi công
--này có khả năng bay được. Xuất ra tên phi công, hãng sản xuất và mã loại máy bay.

SELECT
    TEN,
    HANGSX,
    LMB.MALOAI
FROM
    LOAIMB LMB,
    KHANANG KN,
    NHANVIEN NV
WHERE
    LMB.MALOAI = KN.MALOAI
    AND NV.MANV = KN.MANV
    AND NV.LOAINV = 1 
    
-- CÂU 11: Cho biết mã phi công, tên phi công đã lái máy bay 
-- trong chuyến bay mã số 100 vào ngày 11/01/2000.
SELECT
    DISTINCT NV.MANV,
    TEN
FROM
    NHANVIEN NV,
    PHANCONG PC,
    LICHBAY LB
WHERE
    NV.MANV = PC.MANV
    AND PC.MACB = LB.MACB
    AND PC.MACB = '100'
    AND LB.NGAYDI = '2000/11/01'
    AND NV.LOAINV = 1 
    
-- CÂU 12: Cho biết mã chuyến bay, mã nhân viên, tên nhân viên được phân công
-- vào chuyến bay xuất phát ngày 10/31/2000 tại sân bay MIA vào lúc 20:30.

SELECT
    PC.MACB,
    NV.MANV,
    TEN
FROM
    NHANVIEN NV,
    PHANCONG PC,
    LICHBAY LB,
    CHUYENBAY CB
WHERE
    NV.MANV = PC.MANV
    AND PC.MACB = CB.MACB
    AND LB.MACB = CB.MACB
    AND LB.NGAYDI = '2000/10/31'
    AND CB.SBDI = 'MIA'
    AND CB.GIODI = '20:30' 
    
-- CÂU 13: Cho biết thông tin về chuyến bay (mã chuyến bay, số hiệu,
-- mã loại, hãng sản xuất) mà phi công "Quang" đã lái.
SELECT
    PC.MACB,
    MB.SOHIEU,
    LMB.MALOAI,
    HANGSX
FROM
    LOAIMB LMB,
    MAYBAY MB,
    LICHBAY LB,
    PHANCONG PC,
    NHANVIEN NV
WHERE
    NV.MANV = PC.MANV
    AND PC.MACB = LB.MACB
    AND PC.NGAYDI = LB.NGAYDI
    AND LB.MALOAI = MB.MALOAI
    AND MB.MALOAI = LMB.MALOAI
    AND NV.TEN = 'Quang'
    AND NV.LOAINV = 1 
    
-- CÂU 14: Cho biết tên của những phi công chưa được phân công lái chuyến bay nào.
SELECT
    DISTINCT TEN
FROM
    NHANVIEN NV,
    PHANCONG PC
WHERE
    NV.MANV <> PC.MANV
    AND LOAINV = 1 
    
-- CÂU 15: Cho biết tên khách hàng đã đi chuyến bay trên máy bay của hãng "Boeing".
SELECT
    DISTINCT TEN
FROM
    KHACHHANG KH,
    DATCHO DC,
    LICHBAY LB,
    MAYBAY MB,
    LOAIMB LMB
WHERE
    KH.MAKH = DC.MAKH
    AND DC.MACB = LB.MACB
    AND DC.NGAYDI = LB.NGAYDI
    AND LB.MALOAI = MB.MALOAI
    AND LB.SOHIEU = MB.SOHIEU
    AND MB.MALOAI = LMB.MALOAI
    AND LMB.HANGSX = 'Boeing' 
    
-- CÂU 16: Cho biết mã các chuyến bay chỉ bay với máy bay số hiệu 10 và mã loại B747.
SELECT
    DISTINCT CB.MACB
FROM
    LICHBAY LB,
    CHUYENBAY CB,
    MAYBAY MB
WHERE
    LB.MACB = CB.MACB
    AND LB.MALOAI = MB.MALOAI
    AND LB.SOHIEU = MB.SOHIEU
    AND MB.SOHIEU = 10
    AND MB.MALOAI = 'B747'