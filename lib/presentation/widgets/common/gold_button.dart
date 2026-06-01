import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

enum GoldButtonVariant { solid, outline }

class GoldButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final GoldButtonVariant variant;

  const GoldButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = GoldButtonVariant.solid,
  });

  const GoldButton.outline({
    super.key,
    required this.label,
    required this.onPressed,
  }) : variant = GoldButtonVariant.outline;

  @override
  State<GoldButton> createState() => _GoldButtonState();
}

class _GoldButtonState extends State<GoldButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isSolid = widget.variant == GoldButtonVariant.solid;
    final bg = isSolid
        ? (_hovered ? AppColors.goldHover : AppColors.gold)
        : Colors.transparent;
    final textColor = isSolid ? AppColors.background : AppColors.gold;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: bg,
            border: isSolid ? null : Border.all(color: AppColors.gold, width: 1.0),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.eyebrow(size: 12).copyWith(color: textColor, letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}
