import 'package:material_ui/material_ui.dart';

/// Mengembalikan `true` hanya jika pengguna menekan tombol dialog. Formulir
/// proyek memakai hasil ini untuk membedakan konfirmasi dari tombol kembali.
Future<bool?> showFormSummary(
  BuildContext context, {
  required String title,
  required Map<String, String> fields,
  required String closeLabel,
}) {
  FocusScope.of(context).unfocus();
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      title: Text(title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          for (final field in fields.entries)
            Text('${field.key}: ${field.value}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(closeLabel),
        ),
      ],
    ),
  );
}
