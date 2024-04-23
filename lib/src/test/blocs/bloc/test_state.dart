part of 'test_bloc.dart';

sealed class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

final class TestInitial extends TestState {}

final class PriceLoading extends TestState {}

final class PriceLoadSuccess extends TestState {
  final CryptoHistory priceList;

  const PriceLoadSuccess({required this.priceList});
}
