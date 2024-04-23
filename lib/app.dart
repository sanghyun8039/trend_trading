import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend_trading/app_view.dart';
import 'package:trend_trading/src/home/blocs/bloc/canary_bloc.dart';
import 'package:trend_trading/src/home/blocs/bloc/roi_bloc.dart';
import 'package:trend_trading/src/home/blocs/bloc/stock_bloc.dart';
import 'package:trend_trading/src/setting/blocs/bloc/setting_bloc.dart';
import 'package:trend_trading/src/trend/blocs/bloc/ranking_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StockBloc(),
        ),
        BlocProvider(
          create: (context) => RoiBloc(),
        ),
        BlocProvider(
          create: (context) => CanaryBloc(),
        ),
        BlocProvider(
          create: (context) => RankingBloc(),
        ),
        BlocProvider(
          create: (context) => SettingBloc(),
        ),
      ],
      child: const AppView(),
    );
  }
}
