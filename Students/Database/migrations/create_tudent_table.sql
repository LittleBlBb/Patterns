CREATE TABLE IF NOT EXISTS student (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    middle_name TEXT NOT NULL,
    phone TEXT,
    email TEXT,
    telegram TEXT,
    github TEXT,
    birthdate TEXT NOT NULL
);
