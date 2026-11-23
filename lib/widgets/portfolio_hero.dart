import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/portfolio_content.dart';
import 'package:myportofolio_mobile/services/portfolio_links.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';

/// Adaptasi profil web dengan foto asli, judul perak, dan detail kontak.
/// Layout mengikuti lebar ruang yang diberikan, termasuk dalam split screen.
class PortfolioHero extends StatelessWidget {
  final PortfolioDetails details;
  final VoidCallback onViewWork;

  const PortfolioHero({
    super.key,
    required this.details,
    required this.onViewWork,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 740;
        final portrait = _Portrait(name: details.displayName);
        final introduction = _Introduction(
          details: details,
          onViewWork: onViewWork,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'TECHNOLOGY × CREATIVITY',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PortfolioColors.accent,
                fontSize: 11,
                letterSpacing: 2.8,
              ),
            ),
            const SizedBox(height: 14),
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
                  details.displayName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: wide ? 92 : 48,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                    letterSpacing: -1.8,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: portrait),
                  const SizedBox(width: 40),
                  Expanded(child: introduction),
                ],
              )
            else ...[
              portrait,
              const SizedBox(height: 24),
              introduction,
            ],
          ],
        );
      },
    );
  }
}

class _Portrait extends StatelessWidget {
  final String name;

  const _Portrait({required this.name});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.95,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, 0.3),
                  radius: 0.8,
                  colors: [Color(0xFF44235D), Color(0x00141416)],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 8,
            left: 0,
            right: 0,
            child: ExcludeSemantics(
              child: FittedBox(
                child: Text(
                  'PORTOFOLIO',
                  style: TextStyle(
                    color: Color(0xFF4E465B),
                    fontSize: 64,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 16,
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white, Colors.transparent],
                stops: [0, 0.82, 1],
              ).createShader(bounds),
              child: Image.asset(
                'assets/images/noe-cutout.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                semanticLabel: 'Foto $name dari portofolio web',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Introduction extends StatelessWidget {
  final PortfolioDetails details;
  final VoidCallback onViewWork;

  const _Introduction({required this.details, required this.onViewWork});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'The person behind the work',
          style: TextStyle(color: PortfolioColors.muted, fontSize: 12),
        ),
        const SizedBox(height: 10),
        Text(
          details.roles.first,
          style: const TextStyle(
            color: PortfolioColors.ink,
            fontWeight: FontWeight.w600,
            fontSize: 32,
            height: 1.15,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          details.roles.skip(1).join(' · '),
          style: const TextStyle(color: PortfolioColors.accent, height: 1.5),
        ),
        const SizedBox(height: 20),
        Text(
          details.bio,
          style: const TextStyle(
            color: PortfolioColors.muted,
            fontSize: 15,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 20),
        TextButton.icon(
          onPressed: onViewWork,
          label: const Text('VIEW MY WORK'),
          icon: const Icon(Icons.north_east, size: 18),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(color: PortfolioColors.line),
        ),
        Text(
          details.studyProgram,
          style: const TextStyle(color: PortfolioColors.accent, fontSize: 16),
        ),
        const SizedBox(height: 6),
        Text(
          details.university,
          style: const TextStyle(
            color: PortfolioColors.ink,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ContactButton(label: 'Email', url: 'mailto:${details.email}'),
            _ContactButton(label: 'GitHub', url: details.githubUrl),
            _ContactButton(label: 'LinkedIn', url: details.linkedinUrl),
          ],
        ),
      ],
    );
  }
}

class _ContactButton extends StatelessWidget {
  final String label;
  final String url;

  const _ContactButton({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => openPortfolioLink(context, url),
      label: Text(label),
      icon: const Icon(Icons.north_east, size: 14),
      style: OutlinedButton.styleFrom(
        foregroundColor: PortfolioColors.ink,
        backgroundColor: const Color(0xFF201A27),
        side: const BorderSide(color: Color(0xFF473650)),
        minimumSize: const Size(0, 44),
      ),
    );
  }
}
