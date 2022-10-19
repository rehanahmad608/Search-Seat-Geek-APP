import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:type_ahead/navigation/navigation.dart';

part 'app_nav_state.dart';

class AppNavCubit extends Cubit<AppNavPath> with BaseNav {
  AppNavCubit() : super(HomePath());

  @override
  BasePath get currentPath => state;

  @override
  BaseNav? get parent => null;

  @override
  BasePath get homePath => HomePath();

  @override
  void routeTo(covariant AppNavPath state) {
    emit(state);
  }
}
