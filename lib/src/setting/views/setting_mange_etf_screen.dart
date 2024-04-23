import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trend_trading/src/setting/blocs/bloc/setting_bloc.dart';
import 'package:trend_trading/src/setting/components/manage_modalBottomSheet.dart';

class ManageETFScreen extends StatefulWidget {
  const ManageETFScreen({super.key});

  @override
  State<ManageETFScreen> createState() => _ManageETFScreenState();
}

class _ManageETFScreenState extends State<ManageETFScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingBloc>().add(GetManageStockList());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController tickerController = TextEditingController();
    TextEditingController descController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage ETF'),
      ),
      body: BlocConsumer<SettingBloc, SettingState>(
        buildWhen: (previous, current) {
          return current is! SettingAddTickerFailure;
        },
        listener: (context, state) {
          if (state is SettingAddTickerSuccess) {
            context.pop();
            context.read<SettingBloc>().add(GetManageStockList());
          }
        },
        builder: (context, state) {
          if (state is SettingTickerLoading) {
            return const CircularProgressIndicator();
          } else if (state is SettingTickerLoadingSuccess) {
            return Stack(children: [
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                  );
                },
                itemCount: state.stockTickerList.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_forever_rounded),
                      onPressed: () {
                        context.read<SettingBloc>().add(RemoveManageStock(
                            ticker: state.stockTickerList[index].ticker));
                      },
                    ),
                    title: Text(state.stockTickerList[index].ticker),
                  );
                },
              ),
            ]);
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tickerController.clear(); // BottomSheet를 열 때마다 입력 필드 초기화
          descController.clear();

          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const ManageModalBottomSheet());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
