# Chương 4 trang 24
Xác định khóa

Thí sinh: MASV PK, MALOP FK, HOTEN, NGAYSINH, NOISINH,PHAI, DANTOC
Lop: MALOP PK, MAKHOA FK, TENLOP
KHOA: MAKHOA PK, TENKHOA
MONTHI: MAMT PK, TENMT, THOIGIAN, NGAYTHI, BUOITHI, LOAIMONTHI, GHICHU

Quan hệ
THISINH - LOP n - 1: HOC
LOP - KHOA n - 1: QUANLY
THISINH - MONTHI m-n : THICU
THICU: MASV FK, MAMT FK, PK=(MAMT, MASV),  DIEMTHI
## Rằng buộc toàn vẹn
Rằng buộc thực thể
- Mọi giá trị của các thuộc tính trong khóa chính không được NULL

Rằng buộc tham chiếu
- Mọi MALOP trong THISINH phải tồn tại trong LOP
- Mọi MAKHOA trong LOP phải tồn tại ở KHOA
- Mọi MASV, MAMT trong THICU phải tương ứng tồn tại trong bảng THISINH và MONTHI

Rằng buộc miền giá trị 
DIEMTHI: số thực 0.0–10.0, bước 0.5

PHUT (thời gian làm bài): số nguyên dương

BUOITHI: chỉ nhận giá trị ‘SÁNG’ hoặc ‘CHIỀU’

LOAITHI: chỉ nhận ‘LYTHUYET’ hoặc ‘THUCHANH’

GHI_CHÚ (trong MONTHI): chỉ nhận ‘TRUNGCAP’ hoặc ‘CAODANG’

NGAYSINH, NGAYTHI: kiểu DATE

# Chương 4 trang 27
Xác định khóa và các rằng buộc

TACGIA: EMAIL PK, HOVATEN, BOMON, KHOA, TRUONGCONGTAC, HOCVI, CHUCVI

BAIBAO: MABAIBAO PK, TITLE, ABSTRACT, FILESAVE, MATACGIACHINH (TACGIA.EMAIL) FK


NGUOIDANHGIA: EMAIL PK, HO, TEN, SODT, HOCVI, CHUCVI, HUONGNGHIENCUU (đa trị) - nên sẽ tách ra 1 bảng

NGUOIDANHGIA_HUONG: EMAIL FK (NGUOIDANHGIA.EMAIL), HUONG NOTNULL, PK=(EMAIL, HUONG)

Quan hệ

TACGIA - BAIBAO m-n: CONGTAC

TACGIA - BAIBAO 1-n

CONGTAC: MABAIBAO FK, MATACGIA(TACGIA.EMAIL) FK, PK=(MABAIBAO, MATACGIA)

BAIBAO - NGUOIDANHGIA m-n: DANHGIA

DANHGIA: MABAIBAO FK, MANGUOIDANHGIA FK (NGUOIDANHGIA.EMAIL), PK = (MABAIBAO, MANGUOIDANHGIA), CAUHOI, NHANXET, DIEM, TINHDOCDAO. TINHTUONGTHICH, TINHTRINHBAY, KHANANGTIENCU

Rằng buộc thực thể:
- Mọi thuộc tính khóa chính không null

Rằng buộc quan hệ:
Mọi MABAIBAO, MATACGIA trong CONGTAC phải lần lượt có trong bảng BAIBAO, TACGIA
MATACGIACHINH phải có trong bảng TACGIA
Mọi MABAIBAO, MANGUOIDANHGIA trong DANHGIA phải có trong bảng BAIBAO, NGUOIDANHGIA
