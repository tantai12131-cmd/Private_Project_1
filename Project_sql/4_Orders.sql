--số lượng đơn hàng dùng tại chỗ (in) và
--mang đi (out) và không biết theo từng ngày.
--
SELECT
    TO_CHAR(created_at, 'dd-mm') as Ngay,
    TO_CHAR(created_at, 'day') as Thu,
    COUNT(in_or_out) AS Tong,
    SUM(CASE WHEN in_or_out= 'in' THEN quantity END) AS So_Luong_IN,
    SUM(CASE WHEN in_or_out= 'out' THEN quantity END) AS So_Luong_OUT,
    SUM(CASE WHEN in_or_out= 'unknown' THEN quantity END) AS So_Luong_UNKNOWN    
FROM
    orders
GROUP BY
    Ngay, Thu
ORDER BY
    Ngay
