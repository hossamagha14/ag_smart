import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_cubit.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Screens/custom_duration_by_time.dart';
import 'package:ag_smart/View/Screens/custom_duration_settings.dart';
import 'package:ag_smart/View/Screens/custom_duration_settings_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/bloc/commom_states.dart';
import 'colors.dart';

class PopUpScreen2 extends StatelessWidget {
  final int lineIndex;
  final int valveId;
  final int stationId;
  final int statusType;
  final int irrigationMethod2;
  final int flowMeter;
  final int currentMethod1;
  final int currentMethod2;
  const PopUpScreen2(
      {Key? key,
      required this.valveId,
      required this.currentMethod1,
      required this.currentMethod2,
      required this.flowMeter,
      required this.lineIndex,
      required this.stationId,
      required this.statusType,
      required this.irrigationMethod2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomFertilizationCubit, CommonStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CustomFertilizationCubit myCubit =
            CustomFertilizationCubit.get(context);
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => statusType == 3
                                      ? CustomDurationSettingsByPeriodScreen(
                                          currentMethod1: currentMethod1,
                                          currentMethod2: currentMethod2,
                                          flowMeter: flowMeter,
                                          stationId: stationId,
                                          lineIndex: lineIndex,
                                          valveId: valveId,
                                          irrigationMethod2: irrigationMethod2)
                                      : statusType == 2
                                          ? CustomDurationByTime(
                                              currentMethod1: currentMethod1,
                                              currentMethod2: currentMethod2,
                                              flowMeter: flowMeter,
                                              stationId: stationId,
                                              lineIndex: lineIndex,
                                              valveId: valveId,
                                              irrigationMethod2:
                                                  irrigationMethod2)
                                          : CustomDurationSettingsScreen(
                                              currentMethod1: currentMethod1,
                                              currentMethod2: currentMethod2,
                                              flowMeter: flowMeter,
                                              stationId: stationId,
                                              lineIndex: lineIndex,
                                              valveId: valveId)));
                        },
                        child: const Text(
                          'D',
                          style: TextStyle(
                              fontSize: 45,
                              fontFamily: 'icons',
                              color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: FittedBox(
                          child: Text(
                            text[chosenLanguage]!['Irrigation Settings']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          errorToast(context,text[chosenLanguage]![
                              'You are not subscribed for this feature']!);
                        },
                        child: SizedBox(
                          child: Text(
                            'A',
                            style: TextStyle(
                                fontSize: 45,
                                fontFamily: 'icons',
                                color: yellowColor.withOpacity(0.3)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: FittedBox(
                          child: Text(
                            text[chosenLanguage]!['Fertilization Settings']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.2)),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.065,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(settingsColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close')),
              )
            ],
          ),
        );
      },
    );
  }
}
