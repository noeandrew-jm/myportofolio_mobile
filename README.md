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

Validasi kualitas kode: `flutter analyze` dijalankan dari root proyek
(`myportofolio_mobile/`) dan menghasilkan **No issues found!**. Pengujian widget
dapat dijalankan dengan `flutter test`.

### Tugas 7

1. **Apa itu widget tree dan bagaimana hubungan parent–child?**

   Widget tree adalah hierarki widget yang mendeskripsikan susunan antarmuka. Sebuah parent menyusun child melalui properti seperti `child`, `children`, `body`, atau `home`. Widget buatan sendiri mengembalikan susunan widget lain melalui `build()`, sehingga komponen kecil dapat digabungkan menjadi halaman. Data konfigurasi dapat diteruskan dari parent melalui konstruktor child. [Dokumentasi widget Flutter](https://docs.flutter.dev/learn/pathway/tutorial/widget-fundamentals).

   Dalam proyek ini, jalur ringkasnya adalah `MyApp → MaterialApp → MyHomePage → Scaffold`. Jalur tersebut menyederhanakan widget internal yang dibentuk framework. `Scaffold` menempatkan `AppBar` pada bagian atas dan `SafeArea` sebagai body. Di dalam body, `CustomScrollView` menggabungkan bagian profil dan grid menu.

   Pada bagian profil, `Row` memiliki tiga child `Expanded`, masing-masing membungkus `InfoCard`. `Row` menentukan susunan horizontal; `Expanded` membagi ruang tersedia; `InfoCard` menampilkan label dan nilai. Dengan demikian, parent mengatur penempatan, sedangkan child menjalankan tanggung jawab tampilannya. Pada menu, halaman mengirim data dan callback kepada `ItemCard`, lalu kartu meneruskan ketukan pengguna melalui callback tersebut. [Dokumentasi layout](https://docs.flutter.dev/ui/widgets/layout).

2. **Widget apa saja yang digunakan dan apa fungsinya?**

   Berikut seluruh tipe widget yang dibuat secara eksplisit dalam kode produksi `lib/`: empat widget buatan proyek dan dua puluh widget Flutter. Fungsi di bawah menjelaskan pemakaiannya pada aplikasi ini.

   | Widget | Fungsi dalam proyek |
   | --- | --- |
   | `MyApp` | Membentuk konfigurasi aplikasi dan memasukkan profil pemilik. |
   | `MyHomePage` | Menyusun halaman profil, menu, dan penanganan aksi. |
   | `InfoCard` | Komponen reusable untuk pasangan label dan nilai identitas. |
   | `ItemCard` | Komponen aksi dengan label, ikon, warna, dan callback. |
   | `MaterialApp` | Menyediakan lingkungan Material, tema, dan halaman awal. |
   | `Scaffold` | Menyediakan kerangka halaman melalui `appBar` dan `body`. |
   | `AppBar` | Menampilkan judul MyPortfolio pada bilah atas. |
   | [SafeArea](https://api.flutter.dev/flutter/widgets/SafeArea-class.html) | Memberi inset agar body menghindari area sistem seperti notch. |
   | `CustomScrollView` | Menggabungkan bagian profil dan menu dalam satu area gulir. |
   | `SliverPadding` | Memberi jarak di sekitar bagian profil dan grid. |
   | `SliverToBoxAdapter` | Menghubungkan konten profil berbentuk box dengan daftar sliver. |
   | `SliverGrid` | Menyusun ketiga kartu aksi dalam grid tiga kolom. |
   | `Column` | Menyusun konten halaman atau isi kartu secara vertikal. |
   | `Row` | Menyusun tiga kartu identitas secara horizontal. |
   | `Expanded` | Membagi lebar tersedia secara merata untuk kartu identitas. |
   | `SizedBox` | Memberi jarak vertikal antarelemen. |
   | `Card` | Menjadi permukaan kartu identitas dengan elevasi. |
   | `Padding` | Memberi ruang antara isi dan tepi kartu. |
   | [Text](https://api.flutter.dev/flutter/widgets/Text-class.html) | Menampilkan judul, identitas, sambutan, label, dan pesan. |
   | [Material](https://api.flutter.dev/flutter/material/Material-class.html) | Menjadi permukaan berwarna untuk kartu aksi dan efek tinta. |
   | [InkWell](https://api.flutter.dev/flutter/material/InkWell-class.html) | Mendeteksi ketukan serta memberikan respons visual pada kartu aksi. |
   | `Center` | Memusatkan susunan ikon dan label dalam kartu aksi. |
   | [Icon](https://api.flutter.dev/flutter/widgets/Icon-class.html) | Menampilkan simbol folder, tambah, dan logout. |
   | `SnackBar` | Menampilkan pesan sementara sesuai tombol yang ditekan. |

   Rujukan fungsi bawaan: [widget layout](https://docs.flutter.dev/ui/widgets/layout), [komponen Material](https://docs.flutter.dev/ui/widgets/material), dan [SliverGrid](https://api.flutter.dev/flutter/widgets/SliverGrid-class.html).

   `Theme` dan `ScaffoldMessenger` juga digunakan melalui pencarian ancestor, tetapi tidak dibuat langsung oleh kode halaman. `MaterialApp` menyediakan lingkungan tema dan root `ScaffoldMessenger`; messenger mengelola SnackBar bagi `Scaffold` turunannya. [Dokumentasi ScaffoldMessenger](https://docs.flutter.dev/release/breaking-changes/scaffold-messenger).

   `ThemeData`, `ColorScheme`, `TextStyle`, `EdgeInsets`, `BorderRadius`, `Color`, dan `IconData` merupakan objek konfigurasi/data, bukan widget. Begitu pula model `PortfolioProfile`/`ItemHomepage` dan delegate `SliverChildBuilderDelegate`/`SliverGridDelegateWithFixedCrossAxisCount`: delegate mengatur pembangunan serta tata letak grid, bukan node widget tambahan.

3. **Apa peran MaterialApp dan mengapa ditempatkan di bagian atas aplikasi?**

   Root yang dikirim ke `runApp()` sebenarnya adalah `MyApp`. Hasil `MyApp.build()` berupa `MaterialApp`, yang menjadi pembungkus utama konfigurasi aplikasi. Penempatan ini membuat halaman di bawahnya memakai tema dan layanan aplikasi yang konsisten.

   Pada proyek ini, `MaterialApp` menetapkan judul, `ThemeData`, skema warna, penggunaan Material 3, serta `home: MyHomePage(profile: portfolioOwner)`. `home` menjadi rute awal yang dikelola Navigator. MaterialApp juga membangun fasilitas seperti tema, lokalisasi, dan dukungan navigasi yang diperlukan aplikasi Material. Karena halaman memakai `Scaffold`, `AppBar`, kartu, dan SnackBar, konfigurasi tersebut cukup dipusatkan di satu tempat. `Scaffold` tetap bertanggung jawab atas tata letak satu halaman. [Dokumentasi MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html).

4. **Apa perbedaan StatelessWidget dan StatefulWidget serta kapan digunakan?**

   `StatelessWidget` tidak memiliki objek `State` lokal yang mutable. Tampilan ditentukan oleh konfigurasi konstruktor dan dependensi dari context. Widget ini tetap dapat mengalami rebuild ketika parent memberi konfigurasi baru atau dependensi seperti tema berubah. Pilih jenis ini untuk komponen yang menerima data dan callback, seperti `InfoCard`, `ItemCard`, dan `MyHomePage` saat ini. [Dokumentasi StatelessWidget](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html).

   `StatefulWidget` digunakan ketika komponen perlu menyimpan perubahan selama hidupnya, misalnya pilihan filter, hitungan, atau status formulir. Objek widget tetap immutable; data berubah disimpan pada objek `State` terpisah. `setState()` memberi tahu framework bahwa tampilan perlu dibangun ulang setelah perubahan data. `State` juga menyediakan lifecycle untuk mengelola controller atau subscription. [Dokumentasi StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).

   Ketukan tombol tidak otomatis mengharuskan halaman menjadi stateful. Pada aplikasi ini, ketukan hanya meminta `ScaffoldMessenger` menampilkan pesan; halaman sendiri tidak mengubah data profil atau menu.

5. **Apa itu BuildContext dan bagaimana penggunaannya?**

   `BuildContext` adalah handle lokasi widget dalam tree, bukan tempat penyimpanan data aplikasi. Context berkaitan dengan `Element` yang memasang widget pada tree. Framework memberikannya kepada `build()` dan callback builder agar kode dapat menemukan dependensi atau layanan yang sesuai dengan lokasi tersebut. Pencarian ancestor bergerak ke atas; context parent tidak dapat menemukan widget baru yang berada di bawahnya. [Dokumentasi BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html).

   Dalam `MyHomePage.build()`, `Theme.of(context).colorScheme.primary` membaca tema ancestor untuk warna AppBar. Context halaman berada di bawah MaterialApp sehingga tema tersedia. Sebaliknya, context milik `MyApp.build()` berada di atas MaterialApp yang baru dikembalikannya. [Dokumentasi Theme.of](https://api.flutter.dev/flutter/material/Theme/of.html).

   Callback builder grid memberikan context kepada `_handleMenuAction()`. `ScaffoldMessenger.of(context)` memperoleh messenger ancestor, kemudian `hideCurrentSnackBar()` dan `showSnackBar()` mengatur pesan. Jika nanti handler memakai `await`, periksa `if (!context.mounted) return;` sebelum menggunakan context setelah operasi selesai, karena widget mungkin sudah dilepas dari tree. Handler sekarang bersifat sinkron. [Dokumentasi ScaffoldMessenger](https://api.flutter.dev/flutter/material/ScaffoldMessenger-class.html) dan [context.mounted](https://api.flutter.dev/flutter/widgets/BuildContext/mounted.html).

6. **Apa perbedaan hot reload, hot restart, dan full restart?**

   | Mekanisme | Dampak dan penggunaan |
   | --- | --- |
   | **Hot reload** | Memuat perubahan Dart dan rebuild sambil mempertahankan state berjalan. Tidak menjalankan ulang `main()` maupun `initState()` pada State yang dipertahankan. Cocok untuk perubahan teks, warna, dan layout. |
   | **Hot restart** | Memulai ulang aplikasi Flutter dan membuang state dalam memori. `main()` berjalan kembali dan objek State baru menjalankan `initState()`. Cocok untuk menguji inisialisasi dari awal. |
   | **Full restart** | Menghentikan aplikasi lalu build/run ulang; state memori hilang, `main()` dan `initState()` untuk State baru berjalan lagi. Prosesnya lebih lama dan diperlukan ketika kode native/platform perlu dikompilasi ulang. |

   Hot reload dan hot restart tersedia pada mode debug. Mengubah deklarasi `enum` menjadi kelas atau jumlah parameter tipe generic juga tidak didukung hot reload; gunakan restart. [Dokumentasi hot reload](https://docs.flutter.dev/tools/hot-reload).

   Initializer global/static yang nilainya sudah tersimpan sebagai state, termasuk variabel `final`, tidak dieksekusi ulang oleh hot reload; hot restart menerapkan inisialisasi baru. [Panduan VS Code](https://docs.flutter.dev/tools/vs-code#hot-reload-vs-hot-restart). Konstanta berbeda: perubahan nilai `const` didukung hot reload, sehingga perubahan `portfolioOwner` atau `portfolioActions` tidak selalu membutuhkan hot restart. [Batasan dan perilaku konstanta](https://docs.flutter.dev/tools/hot-reload#recent-code-change-is-included-but-app-state-is-excluded).

   Perubahan Kotlin/Java/Swift/Objective-C atau penambahan plugin dengan kode platform memerlukan build dan full restart. [Panduan penggunaan package](https://docs.flutter.dev/packages-and-plugins/using-packages). Saat mengganti Flutter/Dart SDK, hentikan sesi lama dan jalankan kembali dengan SDK yang dipilih; ini langkah operasional agar toolchain baru digunakan. [Panduan upgrade SDK](https://docs.flutter.dev/install/upgrade).
