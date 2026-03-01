-- Вывести список всех доступных для бронирования вещей
CREATE OR REPLACE FUNCTION get_all_items()
    RETURNS TABLE
            (
                id          INTEGER,
                name        VARCHAR(100),
                description TEXT,
                status      VARCHAR(100)
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT i.id, i.name, i.description, i.status
        FROM items AS i;
END;
$$ LANGUAGE plpgsql;

-- Вывести даты бронирования вещи
CREATE OR REPLACE FUNCTION get_booked_dates(item INTEGER)
    RETURNS TABLE
            (
                start_date DATE,
                end_date   DATE
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT b.start_date, b.end_date
        FROM bookings AS b
                 JOIN booked_items AS bi ON b.id = bi.booking_id
                 JOIN items AS i ON bi.item_id = i.id
        WHERE bi.item_id = item
          AND (b.status = 'APPROVED'
            OR b.status = 'WAITING FOR CONFIRMATION')
        ORDER BY b.start_date;
END;
$$ LANGUAGE plpgsql;

-- Вывести список всех дат бронирования вещи
CREATE OR REPLACE FUNCTION get_owner_booked_dates(item INTEGER)
    RETURNS TABLE
            (
                id         INTEGER,
                start_date DATE,
                end_date   DATE,
                status     VARCHAR(100)
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT b.id, b.start_date, b.end_date, b.status
        FROM bookings AS b
                 JOIN booked_items AS bi ON b.id = bi.booking_id
                 JOIN items AS i ON bi.item_id = i.id
        WHERE bi.item_id = item
          AND b.status = 'WAITING FOR CONFIRMATION'
        ORDER BY b.start_date;
END
$$ LANGUAGE plpgsql;

-- Вывести историю заказов вещей пользователя
CREATE OR REPLACE FUNCTION get_owner_items_books(owner_id_v INTEGER)
    RETURNS TABLE
            (
                id          INTEGER,
                name        VARCHAR(100),
                username    VARCHAR(100),
                start_date  DATE,
                end_date    DATE,
                status      VARCHAR(100),
                description TEXT
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT b.id, i.name, u.username, b.start_date, b.end_date, b.status, b.description
        FROM bookings AS b
                 JOIN booked_items AS bi ON b.id = bi.booking_id
                 JOIN items AS i ON bi.item_id = i.id
                 JOIN users u ON b.user_id = u.id
        WHERE i.owner_id = owner_id_v
        ORDER BY b.start_date DESC;
END
$$ LANGUAGE plpgsql;

-- Добавление вещи, которой готов поделиться пользователь
CREATE PROCEDURE add_new_item(
    item_name VARCHAR(100),
    item_description TEXT,
    item_owner_id INTEGER)
    LANGUAGE SQL
BEGIN
    ATOMIC
    INSERT INTO items (name, description, owner_id, status)
    VALUES (item_name, item_description, item_owner_id, 'AVAILABLE');
END;

-- Вывести все бронирования пользователя
CREATE OR REPLACE FUNCTION get_user_bookings(id_v INTEGER)
    RETURNS TABLE
            (
                id             INTEGER,
                name           VARCHAR(100),
                username       VARCHAR(100),
                owner_username VARCHAR(100),
                start_date     DATE,
                end_date       DATE,
                description    TEXT,
                status         VARCHAR(100)
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT b.id,
               i.name,
               u.username,
               ow.username,
               b.start_date,
               b.end_date,
               b.description,
               b.status
        FROM bookings b
                 JOIN booked_items bi ON b.id = bi.booking_id
                 JOIN items i ON bi.item_id = i.id
                 JOIN users u ON b.user_id = u.id
                 JOIN users ow ON b.user_id = u.id
        WHERE b.user_id = id_v
        ORDER BY start_date DESC;
END;
$$ LANGUAGE plpgsql;