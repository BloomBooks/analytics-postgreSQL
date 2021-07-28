-- Type: book_id_input

-- DROP TYPE common.book_id_input;

CREATE TYPE common.book_id_input AS
(
	book_id TEXT,
	book_instance_id TEXT
);

ALTER TYPE common.book_id_input
    OWNER TO silpgadmin;
