import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoScreen extends StatelessWidget {
  const AutoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Station info']!),
      ),
      body: SafeArea(
          child: Column(
        children: [
          MainCard2(
              mainWidget: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                child: BlocConsumer<LinesActivationCubit,
                        LinesActivationStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      LinesActivationCubit activationCubit =
                          LinesActivationCubit.get(context);
                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Visibility(
                              visible: activationCubit.valves[index].isActive,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Line ${index + 1}'),
                                      const Spacer()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Visibility(
                              visible: activationCubit.valves[index].isActive,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                            );
                          },
                          itemCount: activationCubit.valves.length);
                    }),
              ),
              rowWidget: const MainIconsRowWidget(
                icon1: 'm',
                icon2: 'e',
              ),
              function: () {},
              buttonTitle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: chosenLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  const Text(
                    'q',
                    style: TextStyle(fontFamily: 'icons', fontSize: 25),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(text[chosenLanguage]!['Settings']!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
              cardtitle: text[chosenLanguage]!['Auto duration']!,
              buttonColor: settingsColor),
        ],
      )),
    );
  }
}
