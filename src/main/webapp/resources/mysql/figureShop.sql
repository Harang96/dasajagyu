SELECT * FROM goott351.image;
use goott351;

select * from goott351.order;
desc goott351.order;

select now();

INSERT INTO `goott351`.`order` (`order_no`, `order_time`, `order_status`, `pay_status`, `delivery_date`, `payment_key`, `payment_date`, `order_name`, `customer_id`) VALUES ('0000000001', '2024-02-27 15:19:28', '결제완료', 'null', 'null', 'a90ZoyegEOALnQvDd2VJbJjnlKPAYwVMj7X41mNW5kzKbwG6', '2024-02-27 15:19:28', '토스 티셔츠 외 2건', '14da71c3-d49e-11ee-a3e7-6c2b59a71098');
INSERT INTO `goott351`.`order` (`order_no`, `order_time`, `order_status`, `pay_status`, `delivery_date`, `payment_key`, `payment_date`, `order_name`, `customer_id`) VALUES ('0000000002', '2024-02-27 17:51:15', '입금대기', 'null', 'null', '', '2024-02-27 17:51:15', '토스 티셔츠 외 2건', '14da71c3-d49e-11ee-a3e7-6c2b59a71098');

select * from goott351.customers;

select order_no, order_time, order_status, pay_status, delivery_date, payment_key, payment_date, order_name, customer_id from goott351.order;

use goott351;
select * from goott351.order;

show databases;
use goott351;
select * from ordersordersorders;

select order_no, order_time, order_status, pay_status, delivery_date, payment_key, payment_date, order_name, customer_id from orders;
select * from customers;
desc customers;
-- 650d5114-d5eb-11ee-a3e7-6c2b59a71098

select uuid, email, name, birthday, phone_number, gender, nickname, session_key, user_img, user_point, register_date, is_admin, msg_agree, bank_name, refund_account, addr, addr_postCode, addr_detail, addr_extra from customers;
select * from orders;
desc orders;
select * from order_billing;

select order_no, order_time, order_status, pay_status, delivery_date, payment_key, payment_date, order_name, customer_id, pay_method, pay_account_no from orders;

select uuid, email, name, birthday, phone_number, gender, nickname, session_key, user_img, user_point, register_date, is_admin, msg_agree, bank_name, refund_account, addr, addr_postCode, addr_detail, addr_extra from customers;
select * from customers where uuid = "650d5114-d5eb-11ee-a3e7-6c2b59a71098";
select * from orders where uuid = "650d5114-d5eb-11ee-a3e7-6c2b59a71098";
select * from customers;
select * from orders;
select uuid, email, name, birthday, phone_number, gender, nickname, session_key, user_img, user_point, register_date, is_admin, msg_agree, bank_name, refund_account, addr, addr_postCode, addr_detail, addr_extra from customers where uuid = "650d5114-d5eb-11ee-a3e7-6c2b59a71098";

select * from orders where order_status = "결제완료" order by order_time desc;
select * from orders order by order_time desc limit 0, 3;
select * from orders;
select * from order_products;
select product_name from products where product_no = 42;
-- 0000000006	42	1	39000	N 27300
-- 0000000006	54	1	69000	N 48300
-- 0000000006	57	1	65000	N 45500
select * from order_billing where order_no;

select * from order_billing;
select * from products where product_no = 57;
select order_no, product_amount, product_discount, point_discount, shipping_cost, order_cost, order_point from order_billing;
select * from orders;
select * from orders ;
select c.uuid, c.email, c.name, c.phone_number, c.nickname, c.session_key, c.user_img, c.user_point, bank_name, refund_account from orders o inner join customers c on o.customer_id = c.uuid where order_no = "test-1709535416367";
-- select c.uuid, c.email, c.name, c.phone_number, c.nickname, c.session_key, c.user_img, c.user_point, bank_name, refund_account from orders o inner join customers c on o.customer_id = c.uuid where order_no = #{orderNo};
select * from customers where uuid = "933c255f-d2e5-11ee-a3e7-6c2b59a71098";

