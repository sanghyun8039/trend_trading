import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_repository/stock_repository.dart';

part 'roi_event.dart';
part 'roi_state.dart';

StockRepository repository = FireBaseStockRepository();

class RoiBloc extends Bloc<RoiEvent, RoiState> {
  RoiBloc() : super(RoiInitial()) {
    on<GetStockROI>(_getStockROI);
  }
}

FutureOr<void> _getStockROI(GetStockROI event, Emitter<RoiState> emit) async {
  emit(StockROILoading());
  try {
    List<StockROI> stockROIList = [];
    List<HoldingStock> holdingStockList = await repository.getMyETFList();
    List<StockRanking> stockRankingList =
        await repository.getStockRankingList();
    StockRanking recentData = stockRankingList.last;
    // HoldingStock의 각 항목에 대하여 처리
    for (var holdingStock in holdingStockList) {
      Ranking matchingRanking = recentData.stockMomentumList.firstWhere(
          (element) =>
              element.stockMomentum.symbol.ticker == holdingStock.ticker);
      StockROI roi = StockROI(
          ticker: holdingStock.ticker,
          avgPrice: holdingStock.avgPrice,
          nowPrice: matchingRanking.stockMomentum.rsi.close);
      stockROIList.add(roi);
    }
    emit(StockROILoadingSuccess(roiList: stockROIList));
  } catch (e) {}
}
