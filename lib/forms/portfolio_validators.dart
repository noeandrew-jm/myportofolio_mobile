/// Memeriksa teks sesudah spasi tepi disingkirkan. Django menghitung
/// `CharField.max_length` dalam Unicode code point, sehingga huruf dan emoji
/// dinilai dengan aturan yang sama saat data dipakai pada portofolio web.
String? validatePortfolioText(
  String? value, {
  required String label,
  String? emptyMessage,
  int? maxLength,
}) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) return emptyMessage;
  if (maxLength != null && text.runes.length > maxLength) {
    return '$label maksimal $maxLength karakter.';
  }
  return null;
}

final _invalidUrlCharacter = RegExp(r'[\s\\\x00-\x1f\x7f]');
final _hostnameLabel = RegExp(
  r'^[\p{L}\p{N}](?:[\p{L}\p{M}\p{N}-]{0,61}[\p{L}\p{M}\p{N}])?$',
  unicode: true,
);
final _numericHost = RegExp(r'^[0-9.]+$');

/// Tautan opsional harus dapat dibuka di peramban. [Uri.tryParse] juga menerima
/// referensi relatif dan beberapa bentuk host yang bukan alamat web.
String? validateProjectUrl(String? value) {
  final link = value?.trim() ?? '';
  if (link.isEmpty) return null;
  if (link.runes.length > 200) return 'Tautan maksimal 200 karakter.';
  const invalid = 'Masukkan URL http atau https yang lengkap.';
  final uri = Uri.tryParse(link);
  if (uri == null ||
      (uri.scheme != 'http' && uri.scheme != 'https') ||
      uri.host.isEmpty ||
      _invalidUrlCharacter.hasMatch(link)) {
    return invalid;
  }
  try {
    if (uri.port < 1 || uri.port > 65535) return invalid;
    // Uri sudah memeriksa IPv6 saat membaca host dalam kurung siku.
    if (!uri.host.contains(':')) {
      final host = Uri.decodeComponent(uri.host);
      final name = host.endsWith('.')
          ? host.substring(0, host.length - 1)
          : host;
      if (_numericHost.hasMatch(name)) {
        Uri.parseIPv4Address(name);
      } else if (name != 'localhost' &&
          (!name.contains('.') ||
              !name.split('.').every(_hostnameLabel.hasMatch))) {
        return invalid;
      }
    }
  } on FormatException {
    // Port di luar jangkauan integer atau escape UTF-8 rusak pada hostname.
    return invalid;
  }
  return null;
}

/// Tanggal yang sama sah untuk pengalaman satu hari. Tanggal selesai kosong
/// menandai pengalaman yang masih berlangsung pada model portofolio.
String? validateExperienceEnd(DateTime? start, DateTime? end) {
  if (start != null && end != null && end.isBefore(start)) {
    return 'Tanggal selesai tidak boleh sebelum tanggal mulai.';
  }
  return null;
}
