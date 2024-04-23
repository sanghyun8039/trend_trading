part of 'ranking_bloc.dart';

sealed class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object> get props => [];
}

final class RankingInitial extends RankingState {}

final class RankingLoading extends RankingState {}

final class RankingLoadSuccess extends RankingState {
  final List<StockRanking> stockRankingList;
  final List<StockTicker> stockTickerList;
  const RankingLoadSuccess({
    required this.stockTickerList,
    required this.stockRankingList,
  });
}

final class RankingLoadFailure extends RankingState {}
