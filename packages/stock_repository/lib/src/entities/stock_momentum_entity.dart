import 'package:stock_repository/src/entities/stock_ticker_entity.dart';

import '../../stock_repository.dart';

class StockMomentumEntity {
  StockTicker symbol;
  num the1M;
  num the3M;
  num the6M;
  num the1Y;
  num momentumScore;
  StockRSI rsi;
  StockMomentumEntity({
    required this.symbol,
    required this.the1M,
    required this.the3M,
    required this.the6M,
    required this.the1Y,
    required this.momentumScore,
    required this.rsi,
  });

  Map<String, dynamic> toDocument() {
    return {
      'symbol': symbol.toEntity().toDocument(),
      '1M': the1M,
      '3M': the3M,
      '6M': the6M,
      '1Y': the1Y,
      'momentumScore': momentumScore,
      'rsi': rsi.toEntity().toDocument()
    };
  }

  static StockMomentumEntity fromDocument(Map<String, dynamic> doc) {
    StockTicker ticker =
        StockTicker.fromEntity(StockTickerEntity.fromDocument(doc['symbol']));
    StockRSI rsi = StockRSI.fromEntity(StockRSIEntity.fromDocument(doc['rsi']));
    return StockMomentumEntity(
        symbol: ticker,
        the1M: doc['1M'],
        the3M: doc['3M'],
        the6M: doc['6M'],
        the1Y: doc['1Y'],
        momentumScore: doc['momentumScore'],
        rsi: rsi);
  }
}
