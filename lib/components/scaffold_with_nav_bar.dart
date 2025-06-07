import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/network_banner.dart';
import '../constants/theme_icons.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NetworkBanner(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(216, 217, 217, 1),
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 65,
        child: CustomNavigationBar(
          iconSize: 20.0,
          elevation: 0,
          scaleFactor: 0.2,
          opacity: 1,
          selectedColor: const Color.fromRGBO(227, 0, 44, 1),
          strokeColor: const Color(0x30040307),
          unSelectedColor: const Color.fromRGBO(87, 86, 86, 1),
          backgroundColor: Colors.transparent,
          onTap: (int idx) => _onItemTapped(idx, context),
          currentIndex: _calculateSelectedIndex(context),
          items: [
            CustomNavigationBarItem(
              icon: const Icon(AppIcons.home),
              title: _navLabel(AppLocalizations.of(context)!.main),
            ),
            CustomNavigationBarItem(
              icon: const Icon(AppIcons.catalog),
              title: _navLabel(AppLocalizations.of(context)!.catalog),
            ),
            CustomNavigationBarItem(
              icon: const Icon(AppIcons.calc),
              title: _navLabel(AppLocalizations.of(context)!.calculator),
            ),
            CustomNavigationBarItem(
              icon: const Icon(AppIcons.user),
              title: _navLabel(AppLocalizations.of(context)!.profile),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _navLabel(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10.0),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    if (location.startsWith('/catalog')) return 1;
    if (location.startsWith('/calculator')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/catalog');
        break;
      case 2:
        GoRouter.of(context).go('/calculator');
        break;
      case 3:
        GoRouter.of(context).go('/profile');
        break;
    }
  }
}
