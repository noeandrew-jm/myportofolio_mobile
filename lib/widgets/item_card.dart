import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';

/// Menampilkan pilihan menu dan meneruskan interaksi melalui [onTap].
///
/// Pemilik kartu menentukan efek aksi, misalnya SnackBar atau navigasi. Kartu
/// tidak perlu mengetahui halaman tujuan maupun cara autentikasi bekerja.
/// Warna latar berasal dari model, sehingga setiap aksi memiliki warna sendiri
/// tanpa percabangan berdasarkan teks tombol di dalam widget.
class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final VoidCallback onTap;

  const ItemCard(this.item, {super.key, required this.onTap});

  static const BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(12.0),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.backgroundColor,
      borderRadius: _borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: _borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const SizedBox(height: 6.0),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
