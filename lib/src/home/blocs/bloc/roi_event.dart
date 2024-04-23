part of 'roi_bloc.dart';

sealed class RoiEvent extends Equatable {
  const RoiEvent();

  @override
  List<Object> get props => [];
}

final class GetStockROI extends RoiEvent {}
