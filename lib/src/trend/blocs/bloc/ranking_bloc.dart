import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_repository/stock_repository.dart';

part 'ranking_event.dart';
part 'ranking_state.dart';

StockRepository repository = FireBaseStockRepository();

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  RankingBloc() : super(RankingInitial()) {
    on<GetRanking>(_getRankingData);
  }
}

Future<void> _getRankingData(
    GetRanking event, Emitter<RankingState> emit) async {
  emit(RankingLoading());
  try {
    var stockRankingList = await repository.getStockRankingList();
    var stockTickerList = await repository.getStockTickerList();
    emit(RankingLoadSuccess(
        stockRankingList: stockRankingList, stockTickerList: stockTickerList));
  } catch (e) {}
}
