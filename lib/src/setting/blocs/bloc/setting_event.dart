part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

final class GetManageStockList extends SettingEvent {}

final class RemoveManageStock extends SettingEvent {
  final String ticker;

  const RemoveManageStock({required this.ticker});
}

final class AddManageStock extends SettingEvent {
  final String ticker;
  final String description;

  const AddManageStock({required this.ticker, required this.description});
}

final class GetMyETFList extends SettingEvent {}

final class RemoveMyETF extends SettingEvent {
  final String ticker;

  const RemoveMyETF({required this.ticker});
}

final class AddMyETF extends SettingEvent {
  final String ticker;
  final num avgPrice;
  final num quantity;

  const AddMyETF(
      {required this.ticker, required this.avgPrice, required this.quantity});
}
