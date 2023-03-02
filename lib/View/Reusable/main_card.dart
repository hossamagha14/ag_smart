import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget mainWidget;
  final Widget rowWidget;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  final Color buttonColor;
  final String buttonTitle;
  final Widget? buttonIcon;
  final Widget? button;
  const MainCard(
      {Key? key,
      required this.mainWidget,
      required this.buttonColor,
      required this.rowWidget,
      required this.buttonTitle,
      required this.function,
      this.buttonIcon,
      this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                    child: Text(
                      'Agritopia',
                      style: TextStyle(),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 30, 0),
                      child: rowWidget)
                ],
              ),
              mainWidget,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                child: button ??ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(buttonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.zero,
                                  topRight: Radius.zero,
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))))),
                  onPressed: function,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: chosenLanguage=='ar'? TextDirection.rtl:TextDirection.ltr,
                    children: [
                      buttonIcon ?? const SizedBox(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        buttonTitle,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