use goott351;
select * from orders;
select * from order_products;
select * from products;
-- update order_products set order_cancel = 'Y' where order_no = "0000000006" and product_no = #{productNo}

select * from orders;
select * from order_products where order_cancel = "Y";
select * from order_billing;
select * from order_products;
select * from order_billing;


-- test-1709627807352
select * from order_products where order_no = "test-1709604618124";
select (order_price*quantity) as 취소상품제외금액 from order_products where order_no = "test-1709604618124" and order_cancel = "N";
select * from order_products where order_no = "test-1709604618124";
select * from order_billing where order_no = "test-1709604618124";
-- 73000

-- 수동 롤백
UPDATE `goott351`.`order_billing` SET `product_amount` = '73000', `product_discount` = '3650', `order_cost` = '69350', `order_point` = '693' WHERE (`order_no` = 'test-1709604618124');
UPDATE `goott351`.`order_products` SET `order_cancel` = 'N' WHERE (`order_no` = 'test-1709604618124') and (`product_no` = '13093');
UPDATE `goott351`.`order_products` SET `order_cancel` = 'N' WHERE (`order_no` = 'test-1709604618124') and (`product_no` = '38789');

select * from order_billing where order_no = "test-1709604618124";
select * from order_products where order_no = "test-1709604618124";
select * from order_billing where order_no = "test-1709604618124";
-- 취소 처리 프로세스 2 : order_billing 테이블에서 해당 주문건 update (변경해야하는 사항 : product_amount, product_discount, order_cost, order_point)
update order_billing ob 
inner join order_products op on ob.order_no = op.order_no 
inner join orders od on ob.order_no = od.order_no
set ob.product_amount = ob.product_amount - (select sum(sales_cost) from order_products where order_no = "test-1709604189910" and lower(order_cancel) = "y"),
ob.product_discount = ob.product_discount - (select sum(discount_cost) from order_products where order_no = "test-1709604189910" and lower(order_cancel) = "y"),
ob.order_cost = ob.product_amount - ob.product_discount,
ob.order_point = (ob.order_cost - ob.shipping_cost) * 0.01
where ob.order_no = "test-1709604189910";

/*
update order_billing ob 
inner join order_products op on ob.order_no = op.order_no 
inner join orders od on ob.order_no = od.order_no
set ob.product_amount = ob.product_amount - (select sum(sales_cost) from order_products where order_no = #{order_no} and lower(order_cancel) = "y"),
ob.product_discount = ob.product_discount - (select sum(discount_cost) from order_products where order_no = #{order_no} and lower(order_cancel) = "y"),
ob.order_cost = ob.product_amount - ob.product_discount,
ob.order_point = (ob.order_cost - ob.shipping_cost) * 0.01
where ob.order_no = #{order_no};
*/
select sum(sales_cost) from order_products where order_no = "test-1709604618124" and lower(order_cancel) = "y";
select sum(discount_cost) from order_products where order_no = "test-1709604618124" and lower(order_cancel) = "y";
select * from order_products where order_no = "test-1709604618124" and lower(order_cancel) = "y";
select * from products where product_no = "38789";

select * from order_products;
select * from order_products where order_no = "test-1709604189910";
select * from order_billing where order_no = "test-1709604189910";
select * from order_billing where product_no = 54679;

UPDATE `goott351`.`order_products` SET `sales_cost` = '21000' WHERE (`order_no` = 'test-1709604189910') and (`product_no` = '48577');
UPDATE `goott351`.`order_products` SET `sales_cost` = '48000' WHERE (`order_no` = 'test-1709604189910') and (`product_no` = '53057');
UPDATE `goott351`.`order_products` SET `sales_cost` = '187000' WHERE (`order_no` = 'test-1709604189910') and (`product_no` = '54679');

