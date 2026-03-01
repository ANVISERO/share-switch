INSERT INTO passports (id, series, number, division_code, date_of_issue, issued_by, date_of_birth)
VALUES (1, '1111', '222222', '111-222', '2000-01-01', 'someone', '2000-01-01'),
       (2, '2222', '222222', '111-222', '2001-01-01', 'someone', '2001-01-01'),
       (3, '3333', '222222', '111-222', '2002-01-01', 'someone', '2003-01-01');
-- 1) Проверка роботы триггера check_unique_email_trigger
INSERT INTO users (id, username, surname, name, patronymic, email, phone_number, sex)
VALUES (11, 'abc', 'a', 'b', 'c', 'abc@gmail.com', '89283334455', 'MAN'),
       (22, 'DEF', 'D', 'E', 'F', 'DEF@gmail.com', '89283334466', 'MAN'),
       (33, 'GHI', 'G', 'H', 'I', 'GHI@gmail.com', '89283334477', 'WOMAN');

INSERT INTO users (id, username, surname, name, patronymic, email, phone_number, sex)
VALUES (12, 'abcD', 'a', 'b', 'c', 'abc@gmail.com', '89283334455', 'MAN');
--

-- 2) Проверка работы триггера set_booking_end_date_trigger
call add_new_item(
    1,
    'дрель1',
    'классная дрель1',
    11);

call book_item(
    1,
    22,
    1);

call confirm_booking(
     1,
     1);

call end_booking(
    1,
     1);

call book_item(
    2,
    22,
    1);

call confirm_booking(
     2,
     1);

call end_booking(
    2,
     1);
--

-- 3) Проверка работы триггера check_user_passport_trigger
call add_new_item(
    2,
    'швабра',
    'классная швабра',
    11);

call add_passport(
     1234,
     '1111',
     '111111',
     '111-111',
     '2000-01-01',
     'someone',
     '1988-01-01',
     11);

call add_new_item(
    2,
    'швабра',
    'классная швабра',
    11);
call add_new_item(
        16,
        'швабра',
        'классная швабра',
        11);
--

-- 4)