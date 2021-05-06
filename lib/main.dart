import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/utilities/dynamicLink.dart';
import 'dart:io';
import 'app.dart';
import './utilities/firstTimeVisitChecker.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = new MyHttpOverrides();

  await Firebase.initializeApp();
  await DynamicLink().handleDynamicLink();

  runApp(
    ProviderScope(
      child: MyApp(
        firstTimeVisit: await FirstTimeVisitChecker().firstTimeVisitChecker(),
      ),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
