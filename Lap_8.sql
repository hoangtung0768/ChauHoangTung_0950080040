go 
use QLBANHANG
go
--cau1--
go
CREATE PROCEDURE addOrUpdateEmployee 
    @manv NVARCHAR(10),
    @gioitinh NVARCHAR(3),
    @diachi NVARCHAR(50),
    @email NVARCHAR(50),
    @phong NVARCHAR(50),
    @flag INT
AS
BEGIN
   
    IF (@gioitinh <> N'Nam' AND @gioitinh <> N'Nữ')
    BEGIN
        SELECT 1 AS 'MaLoi', 'Giới tính không hợp lệ' AS 'MoTaLoi'
        RETURN
    END
    
  
    IF (@flag = 0)
    BEGIN
        INSERT INTO nhanvien (manv, gioitinh, diachi, email, phong)
        VALUES (@manv, @gioitinh, @diachi, @email, @phong)
        SELECT 0 AS 'MaLoi', 'Thêm mới nhân viên thành công' AS 'MoTaLoi'
    END
    -- Ngược lại, flag = 1 thì cập nhật thông tin nhân viên
    ELSE
    BEGIN
        UPDATE nhanvien
        SET gioitinh = @gioitinh,
            diachi = @diachi,
            email = @email,
            phong = @phong
        WHERE manv = @manv
        SELECT 0 AS 'MaLoi', 'Cập nhật thông tin nhân viên thành công' AS 'MoTaLoi'
    END
END
go

--cau2--
go
CREATE PROCEDURE sp_ThemCapNhatSanPham
    @masp INT,
    @tenhang NVARCHAR(50),
    @tensp NVARCHAR(50),
    @soluong INT,
    @mausac NVARCHAR(20),
    @giaban FLOAT,
    @donvitinh NVARCHAR(10),
    @mota NVARCHAR(MAX),
    @flag INT
AS
BEGIN
    DECLARE @mahangsx INT

    -- Kiểm tra xem tenhang có tồn tại trong bảng hangsx hay không
    SELECT @mahangsx = mahangsx FROM hangsx WHERE tenhang = @tenhang
    IF @mahangsx IS NULL
    BEGIN
        -- Trả về mã lỗi 1 nếu tenhang không tồn tại trong bảng hangsx
        SELECT 1 AS [ErrorCode], 'Tên hàng không không hợp lệ ' AS [Message]
        RETURN
    END

    -- Kiểm tra số lượng sản phẩm
    IF @soluong < 0
    BEGIN
        -- Trả về mã lỗi 2 nếu soluong < 0
        SELECT 2 AS [ErrorCode], 'Số lượng không hợp lệ' AS [Message]
        RETURN
    END

    IF @flag = 0 -- Thêm mới sản phẩm
    BEGIN
        INSERT INTO sanpham(masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES(@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)

        SELECT 0 AS [ErrorCode], 'Thêm sản phẩm thành công' AS [Message]
    END
    ELSE -- Cập nhật thông tin sản phẩm
    BEGIN
        UPDATE sanpham
        SET mahangsx = @mahangsx,
            tensp = @tensp,
            soluong = @soluong,
            mausac = @mausac,
            giaban = @giaban,
            donvitinh = @donvitinh,
            mota = @mota
        WHERE masp = @masp

        SELECT 0 AS [ErrorCode], 'Đã cập nhập sản phẩm thành công' AS [Message]
    END
END
go
--cau3--
CREATE PROCEDURE sp_XoaNhanVien
    @manv NVARCHAR(10)
AS
BEGIN
    -- Kiểm tra xem mã nhân viên có tồn tại trong bảng nhanvien hay không
    IF NOT EXISTS (SELECT * FROM nhanvien WHERE manv = @manv)
    BEGIN
        -- Nếu không tồn tại, trả về mã lỗi 1
        SELECT 1 AS 'ErrorCode'
        RETURN
    END
    
    -- Xóa dữ liệu của nhân viên trong bảng Nhập và Xuat
    DELETE FROM Nhap WHERE manv = @manv
    DELETE FROM Xuat WHERE manv = @manv
    
    -- Xóa dữ liệu của nhân viên trong bảng nhanvien
    DELETE FROM nhanvien WHERE manv = @manv
    
    -- Trả về mã lỗi 0 để cho biết xóa thành công
    SELECT 0 AS 'ErrorCode'
END
-----cau 4
go
CREATE PROCEDURE delete_sanpham(@masp VARCHAR(10))
AS
BEGIN
    -- Kiểm tra xem sản phẩm có tồn tại trong bảng sanpham không
    IF NOT EXISTS (SELECT * FROM sanpham WHERE masp = @masp)
    BEGIN
        -- Nếu không tồn tại, trả về mã lỗi 1
        SELECT 1 AS 'ErrorCode'
        RETURN
    END
    
    -- Xóa thông tin sản phẩm trong bảng Nhap
    DELETE FROM Nhap WHERE masp = @masp
    
    -- Xóa thông tin sản phẩm trong bảng Xuat
    DELETE FROM Xuat WHERE masp = @masp
    
    -- Xóa thông tin sản phẩm trong bảng sanpham
    DELETE FROM sanpham WHERE masp = @masp
    
    -- Trả về mã lỗi 0
    SELECT 0 AS 'ErrorCode'
END
----cau 5:
go
CREATE PROCEDURE themHangsx 
    @mahangsx varchar(10),
    @tenhang nvarchar(50),
    @diachi nvarchar(100),
    @sodt varchar(20),
    @email varchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    -- Kiểm tra xem tên hãng sản xuất đã tồn tại hay chưa
    IF EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        -- Trả về mã lỗi 1 nếu tên hãng sản xuất đã tồn tại
        SELECT 1 AS [ErrorCode]
        RETURN
    END

    -- Thêm mới hãng sản xuất vào bảng
    INSERT INTO Hangsx (mahangsx, tenhang, diachi, sodt, email)
    VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email)

    -- Trả về mã lỗi 0 nếu thêm mới thành công
    SELECT 0 AS [ErrorCode]
    RETURN
END