import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:trend_trading/common/constant_value.dart';

part 'stock_event.dart';
part 'stock_state.dart';

StockRepository repository = FireBaseStockRepository();

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(StockInitial()) {
    on<GetStockData>(_getStockData);
    on<GetStockDataByHive>(_getStockDataByHive);
  }
}

Future<void> _getStockDataByHive(
    GetStockDataByHive event, Emitter<StockState> emit) async {
  emit(StockLoading());
  try {
    Box box = await Hive.openBox(ConstantValue.stockMomentumFileName);
    List<StockMomentum> momentumList = [];
    for (var item in box.values.toList()) {
      Map<String, dynamic> data = json.decode(json.encode(item));
      StockMomentum momentum =
          StockMomentum.fromEntity(StockMomentumEntity.fromDocument(data));

      momentumList.add(momentum);
    }

    momentumList.sort((a, b) => b.momentumScore.compareTo(a.momentumScore));
    await setStockMomentumData(momentumList);
    emit(StockLoadingSuccess(momentumList: momentumList));
  } catch (e) {}
}

void _getStockData(GetStockData event, Emitter<StockState> emit) async {
  emit(StockLoading());
  try {
    List<StockTicker> list = await repository.getStockTickerList();
    List<StockMomentum> momentumList = [];
    for (var item in list) {
      StockMomentum data = await repository.getStockMomentumChange(item);
      momentumList.add(data);
      createItem(data.toEntity().toDocument());
    }
    momentumList.sort((a, b) => b.momentumScore.compareTo(a.momentumScore));
    await setStockMomentumData(momentumList);
    emit(StockLoadingSuccess(momentumList: momentumList));
  } catch (e) {}
}

Future<void> createItem(Map<String, dynamic> newItem) async {
  final stockMomentumBox = Hive.box(ConstantValue.stockMomentumFileName);
  await stockMomentumBox.add(newItem);
}

Future<void> setStockMomentumData(List<StockMomentum> list) async {
  try {
    await repository.setStockMomentum(list);
  } catch (e) {}
}
