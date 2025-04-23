

-- Sử dụng Database vừa tạo
USE QL_banvexebus;
GO

-- Tạo bảng XeBus
CREATE TABLE XeBus (
    MaXeBus VARCHAR(10) PRIMARY KEY,
    BienSo VARCHAR(15),
    SucChua INT
);
GO

-- Tạo bảng TuyenXeBus
CREATE TABLE TuyenXeBus (
    MaTuyen VARCHAR(10) PRIMARY KEY,
    TenTuyen NVARCHAR(50),
    DiemBatDau NVARCHAR(50),
    DiemKetThuc NVARCHAR(50),
    KhoangCach DECIMAL(10, 2)
);
GO

-- Tạo bảng LichTrinhXeBus
CREATE TABLE LichTrinhXeBus (
    MaLichTrinh INT PRIMARY KEY IDENTITY(1,1), -- Tự động tăng
    MaXeBus VARCHAR(10),
    MaTuyen VARCHAR(10),
    NgayGioXuatPhat DATETIME,
    FOREIGN KEY (MaXeBus) REFERENCES XeBus(MaXeBus),
    FOREIGN KEY (MaTuyen) REFERENCES TuyenXeBus(MaTuyen)
);
GO

-- Tạo bảng VeXe
CREATE TABLE VeXe (
    MaVe INT PRIMARY KEY IDENTITY(1,1), -- Tự động tăng
    LoaiVe NVARCHAR(50),
    GiaVe DECIMAL(10, 2),
    MaTuyen VARCHAR(10),
    FOREIGN KEY (MaTuyen) REFERENCES TuyenXeBus(MaTuyen)
);
GO

-- Tạo bảng NhanVienBanVe
CREATE TABLE NhanVienBanVe (
    MaNV VARCHAR(10) PRIMARY KEY,
    TenNV NVARCHAR(50),
    SoDienThoai VARCHAR(15)
);
GO

-- Tạo bảng KhachHang
CREATE TABLE KhachHang (
    MaKhachHang VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(50),
    SoDienThoai VARCHAR(15)
);
GO

-- Tạo bảng DatVe
CREATE TABLE DatVe (
    MaDatVe INT PRIMARY KEY IDENTITY(1,1), -- Tự động tăng
    MaKhachHang VARCHAR(10),
    MaVe INT,
    NgayDatVe DATETIME,
    TrangThai NVARCHAR(20),
    MaNV VARCHAR(10),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaVe) REFERENCES VeXe(MaVe),
    FOREIGN KEY (MaNV) REFERENCES NhanVienBanVe(MaNV)
);
GO

ALTER TABLE TuyenXeBus
ADD ThoiGianDuKien TIME;
GO


CREATE TABLE NhatKyLichTrinh (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MaLichTrinh INT,
    MaTuyen VARCHAR(10),
    ThoiGianDuKien TIME,
    NgayGioThem DATETIME DEFAULT GETDATE()
);
GO

-- Tạo Trigger
CREATE TRIGGER TR_ThemLichTrinh
ON LichTrinhXeBus
AFTER INSERT
AS
BEGIN
    INSERT INTO NhatKyLichTrinh (MaLichTrinh, MaTuyen, ThoiGianDuKien)
    SELECT i.MaLichTrinh, i.MaTuyen, t.ThoiGianDuKien
    FROM inserted i
    JOIN TuyenXeBus t ON i.MaTuyen = t.MaTuyen;
END;
GO

-- 4. Nhập dữ liệu có kiểm soát để test sự hiệu quả của trigger auto run.
-- Nhập dữ liệu vào TuyenXeBus (bao gồm ThoiGianDuKien)
INSERT INTO TuyenXeBus   (MaTuyen, TenTuyen, DiemBatDau, DiemKetThuc, KhoangCach, ThoiGianDuKien)
VALUES
('T01', N'Long Biên - BX Gia Lâm', N'Long Biên', N'BX Gia Lâm', 10.5, '00:25:00'),
('T02', N'Yên Nghĩa - Kim Mã', N'Yên Nghĩa', N'Kim Mã', 15.2, '00:35:00');
GO

-- Nhập dữ liệu vào XeBus
INSERT INTO XeBus (MaXeBus, BienSo, SucChua)
VALUES
('XB001', '29A-12345', 45),
('XB002', '30B-54321', 30);
GO

-- Nhập dữ liệu vào LichTrinhXeBus (kích hoạt trigger)
INSERT INTO LichTrinhXeBus (MaXeBus, MaTuyen, NgayGioXuatPhat)
VALUES
('XB001', 'T01', '2025-04-24 07:00:00'),
('XB002', 'T02', '2025-04-24 07:30:00');
GO

-- Kiểm tra kết quả trong bảng nhật ký
SELECT * FROM NhatKyLichTrinh;
GO