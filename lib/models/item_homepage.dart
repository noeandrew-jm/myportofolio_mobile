import 'package:flutter/material.dart' show IconData;

/// Deskripsi immutable sebuah pilihan menu, tanpa perilaku atau BuildContext.
///
/// Field final dan konstruktor const memungkinkan konfigurasi menu konstan.
/// Aksi dipasangkan oleh halaman melalui callback pada widget kartu.
class ItemHomepage {
  final String name;
  final IconData icon;

  const ItemHomepage(this.name, this.icon);
}
