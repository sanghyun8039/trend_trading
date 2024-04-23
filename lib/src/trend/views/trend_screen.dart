import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:trend_trading/src/trend/blocs/bloc/ranking_bloc.dart';

class TrendScreen extends StatefulWidget {
  const TrendScreen({super.key});

  @override
  State<TrendScreen> createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    context.read<RankingBloc>().add(GetRanking());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trend ETF'),
          centerTitle: true,
        ),
        body: BlocBuilder<RankingBloc, RankingState>(
          builder: (context, state) {
            if (state is RankingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RankingLoadSuccess) {
              List<StockRanking> stockRankingList = state.stockRankingList;
              List<StockTicker> uniqueTickers = state.stockTickerList;

              var stockRankingDataSource =
                  StockRankingDataSource(stockRankingData: stockRankingList);

              List<RankingWithDate> rankingWithDates = [];
              for (var stockRanking in stockRankingList) {
                for (var ranking in stockRanking.stockMomentumList) {
                  rankingWithDates.add(RankingWithDate(
                    date: stockRanking.date,
                    ranking: ranking.ranking,
                    stockMomentum: ranking.stockMomentum,
                  ));
                }
              }

              List<LineSeries<RankingWithDate, DateTime>> chartSeries =
                  uniqueTickers.map((ticker) {
                // rankingWithDates에서 해당 ticker에 대한 데이터만 필터링합니다.
                List<RankingWithDate> rankingsForTicker = rankingWithDates
                    .where((ranking) =>
                        ranking.stockMomentum.symbol.ticker == ticker.ticker)
                    .toList();
                return LineSeries<RankingWithDate, DateTime>(
                  dataSource: rankingsForTicker,
                  xValueMapper: (RankingWithDate r, _) =>
                      DateTime.parse(r.date),
                  yValueMapper: (RankingWithDate r, _) => r.ranking,
                  name: ticker.ticker,
                  dataLabelMapper: (RankingWithDate data, _) =>
                      data.stockMomentum.symbol.ticker,
                );
              }).toList();

              return SingleChildScrollView(
                child: Column(children: [
                  SfDataGrid(
                    source: stockRankingDataSource,
                    columnWidthMode: ColumnWidthMode.fill,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'date',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Date',
                              ))),
                      GridColumn(
                          columnName: 'ranking_1',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('1st'))),
                      GridColumn(
                          columnName: 'ranking_2',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('2nd'))),
                      GridColumn(
                          columnName: 'ranking_3',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('3rd'))),
                      GridColumn(
                          columnName: 'ranking_4',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('4th'))),
                      GridColumn(
                          columnName: 'ranking_5',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('5th'))),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SfCartesianChart(
                      tooltipBehavior: _tooltipBehavior,
                      primaryXAxis: const DateTimeAxis(
                        intervalType: DateTimeIntervalType.days,
                      ),
                      primaryYAxis: const NumericAxis(
                        isInversed: true, // 낮은 랭킹이 위로 오도록 Y축 뒤집기
                        maximum: 10,
                      ),
                      series: chartSeries),
                  const SizedBox(
                    height: 50,
                  ),
                ]),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}

class StockRankingDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  StockRankingDataSource({required List<StockRanking> stockRankingData}) {
    _stockRankingData = stockRankingData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.date),
              DataGridCell<String>(
                  columnName: 'ranking_1',
                  value: e.stockMomentumList[0].stockMomentum.symbol.ticker),
              DataGridCell<String>(
                  columnName: 'ranking_2',
                  value: e.stockMomentumList[1].stockMomentum.symbol.ticker),
              DataGridCell<String>(
                  columnName: 'ranking_3',
                  value: e.stockMomentumList[2].stockMomentum.symbol.ticker),
              DataGridCell<String>(
                  columnName: 'ranking_4',
                  value: e.stockMomentumList[3].stockMomentum.symbol.ticker),
              DataGridCell<String>(
                  columnName: 'ranking_5',
                  value: e.stockMomentumList[4].stockMomentum.symbol.ticker),
            ]))
        .toList();
  }

  List<DataGridRow> _stockRankingData = [];

  @override
  List<DataGridRow> get rows => _stockRankingData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}

class RankingWithDate {
  final String date;
  final int ranking;
  final StockMomentum stockMomentum;

  RankingWithDate({
    required this.date,
    required this.ranking,
    required this.stockMomentum,
  });
}
