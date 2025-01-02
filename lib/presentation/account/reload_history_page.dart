import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_prepaid_demo/core/extensions/extensions.dart';
import 'package:new_prepaid_demo/core/service_locator.dart';
import 'package:new_prepaid_demo/domain/domain.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/dialogs/single_button_dialog.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/stylish_scaffold.dart';
import 'package:new_prepaid_demo/presentation/account/blocs/reload_history_bloc.dart';

class ReloadHistoryPage extends StatefulWidget {
  const ReloadHistoryPage({super.key});

  @override
  State<ReloadHistoryPage> createState() => _ReloadHistoryPageState();
}

class _ReloadHistoryPageState extends State<ReloadHistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl.get<ReloadHistoryBloc>();
        if (bloc.state is ReloadHistoryFetchInitial) bloc.add(const ReloadHistoryFetch());
        return bloc;
      },
      child: StylishScaffold(
        title: "Reload History",
        child: BlocConsumer<ReloadHistoryBloc, ReloadHistoryState>(
          listenWhen: (pre, cur) {
            return cur is ReloadHistoryFetchFailure;
          },
          listener: _handleListener,
          buildWhen: (pre, cur) {
            return cur is! ReloadHistoryFetchFailure;
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read().add(const ReloadHistoryFetch());
              },
              child: switch (state) {
                ReloadHistoryFetchInitial() ||
                ReloadHistoryFetchLoading() =>
                  Center(child: CircularProgressIndicator()),
                ReloadHistoryFetchSuccess() => ListView.separated(
                    itemCount: state.reloadHistoriesGroupByMonth.length,
                    separatorBuilder: (ctx, index) => SizedBox(height: 16.0),
                    itemBuilder: (ctx, index) {
                      return _ReloadHistoryMonth(
                        monthYear: state.reloadHistoriesGroupByMonth.keys.toList()[index],
                        reloadHistories: state.reloadHistoriesGroupByMonth.values.toList()[index],
                      );
                    },
                  ),
                ReloadHistoryFetchFailure() => Center(child: CircularProgressIndicator()),
              },
            );
          },
        ),
      ),
    );
  }

  void _handleListener(BuildContext context, ReloadHistoryState state) {
    switch (state) {
      case ReloadHistoryFetchFailure():
        showDialog(
          context: context,
          builder: (ctx) {
            return SingleButtonDialog(
              title: "Reload History",
              message: state.exception.toString(),
              label: 'OKAY',
              onPressed: () {
                context.pop();
              },
            );
          },
        );
      default:
        break;
    }
  }
}

//region _ReloadHistoryMonth
class _ReloadHistoryMonth extends StatelessWidget {
  final DateTime monthYear;
  final List<ReloadHistory> reloadHistories;

  const _ReloadHistoryMonth({
    super.key,
    required this.monthYear,
    required this.reloadHistories,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: reloadHistories.length + 1,
      separatorBuilder: (ctx, index) => SizedBox(height: 8.0),
      itemBuilder: (ctx, index) {
        if (index == 0) {
          return Text(
            monthYear.yMMMM,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        return _ReloadHistoryItem(item: reloadHistories[index - 1]);
      },
    );
  }
}
//endregion

//region _ReloadHistoryItem
class _ReloadHistoryItem extends StatelessWidget {
  final ReloadHistory item;

  const _ReloadHistoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "+${item.amount.inMYR}",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                item.dateTime.yMdhmma,
                style: TextStyle(color: Colors.black38),
              ),
            ],
          ),
          Row(
            children: [
              // Image.asset(name),
              Icon(Icons.abc),
              SizedBox(width: 8.0),
              Text(
                "Invoice",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//endregion
