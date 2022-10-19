import 'package:get_it/get_it.dart';
import 'package:type_ahead/providers/providers_di.dart';

class MainDiConfigurator extends DiConfigurator {
  MainDiConfigurator()
      : super(serviceDiDelegates: [
          ProviderDI(),
        ]);
}

GetIt getIt = GetIt.I;

abstract class Di {}

abstract class ServiceDi implements Di {
  Future<void> create(GetIt container);
}

class DiConfigurator {
  DiConfigurator({
    required this.serviceDiDelegates,
  });

  final List<ServiceDi> serviceDiDelegates;

  Future<void> init() async {
    await _initServices();
    await getIt.allReady();
  }

  Future<void> _initServices() async {
    for (final service in serviceDiDelegates) {
      await service.create(getIt);
    }
  }
}

class TestDiConfigurator extends DiConfigurator {
  TestDiConfigurator({required List<ServiceDi> serviceDiDelegates})
      : super(serviceDiDelegates: serviceDiDelegates);
}
