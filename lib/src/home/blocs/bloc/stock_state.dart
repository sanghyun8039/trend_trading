part of 'stock_bloc.dart';

sealed class StockState extends Equatable {
  const StockState();

  @override
  List<Object> get props => [];
}

final class StockInitial extends StockState {}

final class StockLoading extends StockState {}

final class StockLoadingSuccess extends StockState {
  final List<StockMomentum> momentumList;

  const StockLoadingSuccess({required this.momentumList});
}

final class StockLoadingFailure extends StockState {}
