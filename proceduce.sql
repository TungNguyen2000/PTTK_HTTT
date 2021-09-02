use master
go
create database QLHocPhan
go
use QLHocPhan
go
-------------------------create database---------------------
create table GiangVien
(
	MaGiangVien  nvarchar(8) NOT NULL,
	HoTenGV nvarchar(50) NOT NULL,
	DiaChi nvarchar(50) NOT NULL,
	SDT char(10) NOT NULL UNIQUE,
	primary key(MaGiangVien)
)
go
create table SinhVien
(
	MSSV nvarchar(8) NOT NULL,
	HoTenHS nvarchar(50) NOT NULL,
	DiaChi nvarchar(50) NOT NULL,
	SDT char(10) NOT NULL UNIQUE,
	Khoa nvarchar(50) NOT NULL,
	TinhTrang nvarchar(20) NOT NULL,
	primary key(MSSV)
)
-----Chuyen De---------------
create table DSLopChuyenDe
(
	MaDS nvarchar(10) NOT NULL,
	HocKy int NOT NULL,
	Nam char(5) NOT NULL,
	TenDSLopChuyenDe nvarchar(50)NOT NULL,
	NgayDang date,
	primary key(MaDS)
)
create table DSLopNhomChuyenDe
(
	MaDSNhom nvarchar(10) NOT NULL,
	HocKy int NOT NULL,
	Nam char(5) NOT NULL,
	TenDSNhom nvarchar(50) NOT NULL,
	NgayDang Date,
	primary key(MaDSNhom)
)
create table NhomChuyenDe
(
	MaNhomCD nvarchar(10) NOT NULL,
	TenNhomCD nvarchar(50)NOT NULL,
	MaDSNhom nvarchar(10)NOT NULL,
	primary key(MaNhomCD)
)
ALTER TABLE NhomChuyenDe ADD CONSTRAINT fk_NCD_DSLNCD FOREIGN KEY (MaDSNhom) REFERENCES DSLopNhomChuyenDe (MaDSNhom)

create table LopChuyenDe
(
	MaLopCD nvarchar(10) NOT NULL,
	TenLop nvarchar(50) NOT NULL,
	SiSo int NOT NULL,
	SiSoMax int NOT NULL,
	MaDS nvarchar(10)NOT NULL,
	MaNhomCD nvarchar(10)NOT NULL,
	MaGiangVien nvarchar(8)NOT NULL,
	primary key(MaLopCD)
)

ALTER TABLE LopChuyenDe ADD CONSTRAINT fk_LCD_DSLNCD FOREIGN KEY (MaDS) REFERENCES DSLopChuyenDe (MaDS)
ALTER TABLE LopChuyenDe ADD CONSTRAINT fk_LCD_NCD FOREIGN KEY (MaNhomCD) REFERENCES NhomChuyenDe (MaNhomCD)
ALTER TABLE  LopChuyenDe ADD CONSTRAINT fk_LCD_GV FOREIGN KEY (MaGiangVien) REFERENCES GiangVien(MaGiangVien)

create table PhieuDangKyCD
(
	MaPhieuDKCD nvarchar(10) NOT NULL,
	HocKy int NOT NULL,
	NamHoc char(5) NOT NULL,
	NgayDangKy date NOT NULL,
	TinhTrang nvarchar(50) NOT NULL,
	MSSV nvarchar(8)NOT NULL,
	MaNhomCD nvarchar(10)NOT NULL,
	primary key(MaPhieuDKCD)

)
ALTER TABLE PhieuDangKyCD ADD CONSTRAINT fk_PDKCD_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)
ALTER TABLE PhieuDangKyCD ADD CONSTRAINT fk_PDKCD_NCD FOREIGN KEY (MaNhomCD) REFERENCES NhomChuyenDe(MaNhomCD)

----Hoc Phan--------------
create table DanhSachLopHocPhan
(
	MaDSLop nvarchar(10)NOT NULL,
	HocKy int NOT NULL,
	Nam char(5) NOT NULL,
	TenDSLop nvarchar(50)NOT NULL,
	NgayDang date,
	primary key(MaDSLop)
)
create table DanhSachHocPhan
(
	MaDS nvarchar(10)NOT NULL,
	HocKy int NOT NULL,
	Nam char(5) NOT NULL,
	TenDanhSach nvarchar(50)NOT NULL,
	NgayDang date,
	primary key(MaDs)
)
go
create table HocPhan
(
	MaHocPhan nvarchar(10)NOT NULL,
	TenHocPhan nvarchar(50)NOT NULL,
	MaDS nvarchar(10)NOT NULL,
	primary key(MaHocPhan)
)
go
ALTER TABLE HocPhan ADD CONSTRAINT fk_HP_DSHP FOREIGN KEY (MaDS) REFERENCES DanhSachHocPhan(MaDS)

go
create table PhieuDangKyHocPhan
(
	MaPhieuDKHP nvarchar(10)NOT NULL,
	MSSV nvarchar(8)NOT NULL,
	HocKy int NOT NULL,
	NamHoc char(5) NOT NULL,
	NgayDK date NOT NULL,
	TinhTrang nvarchar(50)NOT NULL,
	MaHocPhan nvarchar(10)NOT NULL,
	primary key(MaPhieuDKHP)
)
go
ALTER TABLE PhieuDangKyHocPhan ADD CONSTRAINT fk_PDKHP_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)
ALTER TABLE PhieuDangKyHocPhan ADD CONSTRAINT fk_PDKHP_HP FOREIGN KEY (MaHocPhan) REFERENCES HocPhan(MaHocPhan)

