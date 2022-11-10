import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_app/page/login_page.dart';
import 'package:share_app/page/tabs.dart';
import 'package:share_app/page/update_page.dart';
import 'package:share_app/style/themes.dart';
import 'package:share_app/util/http_utils.dart';
import 'package:share_app/util/sp_utils.dart';

import 'constant/base_common.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStore();
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
}

Future<void> initStore() async {
  // 初始化本地存储类
  await SpUtils.getInstance();
  // 初始化request类
  HttpUtils.init(
    baseUrl: BaseCommon.BASE_URL,
  );
}

class SpUtil {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1334),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            routes: {
              '/index': (context) => const Tabs(),
              '/login': (context) => const LoginPage(),
              '/update': (context) => const UpdatePage(),
            },
            title: 'Flutter Demo',
            theme: defaultTheme,
            home: const Tabs(),
          );
        });
  }
}
