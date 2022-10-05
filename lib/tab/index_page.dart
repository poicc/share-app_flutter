import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:share_app/util/sp_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/base_common.dart';
import '../model/adv_resp.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late String nickname = '未登录';
  late String avatar =
      'https://images.pexels.com/photos/13538314/pexels-photo-13538314.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load';

  List<Advertise> imgList = [];
  final tabs = ['发现', '使用说明'];

  _getHttp() async {
    var dio = Dio();
    final response = await dio.get('${BaseCommon.BASE_URL}advertise/all');
    AdvResponse res = AdvResponse.fromJson(json.decode(response.toString()));
    print(res.data);
    setState(() {
      imgList = res.data;
    });
    if (SpUtils.getString('nickname') != '') {
      setState(() {
        nickname = (SpUtils.getString('nickname'))!;
        avatar = (SpUtils.getString('avatar'))!;
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
    _tabController = TabController(vsync: this, length: tabs.length);
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
              backgroundImage: NetworkImage(avatar),
            ),
          ),
          title: Text(
            nickname,
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
        body: _buildTableBarView()
        // Column(
        //   children: [
        //     Container(
        //       child: _buildTabBar(),
        //     ),
        // Stack(
        //   children: [
        // Center(
        //   child: CarouselSlider(
        //     options: CarouselOptions(
        //       height: 200.0,
        //       autoPlay: true,
        //       autoPlayInterval: const Duration(seconds: 3),
        //       autoPlayAnimationDuration: const Duration(milliseconds: 800),
        //       autoPlayCurve: Curves.fastOutSlowIn,
        //       enlargeCenterPage: true,
        //     ),
        //     items: imgList.map((i) {
        //       return Builder(
        //         builder: (BuildContext context) {
        //           return Container(
        //             width: MediaQuery.of(context).size.width,
        //             margin: const EdgeInsets.symmetric(horizontal: 5.0),
        //             decoration: BoxDecoration(
        //               image: DecorationImage(
        //                 image: NetworkImage(i),
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     }).toList(),
        //   ),
        // ),
        //   ],
        // ),
        //   ],
        // ),
        );
  }

  TabBar _buildTabBar() {
    return TabBar(
      // isScrollable: true,
      controller: _tabController,
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      tabs: tabs.map((e) => Tab(text: e)).toList(),
    );
  }

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs
          .map(
            (e) => Container(
              height: 200.0,
              child: Swiper(
                containerHeight: 100.0,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    imgList[index].cover,
                    fit: BoxFit.cover,
                  );
                },
                onTap: (index) {
                  _launchUrl(imgList[index].url);
                },
                itemCount: imgList.length,
                pagination: const SwiperPagination(), //如果不填则不显示指示点
                // control: SwiperControl(), //如果不填则不显示左右按钮
              ),
            ),
          )
          .toList());
}
