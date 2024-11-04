CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE eq_users
(
    id INTEGER PRIMARY KEY,
    login VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    firstname VARCHAR(255),
    lastname VARCHAR(255)
);

CREATE TABLE eq_account
(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    eq_id INTEGER,
    login VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE eq_personal_info
(
    id uuid PRIMARY KEY,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    FOREIGN KEY (id) REFERENCES eq_account(id)
);