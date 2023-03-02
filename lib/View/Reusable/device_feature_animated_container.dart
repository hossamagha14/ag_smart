import 'package:flutter/material.dart';

import 'colors.dart';

class MyAnimatedContainer extends StatelessWidget {
  final double height;
  final double fontSize;
  final String title;
  final String description;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  const MyAnimatedContainer(
      {Key? key,
      required this.title,
      required this.height,
      required this.fontSize,
      required this.description,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * height,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 8,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(title),
                  ],
                ),
                InkWell(onTap: function, child: const Icon(Icons.info)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 31, 0),
              child: AnimatedDefaultTextStyle(
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black, fontSize: fontSize),
                duration: const Duration(milliseconds: 500),
                child: Text(
                  description,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
