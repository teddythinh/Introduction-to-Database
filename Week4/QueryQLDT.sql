USE QLDETAI GO 

-- CÂU 1: Cho biết họ tên và mức lương của các giáo viên nữ.
SELECT
    HOTEN,
    LUONG
FROM
    GIAOVIEN
WHERE
    PHAI = N 'Nữ' 
    
-- CÂU 2: Cho biết họ tên của các giáo viên và lương của họ sau khi tăng 10%.
SELECT
    HOTEN,
    LUONG * 1.1 AS LUONG
FROM
    GIAOVIEN 
    
-- CÂU 3: Cho biết mã của các giáo viên có họ tên bắt đầu là “Nguyễn” và lương trên $2000 hoặc,
-- giáo viên là trưởng bộ môn nhận chức sau năm 1995.
SELECT
    DISTINCT GV.MAGV
FROM
    GIAOVIEN GV,
    BOMON BM
WHERE
    GV.HOTEN LIKE N 'Nguyễn%'
    AND LUONG > 2000.0
    OR GV.MABM = BM.MABM
    AND GV.GVQLBM = BM.TRUONGBM
    AND YEAR(BM.NGAYNHANCHUC) = 1995 
    
-- CÂU 4: Cho biết tên những giáo viên khoa Công nghệ thông tin.
SELECT
    GV.HOTEN
FROM
    GIAOVIEN GV,
    KHOA K,
    BOMON BM
WHERE
    GV.MAGV = K.TRUONGKHOA
    AND GV.MABM = BM.MABM
    AND BM.MAKHOA = K.MAKHOA
    AND K.TENKHOA = N'Công nghệ thông tin' 
    
-- CÂU 5: Cho biết thông tin của bộ môn cùng thông tin giảng viên làm trưởng bộ môn đó.
SELECT
    *
FROM
    BOMON BM,
    GIAOVIEN GV
WHERE
    GV.MAGV = BM.TRUONGBM 
    
-- CÂU 6: Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc.
SELECT
    BM. *
FROM
    BOMON BM,
    GIAOVIEN GV
WHERE
    GV.MABM = BM.MABM 
    
-- CÂU 7: Cho biết tên đề tài và giáo viên chủ nhiệm đề tài.
SELECT
    DT.TENDT,
    GV.HOTEN
FROM
    DETAI DT,
    GIAOVIEN GV
WHERE
    GV.MAGV = DT.GVCNDT 
    
-- CÂU 8: Với mỗi khoa cho biết thông tin trưởng khoa.
SELECT
    *
FROM
    GIAOVIEN GV,
    KHOA K
WHERE
    GV.MAGV = K.TRUONGKHOA 
    
-- CÂU 9: Cho biết các giáo viên của bộ môn “Vi sinh” có tham gia đề tài 006.
SELECT
    DISTINCT GV.HOTEN
FROM
    GIAOVIEN GV,
    BOMON BM,
    THAMGIADT TGDT
WHERE
    GV.MABM = BM.MABM
    AND TGDT.MAGV = GV.MAGV
    AND BM.TENBM = N'Vi sinh'
    AND TGDT.MADT = 006
    
-- CÂU 10: Với những đề tài thuộc cấp quản lý “Thành phố”, cho biết mã đề tài, đề tài 
-- thuộc về chủ đề nào, họ tên người chủ nhiệm đề tài cùng với 
-- ngày sinh và địa chỉ của người ấy.
SELECT
    DT.MADT,
    CD.TENCD,
    GV.HOTEN,
    GV.NGAYSINH,
    GV.DIACHI
FROM
    DETAI DT,
    GIAOVIEN GV,
    CHUDE CD
WHERE
    DT.GVCNDT = GV.MAGV
    AND DT.MACD = CD.MACD
    AND DT.CAPQL = N'Trường' 

-- CÂU 11: Tìm họ tên của từng giáo viên và người phụ trách chuyên môn trực tiếp của giáo viên đó.
SELECT
    GV.HOTEN
FROM
    GIAOVIEN GV
WHERE
    GV.MAGV = GV.GVQLBM 
    
-- CÂU 12: Tìm họ tên của những giáo viên được “Nguyễn Thanh Tùng” phụ trách trực tiếp.
-- CÂU 13: Cho biết tên giáo viên là trưởng bộ môn “Hệ thống thông tin”.
SELECT
    GV.HOTEN
FROM
    GIAOVIEN GV,
    BOMON BM
WHERE
    GV.MAGV = BM.TRUONGBM
    AND TENBM = N'Hệ thống thông tin' 

-- CÂU 14: Cho biết tên người chủ nhiệm đề tài của những đề tài thuộc chủ đề Quản lý giáo dục.
SELECT
    GV.HOTEN
FROM
    GIAOVIEN GV,
    DETAI DT,
    CHUDE CD
WHERE
    DT.GVCNDT = GV.MAGV
    AND DT.MACD = CD.MACD
    AND CD.TENCD = N'Quản lý giáo dục' 
    
-- CÂU 15: Cho biết tên các công việc của đề tài HTTT quản lý các trường ĐH 
-- có thời gian bắt đầu trong tháng 3/2008.
SELECT
    CV.TENCV
FROM
    CONGVIEC CV,
    DETAI DT
WHERE
    CV.MADT = DT.MADT
    AND DT.TENDT = N'HTTT quản lý các trường ĐH'


    AND YEAR(CV.NGAYBD) = 2008
    AND MONTH(CV.NGAYBD) = 3

-- CÂU 16: Cho biết tên giáo viên và tên người quản lý chuyên môn của giáo viên đó.
SELECT
    GV.HOTEN AS TENGV,
    NQL.HOTEN AS TENNQL
FROM
    GIAOVIEN GV,
    GIAOVIEN NQL
WHERE
    GV.GVQLBM = NQL.MAGV 

-- CÂU 17: Cho các công việc bắt đầu trong khoảng từ 01/01/2007 đến 01/08/2007.
SELECT
    TENCV
FROM
    CONGVIEC
WHERE
    NGAYBD BETWEEN '2007/01/01'
    AND '2007/08/01' 

-- CÂU 18: Cho biết họ tên các giáo viên cùng bộ môn với giáo viên “Trần Trà Hương”.
SELECT
    GV.HOTEN
FROM
    GIAOVIEN GV,
    BOMON BM
WHERE
    GV.MABM = BM.MABM