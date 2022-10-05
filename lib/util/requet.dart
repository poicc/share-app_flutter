/// 指定返回响应格式
class HttpResponseFormat {
  String? codeKey;
  String? successCodeValue;
  String? dataKey;
  String? msgKey;
  String? tokenKey;

  HttpResponseFormat(
      this.codeKey, this.dataKey, this.msgKey, this.successCodeValue,
      {this.tokenKey});
}
