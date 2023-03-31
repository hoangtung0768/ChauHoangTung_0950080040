-- 1 Specify xem mỗi hãng sản xuất có bao nhiêu loại sản phẩm--
GO
CREATE VIEW Cau1_LAP3 AS
SELECT Hangsx.mahangsx, Hangsx.tenhang, COUNT(Sanpham.masp) AS SoLoaiSanPham
FROM Hangsx
LEFT JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
GROUP BY Hangsx.mahangsx, Hangsx.tenhang;
GO

SELECT * FROM Cau1_LAP3;
-- 2 Hãy thống kê xem tổng tiền nhập của từng sản phẩm trong năm 2018--
GO
CREATE VIEW Cau2_LAP3 AS
SELECT Sanpham.masp, Sanpham.tensp, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM Sanpham
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Sanpham.masp, Sanpham.tensp;
GO

SELECT * FROM Cau2_LAP3;
-- 3 Hãy thống kê các sản phẩm có tổng sản lượng năm 2018 lớn hơn 10.000 sản phẩm--
-- sản phẩm của hãng samsung.--
GO
CREATE VIEW Cau3_LAP3 AS
SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) AS TongSoLuongXuat
FROM Sanpham
INNER JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Sanpham.mahangsx = 'SAMSUNG' 
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;
GO

SELECT * FROM Cau3_LAP3;
-- 4 Thống kê số lượng nhân viên Nam của mỗi phòng ban.--
GO
CREATE VIEW Cau4_LAP3 AS
SELECT Nhanvien.phong, COUNT(*) AS SoLuongNhanVienNam
FROM Nhanvien
WHERE Nhanvien.gioitinh = N'Nam'
GROUP BY Nhanvien.phong;
GO

SELECT * FROM Cau4_LAP3;
-- 5 Thống kê tổng lượng nhập của mỗi hãng sản xuất trong năm 2018.--
GO
CREATE VIEW Cau5_LAP3 AS
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) AS TongSoLuongNhap
FROM Hangsx
INNER JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang
GO

SELECT * FROM Cau5_LAP3;
-- 6 Hãy xem thống kê tổng số tiền xuất ra của mỗi nhân viên trong năm 2018 là bao--
GO
CREATE VIEW Cau6_LAP3 AS
SELECT Nhanvien.tennv, SUM(Xuat.soluongX * Sanpham.giaban) AS TongTienXuat
FROM Nhanvien
INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE YEAR(Xuat.ngayxuat) = 2018
GROUP BY Nhanvien.tennv
GO

SELECT * FROM Cau6_LAP3;
-- 7 Please đưa ra tổng số tiền đầu vào của mỗi nhân viên trong tháng 8 – năm 2018 có tổng giá trị--
--lớn hơn 100.000--
GO
CREATE VIEW Cau7_LAP3 AS
SELECT Nhanvien.tennv, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM Nhanvien
INNER JOIN Nhap ON Nhanvien.manv = Nhap.manv
WHERE YEAR(Nhap.ngaynhap) = 2018 AND MONTH(Nhap.ngaynhap) = 8
GROUP BY Nhanvien.tennv
HAVING SUM(Nhap.soluongN * Nhap.dongiaN) > 100000
GO

SELECT * FROM Cau7_LAP3;
-- 8 Please đưa ra danh sách các sản phẩm đã nhập nhưng chưa xuất bao giờ.--
GO
CREATE VIEW Cau8_LAP3 AS
SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
LEFT JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE Xuat.masp IS NULL

GO

SELECT * FROM Cau8_LAP3;
-- 9 Please đưa ra danh sách các sản phẩm đã nhập vào năm 2018 và xuất hiện vào năm 2018.--
GO
CREATE VIEW Cau9_LAP3 AS
SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
INNER JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Nhap.ngaynhap) = 2018 AND YEAR(Xuat.ngayxuat) = 2018
GO

SELECT * FROM Cau9_LAP3;
-- 10 Please đưa ra danh sách các nhân viên vừa nhập vừa xuất.--
GO
CREATE VIEW Cau10_LAP3 AS
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
INNER JOIN Nhap ON Nhanvien.manv = Nhap.manv
INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
GO

SELECT * FROM Cau10_LAP3;
-- 11 Hãy đưa ra danh sách các nhân viên không tham gia công việc nhập và xuất.--
go
CREATE VIEW Cau11_LAP3 AS
SELECT nv.manv, nv.tennv
FROM Nhanvien nv
WHERE nv.manv NOT IN (
    SELECT DISTINCT manv FROM Nhap
    UNION
    SELECT DISTINCT manv FROM Xuat
)
go
SELECT * FROM Cau11_LAP3;