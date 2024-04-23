// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stock_repository/src/entities/holding_stock_entity.dart';

class HoldingStock {
  String ticker;
  num avgPrice;
  num quantity;
  HoldingStock({
    required this.ticker,
    required this.avgPrice,
    required this.quantity,
  });

  HoldingStockEntity toEntity() {
    return HoldingStockEntity(
        ticker: ticker, avgPrice: avgPrice, quantity: quantity);
  }

  static HoldingStock fromEntity(HoldingStockEntity entity) {
    return HoldingStock(
        ticker: entity.ticker,
        avgPrice: entity.avgPrice,
        quantity: entity.quantity);
  }
}
