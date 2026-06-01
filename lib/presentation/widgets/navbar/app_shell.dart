import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/nav_provider.dart';
import '../footer/footer.dart';
import 'navbar.dart';
import 'nav_overlay.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => NavProvider(),
        child: _ShellBody(child: child),
      );
}

class _ShellBody extends StatelessWidget {
  final Widget child;
  const _ShellBody({required this.child});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Column(
              children: [
                const Navbar(),
                Expanded(child: child),
                const AppFooter(),
              ],
            ),
            const NavOverlay(),
          ],
        ),
      );
}
