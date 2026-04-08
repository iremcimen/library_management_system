-- Bu fonksiyon, Herbir şubeden toplamda kaç adet kitap ödünç alındığını listeler.
-- Hangi şubemiz daha çok çalışıyor, en çok hangi bölgede kitap okunuyor?

CREATE OR REPLACE FUNCTION get_total_loans_per_branch()
RETURNS TABLE(
	branch_id INT,
    branch_name VARCHAR,
    total_loans BIGINT -- COUNT sonucu PostgreSQL'de genellikle BIGINT döner
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
		br.id,
        br.name, 
        COUNT(bl.loan_id) -- Her bir ödünç işlemini sayıyoruz
    FROM branches br
    LEFT JOIN book_loans bl ON br.id = bl.branch_id
    GROUP BY br.id, br.name
    ORDER BY total_loans DESC; -- En çok ödünç veren şube en üstte olsun
END;
$$ LANGUAGE plpgsql;


-- Kütüphane performanslarını görelim
SELECT * FROM get_total_loans_per_branch();