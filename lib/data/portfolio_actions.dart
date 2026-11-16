import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';

/// Konfigurasi tampilan menu, terpisah dari susunan widget dan penanganan aksi.
///
/// Setiap warna melekat pada item sehingga tetap sesuai saat urutan menu
/// berubah. Warna gelap dipilih agar teks dan ikon putih tetap terbaca.
/// List const beserta model immutable dapat digunakan ulang pada setiap build.
const List<ItemHomepage> portfolioActions = [
  ItemHomepage(
    'Lihat Proyek',
    Icons.folder,
    backgroundColor: Color(0xFF1565C0),
  ),
  ItemHomepage(
    'Tambah Proyek',
    Icons.add_circle,
    backgroundColor: Color(0xFF2E7D32),
  ),
  ItemHomepage('Logout', Icons.logout, backgroundColor: Color(0xFFC62828)),
];