go
create table LopHocPhan
(
	MaLopHP nvarchar(10)NOT NULL,
	TenLopHP nvarchar(50)NOT NULL,
	SiSo int NOT NULL,
	SiSoToiDa int NOT NULL,
	MaGiangVien nvarchar(8)NOT NULL,
	MaHocPhan nvarchar(10)NOT NULL,
	MaDSLop nvarchar(10)NOT NULL,
	primary key(MaLopHP)
)
go
ALTER TABLE LopHocPhan ADD CONSTRAINT fk_LHP_GV FOREIGN KEY (MaGiangVien) REFERENCES GiangVien(MaGiangVien)
ALTER TABLE LopHocPhan ADD CONSTRAINT fk_LHP_hp FOREIGN KEY (MaHocPhan) REFERENCES HocPhan(MaHocPhan)
ALTER TABLE LopHocPhan ADD CONSTRAINT fk_LHP_DSLHP FOREIGN KEY (MaDSLop) REFERENCES DanhSachLopHocPhan(MaDSLop)

go
create table PhieuDKLopHP
(
	MaPhieuDKLopHP nvarchar(10)NOT NULL,
	MSSV nvarchar(8)NOT NULL,
	HocKy int NOT NULL,
	NamHoc char(5) NOT NULL,
	NgayDK date NOT NULL,
	TinhTrang nvarchar(20)NOT NULL,
	MaLopHP nvarchar(10)NOT NULL,
	primary key(MaPhieuDKLopHP)
)
go
ALTER TABLE PhieuDKLopHP ADD CONSTRAINT fk_PDKLHP_LHP FOREIGN KEY (MaLopHP) REFERENCES LopHocPhan(MaLopHP)
ALTER TABLE PhieuDKLopHP ADD CONSTRAINT fk_PDKLHP_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)

go
----Chuong Trinh Dao Tao-------------
create table DSChuongTrinhDaoTao
(
	MaDSCT nvarchar(10)NOT NULL,
	HocKy int NOT NULL,
	NamHoc char(5) NOT NULL,
	TenDSCT nvarchar(50)NOT NULL,
	NgayDang date,
	primary key(MaDSCT)
)
go
create table ChuongTrinhDaoTao
(
	MaCTDT nvarchar(10)NOT NULL,
	TenCTDT nvarchar(50)NOT NULL,
	MaDSCT nvarchar(10)NOT NULL,
	primary key(MaCTDT)
)
go
ALTER TABLE ChuongTrinhDaoTao ADD CONSTRAINT fk_CTDT_DSCTDT FOREIGN KEY (MaDSCT) REFERENCES DSChuongTrinhDaoTao(MaDSCT)

go
create table PhieuDangKyCTDT
(
	MaPhieuDKCT nvarchar(10)NOT NULL,
	MSSV nvarchar(8)NOT NULL,
	MaCTDT nvarchar(10)NOT NULL,
	HocKy int NOT NULL,
	NamHoc char(5) NOT NULL,
	NgayDangKy date NOT NULL,
	TinhTrang nvarchar(50)NOT NULL,
	primary key(MaPhieuDKCT)
)
go
ALTER TABLE PhieuDangKyCTDT ADD CONSTRAINT fk_PDKCTDT_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)
ALTER TABLE PhieuDangKyCTDT ADD CONSTRAINT fk_PDKCTDT_CTDT FOREIGN KEY (MaCTDT) REFERENCES ChuongTrinhDaoTao(MaCTDT)

go
-------Chung Chi-------------
create table LoaiChungChi
(
	MaLoaiCC nvarchar(10) NOT NULL,
	TenLoai nvarchar(30) NOT NULL,
	primary key(MaLoaiCC)
)
go
create table DanhSachHocPhanChungChi
(
	MaDS nvarchar(10)NOT NULL,
	HocKy int NOT NULL,
	Nam char(5)  NOT NULL,
	MaLoaiCC nvarchar(10) NOT NULL ,
	TenDS nvarchar(50)NOT NULL,
	NgayDang date,
	primary key(MaDS)
)
go
ALTER TABLE DanhSachHocPhanChungChi ADD CONSTRAINT fk_DSHPCC_LCC FOREIGN KEY (MaLoaiCC) REFERENCES LoaiChungChi(MaLoaiCC)

go
create table HocPhanChungChi
(
	MaHocPhanCC nvarchar(10)NOT NULL,
	TenHocPhanCC nvarchar(50)NOT NULL,
	MaDS nvarchar(10)NOT NULL,
	primary key(MaHocPhanCC)
)
go
ALTER TABLE HocPhanChungChi ADD CONSTRAINT fk_HPCC_DSHPCC FOREIGN KEY (MaDS) REFERENCES DanhSachHocPhanChungChi(MaDS)

go
create table PhieuDangKyHPChungChi
(
	MaPhieuDK nvarchar(10)NOT NULL,
	MSSV nvarchar(8)NOT NULL,
	MaHocPhanCC nvarchar(10)NOT NULL,
	MaLoaiCC nvarchar(10) NOT NULL ,
	HocKy int NOT NULL,
	Nam char(5) NOT NULL,
	NgayDK date NOT NULL,
	TinhTrang nvarchar(20)NOT NULL,
	primary key(MaPhieuDK)
)
go
ALTER TABLE PhieuDangKyHPChungChi ADD CONSTRAINT fk_PDKHPCC_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)
ALTER TABLE PhieuDangKyHPChungChi ADD CONSTRAINT fk_PDKHPCC_HPCC FOREIGN KEY (MaHocPhanCC) REFERENCES HocPhanChungChi(MaHocPhanCC)
ALTER TABLE PhieuDangKyHPChungChi ADD CONSTRAINT fk_PDKHPCC_LCC FOREIGN KEY (MaLoaiCC) REFERENCES LoaiChungChi(MaLoaiCC)

