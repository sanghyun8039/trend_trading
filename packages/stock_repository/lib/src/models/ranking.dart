import 'package:stock_repository/src/entities/ranking_entity.dart';
import 'package:stock_repository/stock_repository.dart';

class Ranking {
  int ranking;
  StockMomentum stockMomentum;
  Ranking({
    required this.ranking,
    required this.stockMomentum,
  });

  RankingEntity toEntity() {
    return RankingEntity(ranking: ranking, stockMomentum: stockMomentum);
  }

  static Ranking fromEntity(RankingEntity entity) {
    return Ranking(
      ranking: entity.ranking,
      stockMomentum: entity.stockMomentum,
    );
  }
}
