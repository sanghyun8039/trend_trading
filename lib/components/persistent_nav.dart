import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:trend_trading/src/home/views/home_screen.dart';
import 'package:trend_trading/src/setting/views/setting_screen.dart';
import 'package:trend_trading/src/trend/views/trend_screen.dart';

class PersistentTabScreen extends StatefulWidget {
  const PersistentTabScreen({super.key});

  @override
  State<PersistentTabScreen> createState() => _PersistentTabScreenState();
}

class _PersistentTabScreenState extends State<PersistentTabScreen> {
  List<PersistentTabConfig> tabs = [
    PersistentTabConfig(
      screen: const HomeScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.home),
        title: "Home",
      ),
    ),
    PersistentTabConfig(
      screen: const TrendScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.trending_up_rounded),
        title: "Trend",
      ),
    ),
    PersistentTabConfig(
      screen: const SettingScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.settings),
        title: "Setting",
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: tabs,
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
