import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:share_app/constant/base_common.dart';
import 'package:share_app/util/http_utils.dart';
import 'package:share_app/util/sp_utils.dart';

import '../model/login_resp.dart';
import '../style/config.dart';

final Color color1 = Config.primarySwatchColor.shade100;
final Color color2 = Config.primarySwatchColor.shade200;
final Color color3 = Config.primarySwatchColor.shade300;
final Color color4 = Config.primarySwatchColor.shade400;

TextStyle titleStyle = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 30,
);

TextStyle tipStyle = const TextStyle(
  color: Config.primaryColor,
  fontWeight: FontWeight.w700,
  fontSize: 12,
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileController = TextEditingController(text: '18851699003');
  final passwordController = TextEditingController(text: '123456');
  String username = '18851699003';
  String password = '123456';

  @override
  void initState() {
    super.initState();
  }

  Future _login() async {
    var apiLogin = "users/login";

    var res = await HttpUtils.post(
      apiLogin,
      data: {"username": username, "password": password},
    );

    LoginResponse resp = LoginResponse.fromJson(res);

    var msg = resp.msg;
    var code = resp.code;
    debugPrint(msg);
    _setInfo(resp.data);
    return code;
  }

  void _setInfo(data) async {
    SpUtils.setString('token', data.token);
    print(data.token);
    BaseCommon().set();
    var res = await HttpUtils.get(
      'users/${data.userId}',
    );

    UserResponse resp = UserResponse.fromJson(res);
    SpUtils.set("avatar", resp.data.avatar);
    SpUtils.set("nickname", resp.data.nickname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color1, color2],
                      ),
                    ),
                    child: Column(),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color3, color4],
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Icon(
                          Icons.code,
                          color: Colors.white,
                          size: 60,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Coding Life',
                          style: titleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Material(
                elevation: 3,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: TextField(
                  controller: mobileController,
                  onChanged: (String value) {},
                  cursorColor: color4,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.email,
                        color: color4,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 3,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: TextField(
                  controller: passwordController,
                  onChanged: (String value) {},
                  cursorColor: color4,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: color4,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                color: color4,
              ),
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text('Login', style: titleStyle.copyWith(fontSize: 18)),
                onPressed: () {
                  setState(() {
                    username = mobileController.text;
                    password = passwordController.text;
                  });

                  _login().then((value) {
                    if (value == 1) {
                      Navigator.pushNamed(context, '/index');
                    } else {
                      debugPrint('失败');
                    }
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'FORGET PASSWORD ?',
                style: tipStyle,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don t have an Account ?',
                  style: tipStyle.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.normal),
                ),
                Text(
                  'Sign up',
                  style:
                      tipStyle.copyWith(decoration: TextDecoration.underline),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: NetworkImage(
                    'https://tva1.sinaimg.cn/large/e6c9d24egy1h6m02f4vlfj201c01cdfl.jpg',
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Image(
                  image: NetworkImage(
                    'https://tva1.sinaimg.cn/large/e6c9d24egy1h6m08u0ry5j201c01cq2p.jpg',
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Image(
                  image: NetworkImage(
                    'https://tva1.sinaimg.cn/large/e6c9d24egy1h6m07z8cacj201c01cjr5.jpg',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
