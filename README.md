# 📚 Kütüphane Yönetim Sistemi (PostgreSQL & Python)

Bu proje, bir kütüphanenin kitap stoğunu, üye bilgilerini ve ödünç alma süreçlerini uçtan uca yöneten ilişkisel bir veritabanı sistemidir. Gerçekçi verilerle test edilmiş ve karmaşık SQL fonksiyonları (PL/pgSQL) ile zenginleştirilmiştir.



## 🚀 Proje Özellikleri

* **Dinamik Veri Üretimi:** Python `Faker` kütüphanesi kullanılarak satır gerçekçi (isim, adres, telefon) test verisi üretilmiştir.
* **İlişkisel Veritabanı Tasarımı:** Kitaplar, yazarlar, yayıncılar, şubeler ve üyeler arasındaki ilişkiler (Primary/Foreign Key) optimize edilmiştir.
* **Gelişmiş Analitik Fonksiyonlar:** PostgreSQL'in `PL/pgSQL` dili kullanılarak 7 farklı operasyonel rapor ve fonksiyon geliştirilmiştir.
* **Stok Takibi:** Şube bazlı kitap mevcudiyeti ve yazar bazlı envanter dökümü anlık olarak yapılabilmektedir.



## 📂 Dosya Yapısı

| Dosya Adı | Açıklama |
| :--- | :--- |
| `creating_tables.sql` | Veritabanı şemasını ve tabloları oluşturan ana script. |
| `generate_data.py` | Faker kütüphanesi ile SQL INSERT komutları üreten Python kodu. |
| `insert_data.sql` | Python tarafından üretilen 150+ satırlık örnek veritabanı kayıtları. |
| `fn_... .sql` | Kütüphane raporlarını döndüren profesyonel SQL fonksiyonları. |

---

## 🛠️ Kurulum ve Kullanım

### 1. Veritabanı Şemasını Oluşturma
PostgreSQL (pgAdmin) üzerinde `creating_tables.sql` dosyasını çalıştırarak tablo yapılarını kurun.

### 2. Verilerin Üretilmesi
Sistemde kullanılacak rastgele verileri üretmek için:
```bash
python generate_data.py
