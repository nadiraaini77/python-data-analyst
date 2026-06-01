--Mendeteksi adanya transaksi fiktif
--Tanggal dan waktu rental di date_of_return bernilai null diisi oleh sistem karena nilainya sama semua
SELECT date_of_rental, time_of_rental, date_of_return
FROM rental_clean 
WHERE date_of_rental BETWEEN '2006-02-01' AND '2006-02-28'

--Tanggal dan waktu payment diisi oleh sistem karena nilainya sama semua
SELECT date_of_payment, time_of_payment, amount
FROM payment_clean 
WHERE date_of_payment BETWEEN '2006-02-01' AND '2006-02-28'

SELECT rental_id, date_of_payment, time_of_payment
FROM payment_clean 
WHERE time_of_payment = '00:30:32'

select date_of_rental, time_of_rental, rental_id, customer_id, date_of_return
from rental_clean
where date_of_return is null 
--2005-08-21 00:30:32 rental_id=14098 customer_id=554

--Soal 1. Pendapatan setiap bulan dari total pendapatan, sewa standar, dan denda keterlambatan
create table pendapatan_bulanan as
SELECT 
    DATE(p.date_of_payment) AS "Tanggal Transaksi",
    SUM(f.rental_rate) AS "Pendapatan Sewa Standar ($)",
    SUM(p.amount - f.rental_rate) AS "Pendapatan Denda Keterlambatan ($)",
    SUM(p.amount) AS "Total Pendapatan ($)"
FROM payment_clean p
INNER JOIN rental_clean r ON r.rental_id = p.rental_id
INNER JOIN inventory_clean i ON i.inventory_id = r.inventory_id
INNER JOIN film_clean f ON f.film_id = i.film_id
-- KUNCI : Tetap membuang data fiktif
WHERE r.date_of_return IS NOT NULL
GROUP BY DATE(p.date_of_payment)
ORDER BY "Tanggal Transaksi";

--Cek apakah ada customer yang mendapat diskon
SELECT 
    distinct p.customer_id AS "ID Customer",
    f.title AS "Judul Film",
    f.rental_rate AS "Tarif Standar ($)",
    p.amount AS "Uang yang Dibayar ($)",
    (f.rental_rate - p.amount) AS "Selisih Kurang ($)",
    DATE(p.date_of_payment) AS "Tanggal Bayar"
FROM payment_clean p
INNER JOIN rental_clean r ON r.rental_id = p.rental_id
INNER JOIN inventory_clean i ON i.inventory_id = r.inventory_id
INNER JOIN film_clean f ON f.film_id = i.film_id
-- KUNCI FILTERNYA: Cari yang uang dibayar LEBIH KECIL dari tarif film
WHERE p.amount < f.rental_rate
  AND r.date_of_return IS NOT NULL; -- Tetap buang data fiktif agar hasilnya objektif
  

--Soal 2. Performa penjualan setiap toko
create table performa_penjualan_toko as
SELECT 
    s.store_id AS "ID Toko",
    p.customer_id AS "ID Customer",
    SUM(p.amount) AS "Total Pengeluaran Pelanggan ($)"
FROM payment_clean p
INNER JOIN rental_clean r ON r.rental_id = p.rental_id
INNER JOIN staff_clean s ON s.staff_id = p.staff_id
-- KUNCI : Tetap membuang transaksi fiktif
WHERE r.date_of_return IS NOT NULL
GROUP BY s.store_id, p.customer_id
ORDER BY s.store_id, p.customer_id;

--Soal 3. Total transaksi dan pendapatan berdasarkan genre
create table total_transaksi_dan_pendapatan_per_genre as
SELECT 
    c.name AS "Genre",
    SUM(p.amount) AS "Total Pendapatan ($)"
FROM payment_clean p
INNER JOIN rental_clean r ON r.rental_id = p.rental_id
INNER JOIN inventory_clean i ON i.inventory_id = r.inventory_id
INNER JOIN film_clean f ON f.film_id = i.film_id
INNER JOIN film_category_clean fc ON fc.film_id = f.film_id
INNER JOIN category_clean c ON c.category_id = fc.category_id
-- Membuang transaksi fiktif
WHERE r.date_of_return IS NOT NULL 
GROUP BY c.name
ORDER BY "Total Pendapatan ($)" DESC;

