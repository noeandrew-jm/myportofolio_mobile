import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/data/portfolio_actions.dart';
import 'package:myportofolio_mobile/data/portfolio_content.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/models/portfolio_profile.dart';
import 'package:myportofolio_mobile/pages/portfolio_collection_page.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:myportofolio_mobile/widgets/info_card.dart';
import 'package:myportofolio_mobile/widgets/item_card.dart';
import 'package:myportofolio_mobile/widgets/portfolio_hero.dart';

/// Halaman profil stateless dengan konten dan identitas dari konfigurasi.
///
/// Navigator mengelola perpindahan halaman, sementara ScaffoldMessenger
/// mengelola umpan balik aksi. Halaman tidak membutuhkan state lokal.
class MyHomePage extends StatelessWidget {
  final PortfolioProfile profile;

  const MyHomePage({super.key, required this.profile});

  static const _collections = [
    PortfolioCollectionPage(
      title: 'Projects',
      introduction: 'Karya yang saya bangun',
      entries: portfolioProjects,
    ),
    PortfolioCollectionPage(
      title: 'Experience',
      introduction:
          'My growing path across software engineering, fintech, '
          'and student-led collaboration.',
      entries: portfolioExperiences,
    ),
    PortfolioCollectionPage(
      title: 'Achievements',
      introduction: 'Milestones in technology, innovation, and collaboration.',
      entries: portfolioAchievements,
    ),
  ];

  void _openCollection(BuildContext context, PortfolioCollectionPage page) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (context) => page));
  }

  /// Seluruh aksi tetap memberikan pesan sesuai label untuk kriteria Tugas 7.
  void _handleMenuAction(BuildContext context, ItemHomepage item) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Kamu telah menekan tombol ${item.name}!')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                portfolioDetails.displayName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const Text('.', style: TextStyle(color: PortfolioColors.accent)),
          ],
        ),
        actions: [
          PopupMenuButton<PortfolioCollectionPage>(
            tooltip: 'Navigasi portofolio',
            icon: const Icon(Icons.more_horiz),
            onSelected: (page) => _openCollection(context, page),
            itemBuilder: (context) => [
              for (final page in _collections)
                PopupMenuItem(value: page, child: Text(page.title)),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.9, -0.1),
            radius: 1.2,
            colors: [Color(0xFF24142F), PortfolioColors.background],
          ),
        ),
        child: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontal = constraints.maxWidth > 1100
                  ? (constraints.maxWidth - 1060) / 2
                  : 16.0;
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(horizontal, 12, horizontal, 0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: InfoCard(
                                  title: 'NPM',
                                  content: profile.npm,
                                ),
                              ),
                              Expanded(
                                child: InfoCard(
                                  title: 'Name',
                                  content: profile.fullName,
                                ),
                              ),
                              Expanded(
                                child: InfoCard(
                                  title: 'Class',
                                  content: profile.pbpClass,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              for (final page in _collections)
                                TextButton(
                                  onPressed: () =>
                                      _openCollection(context, page),
                                  style: TextButton.styleFrom(
                                    foregroundColor: PortfolioColors.ink,
                                  ),
                                  child: Text(page.title),
                                ),
                            ],
                          ),
                          const SizedBox(height: 36),
                          PortfolioHero(
                            details: portfolioDetails,
                            onViewWork: () =>
                                _openCollection(context, _collections.first),
                          ),
                          const SizedBox(height: 44),
                          const Divider(color: PortfolioColors.line),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Menu Portofolio',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                  color: PortfolioColors.ink,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(horizontal, 0, horizontal, 32),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        // Tinggi bertambah mengikuti pengaturan ukuran teks.
                        mainAxisExtent:
                            132 *
                            MediaQuery.textScalerOf(context).scale(14) /
                            14,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = portfolioActions[index];
                        return ItemCard(
                          item,
                          onTap: () => _handleMenuAction(context, item),
                        );
                      }, childCount: portfolioActions.length),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(horizontal, 0, horizontal, 28),
                    sliver: const SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Divider(color: PortfolioColors.line),
                          SizedBox(height: 20),
                          Text(
                            '© 2026 Noe Andrew\nFakultas Ilmu Komputer, Universitas Indonesia.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: PortfolioColors.muted,
                              fontSize: 12,
                              height: 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