go
create table DanhSachLopChungChi
(
	MaDSLopChungChi nvarchar(10)NOT NULL,
	HocKy int NOT NULL,
	Nam char(5)  NOT NULL,
	MaLoaiCC nvarchar(10) NOT NULL, 
	TenDSLopChungChi nvarchar(50)NOT NULL,
	NgayDang date,
	primary key(MaDSLopChungChi)
)
go
ALTER TABLE DanhSachLopChungChi ADD CONSTRAINT fk_DSLCC_LCC FOREIGN KEY (MaLoaiCC) REFERENCES LoaiChungChi(MaLoaiCC)
go
create table LopChungChi
(
	MaLopChungChi nvarchar(10)NOT NULL UNIQUE,
	MaDSLopChungChi nvarchar(10)NOT NULL,
	MaGiangVien nvarchar(8)NOT NULL,
	MaHocPhanCC nvarchar(10)NOT NULL,
	TenLopChungChi nvarchar(50)NOT NULL,
	SiSo int NOT NULL,
	SiSoToiDa int NOT NULL,
	primary key(MaLopChungChi)
)
go
ALTER TABLE LopChungChi ADD CONSTRAINT fk_LCC_GV FOREIGN KEY (MaGiangVien) REFERENCES GiangVien(MaGiangVien)
ALTER TABLE LopChungChi ADD CONSTRAINT fk_LCC_DSLCC FOREIGN KEY (MaDSLopChungChi) REFERENCES DanhSachLopChungChi(MaDSLopChungChi)
ALTER TABLE LopChungChi ADD CONSTRAINT fk_LCC_HPCC FOREIGN KEY (MaHocPhanCC) REFERENCES HocPhanChungChi(MaHocPhanCC)


go

create table HocPhi(
	MaHocPhi nvarchar(10) NOT NULL,
	MSSV nvarchar(8) NOT NULL,
	MaLopChungChi nvarchar(10)NOT NULL,
	MaLopCD nvarchar(10) NOT NULL,
	MaLopHP nvarchar(10)NOT NULL,
	GiaTien money NOT NULL,
	TinhTrang nvarchar(20) NOT NULL,
	NgayPhatHanh date NOT NULL,
	primary key(MaHocPhi)
)
go
ALTER TABLE HocPhi ADD CONSTRAINT fk_HocPhi_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)
ALTER TABLE HocPhi ADD CONSTRAINT fk_HocPhi_LCC FOREIGN KEY (MaLopChungChi) REFERENCES LopChungChi(MaLopChungChi)
ALTER TABLE HocPhi ADD CONSTRAINT fk_HocPhi_LCD FOREIGN KEY (MaLopCD) REFERENCES LopChuyenDe(MaLopCD)
ALTER TABLE HocPhi ADD CONSTRAINT fk_HocPhi_LHP FOREIGN KEY (MaLopHP) REFERENCES LopHocPhan(MaLopHP)

go
create table HoaDonHocPhi(
	MaHoaDon nvarchar(10) NOT NULL,
	TinhTrang nvarchar(20),
	HocKy int,
	Nam char(5),
	TongTien money NOT NULL,
	primary key(MaHoaDon)
)
go
create table ChiTietHoaDon(
	MaHoaDon nvarchar(10) not null,
	MaHocPhi nvarchar(10) not null,
	GiaTien money not null,
	primary key(MaHoaDon, MaHocPhi)
)
go
alter table ChiTietHoaDon add constraint fk_ChiTietHoaDon_HoaDonHocPhi foreign key(MaHoaDon) references HoaDonHocPhi(MaHoaDon)
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT fk_ChiTietHoaDon_HocPhi FOREIGN KEY (MaHocPhi) REFERENCES HocPhi(MaHocPhi)

go
create table BangDiem_HocPhan
(
	MaBangDiem nvarchar(10)NOT NULL,
	MSSV nvarchar(8)NOT NULL,
	TenHocPhan nvarchar(50)NOT NULL,
	HocKy int NOT NULL,
	NamHoc char(5) NOT NULL,
	MaLopHP nvarchar(10)NOT NULL,
	Diem float,
	NgayDang date,
	primary key(MaBangDiem)
)
go
create table BangDiem_ChuyenDe
(
	MaBangDiem nvarchar(10)NOT NULL,
	MSSV nvarchar(8)NOT NULL,
	TenHocPhan nvarchar(50)NOT NULL,
	HocKy int NOT NULL,
	NamHoc char(5) NOT NULL,
	MaLopCD nvarchar(10) NOT NULL,
	Diem float,
	NgayDang date,
	primary key(MaBangDiem)
)
go
create table BangDiem_ChungChi
(
	MaBangDiem nvarchar(10)NOT NULL,
	MSSV nvarchar(8)NOT NULL,
	TenHocPhan nvarchar(50)NOT NULL,
	HocKy int NOT NULL,
	NamHoc char(5) NOT NULL,
	MaLopChungChi nvarchar(10)NOT NULL,
	MaLoaiCC nvarchar(10) NOT NULL,
	Diem float,
	NgayDang date,
	primary key(MaBangDiem)
)
go
ALTER TABLE BangDiem_HocPhan ADD CONSTRAINT fk_BDHP_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)
ALTER TABLE BangDiem_HocPhan ADD CONSTRAINT fk_BDHP_LHP FOREIGN KEY (MaLopHP) REFERENCES LopHocPhan(MaLopHP)
-----------
ALTER TABLE BangDiem_ChuyenDe ADD CONSTRAINT fk_BDCD_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)
ALTER TABLE BangDiem_ChuyenDe ADD CONSTRAINT fk_BDCD_LCD FOREIGN KEY (MaLopCD) REFERENCES LopChuyenDe(MaLopCD)
----------
ALTER TABLE BangDiem_ChungChi ADD CONSTRAINT fk_BDCC_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)
ALTER TABLE BangDiem_ChungChi ADD CONSTRAINT fk_BDCC_LCC FOREIGN KEY (MaLopChungChi) REFERENCES LopChungChi(MaLopChungChi)
ALTER TABLE BangDiem_ChungChi ADD CONSTRAINT fk_BDCC_LOAICC FOREIGN KEY (MaLoaiCC) REFERENCES LoaiChungChi(MaLoaiCC)


