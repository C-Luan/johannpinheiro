import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';

class BreadcrumbItem {
  final String label;
  final String? route;
  const BreadcrumbItem(this.label, {this.route});
}

class PageScaffold extends StatelessWidget {
  final List<BreadcrumbItem> breadcrumbs;
  final Widget child;

  const PageScaffold({
    super.key,
    required this.breadcrumbs,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 20),
            child: _Breadcrumb(items: breadcrumbs),
          ),
          child,
        ],
      ),
    ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.02, end: 0, duration: 280.ms);
  }
}

class _Breadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;
  const _Breadcrumb({required this.items});

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;
      children.add(
        GestureDetector(
          onTap: item.route != null ? () => context.go(item.route!) : null,
          child: MouseRegion(
            cursor: item.route != null ? SystemMouseCursors.click : MouseCursor.defer,
            child: Text(
              item.label.toUpperCase(),
              style: AppTextStyles.eyebrow(size: 11).copyWith(
                color: isLast ? AppColors.gold : AppColors.textMuted,
              ),
            ),
          ),
        ),
      );
      if (!isLast) {
        children.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('/', style: AppTextStyles.eyebrow(size: 11).copyWith(color: AppColors.textMuted)),
        ));
      }
    }
    return Row(children: children);
  }
}
