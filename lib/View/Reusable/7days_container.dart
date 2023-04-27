import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

class SevenDaysContainer extends StatelessWidget {
  const SevenDaysContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.blue)),
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '7',
                    style: TextStyle(
                        color: iconColor,
                        fontSize: 35,
                        fontWeight: FontWeight.w700)),
                TextSpan(
                    text: ' Days',
                    style: TextStyle(
                        color: iconColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w500))
              ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('d.MMMM.y').format(DateTime.now()),
                  style: TextStyle(
                      color: iconColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                    DateFormat('d.MMMM.y').format(
                        DateTime.now().subtract(const Duration(days: 6))),
                    style: TextStyle(
                        color: iconColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
