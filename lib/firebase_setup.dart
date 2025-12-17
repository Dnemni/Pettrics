// This file will contain the initial Firebase setup for the Pettrics Flutter app.
// It will be updated with actual configuration after Firebase is added to the project.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
