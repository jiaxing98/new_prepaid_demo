import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:new_prepaid_demo/core/env.dart';
import 'package:new_prepaid_demo/core/l10n/l10n.dart';
import 'package:new_prepaid_demo/core/theme/theme.dart';
import 'package:new_prepaid_demo/data/data.dart';
import 'package:new_prepaid_demo/domain/domain.dart';
import 'package:new_prepaid_demo/presentation/presentation.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> initializedApp() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  final defaultTheme =
      appThemes[Env.defaultThemeData] ?? (light: RoseWoodX.light(), dark: RoseWoodX.dark());
  final theme = sl
      .registerSingleton<ThemeCubit>(ThemeCubit(sp: sharedPreferences, defaultTheme: defaultTheme));
  theme.loadTheme();

  sl.registerSingleton<L10nCubit>(
    L10nCubit(
      defaultLocale: Locale('en'),
      supportedLocales: [
        Locale('en'),
        Locale('zh'),
        Locale('ja'),
      ],
    ),
  );

  _injectRepositories();
  _injectBlocs();
}

void _injectRepositories() {
  sl.registerSingleton<AccountRepository>(AccountRepositoryImpl());
  sl.registerSingleton<PlanRepository>(PlanRepositoryImpl());
  sl.registerSingleton<PaymentRepository>(PaymentRepositoryImpl());
}

void _injectBlocs() {
  // ! singleton - use BlocProvider.value to not close the stream
  sl.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(repository: sl.get<AccountRepository>()),
  );
  sl.registerLazySingleton<PlanBloc>(
    () => PlanBloc(repository: sl.get<PlanRepository>()),
  );
  sl.registerLazySingleton<ReloadHistoryBloc>(
    () => ReloadHistoryBloc(repository: sl.get<AccountRepository>()),
  );

  // ! factory - use BlocProvider to create new instance
  sl.registerFactory<ChangeEmailBloc>(
    () => ChangeEmailBloc(repository: sl.get<AccountRepository>()),
  );
  sl.registerFactory<ChangePasswordBloc>(
    () => ChangePasswordBloc(repository: sl.get<AccountRepository>()),
  );
  sl.registerFactory<PaymentBloc>(
    () => PaymentBloc(repository: sl.get<PaymentRepository>()),
  );
}
