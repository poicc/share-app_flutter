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
                share.isOriginal == 0
                    ? Material(
                        color: defaultTheme.primaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            '原创',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      )
                    : Container()
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${share.price}积分',
                  style: Theme.of(context).textTheme.caption,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '兑换',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: defaultTheme.primaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
