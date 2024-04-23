import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_repository/stock_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

StockRepository repository = FireBaseStockRepository();

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<GetManageStockList>(_getManageStockList);
    on<RemoveManageStock>(_removeManageStock);
    on<AddManageStock>(_addManageStock);

    on<GetMyETFList>(_getMyETFList);
    on<RemoveMyETF>(_removeMyETF);
    on<AddMyETF>(_addMyETF);
  }

  Future<void> _getManageStockList(
      GetManageStockList event, Emitter<SettingState> emit) async {
    emit(SettingTickerLoading());
    try {
      var stockTickerList = await repository.getStockTickerList();
      emit(SettingTickerLoadingSuccess(stockTickerList: stockTickerList));
    } catch (e) {}
  }

  Future<void> _removeManageStock(
      RemoveManageStock event, Emitter<SettingState> emit) async {
    try {
      await repository.removeManageTicker(event.ticker);
      var stockTickerList = await repository.getStockTickerList();
      emit(SettingTickerLoadingSuccess(stockTickerList: stockTickerList));
    } catch (e) {}
  }

  FutureOr<void> _addManageStock(
      AddManageStock event, Emitter<SettingState> emit) async {
    bool isExistTicker = await repository.searchTicker(event.ticker);
    try {
      if (isExistTicker) {
        StockTicker stockTicker =
            StockTicker(ticker: event.ticker, description: event.description);
        await repository.addManageTicker(stockTicker);
        var stockTickerList = await repository.getStockTickerList();
        emit(SettingAddTickerSuccess(stockTickerList: stockTickerList));
      } else {
        emit(const SettingAddTickerFailure(error: "Ticker Not Exist"));
      }
    } catch (e) {}
  }

  FutureOr<void> _getMyETFList(
      GetMyETFList event, Emitter<SettingState> emit) async {
    emit(SettingMyETFLoading());
    try {
      var holdingStockList = await repository.getMyETFList();
      emit(SettingMyETFLoadingSuccess(holdingStockList: holdingStockList));
    } catch (e) {}
  }

  FutureOr<void> _addMyETF(AddMyETF event, Emitter<SettingState> emit) async {
    //bool isExistTicker = await repository.searchTicker(event.ticker);

    try {
      if (true) {
        HoldingStock holdingStock = HoldingStock(
            ticker: event.ticker,
            avgPrice: event.avgPrice,
            quantity: event.quantity);
        await repository.addMyETFTicker(holdingStock);
        var holdingStockList = await repository.getMyETFList();
        emit(SettingAddMyETFSuccess(holdingStockList: holdingStockList));
      }
    } catch (e) {}
  }

  FutureOr<void> _removeMyETF(RemoveMyETF event, Emitter<SettingState> emit) {}
}