go
create table PhieuDangKyTotNghiep
(
	MaPhieuDKTG nvarchar(10) NOT NULL,
	MSSV nvarchar(8) NOT NULL,
	HocKy int NOT NULL,
	NamHoc char(5) NOT NULL,
	NgayDK int NOT NULL,
	TinhTrang nvarchar(50) NOT NULL,
	primary key(MaPhieuDKTG)
)
go
ALTER TABLE PhieuDangKyTotNghiep ADD CONSTRAINT fk_PDKTG_SV FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV)
go
----------------------Tung Nguyen
use QLHocPhan
go
--TRIGGER FOR INSERT ON HOCPHI
CREATE OR ALTER TRIGGER SUM_HOCPHI_INSERT on HOCPHI
after insert
as
update hdhp SET hdhp.TongTien = hdhp.TongTien + (select sum(i.GiaTien) from inserted i,ChiTietHoaDon cthd where i.MaHocPhi = cthd.MaHocPhi and cthd.MaHoaDon = hdhp.MaHoaDon)
from HoaDonHocPhi hdhp
go
--TRIGGER FOR DELETE ON HOCPHI
CREATE OR ALTER TRIGGER SUM_HOCPHI_DELETE on HOCPHI
after DELETE
as
update hdhp SET hdhp.TONGTIEN = hdhp.TONGTIEN - (select sum(d.GiaTien) from DELETED d, ChiTietHoaDon cthd where d.MaHocPhi = cthd.MAHOCPHI and cthd.MaHoaDon = hdhp.MaHoaDon)
from HOADONHOCPHI hdhp
go
--TRIGGER FOR UPDATE ON HOCPHI
CREATE OR ALTER TRIGGER SUM_HOCPHI_UPDATE on HOCPHI
after UPDATE
as
update hdhp SET hdhp.TONGTIEN =(select hp.GiaTien from HocPhi hp, ChiTietHoaDon cthd where hp.MaHocPhi = cthd.MaHocPhi and cthd.MaHoaDon = hdhp.MaHoaDon)
from HOADONHOCPHI hdhp
go
--hien thi hoa don cua hoc vien
CREATE OR ALTER PROC XEM_HP(@MSSV NVARCHAR(8) = NULL, @HK INT = NULL, @YEAR INT = NULL)
AS
BEGIN
SELECT SV.MSSV, SV.HOTENHS, SV.KHOA, HDHP.TINHTRANG, HP.TINHTRANG, HP.MaLopCD, HP.MaLopChungChi, HP.MaLopHP, HP.NgayPhatHanh, HP.GiaTien, HDHP.TinhTrang AS TINH_TRANG_HOA_DON, HDHP.TongTien  
FROM SINHVIEN SV, HOADONHOCPHI HDHP, HOCPHI HP, ChiTietHoaDon cthd WHERE HP.MaHocPhi = cthd.MaHocPhi AND cthd.MaHoaDon = hdhp.MaHoaDon AND HP.MSSV = SV.MSSV AND 
(SV.MSSV = @MSSV OR @MSSV = NULL) AND (HDHP.HocKy = @HK OR @HK = NULL) AND (HDHP.Nam = @YEAR OR @YEAR = NULL);
END;
GO
CREATE OR ALTER PROC UPDATE_HOC_PHI(@MALOPCC NVARCHAR(10)= NULL, @MALOPCD NVARCHAR(10) =NULL, @MALOPHP NVARCHAR(10) =NULL, @TT NVARCHAR(10) =NULL, @NEW_PRICE MONEY =NULL)
AS
BEGIN
IF @NEW_PRICE IS NOT NULL
BEGIN
	UPDATE HOCPHI SET GIATIEN = @NEW_PRICE WHERE ((@MALOPCC = MALOPCHUNGCHI OR @MALOPCC IS NULL) AND (@MALOPCD = MALOPCD OR @MALOPCD IS NULL) AND (@MALOPHP = MALOPHP OR @MALOPHP IS NULL))
END

IF @TT IS NOT NULL
BEGIN
	UPDATE HOCPHI SET TINHTRANG = @TT WHERE ((@MALOPCC = MALOPCHUNGCHI OR @MALOPCC IS NULL) AND (@MALOPCD = MALOPCD OR @MALOPCD IS NULL) AND (@MALOPHP = MALOPHP OR @MALOPHP IS NULL))
END
END;
GO

CREATE OR ALTER TRIGGER UPDATE_TT_HDHP ON HOCPHI AFTER INSERT, DELETE, UPDATE
AS 
DECLARE @TT int = 0;
SELECT @TT = COUNT(*) FROM HOCPHI HP WHERE (CHARINDEX('CHƯA', UPPER(TINHTRANG)) > 0 OR CHARINDEX('CHUA', UPPER(TINHTRANG)) > 0) AND HP.MaHocPhi  = (SELECT MaHocPhi FROM INSERTED)
if (@TT > 0)
	UPDATE hdhp SET TINHTRANG = 'ĐÃ TRẢ' 
	from HoaDonHocPhi hdhp, ChiTietHoaDon cthd WHERE cthd.MAHOCPHI = (SELECT MAHOCPHI FROM INSERTED) and hdhp.MaHoaDon = cthd.MaHoaDon
