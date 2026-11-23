import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';

/// Ikon membawa warna tiap aksi. Seluruh permukaan menerima ketukan dan fokus
/// keyboard, termasuk ruang di sekitar label saat teks membungkus.
class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final VoidCallback onTap;

  const ItemCard(this.item, {super.key, required this.onTap});

  static const BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(14),
  );

  @override
  Widget build(BuildContext context) {
    final color = item.backgroundColor;
    return Semantics(
      button: true,
      child: Material(
        color: PortfolioColors.surface,
        borderRadius: _borderRadius,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            border: Border.all(
              color: Color.lerp(color, PortfolioColors.line, .5)!,
            ),
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                Color.lerp(color, PortfolioColors.surface, .68)!,
                PortfolioColors.surface,
              ],
            ),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: _borderRadius,
            focusColor: Colors.white24,
            hoverColor: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(item.icon, color: Colors.white, size: 22),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      color: PortfolioColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
