import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend_trading/src/setting/blocs/bloc/setting_bloc.dart';
import 'package:trend_trading/src/setting/components/my_modalCenterSheet.dart';

class MyModalBottomSheet extends StatefulWidget {
  const MyModalBottomSheet({super.key});

  @override
  State<MyModalBottomSheet> createState() => _MyModalBottomSheetState();
}

class _MyModalBottomSheetState extends State<MyModalBottomSheet> {
  late TextEditingController avgPriceController;
  late TextEditingController quantityController;
  String tickerValue = '----';

  @override
  void initState() {
    super.initState();
    avgPriceController = TextEditingController();
    quantityController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double bottomSheetWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Ticker : '),
                    Text(tickerValue),
                    IconButton(
                        onPressed: () {
                          showDialog(
                                  context: context,
                                  builder: (_) => const MyModalCenterSheet())
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                tickerValue = value; // 받아온 값을 tickerValue에 할당
                              });
                            }
                          });
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Avg.Price : '),
                        SizedBox(
                            height: 25,
                            width: bottomSheetWidth * 0.2,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: avgPriceController,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Quantity : '),
                        SizedBox(
                            height: 25,
                            width: bottomSheetWidth * 0.2,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: quantityController,
                            ))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: bottomSheetWidth,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                        backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                    onPressed: () {
                      context.read<SettingBloc>().add(AddMyETF(
                          ticker: tickerValue,
                          avgPrice: num.parse(avgPriceController.text),
                          quantity: num.parse(quantityController.text)));
                    },
                    child: const Text('ADD'),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
