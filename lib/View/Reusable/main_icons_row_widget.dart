import 'package:flutter/material.dart';

import 'text_style.dart';

class MainIconsRowWidget extends StatelessWidget {
  final String icon1;
  final String? icon2;
  final String? icon3;
  final String? icon4;
  const MainIconsRowWidget(
      {Key? key, required this.icon1, this.icon2, this.icon3, this.icon4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: FittedBox(
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text(
              icon1,
              style: mainIcon,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              icon2 ?? '',
              style: mainIcon,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              icon3 ?? '',
              style: mainIcon,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              icon4 ?? '',
              style: mainIcon,
            ),
          ],
        ),
      ),
    );
  }
}
