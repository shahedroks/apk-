import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Registers the native Firestore channel before auth flows use it.
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );
}
