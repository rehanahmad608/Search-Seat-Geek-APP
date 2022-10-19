import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:type_ahead/bloc/type_ahead_bloc.dart';
import 'package:type_ahead/providers/providers_di.dart';
import 'package:type_ahead/repository/type_ahead_repository.dart';
import 'package:type_ahead/screens/app/nav/app_nav_cubit.dart';

class TypeAheadDi extends StatefulWidget {
  const TypeAheadDi({super.key, required this.child});

  final Widget child;
  @override
  State<TypeAheadDi> createState() => _TypeAheadDiState();
}

class _TypeAheadDiState extends State<TypeAheadDi> {
  late TypeAheadBloc _bloc;

  @override
  void initState() {
    super.initState();

    final repository = TypeAheadRepositorySimple(
      provider: ProviderDI.apiProvider,
    );
    final navigation = BlocProvider.of<AppNavCubit>(context);
    _bloc =
        TypeAheadBloc(typeAheadRepository: repository, navigation: navigation)
          ..add(const InitializedEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: widget.child,
    );
  }
}
