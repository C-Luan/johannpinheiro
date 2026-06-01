import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

class Eyebrow extends StatelessWidget {
  final String text;
  const Eyebrow(this.text, {super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text.toUpperCase(), style: AppTextStyles.eyebrow());
}
