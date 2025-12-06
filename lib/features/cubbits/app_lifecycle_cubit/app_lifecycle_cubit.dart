import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppLifecycleCubit extends Cubit<bool> {
  AppLifecycleCubit() : super(false);

  void markSplashCompleted() => emit(true);
}
