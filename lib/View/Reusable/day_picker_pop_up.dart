import 'package:flutter/material.dart';
import 'colors.dart';
import 'my_number_picker.dart';

class DayPickerPopUp extends StatelessWidget {
  final int lineIndex;
  final int index;
  final int value;
  final function;
  const DayPickerPopUp(
      {Key? key,
      required this.lineIndex,
      required this.index,
      required this.value,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          'Choose fertilization day',
          textAlign: TextAlign.center,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.565,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyNumberPicker(
              value: value,
              function: function,
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.065,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(settingsColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Choose')),
            )
          ],
        ),
      ),
    );
  }
}
