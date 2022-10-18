import 'package:flutter/material.dart';
import 'package:share_app/model/share_resp.dart';

import '../style/colors.dart';
import '../style/text_styles.dart';

class ShareDetail extends StatefulWidget {
  final Share share;

  const ShareDetail({Key? key, required this.share}) : super(key: key);

  get() {
    return share;
  }

  @override
  State<ShareDetail> createState() => _ShareDetailState();
}

class _ShareDetailState extends State<ShareDetail> {
  late Share _share;
  bool _isDui = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      print(widget.share);
      _share = widget.share;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分享详情'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _share.title,
              style: shadedTitle,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              '作者：${_share.author}     下载次数：${_share.buyCount}',
              style: sub,
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: NetworkImage(
                  _share.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              _share.summary,
              style: summary,
            ),
            const SizedBox(
              height: 10.0,
            ),
            // _isDui
            //     ?
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.grey.shade300),
                  side: MaterialStateProperty.all(
                    BorderSide(color: Colors.grey.shade300, width: 0.6),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {},
                child: const Text(
                  '复制下载地址',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
            // : Container(),
          ],
        ),
      ),
      bottomSheet: _isDui
          ? Container()
          : SafeArea(
              child: Container(
                height: 60.0,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const Text(
                      '¥积分',
                      style: summary,
                    ),
                    Text(
                      '${_share.price}',
                      style: summary.copyWith(color: linerColor4),
                    ),
                    const SizedBox(
                      width: 40.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isDui = true;
                        });
                      },
                      child: const Text('兑换'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
