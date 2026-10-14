import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/routes/app_router.dart';
import 'core/storage/auth_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthSession.init();
  runApp(ProviderScope(child: App(router: createAppRouter())));
}
