import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';

/// Renders a display title where [highlight] appears in gold semibold.
/// [before] + [highlight] + [after] form the full title.
class DisplayTitle extends StatelessWidget {
  final String before;
  final String highlight;
  final String after;

  const DisplayTitle({
    super.key,
    required this.before,
    required this.highlight,
    this.after = '',
  });

  @override
  Widget build(BuildContext context) {
    final size = Breakpoints.displaySize(context);
    return RichText(
      text: TextSpan(
        style: AppTextStyles.display(size: size),
        children: [
          if (before.isNotEmpty) TextSpan(text: before),
          TextSpan(
            text: highlight,
            style: AppTextStyles.displayGold(size: size),
          ),
          if (after.isNotEmpty)
            TextSpan(
              text: after,
              style: AppTextStyles.display(size: size, color: AppColors.textPrimary),
            ),
        ],
      ),
    );
  }
}
