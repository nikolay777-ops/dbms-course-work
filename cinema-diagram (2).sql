CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "email" VARCHAR(100) UNIQUE,
  "password" VARCHAR(100),
  "contact_num" VARCHAR(15),
  "role_id" BIGINT,
  "age" INT
);

CREATE TABLE "user_roles" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50)
);

CREATE TABLE "movies" (
  "id" SERIAL PRIMARY KEY,
  "title" VARCHAR(100),
  "description" TEXT,
  "release_date" DATE,
  "rating" DECIMAL(2,1),
  "duration" INTERVAL,
  "genre_id" BIGINT,
  "country_id" BIGINT,
  "age_restriction_id" BIGINT,
);

CREATE TABLE "movie_director" (
  "id" SERIAL PRIMARY KEY,
  "movie_id" BIGINT,
  "director_id" BIGINT
);

CREATE TABLE "genres" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50)
);

CREATE TABLE "directors" (
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50)
);

CREATE TABLE "actors" (
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50)
);

CREATE TABLE "cinemas" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(100),
  "address" VARCHAR(200)
);

CREATE TABLE "halls" (
  "id" SERIAL PRIMARY KEY,
  "cinema_id" INT,
  "hall_num" INT,
  "capacity" INT
);

CREATE TABLE "seats" (
  "id" SERIAL PRIMARY KEY,
  "hall_id" INT,
  "row_num" INT,
  "seat_num" INT,
  "seat_type_id" INT
);

CREATE TABLE "showtimes" (
  "id" SERIAL PRIMARY KEY,
  "movie_id" INT,
  "hall_id" INT,
  "startime" DATETIME
);

CREATE TABLE "tickets" (
  "id" SERIAL PRIMARY KEY,
  "showtime_id" INT,
  "seat_id" INT,
  "price" DECIMAL(5,2)
);

CREATE TABLE "reservations" (
  "id" SERIAL PRIMARY KEY,
  "user_id" BIGINT,
  "reservation_time" TIMESTAMP
);

CREATE TABLE "online_movies" (
  "id" SERIAL PRIMARY KEY,
  "movie_id" INT,
  "language_id" BIGINT,
  "url" TEXT,
  "created_at" DATETIME,
  "updated_at" DATETIME
);

CREATE TABLE "views" (
  "id" SERIAL PRIMARY KEY,
  "online_movie_id" INT,
  "view_time" DATETIME,
  "view_dur_time" DURATION,
  "user_id" INT
);

CREATE TABLE "reviews" (
  "id" SERIAL PRIMARY KEY,
  "movie_id" INT,
  "rating" INT,
  "comment" TEXT,
  "created_at" DATETIME,
  "updated_at" DATETIME
);

CREATE TABLE "payments" (
  "id" SERIAL PRIMARY KEY,
  "reservation_id" INT,
  "payment_method_id" BIGINT,
  "created_at" DATETIME,
  "amount" DECIMAL(5,2)
);

CREATE TABLE "payment_methods" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) UNIQUE
);

CREATE TABLE "advertisements" (
  "id" SERIAL PRIMARY KEY,
  "title" VARCHAR(100),
  "description" TEXT,
  "url" TEXT,
  "type_id" BIGINT
);

CREATE TABLE "adv_type" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) UNIQUE,
  "priority" INT
);

CREATE TABLE "ad_views" (
  "id" SERIAL PRIMARY KEY,
  "ad_id" INT,
  "view_id" INT,
  "user_id" INT,
  "viewed_at" DATETIME
);

CREATE TABLE "countries" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) UNIQUE
);

CREATE TABLE "languages" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) UNIQUE
);

CREATE TABLE "age_restrictions" (
  "id" SERIAL PRIMARY KEY,
  "age_restriction" INT UNIQUE
);

CREATE TABLE "seat_types" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) UNIQUE
);

CREATE TABLE "movie_actor" (
  "id" SERIAL PRIMARY KEY,
  "movie_id" BIGINT,
  "actor_id" BIGINT
);

CREATE TABLE "movie_genre" (
  "id" SERIAL PRIMARY KEY,
  "movie_id" BIGINT,
  "genre_id" BIGINT
);

CREATE TABLE "playlist" (
  "id" SERIAL PRIMARY KEY,
  "user_id" BIGINT,
  "name" VARCHAR(50)
);

CREATE TABLE "playlist_movies" (
  "id" SERIAL PRIMARY KEY,
  "movie_id" BIGINT,
  "playlist_id" BIGINT,
  "created_at" DATETIME
);

CREATE TABLE "recommendation" (
  "id" SERIAL PRIMARY KEY,
  "user_id" BIGINT,
  "movie_id" BIGINT,
  "created_at" DATETIME
);

ALTER TABLE "user_roles" ADD FOREIGN KEY ("id") REFERENCES "users" ("role_id");

ALTER TABLE "halls" ADD FOREIGN KEY ("cinema_id") REFERENCES "cinemas" ("id");

ALTER TABLE "seats" ADD FOREIGN KEY ("hall_id") REFERENCES "halls" ("id");

ALTER TABLE "showtimes" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");

ALTER TABLE "showtimes" ADD FOREIGN KEY ("hall_id") REFERENCES "halls" ("id");

ALTER TABLE "tickets" ADD FOREIGN KEY ("showtime_id") REFERENCES "showtimes" ("id");

ALTER TABLE "tickets" ADD FOREIGN KEY ("seat_id") REFERENCES "seats" ("id");

ALTER TABLE "reservations" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "online_movies" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");

ALTER TABLE "views" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "views" ADD FOREIGN KEY ("online_movie_id") REFERENCES "online_movies" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("id") REFERENCES "users" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");

ALTER TABLE "payments" ADD FOREIGN KEY ("reservation_id") REFERENCES "reservations" ("id");

ALTER TABLE "ad_views" ADD FOREIGN KEY ("ad_id") REFERENCES "advertisements" ("id");

ALTER TABLE "ad_views" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "ad_views" ADD FOREIGN KEY ("view_id") REFERENCES "views" ("id");

ALTER TABLE "languages" ADD FOREIGN KEY ("id") REFERENCES "online_movies" ("language_id");

ALTER TABLE "movie_actor" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");

ALTER TABLE "movie_actor" ADD FOREIGN KEY ("actor_id") REFERENCES "actors" ("id");

ALTER TABLE "movie_genre" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");

ALTER TABLE "movie_genre" ADD FOREIGN KEY ("genre_id") REFERENCES "genres" ("id");

ALTER TABLE "age_restrictions" ADD FOREIGN KEY ("id") REFERENCES "movies" ("age_restriction_id");

ALTER TABLE "payment_methods" ADD FOREIGN KEY ("id") REFERENCES "payments" ("payment_method_id");

ALTER TABLE "seat_types" ADD FOREIGN KEY ("id") REFERENCES "seats" ("seat_type_id");

ALTER TABLE "playlist_movies" ADD FOREIGN KEY ("playlist_id") REFERENCES "playlist" ("id");

ALTER TABLE "playlist_movies" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("id") REFERENCES "recommendation" ("user_id");

ALTER TABLE "movies" ADD FOREIGN KEY ("id") REFERENCES "recommendation" ("movie_id");

ALTER TABLE "adv_type" ADD FOREIGN KEY ("id") REFERENCES "advertisements" ("type_id");

ALTER TABLE "movie_director" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");

ALTER TABLE "movie_director" ADD FOREIGN KEY ("director_id") REFERENCES "directors" ("id");
