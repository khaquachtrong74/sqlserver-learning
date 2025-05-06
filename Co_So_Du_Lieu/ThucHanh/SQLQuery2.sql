use Northwind
go

-- BAI TAP THUC HANH 3
-- TIM KHACH HANG MY
SELECT * INTO TIMKHACHHANGMY FROM Customers
WHERE Country='USA'

SELECT * FROM TIMKHACHHANGMY
-- TIM 5 NHAN VIEN GIOI NHAT
SELECT TOP 5 e.EmployeeID, 
		e.LastName + ' ' + e.FirstName 'fullName', 
		COUNT(o.OrderID) 'DonHang'
FROM Employees e, Orders o
WHERE e.EmployeeID = o.EmployeeID
GROUP By e.EmployeeID, e.LastName + ' ' + e.FirstName
ORDER BY 3 DESC

-- TIM 5 QUOC GIA IT MUA HANG
SELECT TOP 5 c.Country, Count(od.ProductID) 'SL' INTO NamQG
FROM [Order Details] od, Orders o, Customers c
WHERE od.OrderID = o.OrderID AND o.CustomerID = c.CustomerID
GROUP BY c.Country
ORDER BY 2 desc

SELECT * FROM NamQG

-- UPDATE QUERY : 1, 2, 6
-- Bài 1: lấy tất cả khách hàng USa và sửa thành nước Mỹ
SELECT * INTO SuaTen FROM Customers WHERE Customers.Country = 'USA'

SELECT * FROM SuaTen
UPDATE SuaTen
SET Country=N'Nước mỹ'
WHERE Country = 'USA'

-- Bài 2: Sửa tên lần nữa với 2 quốc gia
SELECT * INTO SuaTen2 FROM Customers WHERE Customers.Country in ('Germany','France')


UPDATE SuaTen2
SET Country = (
		case 
		WHEN Country='Germany' THEN N'Nước Đức'
		ELSE N'Nước pháp'
		END
)
WHERE SuaTen2.Country in ('Germany','France')
SELECT * FROM SuaTen2

-- Bài 6: Sửa mã bưu điện
SELECT * INTO SuaPostalCode1 FROM Customers WHERE Country='Germany'

UPDATE SuaPostalCode1
SET PostalCode ='18' + RIGHT(PostalCode,2)
SELECT * FROM SuaPostalCode1 s

-- APPEND QUERY THEM 1 HANG DU LIEU
-- 1. Tạo bảng mới và thêm reccord
Select * INTO Them1LoaiSpa FROM Categories
INSERT INTO Them1LoaiSpa(CategoryName, Description)
VALUES(N'Văn phòng phẩm ', N'Sách, vở, giấy, bút, mực ')
SELECT * FROM Them1LoaiSpa

-- 4.	Hãy tạo một query đặt tên là ThemMotNhanVien 
-- (thêm một nhân viên). Khi chạy, query này sẽ thêm một 
-- record vào table Employees với các thông tin cá nhân của các anh chị
SELECT * INTO ThemMotNhanVien FROM Employees
SELECT * FROM ThemMotNhanVien
INSERT INTO ThemMotNhanVien(LastName, FirstName)
VALUES ('Quacsh', 'Kha')

-- 6. Append nhiều hàng dữ liệu
SELECT * INTO KhachHang FROM Customers
DELETE FROM KhachHang
INSERT INTO KhachHang
SELECT * FROM Customers WHERE Country = 'USA'

SELECT * FROM KhachHang

-- 7 Tạo một query đặt tên là LayDLKhachHangQuy
SELECT * INTO KH FROM Customers
DELETE FROM KH

INSERT INTO KH
SELECT * FROM Customers 
WHERE CustomerID in ( SELECT TOP 10 CustomerID
						from Orders
						GROUP BY CustomerID
						ORDER BY count(OrderID) desc
						)
						SELECT * FROM KH

-- CROSS-TAB
SELECT ProductName, [1996],[1997],[1998], 
TC = ISNULL([1996],0) + ISNULL([1997],0) + ISNULL([1998],0)
FROM(
	SELECT p.ProductName, Year(OrderDate) nam, od.Quantity sl
	FROM Products p, [Order Details] od, Orders o
	WHERE P.ProductID = od.ProductID and od.OrderID = o.OrderID
	AND YEAR(OrderDate) BETWEEN 1996 and 1998) A
pivot(
	sum(sl) for nam in ([1996],[1997],[1998])
)B


-- 5 Tạo query Crosstab thống kê doanh số từng khách hàng của UK theo
-- Từng quý trong năm 1995_ Doanh số = UnitPrie*Quantity

SELECT CompanyName, ToTal = ISNULL([1],0) + ISNULL([2],0) + ISNULL([3],0)
							+ISNULL([4],0) + ISNULL([5],0) + ISNULL([6],0)
							+ISNULL([7],0) + ISNULL([8],0) + ISNULL([9],0)
							+ISNULL([10],0) + ISNULL([11],0) + ISNULL([12],0)
, Qtr1= ISNULL([1],0) + ISNULL([2],0) + ISNULL([3],0),
Qtr2= ISNULL([4],0) + ISNULL([5],0) + ISNULL([6],0),
Qtr3= ISNULL([7],0) + ISNULL([8],0) + ISNULL([9],0),
Qtr4= ISNULL([10],0) + ISNULL([11],0) + ISNULL([12],0)
FROM (
	SELECT CompanyName, MONTH(OrderDate) Thang, od.Quantity*od.UnitPrice DoanhSo
	FROM Customers c, [Order Details] od, Orders o
	WHERE c.CustomerID = o.CustomerID and od.OrderID = o.OrderID
	)A
PIVOT(
	sum(DoanhSo) for Thang in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
)B

SELECT CompanyName,ToTal = ISNULL([1],0)+ISNULL([2],0)+ISNULL([3],0)+ISNULL([4],0)
,[1] Qtr1,[2] Qtr2,[3] Qtr3,[4] Qtr4
FROM(
	SELECT CompanyName, datepart(q,OrderDate) as Quy, od.Quantity*od.UnitPrice DoanhSo
	FROM Customers c, [Order Details] od, Orders o
	WHERE c.CustomerID = o.CustomerID and od.OrderID = o.OrderID AND YEAR(OrderDate) = 1997
	)A 
	PIVOT (
		sum(DoanhSo) for Quy in ([1],[2],[3],[4])
		)B


SELECT CategoryName, ProductName,ToTal = ISNULL([1],0)+ISNULL([2],0)+ISNULL([3],0)+ISNULL([4],0)
,[1] Qtr1,[2] Qtr2,[3] Qtr3,[4] Qtr4
FROM(
	SELECT c.CategoryName,p.ProductName, datepart(q,OrderDate) as Quy, od.Quantity*p.UnitPrice DoanhSo
	FROM Categories c, Orders o, Products p, [Order Details] od
	WHERE c.CategoryID = p.CategoryID AND YEAR(OrderDate) = 1997 AND od.ProductID = p.ProductID
	AND o.OrderID = od.OrderID
	)A  
	PIVOT (
		sum(DoanhSo) for Quy in ([1],[2],[3],[4])
	)B
