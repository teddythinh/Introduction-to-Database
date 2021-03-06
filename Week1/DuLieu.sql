USE [QLBanHang]
GO
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'KH001     ', N'Phạm Thịnh', N'Nam', N'012345       ', N'227 Nguyễn Văn Cừ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'KH002     ', N'Lê Thứ', N'Nu ', N'023456       ', N'228 Nguyễn Hữu Thọ ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'KH003     ', N'Nguyễn Tú', N'Nam', N'054321       ', N'229 Cách Mạng Tháng Tám')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'KH004     ', N'Trần My', N'Nu ', N'098765       ', N'230 Nguyễn Thị Minh Khai')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'KH005     ', N'Nguyễn Huy', N'Nam', N'087654       ', N'231 Lê Lợi')
GO
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'HD001     ', CAST(N'2022-01-02' AS Date), N'KH001     ')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'HD002     ', CAST(N'2022-01-03' AS Date), N'KH002     ')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'HD003     ', CAST(N'2022-01-04' AS Date), N'KH003     ')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'HD004     ', CAST(N'2022-01-05' AS Date), N'KH004     ')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'HD005     ', CAST(N'2022-01-06' AS Date), N'KH005     ')
GO
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'IP08      ', N'Iphone 8                      ', CAST(N'2017-01-01' AS Date), 10000000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'IP10      ', N'Iphone 10                     ', CAST(N'2018-01-01' AS Date), 15000000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'IP11      ', N'Iphone 11                     ', CAST(N'2019-01-01' AS Date), 20000000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'IP12      ', N'Iphone 12                     ', CAST(N'2020-01-01' AS Date), 25000000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'IP13      ', N'Iphone 13                     ', CAST(N'2021-01-01' AS Date), 30000000)
GO
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'HD001     ', N'IP13      ', 1, 30000000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'HD002     ', N'IP12      ', 2, 25000000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'HD003     ', N'IP11      ', 3, 20000000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'HD004     ', N'IP10      ', 4, 15000000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'HD005     ', N'IP08      ', 5, 10000000)
GO
