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
            )
          ],
        ),
      ),
      bottomSheet: SafeArea(
        child: Container(
          height: 60.0,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
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
                onPressed: () {},
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
