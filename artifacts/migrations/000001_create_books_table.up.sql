CREATE TABLE IF NOT EXISTS books(
  id          uuid PRIMARY KEY,
  title       VARCHAR(50) NOT NULL,
  description VARCHAR(50) NOT NULL,
  no_of_pages INT,
  year        INT
);
