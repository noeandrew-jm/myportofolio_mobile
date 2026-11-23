import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/data/portfolio_content.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

enum DrawerPage {
  home('Home', Icons.home_outlined),
  project('Add Project', Icons.add_circle_outline),
  experience('Add Experience', Icons.work_outline);

  const DrawerPage(this.label, this.icon);
  final String label;
  final IconData icon;
}

class LeftDrawer extends StatelessWidget {
  final DrawerPage currentPage;

  const LeftDrawer({super.key, this.currentPage = DrawerPage.home});

  /// Beranda selalu berada di dasar tumpukan. Berpindah antarform mengganti
  /// rute teratas agar tombol kembali tidak membuka formulir yang ditinggalkan.
  void _select(BuildContext context, DrawerPage destination) {
    final navigator = Navigator.of(context);
    Scaffold.of(context).closeDrawer();
    if (destination == currentPage) return;
    if (destination == DrawerPage.home) {
      navigator.popUntil((route) => route.isFirst);
      return;
    }
    final route = MaterialPageRoute<void>(
      builder: (_) => destination == DrawerPage.project
          ? const ProjectFormPage()
          : const ExperienceFormPage(),
    );
    if (currentPage == DrawerPage.home) {
      navigator.push(route);
    } else {
      navigator.pushReplacement(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  portfolioDetails.displayName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'My Portfolio',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
          for (final destination in DrawerPage.values)
            ListTile(
              leading: Icon(destination.icon),
              title: Text(destination.label),
              selected: currentPage == destination,
              onTap: () => _select(context, destination),
            ),
        ],
      ),
    );
  }
}
