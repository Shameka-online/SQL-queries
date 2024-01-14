create database customers
;
use customers; 

-- primary key is in main table foreign key has relationship to pk in main table
-- eg primary key cant be null and is unique
-- foreign key recommended
CREATE TABLE customer (
    customer_id INTEGER NOT NULL,
    first_name VARCHAR(55) NOT NULL,
    last_name VARCHAR(55) NULL,
    CONSTRAINT PK_customer PRIMARY KEY (customer_id)
);
-- constraints are another way to write code above 
-- name constraint and say which value contain the constraint
-- adress id is main as this db cant exist without it
CREATE TABLE address (
    address_id INTEGER NOT NULL,
    building_number VARCHAR(55) NOT NULL,
    street VARCHAR(55) NOT NULL,
    city VARCHAR(55),
    postcode VARCHAR(55) NOT NULL,
    country VARCHAR(55),
    CONSTRAINT PK_address PRIMARY KEY (address_id)
);


CREATE TABLE email_address (
    email_address_id INTEGER NOT NULL,
    email_address_customer_id INTEGER,
    email_address VARCHAR(55) NOT NULL,
    CONSTRAINT pk_email_address PRIMARY KEY (email_address_id)
);

CREATE TABLE phone_number (
    phone_number_id INTEGER NOT NULL,
    phone_number_customer_id INTEGER NOT NULL,
    phone_number VARCHAR(55) NOT NULL,
    CONSTRAINT pk_phone_number PRIMARY KEY (phone_number_id)
);

CREATE TABLE orders (
    order_id INTEGER NOT NULL,
    order_customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    CONSTRAINT pk_order_id PRIMARY KEY (order_id)
);

insert into address
(address_id, building_number, street, city, postcode, country)
VALUES
(1, '20', 'Birch Alley', 'London', 'SE24 0AB', 'UK'),
(2, '17', 'Oak Street', 'London', 'SE25 0XY', NULL);

insert into customer 
(customer_id, first_name, last_name)
values
(1,'Jon', 'Flanders'),
(2,'Sam', 'Smith');

insert into email_address 
(email_address_id, email_address_customer_id, email_address)
values
(1, 2, 'ssmith@mail.com'),
(2, 1, 'jon@mail.com');

INSERT INTO phone_number 
(phone_number_id, phone_number_customer_id, phone_number) 
VALUES 
(1, 1, '555-1212'),
(2, 2, '555-3344');
  
  
INSERT INTO orders 
(order_id, order_customer_id, order_date) 
VALUES 
(1, 1, '2019-08-20'),
(2, 2, '2019-03-15');

SELECT * from customer;

/* select * from customer;
select * from phone_number; -- 555-3344
want to get the customer who has this number but comes from a diff table */ 
SELECT
    c.first_name, c.last_name
FROM
    customer c
WHERE
    customer_id IN (SELECT
            phone_number_customer_id
        FROM
            phone_number
        WHERE
            phone_number = '555-3344');
            
            
select * from email_address; -- 'jon@mail.com'

/*finding phone number associated with email*/
SELECT
    ph.phone_number
FROM
   phone_number ph
WHERE
    phone_number_customer_id IN (SELECT
            email_address_customer_id
        FROM
            email_address
        WHERE
            email_address = 'jon@mail.com');
select * from orders;

/*finding first and last name whose order id is 1*/ 
SELECT
    c.first_name, c.last_name
FROM
    customer c
WHERE
    customer_id IN (SELECT
            orders_customer_id
        FROM
            orders
        WHERE
            order_id = '1');


/* constraints prevent things from messing up in table 
stops different anomalies occuring 
keeps table integrated and generic
wont accept certain things */

ALTER TABLE email_address  
ADD  CONSTRAINT 
FK_email_address_customer 
FOREIGN KEY(email_address_customer_id)
REFERENCES customer (customer_id); 

ALTER TABLE phone_number   
ADD  CONSTRAINT FK_phone_number_customer 
FOREIGN KEY(phone_number_customer_id)
REFERENCES customer (customer_id);

-- removes components from db so removes orders 
DROP TABLE orders;