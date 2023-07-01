import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Screens/custom_duration_by_time.dart';
import 'package:ag_smart/View/Screens/custom_duration_settings.dart';
import 'package:ag_smart/View/Screens/custom_duration_settings_period.dart';
import 'package:ag_smart/View/Screens/custom_ferilization_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Screens/custom_fertlization_duration.dart';
import 'colors.dart';

class PopUpScreen extends StatelessWidget {
  final int lineIndex;
  final int valveId;
  final int stationId;
  final int statusType;
  final int ferStatusType;
  final int fertiliationType;
  final int irrigationMethod2;
  const PopUpScreen(
      {Key? key,
      required this.valveId,
      required this.lineIndex,
      required this.stationId,
      required this.statusType,
      required this.ferStatusType,
      required this.fertiliationType,
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
                                          stationId: stationId,
                                          lineIndex: lineIndex,
                                          valveId: valveId,
                                          irrigationMethod2: irrigationMethod2)
                                      : statusType == 2
                                          ? CustomDurationByTime(
                                              stationId: stationId,
                                              lineIndex: lineIndex,
                                              valveId: valveId,
                                              irrigationMethod2:
                                                  irrigationMethod2)
                                          : CustomDurationSettingsScreen(
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
                          if (ferStatusType == 1) {
                            myCubit.getNumberOfValvesandperiods(
                                serialNumber: serialNumber,
                                lineIndex: lineIndex,
                                valveId: valveId);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomFirtiliserSettingsScreen(
                                    valveId: valveId,
                                    lineIndex: lineIndex,
                                    fertiliationType: fertiliationType,
                                  ),
                                ));
                          } else if (ferStatusType == 3) {
                            errorToast(text[chosenLanguage]![
                                'You are not subscribed for this feature']!);
                          } else {
                            myCubit.getNumberOfValvesandperiods(
                                serialNumber: serialNumber,
                                lineIndex: lineIndex,
                                valveId: valveId);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomFirtilizationTypesScreen(
                                            lineIndex: lineIndex,
                                            valveId: valveId)));
                          }
                        },
                        child: SizedBox(
                          child: Text(
                            'A',
                            style: TextStyle(
                                fontSize: 45,
                                fontFamily: 'icons',
                                color: yellowColor),
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
                            style: const TextStyle(fontSize: 12),
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
