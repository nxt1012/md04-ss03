drop database if exists QuanLyBanHang;
create database QuanLyBanHang;
use QuanLyBanHang;
create table Customer (
cID int primary key auto_increment,
cName varchar(50),
cAge int
);
-- có thể có nhiều hóa đơn cho mỗi khách - mqh n-1
create table `Order` (
oID int primary key auto_increment,
cID int,
oDate date,
oTotalPrice float default null,
foreign key (cID) references Customer(cID)
);

create table OrderDetail (
oID int,
pID int,
odQTY int
);
create table Product (
pID int primary key auto_increment,
pName varchar(50),
pPrice float);
-- mỗi hóa đơn có thể có nhiều mặt hàng => mqh Order - OrderDetail là mqh 1-n
alter table OrderDetail
add constraint fk_order_id foreign key (oID) references `Order`(oID);
-- mỗi mặt hàng trong hóa đơn có thể được mua với số lượng nhiều hơn 1 => mqh Product - OrderDetail là 1-n
alter table OrderDetail
add constraint fk_product_id foreign key (pID) references Product(pID);

alter table OrderDetail
add constraint pk_product_id foreign key (pID) references Product(pID);
-- Thêm dữ liệu vào
insert into Customer(cName, cAge) values
('Minh Quan', 10),
('Ngoc Oanh', 20),
('Hong Ha', 50)
;
insert into `Order`(oID, cID, oDate) values
(1, 1, '2006/03/21'),
(2, 2, '2006/03/23'),
(3, 1, '2006/03/16');
insert into Product(pID, pName, pPrice) values
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);
insert into OrderDetail(oID, pID, odQTY) values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

-- Truy vấn
-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT c.cID, c.cName, GROUP_CONCAT(p.pName ORDER BY p.pName ASC) AS PurchasedProducts
FROM Customer AS c
LEFT JOIN `Order` AS o ON c.cID = o.cID
LEFT JOIN OrderDetail AS od ON o.oID = od.oID
LEFT JOIN Product AS p ON od.pID = p.pID
GROUP BY c.cID, c.cName;
-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT c.cID, c.cName
FROM Customer AS c
LEFT JOIN `Order` AS o ON c.cID = o.cID
WHERE o.oID IS NULL;
-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT o.oID, o.oDate, SUM(od.odQTY * p.pPrice) AS oTotalPrice
FROM `Order` AS o
JOIN OrderDetail AS od ON o.oID = od.oID
JOIN Product AS p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;
# Review code