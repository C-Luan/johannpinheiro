import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Non-web fallback: solid dark background.
Widget buildYoutubeBg(String videoId) =>
    const ColoredBox(color: AppColors.background);
