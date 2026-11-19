import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';

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
      elevation: 0,
      color: PortfolioColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: PortfolioColors.line),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: PortfolioColors.muted,
                fontSize: 11,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(color: PortfolioColors.ink, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
