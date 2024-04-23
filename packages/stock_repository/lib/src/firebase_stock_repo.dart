import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_repository/src/common.dart';
import 'package:stock_repository/src/entities/entities.dart';
import 'package:stock_repository/src/entities/holding_stock_entity.dart';
import 'package:stock_repository/src/entities/stock_rsi_entity.dart';
import 'package:stock_repository/src/entities/test/test_crypto_entity.dart';
import 'package:stock_repository/src/models/holding_stock.dart';
import 'package:stock_repository/src/models/stock_momentum.dart';
import 'package:stock_repository/src/models/stock_price.dart';
import 'package:stock_repository/src/models/stock_ranking.dart';
import 'package:stock_repository/src/models/stock_rsi.dart';
import 'package:stock_repository/src/models/stock_ticker.dart';
import 'package:stock_repository/src/models/test/test_crypto.dart';
import 'package:stock_repository/src/stock_repo.dart';
import 'package:dio/dio.dart';

import 'entities/stock_price_entity.dart';
import 'entities/stock_ticker_entity.dart';

class FireBaseStockRepository implements StockRepository {
  Dio dio = Dio();
  @override
  Future<StockPrice> getStockPriceChange(String ticker) async {
    var data = await dio.get(
        'https://financialmodelingprep.com/api/v3/stock-price-change/$ticker?apikey=${CommonValue.apiKey}');
    StockPrice price =
        StockPrice.fromEntity(StockPriceEntity.fromDocument(data.data[0]));
    return price;
  }

  @override
  Future<StockMomentum> getStockMomentumChange(StockTicker symbol) async {
    StockPrice price = await getStockPriceChange(symbol.ticker);
    StockRSI rsi = await getStockRSI(symbol.ticker);
    print('${rsi.date}-----${rsi.rsi}');
    StockMomentum momentum = StockMomentum(
        symbol: symbol,
        the1M: (price.the1M / 100) * 12,
        the3M: (price.the3M / 100) * 4,
        the6M: (price.the6M / 100) * 2,
        the1Y: (price.the1Y / 100) * 1,
        momentumScore: ((price.the1M / 100) * 12 +
                (price.the3M / 100) * 4 +
                (price.the6M / 100) * 2 +
                (price.the1Y / 100) * 1) /
            4,
        rsi: rsi);
    return momentum;
  }

  @override
  Future<List<StockTicker>> getStockTickerList() async {
    var data = await FirebaseFirestore.instance.collection('tickers').get();

    List<StockTicker> list = [];
    for (var item in data.docs) {
      StockTicker ticker =
          StockTicker.fromEntity(StockTickerEntity.fromDocument(item.data()));
      list.add(ticker);
    }
    return list;
  }

  @override
  Future<List<StockTicker>> getCanaryTickerList() async {
    var data = await FirebaseFirestore.instance.collection('canary').get();

    List<StockTicker> list = [];
    for (var item in data.docs) {
      StockTicker ticker =
          StockTicker.fromEntity(StockTickerEntity.fromDocument(item.data()));
      list.add(ticker);
    }
    return list;
  }

  @override
  Future<List<HoldingStock>> getMyETFList() async {
    var data = await FirebaseFirestore.instance.collection('myETF').get();

    List<HoldingStock> list = [];
    for (var item in data.docs) {
      HoldingStock ticker =
          HoldingStock.fromEntity(HoldingStockEntity.fromDocument(item.data()));
      list.add(ticker);
    }
    return list;
  }

  @override
  Future<void> setStockMomentum(List<StockMomentum> stockMomentumList) async {
    var ref = FirebaseFirestore.instance.collection('momentumRanking');
    List<Map<String, dynamic>> rankings = [];
    var value = await ref
        .where("date", isEqualTo: DateTime.now().toString().substring(0, 10))
        .get();
    if (value.docs.isEmpty) {
      for (int i = 0; i < stockMomentumList.length; i++) {
        var stockMomentum = stockMomentumList[i];
        var rankingData = {
          'ranking': i + 1,
          'stockMomentum': stockMomentum.toEntity().toDocument(),
        };
        rankings.add(rankingData);
      }

      Map<String, dynamic> savedData = {
        'date': DateTime.now().toString().substring(0, 10),
        'rankings': rankings,
      };

      await ref.add(savedData);
    } else {
      print('Already Data Exist!');
    }
  }

  @override
  Future<StockRSI> getStockRSI(String ticker) async {
    var data = await dio.get(
        'https://financialmodelingprep.com/api/v3/technical_indicator/1day/$ticker?type=rsi&period=10&apikey=${CommonValue.apiKey}');
    StockRSI rsi =
        StockRSI.fromEntity(StockRSIEntity.fromDocument(data.data[0]));
    return rsi;
  }

  @override
  Future<List<StockRanking>> getStockRankingList() async {
    var ref = FirebaseFirestore.instance
        .collection('momentumRanking')
        .orderBy('date');
    List<StockRanking> rankingList = [];
    var data = await ref.get();
    for (var item in data.docs) {
      var rankingItem = item.data();
      StockRanking ranking =
          StockRanking.fromEntity(StockRankingEntity.fromDocument(rankingItem));
      rankingList.add(ranking);
    }
    return rankingList;
  }

  @override
  Future<CryptoHistory> getCryptoPriceList() async {
    var data = await dio.get(
        'https://api.coincap.io/v2/assets/bitcoin/history?interval=d1&start=1521179428000&end=1710600781739');
    CryptoHistory priceList =
        CryptoHistory.fromEntity(CryptoHistoryEntity.fromDocument(data.data));
    print(priceList);
    return priceList;
  }

  @override
  Future<void> removeManageTicker(String ticker) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await db.collection('tickers').where('ticker', isEqualTo: ticker).get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await db.collection('tickers').doc(doc.id).delete();
    }
  }

  @override
  Future<void> addManageTicker(StockTicker ticker) async {
    var ref = FirebaseFirestore.instance.collection('tickers');

    ref.add({'ticker': ticker.ticker, 'description': ticker.description});
  }

  @override
  Future<void> addMyETFTicker(HoldingStock stock) async {
    var ref = FirebaseFirestore.instance.collection('myETF');
    ref.add({
      'ticker': stock.ticker,
      'avgPrice': stock.avgPrice,
      'quantity': stock.quantity
    });
  }

  @override
  Future<bool> searchTicker(String ticker) async {
    var data = await dio.get(
        'https://financialmodelingprep.com/api/v3/search-ticker?query=$ticker&limit=10&exchange=AMEX&apikey=vd5SlyuBivOFA3uxJ68FYiZyGojM1AiU');
    if (data.data.length != 0) {
      return true;
    } else {
      return false;
    }
  }
}
