// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stock_repository/src/entities/stock_momentum_entity.dart';
import 'package:stock_repository/src/models/models.dart';

class StockMomentum {
  StockTicker symbol;
  num the1M;
  num the3M;
  num the6M;
  num the1Y;
  num momentumScore;
  StockRSI rsi;
  StockMomentum({
    required this.symbol,
    required this.the1M,
    required this.the3M,
    required this.the6M,
    required this.the1Y,
    required this.momentumScore,
    required this.rsi,
  });

  StockMomentumEntity toEntity() {
    return StockMomentumEntity(
        symbol: symbol,
        the1M: the1M,
        the3M: the3M,
        the6M: the6M,
        the1Y: the1Y,
        momentumScore: momentumScore,
        rsi: rsi);
  }

  static StockMomentum fromEntity(StockMomentumEntity entity) {
    return StockMomentum(
        symbol: entity.symbol,
        the1M: entity.the1M,
        the3M: entity.the3M,
        the6M: entity.the6M,
        the1Y: entity.the1Y,
        momentumScore: entity.momentumScore,
        rsi: entity.rsi);
  }
}
