// ignore_for_file: public_member_api_docs, sort_constructors_first
class StockTickerEntity {
  String ticker;
  String description;
  StockTickerEntity({
    required this.ticker,
    required this.description,
  });

  Map<String, dynamic> toDocument() {
    return {
      'ticker': ticker,
      'description': description,
    };
  }

  static StockTickerEntity fromDocument(Map<String, dynamic> doc) {
    return StockTickerEntity(
        ticker: doc['ticker'], description: doc['description']);
  }
}
