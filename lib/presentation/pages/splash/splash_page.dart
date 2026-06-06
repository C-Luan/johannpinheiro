import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) context.go('/');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.surfaceDark,
        body: Center(
          child: Image.asset(
            'assets/images/logo_full.png',
            width: 320,
            fit: BoxFit.contain,
          )
              .animate()
              .fadeIn(duration: 800.ms, curve: Curves.easeOut)
              .then(delay: 800.ms)
              .fadeOut(duration: 600.ms, curve: Curves.easeIn),
        ),
      );
}
