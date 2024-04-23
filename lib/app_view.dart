import 'package:flutter/material.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:trend_trading/components/persistent_nav.dart';
import 'package:trend_trading/routers/router.dart';
import 'package:trend_trading/src/home/views/home_screen.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
