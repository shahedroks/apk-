import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/firebase/firebase_bootstrap.dart';
import 'core/firebase/auth_refresh_listenable.dart';
import 'core/routes/app_router.dart';
import 'core/storage/auth_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  await AuthSession.init();
  final authRefresh = AuthRefreshListenable();
  runApp(
    ProviderScope(
      child: App(router: createAppRouter(refreshListenable: authRefresh)),
    ),
  );
}
