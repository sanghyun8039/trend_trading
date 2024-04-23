import 'package:stock_repository/src/models/ranking.dart';
import 'package:stock_repository/stock_repository.dart';

class StockRanking {
  String date;
  List<Ranking> stockMomentumList;
  StockRanking({
    required this.date,
    required this.stockMomentumList,
  });

  StockRankingEntity toEntity() {
    return StockRankingEntity(date: date, stockMomentumList: stockMomentumList);
  }

  static StockRanking fromEntity(StockRankingEntity entity) {
    return StockRanking(
      date: entity.date,
      stockMomentumList: entity.stockMomentumList,
    );
  }
}
