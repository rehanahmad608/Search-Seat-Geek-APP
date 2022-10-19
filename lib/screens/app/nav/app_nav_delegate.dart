import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:type_ahead/screens/details/details_page.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_page.dart';

import 'app_nav_cubit.dart';

class AppRouterDelegate extends RouterDelegate<AppNavPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppNavPath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'AppRouterDelegateKey');

  final AppNavCubit _appNavCubit;
  late final StreamSubscription<AppNavPath> _subscription;

  AppRouterDelegate({required AppNavCubit appNavCubit})
      : _appNavCubit = appNavCubit {
    _subscription = _appNavCubit.stream.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Future<void> setNewRoutePath(AppNavPath configuration) async {
    _appNavCubit.routeTo(configuration);
  }

  @override
  AppNavPath? get currentConfiguration {
    return _appNavCubit.state;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNavCubit, AppNavPath>(
      bloc: _appNavCubit,
      builder: (context, state) {
        final pages = [
          const TypeAheadPage(),
          if (state is DetailsPath) const DetailPage(),
        ];
        return Navigator(
          key: navigatorKey,
          observers: [HeroController()],
          pages: pages,
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }

            _appNavCubit.pop();
            return true;
          },
        );
      },
    );
  }
}
