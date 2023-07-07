import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_button.dart';
import 'package:ag_smart/View/Screens/device_setup.dart';
import 'package:flutter/material.dart';

class EditSettingsScreen extends StatelessWidget {
  final String serial;
  const EditSettingsScreen({Key? key, required this.serial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit settings'),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButton(
                      buttonLabel: 'Edit station name',
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeviceSetupScreen(
                                  serial: serial, isEdit: true),
                            ));
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  MainButton(
                      color: Colors.red,
                      buttonLabel: 'Factory reset',
                      function: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            content: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.27,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        'Are you sure you want to delete this station?',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.09,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              child: FittedBox(
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: iconColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              child: const FittedBox(
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.close)),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              )),
        ),
      ),
    );
  }
}
