import 'package:flutter/material.dart';

class MyDatePicker extends StatelessWidget {
  final String date;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  const MyDatePicker({Key? key,required this.date,required this.function   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime(2025),
                context: context,
                initialDate: DateTime.now())
            .then(function);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.31,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            date,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
