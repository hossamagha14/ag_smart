import 'package:flutter/material.dart';

class MyDropDownMenu extends StatelessWidget {
  final int? value;
  final Text hint;
  final List<DropdownMenuItem<int>> items;
  final function;
  const MyDropDownMenu(
      {Key? key,
      required this.value,
      required this.items,
      required this.hint,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.31,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: DropdownButton<int>(
            elevation: 0,
            underline: const Divider(
              thickness: 0,
              color: Colors.transparent,
            ),
            hint: hint,
            value: value,
            menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
            items: items,
            borderRadius: BorderRadius.circular(10),
            dropdownColor: Colors.grey.shade200,
            onChanged: function),
      ),
    );
  }
}
