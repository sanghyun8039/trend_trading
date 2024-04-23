import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:trend_trading/routers/app_routes.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late TextEditingController tickerController;
  late TextEditingController descController;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    tickerController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double bottomSheetWidth = MediaQuery.of(context).size.width;
    List<String> settingList = ['Manage ETF', 'My ETF'];
    final Map<String, String> settingRoutes = {
      'Manage ETF': AppRoutes.manageETF,
      'My ETF': AppRoutes.myETF,
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trend ETF'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: settingList.length,
        itemBuilder: (context, index) {
          String settingItem = settingList[index];
          return ListTile(
            title: Text(settingItem),
            trailing: InkWell(
                onTap: () {
                  String? route = settingRoutes[settingItem];
                  if (route != null) {
                    context.push('${AppRoutes.setting}/$route');
                  }
                },
                child: const Icon(Icons.keyboard_arrow_right_rounded)),
          );
        },
      ),
    );
  }
}
