part of 'app_nav_cubit.dart';

abstract class AppNavPath extends Equatable implements BasePath {
  const AppNavPath();

  @override
  List<Object> get props => [];
}

class HomePath extends AppNavPath {}

class DetailsPath extends AppNavPath {}
