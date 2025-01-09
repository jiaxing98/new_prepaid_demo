import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_prepaid_demo/core/service_locator.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/dialogs/single_button_dialog.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/stylish_scaffold.dart';
import 'package:new_prepaid_demo/presentation/profile/blocs/profile_bloc.dart';
import 'package:new_prepaid_demo/presentation/profile/widgets/profile_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    final bloc = sl.get<ProfileBloc>();
    if (bloc.state is ProfileFetchInitial) bloc.add(const ProfileFetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>.value(
      value: sl.get<ProfileBloc>(),
      child: StylishScaffold(
        title: "Profile",
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listenWhen: (prev, cur) {
            return cur is ProfileFetchFailure;
          },
          listener: _handleListener,
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(const ProfileFetch());
              },
              child: switch (state) {
                ProfileFetchInitial() || ProfileFetchLoading() => ProfileInfo.loading(),
                ProfileFetchSuccess() => ProfileInfo(profile: state.profile),
                ProfileFetchFailure() => ProfileInfo.loading(),
              },
            );
          },
        ),
      ),
    );
  }

  void _handleListener(BuildContext context, ProfileState state) {
    switch (state) {
      case ProfileFetchFailure():
        showDialog(
          context: context,
          builder: (ctx) {
            return SingleButtonDialog(
              title: "Profile",
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
