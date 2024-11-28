USE [master]
GO
/****** Object:  Database [QLChanGaGoiNem]    Script Date: 08/08/2024 07:52:26 CH ******/
CREATE DATABASE [QLChanGaGoiNem]
 GO



USE [QLChanGaGoiNem]
GO
/****** Object:  Table [dbo].[DanhMucSanPham]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMucSanPham](
	[MaDanhMuc] [int] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](max) NULL,
 CONSTRAINT [PK_DanhMucSanPham] PRIMARY KEY CLUSTERED 
(
	[MaDanhMuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loai]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loai](
	[MaLoaiSP] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](max) NULL,
	[MaDanhMuc] [int] NULL,
 CONSTRAINT [PK_Loai] PRIMARY KEY CLUSTERED 
(
	[MaLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSanPham] [nvarchar](50) NOT NULL,
	[TenSanPham] [nvarchar](255) NOT NULL,
	[DonGia] [decimal](18, 0) NOT NULL,
	[HinhDaiDien] [nvarchar](255) NOT NULL,
	[DSHinh] [nvarchar](255) NOT NULL,
	[MienPhiGiaoHang] [bit] NOT NULL,
	[NhaSanXuat] [nvarchar](255) NOT NULL,
	[MoTa] [nvarchar](max) NOT NULL,
	[MaLoaiSP] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[DanhMucSanPhamView]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create views
CREATE VIEW [dbo].[DanhMucSanPhamView] AS
SELECT sp.MaSanPham, sp.TenSanPham, sp.DonGia, l.TenLoai, dm.TenDanhMuc
FROM [dbo].[SanPham] sp
INNER JOIN [dbo].[Loai] l ON sp.MaLoaiSP = l.MaLoaiSP
INNER JOIN [dbo].[DanhMucSanPham] dm ON l.MaDanhMuc = dm.MaDanhMuc
GO
/****** Object:  Table [dbo].[DonDatHang]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonDatHang](
	[MaDonHang] [int] IDENTITY(1,1) NOT NULL,
	[MaKhachHang] [int] NULL,
	[NgayDatHang] [date] NULL,
	[HinhThucThanhToan] [nvarchar](max) NULL,
	[GhiChu] [nvarchar](max) NULL,
	[TongSLHang] [int] NULL,
	[TongThanhTien] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[MaDonHang] [int] NOT NULL,
	[MaSanPham] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_ChiTietDonHang] PRIMARY KEY CLUSTERED 
(
	[MaDonHang] ASC,
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DonHangChuaGiao]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[DonHangChuaGiao] AS
SELECT ddh.MaDonHang, ddh.MaKhachHang, ddh.NgayDatHang, ddh.HinhThucThanhToan, ddh.GhiChu
FROM [dbo].[DonDatHang] ddh
LEFT JOIN [dbo].[ChiTietDonHang] ctdh ON ddh.MaDonHang = ctdh.MaDonHang
WHERE ctdh.MaSanPham IS NULL
GO
/****** Object:  View [dbo].[DonHangDaGiao]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[DonHangDaGiao] AS
SELECT ddh.MaDonHang, ddh.MaKhachHang, ddh.NgayDatHang, ddh.HinhThucThanhToan, ddh.GhiChu
FROM [dbo].[DonDatHang] ddh
INNER JOIN [dbo].[ChiTietDonHang] ctdh ON ddh.MaDonHang = ctdh.MaDonHang
WHERE ctdh.MaSanPham IS NOT NULL
GO
/****** Object:  Table [dbo].[GiaoHang]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoHang](
	[MaSanPham] [nvarchar](50) NOT NULL,
	[MaTinh] [int] NOT NULL,
	[GiaGiao] [decimal](18, 0) NULL,
	[ThoiGianGiao] [nvarchar](max) NULL,
 CONSTRAINT [PK_GiaoHang] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC,
	[MaTinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKhachHang] [int] IDENTITY(1,1) NOT NULL,
	[TenKhachHang] [nvarchar](max) NULL,
	[DienThoai] [nvarchar](50) NULL,
	[MatKhau] [nvarchar](50) NULL,
	[GioiTinh] [bit] NULL,
	[DiaChi] [nvarchar](max) NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tinh]    Script Date: 08/08/2024 07:52:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tinh](
	[MaTinh] [int] IDENTITY(1,1) NOT NULL,
	[TenTinh] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tinh] PRIMARY KEY CLUSTERED 
(
	[MaTinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (1, N'SP01', 2, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (2, N'SP02', 1, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (3, N'SP01', 1, CAST(1267500 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (3, N'SP03', 1, CAST(719250 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (3, N'SP06', 1, CAST(966750 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (3, N'SP07', 1, CAST(149000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (4, N'SP02', 1, CAST(5030100 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (4, N'SP07', 1, CAST(149000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (4, N'SP08', 1, CAST(198750 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (5, N'SP02', 1, CAST(5030100 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaSanPham], [SoLuong], [DonGia]) VALUES (5, N'SP03', 1, CAST(719250 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] ON 

INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc]) VALUES (1, N'Chăn ga gối')
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc]) VALUES (2, N'Chăn ga gối trẻ em')
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc]) VALUES (3, N'Đệm')
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc]) VALUES (4, N'Drap trải giường')
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[DonDatHang] ON 

INSERT [dbo].[DonDatHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [HinhThucThanhToan], [GhiChu], [TongSLHang], [TongThanhTien]) VALUES (1, 1, CAST(N'2023-08-01' AS Date), N'Trực tiếp', N'', NULL, NULL)
INSERT [dbo].[DonDatHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [HinhThucThanhToan], [GhiChu], [TongSLHang], [TongThanhTien]) VALUES (2, 2, CAST(N'2023-08-02' AS Date), N'Chuyển khoản', N'Yêu cầu gấp', NULL, NULL)
INSERT [dbo].[DonDatHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [HinhThucThanhToan], [GhiChu], [TongSLHang], [TongThanhTien]) VALUES (3, 3, CAST(N'2024-08-08' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[DonDatHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [HinhThucThanhToan], [GhiChu], [TongSLHang], [TongThanhTien]) VALUES (4, 3, CAST(N'2024-08-08' AS Date), NULL, NULL, 3, CAST(5377850 AS Decimal(18, 0)))
INSERT [dbo].[DonDatHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [HinhThucThanhToan], [GhiChu], [TongSLHang], [TongThanhTien]) VALUES (5, 3, CAST(N'2024-08-08' AS Date), NULL, NULL, 2, CAST(5749350 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[DonDatHang] OFF
GO
INSERT [dbo].[GiaoHang] ([MaSanPham], [MaTinh], [GiaGiao], [ThoiGianGiao]) VALUES (N'SP01', 1, CAST(50000 AS Decimal(18, 0)), N'3 ngày')
INSERT [dbo].[GiaoHang] ([MaSanPham], [MaTinh], [GiaGiao], [ThoiGianGiao]) VALUES (N'SP01', 2, CAST(70000 AS Decimal(18, 0)), N'5 ngày')
INSERT [dbo].[GiaoHang] ([MaSanPham], [MaTinh], [GiaGiao], [ThoiGianGiao]) VALUES (N'SP02', 1, CAST(30000 AS Decimal(18, 0)), N'2 ngày')
INSERT [dbo].[GiaoHang] ([MaSanPham], [MaTinh], [GiaGiao], [ThoiGianGiao]) VALUES (N'SP02', 2, CAST(50000 AS Decimal(18, 0)), N'4 ngày')
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [DienThoai], [MatKhau], [GioiTinh], [DiaChi]) VALUES (1, N'Nguyen Van A', N'0123456789', N'password', 1, N'Hà Nội')
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [DienThoai], [MatKhau], [GioiTinh], [DiaChi]) VALUES (2, N'Tran Thi B', N'0987654321', N'password', 0, N'TP HCM')
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [DienThoai], [MatKhau], [GioiTinh], [DiaChi]) VALUES (3, N'Trần Minh Luân', N'0934140224', N'123', 1, N'Tiền Giang')
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[Loai] ON 

INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (1, N'Bộ chăn ga', 1)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (2, N'Chăn và vỏ chăn', 1)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (3, N'Ga', 1)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (4, N'Vỏ Gối', 1)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (5, N'Bộ chăn ga Atermis', 1)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (6, N'Đệm cao su', 3)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (7, N'Đệm lò xo', 3)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (8, N'Đệm bông ép', 3)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (9, N'Gối ruột gối', 4)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (10, N'Ruột chăn', 4)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (11, N'Tấm trải-Topper', 4)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (12, N'Bộ chăn ga trẻ em', 2)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (13, N'Vỏ gối trẻ em', 2)
INSERT [dbo].[Loai] ([MaLoaiSP], [TenLoai], [MaDanhMuc]) VALUES (14, N'Chăn và vỏ chăn', 2)
SET IDENTITY_INSERT [dbo].[Loai] OFF
GO
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP01', N'Vivid Sky Blue - OLE003', CAST(1267500 AS Decimal(18, 0)), N'ghep-xanh-600x0.jpg', N'/Hinh/ghep-xanh-600x0.jpg', 1, N'ABC', N'Thiết kế tối giản giúp bạn thoải mái mix & match những tông màu khác nhau, tạo phong cách riêng cho phòng ngủ của bạn
- Phân loại gồm: 01 ga chun kích thước 160x200cm + 02 vỏ gối nằm kích thước 45x65cm

- Chất liệu vải: Tencel Rayon
- Hoạ tiết: Thêu', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP02', N'Âm Thanh Đồng Hoa - ESM24013', CAST(5030100 AS Decimal(18, 0)), N'set-ga-chun-chan-2-600x0.jpg', N'/Hinh/set-ga-chun-chan-2-600x0.jpg', 1, N'DEF', N'Cánh đồng hoa đang ngân nga khúc nhạc theo nắng và gió, toát lên cảm giác vui vẻ, vô tư và tràn ngập năng lượng trẻ trung, khơi gợi cảm giác tươi mới và lạc quan, như thể đón nhận cả thế thế giới với mùa xuân trong mỗi bước chân.
- Phân loại gồm: 01 ga chun chần kích thước tuỳ chọn + 02 vỏ gối nằm kích thước 45x65 + 01 chăn bốn mùa 200x220

- Chất liệu vải: Modal Cotton (MOC)
- Hoạ tiết: Trơn', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP03', N'The Moon - OL2313', CAST(719250 AS Decimal(18, 0)), N'ga-top-down-600x0.jpg', N'/Hinh/ga-top-down-600x0.jpg', 1, N'GHI', N'Bộ chăn ga chất liệu Modal mềm mại, mát lạnh khi chạm vào.
- Phân loại gồm: 01 ga chun kích thước 160x200cm

- Chất liệu vải: Modal Cotton (MOC)
- Hoạ tiết: Trơn', 3)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP04', N'Chăn Anemone - OL2308 ', CAST(846750 AS Decimal(18, 0)), N'chan-1-600x0.jpg', N'/Hinh/chan-1-600x0.jpg', 1, N'JKL', N'Lấy cảm hứng từ loài hoa Thu mẫu đơn xinh đẹp, bộ chăn ga với họa tiết những cánh hoa màu cam mềm mại trên nền trắng tinh khôi như đem cả sắc thu vào phòng ngủ của bạn. Hai mặt sản phẩm là màu trắng hoa.
- Phân loại gồm: 01 chăn bốn mùa kích thước 200x220cm', 2)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP05', N'Chăn hè Cotton Asa', CAST(840000 AS Decimal(18, 0)), N'0-1666161932-600x0.jpg', N'/Hinh/0-1666161932-600x0.jpg', 1, N'ABC', N'Chăn hè thiết kế đơn giản, màu sắc nhẹ nhàng, chất vải tự nhiên mềm mại, hạn chế kích ứng da
- Chất liệu vải: Cotton
- Hoạ tiết: Trơn', 2)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP06', N'Coral - OL2315', CAST(966750 AS Decimal(18, 0)), N'ga-600x0.jpg', N'/Hinh/ga-600x0.jpg', 1, N'DEF', N'Bộ chăn ga chất liệu Modal mềm mại, mát lạnh khi chạm vào.
- Phân loại gồm: 01 ga chun chần kích thước 180x200cm

- Chất liệu vải: Modal Cotton (MOC)
- Hoạ tiết: Trơn', 3)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP07', N'Vỏ gối ôm ESP005', CAST(149000 AS Decimal(18, 0)), N'goi-om-600x0.jpg', N'/Hinh/goi-om-600x0.jpg', 1, N'GHI', N'Bộ chăn ga thiết kế đơn giản, dễ sử dụng cho gia đình thường ngày
- Phân loại gồm: 01 vỏ gối ôm kích thước 60x80cm

- Chất liệu vải: Poly
- Hoạ tiết: Trơn', 4)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP08', N'Vỏ gối The Moon - OL2313', CAST(198750 AS Decimal(18, 0)), N'goi-top-down-600x0.jpg', N'/Hinh/goi-top-down-600x0.jpg', 1, N'JKL', N'Bộ chăn ga chất liệu Modal mềm mại, mát lạnh khi chạm vào.
- Vỏ gối The Moon - OL2313 gồm: 01 gối nằm kích thước 45x65

- Chất liệu vải: Modal Cotton (MOC)
- Hoạ tiết: Trơn', 4)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP09', N'White Blossom ASHM23106', CAST(21599000 AS Decimal(18, 0)), N'ashm-23106-1-600x0.jpg', N'/Hinh/ashm-23106-1-600x0.jpg', 1, N'ABC', N'Nhẹ nhàng mà vẫn không kém phần sang trọng, "White Blossom" là thiết kế dành cho những người yêu vẻ đẹp của những bông hoa trắng tinh khôi.
- Phân loại gồm: 01 ga chun chần kích thước tuỳ chọn + 02 vỏ gối nằm kích thước 45x65 + 01 chăn bốn mùa 200x220

- Chất liệu vải: Hanji Modal
- Hoạ tiết: Thêu', 5)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP10', N'Ottoman ASHM23102', CAST(19399000 AS Decimal(18, 0)), N'ashm-23102-600x0.jpg', N'/Hinh/ashm-23102-600x0.jpg', 1, N'DEF', N'Được lấy cảm hứng từ những họa tiết từ thời của đế quốc Ottoman (đất nước Thổ Nhỗ Kỳ ngày nay), thiết kế này chắc chắn sẽ đem lại sự ấn tượng và sang trọng cho không gian phòng ngủ.
- Phân loại gồm: 01 ga phủ kích thước tùy chọn + 02 vỏ gối 45x65 + 01 chăn bốn mùa 200x220

- Chất liệu vải: Hanji Modal
- Hoạ tiết: Thêu', 5)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP11', N'Đệm cao su Natural Charcoal Latex', CAST(9080000 AS Decimal(18, 0)), N'fill-the-background-600x0.jpg', N'/Hinh/fill-the-background-600x0.jpg', 1, N'GHI', N'Đệm cao su Everon 100% thiên nhiên than hoạt tính - Natural Charcoal Latex sử dụng nguyên liệu 100% cao su thiên nhiên, kết hợp với than hoạt tính. Nệm có độ đàn hồi tốt, nâng đỡ tối ưu vùng lưng cùng khả năng kháng khuẩn, chống nấm mốc. Vỏ nệm được chần bông với vải hạ nhiệt DURARON Cool nhập khẩu Hàn Quốc.
- Phân loại gồm: 01 nệm cao su thiên nhiên Everon kích thước tùy chọn', 6)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP12', N'Đệm lò xo Everon Pocket Premium', CAST(9620000 AS Decimal(18, 0)), N'group-3-600x0.jpg', N'/Hinh/group-3-600x0.jpg', 1, N'JKL', N'Pocket Premium là phiên bản đệm lò xo túi cao cấp mới nhất, vừa được ra mắt trong bộ sưu tập Đệm lò xo Everon. Với mong muốn đem tới trải nghiệm tốt nhất dành cho người dùng, các nguyên liệu làm nên chiếc đệm này chính là ưu điểm vượt trội được kết hợp hoàn hảo để tạo thành hệ thống trợ lực nâng đỡ êm ái, vận hành tốt trong quá trình sử dụng lâu dài. ***Với các tỉnh ngoài Hà Nội, phí giao hàng (nếu phát sinh) sẽ được thông báo đến khách hàng sau khi Everon nhận được đơn đặt hàng của quý khách.', 7)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP13', N'Đệm lò xo Everon Connecticut', CAST(10440000 AS Decimal(18, 0)), N'group-1-600x0.jpg', N'/Hinh/ghep-xanh-600x0.jpg', 1, N'ABC', N'Đệm lò xo Everon Connecticut sử dụng hệ thống lò xo liên kết tạo khung đệm vững chãi, kết hợp cùng lớp topper có thể tháo rời linh hoạt tạo cảm giác êm ái hơn khi nằm. Với các tỉnh ngoài Hà Nội, phí giao hàng (nếu phát sinh) sẽ được thông báo đến khách hàng sau khi Everon nhận được đơn đặt hàng của quý khách.', 7)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP14', N'Đệm bông ép Ceramic Vip', CAST(5199200 AS Decimal(18, 0)), N'group-2-600x0.jpg', N'/Hinh/group-2-600x0.jpg', 1, N'DEF', N'Vỏ đệm từ chất liệu Cotton được chần bông 6oz thấm hút cao, cải tiến hơn so với phiên bản cũ. ***Với các tỉnh ngoài Hà Nội, phí giao hàng (nếu phát sinh) sẽ được thông báo đến khách hàng sau khi Everon nhận được đơn đặt hàng của quý khách.', 8)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP15', N'Đệm chống trượt Everon', CAST(3528000 AS Decimal(18, 0)), N'group-6-1661755499-600x0.jpg', N'/Hinh/group-6-1661755499-600x0.jpg', 1, N'GHI', N'***Với các tỉnh ngoài Hà Nội, phí giao hàng (nếu phát sinh) sẽ được thông báo đến khách hàng sau khi Everon nhận được đơn đặt hàng của quý khách. Đệm chống trượt Everon là sản phẩm đệm bông ép siêu việt, mang tới cho khách hàng chất lượng giấc ngủ thượng hạng, cùng khả năng chống trượt tối ưu. - Thương hiệu Everon - Xuất xứ Việt Nam', 8)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP16', N'Gối cao su Latex Everon', CAST(699000 AS Decimal(18, 0)), N'group-2-copy-4-600x0.jpg', N'/Hinh/group-2-copy-4-600x0.jpg', 1, N'JKL', N'Gối Latex giúp định hình đốt sống cổ về đường cong tự nhiên
- Phân loại gồm: 01 gối Latex Contour kích thước 40x60cm', 9)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP17', N'Ruột gối Sorona Quallofil', CAST(512850 AS Decimal(18, 0)), N'goi-thang-600x0.jpg', N'/Hinh/goi-thang-600x0.jpg', 1, N'ABC', N'Ruột gối êm ái được làm từ sợi bông sinh học đạt kiểm định từ Hoa Kỳ.
- Chất liệu ruột gối/chăn: Bông Sorona sinh học', 9)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP18', N'Chăn 5S', CAST(899100 AS Decimal(18, 0)), N'chan-5s2-2-600x0.jpg', N'/Hinh/chan-5s2-2-600x0.jpg', 1, N'DEF', N'Ruột chăn 5S Everon là một trong những dòng sản phẩm được nhiều khách hàng lựa chọn vì hội tụ các tính năng ưu việt. Sản phẩm mang lại cảm giác thông thoáng, dễ chịu, cho người dùng những giấc ngủ ngon kể cả trong những ngày hè nóng bức.
- Phân loại gồm: 1 chăn kích thước 200x220

- Chất liệu ruột gối/chăn: Bông micro', 10)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP19', N'Ruột chăn Standard', CAST(657000 AS Decimal(18, 0)), N'ruot-chan-standard-anh-main-600x0.jpg', N'/Hinh/ruot-chan-standard-anh-main-600x0.jpg', 1, N'GHI', N'Ruột chăn Everon truyền thống có độ bền cực cao, có thể giặt được và khô nhanh.
- Chất liệu ruột gối/chăn: Bông ball', 10)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP20', N'Topper tăng tiện nghi', CAST(539000 AS Decimal(18, 0)), N'ghep-nen-2-600x0.jpg', N'/Hinh/ghep-nen-2-600x0.jpg', 1, N'JKL', N'Topper đệm tăng tiện nghi dùng để trải lên giường, giúp nằm êm hơn và thoải mái hơn.', 11)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP21', N'Topper AVIV', CAST(2080000 AS Decimal(18, 0)), N'ghep-600x0.jpg', N'/Hinh/ghep-600x0.jpg', 1, N'ABC', N'Tấm topper tăng tiện nghi Everon AVIV là sản phẩm có dạng đệm chất liệu Memory Foam siêu đàn hồi với nhiều tính năng mới được cải tiến và có mức giá phù hợp với đại đa số gia đình Việt.', 11)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP22', N'Space Hero - EPM23063', CAST(1954150 AS Decimal(18, 0)), N'chan-4-mua-600x0.jpg', N'/Hinh/chan-4-mua-600x0.jpg', 1, N'DEF', N'Cùng bước vào một cuộc phiêu lưu kỳ thú & khám phá vũ trụ, Space Hero nhé! Rất nhiều điều bí ẩn cực kì thú vị đang chờ bé giải đáp đấy.
- Phân loại gồm: 01 ga chun kích thước tùy chọn + 02 vỏ gối nằm kích thước 45x65

- Chất liệu vải: Modal Cotton (MOC)
- Hoạ tiết: In', 12)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP23', N'Bestie - EPM23068', CAST(1784150 AS Decimal(18, 0)), N'bo-ga-phu-600x0.jpg', N'/Hinh/bo-ga-phu-600x0.jpg', 1, N'GHI', N'Vẻ đẹp thanh nhã, hồn nhiên của hoa ban trắng sẽ khiến không gian phòng ngủ của bạn rực sáng và bừng lên một sức sống tràn đầy.
- Phân loại gồm: 01 ga chun kích thước tùy chọn + 02 vỏ gối nằm kích thước 45x65

- Chất liệu vải: Modal
- Hoạ tiết: In', 12)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP24', N'Vỏ gối Bữa Sáng Vui Vẻ - EPM24066', CAST(269100 AS Decimal(18, 0)), N'goi-600x0.jpg', N'/Hinh/goi-600x0.jpg', 1, N'JKL', N'Thức dậy cùng vô vàn đồ ăn nhắc nhở bé không được để chiếc bụng đói đến trường nhé. Họa tiết vui nhộn và màu sắc sặc sỡ khuyến khích khả năng sáng tạo, phát huy trí tưởng tượng vô biên của bé.
- Phân loại gồm: 01 vỏ gối nằm kích thước tùy chọn

- Chất liệu vải: Modal Cotton (MOC)
- Hoạ tiết: In', 13)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP25', N'Vỏ gối - EPM22073', CAST(152000 AS Decimal(18, 0)), N'9-1630914051-600x0.jpg', N'/Hinh/9-1630914051-600x0.jpg', 1, N'ABC', N'Hoạ tiết dễ thương được dệt trên nền vải xanh dương tươi sáng, đưa bé vào thế giới tưởng tượng sống động.
- Phân loại gồm: 01 vỏ gối tựa kích thước 45x45

- Chất liệu vải: Modal
- Hoạ tiết: In', 13)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP26', N'Chăn hè trẻ em', CAST(589000 AS Decimal(18, 0)), N'chan-gap-5-1684492676-600x0.jpg', N'/Hinh/chan-gap-5-1684492676-600x0.jpg', 1, N'DEF', N'Chăn hè trẻ em với hoạ tiết ngộ nghĩnh, chất liệu mềm mại, an toàn với trẻ nhỏ.
- Phân loại gồm: 01 chăn hè kích thước/màu sắc theo lựa chọn

- Chất liệu vải: Cotton
- Hoạ tiết: In', 14)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP27', N'Chăn Happy Town - EPC23048', CAST(2209150 AS Decimal(18, 0)), N'chan-4-mua-1-600x0.jpg', N'/Hinh/chan-4-mua-1-600x0.jpg', 1, N'JKL', N'Everon luôn tin bé sẽ là thị trưởng giỏi nhất thế giới!
- Phân loại gồm: 01 chăn bốn mùa kích thước 200x220

- Chất liệu vải: Cotton
- Hoạ tiết: In', 14)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP28', N'CHĂn', CAST(10000 AS Decimal(18, 0)), N'ko co', N'ko co', 1, N'ABC', N'test', 2)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [DonGia], [HinhDaiDien], [DSHinh], [MienPhiGiaoHang], [NhaSanXuat], [MoTa], [MaLoaiSP]) VALUES (N'SP29', N'CHĂn', CAST(100000 AS Decimal(18, 0)), N'ko co', N'ko co', 0, N'ABC', N'test', 2)
GO
SET IDENTITY_INSERT [dbo].[Tinh] ON 

INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (1, N'Hà Nội')
INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (2, N'TP HCM')
INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (3, N'Tiền Giang')
INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (4, N'Bà Rịa Vũng Tàu')
INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (5, N'An Giang')
INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (6, N'Long An')
INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (7, N'Trà VInh')
INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (8, N'Đà Nẵng')
INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (9, N'Huế')
INSERT [dbo].[Tinh] ([MaTinh], [TenTinh]) VALUES (10, N'Đà Lạt')
SET IDENTITY_INSERT [dbo].[Tinh] OFF
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonHang_DonDatHang] FOREIGN KEY([MaDonHang])
REFERENCES [dbo].[DonDatHang] ([MaDonHang])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_ChiTietDonHang_DonDatHang]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonHang_SanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_ChiTietDonHang_SanPham]
GO
ALTER TABLE [dbo].[DonDatHang]  WITH CHECK ADD  CONSTRAINT [FK_DonDatHang_KhachHang] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
GO
ALTER TABLE [dbo].[DonDatHang] CHECK CONSTRAINT [FK_DonDatHang_KhachHang]
GO
ALTER TABLE [dbo].[GiaoHang]  WITH CHECK ADD  CONSTRAINT [FK_GiaoHang_SanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[GiaoHang] CHECK CONSTRAINT [FK_GiaoHang_SanPham]
GO
ALTER TABLE [dbo].[GiaoHang]  WITH CHECK ADD  CONSTRAINT [FK_GiaoHang_Tinh] FOREIGN KEY([MaTinh])
REFERENCES [dbo].[Tinh] ([MaTinh])
GO
ALTER TABLE [dbo].[GiaoHang] CHECK CONSTRAINT [FK_GiaoHang_Tinh]
GO
ALTER TABLE [dbo].[Loai]  WITH CHECK ADD  CONSTRAINT [FK_Loai_DanhMucSanPham] FOREIGN KEY([MaDanhMuc])
REFERENCES [dbo].[DanhMucSanPham] ([MaDanhMuc])
GO
ALTER TABLE [dbo].[Loai] CHECK CONSTRAINT [FK_Loai_DanhMucSanPham]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_Loai] FOREIGN KEY([MaLoaiSP])
REFERENCES [dbo].[Loai] ([MaLoaiSP])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_Loai]
GO
USE [master]
GO
ALTER DATABASE [QLChanGaGoiNem] SET  READ_WRITE 
GO
