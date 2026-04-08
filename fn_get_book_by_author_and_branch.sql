-- Yazar ve Şube Bazlı Stok Sorgusu
-- Belirli bir yazarın, belirli bir şubedeki kitaplarını ve kopya sayılarını listeler.

CREATE OR REPLACE FUNCTION get_book_by_author_and_branch(
    p_author_name VARCHAR DEFAULT 'Angela Martin',
    p_branch_name VARCHAR DEFAULT 'Fitzgeraldfurt Kütüphanesi'
) 
RETURNS TABLE(
	branch_id INT,
    branch_name VARCHAR,
	author_id INT,
	author_name VARCHAR,
    book_title VARCHAR,
    number_of_copies INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
		br.id,
        br.name,
		a.id,
		a.name,
        bk.title, 
        bc.quantity
    FROM authors a
    JOIN books bk ON a.book_id = bk.id
    JOIN book_copies bc ON bk.id = bc.book_id
    JOIN branches br ON bc.branch_id = br.id
    WHERE a.name = p_author_name 
      AND br.name = p_branch_name;
END;
$$ LANGUAGE plpgsql;

-- Sorgulayalım
SELECT * FROM get_book_by_author_and_branch('George Vincent', 'West Edward Kütüphanesi');

