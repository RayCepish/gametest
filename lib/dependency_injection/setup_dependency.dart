import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'setup_dependency.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> setupDependency() async => getIt.init();