GO

use QLHocPhan
GO
--đóng học phí cho duy nhất một lớp của hoc sinh voi MSSV
CREATE or alter proc DONG_HOC_PHI(@MSSV nvarchar(8), @money money, @year int, @HK int, @MACC NVARCHAR(10) = NULL, @MACD NVARCHAR(10) = NULL, @MAHP NVARCHAR(10) = NULL)
as
begin
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
	begin transaction T1
	declare @mucHP money = 0, @TinhTrangHienCo nvarchar(20);
	select @mucHP = HP.GiaTien, @TinhTrangHienCo = HP.TinhTrang FROM HocPhi HP, HoaDonHocPhi HDHP, ChiTietHoaDon cthd where 
	@MSSV = MSSV AND HP.MaHocPhi = cthd.MaHocPhi AND cthd.MaHoaDon = hdhp.MaHoaDon AND HDHP.HocKy = @HK AND (@MACD = HP.MaLopCD OR @MACC = HP.MaLopChungChi OR 
	@MAHP = HP.MaLopHP) AND HDHP.Nam = @year;
	if CHARINDEX (N'ĐÃ', UPPER(@TinhTrangHienCo)) > 0 or CHARINDEX (N'ĐA', UPPER(@TinhTrangHienCo)) > 0
	begin
		return N'học sinh đã thanh toán tiền từ trước'
	end
	if @mucHP > @money 
	begin
		return N'Số tiền không đủ trả'
	end
	update HocPhi SET HocPhi.TinhTrang = N'ĐÃ TRẢ' where MSSV = @MSSV and MaLopChungChi = @MACC and MaLopCD=@MACD and MaLopHP = @MAHP and (MaHocPhi in
	(select cthd.MaHocPhi from HoaDonHocPhi hdhp, ChiTietHoaDon cthd where hdhp.HocKy=@HK and hdhp.Nam=@year and cthd.MaHoaDon = hdhp.MaHoaDon))
	commit
return Abs(@mucHP - @money);
end;
go
--đóng học phí tất cả các môn ở Học kỳ, năm cho học sinh có MSSV
CREATE or alter PROCEDURE DONG_HOC_PHI_ALL(@MSSV NVARCHAR(8), @HK INT, @YEAR INT, @MONEY MONEY)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
	begin transaction T2
	DECLARE @MUC_HP MONEY=0, @TT_DaTra int
	if ((select count(1) from HocPhi hp, HoaDonHocPhi hdhp, ChiTietHoaDOn cthd 
	where hdhp.HocKy = @HK and hdhp.Nam = @YEAR and hp.MaHocPhi = cthd.MaHocPhi and cthd.MaHoaDon= hdhp.MaHoaDon and hp.MSSV = @MSSV and
	(CHARINDEX(N'CHƯA',UPPER(hp.TinhTrang)) > 0 or CHARINDEX(N'CHUA',UPPER(hp.TinhTrang)) > 0)) <= 0)
	begin
		return
	end

	SELECT @MUC_HP = SUM(hp.GiaTien) FROM HocPhi hp, HoaDonHocPhi hdhp, ChiTietHoaDOn cthd 
	where hdhp.HocKy = @HK and hdhp.Nam = @YEAR and hp.MaHocPhi = cthd.MaHocPhi and cthd.MaHoaDon= hdhp.MaHoaDon and hp.MSSV = @MSSV and
	(CHARINDEX(N'CHƯA',UPPER(hp.TinhTrang)) > 0 or CHARINDEX(N'CHUA',UPPER(hp.TinhTrang)) > 0)
	if @MUC_HP > @MONEY
	begin
		return 0
	end
	UPDATE HocPhi SET HocPhi.TinhTrang = N'ĐÃ TRẢ' where @MSSV = MSSV and (MaHocPhi in (select MaHocPhi from HoaDonHocPhi where @HK = HocKy and Nam=@YEAR))
	commit;
	return ABS(@MONEY - @MUC_HP)
	
END;
----------------------Linh
--XEM CHI TIET CHUNG CHI
go
CREATE or alter VIEW chitietchungchi AS
SELECT TenDSLopChungChi,HocKy,Nam,LopChungChi.MaHocPhanCC,TenHocPhanCC,TenLopChungChi,SiSo,SiSoToiDa,HoTenGV
FROM ((LopChungChi join HocPhanChungChi on LopChungChi.MaHocPhanCC = HocPhanChungChi.MaHocPhanCC) join GiangVien on LopChungChi.MaGiangVien = GiangVien.MaGiangVien) join DanhSachLopChungChi on LopChungChi.MaDSLopChungChi = DanhSachLopChungChi.MaDSLopChungChi;
go
--SELECT*FROM chitietchungchi;
--==THEM = 
create or alter proc Them_lopchungchi
(
	@MaLopChungChi nvarchar(10),
	@MaDSLopChungChi nvarchar(10),
	@MaGiangVien nvarchar(8),
	@MaHocPhanCC nvarchar(10),
	@TenLopChungChi nvarchar(50),
	@SiSo int,
	@SiSoToiDa int
)
as
begin
	insert into LopChungChi values(@MaLopChungChi,@MaDSLopChungChi,@MaGiangVien,@MaHocPhanCC,@TenLopChungChi,@SiSo,@SiSoToiDa);
