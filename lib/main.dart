import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/data/portfolio_owner.dart';
import 'package:myportofolio_mobile/menu.dart';

/// Titik masuk aplikasi; susunan halaman utama dikelola di `menu.dart`.
void main() {
  runApp(const MyApp());
}

/// Konfigurasi aplikasi yang berlaku untuk seluruh halaman.
///
/// Tema diletakkan di sini agar widget halaman dan kartu dapat mengambil warna
/// melalui [Theme.of] tanpa menduplikasi konfigurasi tampilan.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          secondary: Colors.amber[700],
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(profile: portfolioOwner),
    );
  }
}
