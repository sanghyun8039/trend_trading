part of 'canary_bloc.dart';

sealed class CanaryState extends Equatable {
  const CanaryState();

  @override
  List<Object> get props => [];
}

final class CanaryInitial extends CanaryState {}

final class CanaryStockLoading extends CanaryState {}

final class CanaryStockLoadingSuccess extends CanaryState {
  final List<StockMomentum> list;

  const CanaryStockLoadingSuccess({required this.list});
}

final class CanaryStockLoadingFailure extends CanaryState {}
