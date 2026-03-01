-- -- Проверить уникальность почты пользователя
-- CREATE OR REPLACE FUNCTION check_unique_email()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     IF (SELECT COUNT(*)
--         FROM users
--         WHERE email = NEW.email AND id != NEW.id) > 0
--     THEN
--         RAISE EXCEPTION 'Пользователь с такой электронной почтой уже существует';
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;
--
-- CREATE TRIGGER check_unique_email_trigger
-- BEFORE INSERT ON users
-- FOR EACH ROW
-- EXECUTE FUNCTION check_unique_email();
--
-- -- Проставить дату закрытия бронирования
-- CREATE OR REPLACE FUNCTION set_booking_end_date()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     IF NEW.status = 'DONE' AND OLD.status != 'DONE' THEN
--         NEW.end_date = CURRENT_TIMESTAMP;
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;
--
-- CREATE OR REPLACE TRIGGER set_booking_end_date_trigger
-- BEFORE UPDATE ON bookings
-- FOR EACH ROW
-- EXECUTE FUNCTION set_booking_end_date();
--
-- -- Проверить, что пользователь (владелец), который выкладывает вещь для проката, добавил паспорт
-- CREATE OR REPLACE FUNCTION check_owner_passport()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     IF (SELECT passport_id
--         FROM users
--         WHERE id = NEW.owner_id) IS NULL THEN
--         RAISE EXCEPTION 'Вам нужно добавить паспортные данные для выполнения данного действия';
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;
--
-- CREATE TRIGGER check_owner_passport_trigger
-- BEFORE INSERT ON items
-- FOR EACH ROW
-- EXECUTE FUNCTION check_owner_passport();
--
--
-- -- Проверить, что пользователь, который хочет взять на прокат вещь, добавил паспорт
-- CREATE OR REPLACE FUNCTION check_user_passport()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     IF (SELECT passport_id
--         FROM users
--         WHERE id = NEW.user_id) IS NULL THEN
--         RAISE EXCEPTION 'Вам нужно добавить паспортные данные для выполнения данного действия';
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;
--
-- CREATE TRIGGER check_user_passport_trigger
-- BEFORE INSERT ON bookings
-- FOR EACH ROW
-- EXECUTE FUNCTION check_user_passport();
--
-- -- Проверить что пользователь завершил бронирование (только после этого он может оставить отзыв)
-- CREATE OR REPLACE FUNCTION check_booking_done()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     IF NOT EXISTS (SELECT status FROM bookings WHERE id = NEW.booking_id AND status = 'DONE') THEN
--         RAISE EXCEPTION 'Требуется завершить бронирование перед тем как оставлять отзыв';
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;
--
-- CREATE TRIGGER check_booking_done_trigger
-- BEFORE INSERT ON bookings
-- FOR EACH ROW
-- EXECUTE FUNCTION check_booking_done();


-- Проверить уникальность почты пользователя
CREATE OR REPLACE FUNCTION set_booking_status_for_item()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.status = 'APPROVED';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_booking_status_for_item_trigger
    BEFORE INSERT ON items
    FOR EACH ROW
EXECUTE FUNCTION set_booking_status_for_item();


-- Изменить статус бронирования если бронирование закончилось
CREATE OR REPLACE FUNCTION set_booking_status_done_for_item()
    RETURNS TRIGGER AS $$
BEGIN

    NEW.status = 'DONE';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_booking_status_for_item_trigger
    BEFORE INSERT ON items
    FOR EACH ROW
EXECUTE FUNCTION set_booking_status_done_for_item();
