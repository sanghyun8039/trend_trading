import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:trend_trading/common/constant_value.dart';
import 'package:trend_trading/src/home/blocs/bloc/canary_bloc.dart';
import 'package:trend_trading/src/home/blocs/bloc/roi_bloc.dart';
import 'package:trend_trading/src/home/components/top_listtile.dart';
import 'package:trend_trading/src/home/views/widgets/home_screen_canary_widget.dart';
import 'package:trend_trading/src/home/views/widgets/home_screen_roi_widget.dart';
import 'package:trend_trading/src/home/views/widgets/home_screen_top_widget.dart';

import '../blocs/bloc/stock_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isStockBoxExists =
          await Hive.boxExists(ConstantValue.stockMomentumFileName);
      bool isCanaryBoxExists =
          await Hive.boxExists(ConstantValue.canaryMomentumFileName);

      if (!isStockBoxExists && !isCanaryBoxExists) {
        // 두 box 모두 존재하지 않을 경우
        await Hive.openBox(ConstantValue.stockMomentumFileName);
        await Hive.openBox(ConstantValue.canaryMomentumFileName);
        context.read<StockBloc>().add(GetStockData());
        context.read<CanaryBloc>().add(GetCanaryStockData());
        context.read<RoiBloc>().add(GetStockROI());
      } else {
        // 두 box 중 하나라도 존재할 경우
        if (isStockBoxExists) {
          context.read<StockBloc>().add(GetStockDataByHive());
        } else {
          await Hive.openBox(ConstantValue.stockMomentumFileName);
          context.read<StockBloc>().add(GetStockData());
        }
        if (isCanaryBoxExists) {
          context.read<CanaryBloc>().add(GetCanaryStockDataByHive());
        } else {
          await Hive.openBox(ConstantValue.canaryMomentumFileName);
          context.read<CanaryBloc>().add(GetCanaryStockData());
        }
        context.read<RoiBloc>().add(GetStockROI());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trend ETF'),
        centerTitle: true,
      ),
      body: BlocConsumer<CanaryBloc, CanaryState>(
        listener: (context, canaryState) {},
        builder: (context, canaryState) {
          return BlocConsumer<StockBloc, StockState>(
            listener: (context, stockState) {},
            builder: (context, stockState) {
              return BlocConsumer<RoiBloc, RoiState>(
                  listener: (context, state) {},
                  builder: (context, roiState) {
                    if (stockState is StockLoading ||
                        roiState is StockROILoading ||
                        canaryState is CanaryStockLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (stockState is StockLoadingSuccess &&
                        roiState is StockROILoadingSuccess &&
                        canaryState is CanaryStockLoadingSuccess) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Canary',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      '기준일 : ${DateTime.now().toString().substring(0, 10)}')
                                ],
                              ),
                              const SizedBox(height: 15),
                              CanaryWidget(canaryList: canaryState.list),
                              const SizedBox(height: 15),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ROI',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              ROIWidget(roiList: roiState.roiList),
                              const SizedBox(height: 15),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Top 5',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              TopWidget(stockList: stockState.momentumList)
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  });
            },
          );
        },
      ),
    );
  }
}
