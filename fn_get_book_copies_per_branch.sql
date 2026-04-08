-- Bir kitabın tüm şubelerdeki stok durumunu listeler.

CREATE OR REPLACE FUNCTION get_book_copies_per_branch(
    p_book_title VARCHAR DEFAULT 'Triple-buffered tertiary firmware'
) 
RETURNS TABLE(
    branch_id INT,
    branch_name VARCHAR,
    number_of_copies INT,
    book_title VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        br.id, 
        br.name, 
        bc.quantity, 
        bk.title
    FROM book_copies bc
    JOIN books bk ON bc.book_id = bk.id
    JOIN branches br ON bc.branch_id = br.id
    WHERE bk.title = p_book_title;
END;
$$ LANGUAGE plpgsql;

-- Tüm kütüphane zincirinde bu kitaptan nerede kaç tane var?
SELECT * FROM get_book_copies_per_branch('Compatible neutral capacity');
	