import 'package:flutter/material.dart';

import 'package:game_test/core/app/app.dart';
import 'package:game_test/dependency_injection/setup_dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependency();

  runApp(MyApp());
}
