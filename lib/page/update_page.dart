import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plugins/Plugins.dart';
import '../util/http_utils.dart';
import '../util/screen_adaper.dart';
import '../util/sp_utils.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late File _file;
  var _croppFile;
  var nickname = '';

  String imageUrl =
      'https://images.pexels.com/photos/13538314/pexels-photo-13538314.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load';
  var id;
  String changeName = '';

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
        imageUrl = (SpUtils.getString('avatar'))!;
        id = (SpUtils.get('userId'))!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("修改个人信息"),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Container(
            color: const Color.fromRGBO(233, 233, 233, 0.7),
            child: ListView(
              children: <Widget>[
                InkWell(
                  onTap: showSelectPicker,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenAdapter.setWidth(20)),
                    color: Colors.white,
                    height: ScreenAdapter.setHeight(150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '头像',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenAdapter.size(28)),
                        ),
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl),
                              radius: 30.0,
                            ),
                            const Icon(Icons.chevron_right)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('请输入需要修改的昵称'),
                            content: Card(
                              elevation: 0.0,
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: '请输入...',
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                    ),
                                    onChanged: (v) {
                                      setState(() {
                                        changeName = v;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('取消'),
                              ),
                              CupertinoDialogAction(
                                onPressed: () async {
                                  var api = "users/update";

                                  var res = await HttpUtils.post(
                                    api,
                                    data: {
                                      "id": id,
                                      "mobile": "",
                                      "password": "",
                                      "nickname": changeName,
                                      "avatar": "",
                                      "bonus": 0
                                    },
                                  );
                                  print(res);
                                  setState(() {
                                    nickname = changeName;
                                  });
                                  SpUtils.set("nickname", nickname);
                                  Navigator.pop(context);
                                },
                                child: const Text('确定'),
                              ),
                            ],
                          );
                        });
                  },
                  child: UserInfoList('昵称', nickname),
                ),
                // Text('')
                _croppFile != null ? Image.file(_croppFile) : const Text('')
              ],
            ),
          ),
        ));
  }

  // 选择图片
  showSelectPicker() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
              height: ScreenAdapter.setHeight(200),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      var file = await Plugins.takePhoto();
                      if (file != null) {
                        print(file);
                        print(file.path);
                        // 获取图片路径
                        setState(() {
                          _file = File(file.path);
                        });
                        // 关闭弹窗
                        Navigator.pop(context);
                        // 获取裁剪后地址

                        var croppFile =
                            await Plugins.cropImage(context, file.path);
                        // 请求接口上传图片
                        if (croppFile != null) {
                          var apiLogin = "file/upload";

                          var res = await HttpUtils.post(
                            apiLogin,
                            data: await FormData1(croppFile.path),
                          );

                          var imgurl = json.decode(res.toString());
                          setState(() {
                            print(imgurl);
                            imageUrl = imgurl;
                          });
                          setState(() {
                            _croppFile = croppFile;
                          });
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: ScreenAdapter.setHeight(100),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 0.5, color: Colors.black26))),
                      child: const Text('拍照'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var file = await Plugins.openGalley();
                      if (file != null) {
                        setState(() {
                          _file = File(file.path);
                        });
                        Navigator.pop(context);
                        var croppFile = await Plugins.cropImage(context, _file);
                        if (croppFile != null) {
                          var apiLogin = "file/upload";

                          var res = await HttpUtils.post(
                            apiLogin,
                            data: await FormData1(croppFile.path),
                          );

                          var imgurl = json.decode(res.toString());
                          setState(() {
                            print(imgurl);
                            imageUrl = imgurl;
                          });
                          setState(() {
                            _croppFile = croppFile;
                          });
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: ScreenAdapter.setHeight(100),
                      child: const Text('相册选择'),
                    ),
                  )
                ],
              ));
        });
  }

  // dio上传文件FormData格式
  Future<FormData> FormData1(fileUrl) async {
    return FormData.fromMap(
        {"uploadFile": await MultipartFile.fromFile(fileUrl)});
  }

  // 用户信息列表
  Widget UserInfoList(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenAdapter.setWidth(20)),
      color: Colors.white,
      height: ScreenAdapter.setHeight(150),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: ScreenAdapter.size(28)),
          ),
          Row(
            children: <Widget>[Text(subtitle), const Icon(Icons.chevron_right)],
          )
        ],
      ),
    );
  }
}
