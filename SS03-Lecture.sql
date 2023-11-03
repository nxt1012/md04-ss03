# tạo một db quản lý đơn hàng, bao gồm các bảng sau:
# bảng order chứa các thông tin: order_id, product_id, quantity, order_date
# bảng product chứa các thông tin: product_id, price, product_name
# thực hiện thêm mới data vào bảng
# thực hiện các truy vấn sau
# - lấy ra thông tin đơn hàng bao gồm: order_id, product_name, quantity, total_money
# - lọc ra những đơn hàng có tổng tiền > 100
# - lấy ra các đơn hàng có chứa 1 từ khóa tìm kiếm truyền vào
drop database if exists order_management;
create database order_management;
use order_management;
create table products
(
product_id int auto_increment primary key,
price float not null,
product_name varchar(50) not null
);
create table orders
(
order_id int auto_increment primary key,
product_id int,
foreign key (product_id) references products(product_id),
quantity int not null,
order_date date not null
);
insert into products (price, product_name) values
(15.0, 'bánh bao'),
(20.0, 'bánh rán'),
(25.0, 'sủi cảo');
insert into orders (product_id, quantity, order_date) values
(3, 10, '2023-10-31'),
(1, 3, '2023-11-01'),
(2, 5, '2023-11-02');
# queries
# - lấy ra thông tin đơn hàng bao gồm: order_id, product_name, quantity, total_money
select o.order_id, p.product_name, o.quantity, (p.price * o.quantity) as total_money
from products p
join orders o
where p.product_id = o.product_id;
# - lọc ra những đơn hàng có tổng tiền > 100
select o.order_id, p.product_name, o.quantity, (p.price * o.quantity) as total_money
from products p
join orders o
where p.product_id = o.product_id and (p.price * o.quantity)  > 100;
# - lấy ra các đơn hàng có chứa 1 từ khóa tìm kiếm truyền vào
select o.order_id, p.product_name, 'bánh%' as search_term
from products p
join orders o
where p.product_id = o.product_id and p.product_name like 'bánh%';