import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 40),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.hairline)),
      ),
      child: mobile ? _MobileFooter() : _DesktopFooter(),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Johann.', style: AppTextStyles.logo(size: 18)),
          const Spacer(),
          Text(
            '© 2026 Johann Filmaker — Todos os direitos reservados.',
            style: AppTextStyles.body(size: 13),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                'Feito com luz, sombra e café',
                style: AppTextStyles.body(size: 13).copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(width: 24),
              _SocialIcons(),
            ],
          ),
        ],
      );
}

class _MobileFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text('Johann.', style: AppTextStyles.logo(size: 18)),
          const SizedBox(height: 16),
          _SocialIcons(),
          const SizedBox(height: 16),
          Text(
            '© 2026 Johann Filmaker — Todos os direitos reservados.',
            style: AppTextStyles.body(size: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Feito com luz, sombra e café',
            style: AppTextStyles.body(size: 12).copyWith(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      );
}

class _SocialIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IconLink(icon: Icons.camera_alt_outlined, url: 'https://instagram.com/johann.filmmaker'),
          const SizedBox(width: 16),
          _IconLink(icon: Icons.chat_bubble_outline, url: 'https://wa.me/5591000000000'),
          const SizedBox(width: 16),
          _IconLink(icon: Icons.mail_outline, url: 'mailto:contato@johann.film'),
        ],
      );
}

class _IconLink extends StatefulWidget {
  final IconData icon;
  final String url;
  const _IconLink({required this.icon, required this.url});

  @override
  State<_IconLink> createState() => _IconLinkState();
}

class _IconLinkState extends State<_IconLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          child: Icon(
            widget.icon,
            color: _hovered ? AppColors.goldHover : AppColors.gold,
            size: 20,
          ),
        ),
      );
}
