import 'package:stock_repository/src/entities/stock_rsi_entity.dart';

class StockRSI {
  String date;
  num open;
  num high;
  num low;
  num close;
  int volume;
  num rsi;

  StockRSI(
      {required this.date,
      required this.open,
      required this.high,
      required this.low,
      required this.close,
      required this.volume,
      required this.rsi});

  static StockRSI fromEntity(StockRSIEntity entity) {
    return StockRSI(
        date: entity.date,
        open: entity.open,
        high: entity.high,
        low: entity.low,
        close: entity.close,
        volume: entity.volume,
        rsi: entity.rsi);
  }

  StockRSIEntity toEntity() {
    return StockRSIEntity(
        date: date,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume,
        rsi: rsi);
  }
}
