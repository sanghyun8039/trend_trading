import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:trend_trading/src/trend/blocs/bloc/ranking_bloc.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<GetCryptoPrice>(_getCryptoPrice);
  }
}

Future<void> _getCryptoPrice(
    GetCryptoPrice event, Emitter<TestState> emit) async {
  emit(PriceLoading());
  try {
    var priceList = await repository.getCryptoPriceList();
    emit(PriceLoadSuccess(priceList: priceList));
  } catch (e) {}
}
