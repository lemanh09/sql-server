-- CẤU TRÚC TRUY VẤN
USE [lecongtp_studySQL]
GO

SELECT * FROM DeTai -- LẤY ALL DATA 
SELECT tendt, NoiThucTap FROM DeTai  -- LAY DATA form COL

SELECT masv as 'Mã sinh viên',hotensv as 'Họ và tên sinh viên', makhoa as 'Chuyên ngành học' FROM SinhVien -- DOI TEN COL
SELECT magv as 'Mã giảng viên',hotengv as 'Họ và tên giảng viên', makhoa as 'Chuyên ngành dạy' FROM GiangVien

-- Alias
SELECT sv.hotensv,gv.hotengv, sv.makhoa
FROM SinhVien AS sv, GiangVien As gv -- Tổ hợp 2 bảng

-- 1, 2, 3
-- A, B
-- 1A, 2A, 3A, 1B, 2B, 3B

--BT 1
select * from DeTai
--BT 2
select makhoa as 'Mã Khoa', tenkhoa as 'Tên Khoa' from Khoa
--BT 3
select magv as 'Mã giáo viên', hotengv as 'Họ tên giáo viên' from GiangVien
--BT 4 
select magv as 'Mã giáo viên', hotengv as 'Họ tên giáo viên', makhoa as 'Ngành đào tạo' from GiangVien

-- TRUY VẤN CÓ ĐIỀU KIỆN

select sv.hotensv,gv.hotengv, sv.makhoa
from SinhVien as sv, GiangVien as gv -- Tổ hợp 2 bảng
where sv.makhoa = gv.makhoa and sv.makhoa = 'CNTT-CQ'

select sv.hotensv as 'Họ Tên Sinh Viên',gv.hotengv as 'Họ Tên Giảng Viên', gv.makhoa as 'Ngành Đào Tạo',dt.tendt as 'Tên Đề Tài'
from SinhVien as sv, GiangVien as gv, DeTai as dt -- Tổ hợp 2 bảng
where sv.masv = dt.madt and sv.makhoa = gv.makhoa  -- inner join kiểu cũ
and sv.hotensv like '%G' -- TK gần đúng

-- inner join
select * from  SinhVien inner join GiangVien on SinhVien.makhoa = GiangVien.makhoa -- inner join kiểu mới

select sv.masv as 'Mã sinh viên', sv.hotensv as 'Họ tên sinh viên', 
sv.makhoa as 'Chuyên ngành', sv.namsinh as 'Năm sinh', sv.quequan as 'Cư Trú',
gv.magv as 'Mã giảng viên', gv.hotengv as 'Họ tên giảng viên', gv.luong as 'Lương Bổng'
from SinhVien as sv join GiangVien as gv
on sv.makhoa = gv.makhoa;

-- RIGHT JOIN
select sv.masv as 'Mã sinh viên', sv.hotensv as 'Họ tên sinh viên', 
sv.makhoa as 'Chuyên ngành', sv.namsinh as 'Năm sinh', sv.quequan as 'Cư Trú',
gv.magv as 'Mã giảng viên', gv.hotengv as 'Họ tên giảng viên', gv.luong as 'Lương Bổng'
from SinhVien as sv right join GiangVien as gv
on sv.makhoa = gv.makhoa;

-- LEFT JOIN
select sv.masv as 'Mã sinh viên', sv.hotensv as 'Họ tên sinh viên', 
sv.makhoa as 'Chuyên ngành', sv.namsinh as 'Năm sinh', sv.quequan as 'Cư Trú',
gv.magv as 'Mã giảng viên', gv.hotengv as 'Họ tên giảng viên', gv.luong as 'Lương Bổng'
from GiangVien as gv left join SinhVien as sv
on sv.makhoa = gv.makhoa;

-- UNION
select madt  from HuongDan 
where ketqua < 79
union
select madt from DeTai
where kinhphi > 2000000

select *  from HuongDan 
select *  from DeTai 

-- SELECT INTO

-- GET ALL DATA FROM  SinhVien's TABLE THEN ASSIGN TO newSinhVien
select * into newSinhVien from SinhVien
select * from newSinhVien
drop table newSinhVien

-- NOOB CODE WILL DO LIKE THIS
select SinhVien.hotensv as 'Họ tên sinh viên',SinhVien.masv as 'Mã sinh viên', Khoa.makhoa as 'Đào tạo',Detai.tendt as 'Đề tài',
GiangVien.hotengv as 'Giảng viên',HuongDan.ketqua as 'Kết quả' 
into SVBackUp2 from SinhVien, GiangVien, Detai, HuongDan, Khoa
where SinhVien.masv = DeTai.madt 
and SinhVien.makhoa = Khoa.makhoa
and SinhVien.makhoa = GiangVien.makhoa 
and SinhVien.masv = HuongDan.masv