select * from order_products where order_no = "test-1709775280634";
select * from order_billing where order_no = "test-1709775280634";
select * from products;
desc order_cs_type;
select * from orders where order_no = "test-1709779070326";
select * from order_products where order_no = "test-1709779070326";
select * from order_billing where order_no = "test-1709779070326";

select * from order_products;
select * from order_products where order_cancel = "Y";
select * from orders;
select * from order_products;
select * from order_billing;

-- 테스트 데이터 추가
-- select * from orders; where order_no = "a4CWyWY5m89PNh7xJwhktest40";
INSERT INTO `goott351`.`orders` (`order_no`, `order_time`, `order_status`, `pay_status`, `payment_key`, `payment_date`, `order_name`, `customer_id`, `pay_method`, `pay_account_no`) VALUES ('tviva20240308220627whGw12', now(), '결제완료', '결제완료', '9o5gEq4k6YZ1aOwX7K8m167BBGR0z08yQxzvNPGenpDAlBdb', now(), '고죠 사토루 1/7 외 1개', '97155f0a-dac9-11ee-a3e7-6c2b59a71098', '카드', '140*');

INSERT INTO `goott351`.`order_products` (`order_no`, `product_no`, `quantity`, `order_price`, `discount_cost`, `sales_cost`, `order_cancel`, `original_name`) VALUES ('tviva20240308220627whGw12', '54679', '1', '187000', '0', '187000', 'N', '주술회전');
INSERT INTO `goott351`.`order_products` (`order_no`, `product_no`, `quantity`, `order_price`, `discount_cost`, `sales_cost`, `order_cancel`, `original_name`) VALUES ('tviva20240308220627whGw12', '50366', '1', '224000', '0', '224000', 'N', '주술회전');
INSERT INTO `goott351`.`order_products` (`order_no`, `product_no`, `quantity`, `order_price`, `discount_cost`, `sales_cost`, `order_cancel`, `original_name`) VALUES ('tviva20240308220627whGw12', '16916', '1', '46000', '0', '46000', 'N', '쿠로코의 농구');

INSERT INTO `goott351`.`order_billing` (`order_no`, `product_amount`, `product_discount`, `point_discount`, `shipping_cost`, `order_cost`, `order_point`) VALUES ('tviva20240308220627whGw12', '457000', '0', '0', '0', '457000', '4570');



select * from order_cs;

select * from orders where order_no = "1709915899971";
use goott351;
select current_qty from products;

select * from order_products;
select * from order_billing where order_no = "1710144004258";
select * from order_cs where order_no = '1710144004258';
desc order_cs;

insert into order_cs(reason, is_admin, product_quantity, product_no, cs_type, order_no) values( "재고부족", "Y", 1, 39932, "재고부족", 1710138296241);

select * from order_billing where order_no = "1710144965841";

select sum(sales_cost * quantity) from order_products where order_no = "1710144965841" and lower(order_cancel) = "y";
select * from order_products where order_no = "1710144965841" and lower(order_cancel) = "y";
select sum(discount_cost) from order_products where order_no = "1710144965841" and lower(order_cancel) = "y";

select * from products;
desc products;

select * from orders where order_no = "1710146579880";
select * from order_billing where order_no = "1710147704883";

select count(order_no) from order_products where order_no = "1710148092234" and order_cancel = "Y";
select count(order_no) from order_products where order_no = "1710148092234";
select * from order_billing;
select * from order_products;
-- select sum(sales_cost * quantity) from order_products where order_no = #{order_no} and lower(order_cancel) = "y" and product_no = #{productNo}
select sum(sales_cost * quantity) from order_products where order_no = "1710159178482" and lower(order_cancel) = "y";
select sum(sales_cost * quantity) from order_products where order_no = "1710159178482" and lower(order_cancel) = "y" and product_no = 54018;
select * from order_products where order_no = "1710159178482" and lower(order_cancel) = "y" and product_no = 54018;

select sum(sales_cost * quantity) from order_products where order_no = "1710160629611" and lower(order_cancel) = "y";
select * from order_products where order_no = "1710160629611" and lower(order_cancel) = "y";
select * from order_cs;

