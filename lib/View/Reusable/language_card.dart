// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  final Color color;
  final String language;
  final String imageLanguage;
  final function;
  const LanguageCard(
      {Key? key,
      required this.color,
      required this.language,
      required this.imageLanguage,
      required this.function
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.18,
        child: Card(
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/$imageLanguage.png')),
              Text(
                language,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
