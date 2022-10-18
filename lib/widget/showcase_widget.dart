import 'package:flutter/material.dart';
import 'package:share_app/model/share_resp.dart';

import '../style/themes.dart';

class ShowcaseWidget extends StatelessWidget {
  final Share share;

  const ShowcaseWidget({required this.share, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 130.0,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(share.cover),
                        fit: BoxFit.fill,
                      )),
                ),
                Material(
                  color: share.isOriginal == 0
                      ? Colors.orange.shade700
                      : defaultTheme.primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      share.isOriginal == 0 ? '转载' : '原创',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
            buildInfo(context),
          ],
        ),
      );

  Widget buildInfo(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 4),
            Text(
              share.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${share.price}积分',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  width: 50.0,
                  height: 30.0,
                  child: TextButton(
                    // style: ButtonStyle(
                    //   shadowColor: MaterialStateProperty.all(Colors.grey),
                    //   side: MaterialStateProperty.all(
                    //     const BorderSide(color: Colors.grey, width: 0.6),
                    //   ),
                    // ),
                    onPressed: () {},
                    child: Text(
                      '兑换',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: defaultTheme.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      );
}
