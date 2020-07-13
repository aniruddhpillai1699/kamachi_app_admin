import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:kamachi_app_admin/Pages/root_page.dart';
import 'dart:io';

import 'package:kamachi_app_admin/Services/authentication.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'IT Incident Report-Plant',
      home: new RootPage(auth: new Auth()),
    );
  }
}
