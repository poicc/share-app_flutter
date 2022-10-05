import 'package:flutter/material.dart';
import 'package:share_app/util/config.dart';
import 'package:share_app/util/sp_utils.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late String nickname = '未登录';
  late String avatar =
      'https://images.pexels.com/photos/13538314/pexels-photo-13538314.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load';

  List<String> imgList = [];
  final tabs = ['发现', '使用说明'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _getHttp() async {
    // var dio = Dio();
    // final response =
    //     await dio.get('http://139.196.153.80:8083/advertisement/all');
    // // print(response.toString());
    // AdvResponse res = AdvResponse.fromJson(json.decode(response.toString()));
    // print(res.data);
    await SpUtils.getInstance();
    if (SpUtils.getString('nickname') != '') {
      setState(() {
        // res.data.forEach((item) {
        //   print(item['cover']);
        //   imgList.add(item['cover']);
        // });
        nickname = (SpUtils.getString('nickname'))!;
        avatar = (SpUtils.getString('avatar'))!;
      });
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
          .map((e) => Center(
                  child: Text(
                e,
                style:
                    const TextStyle(color: Config.primaryColor, fontSize: 20),
              )))
          .toList());
}
