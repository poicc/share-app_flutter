import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:share_app/model/notices_resp.dart';
import 'package:share_app/style/iconfont.dart';
import 'package:share_app/util/sp_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/base_common.dart';
import '../model/adv_resp.dart';
import '../model/share_resp.dart';
import '../widget/showcase_widget.dart';
import '../widget/yy_marquee_widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late String _nickname = '未登录';
  late String _avatar =
      'https://images.pexels.com/photos/13538314/pexels-photo-13538314.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load';

  List<Advertise> _imgList = [];
  String _notice = '';
  List<Share> _share = [];
  final _tabs = ['发现', '使用说明'];

  _getHttp() async {
    var dio = Dio();
    final response = await dio.get('${BaseCommon.BASE_URL}advertise/all');
    final noticeResponse =
        await dio.get('${BaseCommon.BASE_URL}notices/latest');
    final shareResponse = await dio.get('${BaseCommon.BASE_URL}share/all');

    AdvResponse res = AdvResponse.fromJson(json.decode(response.toString()));
    NoticeResponse notice =
        NoticeResponse.fromJson(json.decode(noticeResponse.toString()));

    ShareResponse share =
        ShareResponse.fromJson(json.decode(shareResponse.toString()));

    print(share.data);
    setState(() {
      _imgList = res.data;
      _notice = notice.data.content;
      _share = share.data.shareList;
    });
    if (SpUtils.getString('nickname') != '') {
      setState(() {
        _nickname = (SpUtils.getString('nickname'))!;
        _avatar = (SpUtils.getString('avatar'))!;
      });
    }
  }

  Future<void> _launchUrl(url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getHttp();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(_avatar),
            ),
          ),
          title: Text(
            _nickname,
            // style: const TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          actions: [
            SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.tag,
                  ),
                  Icon(
                    Icons.search,
                  ),
                  Icon(
                    Icons.more_vert,
                  ),
                ],
              ),
            )
          ],
          bottom: _buildTabBar(),
          // backgroundColor: Colors.grey.shade100,
        ),
        body: _buildTableBarView());
  }

  TabBar _buildTabBar() {
    return TabBar(
      // isScrollable: true,
      controller: _tabController,
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      tabs: _tabs.map((e) => Tab(text: e)).toList(),
    );
  }

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: _tabs
          .map(
            (e) => ListView(
              children: [
                SizedBox(
                  height: 200.0,
                  child: Swiper(
                    containerHeight: 100.0,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        _imgList[index].cover,
                        fit: BoxFit.cover,
                      );
                    },
                    onTap: (index) {
                      _launchUrl(_imgList[index].url);
                    },
                    itemCount: _imgList.length,
                    pagination: const SwiperPagination(), //如果不填则不显示指示点
                    // control: SwiperControl(), //如果不填则不显示左右按钮
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  // width: no,
                  height: 32,
                  child: Row(
                    children: [
                      const Icon(IconFont.icon_gonggao),
                      buildMarqueeWidget(),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30.0,
                      crossAxisSpacing: 10.0,
                    ),
                    shrinkWrap: true,
                    itemCount: _share.length,
                    itemBuilder: (BuildContext context, int index) => Wrap(
                      children: [
                        ShowcaseWidget(share: _share[index]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList());

  Widget buildMarqueeWidget() {
    ///上下轮播 安全提示
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: YYMarquee(
          stepOffset: 200.0,
          duration: const Duration(seconds: 3),
          paddingLeft: 180.0,
          children: [
            Text(
              _notice,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
