import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/forms/portfolio_validators.dart';
import 'package:myportofolio_mobile/widgets/form_summary.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/portfolio_form_body.dart';

/// Ringkasan bisa ditutup dan diperiksa ulang tanpa kehilangan isian pengalaman.
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  static const _categories = [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
  ];

  final _formKey = GlobalKey<FormState>();
  final _startField = GlobalKey<FormFieldState<DateTime>>();
  final _endField = GlobalKey<FormFieldState<DateTime>>();
  String _role = '';
  String _category = 'Full-Time';
  String _description = '';

  static String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString().padLeft(4, '0');
    return '$day/$month/$year';
  }

  /// Field menyimpan tanggal sebagai DateTime. Menghapus tanggal selesai juga
  /// langsung mengubah nilai yang dipakai validator dan dialog.
  Widget _dateField({required bool isStart}) {
    final label = isStart ? 'Tanggal mulai' : 'Tanggal selesai (opsional)';
    return FormField<DateTime>(
      key: isStart ? _startField : _endField,
      validator: isStart
          ? (date) => date == null ? 'Pilih tanggal mulai.' : null
          : (date) =>
                validateExperienceEnd(_startField.currentState?.value, date),
      builder: (field) {
        final selected = field.value;
        return Semantics(
          button: true,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () async {
              final date = await showDatePicker(
                context: field.context,
                helpText: isStart ? 'Tanggal mulai' : 'Tanggal selesai',
                initialDate:
                    selected ??
                    _startField.currentState?.value ??
                    DateTime.now(),
                firstDate: DateTime(1),
                lastDate: DateTime(9999, 12, 31),
                cancelText: 'Batal',
                confirmText: 'OK',
              );
              if (date != null && field.mounted) field.didChange(date);
            },
            child: InputDecorator(
              isEmpty: selected == null,
              decoration: InputDecoration(
                labelText: label,
                errorText: field.errorText,
                prefixIcon: Icon(
                  isStart
                      ? Icons.calendar_today_outlined
                      : Icons.event_outlined,
                ),
                helperText: isStart
                    ? null
                    : 'Kosongkan jika masih berlangsung.',
                suffixIcon: isStart || selected == null
                    ? null
                    : IconButton(
                        tooltip: 'Hapus tanggal selesai',
                        icon: const Icon(Icons.clear),
                        onPressed: () => field.didChange(null),
                      ),
              ),
              child: Text(selected == null ? '' : _formatDate(selected)),
            ),
          ),
        );
      },
    );
  }

  void _showSummary() {
    final form = _formKey.currentState!;
    if (!form.validate()) return;
    form.save();
    final end = _endField.currentState!.value;
    showFormSummary(
      context,
      title: 'Ringkasan pengalaman',
      closeLabel: 'Tutup',
      fields: {
        'Nama peran': _role,
        'Kategori': _category,
        'Deskripsi': _description,
        'Tanggal mulai': _formatDate(_startField.currentState!.value!),
        'Tanggal selesai': end == null ? 'Masih berlangsung' : _formatDate(end),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pengalaman')),
      drawer: const LeftDrawer(currentPage: DrawerPage.experience),
      body: Form(
        key: _formKey,
        child: PortfolioFormBody(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nama peran'),
              textInputAction: TextInputAction.next,
              validator: (value) => validatePortfolioText(
                value,
                label: 'Nama peran',
                emptyMessage: 'Isi nama peran.',
                maxLength: 255,
              ),
              onSaved: (value) => _role = value!.trim(),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Kategori'),
              initialValue: 'Full-Time',
              isExpanded: true,
              items: [
                for (final category in _categories)
                  DropdownMenuItem(value: category, child: Text(category)),
              ],
              onChanged: (_) {},
              onSaved: (value) => _category = value!,
              validator: (value) => _categories.contains(value)
                  ? null
                  : 'Pilih kategori pengalaman.',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              minLines: 3,
              maxLines: 6,
              validator: (value) => validatePortfolioText(
                value,
                label: 'Deskripsi',
                emptyMessage: 'Isi deskripsi pengalaman.',
              ),
              onSaved: (value) => _description = value!.trim(),
            ),
            _dateField(isStart: true),
            _dateField(isStart: false),
            FilledButton.icon(
              onPressed: _showSummary,
              icon: const Icon(Icons.check),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
