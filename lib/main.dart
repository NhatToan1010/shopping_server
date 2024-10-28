import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';

import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // --- Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // --- GetX LocalStorage
  await GetStorage.init();

  // --- Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // --- Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

