# MyPortfolio Mobile

Kelanjutan proyek Flutter Tutorial 08. Halaman utama menampilkan informasi
profil serta menu **Lihat Proyek**, **Tambah Proyek**, dan **Logout**. Ketiga
tombol saat ini menampilkan SnackBar; navigasi dan autentikasi belum diterapkan.

## Struktur kode

```text
lib/
├── main.dart                  # Entry point, MaterialApp, dan tema aplikasi
├── menu.dart                  # MyHomePage dan penanganan aksi menu
├── data/
│   └── portfolio_owner.dart    # Isi NPM, nama lengkap, dan kelas PBP di sini
├── models/
│   ├── item_homepage.dart      # Data immutable untuk label dan ikon menu
│   └── portfolio_profile.dart  # Model identitas pemilik tanpa dependensi Flutter
└── widgets/
    ├── info_card.dart         # Kartu informasi profil
    └── item_card.dart         # Kartu menu dengan callback onTap
```

`main()` menjalankan `MyApp`, lalu `MaterialApp` membuka
`const MyHomePage(profile: portfolioOwner)`.
Susunan widget halaman utama berada di `menu.dart`, terpisah dari bootstrap
dan konfigurasi aplikasi di `main.dart`.

## Pemisahan tanggung jawab dan optimasi

- **Halaman stateless:** `MyHomePage` mewarisi `StatelessWidget` karena data
  profil dan menu tidak berubah secara lokal. SnackBar dikelola oleh
  `ScaffoldMessenger`, sehingga halaman tidak memerlukan `setState`.
- **Data terpisah dari aksi:** `ItemHomepage` hanya berisi label dan ikon.
  `ItemCard` menerima callback `onTap`; halaman menentukan efek interaksi.
  Perubahan navigasi nantinya tidak mengharuskan perubahan pada widget kartu.
- **Konfigurasi immutable:** daftar menu menggunakan `static const`, model
  menggunakan field `final` dan konstruktor `const`. Profil pemilik juga berupa
  konstanta yang diberikan melalui konstruktor halaman. Widget dengan isi
  tetap menggunakan `const` agar instansinya dapat digunakan kembali.
- **Identitas terpusat:** data pemilik berada di `lib/data/portfolio_owner.dart`,
  terpisah dari model `PortfolioProfile` dan tampilan `InfoCard`. Halaman tidak
  mengunci identitas tertentu sehingga dapat diuji dengan profil lain.
- **Nama lengkap tetap terbaca:** tiga kartu sejajar di bagian atas halaman.
  Teks dapat membungkus ke beberapa baris dengan tinggi kartu mengikuti isinya,
  tanpa ellipsis atau pengukuran `IntrinsicHeight` tambahan.
- **Satu area gulir:** `CustomScrollView` menyusun profil dan `SliverGrid`
  dalam satu viewport, menggantikan grid `shrinkWrap` di dalam scroll view lain.
  Delegate grid membangun kartu sesuai kebutuhan viewport.
- **Komponen reusable:** `InfoCard` dan `ItemCard` mengurus tampilan dengan
  input konstruktor. Docstring menjelaskan tanggung jawab dan alasan desain.

## Mengisi identitas pemilik

Edit **`lib/data/portfolio_owner.dart`** dan ganti ketiga teks berikut dengan
identitas kamu sendiri:

```dart
const portfolioOwner = PortfolioProfile(
  npm: 'Isi NPM kamu',
  fullName: 'Isi nama lengkap kamu',
  pbpClass: 'Isi kelas PBP kamu',
);
```

`npm` tampil pada kartu **NPM**, `fullName` pada kartu **Name**, dan `pbpClass`
pada kartu **Class**. Pertahankan tanda kutip pada NPM agar tetap berupa teks.
Data Burhan sudah dihapus; teks pengisian di atas bukan identitas asli dan harus
diganti sebelum tugas dikumpulkan. Setelah mengedit konstanta, lakukan hot
restart atau jalankan ulang aplikasi untuk memastikan profil diperbarui.

## Menjalankan aplikasi

Dari direktori `myportofolio_mobile`, dengan Flutter SDK tersedia di PATH:

```sh
flutter pub get
flutter run
```

## Pemeriksaan

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

Widget test di `test/widget_test.dart` memeriksa informasi profil dan menu pada
layar 320 × 568, pasangan label dan nilai profil, nama panjang tanpa overflow,
serta pesan SnackBar untuk setiap tombol menu. Nilai profil default dibaca dari
konfigurasi yang sama sehingga test tidak perlu diedit saat identitas diisi.
