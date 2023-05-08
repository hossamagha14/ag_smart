import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

class MainCard2 extends StatelessWidget {
  final Widget mainWidget;
  final Widget rowWidget;
  final String cardtitle;
  final Color buttonColor;
  final Widget? button;
  final Widget? editButton;
  final Widget? buttonTitle;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  const MainCard2(
      {Key? key,
      required this.mainWidget,
      this.button,
      required this.rowWidget,
      required this.function,
      required this.cardtitle,
      required this.buttonColor,
      this.editButton,
      this.buttonTitle})
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
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 25, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(stationName), rowWidget],
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.blue),
                            borderRadius: BorderRadius.circular(7)),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Center(
                            child: Text(
                          cardtitle,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                      editButton ?? const SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  mainWidget,
                ],
              ),
              button ??
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(buttonColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.zero,
                                          topRight: Radius.zero,
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))))),
                          onPressed: function,
                          child: buttonTitle ??
                              const Text(
                                'Next',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )))
            ],
          ),
        ),
      ),
    );
  }
}
