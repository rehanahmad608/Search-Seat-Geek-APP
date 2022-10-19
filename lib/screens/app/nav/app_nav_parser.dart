import 'package:flutter/material.dart';

import 'app_nav_cubit.dart';

class AppParser extends RouteInformationParser<AppNavPath> {
  @override
  Future<AppNavPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    return HomePath();
  }

  @override
  RouteInformation restoreRouteInformation(AppNavPath configuration) {
    return const RouteInformation(location: '/');
  }
}
