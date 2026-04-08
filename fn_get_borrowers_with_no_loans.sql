-- Bu fonksiyon, şu an üzerinde hiç ödünç kitap bulunmayan üyelerin isimlerini listeler.
-- Kütüphanenin "pasif üyelerini" tespit etmek için harikadır.

CREATE OR REPLACE FUNCTION get_borrowers_with_no_loans()
RETURNS TABLE(card_no INT, borrower_name VARCHAR) 
AS $$
BEGIN
    RETURN QUERY
    SELECT b.card_no, b.name
    FROM borrowers b
    WHERE NOT EXISTS (
        SELECT 1 
        FROM book_loans bl 
        WHERE bl.card_no = b.card_no
    );
END;
$$ LANGUAGE plpgsql;

-- Fonksiyonu çağıralım
SELECT * FROM get_borrowers_with_no_loans();