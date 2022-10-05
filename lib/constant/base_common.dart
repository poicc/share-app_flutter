import 'package:share_app/util/sp_utils.dart';

class BaseCommon {
  static const BASE_URL = 'http://localhost:10000/api/v1/';
  String token = SpUtils.get('token') ?? '';

  get() {
    return token;
  }

  set() {
    token = SpUtils.get('token');
  }

  clear() {
    token = '';
  }
}
