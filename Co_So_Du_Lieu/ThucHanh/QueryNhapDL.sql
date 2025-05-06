use QuanLyBanHang
go

insert into [dbo].[KhachHang](MaKH, TenKH,DIACHI,dt,EMAIL)
select * from tam.[dbo].[KhachHang$]

insert into VatTu(MAVT,TENVT,DVT,GIAMUA,SLTON)
select * from tam.[dbo].[VATTU$]

insert into HoaDon
select * from tam.[dbo].[HoaDon$]

insert into CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN)
select * from tam.[dbo].[CTHD$]


-- 1
SELECT MAKH, TENKH, DIACHI, EMAIL FROM KhachHang
WHERE DIACHI='Tân Bình'

-- 2
SELECT * FROM KhachHang
WHERE DT = NULL;
--