end;
go
exec Them_lopchungchi 'LP002','DS001','GV001','AV001','17_2',0,6;
--==UPDATE
go
create or ALTER proc capnhat_lopchungchi
(
	@MaLopChungChi nvarchar(10),
	@MaDSLopChungChi nvarchar(10),
	@MaGiangVien nvarchar(8),
	@MaHocPhanCC nvarchar(10),
	@TenLopChungChi nvarchar(50),
	@SiSo int,
	@SiSoToiDa int
)
as
begin
	UPDATE LopChungChi SET MaDSLopChungChi =@MaDSLopChungChi WHERE MaLopChungChi = @MaLopChungChi;
	UPDATE LopChungChi SET MaGiangVien =@MaGiangVien WHERE MaLopChungChi = @MaLopChungChi;
	UPDATE LopChungChi SET MaHocPhanCC =@MaHocPhanCC WHERE MaLopChungChi = @MaLopChungChi;
	UPDATE LopChungChi SET TenLopChungChi =@TenLopChungChi WHERE MaLopChungChi = @MaLopChungChi;
	UPDATE LopChungChi SET SiSo =@SiSo WHERE MaLopChungChi = @MaLopChungChi;
	UPDATE LopChungChi SET SiSoToiDa =@SiSoToiDa WHERE MaLopChungChi = @MaLopChungChi;
end;
--==DELETE
go
create or alter proc xoa_lopchungchi
(
	@MaLopChungChi nvarchar(10)
)
as
begin
	delete LopChungChi where MaLopChungChi = @MaLopChungChi;
end
go
--THEM/SUA/XOA BANG HOCPHANCHUNGCHI
create or alter proc them_hpchungchi
(
	@MaHocPhanCC nvarchar(10),
	@TenHocPhanCC nvarchar(50),
	@MaDS nvarchar(10)
)
as
begin
	insert into HocPhanChungChi values(@MaHocPhanCC,@TenHocPhanCC,@MaDS);
end;
--==Sua
go
create or alter proc sua_hpchungchi
(
	@MaHocPhanCC nvarchar(10),
	@TenHocPhanCC nvarchar(50),
	@MaDS nvarchar(10)
)
as
begin
	UPDATE HocPhanChungChi SET TenHocPhanCC = @TenHocPhanCC WHERE MaHocPhanCC = @MaHocPhanCC;
	UPDATE HocPhanChungChi SET MaDS = @MaDS WHERE MaHocPhanCC=@MaHocPhanCC;
end;
--==Xoa_hpchungchi
go
create or alter proc xoa_hpchungchi
(
	@MaHocPhanCC nvarchar(10)

)
as
begin
	DELETE HocPhanChungChi WHERE MaHocPhanCC = @MaHocPhanCC;
end;
--THEM/SUA DANHSACHLOPCHUNGCHI
--==THEM
go
create or alter proc them_dslopchungchi
(
	@MaDSLopChungChi nvarchar(10),
	@HocKy int,
	@Nam char(5),
	@MaLoaiCC nvarchar(10),
	@TenDSLopChungChi nvarchar(50)
)
as
begin
	insert into DanhSachLopChungChi values(@MaDSLopChungChi,@HocKy,@Nam,@MaLoaiCC,@TenDSLopChungChi,GETDATE());
end;
--SUA
go
create or alter proc sua_dslopchungchi
(
	@MaDSLopChungChi nvarchar(10),
	@HocKy int,
	@Nam char(5),
	@MaLoaiCC nvarchar(10),
	@TenDSLopChungChi nvarchar(50)

)
as
begin
	UPDATE DanhSachLopChungChi SET HocKy = @HocKy WHERE MaDSLopChungChi=@MaDSLopChungChi;
	UPDATE DanhSachLopChungChi SET Nam = @Nam WHERE MaDSLopChungChi=@MaDSLopChungChi;
	UPDATE DanhSachLopChungChi SET MaLoaiCC =@MaLoaiCC WHERE MaDSLopChungChi=@MaDSLopChungChi;
	UPDATE DanhSachLopChungChi SET TenDSLopChungChi = @TenDSLopChungChi WHERE MaDSLopChungChi=@MaDSLopChungChi;

end;
go
--exec XEM_HP @MSSV = '122222';
--insert into GiangVien values ('121323', N'Nguyễn hạ thành', 'N/A', '4123123123');
-----------------------------Nguyên
use QLHocPhan
GO
---------------------------------------------------------------------------------------------------------------------------------
----------------------------Tao table Lich Thi va DSSV_DuThi
CREATE TABLE [DSSV_DuThi]
(
	[MaLichThi] nvarchar(10) NOT NULL,
	[MSSV] nvarchar(8) NOT NULL,
	[GiamThi] nvarchar(8) NOT NULL,
	[TinhTrang] varchar(50) NULL,
	[Diem] int NULL
)
GO
CREATE TABLE [LichThi]
(
	[MaLichThi] nvarchar(10) NOT NULL,
	[MaLopHP] nvarchar(10) NULL,
	[MaLopChungChi] nvarchar(10) NULL,
	[MaLopCD] nvarchar(10) NULL,
	[NgayThi] date NOT NULL,
	[GioThi] char(6) NOT NULL,
	[LoaiThi] char(7) NOT NULL,
	[DiaDiem] nvarchar(50) NOT NULL,
	[PhongThi] char(10) NULL,
	[HocKy] int NOT NULL,
	[NamHoc] int NOT NULL,
	[GVCoiThi] nvarchar(8) NOT NULL
)
GO
ALTER TABLE [DSSV_DuThi] 
 ADD CONSTRAINT [PK_DSSV_DuThi]
	PRIMARY KEY CLUSTERED ([MaLichThi] ASC,[MSSV] ASC)
