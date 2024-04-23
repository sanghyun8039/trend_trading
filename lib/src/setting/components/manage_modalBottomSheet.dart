import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend_trading/src/setting/blocs/bloc/setting_bloc.dart';

class ManageModalBottomSheet extends StatefulWidget {
  const ManageModalBottomSheet({super.key});

  @override
  State<ManageModalBottomSheet> createState() => _ManageModalBottomSheetState();
}

class _ManageModalBottomSheetState extends State<ManageModalBottomSheet> {
  late TextEditingController tickerController;
  late TextEditingController descController;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    tickerController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double bottomSheetWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          String errorMessage = ''; // 에러 메시지 초기화

          if (state is SettingAddTickerFailure) {
            // 에러 상태일 경우, 에러 메시지 업데이트
            errorMessage = state.error;
          }
          return SizedBox(
            width: bottomSheetWidth,
            child: Wrap(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Ticker : '),
                        SizedBox(
                            height: 25,
                            width: bottomSheetWidth * 0.625,
                            child: TextField(
                              controller: tickerController,
                            ))
                      ],
                    ),
                    errorMessage.isNotEmpty
                        ? // 에러 메시지가 있을 경우에만 표시
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(errorMessage,
                                style: const TextStyle(color: Colors.red)),
                          )
                        : const SizedBox(
                            height: 35,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Description : '),
                        SizedBox(
                            height: 25,
                            width: bottomSheetWidth * 0.6,
                            child: TextField(
                              controller: descController,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        width: bottomSheetWidth,
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)))),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue)),
                            onPressed: () {
                              context.read<SettingBloc>().add(AddManageStock(
                                  ticker: tickerController.text.toString(),
                                  description: descController.text.toString()));
                            },
                            child: const Text('ADD')))
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
