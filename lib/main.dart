import 'package:flutter/material.dart';
import 'package:share_app/page/login_page.dart';
import 'package:share_app/page/tabs.dart';
import 'package:share_app/style/themes.dart';
import 'package:share_app/util/http.dart';
import 'package:share_app/util/requet.dart';
import 'package:share_app/util/sp_utils.dart';

import 'constant/base_common.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Request request = Request();

void main() async {
  request.init(
    baseUrl: BaseCommon.BASE_URL,
    responseFormat: HttpResponseFormat('code', 'data', 'msg', '1'),
  );
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
      navigatorKey: navigatorKey,
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
