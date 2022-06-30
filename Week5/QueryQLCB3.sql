-- MSSV: 20127335
-- Topic: 05
USE QLCHUYENBAY 
GO 

-- CÂU 34: Cho biết hãng sản xuất, mã loại và số hiệu của máy bay đã được sử
-- dụng nhiều nhất.
SELECT
	LMB.HANGSX AS N'Hãng sản xuất',
	LMB.MALOAI AS N'Mã loại',
	MB.SOHIEU AS N'Số hiệu'
FROM
	LOAIMB LMB,
	MAYBAY MB,
	LICHBAY LB
WHERE
	MB.MALOAI = LMB.MALOAI
	AND LB.MALOAI = MB.MALOAI
GROUP BY
	MB.SOHIEU,
	LMB.HANGSX,
	LMB.MALOAI
HAVING
	COUNT(*) >= ALL (
		SELECT
			COUNT(*)
		FROM
			LOAIMB LMB,
			MAYBAY MB,
			LICHBAY LB
		WHERE
			MB.MALOAI = LMB.MALOAI
			AND LB.MALOAI = MB.MALOAI
		GROUP BY
			MB.SOHIEU,
			LMB.HANGSX,
			LMB.MALOAI ) 

-- CÂU 35: Cho biết tên nhân viên được phân công đi nhiều chuyến bay nhất.
SELECT
	NV.TEN AS N'Tên'
FROM
	NHANVIEN NV,
	PHANCONG PC
WHERE
	NV.MANV = PC.MANV
GROUP BY
	NV.TEN
HAVING
	COUNT(*) >= ALL (
		SELECT
			COUNT(*)
		FROM
			NHANVIEN NV,
			PHANCONG PC
		WHERE
			NV.MANV = PC.MANV
		GROUP BY
			NV.TEN ) 
            
-- CÂU 36: Cho biết thông tin của phi công (tên, địa chỉ, điện thoại) lái nhiều
-- chuyến bay nhất.
SELECT
	NV.TEN AS N'Tên',
	NV.DCHI AS N'Địa chỉ',
	NV.DTHOAI AS N'Điện thoại'
FROM
	NHANVIEN NV,
	PHANCONG PC,
	LICHBAY LB,
	CHUYENBAY CB
WHERE
	NV.MANV = PC.MANV
	AND PC.MACB = LB.MACB
	AND PC.NGAYDI = LB.NGAYDI
	AND LB.MACB = CB.MACB
	AND NV.LOAINV = 1
GROUP BY
	NV.TEN,
	NV.DCHI,
	NV.DTHOAI
HAVING
	COUNT(*) >= ALL (
		SELECT
			COUNT(*)
		FROM
			NHANVIEN NV1,
			PHANCONG PC1,
			LICHBAY LB,
			CHUYENBAY CB
		WHERE
			NV1.MANV = PC1.MANV
			AND PC1.MACB = LB.MACB
			AND PC1.NGAYDI = LB.NGAYDI
			AND LB.MACB = CB.MACB
			AND NV1.LOAINV = 1
		GROUP BY
			NV1.TEN,
			NV1.DCHI,
			NV1.DTHOAI ) 
            
-- CÂU 37: Cho biết sân bay (SBDEN) và số lượng chuyến bay của sân bay có ít
-- chuyến bay đáp xuống nhất.
SELECT
	CB.SBDEN AS N'Sân bay đến',
	COUNT(*) AS N'Số lượng chuyến bay'
FROM
	CHUYENBAY CB
GROUP BY
	CB.SBDEN
HAVING
	COUNT(*) <= ALL (
		SELECT
			COUNT(*)
		FROM
			CHUYENBAY CB1
		GROUP BY
			CB1.SBDEN ) 
            
-- CÂU 38: Cho biết sân bay (SBDI) và số lượng chuyến bay của sân bay có nhiều
-- chuyến bay xuất phát nhất.
SELECT
	CB.SBDI AS N'Sân bay đi',
	COUNT(*) AS N'Số lượng chuyến bay'
FROM
	CHUYENBAY CB
GROUP BY
	CB.SBDI
HAVING
	COUNT(*) >= ALL (
		SELECT
			COUNT(*)
		FROM
			CHUYENBAY CB1
		GROUP BY
			CB1.SBDI ) 
            
-- CÂU 39: Cho biết tên, địa chỉ, và điện thoại của khách hàng đã đi trên nhiều
-- chuyến bay nhất.
SELECT
	KH.TEN AS N'Tên',
	KH.DCHI AS N'Địa chỉ',
	KH.DIENTHOAI AS N'Điện thoại'
FROM
	KHACHHANG KH,
	DATCHO DC
WHERE
	KH.MAKH = DC.MAKH
GROUP BY
	KH.TEN,
	KH.DCHI,
	KH.DIENTHOAI
HAVING
	COUNT(*) >= ALL (
		SELECT
			COUNT(*)
		FROM
			KHACHHANG KH1,
			DATCHO DC1
		WHERE
			KH1.MAKH = DC1.MAKH
		GROUP BY
			KH1.TEN,
			KH1.DCHI,
			KH1.DIENTHOAI ) 
            
-- CÂU 40: Cho biết mã số, tên và lương của các phi công có khả năng lái nhiều
-- loại máy bay nhất.
SELECT
	NV.MANV AS N'Mã số',
	NV.TEN AS N'Tên',
	NV.LUONG AS N'Lương'
FROM
	NHANVIEN NV,
	KHANANG KN
WHERE
	NV.MANV = KN.MANV
GROUP BY
	NV.MANV,
	NV.TEN,
	NV.LUONG
