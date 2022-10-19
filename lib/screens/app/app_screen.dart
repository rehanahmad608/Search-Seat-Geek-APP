import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:type_ahead/screens/app/nav/app_nav_cubit.dart';
import 'package:type_ahead/screens/app/nav/app_nav_delegate.dart';
import 'package:type_ahead/screens/app/nav/app_nav_parser.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_di.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppNavCubit _appNavCubit;
  late AppRouterDelegate _appRouterDelegate;
  final AppParser _appParser = AppParser();

  @override
  void initState() {
    super.initState();
    _appNavCubit = AppNavCubit();
    _appRouterDelegate = AppRouterDelegate(appNavCubit: _appNavCubit);
  }

  @override
  void dispose() {
    _appNavCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _appNavCubit,
      child: TypeAheadDi(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routerDelegate: _appRouterDelegate,
          routeInformationParser: _appParser,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          darkTheme: ThemeData.dark(),
        ),
      ),
    );
  }
}
