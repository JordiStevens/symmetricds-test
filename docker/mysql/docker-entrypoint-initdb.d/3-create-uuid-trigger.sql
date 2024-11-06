DROP TRIGGER IF EXISTS before_insert_eq_users;
DELIMITER $$
CREATE TRIGGER before_insert_eq_users
    BEFORE INSERT ON eq_users FOR EACH ROW
BEGIN
    IF new.GUID IS NULL
    THEN
        SET new.GUID = uuid_v4s();
    END IF;
END $$
DELIMITER ;