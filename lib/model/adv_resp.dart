class AdvResponse {
  AdvResponse({
    required this.code,
    required this.msg,
    required this.data,
  });
  late final int code;
  late final String msg;
  late final List<dynamic> data;

  AdvResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['msg'] = msg;
    _data['data'] = data;
    return _data;
  }
}

class Adverise {
  late String cover;
  late String url;
  late bool isDisplay;
  late int id;

  Adverise(
      {required this.cover,
      required this.url,
      required this.isDisplay,
      required this.id});

  Adverise.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    url = json['url'];
    isDisplay = json['isDisplay'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cover'] = cover;
    _data['url'] = url;
    _data['isDisplay'] = isDisplay;
    return _data;
  }
}
