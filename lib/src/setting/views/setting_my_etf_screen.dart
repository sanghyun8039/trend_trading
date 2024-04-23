import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trend_trading/src/setting/blocs/bloc/setting_bloc.dart';
import 'package:trend_trading/src/setting/components/my_modalBottomSheet.dart';

class MyETFScreen extends StatefulWidget {
  const MyETFScreen({super.key});

  @override
  State<MyETFScreen> createState() => _MyETFScreenState();
}

class _MyETFScreenState extends State<MyETFScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingBloc>().add(GetMyETFList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My ETF'),
      ),
      body: BlocConsumer<SettingBloc, SettingState>(
        buildWhen: (previous, current) {
          return current is! SettingTickerLoading &&
              current is SettingMyETFLoadingSuccess;
        },
        listener: (context, state) {
          if (state is SettingAddMyETFSuccess) {
            context.pop();
            context.read<SettingBloc>().add(GetMyETFList());
          }
        },
        builder: (context, state) {
          if (state is SettingMyETFLoadingSuccess) {
            return Stack(children: [
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                  );
                },
                itemCount: state.holdingStockList.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_forever_rounded),
                      onPressed: () {
                        context.read<SettingBloc>().add(RemoveManageStock(
                            ticker: state.holdingStockList[index].ticker));
                      },
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.holdingStockList[index].ticker),
                            Text(
                              state.holdingStockList[index].avgPrice.toString(),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        Text(state.holdingStockList[index].quantity.toString()),
                      ],
                    ),
                  );
                },
              )
            ]);
          } else {
            print('@@@@@@@@@@@$state@@@@@@@@@@@@');
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const MyModalBottomSheet());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
