import 'package:flutter/material.dart';
import 'package:webview/config.dart';
import 'package:webview/webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // color: Colors.amber,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(int.parse(config.primary)),
          secondary: const Color(0xFFFFC107),
        ),
      ),
      home: webvi(),
    );
  }
}
