part of 'roi_bloc.dart';

sealed class RoiState extends Equatable {
  const RoiState();

  @override
  List<Object> get props => [];
}

final class RoiInitial extends RoiState {}

final class StockROILoading extends RoiState {}

final class StockROILoadingSuccess extends RoiState {
  final List<StockROI> roiList;

  const StockROILoadingSuccess({required this.roiList});
}

final class StockROILoadingFailure extends RoiState {}
