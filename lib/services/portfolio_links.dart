import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Membuka kontak atau karya melalui aplikasi perangkat yang sesuai.
///
/// Tautan tetap dapat disalin bila perangkat tidak memiliki aplikasi pembuka.
/// Context diperiksa setelah operasi asinkron karena halaman dapat ditutup.
Future<void> openPortfolioLink(BuildContext context, String url) async {
  try {
    if (await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      return;
    }
  } on Exception {
    // Kegagalan platform ditampilkan sebagai umpan balik yang bisa ditindak.
  }
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Tautan belum dapat dibuka pada perangkat ini.'),
      action: SnackBarAction(
        label: 'Salin',
        onPressed: () async {
          try {
            await Clipboard.setData(ClipboardData(text: url));
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tautan berhasil disalin.')),
            );
          } on PlatformException {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Salin tautan ini secara manual: $url')),
            );
          }
        },
      ),
    ),
  );
}
