-- Günlük İade Takip Fonksiyonu
-- Belirli bir şubede iade süresi bugün dolan kitapları ve üye iletişim bilgilerini listeler.
-- Kimin kitabı getirmesi gerektiğini, hangi şubeye gitmemiz gerektiğini ve o kişiye nasıl ulaşacağımızı tek bir kodla çıkarıyoruz.

CREATE OR REPLACE FUNCTION get_daily_loan_reports(
    p_branch_name VARCHAR DEFAULT 'Robertside Kütüphanesi',
    p_check_date DATE DEFAULT CURRENT_DATE
) 
RETURNS TABLE(
    branch_name VARCHAR,
    book_title VARCHAR,
    borrower_name VARCHAR,
    borrower_address TEXT,
    date_out DATE,
    due_date DATE
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        br.name, 
        bk.title, 
        bw.name, 
        bw.address, 
        bl.date_out, 
        bl.due_date
    FROM book_loans bl
    JOIN books bk ON bl.book_id = bk.id
    JOIN borrowers bw ON bl.card_no = bw.card_no
    JOIN branches br ON bl.branch_id = br.id
    WHERE bl.due_date = p_check_date 
      AND br.name = p_branch_name;
END;
$$ LANGUAGE plpgsql;

-- Bugün iadesi gelenleri listele
SELECT * FROM get_daily_loan_reports('North Christina Kütüphanesi');

-- Belirli bir tarihte iadesi olanları listele (Örn: 2026-04-22)
SELECT * FROM get_daily_loan_reports('West Edward Kütüphanesi', '2026-04-22');