CREATE TABLE IF NOT EXISTS student (
    id SERIAL PRIMARY KEY ,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    middle_name TEXT NOT NULL,
    phone TEXT UNIQUE,
    email TEXT UNIQUE,
    telegram TEXT UNIQUE,
    github TEXT UNIQUE,
    birthdate TEXT NOT NULL
);
