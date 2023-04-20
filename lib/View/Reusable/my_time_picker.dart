import 'package:flutter/material.dart';

class MyTimePicker extends StatelessWidget {
  final String time;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  const MyTimePicker({Key? key, required this.time, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (context, childWidget) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      // Using 24-Hour format
                      alwaysUse24HourFormat: true),
                  // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                  child: childWidget!);
            }).then(function);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.31,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            time,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
