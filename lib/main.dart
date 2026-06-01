import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/portfolio_provider.dart';

void main() {
  runApp(const JohannApp());
}

class JohannApp extends StatelessWidget {
  const JohannApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PortfolioProvider()),
        ],
        child: MaterialApp.router(
          title: 'Johann Filmaker',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          routerConfig: appRouter,
        ),
      );
}
