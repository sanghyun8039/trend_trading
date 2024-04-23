class StockRSIEntity {
  String date;
  num open;
  num high;
  num low;
  num close;
  int volume;
  num rsi;

  StockRSIEntity(
      {required this.date,
      required this.open,
      required this.high,
      required this.low,
      required this.close,
      required this.volume,
      required this.rsi});

  Map<String, dynamic> toDocument() {
    return {
      'date': date,
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'volume': volume,
      'rsi': rsi,
    };
  }

  static StockRSIEntity fromDocument(Map<String, dynamic> doc) {
    return StockRSIEntity(
        date: doc['date'],
        open: doc['open'],
        high: doc['high'],
        low: doc['low'],
        close: doc['close'],
        volume: doc['volume'],
        rsi: doc['rsi']);
  }
}
