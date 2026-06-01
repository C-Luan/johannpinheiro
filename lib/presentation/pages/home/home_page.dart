import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';
import '../../../data/repositories/static_data.dart';
import '../../widgets/common/display_title.dart';
import '../../widgets/common/eyebrow.dart';
import '../../widgets/common/gold_button.dart';
import '../../widgets/common/viewfinder_corners.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            const _HeroSection(),
            const _DifferentialsSection(),
            const _ServiceTeaserSection(),
            const _PortfolioTeaserSection(),
            const _CtaBanner(),
          ],
        ),
      );
}

// ─── Hero ────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  static const _navbarH = 68.0;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final h = mobile ? 560.0 : MediaQuery.sizeOf(context).height - _navbarH;
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;

    return SizedBox(
      height: h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Gradient base (visible while/if no image) ──
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.6, 0.4),
                radius: 1.4,
                colors: [Color(0xFF1C1208), AppColors.background],
              ),
            ),
          ),

          // ── Background image (shows automatically once asset is added) ──
          Image.asset(
            'assets/images/hero_bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),

          // ── Dark overlay ──
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  AppColors.background.withAlpha(200),
                  AppColors.background.withAlpha(240),
                ],
              ),
            ),
          ),

          // ── Content ──
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ViewfinderCorners(
                    padding: mobile ? 12 : 20,
                    armLength: mobile ? 16 : 28,
                    child: Padding(
                      padding: EdgeInsets.all(mobile ? 24 : 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Eyebrow('Produção audiovisual · Belém, PA'),
                          const SizedBox(height: 24),
                          DisplayTitle(
                            before: 'Vídeos que ',
                            highlight: 'fortalecem marcas',
                            after: ', geram autoridade e conectam empresas ao seu público.',
                          ),
                          const SizedBox(height: 24),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Text(
                              'Produção audiovisual especializada para empresas, profissionais, instituições e eventos. Da estratégia à entrega final, transformo histórias em vídeos que comunicam com clareza e geram resultado.',
                              style: AppTextStyles.body(size: 17),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Wrap(
                            spacing: 16,
                            runSpacing: 12,
                            children: [
                              GoldButton.outline(
                                label: 'Ver Portfólio',
                                onPressed: () => context.go('/portfolio'),
                              ),
                              GoldButton(
                                label: 'Solicitar Orçamento',
                                onPressed: () => context.go('/contato'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Scroll indicator ──
          const Positioned(bottom: 32, left: 0, right: 0, child: _ScrollIndicator()),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}

class _ScrollIndicator extends StatefulWidget {
  const _ScrollIndicator();

  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ROLAR', style: AppTextStyles.eyebrow(size: 9).copyWith(color: AppColors.textMuted)),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            width: 1,
            child: AnimatedBuilder(
              animation: _anim,
              builder: (_, _) => CustomPaint(painter: _LinePainter(_anim.value)),
            ),
          ),
        ],
      );
}

class _LinePainter extends CustomPainter {
  final double progress;
  const _LinePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Static line
    canvas.drawLine(
      Offset(0, 0),
      Offset(0, size.height),
      Paint()
        ..color = AppColors.hairline
        ..strokeWidth = 1,
    );
    // Animated dot
    canvas.drawCircle(
      Offset(0, size.height * progress),
      2.5,
      Paint()..color = AppColors.gold,
    );
  }

  @override
  bool shouldRepaint(_LinePainter old) => old.progress != progress;
}

// ─── Diferenciais ────────────────────────────────────────────────────────────

class _DifferentialsSection extends StatelessWidget {
  const _DifferentialsSection();

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;
    final vPad = mobile ? AppSpacing.sectionMobile : AppSpacing.section;

    return Container(
      color: AppColors.surfaceCard,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Eyebrow('Diferenciais'),
            const SizedBox(height: 8),
            LayoutBuilder(builder: (context, constraints) {
              final cols = mobile ? 1 : 2;
              final items = StaticData.differentials;
              return Wrap(
                spacing: AppSpacing.gridGap,
                runSpacing: AppSpacing.gridGap,
                children: List.generate(items.length, (i) {
                  final d = items[i];
                  return SizedBox(
                    width: mobile
                        ? double.infinity
                        : (constraints.maxWidth - AppSpacing.gridGap) / cols,
                    child: _DifferentialCard(
                      number: '0${i + 1}',
                      title: d.title,
                      description: d.description,
                    ),
                  );
                }),
              );
            }),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }
}

class _DifferentialCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  const _DifferentialCard({required this.number, required this.title, required this.description});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(number, style: AppTextStyles.eyebrow(size: 11)),
            const SizedBox(height: 4),
            Container(height: 1, width: 40, color: AppColors.hairline),
            const SizedBox(height: 16),
            Text(title, style: AppTextStyles.cardTitle()),
            const SizedBox(height: 8),
            Text(description, style: AppTextStyles.body()),
          ],
        ),
      );
}

