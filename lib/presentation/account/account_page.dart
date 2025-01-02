import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/stylish_scaffold.dart';
import 'package:new_prepaid_demo/presentation/account/widgets/account_container.dart';
import 'package:new_prepaid_demo/presentation/account/widgets/theme_dialog.dart';
import 'package:new_prepaid_demo/router/router.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StylishScaffold(
      title: 'Account',
      child: ListView(
        children: [
          AccountPayment(),
          SizedBox(height: 16.0),
          AccountSettings(),
        ],
      ),
    );
  }
}

//region AccountPayment
class AccountPayment extends StatelessWidget {
  const AccountPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      title: 'Payment',
      children: [
        AccountContainerTile(
          image: "",
          label: "Reload History",
          onTap: () {
            context.pushNamed(Routes.reloadHistory);
          },
        ),
        AccountContainerTile(image: "", label: "E-Bill", onTap: () {}),
      ],
    );
  }
}
//endregion

//region AccountSettings
class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      title: 'Settings',
      children: [
        AccountContainerTile(image: "", label: "Language", onTap: () {}),
        AccountContainerTile(
          image: "",
          label: "Theme",
          onTap: () {
            showDialog(context: context, builder: (ctx) => const ThemeDialog());
          },
        ),
      ],
    );
  }
}
//endregion
