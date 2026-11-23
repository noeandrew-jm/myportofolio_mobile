import 'package:flutter/widgets.dart' show Color, IconData;

/// Identitas aksi tetap sama ketika label kartu diterjemahkan atau diubah.
enum HomeAction { viewProjects, addProject, addExperience, logout }

/// Deskripsi immutable sebuah pilihan menu, tanpa perilaku atau BuildContext.
///
/// Field final dan konstruktor const memungkinkan konfigurasi menu konstan.
/// Aksi dipasangkan oleh halaman melalui callback pada widget kartu.
class ItemHomepage {
  final HomeAction action;
  final String name;
  final IconData icon;

  /// Warna eksplisit per aksi, tanpa bergantung pada indeks atau nama tombol.
  final Color backgroundColor;

  const ItemHomepage(
    this.action,
    this.name,
    this.icon, {
    required this.backgroundColor,
  });
}
