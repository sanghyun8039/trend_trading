import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:trend_trading/src/test/blocs/bloc/test_bloc.dart';
import 'package:trend_trading/src/trend/blocs/bloc/ranking_bloc.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TestBloc>().add(GetCryptoPrice());
    //context.read<RankingBloc>().add(GetRanking());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trend ETF'),
          centerTitle: true,
        ),
        body: BlocBuilder<TestBloc, TestState>(
          builder: (context, state) {
            if (state is PriceLoading) {
              return const CircularProgressIndicator();
            } else if (state is PriceLoadSuccess) {
              List<CryptoPrice> priceHistory = state.priceList.data;
              List<CryptoPrice> before2022 = [];
              List<CryptoPrice> after2022 = [];

              for (CryptoPrice price in priceHistory) {
                DateTime date = DateTime.parse(price.date);
                if (date.year < 2022) {
                  before2022.add(price);
                } else {
                  after2022.add(price);
                }
              }
              return SingleChildScrollView(
                  child: Column(
                children: [
                  SfCartesianChart(
                      primaryXAxis: const DateTimeAxis(),
                      series: <CartesianSeries>[
                        // Renders line chart
                        LineSeries<CryptoPrice, DateTime>(
                            dataSource: before2022,
                            xValueMapper: (CryptoPrice price, _) =>
                                DateTime.parse(price.date),
                            yValueMapper: (CryptoPrice price, _) =>
                                num.parse(price.priceUsd)),
                        LineSeries<CryptoPrice, DateTime>(
                            color: Colors.red,
                            dashArray: const [4, 4],
                            dataSource: after2022,
                            xValueMapper: (CryptoPrice price, _) =>
                                DateTime.parse(price.date),
                            yValueMapper: (CryptoPrice price, _) =>
                                num.parse(price.priceUsd))
                      ]),
                  const SizedBox(
                    height: 50,
                  ),
                  AspectRatio(
                      aspectRatio: 1.25,
                      child: LineChart(LineChartData(
                        lineBarsData: [
                          // X <= 5인 데이터 포인트에 대한 선
                          LineChartBarData(
                            spots: List.generate(before2022.length, (index) {
                              return FlSpot(before2022[index].time.toDouble(),
                                  double.parse(before2022[index].priceUsd));
                            }),
                            isCurved: false,
                            color: Colors.blue,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),

                          LineChartBarData(
                            spots: List.generate(after2022.length, (index) {
                              return FlSpot(after2022[index].time.toDouble(),
                                  double.parse(after2022[index].priceUsd));
                            }),
                            isCurved: false,
                            color: Colors.red,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData:
                                const FlDotData(show: false), // 점선 구간에서는 점을 표시

                            dashArray: [4, 4], // 점선 표시를 위한 설정
                          ),
                        ],
                        // 여기에 다른 LineChartData 설정을 추가할 수 있습니다.
                      ))),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ));
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
