import 'package:flutter/widgets.dart';
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
    return MergeSemantics(
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
        decoration: BoxDecoration(
          color: PortfolioColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: PortfolioColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                border: BorderDirectional(
                  start: BorderSide(color: PortfolioColors.accent, width: 2),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 6),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: PortfolioColors.muted,
                    fontSize: 12,
                    height: 1.25,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                color: PortfolioColors.ink,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