HAVING
	COUNT(*) >= ALL (
		SELECT
			COUNT(*)
		FROM
			NHANVIEN NV1,
			KHANANG KN1
		WHERE
			NV1.MANV = KN1.MANV
		GROUP BY
			NV1.MANV,
			NV1.TEN,
			NV1.LUONG ) 
            
-- CÂU 41: Cho biết thông tin (mã nhân viên, tên, lương) của nhân viên có mức
-- lương cao nhất.
SELECT
	NV.MANV AS N'Mã nhân viên',
	NV.TEN AS N'Tên',
	NV.LUONG AS N'Lương'
FROM
	NHANVIEN NV
GROUP BY
	NV.MANV,
	NV.TEN,
	NV.LUONG
HAVING
	NV.LUONG >= (
		SELECT
			MAX(NV2.LUONG)
		FROM
			NHANVIEN NV2 ) 
            
-- CÂU 42: Cho biết tên, địa chỉ của các nhân viên có lương cao nhất trong phi
-- hành đoàn (các nhân viên được phân công trong một chuyến bay) mà
-- người đó tham gia.
SELECT
	DISTINCT NV.TEN AS N'Tên',
	NV.DCHI AS N'Địa chỉ'
FROM
	NHANVIEN NV,
	PHANCONG PC
WHERE
	NV.MANV = PC.MANV
	AND NV.LUONG >= ALL(
		SELECT
			NV2.LUONG
		FROM
			NHANVIEN NV2,
			PHANCONG PC2
		WHERE
			NV2.MANV = NV.MANV
			AND PC2.MACB = PC.MACB
			AND NV2.MANV = PC2.MANV ) 
            
-- CÂU 43: Cho biết mã chuyến bay, giờ đi và giờ đến của chuyến bay bay sớm
-- nhất trong ngày.
SELECT
	CB.MACB AS N'Mã chuyến bay',
	CB.GIODI AS N'Giờ đi',
	CB.GIODEN AS N'Giờ đến',
	LB.NGAYDI AS N'Ngày đi'
FROM
	CHUYENBAY CB,
	LICHBAY LB
WHERE
	CB.MACB = LB.MACB
	AND EXISTS (
		SELECT
			*
		FROM
			CHUYENBAY CB2,
			LICHBAY LB2
		WHERE
			CB2.MACB = LB2.MACB
			AND LB.NGAYDI = LB2.NGAYDI
		GROUP BY
			LB2.NGAYDI
		HAVING
			CB.GIODI = MIN(CB2.GIODI) ) 
            
-- CÂU 44: Cho biết mã chuyến bay có thời gian bay dài nhất. Xuất ra mã chuyến
-- bay và thời gian bay (tính bằng phút).
SELECT
	CB.MACB AS N'Mã chuyến bay',
	DATEDIFF(minute, CB.GIODI, CB.GIODEN) AS N'Thời gian bay (phút)'
FROM
	CHUYENBAY CB
WHERE
	DATEDIFF(minute, CB.GIODI, CB.GIODEN) >= ALL (
		SELECT
			DATEDIFF(minute, CB2.GIODI, CB2.GIODEN)
		FROM
			CHUYENBAY CB2 ) 
            
-- CÂU 45: Cho biết mã chuyến bay có thời gian bay ít nhất. Xuất ra mã chuyến
-- bay và thời gian bay.
SELECT
	CB.MACB AS N'Mã chuyến bay',
	DATEDIFF(minute, CB.GIODI, CB.GIODEN) AS N'Thời gian bay (phút)'
FROM
	CHUYENBAY CB
WHERE
	DATEDIFF(minute, CB.GIODI, CB.GIODEN) <= ALL (
		SELECT
			DATEDIFF(minute, CB2.GIODI, CB2.GIODEN)
		FROM
			CHUYENBAY CB2 ) 
            
-- CÂU 46:	Cho biết mã chuyến bay và ngày đi của những chuyến bay bay trên loại
-- máy bay B747 nhiều nhất.
SELECT
	LB.MACB AS N'Mã chuyến bay',
	LB.NGAYDI AS N'Ngày đi'
FROM
	LICHBAY LB
WHERE
	EXISTS (
		SELECT
			*
		FROM
			LICHBAY LB2
		WHERE
			LB2.MACB = LB.MACB
			AND LB2.MALOAI = 'B747'
		GROUP BY
			MACB
		HAVING
			COUNT(LB2.NGAYDI) >= ALL (
				SELECT
					COUNT(LB3.NGAYDI)
				FROM
					LICHBAY LB3
				WHERE
					LB3.MALOAI = 'B747'
				GROUP BY
					MACB ) ) 
                    
-- CÂU 47: Với mỗi chuyến bay có trên 3 hành khách, cho biết mã chuyến bay và
-- số lượng nhân viên trên chuyến bay đó. Xuất ra mã chuyến bay và số
-- lượng nhân viên.
SELECT
	PC.MACB AS N'Mã chuyến bay',
	COUNT(DISTINCT PC.MANV) AS N'Số lượng nhân viên'
FROM
	PHANCONG PC,
	DATCHO DC,
	LICHBAY LB
WHERE
	PC.NGAYDI = LB.NGAYDI
	AND PC.MACB = LB.MACB
	AND DC.MACB = LB.MACB
	AND DC.NGAYDI = LB.NGAYDI
GROUP BY
	PC.MACB,
	LB.NGAYDI
HAVING
	COUNT(DISTINCT DC.MAKH) >= 3 
    
-- CÂU 48: Với mỗi loại nhân viên có tổng lương trên 600000, cho biết số lượng
-- nhân viên trong từng loại nhân viên đó. Xuất ra loại nhân viên, và số
-- lượng nhân viên tương ứng.
SELECT
	NV.LOAINV,
	COUNT(NV.MANV)
FROM
	NHANVIEN NV