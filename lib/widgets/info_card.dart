import 'package:flutter/material.dart';

/// Kartu label dan nilai yang dapat digunakan untuk berbagai informasi profil.
///
/// Semua data berasal dari konstruktor; kartu tidak menyimpan state atau
/// bergantung pada identitas pengguna tertentu.
/// Tinggi kartu mengikuti isi teks agar nama lengkap tetap terbaca pada layar
/// sempit, tanpa ellipsis, batas jumlah baris, atau pengecilan ukuran huruf.
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
