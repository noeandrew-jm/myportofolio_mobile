# MyPortfolio Mobile

Kelanjutan proyek Flutter Tutorial 08 dengan halaman profil dan tiga aksi menu.

## Halaman utama

- `lib/main.dart` menangani bootstrap, `MaterialApp`, dan tema aplikasi.
- `MyHomePage` di `lib/menu.dart` merupakan `StatelessWidget`, terpisah dari bootstrap.
- Tiga `InfoCard` menampilkan **NPM**, **Name**, dan **Class** dari konfigurasi identitas `lib/data/portfolio_owner.dart` melalui model `PortfolioProfile`.
- Nama lengkap membungkus ke beberapa baris tanpa pemotongan; tiga kartu tetap sejajar di bagian atas.

## Aksi menu

Label, ikon, dan warna didefinisikan dalam konstanta `portfolioActions` di `lib/data/portfolio_actions.dart`.

| Tombol | Ikon | Warna | Pesan SnackBar |
| --- | --- | --- | --- |
| Lihat Proyek | `Icons.folder` | Biru `#1565C0` | `Kamu telah menekan tombol Lihat Proyek!` |
| Tambah Proyek | `Icons.add_circle` | Hijau `#2E7D32` | `Kamu telah menekan tombol Tambah Proyek!` |
| Logout | `Icons.logout` | Merah `#C62828` | `Kamu telah menekan tombol Logout!` |

Setiap tombol menampilkan SnackBar sesuai labelnya. Navigasi dan autentikasi belum diterapkan.

## Pemisahan kode dan optimasi

- Model menggunakan field `final` dan konstruktor `const`; konfigurasi serta widget tetap menggunakan `const`.
- `ItemCard` menerima data `ItemHomepage` dan callback `onTap`; halaman menangani SnackBar melalui `ScaffoldMessenger`.
- `CustomScrollView` dan `SliverGrid` memakai satu area gulir tanpa grid `shrinkWrap` bertingkat.
- Docstring menjelaskan tanggung jawab model, halaman, dan kartu yang dapat digunakan kembali.

Pemeriksaan: `flutter analyze` dan `flutter test`.
