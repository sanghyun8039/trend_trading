class StockPriceEntity {
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

  StockPriceEntity({
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

  // Map<String, dynamic> toDocument() {}

  static StockPriceEntity fromDocument(Map<String, dynamic> doc) {
    return StockPriceEntity(
        symbol: doc['symbol'],
        the1D: doc['1D'],
        the5D: doc['5D'],
        the1M: doc['1M'],
        the3M: doc['3M'],
        the6M: doc['6M'],
        ytd: doc['ytd'],
        the1Y: doc['1Y'],
        the3Y: doc['3Y'],
        the5Y: doc['5Y'],
        the10Y: doc['10Y'],
        max: doc['max']);
  }
}
