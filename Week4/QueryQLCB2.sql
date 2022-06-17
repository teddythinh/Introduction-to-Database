USE QLCHUYENBAY 
GO 

-- CÂU 17: Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh xuống sân bay đó.
-- Kết quả được sắp xếp theo thứ tự tăng dần của sân bay đến.
SELECT
    SBDEN,
    COUNT(*)
FROM
    CHUYENBAY CB
GROUP BY
    SBDEN
ORDER BY
    SBDEN ASC 
    
-- CÂU 18: Với mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát từ sân bay đó,
-- sắp xếp theo thứ tự tăng dần của sân bay xuất phát.	
SELECT
    SBDI,
    COUNT(*)
FROM
    CHUYENBAY CB
GROUP BY
    SBDI
ORDER BY
    SBDI ASC 
    
-- CÂU 19: Với mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát theo từng ngày.
-- Xuất ra mã sân bay đi, ngày và số lượng.
SELECT
    CB.SBDI,
    LB.NGAYDI,
    COUNT(*)
FROM
    CHUYENBAY CB,
    LICHBAY LB
WHERE
    CB.MACB = LB.MACB
GROUP BY
    SBDI,
    NGAYDI 
    
-- CÂU 20: Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh theo từng ngày. 
-- Xuất ra mã sân bay đến, ngày và số lượng.
SELECT
    CB.SBDEN,
    LB.NGAYDI,
    COUNT(*)
FROM
    CHUYENBAY CB,
    LICHBAY LB
WHERE
    CB.MACB = LB.MACB
GROUP BY
    SBDEN,
    NGAYDI 
    
-- CÂU 21: Với mỗi lịch bay, cho biết mã chuyến bay, ngày đi 
-- cùng với số lượng nhân viên không phải là phi công của chuyến bay đó.
SELECT
    LB.MACB,
    LB.NGAYDI,
    COUNT(*)
FROM
    LICHBAY LB,
    NHANVIEN NV,
    PHANCONG PC
WHERE
    NV.MANV = PC.MANV
    AND PC.NGAYDI = LB.NGAYDI
    AND PC.MACB = LB.MACB
    AND NV.LOAINV <> 1
GROUP BY
    LB.MACB,
    LB.NGAYDI 
    
-- CÂU 22: Số lượng chuyến bay xuất phát từ sân bay MIA vào ngày 11/01/2000.
SELECT
    COUNT(*)
FROM
    CHUYENBAY CB,
    LICHBAY LB
WHERE
    LB.MACB = CB.MACB
    AND CB.SBDI = 'MIA'
    AND LB.NGAYDI = '2000/11/01' 
    
-- CÂU 23: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, số lượng nhân viên 
-- được phân công trên chuyến bay đó, sắp theo thứ tự giảm dần của số lượng.
SELECT
    CB.MACB,
    LB.NGAYDI,
    COUNT(*)
FROM
    CHUYENBAY CB,
    LICHBAY LB,
    PHANCONG PC
WHERE
    CB.MACB = LB.MACB
    AND PC.MACB = LB.MACB
GROUP BY
    CB.MACB,
    LB.NGAYDI
ORDER BY
    COUNT(*) DESC 
    
-- CÂU 24: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, cùng với số lượng
-- hành khách đã đặt chỗ của chuyến bay đó, sắp theo thứ tự giảm dần của số lượng.
SELECT
    CB.MACB,
    LB.NGAYDI,
    COUNT(*)
FROM
    CHUYENBAY CB,
    LICHBAY LB,
    DATCHO DC
WHERE
    CB.MACB = LB.MACB
    AND DC.MACB = LB.MACB
    AND DC.NGAYDI = LB.NGAYDI
GROUP BY
    CB.MACB,
    LB.NGAYDI
ORDER BY
    COUNT(*) DESC 
    
