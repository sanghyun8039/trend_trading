part of 'setting_bloc.dart';

sealed class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

final class SettingInitial extends SettingState {}

final class SettingTickerLoading extends SettingState {}

final class SettingTickerLoadingSuccess extends SettingState {
  final List<StockTicker> stockTickerList;
  const SettingTickerLoadingSuccess({required this.stockTickerList});

  @override
  List<Object> get props => [stockTickerList];
}

final class SettingTickerLoadingFailure extends SettingState {}

final class SettingRemoveTickerSuccess extends SettingState {}

final class SettingRemoveTickerFailure extends SettingState {}

final class SettingAddTickerSuccess extends SettingState {
  final List<StockTicker> stockTickerList;
  const SettingAddTickerSuccess({required this.stockTickerList});

  @override
  List<Object> get props => [stockTickerList];
}

final class SettingAddTickerFailure extends SettingState {
  final String error;

  const SettingAddTickerFailure({required this.error});
}

final class SettingMyETFLoading extends SettingState {}

final class SettingMyETFLoadingSuccess extends SettingState {
  final List<HoldingStock> holdingStockList;
  const SettingMyETFLoadingSuccess({required this.holdingStockList});

  @override
  List<Object> get props => [holdingStockList];
}

final class SettingAddMyETFSuccess extends SettingState {
  final List<HoldingStock> holdingStockList;
  const SettingAddMyETFSuccess({required this.holdingStockList});

  @override
  List<Object> get props => [holdingStockList];
}

final class SettingAddMyETFFailure extends SettingState {
  final String error;

  const SettingAddMyETFFailure({required this.error});
}

final class SettingRemoveMyETFSuccess extends SettingState {}

final class SettingRemoveMyETFFailure extends SettingState {}
