import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

Widget buildDriveImage(String url, BoxFit fit) => Image.network(
      url,
      fit: fit,
      errorBuilder: (context, error, stack) =>
          Container(color: AppColors.surfaceCard),
    );
