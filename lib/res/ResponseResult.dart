import 'package:share_app/model/login_resp.dart';

class ResponseResult {
  late final int code;
  late final String msg;
  late final Data data;

  ResponseResult({required this.code, required this.msg, required this.data});

  ResponseResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }
}
