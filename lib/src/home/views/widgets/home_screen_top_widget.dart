// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:stock_repository/stock_repository.dart';

import 'package:trend_trading/src/home/components/top_listtile.dart';

class TopWidget extends StatelessWidget {
  List<StockMomentum> stockList;
  TopWidget({
    super.key,
    required this.stockList,
  });

  @override
  Widget build(BuildContext context) {
    List<StockMomentum> mometumList = [];
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 15,
        );
      },
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        mometumList.add(stockList[index]);
        return TopListTile(
          index: index + 1,
          stock: stockList[index],
        );
      },
    );
  }
}
