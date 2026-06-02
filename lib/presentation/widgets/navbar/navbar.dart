import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';
import '../../../core/providers/nav_provider.dart';
import '../common/gold_button.dart';

const _navLinks = [
  ('Sobre',     '/sobre'),
  ('Portfólio', '/portfolio'),
  ('Serviços',  '/servicos'),
  ('Contato',   '/contato'),
];

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final location = GoRouterState.of(context).uri.path;

    return Container(
      height: 68,
      color: AppColors.surfaceDark,
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 24 : 48,
      ),
      child: Row(
        children: [
          _Logo(),
          const Spacer(),
          if (!mobile) ...[
            ..._navLinks.map((e) => _NavLink(label: e.$1, route: e.$2, active: location == e.$2)),
            const SizedBox(width: 32),
            GoldButton.outline(
              label: 'Orçamento',
              onPressed: () => context.go('/contato'),
            ),
          ] else
            _HamburgerButton(),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.go('/'),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text('Johann.', style: AppTextStyles.logo(color: AppColors.textOnDark)),
        ),
      );
}

class _NavLink extends StatefulWidget {
  final String label;
  final String route;
  final bool active;
  const _NavLink({required this.label, required this.route, required this.active});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => context.go(widget.route),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label.toUpperCase(),
                  style: widget.active || _hovered
                      ? AppTextStyles.navActive()
                      : AppTextStyles.nav(color: AppColors.textOnDark),
                ),
                const SizedBox(height: 3),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 1,
                  width: widget.active ? 24 : 0,
                  color: AppColors.gold,
                ),
              ],
            ),
          ),
        ),
      );
}

class _HamburgerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavProvider>();
    return GestureDetector(
      onTap: nav.toggleMenu,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: const Icon(Icons.menu, color: AppColors.gold, size: 28),
      ),
    );
  }
}
