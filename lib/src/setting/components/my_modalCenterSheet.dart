import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trend_trading/src/setting/blocs/bloc/setting_bloc.dart';

class MyModalCenterSheet extends StatefulWidget {
  const MyModalCenterSheet({super.key});

  @override
  State<MyModalCenterSheet> createState() => _MyModalCenterSheetState();
}

class _MyModalCenterSheetState extends State<MyModalCenterSheet> {
  @override
  void initState() {
    super.initState();
    context.read<SettingBloc>().add(GetManageStockList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      buildWhen: (previous, current) {
        return current is! SettingTickerLoadingFailure;
      },
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SettingTickerLoadingSuccess) {
          return Dialog(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              width: 250,
              height: 300,
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            height: 1,
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: state.stockTickerList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context.pop(state.stockTickerList[index].ticker);
                          },
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(state.stockTickerList[index].ticker),
                          )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
              child: SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator()));
        }
      },
    );
  }
}
