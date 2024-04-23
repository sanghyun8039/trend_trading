// ignore_for_file: public_member_api_docs, sort_constructors_first
class HoldingStockEntity {
  String ticker;
  num avgPrice;
  num quantity;
  HoldingStockEntity({
    required this.ticker,
    required this.avgPrice,
    required this.quantity,
  });

  Map<String, dynamic> toDocument() {
    return {
      'ticker': ticker,
      'avgPrice': avgPrice,
      'quantity': quantity,
    };
  }

  static HoldingStockEntity fromDocument(Map<String, dynamic> doc) {
    return HoldingStockEntity(
        ticker: doc['ticker'],
        avgPrice: doc['avgPrice'],
        quantity: doc['quantity']);
  }
}
