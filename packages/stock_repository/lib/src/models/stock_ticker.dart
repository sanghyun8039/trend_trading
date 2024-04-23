// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stock_repository/src/entities/stock_ticker_entity.dart';

class StockTicker {
  String ticker;
  String description;
  StockTicker({
    required this.ticker,
    required this.description,
  });

  static StockTicker fromEntity(StockTickerEntity entity) {
    return StockTicker(ticker: entity.ticker, description: entity.description);
  }

  StockTickerEntity toEntity() {
    return StockTickerEntity(ticker: ticker, description: description);
  }
}
