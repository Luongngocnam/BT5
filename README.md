
# BT5 
# Môn học : Hệ quản trị cơ sở dữ liệu 
# Họ Tên : Lương Ngọc Nam 
# Lớp : K58.KTP

# Yêu cầu : 
SUBJECT: Trigger on mssql

A. Trình bày lại đầu bài của đồ án PT&TKHT:
1. Mô tả bài toán của đồ án PT&TKHT, 
   đưa ra yêu cầu của bài toán đó
2. Cơ sở dữ liệu của Đồ án PT&TKHT :
   Có database với các bảng dữ liệu cần thiết (3nf),
   Các bảng này đã có PK, FK, CK cần thiết
 
B. Nội dung Bài tập 05:
1. Dựa trên cơ sở là csdl của Đồ án
2. Tìm cách bổ xung thêm 1 (hoặc vài) trường phi chuẩn
   (là trường tính toán đc, nhưng thêm vào thì ok hơn,
    ok hơn theo 1 logic nào đó, vd ok hơn về speed)
   => Nêu rõ logic này!
3. Viết trigger cho 1 bảng nào đó, 
   mà có sử dụng trường phi chuẩn này,
   nhằm đạt được 1 vài mục tiêu nào đó.
   => Nêu rõ các mục tiêu 
4. Nhập dữ liệu có kiểm soát, 
   nhằm để test sự hiệu quả của việc trigger auto run.
5. Kết luận về Trigger đã giúp gì cho đồ án của em.
#Đề tài: Phân tích thiết kế hệ thống bán vé xe bus
# Bài làm : 
# Phần A 
Tạo Database mới tên QL_banvexebus
Tạo bảng DatVe  
Tạo bảng KhachHang  
Tạo bảng LichTrinhXeBus  
Tạo bảng NhanVienBanVe
Tạo bảng TuyenXeBus  
Tạo bảng VeXe
Tạo bảng XeBus  

![image](https://github.com/user-attachments/assets/8561e8cd-afc5-40b9-b56e-26e04ff5776b) 

Sau khi hoàn thành ta có sơ đồ sau:
![image](https://github.com/user-attachments/assets/2fdd89c9-ac94-44bd-ac5e-9e40fc681cd0)

# Phần B
Thêm trường phi chuẩn ThoiGianDuKien
![image](https://github.com/user-attachments/assets/03f786d4-5bab-43ca-a179-cbf6b2d17092)  

Logic: Việc thêm trường ThoiGianDuKien giúp lưu trữ thời gian dự kiến để hoàn thành một tuyến xe bus. Mặc dù thời gian này có thể được tính toán dựa trên KhoangCach và vận tốc trung bình (nếu có bảng vận tốc), việc lưu trữ trực tiếp sẽ giúp tăng tốc độ truy vấn khi cần hiển thị thông tin về thời gian di chuyển của tuyến, đặc biệt trong các ứng dụng cần hiển thị nhanh chóng lịch trình hoặc ước tính thời gian đến. Đây là một dạng denormalization có chủ đích để tối ưu hóa hiệu suất đọc dữ liệu.  
Tạo Triggers mới bằng cách bấm vào dấu cộng của bảng TuyenXeBus chọn Triggers chọn new Triggers.  
![image](https://github.com/user-attachments/assets/de1028be-eb01-4379-b96a-c3ba03d371ed) 

Đoạn mã trigger này có mục tiêu tự động cập nhật thời gian dự kiến của một lịch trình xe bus trong bảng nhật ký (NhatKyLichTrinh) mỗi khi có một lịch trình mới được thêm vào (LichTrinhXeBus). Việc tự động hóa này phục vụ việc theo dõi nhanh chóng và chính xác thời gian dự kiến của các chuyến đi mới, hỗ trợ công tác kiểm tra lịch trình, giám sát thời gian hoạt động dự kiến của các tuyến, hoặc có thể được sử dụng trong các bước xử lý tiếp theo như thông báo lịch trình cho hành khách hoặc điều phối xe. Nhờ việc tự động cập nhật, hệ thống quản lý xe bus có thể duy trì dữ liệu thời gian dự kiến một cách nhất quán và giảm thiểu sai sót, đồng thời tăng tốc độ truy vấn khi cần hiển thị hoặc xử lý thông tin liên quan đến thời gian dự kiến của các lịch trình mới.  
![image](https://github.com/user-attachments/assets/131a437f-4a66-43bb-9235-a82a41583c60)  

Nhập dữ liệu có kiểm soát, nhắm để kiểm tra hiệu quả của việc tự động kích hoạt công việc.
![image](https://github.com/user-attachments/assets/e31a7579-d810-43f4-8f57-1aced12c8013)  

# Kiểm tra kết quả
![image](https://github.com/user-attachments/assets/7e6fac75-e828-4189-b6b4-7e92b4c3408c)  

Kết luận về Trigger đã giúp ích gì cho kế hoạch của em.
Trigger TR_ThemLichTrinh giúp:
Đảm bảo tính nhất quán dữ liệu bằng cách tự động ghi lại thông tin thời gian dự kiến.
Tự động hóa quy trình, giảm thao tác thủ công và sai sót.
Tạo cơ sở cho các nghiệp vụ phức tạp như theo dõi lịch sử và thống kê.
Tăng tốc độ truy vấn gián tiếp trong một số trường hợp.
Nhìn chung, trigger đã tự động hóa quản lý dữ liệu, tăng tính nhất quán và tạo tiền đề cho phát triển các chức năng nâng cao trong đồ án.
Việc sử dụng trường phi chuẩn kết hợp với trigger minh họa cho việc tối ưu hóa hiệu suất và quản lý thông tin hiệu quả.













