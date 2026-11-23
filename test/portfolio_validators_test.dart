import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/forms/portfolio_validators.dart';

void main() {
  test('counts Unicode code points after trimming like Django CharField', () {
    String? validate(String name) =>
        validatePortfolioText(name, label: 'Nama peran', maxLength: 255);

    expect(validate('  ${'🚀' * 255}  '), isNull);
    // Satu aksen gabungan tetap terdiri dari dua code point (e dan aksen).
    expect(validate('${'🚀' * 254}e\u0301'), isNotNull);
  });

  test('checks web hosts and port bounds without throwing on pasted URLs', () {
    for (final value in [
      '',
      '  https://contoh.id/proyek?q=flutter  ',
      'https://café.id',
      'http://127.0.0.1:8080/demo',
      'http://[::1]:8080/demo',
    ]) {
      expect(validateProjectUrl(value), isNull, reason: value);
    }
    for (final value in [
      '/proyek',
      'ftp://contoh.id',
      'https://contoh..id',
      'https://-contoh.id',
      'https://contoh.id:65536',
      'https://contoh.id:${'9' * 40}',
      'http://127.0.0.999',
      'https://%ff.id',
      'https://contoh.id/a b',
    ]) {
      expect(validateProjectUrl(value), isNotNull, reason: value);
    }
  });
}
