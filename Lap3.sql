-- 1 Specify xem mỗi hãng sản xuất có bao nhiêu loại sản phẩm--

SELECT Hangsx.mahangsx, Hangsx.tenhang, COUNT(Sanpham.masp) AS SoLoaiSanPham
FROM Hangsx
LEFT JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
GROUP BY Hangsx.mahangsx, Hangsx.tenhang;

-- 2 Hãy thống kê xem tổng tiền nhập của từng sản phẩm trong năm 2018--

SELECT Sanpham.masp, Sanpham.tensp, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM Sanpham
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Sanpham.masp, Sanpham.tensp;

-- 3 Hãy thống kê các sản phẩm có tổng sản lượng năm 2018 lớn hơn 10.000 sản phẩm--
-- sản phẩm của hãng samsung.--

SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) AS TongSoLuongXuat
FROM Sanpham
INNER JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Sanpham.mahangsx = 'SAMSUNG' 
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;

-- 4 Thống kê số lượng nhân viên Nam của mỗi phòng ban.--

SELECT Nhanvien.phong, COUNT(*) AS SoLuongNhanVienNam
FROM Nhanvien
WHERE Nhanvien.gioitinh = N'Nam'
GROUP BY Nhanvien.phong;

-- 5 Thống kê tổng lượng nhập của mỗi hãng sản xuất trong năm 2018.--

SELECT Hangsx.tenhang, SUM(Nhap.soluongN) AS TongSoLuongNhap
FROM Hangsx
INNER JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang

-- 6 Hãy xem thống kê tổng số tiền xuất ra của mỗi nhân viên trong năm 2018 là bao--

SELECT Nhanvien.tennv, SUM(Xuat.soluongX * Sanpham.giaban) AS TongTienXuat
FROM Nhanvien
INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE YEAR(Xuat.ngayxuat) = 2018
GROUP BY Nhanvien.tennv

-- 7 Please đưa ra tổng số tiền đầu vào của mỗi nhân viên trong tháng 8 – năm 2018 có tổng giá trị--
--lớn hơn 100.000--

SELECT Nhanvien.tennv, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM Nhanvien
INNER JOIN Nhap ON Nhanvien.manv = Nhap.manv
WHERE YEAR(Nhap.ngaynhap) = 2018 AND MONTH(Nhap.ngaynhap) = 8
GROUP BY Nhanvien.tennv
HAVING SUM(Nhap.soluongN * Nhap.dongiaN) > 100000

-- 8 Please đưa ra danh sách các sản phẩm đã nhập nhưng chưa xuất bao giờ.--

SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
LEFT JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE Xuat.masp IS NULL


-- 9 Please đưa ra danh sách các sản phẩm đã nhập vào năm 2018 và xuất hiện vào năm 2018.--

SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
INNER JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Nhap.ngaynhap) = 2018 AND YEAR(Xuat.ngayxuat) = 2018

-- 10 Please đưa ra danh sách các nhân viên vừa nhập vừa xuất.--

SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
INNER JOIN Nhap ON Nhanvien.manv = Nhap.manv
INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv

-- 11 Hãy đưa ra danh sách các nhân viên không tham gia công việc nhập và xuất.--

SELECT *
FROM Nhanvien
LEFT JOIN Nhap ON Nhanvien.manv = Nhap.manv
LEFT JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Nhap.manv IS NULL AND Xuat.manv IS NULL;