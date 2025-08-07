import 'package:admin_panel/data/repositories/authentication_repository.dart';
import 'package:admin_panel/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize GetX Local Storage
  await GetStorage.init();
  setPathUrlStrategy();
  // Remove # sign from url
  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).
  then((value) => Get.put(AuthenticationRepository()));
  // Main App Starts here...
  runApp(const App());
}
