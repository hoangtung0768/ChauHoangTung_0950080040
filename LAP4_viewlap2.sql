USE  QLBANHANG;



-- 1. Hiển thị thông tin các bảng dữ liệu trên --
GO
CREATE VIEW Cau1_LAP2 AS
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
GO
SELECT * FROM Cau1_LAP2;
-- 2.Đưa ra thông tin masp, tensp, tenhang,soluong, mausac, giaban, donvitinh, mota của các sản phẩm sắp xếp theo chiều giảm dần giá bán--
GO
CREATE VIEW Cau2_LAP2 AS
SELECT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
ORDER BY Sanpham.giaban DESC;
GO
SELECT * FROM Cau2_LAP2;
-- 3.Đưa ra thông tin các sản phẩm có trong cữa hàng do công ty có tên hãng là samsung sản xuất. --
GO
CREATE VIEW Cau3_LAP2 AS
SELECT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung'
GO
SELECT * FROM Cau3_LAP2;
-- 4.Đưa ra thông tin các nhân viên Nữ ở phòng ‘Kế toán’.--
GO
CREATE VIEW Cau4_LAP2 AS
SELECT * FROM nhanvien
WHERE gioitinh = 'Nữ' AND phong = 'Kế toán'
GO

SELECT * FROM Cau4_LAP2;
-- 5.Đưa ra thông tin phiếu nhập gồm: sohdn, masp, tensp, tenhang, soluongN, dongiaN, tiennhap=soluongN*dongiaN, mausac, donvitinh, ngaynhap, tennv, phong. Sắp xếp theo chiều tăng dần của hóa đơn nhập.--
GO
CREATE VIEW Cau5_LAP2 AS
SELECT TOP 100 PERCENT Nhap.sohdn, Sanpham.masp,Sanpham.tensp, Hangsx.tenhang, Nhap.soluongN, Nhap.dongiaN, Nhap.soluongN*Nhap.dongiaN AS 
tiennhap, Sanpham.mausac, Sanpham.donvitinh, Nhap.ngaynhap, Nhanvien.tennv, Nhanvien.phong
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
ORDER BY Nhap.sohdn ASC;
GO

SELECT * FROM Cau5_LAP2;
-- 6. --
GO
CREATE VIEW Cau6_LAP2 AS
SELECT TOP 100 PERCENT Xuat.sohdx, Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Xuat.soluongX, Sanpham.giaban, 
       Xuat.soluongX*Sanpham.giaban AS tienxuat, Sanpham.mausac, Sanpham.donvitinh, Xuat.ngayxuat, 
       Nhanvien.tennv, Nhanvien.phong
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
INNER JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE MONTH(Xuat.ngayxuat) = 10 AND YEAR(Xuat.ngayxuat) = 2018
ORDER BY Xuat.sohdx ASC;
GO
SELECT * FROM Cau6_LAP2;
-- 7.  --
GO
CREATE VIEW Cau7_LAP2 AS
SELECT TOP 100 PERCENT sohdn, Sanpham.masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong
FROM Nhap 
JOIN Sanpham ON Nhap.masp = Sanpham.masp 
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(ngaynhap) = 2017;
GO
SELECT * FROM Cau7_LAP2;
--8. --
GO
CREATE VIEW Cau8_LAP2 AS
SELECT TOP 10 Xuat.sohdx, Sanpham.tensp, Xuat.soluongX
FROM Xuat 
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE YEAR(Xuat.ngayxuat) = '2023' 
ORDER BY Xuat.soluongX DESC;
GO
SELECT * FROM Cau8_LAP2;
--9. --
GO
CREATE VIEW Cau9_LAP2 AS
SELECT TOP 10 tenSP, giaBan
FROM SanPham
ORDER BY giaBan DESC;
GO
SELECT * FROM Cau9_LAP2;
--10. --
GO
CREATE VIEW Cau10_LAP2 AS
 SELECT Sanpham.masp, Sanpham.tensp, Sanpham.giaban, Hangsx.mahangsx AS mahangsx_hs, Hangsx.tenhang
FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000
GO
SELECT * FROM Cau10_LAP2;
--11 --
GO
CREATE VIEW Cau11_LAP2 AS
SELECT SUM(soluongN * dongiaN) AS tongtien
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(ngaynhap) = 2018
GO
SELECT * FROM Cau11_LAP2;
--12 --
GO
CREATE VIEW Cau12_LAP2 AS
SELECT SUM(Xuat.soluongX * Sanpham.giaban) AS Tongtien
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE Xuat.ngayxuat = '2018-09-02'
GO
SELECT * FROM Cau12_LAP2;
--13 --
GO
CREATE VIEW Cau13_LAP2 AS
SELECT TOP 1 sohdn, ngaynhap, dongiaN
FROM Nhap
ORDER BY dongiaN DESC
GO
SELECT * FROM Cau1_LAP2;
--14 --
GO 
CREATE VIEW Cau14_LAP2 AS
SELECT TOP 10 Sanpham.tensp, SUM(Nhap.soluongN) AS TongSoLuongN 
FROM Sanpham 
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp 
WHERE YEAR(Nhap.ngaynhap) = 2019 
GROUP BY Sanpham.tensp 
ORDER BY TongSoLuongN DESC
GO
SELECT * FROM Cau14_LAP2;
--15 --
GO 
CREATE VIEW Cau15_LAP2 AS
SELECT Sanpham.masp, Sanpham.tensp
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
INNER JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE Hangsx.tenhang = 'Samsung' AND Nhanvien.manv = 'NV01';
GO
SELECT * FROM Cau15_LAP2;
--16 --
GO
CREATE VIEW Cau16_LAP2 AS
SELECT sohdn, masp, soluongN, ngaynhap
FROM Nhap
WHERE masp = 'SP02' AND manv = 'NV02'
GO
SELECT * FROM Cau16_LAP2;
--17 --
GO
CREATE VIEW Cau17_LAP2 AS
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Xuat.masp = 'SP02' AND Xuat.ngayxuat = '2020-03-02'
GO
SELECT * FROM Cau17_LAP2;