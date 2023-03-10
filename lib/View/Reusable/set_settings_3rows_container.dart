import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class SetSettings3RowsContainer extends StatelessWidget {
  final String firstRowTitle;
  final Widget firstRowWidget;
  final String secondRowTitle;
  final Widget secondRowWidget;
  final String thirdRowTitle;
  final Widget thirdRowWidget;
  final bool visible;
  final function;
  const SetSettings3RowsContainer(
      {Key? key,
      required this.firstRowTitle,
      required this.firstRowWidget,
      required this.secondRowTitle,
      required this.secondRowWidget,
      required this.thirdRowTitle,
      required this.thirdRowWidget,
      required this.visible,
      required this.function
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: chosenLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: Center(
                          child: Text(
                        firstRowTitle,
                        textAlign: TextAlign.center,
                      ))),
                  firstRowWidget,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: chosenLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: Center(
                          child: Text(
                        secondRowTitle,
                        textAlign: TextAlign.center,
                      ))),
                  secondRowWidget,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: chosenLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: Center(
                          child: Text(
                        thirdRowTitle,
                        textAlign: TextAlign.center,
                      ))),
                  thirdRowWidget
                ],
              )
            ],
          ),
        ),
        Visibility(
          visible: visible,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.03,
                MediaQuery.of(context).size.width * 0.03,
                0,
                0),
            child: InkWell(
                onTap: function,
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ),
        )
      ],
    );
  }
}
