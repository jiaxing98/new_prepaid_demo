import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_prepaid_demo/core/service_locator.dart';
import 'package:new_prepaid_demo/domain/models/reload_plan.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/cta_outlined_button.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/stylish_scaffold.dart';
import 'package:new_prepaid_demo/presentation/reload/blocs/plan_bloc.dart';
import 'package:new_prepaid_demo/presentation/reload/widgets/reload_grid.dart';
import 'package:new_prepaid_demo/router/router.dart';

class ReloadPage extends StatefulWidget {
  const ReloadPage({super.key});

  @override
  State<ReloadPage> createState() => _ReloadPageState();
}

class _ReloadPageState extends State<ReloadPage> {
  ReloadPlan? selectedPlan;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlanBloc>(
      create: (context) {
        final bloc = sl.get<PlanBloc>();
        if (bloc.state is PlanFetchInitial) bloc.add(const PlanFetch());
        return bloc;
      },
      child: StylishScaffold(
        title: "Reload",
        child: BlocBuilder<PlanBloc, PlanState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PlanBloc>().add(const PlanFetch());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: switch (state) {
                      PlanFetchInitial() || PlanFetchLoading() => ReloadGrid.loading(),
                      PlanFetchSuccess() => ReloadGrid(
                          plans: state.plans,
                          selectedPlan: selectedPlan,
                          onSelect: (plan) {
                            setState(() {
                              selectedPlan = plan;
                            });
                          },
                        ),
                      PlanFetchFailure() => ReloadGrid.loading(),
                    },
                  ),
                  CTAOutlinedButton(
                    label: "Purchase",
                    onPressed: (state is PlanFetchSuccess && selectedPlan != null)
                        ? () => context.pushNamed(Routes.payment, extra: selectedPlan)
                        : null,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
