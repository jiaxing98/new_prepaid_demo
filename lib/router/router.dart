import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_prepaid_demo/domain/models/reload_plan.dart';
import 'package:new_prepaid_demo/presentation/account/account_page.dart';
import 'package:new_prepaid_demo/presentation/account/reload_history_page.dart';
import 'package:new_prepaid_demo/presentation/dashboard/dashboard_page.dart';
import 'package:new_prepaid_demo/presentation/home/home_page.dart';
import 'package:new_prepaid_demo/presentation/profile/change_email_page.dart';
import 'package:new_prepaid_demo/presentation/profile/change_password_page.dart';
import 'package:new_prepaid_demo/presentation/profile/profile_page.dart';
import 'package:new_prepaid_demo/presentation/reload/payment_page.dart';
import 'package:new_prepaid_demo/presentation/reload/reload_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.home,
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return DashboardPage(child: child);
      },
      routes: [
        GoRoute(
          path: Routes.home,
          name: Routes.home,
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: Routes.reload,
          name: Routes.reload,
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return const ReloadPage();
          },
          routes: [
            GoRoute(
              path: Routes.payment,
              name: Routes.payment,
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                return PaymentPage(selectedPlan: state.extra as ReloadPlan);
              },
            ),
          ],
        ),
        GoRoute(
          path: Routes.profile,
          name: Routes.profile,
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return const ProfilePage();
          },
          routes: [
            GoRoute(
              path: Routes.changeEmail,
              name: Routes.changeEmail,
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final currentEmail = state.uri.queryParameters["current_email"];
                return ChangeEmailPage(currentEmail: currentEmail);
              },
            ),
            GoRoute(
              path: Routes.changePassword,
              name: Routes.changePassword,
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                return const ChangePasswordPage();
              },
            ),
          ],
        ),
        GoRoute(
          path: Routes.account,
          name: Routes.account,
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return const AccountPage();
          },
          routes: [
            GoRoute(
              path: Routes.reloadHistory,
              name: Routes.reloadHistory,
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                return ReloadHistoryPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

abstract final class Routes {
  static const String home = "/";

  static const String reload = "/reload";
  static const String payment = "payment";

  static const String profile = "/profile";
  static const String changeEmail = "email";
  static const String changePassword = "password";

  static const String account = "/account";
  static const String reloadHistory = "reloadHistory";
}
