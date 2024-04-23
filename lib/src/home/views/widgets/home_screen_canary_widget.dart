// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_repository/stock_repository.dart';

class CanaryWidget extends StatefulWidget {
  List<StockMomentum> canaryList;
  CanaryWidget({
    super.key,
    required this.canaryList,
  });

  @override
  State<CanaryWidget> createState() => _CanaryWidgetState();
}

class _CanaryWidgetState extends State<CanaryWidget> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
  }

  void _startAutoScroll() {
    const duration = Duration(milliseconds: 1000); // 스크롤 속도 조정
    const scrollAmount = 10.0; // 한 번에 스크롤할 양 조정

    _timer = Timer.periodic(duration, (timer) {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;

      if (currentScroll + scrollAmount > maxScroll) {
        // 스크롤이 끝에 도달했을 경우, 시작점으로 되돌림
        _controller.jumpTo(0.0);
      } else {
        _controller.animateTo(
          _controller.position.pixels + scrollAmount,
          duration: duration,
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 위젯이 dispose될 때 타이머 정리
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 30,
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemCount: 1000000,
        itemBuilder: (context, index) {
          final adjustedIndex = index % widget.canaryList.length;
          return Container(
            width: 75,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(widget.canaryList[adjustedIndex].symbol.ticker),
                Text(
                  widget.canaryList[adjustedIndex].momentumScore
                      .toStringAsFixed(2),
                  style: TextStyle(
                      color: widget.canaryList[adjustedIndex].momentumScore >= 0
                          ? Colors.blue
                          : widget.canaryList[adjustedIndex].momentumScore < 0
                              ? Colors.red
                              : Colors.grey.shade400),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
