import 'package:flutter/material.dart';
import 'package:type_ahead/screens/app/app_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final diConfigurator = MainDiConfigurator();
  await diConfigurator.init();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}
