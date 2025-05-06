# Rằng buộc

- Rằng buộc trên dữ liệu quan hệ
    - Hai bộ bất kỳ cuả quan hệ không có giá trị bằng nhau tại `thuộc tính khoá`
    - SK là SK cuả quan hệ `R` khi hai bộ bất kỳ cuả R không có giá trị bằng nhau tại SK
    - K là khoá cuả quan hệ R khi
        - K là siêu khoá
        - K là siêu khoá nhỏ nhất 
    - Rằng buộc giá trị NULL
        - Thuộc tính A đuợc thiết lập NOT NULL thì bộ dữ liệu không nhận giá trị NULL tại thuộc tính này.
    - Rằng buộc Thực thể
        - Nếu K là khoá chính cuả quan hệ R thì tồn taị `đồng thời` rằng buộc `NOT NULL` trên các các thuộc tính cuả K 
        - Khoá chính không NULL 
    - Rằng buộc toàn vẹn tham chiếu
- Khai báo khoá ngoại (FK) ở bảng con trỏ về khoá chính (PK) ở bảng chi
            - Nhằm mọi giá trị FK ở bảng con phải luôn khớp với một giá trị PK ở bảng cha 
            - Bảng cha không nhất thiết phải biết bảng con 
        - Vi phạm xảy ra khi 
            - Xoá `cha` để con bơ vơ 
            - Chèn, cập nhập `con` nhận vơ `cha`
            - Thuờng những truờng hợp update hoặc delete 2 thuộc tính sẽ dễ gaya ra lôĩ

# Cách tạo thêm rằng buộc 

Cấu trúc
```sql
ALTER TABLE TABLE-NAME 
ADD CONSTRAINT CONSTRAINT-NAME
ADD
ALTER COLUMN
DROP COLUMN
```

- Với rằng buộc `NOT NULL`, SQL SERVER dùng `ALTER COLUMN`
- Và có một số rằng buộc không thể xoá bằng `DROP CONSTRAINT` mà phải `ALTER TABLE .. DROP CONSTRAINT <tên>`
``` sql
-- 2.1 Thêm khóa chính
ALTER TABLE SinhVien
ADD CONSTRAINT PK_SinhVien PRIMARY KEY (MaSV);

-- 2.2 Thêm khóa ngoại
ALTER TABLE DiemHoc
ADD CONSTRAINT FK_DiemHoc_SinhVien
    FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV);

-- 2.3 Thêm UNIQUE
ALTER TABLE SinhVien
ADD CONSTRAINT UQ_SinhVien_Email UNIQUE (Email);

-- 2.4 Thêm CHECK
ALTER TABLE SinhVien
ADD CONSTRAINT CHK_SinhVien_Tuoi
    CHECK (DATEDIFF(year, NgaySinh, GETDATE()) >= 18);

-- 2.5 Thêm NOT NULL (cách MySQL / SQL Server không hỗ trợ tên)
ALTER TABLE SinhVien
ALTER COLUMN HoTen NVARCHAR(100) NOT NULL;
```
# Quy tắt
- Nằm giữa khoảng 2 số thì dùng between
```sql
ALTER TABLE TABLENAME
ADD CONSTRAINT chkTABLENAME_ATTRIBUTESNAME
CHECK (ATTRIBUTENAME BETWEEN X AND Y)
```
