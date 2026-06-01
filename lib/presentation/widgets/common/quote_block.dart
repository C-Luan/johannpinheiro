import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class QuoteBlock extends StatelessWidget {
  final String text;
  const QuoteBlock(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12, right: 16),
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: AppColors.gold, width: 3)),
        ),
        child: Text('"$text"', style: AppTextStyles.quote()),
      );
}
