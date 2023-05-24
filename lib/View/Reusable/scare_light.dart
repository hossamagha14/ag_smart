import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

class ScarLightWidget extends StatelessWidget {
  final Color scarColor;
  final TextStyle scaricon;
  final Color ligColor;
  final TextStyle ligicon;
  final scarFunction;
  final lightFunction;
  const ScarLightWidget(
      {Key? key,
      required this.scarColor,
      required this.scaricon,
      required this.ligicon,
      required this.scarFunction,
      required this.lightFunction,
      required this.ligColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: scarFunction,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    color: scarColor,
                    border: Border.all(color: Colors.blue, width: 1),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(text[chosenLanguage]!['Scarecrow']!),
                    Text(
                      'z',
                      style: scaricon,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: lightFunction,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    color: ligColor,
                    border: Border.all(color: Colors.blue, width: 1),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(text[chosenLanguage]!['Light']!),
                    Text(
                      'k',
                      style: ligicon,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
