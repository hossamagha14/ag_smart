import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

class IrrigationTypeContainer extends StatelessWidget {
  final Widget icon;
  final String irrigationType;
  final Widget? widget;
  final Color color;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  const IrrigationTypeContainer(
      {Key? key,
      required this.icon,
      required this.function,
      required this.irrigationType,
      required this.color,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
      child: InkWell(
        onTap: function,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Row(
            textDirection:
                chosenLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: icon,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(irrigationType),
              const Spacer(),
              widget ?? const Spacer(),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
