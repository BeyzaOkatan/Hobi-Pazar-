DROP TABLE IF EXISTS purchased_items CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS item_categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
	name varchar(50),
	phone_number varchar(10),
	email varchar(320),
	age int not null,
	address varchar(100),
	username varchar(20) not null unique,
	password varchar(64) not null,	
	num_purchased_items int,
	balance int not null,
	primary key (username),
	check(age >= 18)
);

CREATE TABLE item_categories(
	item_category_id int not null unique,
	item_category_name varchar(15)
);
CREATE SEQUENCE item_id_generator
AS int
START 0
INCREMENT 1
MINVALUE 0
MAXVALUE 1000000
NO CYCLE;

CREATE TABLE items (
	item_id int DEFAULT nextval('item_id_generator') not null unique,
	item_price int not null,
	item_sellcount int not null,
	item_name varchar(30) not null,
	item_category_id int not null,
	item_description varchar(200),
	item_seller varchar(20) not null,
	item_image_path varchar(50),
	primary key (item_id),
	foreign key (item_category_id) references item_categories(item_category_id),
	foreign key (item_seller) references users(username),
	check(item_price > 0),
	constraint CHK_item_price CHECK (item_price < 256)
);

CREATE TABLE purchased_items (
	purchased_item_id int not null,
	buyer_username varchar(20) not null,
	foreign key (buyer_username) references users(username),
	foreign key (purchased_item_id) references items(item_id)
);




INSERT INTO users VALUES ('John Doe', '1234567890', 'john.doe@example.com', 25, '123 Main St', 'john_doe', 'password123', 0, 1000);
INSERT INTO users VALUES ('Jane Smith', '9876543210', 'jane.smith@example.com', 30, '456 Oak St', 'jane_smith', 'securepass', 0, 1500);
INSERT INTO users VALUES ('Alice Johnson', '5555555555', 'alice.j@example.com', 22, '789 Pine St', 'alice_j', 'mypassword', 0, 1200);
INSERT INTO users VALUES ('Bob Brown', '1112223333', 'bob.b@example.com', 35, '101 Maple St', 'bob_brown', 'bobs_secure_pass', 0, 2000);
INSERT INTO users VALUES ('Eva White', '4445556666', 'eva.w@example.com', 28, '202 Elm St', 'eva_white', 'evapass123', 0, 1800);
INSERT INTO users VALUES ('Chris Lee', '7778889999', 'chris.l@example.com', 40, '303 Oak St', 'chris_lee', 'chrispass', 0, 1600);
INSERT INTO users VALUES ('Grace Turner', '6667778888', 'grace.t@example.com', 26, '404 Pine St', 'grace_turner', 'gracepass456', 0, 1400);
INSERT INTO users VALUES ('David Miller', '3334445555', 'david.m@example.com', 32, '505 Maple St', 'david_miller', 'davidpass789', 0, 1700);
INSERT INTO users VALUES ('Sophie Wilson', '9990001111', 'sophie.w@example.com', 23, '606 Elm St', 'sophie_wilson', 'sophiepass', 0, 1900);
INSERT INTO users VALUES ('Michael Davis', '1212121212', 'michael.d@example.com', 29, '707 Oak St', 'michael_davis', 'michaelpass', 0, 2200);

INSERT INTO item_categories (item_category_id, item_category_name)
VALUES
(0, 'Cleaning'),
(1, 'Accessories'),
(2, 'Home Decoration'),
(3, 'Beauty'),
(4, 'Toys'),
(5, 'Clothing'),
(6, 'Electronics'),
(7, 'Sports'),
(8, 'Books'),
(9, 'Food');


insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values ( 100, 0, 'Handmade Soap', 0, 'A soap with lemon aroma. You are gonna feel the real cleanity', 'john_doe','assets/images/soap.png');
insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values (120, 1, 'Handmade Bracelet',1,  'A luck bracelet to use in daily. It is believed to removed bad luck', 'john_doe','assets/images/bracelet.png');
insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values ( 120, 3, 'Handmade Mask', 1, 'A cool mask for your elegant parties. You are gonna be the most secret person in the party', 'jane_smith','assets/images/handmade_mask.png');
insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values ( 130, 1, 'Handmade Flower Pot', 2, 'A decorative flower pot for your lovely flowers. It will look great in your garden', 'jane_smith','assets/images/handmade_flower_pot.png');
insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values ( 145, 1,'Handmade Basket', 2, 'A convenient and lightweight basket to use in shopping.', 'michael_davis','assets/images/handmade_basket.png');
insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values ( 91, 1, 'Handmade Soap', 0, 'A soap with orange aroma. You are gonna feel the real cleanity', 'sophie_wilson','assets/images/soap.png');
insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values ( 192, 0, 'Handmade Basket',2,  'A convenient and lightweight basket to use in shopping.', 'grace_turner','assets/images/handmade_basket.png');
insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values ( 220, 1, 'Handmade Bag',1,'So sweet and stylish bag for daily using. It is gonna suit your combine very well', 'grace_turner','assets/images/pink_bag.png');
insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values ( 150, 1, 'Handmade Bag',1,  'So stylish. It is gonna suit your combine very well', 'chris_lee','assets/images/pink_bag.png');
insert into items (item_price,item_sellcount,item_name,item_category_id,item_description,item_seller,item_image_path)values ( 130, 1,'Handmade Flower Pot', 2,'A decorative flower pot for your lovely flowers. It will look great in your garden', 'chris_lee','assets/images/handmade_flower_pot.png');

INSERT INTO purchased_items (purchased_item_id, buyer_username)
VALUES
(1, 'jane_smith'),
(2, 'john_doe'),
(3, 'alice_j'),
(2, 'bob_brown'),
(2, 'eva_white'),
(4, 'chris_lee'),
(7, 'grace_turner'),
(8, 'david_miller'),
(9, 'sophie_wilson'),
(5, 'michael_davis');

CREATE VIEW get_best_sellings AS
SELECT *
FROM items
WHERE (item_seller, item_sellcount) IN (
  SELECT item_seller, MAX(item_sellcount) AS max_sellcount
  FROM items
  WHERE item_sellcount > 0
  GROUP BY item_seller
)
ORDER BY item_sellcount DESC;

-- function 1, used for trigger
 CREATE OR REPLACE FUNCTION default_item_description()
  RETURNS TRIGGER AS $$
BEGIN
	IF NEW.item_description='' THEN
	NEW.item_description := 'default_item_description';
	END IF; 

	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

-- trigger 1
CREATE TRIGGER default_item_description
  BEFORE INSERT
  ON items
  FOR EACH ROW EXECUTE PROCEDURE default_item_description();

  -- function 0, used for trigger
CREATE OR REPLACE FUNCTION process_transaction()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.balance < OLD.balance THEN
		UPDATE users SET num_purchased_items = num_purchased_items + 1 WHERE username = NEW.username;
	END IF;

	RETURN NEW;
END;
$$;

-- trigger 0
CREATE OR REPLACE TRIGGER process_transaction
  AFTER UPDATE
  ON users 
  FOR EACH ROW
  EXECUTE PROCEDURE process_transaction();

CREATE OR REPLACE FUNCTION userExist(username varchar(50))
RETURNS INT
LANGUAGE PLPGSQL
AS
$$
DECLARE
    user_exists INT := 0;
BEGIN
    SELECT 1 INTO user_exists
    FROM users
    WHERE username = userExist.username
    LIMIT 1;

    RETURN user_exists;
END;
$$;

  
CREATE OR REPLACE FUNCTION get_max_sold_item_id(username varchar(50))
RETURNS INT
LANGUAGE PLPGSQL
AS
$$
DECLARE
	-- declare record var here
	max_sold_item_id int;
	rec record;
	cur cursor
		for select *
		from items where item_seller = username;
BEGIN
	open cur;
	loop
		fetch cur into rec;
		exit when not found;

		if rec.item_sellcount > max_sold_item_id then
			max_sold_item_id = rec.item_sellcount;
		end if;

	end loop;

	RETURN max_sold_item_id;
END;
$$;