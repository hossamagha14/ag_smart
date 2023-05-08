import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Scarcrow/Scarcrow_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Scarcrow/scarcrow_states.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_states.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/fertiliser_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirScarLightWidget extends StatelessWidget {
  final Color ferColor;
  final TextStyle fericon;
  final Color scarColor;
  final TextStyle scaricon;
  final Color ligColor;
  final TextStyle ligicon;
  const FirScarLightWidget(
      {Key? key,
      required this.ferColor,
      required this.fericon,
      required this.scarColor,
      required this.scaricon,
      required this.ligColor,
      required this.ligicon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        children: [
          BlocConsumer<FirtiliserSettingsCubit, FirtiliserSettingsStates>(
            listener: (context, state) {
              if (state is FirtiliserLoadingState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FirtiliserSettingsScreen(),
                    ));
              }
            },
            builder: (context, state) {
              FirtiliserSettingsCubit myCubit =
                  FirtiliserSettingsCubit.get(context);
              return Expanded(
                child: InkWell(
                  onTap: () {
                    myCubit.getFertilizationFeatures(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: ferColor,
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(text[chosenLanguage]!['Fertilizer']!),
                        Text(
                          'y',
                          style: fericon,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          BlocConsumer<ScarecrowCubit, ScarecrowStates>(
            listener: (context, state) {},
            builder: (context, state) {
              ScarecrowCubit myCubit = ScarecrowCubit.get(context);
              return Expanded(
                child: InkWell(
                  onTap: () {
                    myCubit.getFeatures(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: scarColor,
                      border: Border.all(color: Colors.blue, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(text[chosenLanguage]!['Scarecrow']!),
                        Text(
                          'z',
                          style: scaricon,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          BlocConsumer<LightCubit, LightStates>(
            listener: (context, state) {},
            builder: (context, state) {
              LightCubit myCubit = LightCubit.get(context);
              return Expanded(
                child: InkWell(
                  onTap: () {
                    myCubit.getFeatures(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: ligColor,
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(text[chosenLanguage]!['Light']!),
                        Text(
                          'k',
                          style: ligicon,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
