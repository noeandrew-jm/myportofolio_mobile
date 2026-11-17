import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/portfolio_content.dart';
import 'package:myportofolio_mobile/services/portfolio_links.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';

/// Menampilkan koleksi portofolio dari data lokal yang diberikan oleh halaman.
///
/// Satu list membangun konten sesuai viewport. Kartu mengikuti tinggi teks dan
/// beralih ke susunan horizontal ketika ruang cukup untuk gambar dan uraian.
class PortfolioCollectionPage extends StatelessWidget {
  final String title;
  final String introduction;
  final List<PortfolioEntry> entries;

  const PortfolioCollectionPage({
    super.key,
    required this.title,
    required this.introduction,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PortfolioColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: PortfolioColors.background,
        foregroundColor: PortfolioColors.ink,
        surfaceTintColor: Colors.transparent,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.1,
            colors: [Color(0xFF25142F), PortfolioColors.background],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                itemCount: entries.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _CollectionIntroduction(
                      title: title,
                      introduction: introduction,
                      isEmpty: entries.isEmpty,
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _PortfolioEntryCard(entry: entries[index - 1]),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CollectionIntroduction extends StatelessWidget {
  final String title;
  final String introduction;
  final bool isEmpty;

  const _CollectionIntroduction({
    required this.title,
    required this.introduction,
    required this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF737985), Color(0xFFBBCDD7)],
              ).createShader(bounds),
              child: Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  letterSpacing: -1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            introduction,
            style: const TextStyle(
              color: PortfolioColors.muted,
              fontSize: 16,
              height: 1.7,
            ),
          ),
          if (isEmpty) ...[
            const SizedBox(height: 32),
            const Text(
              'Belum ada item untuk ditampilkan.',
              style: TextStyle(color: PortfolioColors.ink, height: 1.6),
            ),
          ],
        ],
      ),
    );
  }
}

class _PortfolioEntryCard extends StatelessWidget {
  final PortfolioEntry entry;

  const _PortfolioEntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: PortfolioColors.surface,
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: PortfolioColors.line),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageAsset = entry.imageAsset;
          final details = _EntryDetails(entry: entry);
          if (imageAsset == null) {
            return details;
          }

          // BoxFit.contain keeps certificates and project screenshots complete.
          final image = AspectRatio(
            aspectRatio: 16 / 10,
            child: ColoredBox(
              color: PortfolioColors.background,
              child: Image.asset(
                imageAsset,
                fit: BoxFit.contain,
                semanticLabel: entry.title,
              ),
            ),
          );
          if (constraints.maxWidth >= 720) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: image),
                Expanded(flex: 6, child: details),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [image, details],
          );
        },
      ),
    );
  }
}

class _EntryDetails extends StatelessWidget {
  final PortfolioEntry entry;

  const _EntryDetails({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (entry.period != null) ...[
            Text(
              entry.period!,
              style: const TextStyle(
                color: PortfolioColors.accent,
                fontSize: 13,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 10),
          ],
          if (entry.subtitle.isNotEmpty) ...[
            Text(
              entry.subtitle,
              style: const TextStyle(
                color: PortfolioColors.accent,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Semantics(
            header: true,
            child: Text(
              entry.title,
              style: const TextStyle(
                color: PortfolioColors.ink,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 1.3,
                letterSpacing: -0.4,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            entry.description,
            style: const TextStyle(
              color: PortfolioColors.muted,
              fontSize: 15,
              height: 1.7,
            ),
          ),
          if (entry.tags.isNotEmpty) ...[
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tag in entry.tags)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: PortfolioColors.line),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: PortfolioColors.ink,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ],
          if (entry.linkUrl != null) ...[
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => openPortfolioLink(context, entry.linkUrl!),
              icon: const Icon(Icons.north_east, size: 18),
              label: const Text('Visit project'),
            ),
          ],
        ],
      ),
    );
  }
}
