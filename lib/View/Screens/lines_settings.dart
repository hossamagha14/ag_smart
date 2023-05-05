import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/lines_activation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LinesSettingsScreen extends StatelessWidget {
  final bool isEdit;
  const LinesSettingsScreen({Key? key, required this.isEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: BlocConsumer<LinesActivationCubit, LinesActivationStates>(
            listener: (context, state) {
              if (state is LinesActivationSendSuccessState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LinesActivationScreen(isEdit: isEdit),
                    ));
              } else if (state is LinesActivationSendFailState) {
                errorToast('An error has occurred');
              }
            },
            builder: (context, state) {
              LinesActivationCubit myCubit = LinesActivationCubit.get(context);
              return state is LinesActivationLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        MainCard2(
                            function: () {
                              bool allFull = true;
                              for (int i = 0; i < myCubit.valves.length; i++) {
                                if (myCubit.valves[i].diameterController.text
                                        .isEmpty ||
                                    myCubit.valves[i].numberController.text
                                        .isEmpty) {
                                  allFull = false;
                                }
                              }

                              if (allFull == true) {
                                for (int i = 0;
                                    i < myCubit.valves.length;
                                    i++) {
                                  myCubit.sendValveInfo(
                                      valveId: i + 1,
                                      valveDiameter: double.parse(myCubit
                                          .valves[i].diameterController.text),
                                      valveNumber: double.parse(myCubit
                                          .valves[i].numberController.text));
                                }
                              } else {
                                errorToast(
                                    'Please fill the data for each valve');
                              }
                            },
                            buttonColor: greenButtonColor,
                            mainWidget: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.445,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: backgroundColor),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 25, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Line ${index + 1}'),
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.165,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextFormField(
                                                    controller: myCubit
                                                        .valves[index]
                                                        .diameterController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          text[chosenLanguage]![
                                                              'Diameter']!,
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.165,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextFormField(
                                                    controller: myCubit
                                                        .valves[index]
                                                        .numberController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          text[chosenLanguage]![
                                                              'Number']!,
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    );
                                  },
                                  itemCount: myCubit.valves.length),
                            ),
                            rowWidget: Text(
                              'm',
                              style: mainIcon,
                            ),
                            cardtitle:
                                text[chosenLanguage]!['Lines\' Settings']!),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
