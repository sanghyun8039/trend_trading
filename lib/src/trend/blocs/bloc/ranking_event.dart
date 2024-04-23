part of 'ranking_bloc.dart';

sealed class RankingEvent extends Equatable {
  const RankingEvent();

  @override
  List<Object> get props => [];
}

final class GetRanking extends RankingEvent {}

final class GetStockTicker extends RankingEvent {}
