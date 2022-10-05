class ShareResponse {
  ShareResponse({
    required this.code,
    required this.msg,
    required this.data,
  });
  late final int code;
  late final String msg;
  late final Data data;

  ShareResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.totalPage,
    required this.total,
    required this.last,
    required this.first,
    required this.shareList,
  });
  late final int totalPage;
  late final int total;
  late final bool last;
  late final bool first;
  late final List<Share> shareList;

  Data.fromJson(Map<String, dynamic> json) {
    var list = json['shareList'] as List;
    totalPage = json['totalPage'];
    total = json['total'];
    last = json['last'];
    first = json['first'];
    shareList = list.map((e) => Share.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['totalPage'] = totalPage;
    _data['total'] = total;
    _data['last'] = last;
    _data['first'] = first;
    _data['shareList'] = shareList;
    return _data;
  }
}

class Share {
  Share(
      {required this.id,
      required this.userId,
      required this.title,
      required this.createTime,
      required this.updateTime,
      required this.isOriginal,
      required this.author,
      required this.cover,
      required this.summary,
      required this.price,
      required this.downloadUrl,
      required this.buyCount,
      required this.showFlag,
      required this.auditStatus});
  late final int id;
  late final int userId;
  late final String title;
  late final String createTime;
  late final String updateTime;
  late final int isOriginal;
  late final String author;
  late final String cover;
  late final String summary;
  late final int price;
  late final String downloadUrl;
  late final int buyCount;
  late final bool showFlag;
  late final String auditStatus;

  Share.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    showFlag = json['showFlag'];
    isOriginal = json['isOriginal'];
    author = json['author'];
    cover = json['cover'];
    summary = json['summary'];
    price = json['price'];
    downloadUrl = json['downloadUrl'];
    buyCount = json['buyCount'];
    auditStatus = json['auditStatus'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['title'] = title;
    _data['createTime'] = createTime;
    _data['updateTime'] = updateTime;
    _data['showFlag'] = showFlag;
    _data['isOriginal'] = isOriginal;
    _data['author'] = author;
    _data['cover'] = cover;
    _data['summary'] = summary;
    _data['price'] = price;
    _data['downloadUrl'] = downloadUrl;
    _data['buyCount'] = buyCount;
    _data['auditStatus'] = auditStatus;
    return _data;
  }
}