select * from SVBackUp2
drop table SVBackUp2

-- THE BEST WAY PRO CODE DO
SELECT 
    sv.hotensv AS 'Họ tên sinh viên', 
    sv.masv AS 'Mã sinh viên', 
    k.makhoa AS 'Đào tạo', 
    dt.tendt AS 'Đề tài', 
    gv.hotengv AS 'Giảng viên', 
    hd.ketqua AS 'Kết quả' 
INTO SVBackUp 
FROM 
    SinhVien sv
JOIN 
    HuongDan hd ON sv.masv = hd.masv
JOIN 
    Detai dt ON hd.madt = dt.madt
JOIN 
    GiangVien gv ON hd.magv = gv.magv
JOIN 
    Khoa k ON sv.makhoa = k.makhoa;

select * from SVBackUp
select * from SVBackUp2

select * into Ghost from SVBackup2
where 1 = 0

select * from Ghost

insert into Ghost select * from SVBackUp 

-- Is the lecturer has magv = 1 teaching in CNTT class ?

-- TRUY VẤN LỒNG
select * from GiangVien where GiangVien.magv = 2
and GiangVien.makhoa in 
( 
	select makhoa from GiangVien 
)
-- GROUP BY

-- CHO BIẾT SỐ LƯỢNG NGƯỜI THEO CÁC NGÀNH
select SinhVien.makhoa, COUNT(*) from SinhVien, GiangVien
where SinhVien.makhoa = GiangVien.makhoa
group by SinhVien.makhoa having COUNT(*) > 2

-- LẤY DS GV CÓ LƯƠNG > TB

select * from GiangVien where luong > (
(select sum(luong) from GiangVien) /
(select count(*) from GiangVien))

-- Xuất ra tên gv và đề tài gv đó đã làm
select * from SinhVien
select * from GiangVien
select * from DeTai

select hotengv,tendt, count(*) from SinhVien,GiangVien,DeTai
where SinhVien.makhoa = GiangVien.makhoa and SinhVien.masv = DeTai.madt
group by hotengv,tendt

-- Xuất ra tên gv và số đề tài gv đó đã làm
select HuongDan.magv,hotengv, count(*) from HuongDan, GiangVien
where HuongDan.magv = GiangVien.magv
group by HuongDan.magv, hotengv having count(*) > 1

-- Auto Increase
create table countries
(
	id INT primary key identity,
	nation nvarchar(50),
)
insert into countries (nation) values (N'Triều tiên')

select * from countries
-- Tạo ra view từ câu truy vấn 
create view testview as 
select * from countries 

insert into testview (nation)
values (N'Nga')
select * from countries 
select * from testview
drop view testview

-- CHECK
-- add a constraint check ket qua
alter table ghost add constraint KQ_Check check ([Kết quả] > 0 and [Kết quả] <= 100)

insert into ghost ([Họ tên sinh viên],[Mã sinh viên],[Đào tạo],[Đề tài],[Giảng viên],[Kết quả])
values ('ALI VELOA CHEK',201,'TMDT-QT','SUSTAINABLE TECHXA','NGUYEN TRAN KHAI',95)

-- INDEXES (tạo chỉ số, tăng tốc truy vấn, chậm tốc độ sửa dữ liệu)

create index IndexName on Ghost ([Mã sinh viên])

select * from Ghost

-- Kiểu dữ liệu tự định nghĩa
exec sp_addtype 'NName', 'nvarchar(20)','Not null'

create table testAliasDataType
(
	Name NName,
	Address NName
)
drop table testAliasDataType
exec sp_droptype 'NName'

-- Tạo biến lưu giá trị của câu truy vấn
declare @MinSalaryMaGV char(20)
select @MinSalaryMaGV = MIN(luong) from GiangVien

select * from GiangVien where luong = @MinSalaryMaGV

-- khởi tạo với kiểu dữ liệu
declare @i int

-- Khoiiwr tạo với giá trị mặc định
declare @j int = 0

-- set dữ liệu cho biến set @i = @i + 1
set @i += 1
set @j += @i

-- set thông qua câu select

declare @MaxLhuong int
select @MaxLhuong = (luong) from GiangVien

-- In ra tên gv có lương thấp nhất
declare @MinSalaryMaGV char(20)
declare @Tengv char(50)
select @MinSalaryMaGV = MIN(luong) from GiangVien

select @Tengv = hotengv from GiangVien where luong = @MinSalaryMaGV
print @Tengv









