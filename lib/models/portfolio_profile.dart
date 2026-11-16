/// Identitas pemilik portofolio, terpisah dari widget yang menampilkannya.
///
/// Model tidak bergantung pada Flutter. Semua field bersifat final dan dapat
/// dibuat sebagai konstanta karena profil tidak berubah selama aplikasi berjalan.
class PortfolioProfile {
  /// NPM disimpan sebagai teks agar digit awal, termasuk nol, tetap utuh.
  final String npm;

  /// Nama lengkap, ditampilkan tanpa singkatan atau pemotongan otomatis.
  final String fullName;

  /// Label kelas PBP yang ingin ditampilkan pada kartu Class.
  final String pbpClass;

  const PortfolioProfile({
    required this.npm,
    required this.fullName,
    required this.pbpClass,
  });
}
