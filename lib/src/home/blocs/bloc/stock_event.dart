part of 'stock_bloc.dart';

sealed class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

final class GetStockData extends StockEvent {}

final class GetStockDataByHive extends StockEvent {}
