import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';
import '../../widgets/common/display_title.dart';
import '../../widgets/common/eyebrow.dart';
import '../../widgets/common/gold_button.dart';
import '../../widgets/common/viewfinder_corners.dart';
import '../../../core/widgets/youtube_bg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const _HeroSection();
}

// ─── Hero ─────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background video (YouTube, autoplay + muted + loop)
          const YoutubeBg(videoId: 'r8EyEgP7_ko'),

          // Dark overlay gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  AppColors.background.withAlpha(180),
                  AppColors.background.withAlpha(240),
                ],
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mobile
                            ? AppSpacing.containerPaddingMobile
                            : AppSpacing.containerPadding,
                      ),
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
                                  constraints: const BoxConstraints(maxWidth: 580),
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
              ),

              // Bottom panel (Ashley-style)
              _BottomPanel(mobile: mobile),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}

// ─── Bottom panel (Ashley mil-banner-panel) ───────────────────────────────────

class _BottomPanel extends StatelessWidget {
  final bool mobile;
  const _BottomPanel({required this.mobile});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.surfaceCard,
          border: Border(top: BorderSide(color: AppColors.hairline)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding,
          vertical: 18,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
          child: mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Johann Filmaker',
                      style: AppTextStyles.eyebrow(size: 10).copyWith(
                        color: AppColors.textMuted,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Belém · Pará · Brasil',
                      style: AppTextStyles.eyebrow(size: 10).copyWith(
                        color: AppColors.textMuted,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      'Johann Filmaker',
                      style: AppTextStyles.eyebrow(size: 10).copyWith(
                        color: AppColors.textMuted,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 32),
                    Container(width: 1, height: 12, color: AppColors.hairline),
                    const SizedBox(width: 32),
                    Text(
                      'Belém · Pará · Brasil',
                      style: AppTextStyles.eyebrow(size: 10).copyWith(
                        color: AppColors.textMuted,
                        letterSpacing: 2,
                      ),
                    ),
                    const Spacer(),
                    _StatItem(value: '5+', label: 'Anos'),
                    const SizedBox(width: 40),
                    _StatItem(value: '50+', label: 'Projetos'),
                    const SizedBox(width: 40),
                    _StatItem(value: '30+', label: 'Clientes'),
                  ],
                ),
        ),
      );
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            value,
            style: AppTextStyles.eyebrow(size: 16).copyWith(
              color: AppColors.gold,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.eyebrow(size: 9).copyWith(
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
        ],
      );
}
