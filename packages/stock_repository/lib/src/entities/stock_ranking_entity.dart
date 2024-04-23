// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stock_repository/src/entities/ranking_entity.dart';
import 'package:stock_repository/src/models/ranking.dart';
import 'package:stock_repository/stock_repository.dart';

class StockRankingEntity {
  String date;
  List<Ranking> stockMomentumList;
  StockRankingEntity({
    required this.date,
    required this.stockMomentumList,
  });

  Map<String, dynamic> toDocument() {
    return {'date': date, 'rankings': stockMomentumList};
  }

  static StockRankingEntity fromDocument(Map<String, dynamic> doc) {
    List<Ranking> stockMomentumList = [];
    for (var item in doc['rankings']) {
      Ranking ranking = Ranking.fromEntity(RankingEntity.fromDocument(item));
      stockMomentumList.add(ranking);
    }
    return StockRankingEntity(
      date: doc['date'],
      stockMomentumList: stockMomentumList,
    );
  }
}
