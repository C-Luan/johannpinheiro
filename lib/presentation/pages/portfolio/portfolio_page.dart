import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/providers/portfolio_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';
import '../../../core/utils/drive_helper.dart';
import '../../../core/widgets/drive_image.dart';
import '../../../data/models/work.dart';
import '../../widgets/common/display_title.dart';
import '../../widgets/common/eyebrow.dart';
import '../../widgets/common/page_scaffold.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => PortfolioProvider(),
        child: const _PortfolioContent(),
      );
}

class _PortfolioContent extends StatelessWidget {
  const _PortfolioContent();

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;
    final vPad = mobile ? AppSpacing.sectionMobile : AppSpacing.section;

    return PageScaffold(
      breadcrumbs: const [
        BreadcrumbItem('Home', route: '/'),
        BreadcrumbItem('Portfólio'),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Eyebrow('Portfólio'),
              const SizedBox(height: 16),
              DisplayTitle(before: 'Trabalhos ', highlight: 'selecionados', after: '.'),
              const SizedBox(height: 8),
              Text(
                'Uma amostra dos projetos recentes — clique para reproduzir.',
                style: AppTextStyles.body(),
              ),
              const SizedBox(height: 40),
              const _CategoryFilter(),
              const SizedBox(height: 48),
              const _WorksGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Filter ──────────────────────────────────────────────────────────────────

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PortfolioProvider>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterPill(label: 'Todos', active: provider.activeFilter == null,
              onTap: () => provider.setFilter(null)),
          ...WorkCategory.values.map((c) => _FilterPill(
                label: c.label,
                active: provider.activeFilter == c,
                onTap: () => provider.setFilter(c),
              )),
        ],
      ),
    );
  }
}

class _FilterPill extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _FilterPill({required this.label, required this.active, required this.onTap});

  @override
  State<_FilterPill> createState() => _FilterPillState();
}

class _FilterPillState extends State<_FilterPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: widget.active ? AppColors.gold : Colors.transparent,
              border: Border.all(
                color: widget.active || _hovered ? AppColors.gold : AppColors.textMuted,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              widget.label,
              style: AppTextStyles.eyebrow(size: 11).copyWith(
                color: widget.active ? AppColors.background : AppColors.textMuted,
              ),
            ),
          ),
        ),
      );
}

// ─── Grid ────────────────────────────────────────────────────────────────────

class _WorksGrid extends StatelessWidget {
  const _WorksGrid();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PortfolioProvider>();
    final mobile = Breakpoints.isMobile(context);

    if (provider.loading) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.gold, strokeWidth: 1.5),
        ),
      );
    }

    final works = provider.filteredWorks;

    if (works.isEmpty) {
      return SizedBox(
        height: 240,
        child: Center(
          child: Text('Nenhum trabalho nesta categoria.', style: AppTextStyles.body()),
        ),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Wrap(
        spacing: AppSpacing.gridGap,
        runSpacing: AppSpacing.gridGap,
        children: works
            .map((w) => SizedBox(
                  width: mobile
                      ? double.infinity
                      : (constraints.maxWidth - AppSpacing.gridGap) / 2,
                  child: WorkCard(work: w),
                ))
            .toList(),
      );
    });
  }
}

class WorkCard extends StatelessWidget {
  final Work work;
  const WorkCard({super.key, required this.work});

  Future<void> _open() async {
    if (work.driveId == null) return;
    final uri = Uri.parse(DriveHelper.watchUrl(work.driveId!));
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: work.driveId != null
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        child: GestureDetector(
          onTap: _open,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              border: Border.all(color: AppColors.hairline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 240, child: _Thumbnail(work: work)),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(work.title, style: AppTextStyles.cardTitle())),
                          const SizedBox(width: 8),
                          Text('${work.year}', style: AppTextStyles.eyebrow(size: 11)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(work.category.label, style: AppTextStyles.body(size: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate().fadeIn(duration: 300.ms);
}

class _Thumbnail extends StatelessWidget {
  final Work work;
  const _Thumbnail({required this.work});

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          if (work.driveId != null)
            DriveImage(url: DriveHelper.thumbnail(work.driveId!))
          else
            Container(color: AppColors.surfaceCard),
          Container(
            color: AppColors.surfaceDark.withValues(alpha: 0.35),
          ),
          if (work.driveId != null)
            Center(
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 1.5),
                ),
                child: const Icon(Icons.play_arrow, color: AppColors.gold, size: 28),
              ),
            )
          else
            Center(
              child: Text('Em breve', style: AppTextStyles.body(size: 13, color: AppColors.textMutedOnDark)),
            ),
        ],
      );
}
