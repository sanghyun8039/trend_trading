import 'package:stock_repository/src/entities/test/test_crypto_entity.dart';

class CryptoHistory {
  List<CryptoPrice> data;

  CryptoHistory({
    required this.data,
  });

  CryptoHistoryEntity toEntity() {
    return CryptoHistoryEntity(data: data);
  }

  static CryptoHistory fromEntity(CryptoHistoryEntity entity) {
    return CryptoHistory(data: entity.data);
  }
}

class CryptoPrice {
  String priceUsd;
  int time;
  String date;

  CryptoPrice({
    required this.priceUsd,
    required this.time,
    required this.date,
  });

  CryptoPriceEntity toEntity() {
    return CryptoPriceEntity(priceUsd: priceUsd, time: time, date: date);
  }

  static CryptoPrice fromEntity(CryptoPriceEntity entity) {
    return CryptoPrice(
        date: entity.date, priceUsd: entity.priceUsd, time: entity.time);
  }
}
