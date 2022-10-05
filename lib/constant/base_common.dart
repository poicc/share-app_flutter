import 'package:share_app/util/sp_utils.dart';

class BaseCommon {
  static const BASE_URL = 'http://localhost:10000/api/v1/';
  static String token = SpUtils.get('token') ?? '';
}
