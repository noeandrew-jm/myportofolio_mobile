import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/forms/portfolio_validators.dart';
import 'package:myportofolio_mobile/widgets/form_summary.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/portfolio_form_body.dart';

/// Menampilkan isian proyek untuk diperiksa sebelum mengosongkan formulir.
class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  static const _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  final _formKey = GlobalKey<FormState>();
  String _projectName = '';
  String _description = '';
  String _category = _categories.first;
  String _technologies = '';
  String _projectLink = '';

  Future<void> _submit() async {
    final form = _formKey.currentState!;
    if (!form.validate()) return;
    form.save();
    final confirmed = await showFormSummary(
      context,
      title: 'Ringkasan Proyek',
      closeLabel: 'OK',
      fields: {
        'Nama Proyek': _projectName,
        'Deskripsi': _description,
        'Kategori': _category,
        'Teknologi': _technologies.isEmpty ? '—' : _technologies,
        'Tautan': _projectLink.isEmpty ? '—' : _projectLink,
      },
    );
    if (mounted && confirmed == true) form.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Proyek')),
      drawer: const LeftDrawer(currentPage: DrawerPage.project),
      body: Form(
        key: _formKey,
        child: PortfolioFormBody(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nama Proyek'),
              textInputAction: TextInputAction.next,
              validator: (value) => validatePortfolioText(
                value,
                label: 'Nama proyek',
                emptyMessage: 'Nama proyek tidak boleh kosong!',
                maxLength: 255,
              ),
              onSaved: (value) => _projectName = value!.trim(),
            ),
            TextFormField(
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Deskripsi Proyek'),
              validator: (value) => validatePortfolioText(
                value,
                label: 'Deskripsi proyek',
                emptyMessage: 'Deskripsi proyek tidak boleh kosong!',
              ),
              onSaved: (value) => _description = value!.trim(),
            ),
            DropdownButtonFormField<String>(
              initialValue: _categories.first,
              decoration: const InputDecoration(labelText: 'Kategori Proyek'),
              isExpanded: true,
              items: [
                for (final category in _categories)
                  DropdownMenuItem(value: category, child: Text(category)),
              ],
              onChanged: (_) {},
              onSaved: (value) => _category = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Teknologi yang Digunakan',
                hintText: 'Contoh: Flutter, Django, Figma',
              ),
              textInputAction: TextInputAction.next,
              validator: (value) => validatePortfolioText(
                value,
                label: 'Teknologi',
                maxLength: 255,
              ),
              onSaved: (value) => _technologies = value?.trim() ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tautan Proyek',
                hintText: 'https://contoh.id (opsional)',
              ),
              keyboardType: TextInputType.url,
              autocorrect: false,
              validator: validateProjectUrl,
              onSaved: (value) => _projectLink = value?.trim() ?? '',
            ),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.check),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
