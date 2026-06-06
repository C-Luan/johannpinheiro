import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/portfolio/portfolio_page.dart';
import '../../presentation/pages/services/services_page.dart';
import '../../presentation/pages/about/about_page.dart';
import '../../presentation/pages/contact/contact_page.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../presentation/widgets/navbar/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => _noTransitionPage(const SplashPage(), state),
    ),
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => _fadePage(const HomePage(), state),
        ),
        GoRoute(
          path: '/portfolio',
          pageBuilder: (context, state) => _fadePage(const PortfolioPage(), state),
        ),
        GoRoute(
          path: '/servicos',
          pageBuilder: (context, state) => _fadePage(const ServicesPage(), state),
        ),
        GoRoute(
          path: '/sobre',
          pageBuilder: (context, state) => _fadePage(const AboutPage(), state),
        ),
        GoRoute(
          path: '/contato',
          pageBuilder: (context, state) => _fadePage(const ContactPage(), state),
        ),
      ],
    ),
  ],
);

CustomTransitionPage<void> _noTransitionPage(Widget child, GoRouterState state) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondary, child) => child,
    );

CustomTransitionPage<void> _fadePage(Widget child, GoRouterState state) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 280),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.02),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
              child: child,
            ),
          ),
    );
