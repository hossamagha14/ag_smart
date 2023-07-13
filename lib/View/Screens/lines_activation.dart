import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/Repo/auth_bloc.dart';
import '../Reusable/main_card02.dart';
import '../Reusable/toasts.dart';
import 'lines_settings.dart';

class LinesActivationScreen extends StatefulWidget {
  final bool isEdit;
  const LinesActivationScreen({Key? key, required this.isEdit})
      : super(key: key);

  @override
  State<LinesActivationScreen> createState() => _LinesActivationScreenState();
}

class _LinesActivationScreenState extends State<LinesActivationScreen> {
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
      body: BlocProvider(
        create: (context) => LinesActivationCubit(authBloc)
          ..getNumberOfValves(isEdit: widget.isEdit),
        child: BlocConsumer<LinesActivationCubit, CommonStates>(
          listener: (context, state) {
            if (state is LinesActivationSendSuccessState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LinesSettingsScreen(isEdit: widget.isEdit),
                  ));
            }
          },
          builder: (context, state) {
            LinesActivationCubit myCubit = LinesActivationCubit.get(context);
            return state is LinesActivationLoadingState
                ? const Center(child: CircularProgressIndicator())
                : BlocListener<AuthBloc, CommonStates>(
                    listener: (context, state) {
                      if (state is ExpiredTokenState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                            (route) => false);
                        expiredTokenToast(context);
                      }
                      if (state is ServerDownState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                            (route) => false);
                        serverDownToast(context);
                      }
                    },
                    child: Column(
                      children: [
                        MainCard2(
                            function: () {
                              myCubit.toBinary(myCubit.valves.length);
                              myCubit.numberOfActivelines();
                              myCubit.putIrrigationType(
                                  activeValves: binaryValves);
                            },
                            buttonColor: greenButtonColor,
                            mainWidget: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.48,
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        decoration: BoxDecoration(
                                            color: backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Transform.scale(
                                              scale: 0.8,
                                              child: CupertinoSwitch(
                                                value: myCubit
                                                    .valves[index].isActive,
                                                onChanged: (value) {
                                                  myCubit.activateLine(index);
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              '${text[chosenLanguage]!['line']!} ${index + 1}',
                                              textDirection:
                                                  chosenLanguage == 'ar'
                                                      ? TextDirection.rtl
                                                      : TextDirection.ltr,
                                            )
                                          ],
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
                                    itemCount: myCubit.valves.length)),
                            rowWidget: Text(
                              'm',
                              style: mainIcon,
                            ),
                            cardtitle:
                                text[chosenLanguage]!['Lines Activation']!),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
