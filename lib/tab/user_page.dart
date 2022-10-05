import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_app/style/config.dart';
import 'package:share_app/util/sp_utils.dart';

import '../style/colors.dart';
import '../style/text_styles.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late String nickname = '暂未登录';
  late String avatar =
      'https://img.ixintu.com/download/jpg/20200917/d38df2c52b6a439dff388445fa5a5050_512_512.jpg';
  @override
  void initState() {
    super.initState();
    _getHttp();
  }

  _getHttp() async {
    await SpUtils.getInstance();
    if (SpUtils.getString('nickname') != '') {
      setState(() {
        nickname = (SpUtils.getString('nickname'))!;
        avatar = (SpUtils.getString('avatar'))!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 360,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(colors: [
                Config.primarySwatchColor.shade100,
                Config.primarySwatchColor.shade400
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                Text(
                  nickname,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 10,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            avatar,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: linerColor4,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Flutter Developer",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'SCS - 212',
                  style: correctMessageStyle,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                    Text(
                      'Yangshan North Street 1,NANJING',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.blue,
                      icon: const Icon(FontAwesomeIcons.qq),
                      onPressed: () {},
                    ),
                    IconButton(
                      color: Colors.green,
                      icon: const Icon(FontAwesomeIcons.weixin),
                      onPressed: () {},
                    ),
                    IconButton(
                      color: Colors.red.shade600,
                      icon: const Icon(FontAwesomeIcons.weibo),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 16,
                      ),
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Config.primarySwatchColor.shade100,
                            Config.primarySwatchColor.shade400
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(FontAwesomeIcons.user),
                            onPressed: () {},
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.location_on),
                            onPressed: () {},
                          ),
                          const Spacer(),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.add),
                            onPressed: () {},
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.message),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const Icon(Icons.favorite),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
              IconButton(
                onPressed: () {
                  SpUtils.clear();
                  Navigator.pushNamed(context, '/login');
                },
                icon: const Icon(Icons.logout),
              )
            ],
          ),
        ],
      ),
    );
  }
}
