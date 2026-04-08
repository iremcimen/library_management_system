from faker import Faker
import random
# pip install faker

fake = Faker()

# Ayarlar: Kaç tane veri üretelim?
num_publishers = 40
num_books = 120
num_branches = 16
num_borrowers = 80
num_loans = 150

with open('insert_data.sql', 'w', encoding='utf-8') as f:
    f.write("-- OTOMATİK ÜRETİLEN TEST VERİLERİ\n\n")

    # 1. Publishers
    for _ in range(num_publishers):
        f.write(f"INSERT INTO publishers (name, address, phone) VALUES ('{fake.company()}', '{fake.address().replace('\n', ' ')}', '{fake.phone_number()}');\n")

    # 2. Branches
    for _ in range(num_branches):
        f.write(f"INSERT INTO branches (name, address) VALUES ('{fake.city()} Kütüphanesi', '{fake.address().replace('\n', ' ')}');\n")

    # 3. Borrowers (Card No 100'den başlıyordu)
    for _ in range(num_borrowers):
        f.write(f"INSERT INTO borrowers (name, address, phone) VALUES ('{fake.name()}', '{fake.address().replace('\n', ' ')}', '{fake.phone_number()}');\n")

    # 4. Books (Publisher ID 1 ile num_publishers arasında olmalı)
    for _ in range(num_books):
        title = fake.catch_phrase() # Kitap ismi niyetine havalı cümleler
        pub_id = random.randint(1, num_publishers)
        f.write(f"INSERT INTO books (title, publisher_id) VALUES ('{title}', {pub_id});\n")

    # 5. Book Copies (Her kitabı her şubeye rastgele miktarda dağıtalım)
    for b_id in range(1, num_books + 1):
        for br_id in range(1, num_branches + 1):
            qty = random.randint(0, 10)
            f.write(f"INSERT INTO book_copies (book_id, branch_id, quantity) VALUES ({b_id}, {br_id}, {qty});\n")

    # 6. Book Loans (Ödünç Alma İşlemleri)
    for _ in range(num_loans):
        b_id = random.randint(1, num_books)
        br_id = random.randint(1, num_branches)
        card_no = random.randint(100, 100 + num_borrowers - 1)
        f.write(f"INSERT INTO book_loans (book_id, branch_id, card_no) VALUES ({b_id}, {br_id}, {card_no});\n")

    # 7. Authors (Yazarlar)
    f.write("\n-- Yazarlar Verileri\n")
    # Her kitap için en az bir yazar oluşturalım
    for b_id in range(1, num_books + 1):
        author_name = fake.name().replace("'", "''") # İsimdeki tırnak işaretlerini SQL için temizle
        f.write(f"INSERT INTO authors (name, book_id) VALUES ('{author_name}', {b_id});\n")
