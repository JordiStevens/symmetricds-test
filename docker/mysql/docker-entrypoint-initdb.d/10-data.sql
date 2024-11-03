CREATE TABLE eq_users
(
    id INTEGER PRIMARY KEY,
    login VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    firstname VARCHAR(255),
    lastname VARCHAR(255)
);

INSERT INTO eq_users
VALUES
    (1, 'admin', 'admin@test.com', 'ad', 'min'),
    (2, 'respo1', 'respo1@test.com', 'res', 'po1'),
    (3, 'respo2', 'respo2@test.com', 'res', 'po2'),
    (4, 'respo3', 'respo3@test.com', 'res', 'po3'),
    (5, 'respo4', 'respo4@test.com', 'res', 'po4'),
    (6, 'respo5', 'respo5@test.com', 'res', 'po5')