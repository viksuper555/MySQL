CREATE TABLE cities (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  name        VARCHAR(20) NOT NULL,
  country_code CHAR(2)      NOT NULL
);

CREATE TABLE hotels (
  id            INT PRIMARY KEY AUTO_INCREMENT,
  name          VARCHAR(30)   NOT NULL,
  city_id        INT            NOT NULL,
  employee_count INT            NOT NULL,
  base_rate      DECIMAL(15, 2) NOT NULL,
  CONSTRAINT fk_hotels_cities FOREIGN KEY (city_id) REFERENCES cities (id)
);

CREATE TABLE rooms (
  id      INT PRIMARY KEY AUTO_INCREMENT,
  price   DECIMAL(15, 2) NOT NULL,
  type    VARCHAR(20)   NOT NULL,
  beds    INT            NOT NULL,
  hotel_id INT            NOT NULL,
  CONSTRAINT fk_rooms_hotels FOREIGN KEY (hotel_id) REFERENCES hotels (id)
);

CREATE TABLE trips (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  room_id      INT  NOT NULL,
  book_date    DATE NOT NULL,
  arrival_date DATE NOT NULL,
  return_date  DATE NOT NULL,
  cancel_date  DATE,
  CONSTRAINT fk_trips_rooms FOREIGN KEY (room_id) REFERENCES rooms (id)
);

CREATE TABLE accounts (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  first_name  VARCHAR(50) NOT NULL,
  middle_name VARCHAR(20),
  last_name   VARCHAR(50) NOT NULL,
  city_id     INT          NOT NULL,
  birth_date  DATE         NOT NULL,
  email      VARCHAR(100) NOT NULL,
  CONSTRAINT fk_accounts_cities FOREIGN KEY (city_id) REFERENCES cities (id),
  CONSTRAINT uq_email UNIQUE (email)
);

CREATE TABLE accounts_trips (
  account_id INT NOT NULL,
  trip_id    INT NOT NULL,
  luggage   INT NOT NULL,
  CONSTRAINT pk_accounts_trips PRIMARY KEY (account_id, trip_id),
  CONSTRAINT fk_accounts_trips_accounts FOREIGN KEY (account_id) REFERENCES accounts (id),
  CONSTRAINT fk_accounts_trips_trips FOREIGN KEY (trip_id) REFERENCES trips (id)
);