-- Функции и процедуры

-- Добавление вещи, которой готов поделиться пользователь
CREATE PROCEDURE add_new_item(
    item_name VARCHAR(100),
    item_description TEXT,
    item_owner_id INTEGER)
LANGUAGE SQL
BEGIN ATOMIC
    INSERT INTO items (name, description, owner_id, status)
    VALUES (item_name, item_description, item_owner_id, 'AVAILABLE');
END;

-- Добавление вещи, в вишлист
-- CREATE PROCEDURE add_item_to_wishlist(
--     item_id INTEGER,
--     item_name VARCHAR(100),
--     item_description TEXT,
--     item_user_id INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO wishlists (id, name, description, status)
--     VALUES (item_id, item_name, item_description, 'ACTIVE');
--
--     INSERT INTO users_wishlists (user_id, wishlist_id)
--     VALUES (item_user_id, item_id);
-- END;

-- -- Добавление категарии для вещи в вишлисте
-- CREATE PROCEDURE add_category_to_item_wishlist(
--     category VARCHAR(100),
--     item_id_in_wishlist INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO wishlist_categories (wishlist_id, category_id)
--     VALUES (item_id_in_wishlist, (SELECT id FROM categories WHERE categories.category_name = category));
-- END;

-- Добавление категарии для вещи
-- CREATE PROCEDURE add_category_to_item(
--     category VARCHAR(100),
--     item INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO item_categories (item_id, category_id)
--     VALUES (item, (SELECT id FROM categories WHERE categories.category_name = category));
-- END;


-- Добавление предпочитаемой пользователем категории
-- CREATE PROCEDURE add_user_preference(
--     category VARCHAR(100),
--     user_id_preference INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO preferences (user_id, category_id)
--     VALUES (user_id_preference, (SELECT id FROM categories WHERE categories.category_name = category));
-- END;

-- Бронирование вещи
CREATE PROCEDURE book_item(
    user_booking INTEGER,
    item INTEGER)
LANGUAGE SQL
BEGIN ATOMIC
    INSERT INTO bookings (user_id, start_date, status)
    VALUES (user_booking, CURRENT_TIMESTAMP, 'BOOKED');

    INSERT INTO booked_items (item_id, booking_id)
    VALUES (item, booking);
END;

-- Подтвердить бронирование вещи
-- CREATE PROCEDURE confirm_booking(
--     booking INTEGER,
--     item INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     UPDATE bookings
--     SET status = 'APPROVED'
--     WHERE id = booking;
--
--     UPDATE items
--     SET status = 'BOOKED'
--     WHERE id = item;
-- END;

-- Отклонить бронирование вещи
-- CREATE PROCEDURE reject_booking(
--     booking INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     UPDATE bookings
--     SET status = 'REJECTED'
--     WHERE id = booking;
-- END;

-- Завершить бронирование вещи
CREATE PROCEDURE end_booking(
    booking INTEGER,
    item INTEGER)
LANGUAGE SQL
BEGIN ATOMIC
    UPDATE bookings
    SET status = 'DONE'
    WHERE id = booking;

    UPDATE items
    SET status = 'AVAILABLE'
    WHERE id = item;
END;

-- Оставить отзыв на бронирование
-- CREATE PROCEDURE give_feedback(
--     feedback INTEGER,
--     feedback_title VARCHAR(100),
--     feedback_description TEXT,
--     rating INTEGER,
--     booking INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO feedbacks (id, title, description, date, rate)
--     VALUES (feedback, feedback_title, feedback_description, CURRENT_TIMESTAMP, rating);
--
--     INSERT INTO booking_feedbacks (booking_id, feedback_id)
--     VALUES (booking, feedback);
-- END;

-- Добавить нового пользователя
-- CREATE PROCEDURE add_new_user(
--     user_id INTEGER,
--     username_v VARCHAR(100),
--     surname_v VARCHAR(100),
--     name_v VARCHAR(100),
--     patronymic_v VARCHAR(100),
--     email_v VARCHAR(100),
--     phone_number_v VARCHAR(100),
--     sex_v sex)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO users (id, username, surname, name, patronymic, email, phone_number, sex)
--     VALUES (user_id, username_v, surname_v, name_v, patronymic_v, email_v, phone_number_v, sex_v);
-- END;

-- Добавить паспорт
-- CREATE PROCEDURE add_passport(
--     pas_id INTEGER,
--     series_v VARCHAR(4),
--     number_v VARCHAR(6),
--     division_code_v VARCHAR(7),
--     date_of_issue_v TIMESTAMP,
--     issued_by_v VARCHAR(255),
--     date_of_birth_v TIMESTAMP,
--     user_v INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO passports (id, series, number, division_code, date_of_issue, issued_by, date_of_birth)
--     VALUES (pas_id, series_v, number_v, division_code_v, date_of_issue_v, issued_by_v, date_of_birth_v);
--
--     UPDATE users
--     SET passport_id = pas_id
--     WHERE id = user_v;
-- END;-- Функции и процедуры

-- Добавление вещи, которой готов поделиться пользователь
-- CREATE PROCEDURE add_new_item(
--     item_id INTEGER,
--     item_name VARCHAR(100),
--     item_description TEXT,
--     item_owner_id INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO items (id, name, description, owner_id, status)
--     VALUES (item_id, item_name, item_description, item_owner_id, 'AVAILABLE');
-- END;

-- Добавление вещи, в вишлист
-- CREATE PROCEDURE add_item_to_wishlist(
--     item_id INTEGER,
--     item_name VARCHAR(100),
--     item_description TEXT,
--     item_user_id INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO wishlists (id, name, description, status)
--     VALUES (item_id, item_name, item_description, 'ACTIVE');
--
--     INSERT INTO users_wishlists (user_id, wishlist_id)
--     VALUES (item_user_id, item_id);
-- END;

-- Добавление категарии для вещи в вишлисте
-- CREATE PROCEDURE add_category_to_item_wishlist(
--     category VARCHAR(100),
--     item_id_in_wishlist INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO wishlist_categories (wishlist_id, category_id)
--     VALUES (item_id_in_wishlist, (SELECT id FROM categories WHERE categories.category_name = category));
-- END;
--
-- -- Добавление категарии для вещи
-- CREATE PROCEDURE add_category_to_item(
--     category VARCHAR(100),
--     item INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO item_categories (item_id, category_id)
--     VALUES (item, (SELECT id FROM categories WHERE categories.category_name = category));
-- END;
--
--
-- -- Добавление предпочитаемой пользователем категории
-- CREATE PROCEDURE add_user_preference(
--     category VARCHAR(100),
--     user_id_preference INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO preferences (user_id, category_id)
--     VALUES (user_id_preference, (SELECT id FROM categories WHERE categories.category_name = category));
-- END;
--
-- -- Бронирование вещи
-- CREATE PROCEDURE book_item(
--     booking INTEGER,
--     user_booking INTEGER,
--     item INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO bookings (id, user_id, start_date, status)
--     VALUES (booking, user_booking, CURRENT_TIMESTAMP, 'WAITING_FOR_CONFIRMATION');
--
--     INSERT INTO booked_items (item_id, booking_id)
--     VALUES (item, booking);
-- END;
--
-- -- Подтвердить бронирование вещи
-- CREATE PROCEDURE confirm_booking(
--     booking INTEGER,
--     item INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     UPDATE bookings
--     SET status = 'APPROVED'
--     WHERE id = booking;
--
--     UPDATE items
--     SET status = 'BOOKED'
--     WHERE id = item;
-- END;
--
-- -- Отклонить бронирование вещи
-- CREATE PROCEDURE reject_booking(
--     booking INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     UPDATE bookings
--     SET status = 'REJECTED'
--     WHERE id = booking;
-- END;
--
-- -- Завершить бронирование вещи
-- CREATE PROCEDURE end_booking(
--     booking INTEGER,
--     item INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     UPDATE bookings
--     SET status = 'DONE'
--     WHERE id = booking;
--
--     UPDATE items
--     SET status = 'AVAILABLE'
--     WHERE id = item;
-- END;
--
-- -- Оставить отзыв на бронирование
-- CREATE PROCEDURE give_feedback(
--     feedback INTEGER,
--     feedback_title VARCHAR(100),
--     feedback_description TEXT,
--     rating INTEGER,
--     booking INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO feedbacks (id, title, description, date, rate)
--     VALUES (feedback, feedback_title, feedback_description, CURRENT_TIMESTAMP, rating);
--
--     INSERT INTO booking_feedbacks (booking_id, feedback_id)
--     VALUES (booking, feedback);
-- END;
--
-- -- Добавить нового пользователя
-- CREATE PROCEDURE add_new_user(
--     user_id INTEGER,
--     username_v VARCHAR(100),
--     surname_v VARCHAR(100),
--     name_v VARCHAR(100),
--     patronymic_v VARCHAR(100),
--     email_v VARCHAR(100),
--     phone_number_v VARCHAR(100),
--     sex_v sex)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO users (id, username, surname, name, patronymic, email, phone_number, sex)
--     VALUES (user_id, username_v, surname_v, name_v, patronymic_v, email_v, phone_number_v, sex_v);
-- END;
--
-- -- Добавить паспорт
-- CREATE PROCEDURE add_passport(
--     pas_id INTEGER,
--     series_v VARCHAR(4),
--     number_v VARCHAR(6),
--     division_code_v VARCHAR(7),
--     date_of_issue_v TIMESTAMP,
--     issued_by_v VARCHAR(255),
--     date_of_birth_v TIMESTAMP,
--     user_v INTEGER)
-- LANGUAGE SQL
-- BEGIN ATOMIC
--     INSERT INTO passports (id, series, number, division_code, date_of_issue, issued_by, date_of_birth)
--     VALUES (pas_id, series_v, number_v, division_code_v, date_of_issue_v, issued_by_v, date_of_birth_v);
--
--     UPDATE users
--     SET passport_id = pas_id
--     WHERE id = user_v;
-- END;
--
-- -- Вывести список всех доступных для бронирования вещей
CREATE OR REPLACE FUNCTION get_available_items()
RETURNS TABLE (
    id INTEGER,
    name VARCHAR(100),
    description TEXT,
    status VARCHAR(100)
) AS $$
BEGIN
    RETURN QUERY
    SELECT i.id, i.name, i.description, i.status
    FROM items AS i
    WHERE i.status = 'AVAILABLE';
END;
$$ LANGUAGE plpgsql;
--
-- -- Вывести все бронирования пользователя
-- CREATE OR REPLACE FUNCTION get_user_bookings(id_v INTEGER)
-- RETURNS TABLE (
--     id INTEGER,
--     name VARCHAR(100),
--     start_date TIMESTAMP,
--     end_date TIMESTAMP,
--     status booking_status
-- ) AS $$
-- BEGIN
--     RETURN QUERY
--     SELECT b.id, i.name, b.start_date, b.end_date, b.status
--     FROM bookings b
--     JOIN booked_items bi ON b.id = bi.booking_id
--     JOIN items i ON bi.item_id = i.id
--     WHERE b.user_id = id_v;
-- END;
-- $$ LANGUAGE plpgsql;
--
-- -- Вывести все бронирования владельца
-- CREATE OR REPLACE FUNCTION get_owner_bookings(id_v INTEGER)
-- RETURNS TABLE (
--     id INTEGER,
--     name VARCHAR(100),
--     start_date TIMESTAMP,
--     end_date TIMESTAMP,
--     status booking_status
-- ) AS $$
-- BEGIN
--     RETURN QUERY
--     SELECT b.id, i.name, b.start_date, b.end_date, b.status
--     FROM bookings b
--     JOIN booked_items bi ON b.id = bi.booking_id
--     JOIN items i ON bi.item_id = i.id
--     WHERE i.owner_id = id_v;
-- END;
-- $$ LANGUAGE plpgsql;
--
-- -- Вывести все отзывы о вещи
-- CREATE OR REPLACE FUNCTION get_item_feedback(item_id_v INTEGER)
-- RETURNS TABLE (
--     id INTEGER,
--     name VARCHAR(100),
--     title VARCHAR(100),
--     description TEXT,
--     date TIMESTAMP,
--     rate INTEGER
-- ) AS $$
-- BEGIN
--     RETURN QUERY
--     SELECT i.id, i.name, f.title, f.description, f.date, f.rate
--     FROM items i
--     JOIN booked_items bi on i.id = bi.item_id
--     JOIN bookings b on bi.booking_id = b.id
--     JOIN booking_feedbacks bf on b.id = bf.booking_id
--     JOIN feedbacks f on bf.feedback_id = f.id
--     WHERE i.id = item_id_v;
-- END;
-- $$ LANGUAGE plpgsql;

-- Вывести список всех доступных для бронирования вещей
CREATE OR REPLACE FUNCTION get_available_items()
RETURNS TABLE (
    id INTEGER,
    name VARCHAR(100),
    description TEXT,
    status VARCHAR(100)
) AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, status
    FROM items
    WHERE status = 'AVAILABLE';
END;
$$ LANGUAGE plpgsql;

-- Вывести все бронирования пользователя
CREATE OR REPLACE FUNCTION get_user_bookings(id_v INTEGER)
RETURNS TABLE (
    id INTEGER,
    name VARCHAR(100),
    start_date VARCHAR(100),
    end_date VARCHAR(100),
    description TEXT,
    status VARCHAR(100)
) AS $$
BEGIN
    RETURN QUERY
    SELECT b.id, i.name, b.start_date, b.end_date, b.description, b.status
    FROM bookings b
    JOIN booked_items bi ON b.id = bi.booking_id
    JOIN items i ON bi.item_id = i.id
    WHERE b.user_id = id_v;
END;
$$ LANGUAGE plpgsql;

-- Вывести все бронирования владельца
-- CREATE OR REPLACE FUNCTION get_owner_bookings(id_v INTEGER)
-- RETURNS TABLE (
--     id INTEGER,
--     name VARCHAR(100),
--     start_date TIMESTAMP,
--     end_date TIMESTAMP,
--     status booking_status
-- ) AS $$
-- BEGIN
--     RETURN QUERY
--     SELECT b.id, i.name, b.start_date, b.end_date, b.status
--     FROM bookings b
--     JOIN booked_items bi ON b.id = bi.booking_id
--     JOIN items i ON bi.item_id = i.id
--     WHERE i.owner_id = id_v;
-- END;
-- $$ LANGUAGE plpgsql;

-- Вывести все отзывы о вещи
CREATE OR REPLACE FUNCTION get_item_feedback(item_id_v INTEGER)
RETURNS TABLE (
    id INTEGER,
    name VARCHAR(100),
    title VARCHAR(100),
    description TEXT,
    date TIMESTAMP,
    rate INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT i.id, i.name, f.title, f.description, f.date, f.rate
    FROM items i
    JOIN booked_items bi on i.id = bi.item_id
    JOIN bookings b on bi.booking_id = b.id
    JOIN booking_feedbacks bf on b.id = bf.booking_id
    JOIN feedbacks f on bf.feedback_id = f.id
    WHERE i.id = item_id_v;
END;
$$ LANGUAGE plpgsql;