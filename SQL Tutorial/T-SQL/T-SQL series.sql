USE [lecongtp_studySQL]
GO

-- If else
declare @AvgLuongGv int
declare @numOfGv int
declare @luongGV int

select @numOfGv = COUNT(*) from GiangVien
select @AvgLuongGv = (SUM(luong) / @numOfGv) from GiangVien
select @luongGv = luong from GiangVien where magv = 2

if @luongGV > @AvgLuongGv
begin
	print N'Lương Giảng Viên là: ' + CAST(@luongGV AS NVARCHAR(20)) -- chuyển đổi dữ liệu
	print N'Lương Trung Bình Giảng Viên là: ' + CAST(@AvgLuongGv AS NVARCHAR(20))
	print N'=> Lớn hơn'
end
else
begin
	print N'Lương Giảng Viên là: ' + CAST(@luongGV AS NVARCHAR(20))
	print N'Lương Trung Bình Giảng Viên là: ' + CAST(@AvgLuongGv AS NVARCHAR(20))
	print N'=> Bé hơn'
end

-- Loop
declare @i int = 0
declare @n int = 100
while (@i < @n)
begin

	insert into countries2 (nation) values (N'Việt Nam ' + cast(@i as nvarchar(20)))
	set @i += 1
end

--Insert 1000 record vào bảng Countries2
--Ko trùng id
create table countries2
(
	id INT primary key identity,
	nation nvarchar(50),
)
insert into countries2 (nation) values (N'Triều tiên')

select * from countries2

drop table countries2

-- Cursor
declare GiangVienCursor cursor for select magv, hotengv from GiangVien
open GiangVienCursor

declare @MaGv int
declare @TenGiangVien char(50)

fetch next from GiangVienCursor into @MaGv, @TenGiangVien

while @@FETCH_STATUS = 0
begin
	if @MaGv > 2
	update GiangVien set luong = 400.00 where magv = @MaGv
end
close GiangVienCursor
deallocate GiangVienCursor

select * from GiangVien
go
-- Store
-- Create store
create proc SelectAll
as
begin
	select * from SinhVien
end
go
-- Call store
exec SelectAll
go
-- Remove store
drop proc SelectAll
go
-- Function
-- Create
CREATE FUNCTION SelectAllGiangVien()
RETURNS TABLE
AS
RETURN 
(
    SELECT * 
    FROM GiangVien
)
GO
-- Call func
select * from SelectAllGiangVien()
GO

CREATE FUNCTION f_SelectDataTable(@Magv INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT Magv, Luong
    FROM GiangVien
    WHERE Magv = @Magv
)
GO

SELECT * FROM f_SelectDataTable(2);
-- remove func
drop function f_SelectDataTable
go

-- A function can get a data from SVBackUp2 table via parameter
create function getDataSinhVien(@Masv int)
returns table
as
return
(
	select * from SVBackUp2 where [Mã sinh viên] = @Masv
)
go
select * from getDataSinhVien(111)

select * from SVBackUp2
go
-- Trigger: Can thiệp sự kiện update delete,...
-- Inserted: Chứa những trường đã insert, update vào bảng
-- Deleted: Chứa những trường đã delete

CREATE TRIGGER TG_SinhVienBK
on SVBackUp
for INSERT, UPDATE
AS
BEGIN
	PRINT N'Không thể thêm'
	ROLLBACK TRANSACTION -- Hủy bỏ thay đổi cập nhật bảng
END
INSERT INTO SVBackUp ([Họ tên sinh viên], [Mã sinh viên], [Đào tạo], [Đề tài], [Giảng viên], [Kết quả])
VALUES ('Hoàng Beo', 404,'KTMT-QT', 'Quản lý tiền ảo','BUI XUAN HUAN',82.20)


SELECT * FROM SVBackUp
GO
-- Không cho xóa lương lớn hơn 15
create TRIGGER TG_SalaryAbove15
on GiangVien
for DELETE
as
BEGIN
	DECLARE @Count INT = 0
    
    SELECT @Count = COUNT(*) from DELETED -- Đếm lệnh DELETE
    WHERE DELETED.luong > 150.000 -- Kiểm tra
    
    if (@Count > 0)
    BEGIN
    PRINT N'Không thể xóa'
    	ROLLBACK TRANSACTION -- Hủy bỏ thay đổi cập nhật bảng
	END
END

Select * FROM GiangVien
INSERT INTO GiangVien (magv, hotengv, luong, makhoa)
VALUES
	(01, 'BUI XUAN HUAN', 520.00, 'CNTT-CQ')

Delete GiangVien where magv = 1
	
-- Transaction: Chấp nhận/Hủy bỏ chuỗi thao tác
insert countries (nation)
values('China')
select * from countries

declare @RmChingChong varchar(20) --Cách đặt tên
select @RmChingChong = 'RmChingChong'

begin transaction @RmChingChong

-- chuỗi thao tác
delete countries where id = 8

-- Go back
rollback transaction

commit transaction RmChingChong -- chấp nhận thay đổi

-------------------------------------------------------------------

begin transaction
save transaction trans1  -- đặt mốc
delete countries where id = 4
commit

begin transaction
save transaction trans2
delete countries where id = 5
commit

rollback transaction trans1 -- Back

select * from countries