GO
CREATE NONCLUSTERED INDEX [IXFK_DSSV_DuThi_LichThi] 
 ON [DSSV_DuThi] ([MaLichThi] ASC)
GO
CREATE NONCLUSTERED INDEX [IXFK_DSSV_DuThi_SinhVien] 
 ON [DSSV_DuThi] ([MSSV] ASC)
GO
ALTER TABLE [LichThi] 
 ADD CONSTRAINT [PK_LichThi]
	PRIMARY KEY CLUSTERED ([MaLichThi] ASC)
GO

ALTER TABLE [LichThi] 
 ADD CONSTRAINT [C_LichThi_LoaiThi] CHECK (LoaiThi='online'
or
LoaiThi='offline')
GO

ALTER TABLE [LichThi] 
 ADD CONSTRAINT [C_LichThi_HocKy] CHECK (HocKy=1 
or
 HocKy=2 
or 
HocKy=3)
GO

CREATE NONCLUSTERED INDEX [IXFK_LichThi_GiangVien] 
 ON [LichThi] ([GVCoiThi] ASC)
GO
CREATE NONCLUSTERED INDEX [IXFK_LichThi_LopChungChi] 
 ON [LichThi] ([MaLopChungChi] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_LichThi_LopChuyenDe] 
 ON [LichThi] ([MaLopCD] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_LichThi_LopHocPhan] 
 ON [LichThi] ([MaLopHP] ASC)
