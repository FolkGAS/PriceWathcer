DROP TABLE IF EXISTS costs;
DROP TABLE IF EXISTS goods;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS global_seq;

CREATE SEQUENCE global_seq START 100000;

CREATE TABLE users
(
  id        INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  name      VARCHAR NOT NULL,
  email     VARCHAR NOT NULL,
  password  VARCHAR NOT NULL,
  date_time TIMESTAMP           DEFAULT now(),
  enabled   BOOL                DEFAULT TRUE
);
CREATE UNIQUE INDEX users_unique_email_idx
  ON users (email);

CREATE TABLE user_roles
(
  user_id INTEGER NOT NULL,
  role    VARCHAR,
  CONSTRAINT user_roles_idx UNIQUE (user_id, role),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);
CREATE TABLE goods
(
  id            INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  user_id       INTEGER,
  name          VARCHAR,
  description   VARCHAR,
  url           VARCHAR,
  in_url_name   VARCHAR,
  in_url_cost   VARCHAR,
  date_time     TIMESTAMP           DEFAULT now(),
  route_indexes VARCHAR,
  route_tags    VARCHAR,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);
CREATE TABLE costs
(
  id        INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  goods_id  INTEGER,
  date_time TIMESTAMP           DEFAULT now(),
  cost      INTEGER,
  FOREIGN KEY (goods_id) REFERENCES goods (id) ON DELETE CASCADE
);