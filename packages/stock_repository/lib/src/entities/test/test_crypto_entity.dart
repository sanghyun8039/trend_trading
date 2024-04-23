import 'package:stock_repository/src/models/test/test_crypto.dart';

class CryptoHistoryEntity {
  List<CryptoPrice> data;

  CryptoHistoryEntity({
    required this.data,
  });

  Map<String, dynamic> toDocument() {
    return {'data': data};
  }

  static CryptoHistoryEntity fromDocument(Map<String, dynamic> doc) {
    List<CryptoPrice> cryptoPriceList = [];
    for (var item in doc['data']) {
      CryptoPrice cryptoPrice =
          CryptoPrice.fromEntity(CryptoPriceEntity.fromDocument(item));
      cryptoPriceList.add(cryptoPrice);
    }

    return CryptoHistoryEntity(data: cryptoPriceList);
  }
}

class CryptoPriceEntity {
  String priceUsd;
  int time;
  String date;

  CryptoPriceEntity({
    required this.priceUsd,
    required this.time,
    required this.date,
  });

  Map<String, dynamic> toDocument() {
    return {'priceUsd': priceUsd, 'time': time, 'date': date};
  }

  static CryptoPriceEntity fromDocument(Map<String, dynamic> doc) {
    return CryptoPriceEntity(
      date: doc['date'],
      priceUsd: doc['priceUsd'],
      time: doc['time'],
    );
  }
}
