import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/di/service_locator.dart';
import 'package:flutter_projects/firebase_options.dart';
import 'package:flutter_projects/skill_radar_app.dart';

String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupGetIt();
  runApp(const SkillRadarApp());
}
