import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

class FirScarLightWidget extends StatelessWidget {
  final Color ferColor;
  final TextStyle fericon;
  final Color scarColor;
  final TextStyle scaricon;
  final Color ligColor;
  final TextStyle ligicon;
  final ferFunction;
  final scarFunction;
  final lightFunction;
  const FirScarLightWidget(
      {Key? key,
      required this.ferColor,
      required this.fericon,
      required this.scarColor,
      required this.scaricon,
      required this.ferFunction,
      required this.scarFunction,
      required this.lightFunction,
      required this.ligColor,
      required this.ligicon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: ferFunction,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    color: ferColor,
                    border: Border.all(color: Colors.blue, width: 1),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(text[chosenLanguage]!['Fertilizer']!),
                    Text(
                      'y',
                      style: fericon,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: scarFunction,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: scarColor,
                  border: Border.all(color: Colors.blue, width: 1),
                ),
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
