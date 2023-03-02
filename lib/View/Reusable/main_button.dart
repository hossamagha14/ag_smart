import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonLabel;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  const MainButton({Key? key,required this.buttonLabel,required this.function }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.07,
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
            onPressed: function,
            child:  Text(
              buttonLabel,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )));
  }
}