GO
-----------------------------------------FK
ALTER TABLE [DSSV_DuThi] ADD CONSTRAINT [FK_DSSV_DuThi_LichThi]
	FOREIGN KEY ([MaLichThi]) REFERENCES [LichThi] ([MaLichThi]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [DSSV_DuThi] ADD CONSTRAINT [FK_DSSV_DuThi_SinhVien]
	FOREIGN KEY ([MSSV]) REFERENCES [SinhVien] ([MSSV]) ON DELETE No Action ON UPDATE No Action
GO
ALTER TABLE [LichThi] ADD CONSTRAINT [FK_LichThi_GiangVien]
	FOREIGN KEY ([GVCoiThi]) REFERENCES [GiangVien] ([MaGiangVien]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [LichThi] ADD CONSTRAINT [FK_LichThi_LopChungChi]
	FOREIGN KEY ([MaLopChungChi]) REFERENCES [LopChungChi] ([MaLopChungChi]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [LichThi] ADD CONSTRAINT [FK_LichThi_LopChuyenDe]
	FOREIGN KEY ([MaLopCD]) REFERENCES [LopChuyenDe] ([MaLopCD]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [LichThi] ADD CONSTRAINT [FK_LichThi_LopHocPhan]
	FOREIGN KEY ([MaLopHP]) REFERENCES [LopHocPhan] ([MaLopHP]) ON DELETE No Action ON UPDATE No Action
GO
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------Select SV,GV tham gia ki thi HP
------------SV thi HP
Create or Alter procedure Sel_SVThi(@MaLichThi nvarchar(10))
as
begin
	if(not exists (select * from LichThi where MaLichThi=@MaLichThi))
	        return
	select sv.MSSV,sv.HoTenHS,sv.Khoa 
from SinhVien sv , LichThi lt, PhieuDKLopHP hp , HocPhi phi
where phi.MSSV=sv.MSSV and phi.MaLopHP=lt.MaLopHP and UPPER(phi.TinhTrang) = UPPER(N'Da Tra')  and hp.MSSV=sv.MSSV and lt.MaLichThi=@MaLichThi and lt.MaLopHP=hp.MaLopHP and lt.HocKy=lt.HocKy and lt.NamHoc=hp.NamHoc;
end;
go
------------GV Coi Thi
Create or Alter procedure Sel_GVCoiThi(@MaLichThi nvarchar(10))
as
begin
	if(not exists (select * from LichThi where MaLichThi=@MaLichThi))
	        return
	select gv.MaGiangVien,gv.HoTenGV
	from GiangVien gv, LichThi lt
	where lt.MaLichThi=@MaLichThi and gv.MaGiangVien=lt.GVCoiThi
end;
go
-------------------------------------------Select DS Lich Thi
select * from LichThi;
------------Select ki thi theo MaLichThi
go
Create or Alter procedure Sel_LichThi_MaLichThi(@MaLichThi nvarchar(10))
as
begin
	if(not exists (select * from LichThi where MaLichThi=@MaLichThi))
	        return
	select *
	from LichThi lt
	where lt.MaLichThi=@MaLichThi 
end;
GO
---------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------Insert / Update/ Delete LichThi
------------------------Insert thi HP

Create or Alter procedure Ins_LichThi_HP(@MaLichThi nvarchar(10), @MaLopHP_New nvarchar(10), @MaLopCC_New nvarchar(10)=NULL, @MaLopCD_New nvarchar(10)=NULL,@Ngay date, @Gio char(6), @loai char(7),@DiaDiem nvarchar(50),@phong char(10),@HK int, @nam int, @GV nvarchar(8))
as
begin
	if(exists (select * from LichThi where MaLichThi=@MaLichThi))
	        return
	insert into LichThi values (@MaLichThi,@MaLopHP_New,@MaLopCC_New,@MaLopCD_New,@Ngay,@Gio,@loai,@DiaDiem,@phong,@HK,@nam,@GV);
end;
go
----------------------Update GV Coi thi
Create or Alter procedure Up_LichThi_GVCoiThi(@MaLichThi nvarchar(10) , @GV nvarchar(8))
as
begin
	if(not exists (select * from LichThi where MaLichThi=@MaLichThi))
	        return
	update LichThi set GVCoiThi=@GV where MaLichThi=@MaLichThi;
end;
go
----------------------Del 1 ki thi
Create or Alter procedure Up_LichThi_GVCoiThi(@MaLichThi nvarchar(10))
as
begin
	if(not exists (select * from LichThi where MaLichThi=@MaLichThi))
	        return
	Delete From LichThi where MaLichThi=@MaLichThi
end;
GO
-----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Insert / Update/ Delete DSSV_DuThi
------------------------Insert SV thi HP
Create or Alter procedure Ins_SV_DuThi_HP(@MaLichThi nvarchar(10), @mssv NVARCHAR(8))
as
begin
	if(NOT EXISTS (select * from LichThi where MaLichThi=@MaLichThi))
	        RETURN
	IF(NOT EXISTS (select * from SinhVien where MSSV=@mssv))
	        RETURN
	IF(EXISTS (select * from DSSV_DuThi where MaLichThi=@MaLichThi and MSSV=@mssv))
	        RETURN
	DECLARE @TT NVARCHAR(20);
	SET @TT=(	SELECT phi.TinhTrang 
				FROM HocPhi phi, LichThi lt
				WHERE phi.MSSV=@mssv AND lt.MaLichThi=@MaLichThi AND phi.MaLopHP=lt.MaLopHP)
	IF (@TT!=N'đã trả')
		RETURN
	DECLARE @giamThi NVARCHAR(8);
	SET @giamThi=(	SELECT GVCoiThi 
					FROM LichThi 
					WHERE MaLichThi=@MaLichThi)
	INSERT INTO DSSV_DuThi VALUES (@MaLichThi,@mssv,@giamThi,N'DuThi',0);
end;
GO
------------------------Update diem SV thi HP
Create or Alter procedure Up_SV_DuThi_HP(@MaLichThi nvarchar(10), @mssv NVARCHAR(8), @diem int)
as
begin
	if(NOT EXISTS (select * from LichThi where MaLichThi=@MaLichThi))
	        RETURN
	IF(NOT EXISTS (select * from SinhVien where MSSV=@mssv))
	        RETURN
	DECLARE @giamThi NVARCHAR(8);
	SELECT GVCoiThi =@giamThi
	FROM LichThi 
	WHERE MaLichThi=@MaLichThi
	INSERT INTO DSSV_DuThi VALUES (@MaLichThi,@mssv,@giamThi,N'DuThi',@diem);
end;
GO
-----------------------------Select SV Du Thi
Create or Alter procedure Sel_SV_DuThi_HP(@MaLichThi nvarchar(10), @mssv NVARCHAR(8))
as
begin
	if(NOT EXISTS (select * from LichThi where MaLichThi=@MaLichThi))
	        RETURN
	IF(NOT EXISTS (select * from SinhVien where MSSV=@mssv))
	        RETURN
	SELECT *
	FROM DSSV_DuThi dt
	WHERE MaLichThi=@MaLichThi AND MSSV =@mssv
end;
GO
USE QLHocPhan
GO
---------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------SV du thi
Create or Alter	FUNCTION func_KQ_SV_DuThi_HP(@MaLichThi nvarchar(10), @mssv NVARCHAR(8))
RETURNS INT
AS
BEGIN
	DECLARE @diem INT 
	if(NOT EXISTS (select * from LichThi where MaLichThi=@MaLichThi))
	BEGIN
		SET @diem=0;
	END;
	ELSE
		BEGIN
			IF(NOT EXISTS (select * from SinhVien where MSSV=@mssv))
			BEGIN
				SET @diem=0;
			END;
			ELSE
				BEGIN
					SET @diem=( SELECT dt.Diem
						FROM DSSV_DuThi dt
						WHERE MaLichThi=@MaLichThi AND MSSV =@mssv)
				END;
		END;
		RETURN @diem;
end;
GO

---------------------------------------------------------------------------
CREATE OR ALTER PROC SV_ThiHP (@mssv NVARCHAR(8), @LHP NVARCHAR(10))
AS
BEGIN
	/*declare c cursor for 
	(	SELECT lt.MaLichThi 
		FROM SinhVien st,LopHocPhan Lhp, PhieuDKLopHP dkLHP, LichThi lt 
		WHERE	dkLHP.MSSV=@mssv AND Lhp.MaLopHP=dkLHP.MaLopHP 
				AND lt.MaLopHP=Lhp.MaLopHP AND lt.HocKy=dkLHP.HocKy AND lt.NamHoc=dkLHP.NamHoc
	)
	open c
	declare @MaLT NVARCHAR(10)
	declare @diem INT
	DECLARE @SoLanThi int
	fetch next from c into @MaLT
	while (@@fetch_status=0)
	begin
		--SET @diem=func_KQ_SV_DuThi_HP (@MaLT, @mssv)
		SELECT
		FROM DSSV_DuThi svdt
		WHERE M
		fetch next from c into @MaLT
	end
	close c
	deallocate c*/
	DECLARE @SoLanThi INT;
	SET @SoLanThi=(	SELECT COUNT(*)
					FROM DSSV_DuThi dt, LichThi lt
					WHERE lt.MaLopHP=@LHP AND dt.MaLichThi=lt.MaLichThi AND dt.MSSV=@mssv)
	IF(@SoLanThi<=2)
		RETURN N'Có thể thi lại';
	ELSE
		RETURN N'Không thể thi lại';
END;
go
-------------------Thắng
