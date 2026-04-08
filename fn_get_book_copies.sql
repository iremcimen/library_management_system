-- Şu kitap şu şubede kaç tane var?
CREATE OR REPLACE FUNCTION get_book_copies_at_branch(
    p_book_title VARCHAR DEFAULT 'Triple-buffered tertiary firmware', 
    p_branch_name VARCHAR DEFAULT 'West Edward Kütüphanesi'
) 
RETURNS TABLE(
    branch_name VARCHAR,
    book_title VARCHAR,
    number_of_copies INT 
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        br.name, 
        bk.title, 
        bc.quantity
    FROM book_copies bc
    JOIN books bk ON bc.book_id = bk.id
    JOIN branches br ON bc.branch_id = br.id
    WHERE bk.title = p_book_title 
    AND br.name = p_branch_name;
   --Fonksiyona dışarıdan gönderilen kitap ve şube isimlerine uyanları getir.
END;
$$ LANGUAGE plpgsql;

-- Arama yapalım
SELECT * FROM get_book_copies_at_branch('Progressive non-volatile alliance', 'Olsonborough Kütüphanesi');