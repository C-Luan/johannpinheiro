import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/providers/nav_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';
import 'nav_overlay.dart';

// ─── Navigation data ─────────────────────────────────────────────────────────

const _sideItems = [
  ('Home',      '/'),
  ('Sobre',     '/sobre'),
  ('Portfólio', '/portfolio'),
  ('Serviços',  '/servicos'),
  ('Contato',   '/contato'),
];

// (inactiveIcon, activeIcon, route, label)
const _bottomItems = [
  (Icons.home_outlined,          Icons.home_rounded,        '/',          'Home'),
  (Icons.person_outline_rounded, Icons.person_rounded,      '/sobre',     'Sobre'),
  (Icons.play_circle_outline,    Icons.play_circle_rounded, '/portfolio', 'Portf.'),
  (Icons.work_outline_rounded,   Icons.work_rounded,        '/servicos',  'Serv.'),
  (Icons.mail_outline_rounded,   Icons.mail_rounded,        '/contato',   'Contato'),
];

// ─── Shell root ──────────────────────────────────────────────────────────────

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => NavProvider(),
        child: _ShellBody(child: child),
      );
}

class _ShellBody extends StatelessWidget {
  final Widget child;
  const _ShellBody({required this.child});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    return mobile ? _MobileShell(child: child) : _DesktopShell(child: child);
  }
}

// ─── Desktop ─────────────────────────────────────────────────────────────────

class _DesktopShell extends StatelessWidget {
  final Widget child;
  const _DesktopShell({required this.child});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.background,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _DesktopSidebar(),
            Container(width: 1, color: AppColors.hairline),
            Expanded(child: child),
          ],
        ),
      );
}

class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return SizedBox(
      width: 220,
      child: Container(
        color: AppColors.background,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            GestureDetector(
              onTap: () => context.go('/'),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Image.asset(
                  'assets/images/logo_mark.png',
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Nav items
            ..._sideItems.map((item) => _SideNavItem(
                  label: item.$1,
                  route: item.$2,
                  active: location == item.$2,
                )),

            const Spacer(),

            // Social icons
            const _SocialRow(),
            const SizedBox(height: 20),

            // Footer copy
            Text(
              '© 2026 Johann',
              style: AppTextStyles.eyebrow(size: 9).copyWith(
                color: AppColors.textMuted,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Belém · PA · Brasil',
              style: AppTextStyles.eyebrow(size: 9).copyWith(
                color: AppColors.textMuted,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideNavItem extends StatefulWidget {
  final String label;
  final String route;
  final bool active;
  const _SideNavItem({required this.label, required this.route, required this.active});

  @override
  State<_SideNavItem> createState() => _SideNavItemState();
}

class _SideNavItemState extends State<_SideNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.active || _hovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 2,
                height: 14,
                color: highlighted ? AppColors.gold : Colors.transparent,
              ),
              const SizedBox(width: 14),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: AppTextStyles.eyebrow(size: 11).copyWith(
                  color: highlighted ? AppColors.gold : AppColors.textMuted,
                  letterSpacing: 2.5,
                ),
                child: Text(widget.label.toUpperCase()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Mobile ──────────────────────────────────────────────────────────────────

class _MobileShell extends StatelessWidget {
  final Widget child;
  const _MobileShell({required this.child});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Column(
              children: [
                const _MobileTopBar(),
                Container(height: 1, color: AppColors.hairline),
                Expanded(child: child),
              ],
            ),
            const NavOverlay(),
          ],
        ),
        bottomNavigationBar: const _MobileBottomTabs(),
      );
}

class _MobileTopBar extends StatelessWidget {
  const _MobileTopBar();

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavProvider>();
    return Container(
      height: 56,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/'),
            child: Image.asset('assets/images/logo_mark.png', height: 36, fit: BoxFit.contain),
          ),
          const Spacer(),
          GestureDetector(
            onTap: nav.toggleMenu,
            child: const Icon(Icons.menu_rounded, color: AppColors.gold, size: 24),
          ),
        ],
      ),
    );
  }
}

class _MobileBottomTabs extends StatelessWidget {
  const _MobileBottomTabs();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.hairline)),
      ),
      child: Row(
        children: _bottomItems.map((item) {
          final active = location == item.$3;
          return Expanded(
            child: GestureDetector(
              onTap: () => context.go(item.$3),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    active ? item.$2 : item.$1,
                    color: active ? AppColors.gold : AppColors.textMuted,
                    size: 20,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.$4,
                    style: AppTextStyles.eyebrow(size: 8).copyWith(
                      color: active ? AppColors.gold : AppColors.textMuted,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── Social row (shared) ─────────────────────────────────────────────────────

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) => Row(
        children: const [
          _SocialBtn(Icons.camera_alt_outlined, 'https://instagram.com/johann.filmmaker'),
          SizedBox(width: 16),
          _SocialBtn(Icons.chat_bubble_outline, 'https://wa.me/559188169032'),
          SizedBox(width: 16),
          _SocialBtn(Icons.mail_outline, 'mailto:contato@johann.film'),
        ],
      );
}

class _SocialBtn extends StatefulWidget {
  final IconData icon;
  final String url;
  const _SocialBtn(this.icon, this.url);

  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<_SocialBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          child: Icon(
            widget.icon,
            color: _hovered ? AppColors.goldHover : AppColors.textMuted,
            size: 16,
          ),
        ),
      );
}
