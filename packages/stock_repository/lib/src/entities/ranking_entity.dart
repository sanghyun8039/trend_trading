// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stock_repository/src/entities/entities.dart';
import 'package:stock_repository/src/models/models.dart';

class RankingEntity {
  int ranking;
  StockMomentum stockMomentum;
  RankingEntity({
    required this.ranking,
    required this.stockMomentum,
  });

  Map<String, dynamic> toDocument() {
    return {
      'ranking': ranking,
      'stockMomentum': stockMomentum.toEntity().toDocument()
    };
  }

  static RankingEntity fromDocument(Map<String, dynamic> doc) {
    StockMomentum stockMomentum = StockMomentum.fromEntity(
        StockMomentumEntity.fromDocument(doc['stockMomentum']));
    return RankingEntity(ranking: doc['ranking'], stockMomentum: stockMomentum);
  }
}
