import 'package:go_router/go_router.dart';
import 'package:trend_trading/components/persistent_nav.dart';
import 'package:trend_trading/routers/app_routes.dart';
import 'package:trend_trading/src/home/views/home_screen.dart';
import 'package:trend_trading/src/setting/views/setting_mange_etf_screen.dart';
import 'package:trend_trading/src/setting/views/setting_my_etf_screen.dart';

final router = GoRouter(initialLocation: AppRoutes.home, routes: [
  GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => const PersistentTabScreen(),
  ),
  GoRoute(
      path: AppRoutes.setting,
      builder: (context, state) => const PersistentTabScreen(),
      routes: [
        GoRoute(
          path: AppRoutes.manageETF,
          builder: (context, state) => const ManageETFScreen(),
        ),
        GoRoute(
          path: AppRoutes.myETF,
          builder: (context, state) => const MyETFScreen(),
        ),
      ])
]);
