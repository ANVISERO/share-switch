CREATE INDEX IF NOT EXISTS items_id ON items USING HASH(id);
CREATE INDEX IF NOT EXISTS items_name ON items USING HASH(name);
CREATE INDEX IF NOT EXISTS items_status ON items USING HASH(status);

CREATE INDEX IF NOT EXISTS bookings_id ON bookings USING HASH(id);
CREATE INDEX IF NOT EXISTS bookings_user_id ON bookings USING HASH(user_id);
CREATE INDEX IF NOT EXISTS bookings_start_date ON bookings USING BTREE(start_date);

CREATE INDEX IF NOT EXISTS categories_id ON categories USING HASH(id);
CREATE INDEX IF NOT EXISTS categories_name ON categories USING HASH(category_name);

CREATE INDEX IF NOT EXISTS item_categories_item_id ON item_categories USING HASH(item_id);
CREATE INDEX IF NOT EXISTS item_categories_category_id ON item_categories USING HASH(category_id);
