-- Creating tables

-- Yayınevi
CREATE TABLE publishers(
	id INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	address TEXT NOT NULL,
	phone VARCHAR(50) NOT NULL
);

-- Kitaplar
CREATE TABLE books(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	publisher_id INT NOT NULL,
	
	CONSTRAINT fk_publishers
		FOREIGN KEY (publisher_id)
		REFERENCES publishers(id)
		ON DELETE RESTRICT
);

-- Şubeler
CREATE TABLE branches(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	address TEXT NOT NULL
);

-- Üyeler
CREATE TABLE borrowers(
	card_no INT GENERATED ALWAYS AS IDENTITY (START WITH 100) PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	address TEXT NOT NULL,
	phone VARCHAR(50) NOT NULL
);

-- Kitap kopyaları (Hangi şubede kaç adet var?)
CREATE TABLE book_copies(
	copy_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	book_id INT NOT NULL,
	branch_id INT NOT NULL,
	quantity INT NOT NULL DEFAULT 0,

	CONSTRAINT fk_books_copies
		FOREIGN KEY (book_id)
		REFERENCES books(id)
		ON DELETE CASCADE,
		
	CONSTRAINT fk_branches_copies
		FOREIGN KEY (branch_id)
		REFERENCES branches(id)
		ON DELETE CASCADE
);
-- ON DELETE RESTRICT: Bağlı olan veriler silinmeden ana verinin silinmesine izin vermez.
-- ON DELETE CASCADE: Üst tabloyu sildiğinde, ona bağlı olan alt tablodaki tüm satırlar da otomatik olarak silinir.

-- Ödünç İşlemleri
CREATE TABLE book_loans(
	loan_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	book_id INT NOT NULL,
	branch_id INT NOT NULL,
	card_no INT NOT NULL,
	date_out DATE DEFAULT CURRENT_DATE, --Kitabı alış tarihi
	due_date DATE DEFAULT (CURRENT_DATE + INTERVAL '14 days'), -- Otomatik 14 gün sonrası teslim
	
	CONSTRAINT fk_books_loans
	FOREIGN KEY (book_id)
	REFERENCES books(id),
		
	CONSTRAINT fk_branches_loans
	FOREIGN KEY (branch_id)
	REFERENCES branches(id),

	CONSTRAINT fk_borrowers
	FOREIGN KEY (card_no)
	REFERENCES borrowers(card_no)	
);

-- Yazarlar
CREATE TABLE authors(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	book_id INT NOT NULL,
	
	CONSTRAINT fk_books_authors
	FOREIGN KEY (book_id)
	REFERENCES books(id)
);