-- CÂU 25: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, tổng lương của phi hành đoàn
-- (các nhân viên được phân công trong chuyến bay), sắp xếp theo thứ tự tăng dần của tổng lương.
SELECT
    CB.MACB,
    LB.NGAYDI,
    SUM(NV.LUONG)
FROM
    CHUYENBAY CB,
    LICHBAY LB,
    NHANVIEN NV,
    PHANCONG PC
WHERE
    CB.MACB = LB.MACB
    AND PC.MACB = LB.MACB
    AND PC.NGAYDI = LB.NGAYDI
    AND NV.MANV = PC.MANV
GROUP BY
    CB.MACB,
    LB.NGAYDI
ORDER BY
    SUM(NV.LUONG) ASC 
    
-- CÂU 26: Cho biết lương trung bình của các nhân viên không phải là phi công.
SELECT
    AVG(LUONG)
FROM
    NHANVIEN
WHERE
    LOAINV <> 1 
    
-- CÂU 27: Cho biết mức lương trung bình của các phi công.
SELECT
    AVG(LUONG)
FROM
    NHANVIEN
WHERE
    LOAINV <> 0 
    
-- CÂU 28: Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay trên loại máy bay
-- đó hạ cánh xuống sân bay ORD. Xuất ra mã loại máy bay, số lượng chuyến bay.
SELECT
    LMB.MALOAI,
    COUNT(*)
FROM
    LOAIMB LMB,
    MAYBAY MB,
    LICHBAY LB,
    CHUYENBAY CB
WHERE
    LMB.MALOAI = MB.MALOAI
    AND MB.SOHIEU = LB.SOHIEU
    AND LB.MACB = CB.MACB
    AND SBDEN = 'ORD'
GROUP BY
    LMB.MALOAI 
    
-- CÂU 29: Cho biết sân bay (SBDI) và số lượng chuyến bay có 
-- nhiều hơn 2 chuyến bay xuất phát trong khoảng 10 giờ đến 22 giờ.
SELECT
    SBDI,
    COUNT(*)
FROM
    CHUYENBAY
WHERE
    GIODI BETWEEN '10:00:00'
    AND '22:00:00'
GROUP BY
    SBDI
HAVING
    COUNT(*) > 2 
    
-- CÂU 30: Cho biết tên phi công được phân công 
-- vào ít nhất 2 chuyến bay trong cùng một ngày.
SELECT
    NV.TEN
FROM
    NHANVIEN NV,
    PHANCONG PC
WHERE
    NV.MANV = PC.MANV
    AND NV.LOAINV = 1
GROUP BY
    NV.TEN
HAVING
    COUNT(PC.MACB) >= 2 
    
-- CÂU 31: Cho biết mã chuyến bay và ngày đi của 
-- những chuyến bay có ít hơn 3 hành khách đặt chỗ.
SELECT
    LB.MACB,
    LB.NGAYDI
FROM
    LICHBAY LB,
    DATCHO DC
WHERE
    LB.NGAYDI = DC.NGAYDI
    AND LB.MACB = DC.MACB
GROUP BY
    LB.MACB,
    LB.NGAYDI
HAVING
    COUNT(DC.MACB) < 3 
    
-- CÂU 32: Cho biết số hiệu máy bay và loại máy bay mà 
-- phi công có mã 1001 được phân công lái trên 2 lần.
SELECT
    LB.SOHIEU,
    LB.MALOAI
FROM
    PHANCONG PC,
    LICHBAY LB
WHERE
    PC.MACB = LB.MACB
    AND PC.NGAYDI = LB.NGAYDI
    AND PC.MANV = '1001'
GROUP BY
    LB.SOHIEU,
    LB.MALOAI
HAVING
    COUNT(*) > 2 
    
-- CÂU 33: Với mỗi hãng sản xuất, cho biết số lượng loại máy bay
-- mà hãng đó đã sản xuất. Xuất ra hãng sản xuất và số lượng.
SELECT
    HANGSX,
    COUNT(*)
FROM
    LOAIMB
GROUP BY
    HANGSX