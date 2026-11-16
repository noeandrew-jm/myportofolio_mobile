import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/models/portfolio_profile.dart';
import 'package:myportofolio_mobile/widgets/info_card.dart';
import 'package:myportofolio_mobile/widgets/item_card.dart';

/// Halaman utama yang menyusun informasi profil dan pilihan menu.
///
/// Tidak ada data lokal yang berubah saat tombol ditekan. Umpan balik dikelola
/// oleh [ScaffoldMessenger], sehingga halaman cukup berupa [StatelessWidget]
/// tanpa [State] atau pemanggilan `setState`.
class MyHomePage extends StatelessWidget {
  /// Profil diberikan oleh bootstrap agar halaman tidak menyimpan identitas
  /// tertentu dan dapat digunakan kembali dengan data pemilik yang berbeda.
  final PortfolioProfile profile;

  const MyHomePage({super.key, required this.profile});

  // Konfigurasi tetap dibagikan oleh semua instance halaman. List dan isinya
  // bersifat konstan, sehingga tidak dialokasikan ulang setiap kali build.
  static const List<ItemHomepage> _items = [
    ItemHomepage('Lihat Proyek', Icons.folder),
    ItemHomepage('Tambah Proyek', Icons.add_circle),
    ItemHomepage('Logout', Icons.logout),
  ];

  /// Menangani aksi di tingkat halaman agar kartu hanya mengurus tampilan.
  ///
  /// Tutorial ini menampilkan umpan balik saja, termasuk untuk tombol Logout.
  /// Saat navigasi/autentikasi ditambahkan, perilaku dapat diubah di sini tanpa
  /// mengikat widget kartu pada rute atau layanan tertentu.
  void _handleMenuAction(BuildContext context, ItemHomepage item) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Kamu telah menekan tombol ${item.name}!')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        // Satu viewport menangani profil dan grid. SliverGrid menghindari
        // pengukuran shrinkWrap pada grid di dalam scroll view lain.
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      // Tinggi kartu mengikuti isi nama, tanpa pengukuran
                      // IntrinsicHeight tambahan atau pemotongan teks.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InfoCard(title: 'NPM', content: profile.npm),
                        ),
                        Expanded(
                          child: InfoCard(
                            title: 'Name',
                            content: profile.fullName,
                          ),
                        ),
                        Expanded(
                          child: InfoCard(
                            title: 'Class',
                            content: profile.pbpClass,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    const Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(36.0, 20.0, 36.0, 36.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 144.0,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = _items[index];
                  return ItemCard(
                    item,
                    onTap: () => _handleMenuAction(context, item),
                  );
                }, childCount: _items.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
