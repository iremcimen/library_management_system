-- Çok Kitap Alan Üyeler Fonksiyonu
-- Amaç: Belirli bir sayıdan (varsayılan 5) fazla kitap ödünç alan üyeleri listeler.

CREATE OR REPLACE FUNCTION get_heavy_borrowers(
    p_min_books INT DEFAULT 5
) 
RETURNS TABLE(
	card_no INT,
    borrower_name VARCHAR,
    borrower_address TEXT,
    books_checked_out BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
		b.card_no,
        b.name, 
        b.address, 
        COUNT(bl.loan_id) AS total_count --ödünç alma sayısı
    FROM borrowers b
    JOIN book_loans bl ON b.card_no = bl.card_no
    GROUP BY b.card_no, b.name, b.address
    HAVING COUNT(bl.loan_id) >= p_min_books
    ORDER BY total_count DESC;
END;
$$ LANGUAGE plpgsql;

-- En az 3 kitap almış olanları listele
SELECT * FROM get_heavy_borrowers(3);

