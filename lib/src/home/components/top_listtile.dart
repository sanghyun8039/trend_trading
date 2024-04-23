import 'package:flutter/material.dart';
import 'package:stock_repository/stock_repository.dart';

class TopListTile extends StatelessWidget {
  final StockMomentum stock;
  final int index;
  const TopListTile({super.key, required this.stock, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(width: 1), borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('$index'),
          Column(
            children: [
              Text(stock.symbol.ticker),
              Text(stock.symbol.description)
            ],
          ),
          Column(
            children: [
              Text(stock.momentumScore.toStringAsFixed(2)),
              Text(
                stock.rsi.rsi.toStringAsFixed(2),
                style: TextStyle(
                    color: stock.rsi.rsi >= 70
                        ? Colors.red
                        : stock.rsi.rsi <= 30
                            ? Colors.blue
                            : Colors.grey.shade400),
              ),
            ],
          )
        ],
      ),
    );
  }
}
