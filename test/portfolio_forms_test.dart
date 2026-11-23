import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';

Future<void> tapVisible(WidgetTester tester, Finder target) async {
  await tester.ensureVisible(target);
  await tester.pumpAndSettle();
  expect(target.hitTestable(), findsOneWidget);
  await tester.tap(target);
  await tester.pumpAndSettle();
}

Finder field(String label) => find.widgetWithText(TextField, label);

Future<void> fillField(WidgetTester tester, String label, String value) async {
  final input = field(label);
  await tester.ensureVisible(input);
  await tester.enterText(input, value);
  await tester.pump();
}

Future<void> pickDate(WidgetTester tester, String label, DateTime date) async {
  await tapVisible(tester, find.widgetWithText(InputDecorator, label));
  final dialog = find.byType(DatePickerDialog);
  final labels = MaterialLocalizations.of(tester.element(dialog));
  await tester.tap(find.byTooltip(labels.inputDateModeButtonLabel));
  await tester.pumpAndSettle();
  await tester.enterText(
    find.descendant(of: dialog, matching: find.byType(EditableText)),
    labels.formatCompactDate(date),
  );
  await tapVisible(tester, find.text(labels.okButtonLabel));
  expect(dialog, findsNothing);
}

Future<void> chooseDrawerItem(WidgetTester tester, String title) async {
  final labels = MaterialLocalizations.of(tester.element(find.byType(AppBar)));
  await tester.tap(find.byTooltip(labels.openAppDrawerTooltip));
  await tester.pumpAndSettle();
  await tapVisible(tester, find.widgetWithText(ListTile, title));
}

void main() {
  testWidgets('Experience opens from its card and drawer and returns Home', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    final card = find.text('Tambah Pengalaman');
    await tester.scrollUntilVisible(
      card,
      180,
      scrollable: find.byType(Scrollable),
    );
    await tapVisible(tester, card);
    expect(find.byType(ExperienceFormPage), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);

    await chooseDrawerItem(tester, 'Add Project');
    expect(find.byType(ProjectFormPage), findsOneWidget);
    await chooseDrawerItem(tester, 'Add Experience');
    expect(find.byType(ExperienceFormPage), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);

    await chooseDrawerItem(tester, 'Add Experience');
    await fillField(tester, 'Nama peran', 'Asisten praktikum');
    await chooseDrawerItem(tester, 'Add Experience');
    expect(find.text('Asisten praktikum'), findsOneWidget);
    await chooseDrawerItem(tester, 'Home');
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(tester.state<NavigatorState>(find.byType(Navigator)).canPop(), isFalse);
  });

  testWidgets('Experience validates fields and dates on a phone', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 640);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(theme: portfolioTheme, home: const ExperienceFormPage()),
    );

    await fillField(tester, 'Nama peran', '   ');
    tester.view.viewInsets = const FakeViewPadding(bottom: 250);
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('Simpan'));
    expect(find.text('Isi nama peran.'), findsOneWidget);
    expect(find.text('Isi deskripsi pengalaman.'), findsOneWidget);
    expect(find.text('Pilih tanggal mulai.'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    tester.view.resetViewInsets();
    await tester.pumpAndSettle();

    await fillField(tester, 'Nama peran', 'a' * 256);
    await tapVisible(tester, find.text('Simpan'));
    expect(find.text('Nama peran maksimal 255 karakter.'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);

    await fillField(tester, 'Nama peran', 'Pengembang Flutter');
    await fillField(tester, 'Deskripsi', 'Merancang aplikasi ponsel.');
    await tapVisible(tester, find.byType(DropdownButton<String>));
    await tapVisible(tester, find.text('Freelance').last);
    await pickDate(tester, 'Tanggal mulai', DateTime(2024, 1, 2));
    await pickDate(tester, 'Tanggal selesai (opsional)', DateTime(2024, 3, 8));
    await pickDate(tester, 'Tanggal mulai', DateTime(2024, 4, 10));
    await tapVisible(tester, find.text('Simpan'));
    expect(
      find.text('Tanggal selesai tidak boleh sebelum tanggal mulai.'),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);

    await pickDate(tester, 'Tanggal mulai', DateTime(2024, 2, 3));
    await tapVisible(tester, find.text('Simpan'));
    final dialog = find.byType(AlertDialog);
    for (final value in [
      'Pengembang Flutter',
      'Freelance',
      'Merancang aplikasi ponsel.',
      '03/02/2024',
      '08/03/2024',
    ]) {
      expect(
        find.descendant(of: dialog, matching: find.textContaining(value)),
        findsOneWidget,
      );
    }
    await tapVisible(tester, find.text('Tutup'));
    expect(dialog, findsNothing);
    expect(find.byType(ExperienceFormPage), findsOneWidget);
    await tapVisible(tester, find.byTooltip('Hapus tanggal selesai'));
    await tapVisible(tester, find.text('Simpan'));
    expect(
      find.descendant(
        of: dialog,
        matching: find.textContaining('Masih berlangsung'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: dialog, matching: find.textContaining('08/03/2024')),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Project validates the link, summarizes entries and resets them',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(theme: portfolioTheme, home: const ProjectFormPage()),
      );
      await fillField(tester, 'Nama Proyek', 'Jejak');
      await fillField(tester, 'Deskripsi Proyek', 'Catatan pendakian.');
      await tapVisible(tester, find.byType(DropdownButton<String>));
      await tapVisible(tester, find.text('Mobile Development').last);
      await fillField(tester, 'Teknologi yang Digunakan', 'Dart');
      await fillField(tester, 'Tautan Proyek', 'bukan-url');
      await tapVisible(tester, find.text('Simpan'));
      expect(
        find.text('Masukkan URL http atau https yang lengkap.'),
        findsOneWidget,
      );
      expect(find.byType(AlertDialog), findsNothing);

      await fillField(tester, 'Tautan Proyek', 'https://example.com/jejak');
      await tapVisible(tester, find.text('Simpan'));
      final dialog = find.byType(AlertDialog);
      for (final value in [
        'Jejak',
        'Catatan pendakian.',
        'Mobile Development',
        'Dart',
        'https://example.com/jejak',
      ]) {
        expect(
          find.descendant(of: dialog, matching: find.textContaining(value)),
          findsOneWidget,
        );
      }
      await tapVisible(tester, find.text('OK'));
      expect(dialog, findsNothing);
      expect(
        tester.widget<TextField>(field('Nama Proyek')).controller!.text,
        isEmpty,
      );
      expect(
        tester.widget<TextField>(field('Tautan Proyek')).controller!.text,
        isEmpty,
      );
      expect(
        tester
            .widget<DropdownButton<String>>(find.byType(DropdownButton<String>))
            .value,
        'Web Development',
      );
    },
  );
}
