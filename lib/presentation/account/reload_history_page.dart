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

    final bloc = sl.get<ReloadHistoryBloc>();
    if (bloc.state is ReloadHistoryFetchInitial) bloc.add(const ReloadHistoryFetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReloadHistoryBloc>.value(
      value: sl.get(),
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
                context.read<ReloadHistoryBloc>().add(const ReloadHistoryFetch());
              },
              child: switch (state) {
                ReloadHistoryFetchInitial() ||
                ReloadHistoryFetchLoading() =>
                  Center(child: CircularProgressIndicator()),
                ReloadHistoryFetchSuccess() => ListView.separated(
                    itemCount: state.reloadHistoriesGroupByMonth.length,
                    separatorBuilder: (ctx, index) => SizedBox(height: 16.0),
                    itemBuilder: (ctx, index) {
                      return ReloadHistoryMonth(
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

//region ReloadHistoryMonth
class ReloadHistoryMonth extends StatelessWidget {
  final DateTime monthYear;
  final List<ReloadHistory> reloadHistories;

  const ReloadHistoryMonth({
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

        return ReloadHistoryItem(item: reloadHistories[index - 1]);
      },
    );
  }
}
//endregion

//region ReloadHistoryItem
class ReloadHistoryItem extends StatelessWidget {
  final ReloadHistory item;

  const ReloadHistoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        border: Border.all(color: context.colorScheme.primary),
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
                style: TextStyle(color: context.colorScheme.onPrimaryContainer),
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
