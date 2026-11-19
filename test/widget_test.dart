import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/data/portfolio_owner.dart';
import 'package:myportofolio_mobile/data/portfolio_content.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/models/portfolio_profile.dart';
import 'package:myportofolio_mobile/pages/portfolio_collection_page.dart';
import 'package:myportofolio_mobile/widgets/info_card.dart';

void main() {
  testWidgets('Portfolio displays profile and menu on a narrow screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(find.text(portfolioDetails.displayName), findsOneWidget);
    expect(find.byType(InfoCard), findsNWidgets(3));
    for (final field in {
      'NPM': portfolioOwner.npm,
      'Name': portfolioOwner.fullName,
      'Class': portfolioOwner.pbpClass,
    }.entries) {
      final card = find.ancestor(
        of: find.text(field.key),
        matching: find.byType(InfoCard),
      );

      expect(card, findsOneWidget);
      expect(
        find.descendant(of: card, matching: find.text(field.value)),
        findsOneWidget,
      );
    }
    expect(find.text('Burhan'), findsNothing);
    expect(
      find.text(portfolioDetails.displayName.toUpperCase()),
      findsOneWidget,
    );
    for (final action in ['Lihat Proyek', 'Tambah Proyek', 'Logout']) {
      await tester.scrollUntilVisible(
        find.text(action),
        100.0,
        scrollable: find.byType(Scrollable),
      );
      await tester.pumpAndSettle();
      expect(find.text(action).hitTestable(), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('Injected long profile name wraps fully on a narrow screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    const profile = PortfolioProfile(
      npm: '1234567890',
      fullName: 'Nama Lengkap Mahasiswa Dengan Banyak Kata Untuk Pengujian',
      pbpClass: 'PBP Z',
    );

    await tester.pumpWidget(
      const MaterialApp(home: MyHomePage(profile: profile)),
    );

    expect(find.byType(InfoCard), findsNWidgets(3));
    expect(find.text(profile.npm), findsOneWidget);
    expect(find.text(profile.pbpClass), findsOneWidget);
    final name = find.text(profile.fullName);
    expect(name, findsOneWidget);
    final paragraph = tester.renderObject<RenderParagraph>(name);
    expect(paragraph.didExceedMaxLines, isFalse);
    final nameCard = find.ancestor(of: name, matching: find.byType(InfoCard));
    final cardBounds = tester.getRect(nameCard);
    final textBounds = tester.getRect(name);
    expect(cardBounds.contains(textBounds.topLeft), isTrue);
    expect(cardBounds.contains(textBounds.bottomRight), isTrue);
    expect(tester.takeException(), isNull);

    // A taller profile must still allow access to the menu below it.
    await tester.scrollUntilVisible(
      find.text('Logout'),
      100.0,
      scrollable: find.byType(Scrollable),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Kamu telah menekan tombol Logout!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Each menu action displays its SnackBar message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    for (final action in ['Lihat Proyek', 'Tambah Proyek', 'Logout']) {
      await tester.scrollUntilVisible(
        find.text(action),
        100.0,
        scrollable: find.byType(Scrollable),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(action));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Kamu telah menekan tombol $action!'), findsOneWidget);
      if (action == 'Lihat Proyek') {
        expect(find.byType(PortfolioCollectionPage), findsOneWidget);
        tester.state<NavigatorState>(find.byType(Navigator).first).pop();
        await tester.pumpAndSettle();
      } else if (action == 'Tambah Proyek') {
        expect(find.byType(ProjectFormPage), findsOneWidget);
        tester.state<NavigatorState>(find.byType(Navigator).first).pop();
        await tester.pumpAndSettle();
      }
    }
  });

  testWidgets('Portfolio navigation opens the original web collections', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    for (final section in {
      'Projects': portfolioProjects,
      'Experience': portfolioExperiences,
      'Achievements': portfolioAchievements,
    }.entries) {
      await tester.tap(find.text(section.key));
      await tester.pumpAndSettle();
      expect(find.byType(PortfolioCollectionPage), findsOneWidget);
      for (final entry in section.value) {
        await tester.scrollUntilVisible(
          find.text(entry.title),
          200,
          scrollable: find.byType(Scrollable).last,
        );
        await tester.pumpAndSettle();
        expect(find.text(entry.title), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
      await tester.pageBack();
      await tester.pumpAndSettle();
    }
  });
}
