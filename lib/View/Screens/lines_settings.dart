import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/irrigation_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/Repo/auth_bloc.dart';

// ignore: must_be_immutable
class LinesSettingsScreen extends StatefulWidget {
  final bool isEdit;
  const LinesSettingsScreen({Key? key, required this.isEdit}) : super(key: key);

  @override
  State<LinesSettingsScreen> createState() => _LinesSettingsScreenState();
}

class _LinesSettingsScreenState extends State<LinesSettingsScreen> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

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
          child: BlocProvider(
            create: (context) => LinesActivationCubit(authBloc)
              ..getNumberOfValves(isEdit: widget.isEdit),
            child: BlocConsumer<LinesActivationCubit, CommonStates>(
              listener: (context, state) {
                if (state is LinesActivationSendSuccessState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            IrrigationTypeScreen(isEdit: widget.isEdit),
                      ));
                } else if (state is LinesActivationSendFailState) {
                  errorToast('An error has occurred');
                }
              },
              builder: (context, state) {
                LinesActivationCubit myCubit =
                    LinesActivationCubit.get(context);
                return state is LinesActivationLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          MainCard2(
                              function: () {
                                FocusScope.of(context).unfocus();
                                for (int i = 0;
                                    i < myCubit.valves.length;
                                    i++) {
                                  if (myCubit.valves[i].diameterController.text
                                          .isEmpty ||
                                      myCubit.valves[i].numberController.text
                                          .isEmpty) {
                                    myCubit.valves[i].diameterController.text =
                                        '0';
                                    myCubit.valves[i].numberController.text =
                                        '0';
                                  }
                                }
                                myCubit.sendValveInfo();
                              },
                              buttonColor: greenButtonColor,
                              mainWidget: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.445,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return myCubit.valves[index].isActive ==
                                              true
                                          ? Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: backgroundColor),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 25, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Line ${index + 1}'),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.165,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: TextFormField(
                                                            controller: myCubit
                                                                .valves[index]
                                                                .diameterController,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            textAlign: TextAlign
                                                                .center,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: text[
                                                                      chosenLanguage]![
                                                                  'Diameter']!,
                                                              hintStyle: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 40,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.165,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: TextFormField(
                                                            controller: myCubit
                                                                .valves[index]
                                                                .numberController,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            textAlign: TextAlign
                                                                .center,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: text[
                                                                      chosenLanguage]![
                                                                  'Number']!,
                                                              hintStyle: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const SizedBox(
                                              width: 0,
                                              height: 0,
                                            );
                                    },
                                    separatorBuilder: (context, index) {
                                      return myCubit.valves[index].isActive ==
                                              true
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            )
                                          : const SizedBox(
                                              height: 0,
                                              width: 0,
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
      ),
    );
  }
}