// ─── Teaser Serviços ─────────────────────────────────────────────────────────

class _ServiceTeaserSection extends StatelessWidget {
  const _ServiceTeaserSection();

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;
    final vPad = mobile ? AppSpacing.sectionMobile : AppSpacing.section;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Eyebrow('Serviços'),
            const SizedBox(height: 24),
            DisplayTitle(before: 'O que posso ', highlight: 'criar', after: ' com você.'),
            const SizedBox(height: 32),
            _FeaturedServiceCard(),
            const SizedBox(height: 32),
            _SeeAllLink(label: 'Ver todos os serviços', route: '/servicos'),
          ],
        ),
      ),
    );
  }
}

class _FeaturedServiceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          border: Border.all(color: AppColors.hairline),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('01', style: AppTextStyles.eyebrow()),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gold),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('MAIS PROCURADO', style: AppTextStyles.tag()),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Captação de Conteúdo', style: AppTextStyles.cardTitle(size: 22)),
            const SizedBox(height: 12),
            Text(
              'Produção de vídeos voltados para redes sociais, posicionamento de marca e fortalecimento da autoridade profissional.',
              style: AppTextStyles.body(),
            ),
          ],
        ),
      );
}

// ─── Teaser Portfólio ─────────────────────────────────────────────────────────

class _PortfolioTeaserSection extends StatelessWidget {
  const _PortfolioTeaserSection();

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;
    final vPad = mobile ? AppSpacing.sectionMobile : AppSpacing.section;
    final works = StaticData.works.take(2).toList();

    return Container(
      color: AppColors.surfaceCard,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Eyebrow('Portfólio'),
            const SizedBox(height: 24),
            DisplayTitle(before: 'Trabalhos ', highlight: 'selecionados', after: '.'),
            const SizedBox(height: 32),
            LayoutBuilder(builder: (context, constraints) {
              return Wrap(
                spacing: AppSpacing.gridGap,
                runSpacing: AppSpacing.gridGap,
                children: works.map((w) => SizedBox(
                      width: mobile
                          ? double.infinity
                          : (constraints.maxWidth - AppSpacing.gridGap) / 2,
                      child: _MiniWorkCard(title: w.title, category: w.category.label, year: w.year),
                    )).toList(),
              );
            }),
            const SizedBox(height: 40),
            _SeeAllLink(label: 'Ver portfólio completo', route: '/portfolio'),
          ],
        ),
      ),
    );
  }
}

class _MiniWorkCard extends StatelessWidget {
  final String title;
  final String category;
  final int year;
  const _MiniWorkCard({required this.title, required this.category, required this.year});

  @override
  Widget build(BuildContext context) => Container(
        height: 220,
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: AppColors.hairline),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(Icons.play_circle_outline, color: AppColors.gold, size: 48),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.surfaceCard.withAlpha(220),
                child: Row(
                  children: [
                    Expanded(child: Text(title, style: AppTextStyles.cardTitle(size: 15))),
                    Text('$year', style: AppTextStyles.eyebrow(size: 11)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

// ─── CTA Banner ──────────────────────────────────────────────────────────────

class _CtaBanner extends StatelessWidget {
  const _CtaBanner();

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
        child: Column(
          children: [
            const Eyebrow('Próximo passo'),
            const SizedBox(height: 24),
            Text(
              'Tem um projeto em mente?',
              style: AppTextStyles.display(size: mobile ? 32 : 48),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            GoldButton(
              label: 'Solicitar Orçamento',
              onPressed: () => context.go('/contato'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared helpers ───────────────────────────────────────────────────────────

class _SeeAllLink extends StatefulWidget {
  final String label;
  final String route;
  const _SeeAllLink({required this.label, required this.route});

  @override
  State<_SeeAllLink> createState() => _SeeAllLinkState();
}

class _SeeAllLinkState extends State<_SeeAllLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => context.go(widget.route),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.eyebrow().copyWith(
                  color: _hovered ? AppColors.goldHover : AppColors.gold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: _hovered ? AppColors.goldHover : AppColors.gold, size: 14),
            ],
          ),
        ),
      );
}
