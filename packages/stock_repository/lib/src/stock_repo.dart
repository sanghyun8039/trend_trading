import 'package:stock_repository/src/models/holding_stock.dart';
import 'package:stock_repository/src/models/stock_momentum.dart';
import 'package:stock_repository/src/models/stock_ticker.dart';
import 'package:stock_repository/src/models/test/test_crypto.dart';

import '../stock_repository.dart';

abstract class StockRepository {
  Future<StockRSI> getStockRSI(String ticker);
  Future<StockPrice> getStockPriceChange(String ticker);
  Future<StockMomentum> getStockMomentumChange(StockTicker ticker);
  Future<List<StockTicker>> getStockTickerList();
  Future<List<StockTicker>> getCanaryTickerList();
  Future<List<HoldingStock>> getMyETFList();
  Future<List<StockRanking>> getStockRankingList();
  Future<void> setStockMomentum(List<StockMomentum> stockMomentumList);
  Future<void> removeManageTicker(String ticker);
  Future<void> addManageTicker(StockTicker ticker);
  Future<void> addMyETFTicker(HoldingStock ticker);
  Future<bool> searchTicker(String ticker);
//==============================================================================
  Future<CryptoHistory> getCryptoPriceList();
}
