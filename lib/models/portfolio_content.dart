/// Informasi publik pemilik yang ditampilkan pada portofolio web dan mobile.
///
/// Model hanya menyimpan data agar widget dapat menyusun tampilan tanpa
/// bergantung pada template atau database website.
class PortfolioDetails {
  final String displayName;
  final String bio;
  final String studyProgram;
  final String university;
  final String email;
  final String githubUrl;
  final String linkedinUrl;
  final List<String> roles;

  const PortfolioDetails({
    required this.displayName,
    required this.bio,
    required this.studyProgram,
    required this.university,
    required this.email,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.roles,
  });
}

/// Satu karya, pengalaman, atau prestasi beserta deskripsi publiknya.
///
/// Gambar memakai aset lokal agar konten tetap tersedia tanpa koneksi jaringan.
/// Konfigurasi proyek membuat instance dan daftar tag sebagai konstanta.
class PortfolioEntry {
  final String title;
  final String subtitle;
  final String description;
  final String? imageAsset;
  final String? period;
  final String? linkUrl;
  final List<String> tags;

  const PortfolioEntry({
    required this.title,
    required this.subtitle,
    required this.description,
    this.imageAsset,
    this.period,
    this.linkUrl,
    this.tags = const [],
  });
}
