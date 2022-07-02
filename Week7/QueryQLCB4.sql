-- MSSV: 20127335
-- Topic: 06
USE QLCHUYENBAY 
GO 

-- CÂU 51: Cho biết mã những chuyến bay đã bay tất cả các máy bay của hãng "Boeing".
SELECT
	LB.MACB AS N'Mã chuyến bay'
FROM
	LICHBAY LB,
	MAYBAY MB
WHERE
	LB.MALOAI = MB.MALOAI
	AND NOT EXISTS (
		SELECT
			LMB.MALOAI
		FROM
			LOAIMB LMB
		WHERE
			LMB.HANGSX = 'Boeing'
		EXCEPT
		SELECT
			MB2.MALOAI
		FROM
			MAYBAY MB2
		WHERE
			MB2.MALOAI = MB.MALOAI
	) 
    
-- CÂU 52: Cho biết mã và tên phi công có khả năng lái tất cả các máy bay của hãng "Airbus".
SELECT
	DISTINCT NV.MANV AS N'Mã nhân viên',
	NV.TEN AS N'Tên phi công'
FROM
	NHANVIEN NV
WHERE
	NV.LOAINV = 1
	AND NOT EXISTS (
		SELECT
			LMB.MALOAI
		FROM
			LOAIMB LMB
		WHERE
			LMB.HANGSX = 'Airbus'
		EXCEPT
		SELECT
			KN2.MALOAI
		FROM
			KHANANG KN2,
			NHANVIEN NV2
		WHERE
			KN2.MANV = NV2.MANV
	) 
    
-- CÂU 53: Cho biết tên nhân viên (không phải là phi công) 
-- được phân công bay vào tất cả các chuyến bay có mã 100.
SELECT
	NV.TEN AS N'Tên nhân viên (không phải là phi công)'
FROM
	NHANVIEN NV
WHERE
	NV.LOAINV <> 1
	AND NOT EXISTS (
		SELECT
			CB.MACB
		FROM
			CHUYENBAY CB
		WHERE
			CB.MACB = '100'
		EXCEPT
		SELECT
			PC.MACB
		FROM
			PHANCONG PC,
			NHANVIEN NV2
		WHERE
			PC.MANV = NV2.MANV
	) 
    
-- CÂU 54: Cho biết ngày đi nào mà có tất cả các loại máy bay của hãng "Boeing" tham gia.
SELECT
	DISTINCT LB.NGAYDI AS N'Ngày đi'
FROM
	LICHBAY LB,
	LOAIMB LMB
WHERE
	LB.MALOAI = LMB.MALOAI
	AND LMB.HANGSX = 'Boeing'
	AND NOT EXISTS (
		SELECT
			LMB.MALOAI
		FROM
			LOAIMB LMB2
		WHERE
			LMB2.HANGSX = 'Boeing'
		EXCEPT
		SELECT
			LB2.MALOAI
		FROM
			LICHBAY LB2
		WHERE
			LB2.MALOAI = LB.MALOAI
	) 
    
-- CÂU 55: Cho biết loại máy bay của hãng "Boeing" nào có tham gia vào tất cả các ngày đi.
SELECT
	LMB.MALOAI AS N'Loại máy bay'
FROM
	LOAIMB LMB
WHERE
	LMB.HANGSX = 'Boeing'
	AND NOT EXISTS (
		SELECT
			LB.NGAYDI
		FROM
			LICHBAY LB
		EXCEPT
		SELECT
			LB.NGAYDI
		FROM
			LICHBAY LB
		WHERE
			LB.MALOAI = LMB.MALOAI
	) 
    
-- CÂU 56: Cho biết mã và tên các khách hàng có 
-- đặt chỗ trong tất cả các ngày từ 31/10/2000 đến 1/1/2000.
SELECT
	DISTINCT KH.MAKH AS N'Mã khách hàng',
	KH.TEN N'Tên khách hàng'
FROM
	KHACHHANG KH,
	DATCHO DC
WHERE
	KH.MAKH = DC.MAKH
	AND NOT EXISTS (
		SELECT
			DC.NGAYDI
		FROM
			DATCHO DC2
		WHERE
			DC.NGAYDI BETWEEN '01/01/2000' AND '10/31/2000'
		EXCEPT
		SELECT
			DC3.NGAYDI
		FROM
			DATCHO DC3
		WHERE
			DC3.MAKH = DC.MAKH
	) 
    
-- CÂU 57: Cho biết mã và tên phi công không có khả
-- năng lái được tất cả các máy bay của hãng "Airbus"
SELECT
	NV.MANV AS N'Mã nhân viên',
	NV.TEN AS N'Tên phi công'
FROM
	NHANVIEN NV
WHERE
	NV.LOAINV = 1
	AND EXISTS (
		SELECT
			LMB.MALOAI
		FROM
			LOAIMB LMB
		WHERE
			LMB.HANGSX = 'Airbus'
		EXCEPT
		SELECT
			KN.MALOAI
		FROM
			KHANANG KN
		WHERE
			KN.MANV = NV.MANV
	) 
    
-- CÂU 58: Cho biết sân bay nào đã có tất cả các loại máy bay của hãng "Boeing" xuất phát.
SELECT
	CB.SBDI AS N'Sân bay xuất phát'
FROM
	CHUYENBAY CB
WHERE
	NOT EXISTS (
		SELECT
			LMB.MALOAI
		FROM
			LOAIMB LMB
		WHERE
			LMB.HANGSX = 'Boeing'
		EXCEPT
		SELECT
			LB.MALOAI
		FROM
			LICHBAY LB
		WHERE
			LB.MACB = CB.MACB
	)