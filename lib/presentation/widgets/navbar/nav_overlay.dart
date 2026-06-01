import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/providers/nav_provider.dart';

const _overlayLinks = [
  ('Sobre',     '/sobre'),
  ('Portfólio', '/portfolio'),
  ('Serviços',  '/servicos'),
  ('Contato',   '/contato'),
];

class NavOverlay extends StatelessWidget {
  const NavOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();
    if (!nav.menuOpen) return const SizedBox.shrink();

    return Positioned.fill(
      child: Material(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Johann.', style: AppTextStyles.logo()),
                    GestureDetector(
                      onTap: nav.closeMenu,
                      child: const Icon(Icons.close, color: AppColors.gold, size: 28),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ..._overlayLinks.map((e) => _OverlayLink(
                    label: e.$1,
                    route: e.$2,
                    onTap: () {
                      nav.closeMenu();
                      context.go(e.$2);
                    },
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'Belém · Pará · Brasil',
                  style: AppTextStyles.eyebrow().copyWith(color: AppColors.textMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverlayLink extends StatelessWidget {
  final String label;
  final String route;
  final VoidCallback onTap;
  const _OverlayLink({required this.label, required this.route, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            label.toUpperCase(),
            style: AppTextStyles.display(size: 36, weight: FontWeight.w300),
          ),
        ),
      );
}