--Soal 4. Durasi rental film per kategori
create table durasi_rental_rating as
select
    f.rating as rating_film,
    (r.date_of_return - r.date_of_rental) as durasi_rental_hari
from rental_clean r
inner join inventory_clean i on i.inventory_id = r.inventory_id
inner join film_clean f on f.film_id = i.film_id
where r.date_of_return is not null

--cek:
SELECT
    rating_film,
    AVG(durasi_rental_hari) AS rata_rata_durasi,
    MIN(durasi_rental_hari) AS min_durasi,
    MAX(durasi_rental_hari) AS max_durasi
FROM durasi_rental_rating
GROUP BY rating_film;

--Soal 5. Perbandingan revenue per rating
CREATE TABLE revenue_rating_film AS
SELECT
    f.rating AS rating_film,
     SUM(p.amount) AS total_revenue,
    100 * SUM(p.amount) / SUM(SUM(p.amount)) OVER () AS persentase_revenue
FROM payment_clean p
INNER JOIN rental_clean r ON r.rental_id = p.rental_id
INNER JOIN inventory_clean i ON i.inventory_id = r.inventory_id
INNER JOIN film_clean f ON f.film_id = i.film_id
WHERE r.date_of_return IS NOT NULL
GROUP BY f.rating
ORDER BY SUM(p.amount) DESC;

--Soal 6. Basis Pelanggan Berdasarkan Negara/Kota
create table transaction_country as
SELECT
    c.country AS "Negara",
    COUNT(pay.payment_id) AS "Total Transaksi",
    COUNT(DISTINCT pay.customer_id) AS "Pelanggan Aktif",
    ROUND(SUM(pay.amount)::numeric, 2) AS "Total Pendapatan ($)"
FROM payment_clean pay
INNER JOIN customer_clean cust  ON cust.customer_id = pay.customer_id
INNER JOIN address_clean addr   ON addr.address_id = cust.address_id
INNER JOIN city_clean ct        ON ct.city_id = addr.city_id
INNER JOIN country_clean c      ON c.country_id = ct.country_id
INNER JOIN rental_clean r       ON r.rental_id = pay.rental_id
-- FILTER: Membuang data fiktif
WHERE r.date_of_return IS NOT NULL
GROUP BY c.country
ORDER BY "Total Transaksi" DESC
LIMIT 20;

--Soal 7. Klasifikasi Customer Berdasarkan Total Spend
create table klasifikasi_pelanggan as
SELECT
    cust.customer_id,
    INITCAP(CONCAT(cust.first_name, ' ', cust.last_name)) AS nama_customer,
    SUM(pay.amount) AS total_spending
FROM customer_clean cust
INNER JOIN payment_clean pay ON pay.customer_id = cust.customer_id
INNER JOIN rental_clean r    ON r.rental_id = pay.rental_id
WHERE r.date_of_return IS NOT NULL
GROUP BY cust.customer_id, nama_customer;

--Soal 8. Hubungan antara "Durasi Keterlambatan Pengembalian" vs "Total Denda yang Dibayar"
create table hubungan_durasi_keterlambatan_dan_denda as
SELECT 
    r.rental_id,
    -- Kurangkan langsung tanggal kembali dengan tanggal pinjam biasa
    r.date_of_return - r.date_of_rental AS durasi_sewa_aktual,
    f.rental_duration AS jatah_durasi_film,
    p.amount AS denda_yang_dibayar
FROM rental_clean r
INNER JOIN payment_clean p ON p.rental_id = r.rental_id
INNER JOIN inventory_clean i ON i.inventory_id = r.inventory_id
INNER JOIN film_clean f ON f.film_id = i.film_id
-- Filter standar: Hanya ambil data yang kasetnya sudah dikembalikan
WHERE r.date_of_rental IS NOT NULL;

--Soal 9. Performa staff berdasarkan total pendapatan
create table performa_staff as
SELECT 
    INITCAP(CONCAT(s.first_name, ' ', s.last_name)) AS nama_staf,
    SUM(p.amount) AS total_pendapatan
FROM payment_clean p
INNER JOIN staff_clean s ON s.staff_id = p.staff_id
GROUP BY s.first_name, s.last_name;