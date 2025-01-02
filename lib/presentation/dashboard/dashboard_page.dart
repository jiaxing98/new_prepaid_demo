import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_prepaid_demo/router/router.dart';

class DashboardPage extends StatefulWidget {
  final Widget child;

  const DashboardPage({super.key, required this.child});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 4, vsync: this);
    GoRouter.of(context).routerDelegate.addListener(_updateTabIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    GoRouter.of(context).routerDelegate.removeListener(_updateTabIndex);

    super.dispose();
  }

  void _updateTabIndex() {
    final currentLocation = GoRouter.of(context).routerDelegate.currentConfiguration.last;
    switch (currentLocation.route.name) {
      case Routes.home:
        _controller.index = 0;
      case Routes.reload:
        _controller.index = 1;
      case Routes.profile:
        _controller.index = 2;
      case Routes.account:
        _controller.index = 3;
      default:
        _controller.index = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: _controller,
          onTap: _onChangedTab,
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.add_circle)),
            Tab(icon: Icon(Icons.account_circle)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }

  void _onChangedTab(int index) {
    switch (index) {
      case 0:
        context.goNamed(Routes.home);
      case 1:
        context.goNamed(Routes.reload);
      case 2:
        context.goNamed(Routes.profile);
      case 3:
        context.goNamed(Routes.account);
      default:
        context.goNamed(Routes.home);
    }
  }
}