desc order_billing;
desc order_products;
select * from order_billing;		
-- select sum(sales_cost * quantity) from order_products where order_no = "1710160629611" and lower(order_cancel) = "y" and product_no = #{productNo};

select sum(sales_cost * quantity) from order_products where order_no = "1710162705470" and product_no = 38414;
select * from order_products where order_no = "1710162705470" and product_no = 38414;

select * from order_billing where order_no = "1710162705470";
update order_billing ob 
inner join order_products op on ob.order_no = op.order_no 
inner join orders od on ob.order_no = od.order_no
set ob.product_amount = ob.product_amount - (select sum(sales_cost * quantity) from order_products where order_no = "1710162705470" and product_no = 38414),
ob.product_discount = ob.product_discount - (select sum(discount_cost) from order_products where order_no = "1710162705470" and product_no = 38414),
ob.order_cost = ob.product_amount - ob.product_discount,
ob.shipping_cost = IF(ob.order_cost &lt; 50000, 3000, 0),
ob.order_point = (ob.order_cost - ob.shipping_cost) * 0.01
where ob.order_no = "1710162705470";

select * from order_billing; 

select count(*) from order_products where order_no = "1710162705470" and order_cancel = lower('n');

select user_point from orders od inner join customers cs on od.customer_id = cs.uuid  where od.order_no = "1710162705470"; 

