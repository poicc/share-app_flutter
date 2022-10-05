class AdvResponse {
  AdvResponse({
    required this.code,
    required this.msg,
    required this.data,
  });
  late final int code;
  late final String msg;
  late final List<Advertise> data;

  AdvResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    code = json['code'];
    msg = json['msg'];
    data = list.map((e) => Advertise.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['msg'] = msg;
    _data['data'] = data;
    return _data;
  }
}

class Advertise {
  late String cover;
  late String url;
  late bool isDisplay;
  late int id;

  Advertise(
      {required this.cover,
      required this.url,
      required this.isDisplay,
      required this.id});

  Advertise.fromJson(Map<String, dynamic> json) {
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
