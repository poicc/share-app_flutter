import 'package:flutter/material.dart';
import 'package:share_app/page/login_page.dart';
import 'package:share_app/page/tabs.dart';
import 'package:share_app/util/sp_utils.dart';
import 'package:share_app/util/themes.dart';

void main() async {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/index': (context) => const Tabs(),
        '/login': (context) => const LoginPage(),
      },
      title: 'Flutter Demo',
      theme: defaultTheme,
      home: const Tabs(),
    );
  }
}