update customers cs 
inner join order_billing ob on cs.uuid = ob.customer_id 
set cs.user_point = cs.user_point + ob.point_discount 
where uuid = (select customer_id from orders where order_no = ;

select * from orders;
select * from order_billing ;
select * from customers;
select point_discount from order_billing where order_no = "1710162705470"; 

update customers
set user_point = user_point + (select abs(point_discount) from order_billing where order_no = "1710168081732")
where uuid = (select customer_id from orders where order_no = "1710168081732");

select * from orders where order_no = "1710167058033";
select customer_id from orders where order_no = "1710168081732";
select * from customers where uuid = (select customer_id from orders where order_no = "1710168081732");
select point_discount from order_billing where order_no = "1710168081732";

select * from orders where order_no = "1710168300165";
select * from order_billing where order_no = "1710168300165";
select * from order_billing;
select abs(point_discount) from order_billing where order_no = "1710168300165";

select * from customers where email = "asdf";
update customers set user_point = 10000 where email = "asdf";

select user_point from customers where uuid = "933c255f-d2e5-11ee-a3e7-6c2b59a71098";

select * from orders where order_no = "1710172059575";

select * from order_cs;

update customers
set user_point = user_point + (select point_discount from order_billing where order_no = "1710185542310")
where uuid = (select customer_id from orders where order_no = "1710185542310");
select * from customers where uuid = (select customer_id from orders where order_no = "1710185542310"); 
select customer_id from orders where order_no = "1710185542310";

select point_discount from order_billing where order_no = "1710185542310";

select * from orders where order_no = "1710215910453";
select * from order_billing where order_no = "1710221835848";

select * from order_products;
select * from order_billing;

select order_status from orders where order_no = "1710229111310";

select if(order_status = "입금대기" or order_status = "WAITING_FOR_DEPOSIT", true, false) from orders where order_no = "1710297494741";


select * from order_billing where order_no = "1710324895147";

select * from order_billing where order_no = "1710329075091";
select * from order_cs where order_no = "1710329075091";

/*
update order_billing ob 
inner join order_products op on ob.order_no = op.order_no 
inner join orders od on ob.order_no = od.order_no
set ob.product_amount = ob.product_amount - (select sum(sales_cost * quantity) from order_products where order_no = #{order_no} and product_no = #{product_no}),
ob.product_discount = ob.product_discount - (select sum(discount_cost) from order_products where order_no = #{order_no} and product_no = #{product_no}),
ob.order_cost = ob.product_amount - ob.product_discount - ob.point_discount,
ob.shipping_cost = IF(ob.order_cost &lt;= 50000 and (select count(*) from order_products where order_no = #{order_no} and order_cancel = lower('n')) != 0 , 3000, 0),
ob.order_point = (ob.order_cost - ob.shipping_cost) * 0.01, 
ob.point_discount = IF( (select count(*) from order_products where order_no = #{order_no} and order_cancel = lower('n')) != 0 , ob.point_discount, 0)
where ob.order_no = #{order_no};
*/
select sum(sales_cost * quantity) from order_products where order_no = "1710329075091" and product_no = 7180;

select * from products where product_no = 42;
select * from order_billing;
select * from order_products;

select * from order_products where order_no = "1710357355187" and order_cancel = "N";


select * from orders where order_no = "1710415945575";
select * from order_products where order_no = "1710415945575";
select * from order_billing where order_no = "1710415945575";
select * from order_cs where order_no = "1710415945575";
desc order_billing;
-- 1710415945575	411000	20550	5000	0	385450	3854


select count(*) from order_products where order_no = "1710468755350" and order_cancel = "Y";
select count(*) from order_products where order_no = "1710468755350";

select  * from order_billing;


select * from customers;


-- update order_billing set order_point = order_cost
select order_cost * 0.01 from order_billing ;


select * from pointlog where customer_uuid = "933c255f-d2e5-11ee-a3e7-6c2b59a71098";
select * from customers;
-- update customers set user_point = user_point - ${userPoint} where uuid = 
select customer_id from orders where order_no = "1709913287749";

select * from orders where order_no = "1710482710789";
select user_point from customers where uuid = (select customer_id from orders where order_no = "1710482710789");
select * from pointlog where customer_uuid = (select customer_id from orders where order_no = "1710482710789");
select * from order_billing where order_no = "1710482710789";

select * from order_billing;

-- 테스트하기위한 박시험씨 정보 출력
select * from customers where uuid = "933c255f-d2e5-11ee-a3e7-6c2b59a71098";

select * from order_products where order_no = "1709913287749" and product_no = 2761;
select * from products where product_no = 2761;
select product_no from order_products where order_no = "1709913287749";

select * from products where product_no = 2761;
select * from order_products where product_no = 9029;
select * from orders;

select op.order_no, op.quantity, op.order_price, op.discount_cost, op.sales_cost, op.original_name, p.thumbnail_img from order_products op inner join products p on op.product_no = p.product_no where p.product_no = 9029 and op.order_no = "1709913287749";

use goott351;
select * from customers where uuid = "b843de2e-e5d5-11ee-a3e7-6c2b59a71098";
select * from orders where customer_id = (select uuid from customers where uuid = "b843de2e-e5d5-11ee-a3e7-6c2b59a71098") order by order_time desc;

select * from customers where uuid = (select customer_id from orders where order_no = "1709913309312");
select * from order_products where order_no = "1710869864131";

select * from order_cs where order_no = "1710913885815";
select * from customers;
select * from order_cs;

select * from orders; where order_no = "1710921391269";
select * from order_cs where order_no = "1710921391269";
select order_no, product_no, quantity, order_price, discount_cost, sales_cost, order_cancel, original_name from order_products where order_no = 1710902007834 and order_cancel = "N";
select op.order_no, op.product_no, op.quantity, op.order_price, op.discount_cost, op.sales_cost, op.order_cancel, op.original_name, p.thumbnail_img from order_products op inner join products p on op.product_no = p.product_no where op.order_no = 1710902007834 and op.order_cancel = "N";

select * from order_products where order_no = "1710924047391";
select * from order_cs;

update order_cs set  product_quantity = 1 where product_quantity = null;
update order_cs set  prodoct_quantity = 5 where prodoct_quantity = null;

-- UPDATE order_cs SET product_quantity = 1 WHERE product_quantity = 0 AND order_id = {your_order_id};

select * from order_cs;
-- 현재 세션에서만 "safe update mode"를 비활성화
SET SQL_SAFE_UPDATES = 0;

-- update orders set 
select * from orders;

select * from customers where nickname = "하엉";

select * from shipping;
update shipping set zip_code= "07072" where zip_code = 7072;

select * from order_cs where order_no = "1710939073096";
select * from orders where order_no = "1710939073096";
select * from order_products where order_no = "1710939073096";

update orders set order_status = "배송시작", delivery_date = now() where order_no = "1709913287749"; 

select * from orders;

-- select order_status from orders where order_no = #{orderNo};
select * from orders;
update orders set delivery_date = DATE_ADD(order_time, interval 3 day) where order_status = "구매확정" or order_status = "배송완료";
select DATE_ADD(order_time, interval 3 day), IF(UNIX_TIMESTAMP(DATE_ADD(order_time, interval 3 day)) < UNIX_TIMESTAMP(now()), UNIX_TIMESTAMP(DATE_ADD(order_time, interval 3 day)), order_time) as testDate from orders;
select * from products where product_no = 48629;
select * from order_cs where product_no = 48629;
select * from orders od inner join order_billing ob on od.order_no = ob.order_no where order_status = "부분취소" and ob.order_cost > 0;

-- insert into order_cs(reason, is_admin, product_quantity, product_no, cs_type, order_no) values (#{cancelReason}, #{adminYn}, #{quantity}, #{productNo}, #{csType}, #{orderNo})
 -- String String int int String String
insert into order_cs(reason, is_admin, product_quantity, product_no, cs_type, order_no) values ("test", "Y", 1, 48629, "환불", "1710960218878");
desc order_cs;

select cs_date, reason, is_admin, product_quantity, product_no, cs_type, order_no from order_cs;
select * from order_cs where order_no = "1710966510618";

select * from order_cs where order_no = "1710966510618";
select * from order_billing where order_no = "1711319532881";

select * from products;
select * from order_products where order_no = "1711319532881";

select * from products where product_no = 2761;

select * from order_cs where order_no = "1711347428836";
select * from order_cs;

select * from shipping where order_no = "1711319532881";

select * from order_cs where order_no = "1711319532881";
select * from orders where order_no = "1711319532881";

select * from order_products;
-- 1711368023767	18753	1	10450	550	11000	N	톰과 제리	N
select * from orders where order_no = "1711368023767";
select * from order_products where order_no = "1711368023767";
select * from order_cs where order_no = "1711368023767";
select * from shipping where order_no = "1711368023767";
select * from order_billing where order_no = "1711368023767";

select cs_date, reason, is_admin, product_quantity, product_no, cs_type, order_no, reason_type, cs_processed
from order_cs where order_no = "1711352019285" and cs_processed is null or cs_processed != "Y" ;


select op.order_no, op.product_no, op.quantity, op.order_price, op.discount_cost, op.sales_cost, op.order_cancel, op.original_name, p.thumbnail_img 
from order_products op 
inner join products p on op.product_no = p.product_no 
where op.order_no = "1711352019285" and op.order_cancel = "N";

select * from order_billing where order_no = "1711441783218"; 
select * from order_cs where order_no = "1711441783218";
select * from order_products where order_no = "1711441783218";

select cs_no, cs_date, reason, is_admin, product_quantity, product_no, cs_type, order_no, reason_type, cs_processed
from order_cs 
where order_no = "1711359930338" and (cs_processed is null or cs_processed != "Y");

select cs_no, cs_date, reason, is_admin, product_quantity, product_no, cs_type, order_no, reason_type, cs_processed
from order_cs 
where order_no = "1711359930338" and (cs_processed is null or cs_processed != "Y") ;

-- select * from shipping where order_no = #{orderNo};

select img_no, base64 from image where cs_no = "1711308030660";
select * from image where cs_order_no = "618";	

select * from order_cs; where cs_no = "2147483647";
select * from orders ;where order_no = "1709913324575";