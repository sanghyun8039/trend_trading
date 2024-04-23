import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:trend_trading/common/constant_value.dart';

part 'canary_event.dart';
part 'canary_state.dart';

StockRepository repository = FireBaseStockRepository();

class CanaryBloc extends Bloc<CanaryEvent, CanaryState> {
  CanaryBloc() : super(CanaryInitial()) {
    on<GetCanaryStockData>(_getCanaryStockData);
    on<GetCanaryStockDataByHive>(_getCanaryStockDataByHive);
  }
}

Future<void> _getCanaryStockDataByHive(
    GetCanaryStockDataByHive event, Emitter<CanaryState> emit) async {
  emit(CanaryStockLoading());
  try {
    Box box = await Hive.openBox(ConstantValue.canaryMomentumFileName);
    List<StockMomentum> momentumList = [];
    for (var item in box.values.toList()) {
      Map<String, dynamic> data = json.decode(json.encode(item));
      StockMomentum momentum =
          StockMomentum.fromEntity(StockMomentumEntity.fromDocument(data));

      momentumList.add(momentum);
    }

    emit(CanaryStockLoadingSuccess(list: momentumList));
  } catch (e) {}
}

Future<void> _getCanaryStockData(
    GetCanaryStockData event, Emitter<CanaryState> emit) async {
  emit(CanaryStockLoading());
  try {
    List<StockTicker> canaryTickerList = await repository.getCanaryTickerList();
    List<StockMomentum> canaryStockMomentum = [];
    for (var item in canaryTickerList) {
      StockMomentum data = await repository.getStockMomentumChange(item);
      canaryStockMomentum.add(data);
      _createItem(data.toEntity().toDocument());
    }
    emit(CanaryStockLoadingSuccess(list: canaryStockMomentum));
  } catch (e) {}
}

Future<void> _createItem(Map<String, dynamic> newItem) async {
  final stockMomentumBox = Hive.box(ConstantValue.canaryMomentumFileName);
  await stockMomentumBox.add(newItem);
}
