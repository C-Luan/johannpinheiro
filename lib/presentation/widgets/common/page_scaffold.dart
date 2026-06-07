import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// BreadcrumbItem kept for API compatibility — no longer rendered.
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
  Widget build(BuildContext context) => SingleChildScrollView(
        child: child,
      ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.02, end: 0, duration: 280.ms);
}
