import '../entities/stock_price_entity.dart';

class StockPrice {
  String symbol;
  num the1D;
  num the5D;
  num the1M;
  num the3M;
  num the6M;
  num ytd;
  num the1Y;
  num the3Y;
  num the5Y;
  num the10Y;
  num max;

  StockPrice({
    required this.symbol,
    required this.the1D,
    required this.the5D,
    required this.the1M,
    required this.the3M,
    required this.the6M,
    required this.ytd,
    required this.the1Y,
    required this.the3Y,
    required this.the5Y,
    required this.the10Y,
    required this.max,
  });

  StockPriceEntity toEntity() {
    return StockPriceEntity(
      symbol: symbol,
      the1D: the1D,
      the5D: the5D,
      the1M: the1M,
      the3M: the3M,
      the6M: the6M,
      ytd: ytd,
      the1Y: the1Y,
      the3Y: the3Y,
      the5Y: the5Y,
      the10Y: the10Y,
      max: max,
    );
  }

  static StockPrice fromEntity(StockPriceEntity entity) {
    return StockPrice(
        symbol: entity.symbol,
        the1D: entity.the1D,
        the5D: entity.the5D,
        the1M: entity.the1M,
        the3M: entity.the3M,
        the6M: entity.the6M,
        ytd: entity.ytd,
        the1Y: entity.the1Y,
        the3Y: entity.the3Y,
        the5Y: entity.the5Y,
        the10Y: entity.the10Y,
        max: entity.max);
  }
}
