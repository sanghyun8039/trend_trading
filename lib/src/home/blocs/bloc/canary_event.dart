part of 'canary_bloc.dart';

sealed class CanaryEvent extends Equatable {
  const CanaryEvent();

  @override
  List<Object> get props => [];
}

final class GetCanaryStockData extends CanaryEvent {}

final class GetCanaryStockDataByHive extends CanaryEvent {}
