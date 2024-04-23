// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_repository/stock_repository.dart';

class ROIWidget extends StatefulWidget {
  List<StockROI> roiList;
  ROIWidget({
    super.key,
    required this.roiList,
  });

  @override
  State<ROIWidget> createState() => _ROIWidgetState();
}

class _ROIWidgetState extends State<ROIWidget> {
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
    double avgROI = 0;
    // ROI 누적 계산
    for (var roi in widget.roiList) {
      avgROI += ((roi.nowPrice - roi.avgPrice) * 100 / roi.avgPrice);
    }
    // ROI 평균 계산
    if (widget.roiList.isNotEmpty) {
      avgROI /= widget.roiList.length;
    }
    return Container(
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              SizedBox(
                width: 275,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 5);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: _controller,
                  itemCount: 1000000,
                  itemBuilder: (context, index) {
                    final adjustedIndex = index % widget.roiList.length;
                    final roi = ((widget.roiList[adjustedIndex].nowPrice -
                            widget.roiList[adjustedIndex].avgPrice) *
                        100 /
                        widget.roiList[adjustedIndex].avgPrice);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(widget.roiList[adjustedIndex].ticker),
                            Text(
                              widget.roiList[adjustedIndex].avgPrice.toString(),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        Text(widget.roiList[adjustedIndex].nowPrice.toString()),
                        Text(
                          '${roi.toStringAsFixed(2)} %',
                          style: TextStyle(
                              color: roi < 0 ? Colors.red : Colors.blue),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Text('${avgROI.toStringAsFixed(2)} %'),
            ],
          ),
        ));
  }
}
